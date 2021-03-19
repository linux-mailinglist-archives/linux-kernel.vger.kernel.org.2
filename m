Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0780734154C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 07:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhCSGRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhCSGQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:16:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367DEC06174A;
        Thu, 18 Mar 2021 23:16:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so6221701pjc.2;
        Thu, 18 Mar 2021 23:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ET4qTdYaBwjetl/xihvy8ecj1oVjERGNlH8HadTByNY=;
        b=mB4jQJ7kvh3MnYEl3p/uKGOdYOukXeu21vIAIG4KqQxOXSntr7UtJ3qfRcnAx3oCQ3
         FMtBbEiPZ739OSpPJuUoYJIAnH6zf0V1i3wr8hknj85Z7ELB5us6lGoJ65s5AytWVGTd
         cgTs+MwIsnacapLTLyVZ7IPl1FdMMDw76s0ryD/ZyggqDpBFcxSTCk2JAI+KE+KqaAre
         ZXtPisYNWtiZ0epTSlO8XANsjOz+eQwfPQOF6DkS+oHBVdRiuQ+wSDV13vIoklS84IZK
         pjlMsazUKRbC479Y672JvXcAJaxGOh8nL9MU0AESINcqznXXqeMXfSSSyQZsRrOrGhml
         tMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ET4qTdYaBwjetl/xihvy8ecj1oVjERGNlH8HadTByNY=;
        b=gldekfO404wSNeS2JEcRSBb57YHRrIt1qS8axy7lO6oGmUiGwAX3baCmR5xb4b7kgu
         5m9jIG0VS730ym6dG+dY9E19ojGnb5yTh4DGdUqEyyD1eR9BgaZV+0HSKSSjzBqSfK9E
         2it943zccer6z26VAuRUxLoCWpYr4QG+wAmcazYBAdxTrdJp9mZ4K2AuB3TdZv8lBvvW
         GKSmPaN0n4GZf72bysqWw6KrcgnMyGbJdjAMZ8txJUz0OMkoPYtiJvHSzRQbSIhu+HXS
         1AyF1tKNtMR56r3FdCE2LXbNtkUaP9GPfArZ0BjDi1DK/IEmtqnIWXhHiyx9amtYiz86
         ljJA==
X-Gm-Message-State: AOAM533PpJfZsY3qJ0c8QvsScW/P54HGmiExRDQX4iI44lILnCa8SNbd
        9N9lgfPKsp8lRaFo54UxuXg=
X-Google-Smtp-Source: ABdhPJygfHoXhb5Cpnrqr9qMOZyAr+f8VD75jLE6Kqn0vDdvvBbMwLxOKt81brv8DnnGYXocMyOkZA==
X-Received: by 2002:a17:90a:f40f:: with SMTP id ch15mr8340180pjb.128.1616134604812;
        Thu, 18 Mar 2021 23:16:44 -0700 (PDT)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o1sm4223103pjp.4.2021.03.18.23.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 23:16:44 -0700 (PDT)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, haidong.yao@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH v3 3/3] mailbox: sprd: Add supplementary inbox support
Date:   Fri, 19 Mar 2021 14:15:37 +0800
Message-Id: <1616134537-27966-4-git-send-email-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616134537-27966-1-git-send-email-orsonzhai@gmail.com>
References: <1616134537-27966-1-git-send-email-orsonzhai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

Some sensors connected to Unisoc mailbox will send data very frequently.
This makes channel 0 very busy and the messages from other remote cores
not able to be handled as soon as possible.

It's a trick (un-documented) from Unisoc ASIC designers to resolve this
special requirement that an inbox assigned to one of the remote cores
before was modified to be exposed to host cpu core.

Then from host side, a supplementary inbox is added for transferring mass
but not emergency messages from the remote cores, such as step counting
sensor, with an independent FIFO and interrupt which is as same as channel
0. Meanwihle, inbox part of this channel is still kept for original remote
core to use.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mailbox/sprd-mailbox.c | 88 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index 94d9067d..0a1449d 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 
@@ -50,13 +51,17 @@
 #define SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ		BIT(0)
 #define SPRD_OUTBOX_FIFO_IRQ_MASK		GENMASK(4, 0)
 
+#define SPRD_OUTBOX_BASE_SPAN			0x1000
 #define SPRD_MBOX_CHAN_MAX			8
+#define SPRD_SUPP_INBOX_ID_SC9863A		7
 
 struct sprd_mbox_priv {
 	struct mbox_controller	mbox;
 	struct device		*dev;
 	void __iomem		*inbox_base;
 	void __iomem		*outbox_base;
+	/*  Base register address for supplementary outbox */
+	void __iomem		*supp_base;
 	struct clk		*clk;
 	u32			outbox_fifo_depth;
 
@@ -96,14 +101,13 @@ static u32 sprd_mbox_get_fifo_len(struct sprd_mbox_priv *priv, u32 fifo_sts)
 	return fifo_len;
 }
 
