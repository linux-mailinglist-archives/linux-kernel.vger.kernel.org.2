Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6F3131EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhBHMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhBHLwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:52:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C14C06174A;
        Mon,  8 Feb 2021 03:52:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 18so7415121pfz.3;
        Mon, 08 Feb 2021 03:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LfB7ydJjgNU6qdDbdeb61u1uczQgf3qmcl9sbfbMLTw=;
        b=MDKZtz8SgocSr4SOIJfB/BuBwfQNX+yKBUQHzKIH820YxZIfw4/k4N6e9sePUmkpEV
         slyVXhcajaz8SG8pfj61dGT7lPhBk0rigFwpOQj1h19c8jwN5IKV5/2euUO6WcWv6UvS
         qtnTo+ouGZAVCu6YABj6Vu3fbUnclja4EEQ/PknHrH8bDx/wvanRU6fejESTRl7isVM8
         tDQvEGCf9WuTPJD30fhaIusQ+eyW1CD+G9iRRi7T01SdiB6aVeIwURD8A2klRf/QohKQ
         V/ijd1FU5wWA0vna+qRg+XC7rx03+ztsRgj6sa3N64EOqA0WQsHiTBDb0PSi08rhY+oY
         L3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LfB7ydJjgNU6qdDbdeb61u1uczQgf3qmcl9sbfbMLTw=;
        b=eBFErr1JS8yBL5HEyHwqpAmaY3oHYtU90PjoSBXVWp+VVT0BJyxhzDABtfPcNDskz4
         7NIG+2A8fiEfw8aIEmTebiQe2El+B2oaoYywuZTPJYmH67pwAj6dMBYoLdyQEFNntrez
         7+Ckf15PobWZOiSLo1N/0cmEvHSUSzwH/NUm+w5LFx4ErqFNd2Mi6C2gh7cyBtHTextT
         jBjge9EHYJRtGIZNd+s413GZ32Npav/NFpYSGdwAkv5aTwgPxO/qnzRr72Ub2ZKCWo+L
         k54cmGTDimYbq3h/Z3zoj8SvbGM/T3uyxtViV0YsZ4FbFQuJ7xfxytmN9AJrGzi5S2if
         x20g==
X-Gm-Message-State: AOAM530merGo3hdXSWAKVXx9gsh4OdA0gxxwXyCv2Bc5nrTmV+YBEGzp
        6HFQTlJqjHWsa2pxm9kTTB4z5Zzs2jWjGA==
X-Google-Smtp-Source: ABdhPJwzg5PkZvis7+lR6gJTvSlytbzD8TGuD0sKsFUC9kEY+SFLp2zMTnJur5uiF2I629pXzOIEjg==
X-Received: by 2002:a63:d257:: with SMTP id t23mr8645306pgi.290.1612785120501;
        Mon, 08 Feb 2021 03:52:00 -0800 (PST)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a9sm12875564pfr.204.2021.02.08.03.51.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:51:59 -0800 (PST)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, haidong.yao@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 1/3] mailbox: sprd: Introduce refcnt when clients requests/free channels
Date:   Mon,  8 Feb 2021 19:51:02 +0800
Message-Id: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

Unisoc mailbox has no way to be enabled/disabled for any single channel.
They can only be set to startup or shutdown as a whole device at same time.

Add a variable to count references to avoid mailbox FIFO being reset
unexpectedly when clients are requesting or freeing channels.

Also add a lock to dismiss possible conflicts from register r/w in
different startup or shutdown threads.

Fixes: ca27fc26cd22 ("mailbox: sprd: Add Spreadtrum mailbox driver")
Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 drivers/mailbox/sprd-mailbox.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index f6fab24..e606f52 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -60,6 +60,8 @@ struct sprd_mbox_priv {
 	struct clk		*clk;
 	u32			outbox_fifo_depth;
 
+	struct mutex		lock;
+	u32			refcnt;
 	struct mbox_chan	chan[SPRD_MBOX_CHAN_MAX];
 };
 
@@ -215,18 +217,22 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
 	struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
 	u32 val;
 
-	/* Select outbox FIFO mode and reset the outbox FIFO status */
-	writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
+	mutex_lock(&priv->lock);
+	if (priv->refcnt++ == 0) {
+		/* Select outbox FIFO mode and reset the outbox FIFO status */
+		writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
 
-	/* Enable inbox FIFO overflow and delivery interrupt */
-	val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
-	val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
-	writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
+		/* Enable inbox FIFO overflow and delivery interrupt */
+		val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
+		val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
+		writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
 
-	/* Enable outbox FIFO not empty interrupt */
-	val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
-	val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
-	writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+		/* Enable outbox FIFO not empty interrupt */
+		val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+		val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
+		writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+	}
+	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -235,9 +241,13 @@ static void sprd_mbox_shutdown(struct mbox_chan *chan)
 {
 	struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
 
-	/* Disable inbox & outbox interrupt */
-	writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
-	writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+	mutex_lock(&priv->lock);
+	if (--priv->refcnt == 0) {
+		/* Disable inbox & outbox interrupt */
+		writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
+		writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+	}
+	mutex_unlock(&priv->lock);
 }
 
 static const struct mbox_chan_ops sprd_mbox_ops = {
@@ -266,6 +276,8 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = dev;
+	priv->refcnt = 0;
+	mutex_init(&priv->lock);
 
 	/*
 	 * The Spreadtrum mailbox uses an inbox to send messages to the target
-- 
2.7.4

