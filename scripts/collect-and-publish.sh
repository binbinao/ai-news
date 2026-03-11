#!/bin/bash
# AI News Daily Collector and Publisher
# 每日自动收集 AI 新闻并发布到 GitHub Pages

set -e

REPO_DIR="/tmp/ai-news"
NEWS_DIR="$REPO_DIR/news"
DATE=$(date +%Y-%m-%d)
JSON_FILE="$NEWS_DIR/$DATE.json"

echo "🤖 AI News Collector - $(date)"

# 创建目录
mkdir -p $NEWS_DIR

# 这里需要调用 nanobot 来执行实际的新闻收集
# 由于 cron 环境限制，我们使用 nanobot 的 CLI 模式
cd $REPO_DIR

# 检查是否有新内容
if [ -f "$JSON_FILE" ]; then
    echo "今日新闻已存在: $JSON_FILE"
else
    echo "等待 nanobot 生成新闻内容..."
fi

# 提交到 GitHub
git add -A
git diff --cached --quiet || {
    git commit -m "docs: update AI news for $DATE"
    git push origin main
    echo "✅ 已发布到 GitHub Pages"
}

echo "完成: $(date)"