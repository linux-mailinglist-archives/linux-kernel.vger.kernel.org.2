Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D03C31AB50
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBMMYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBMMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:23:52 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDBBC061786;
        Sat, 13 Feb 2021 04:23:12 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z15so1286733pfc.3;
        Sat, 13 Feb 2021 04:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G68uhqo3hbiXRho+aO8mb4g6uNzd2hPXIYN68FYpYDs=;
        b=oK61SoawDXTG/VXOKSBvjXpoZ8sJRqieK0ziROwAUeYtKxeLCsDalLCSnJwhK/+RSr
         0vfVymF/W/n5dMqXf4iAMLt7a4ikCNkwADbKXD800UAqDDBVy/uZvlybgjqoKSvs1gcz
         MT/TBLeL2fTsphh41IskwJw3xAAzmgXcAoDKBBtMVH2d7MrYvG8dBDfrsRFxNCwJ4Oc5
         eD6bO0dISOK8445U8nEo1uejNPXEzQSDMbuMO45eI68et0aDHaDeS7tGnoPuqADkWJYw
         ivtRDhrsvvqBKuaPXKlJw20GHy6kuWmCYAkU/Gkj6AI5KOnlFtgRYoL/GqToOnWBw03e
         /5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G68uhqo3hbiXRho+aO8mb4g6uNzd2hPXIYN68FYpYDs=;
        b=Opv8X8iRZTkVLfuBtVZbIoOGJNbl8quYt3++C05I9hGS+fTe1PtiYnFZeBeqxzkNXD
         UFLYGUU56fvrAqxaqBlzqkVXJPWzkaYBPGsvPfHjUv5wK0ni21HBhch8H4H44EN9QMiB
         j9rYwOHOoHBrFQdMHoCFv38e8kWop9RmpNV9tCqh6eGTD6lhluZph9r/dMuH+PVn39+b
         eoPlF7LlW/h9Q+i2Kmj9epfvtWtsesU1/AzQOvLK1xuqErJXWTag1Cw2bn3zACkUWEoC
         BTGlkro1Cds8IXmhLv7A20qdgKxTggAp4gIrisqAAAnNHXWhbW6wPyT9ahmcwYrXwa31
         srtg==
X-Gm-Message-State: AOAM533xyyeT/aO8LzqpS2P0m+CjuYEFIwCeR/2jh+fu7/rWT24//EM7
        xoudUjGcQVQ4utwjJW8hoF0=
X-Google-Smtp-Source: ABdhPJzJULo/oMFmpvpHaingjn2rwURNzfd06a+8R4Zeae4wEFlCrNzgJ+MIJjn5bOoeLVe6jRE8WQ==
X-Received: by 2002:a63:5703:: with SMTP id l3mr7253495pgb.344.1613218991880;
        Sat, 13 Feb 2021 04:23:11 -0800 (PST)
Received: from localhost (li1438-199.members.linode.com. [45.33.111.199])
        by smtp.gmail.com with ESMTPSA id b3sm10248304pjh.22.2021.02.13.04.23.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Feb 2021 04:23:11 -0800 (PST)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haidong Yao <yaohaidong369@gmail.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH v2 3/3] mailbox: sprd: Add supplementary inbox support
Date:   Sat, 13 Feb 2021 20:21:43 +0800
Message-Id: <20210213122143.19240-4-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210213122143.19240-1-orsonzhai@gmail.com>
References: <20210213122143.19240-1-orsonzhai@gmail.com>
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
---
 drivers/mailbox/sprd-mailbox.c | 88 +++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index 920de7b9dce1..7abd6c6d655d 100644
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
2.17.1