-static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
+static irqreturn_t do_outbox_isr(void __iomem *base, struct sprd_mbox_priv *priv)
 {
-	struct sprd_mbox_priv *priv = data;
 	struct mbox_chan *chan;
 	u32 fifo_sts, fifo_len, msg[2];
 	int i, id;
 
-	fifo_sts = readl(priv->outbox_base + SPRD_MBOX_FIFO_STS);
+	fifo_sts = readl(base + SPRD_MBOX_FIFO_STS);
 
 	fifo_len = sprd_mbox_get_fifo_len(priv, fifo_sts);
 	if (!fifo_len) {
@@ -112,9 +116,9 @@ static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
 	}
 
 	for (i = 0; i < fifo_len; i++) {
-		msg[0] = readl(priv->outbox_base + SPRD_MBOX_MSG_LOW);
-		msg[1] = readl(priv->outbox_base + SPRD_MBOX_MSG_HIGH);
-		id = readl(priv->outbox_base + SPRD_MBOX_ID);
+		msg[0] = readl(base + SPRD_MBOX_MSG_LOW);
+		msg[1] = readl(base + SPRD_MBOX_MSG_HIGH);
+		id = readl(base + SPRD_MBOX_ID);
 
 		chan = &priv->chan[id];
 		if (chan->cl)
@@ -124,15 +128,29 @@ static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
 				    "message's been dropped at ch[%d]\n", id);
 
 		/* Trigger to update outbox FIFO pointer */
-		writel(0x1, priv->outbox_base + SPRD_MBOX_TRIGGER);
+		writel(0x1, base + SPRD_MBOX_TRIGGER);
 	}
 
 	/* Clear irq status after reading all message. */
-	writel(SPRD_MBOX_IRQ_CLR, priv->outbox_base + SPRD_MBOX_IRQ_STS);
+	writel(SPRD_MBOX_IRQ_CLR, base + SPRD_MBOX_IRQ_STS);
 
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
+{
+	struct sprd_mbox_priv *priv = data;
+
+	return do_outbox_isr(priv->outbox_base, priv);
+}
+
+static irqreturn_t sprd_mbox_supp_isr(int irq, void *data)
+{
+	struct sprd_mbox_priv *priv = data;
+
+	return do_outbox_isr(priv->supp_base, priv);
+}
+
 static irqreturn_t sprd_mbox_inbox_isr(int irq, void *data)
 {
 	struct sprd_mbox_priv *priv = data;
@@ -235,6 +253,14 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
 		val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
 		val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
 		writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+
+		/* Enable supplementary outbox as the fundamental one */
+		if (priv->supp_base) {
+			writel(0x0, priv->supp_base + SPRD_MBOX_FIFO_RST);
+			val = readl(priv->supp_base + SPRD_MBOX_IRQ_MSK);
+			val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
+			writel(val, priv->supp_base + SPRD_MBOX_IRQ_MSK);
+		}
 	}
 	mutex_unlock(&priv->lock);
 
@@ -250,6 +276,10 @@ static void sprd_mbox_shutdown(struct mbox_chan *chan)
 		/* Disable inbox & outbox interrupt */
 		writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
 		writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+
+		if (priv->supp_base)
+			writel(SPRD_OUTBOX_FIFO_IRQ_MASK,
+			       priv->supp_base + SPRD_MBOX_IRQ_MSK);
 	}
 	mutex_unlock(&priv->lock);
 }
@@ -272,8 +302,8 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sprd_mbox_priv *priv;
-	int ret, inbox_irq, outbox_irq;
-	unsigned long id;
+	int ret, inbox_irq, outbox_irq, supp_irq;
+	unsigned long id, supp;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -283,11 +313,15 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 	mutex_init(&priv->lock);
 
 	/*
-	 * The Spreadtrum mailbox uses an inbox to send messages to the target
-	 * core, and uses an outbox to receive messages from other cores.
+	 * Unisoc mailbox uses an inbox to send messages to the target
+	 * core, and uses (an) outbox(es) to receive messages from other
+	 * cores.
+	 *
+	 * Thus in general the mailbox controller supplies 2 different
+	 * register addresses and IRQ numbers for inbox and outbox.
 	 *
-	 * Thus the mailbox controller supplies 2 different register addresses
-	 * and IRQ numbers for inbox and outbox.
+	 * If necessary, a supplementary inbox could be enabled optionally
+	 * with an independent FIFO and an extra interrupt.
 	 */
 	priv->inbox_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->inbox_base))
@@ -313,7 +347,7 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	inbox_irq = platform_get_irq(pdev, 0);
+	inbox_irq = platform_get_irq_byname(pdev, "inbox");
 	if (inbox_irq < 0)
 		return inbox_irq;
 
@@ -324,7 +358,7 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	outbox_irq = platform_get_irq(pdev, 1);
+	outbox_irq = platform_get_irq_byname(pdev, "outbox");
 	if (outbox_irq < 0)
 		return outbox_irq;
 
@@ -335,6 +369,24 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Supplementary outbox IRQ is optional */
+	supp_irq = platform_get_irq_byname(pdev, "supp-outbox");
+	if (supp_irq > 0) {
+		ret = devm_request_irq(dev, supp_irq, sprd_mbox_supp_isr,
+				       IRQF_NO_SUSPEND, dev_name(dev), priv);
+		if (ret) {
+			dev_err(dev, "failed to request outbox IRQ: %d\n", ret);
+			return ret;
+		}
+
+		supp = (unsigned long) of_device_get_match_data(dev);
+		if (!supp) {
+			dev_err(dev, "no supplementary outbox specified\n");
+			return -ENODEV;
+		}
+		priv->supp_base = priv->outbox_base + (SPRD_OUTBOX_BASE_SPAN * supp);
+	}
+
 	/* Get the default outbox FIFO depth */
 	priv->outbox_fifo_depth =
 		readl(priv->outbox_base + SPRD_MBOX_FIFO_DEPTH) + 1;
@@ -357,7 +409,9 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sprd_mbox_of_match[] = {
-	{ .compatible = "sprd,sc9860-mailbox", },
+	{ .compatible = "sprd,sc9860-mailbox" },
+	{ .compatible = "sprd,sc9863a-mailbox",
+	  .data = (void *)SPRD_SUPP_INBOX_ID_SC9863A },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sprd_mbox_of_match);
-- 
2.7.4

