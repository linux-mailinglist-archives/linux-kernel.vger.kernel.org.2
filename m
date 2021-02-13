Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE91931AB4B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBMMXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBMMXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:23:30 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC7FC061756;
        Sat, 13 Feb 2021 04:22:50 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o21so1387068pgn.12;
        Sat, 13 Feb 2021 04:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4G3vbL+lG3HUDiks1656Ig0pPQs9KSgtWGIkzQnDuLs=;
        b=gvuVBjNmUjeSSsaMcfRVTouOjshltyyQwor5tQEvu39Jy3ksK8MplxJFc1DUg9MQ4t
         SpZJYeatJ2f9MdEfADAM5cGj5XUDhLARLu6AUY5JGOyydcRMdKhriuVVJo4cEO82tTCH
         XdgJyFd7ITI8baqb8hNLWKr2vXoTvvYaKqRUfGdqhaGZ8A3l8sxHlWW/TOMUchnMH5GR
         oILAnT+hOUyK0DaqW9KukJK7R7H8J0w0ocZNA10BoSmasg9XZhuq7zf6/BTV8CjDKa0N
         b2VlC1woSGwcBOtjHtPQXdVCX4FgHWZOVbOL6sqXzVh4j5h84pXqmjZ4NY2Ghx0tr1Bu
         elgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4G3vbL+lG3HUDiks1656Ig0pPQs9KSgtWGIkzQnDuLs=;
        b=HNt0VT2vKaK8zT4KjwEyTeomK6ICpLKM313T9/L0cxteEzwhSGDe4JpZrCN7F/FvWN
         Ru3PSjwZ7sJOwdpY8XyD5GOYPdvz/sWQBI8T8IYISMeILDfgrjcsS+9k67UOji8X8ydC
         UcRFviixr+app4wP6r9VJDt81Q1ltSvlEqysYJgK5SSoT4c5hbZhKdUM76DOs9L2/tfJ
         ozolmuCLrjEEE6kVJI7nOQ27mta/9LcfmJ9mASJRulDCwzryzOFTl+uyf6vu24blt87M
         Z7XAIfXCbeH4RI71lGrlYzKbL/ZJHlUup/EtD88BNe3Wm1MUwpUAdNakOzjFeA54yuM/
         FWvg==
X-Gm-Message-State: AOAM533KzO9HPscrCEm13hdieQBeCTlaZtI4uxw6XoNRnFeIwW/0IHkf
        3zNGu7om4TbDRSjPTxbbEMZBOUWp4u/r/Q==
X-Google-Smtp-Source: ABdhPJynWS7ETL+7Z35H5/pngMKWUm/8QNm5dtCEeeuRFsCI0x/Sui3j89HWlItYpG5GWBQMeK2pPw==
X-Received: by 2002:a62:16cb:0:b029:1da:358c:4338 with SMTP id 194-20020a6216cb0000b02901da358c4338mr7121473pfw.36.1613218969976;
        Sat, 13 Feb 2021 04:22:49 -0800 (PST)
Received: from localhost (li1438-199.members.linode.com. [45.33.111.199])
        by smtp.gmail.com with ESMTPSA id v1sm13799435pfi.99.2021.02.13.04.22.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Feb 2021 04:22:49 -0800 (PST)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haidong Yao <yaohaidong369@gmail.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH v2 1/3] mailbox: sprd: Introduce refcnt when clients requests/free channels
Date:   Sat, 13 Feb 2021 20:21:41 +0800
Message-Id: <20210213122143.19240-2-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210213122143.19240-1-orsonzhai@gmail.com>
References: <20210213122143.19240-1-orsonzhai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

Unisoc mailbox has no way to be enabled/disabled for any single channel.
They can only be set to startup or shutdown as a whole device at same time.

Add a variable to count references to avoid mailbox FIFO being reset
unexpectedly when clients are requesting or freeing channels.

Also add a lock to dismiss possible conflicts from register r/w in
different startup or shutdown threads. And fix the crash problem when early
interrupts come from channel which has not been requested by client yet.

Fixes: ca27fc26cd22 ("mailbox: sprd: Add Spreadtrum mailbox driver")
Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 drivers/mailbox/sprd-mailbox.c | 43 +++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index f6fab24ae8a9..920de7b9dce1 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -60,6 +60,8 @@ struct sprd_mbox_priv {
 	struct clk		*clk;
 	u32			outbox_fifo_depth;
 
+	struct mutex		lock;
+	u32			refcnt;
 	struct mbox_chan	chan[SPRD_MBOX_CHAN_MAX];
 };
 
@@ -115,7 +117,11 @@ static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
 		id = readl(priv->outbox_base + SPRD_MBOX_ID);
 
 		chan = &priv->chan[id];
-		mbox_chan_received_data(chan, (void *)msg);
+		if (chan->cl)
+			mbox_chan_received_data(chan, (void *)msg);
+		else
+			dev_warn_ratelimited(priv->dev,
+				    "message's been dropped at ch[%d]\n", id);
 
 		/* Trigger to update outbox FIFO pointer */
 		writel(0x1, priv->outbox_base + SPRD_MBOX_TRIGGER);
@@ -215,18 +221,22 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
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
@@ -235,9 +245,13 @@ static void sprd_mbox_shutdown(struct mbox_chan *chan)
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
@@ -266,6 +280,7 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = dev;
+	mutex_init(&priv->lock);
 
 	/*
 	 * The Spreadtrum mailbox uses an inbox to send messages to the target
-- 
2.17.1

