Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A263131F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBHMOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhBHLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:53:07 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196ACC061756;
        Mon,  8 Feb 2021 03:52:27 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o7so10073304pgl.1;
        Mon, 08 Feb 2021 03:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pRcoC9IxO8teu+ATPd36RtsfDUP6Bt8LnrTxNQnBJn8=;
        b=h1AnncFzzz2zUFz6g/dO5pa5dN++IWDGd5pD4CjlStcMUBdQZ+ZbxVu5CcyRSlJS4A
         eFQtTpF5GVilCHkM+PJ6JwaBrExlYlZKZoskpLgpfLibhxQ4WyL/eEzubM8KbIW2GKEi
         OjTy/rrW49uC5gLns043DYCm6ZP5iqtMOBQcRRIni69MKj60IsSGj4V/W5a6Q/eQ6DP9
         DAExwUSo9rQwcI4z7rAqbLVp810aUGEAQr/wdpspurWYSwRziLCABHpR0a9YcctcLwUg
         d/Pw4JoSuJTNvuQg4vm3vcv2h9BLRDvlxdXFm2a6/FBz6hLhDWOnm1WcRnkemffJLjHq
         9E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pRcoC9IxO8teu+ATPd36RtsfDUP6Bt8LnrTxNQnBJn8=;
        b=IWhpLpDohkR24AQ1MEAutPgPTgSQ76CbL78rFhiAluSCvBFuXv4pR4uwx4x29NL0uq
         vRC2adCqEisbe9LjBzdkYGlqt1P6vHEt1FmyyYh7acKhdL/pn3XYnpbl1Kqo5JN3o1As
         Rmz8XLryHrf68bSg2NUrE4iIroaR+akXLUyCjm2nmcT0gZAKLsf0cyRG2Nqq3H+bGsOu
         aPnLR0udvYlu2M6q7RP7sh6R25RkqoKdXO2m+G3RMQKtbXg+la475ZDP7yUf2+TCtaP9
         PNOglEn9PKbTGirhIGKT7ZK6KHH/EgtHrjvnaJgcomOot8en01IetgxBe65nsVMjNQqj
         FCRA==
X-Gm-Message-State: AOAM5332AUYV9VGOwul4mVic8RRqJiLpp75ZH/+p5QqyxI8yfvIVmAZc
        YfUDOABa5vmQQqPxpP2LFhg=
X-Google-Smtp-Source: ABdhPJwLVj2Or07TkSmTRjBNfzFjp8uH2i9k0IQ1TixZOGJUpzj3qrsxTxOaFXIND2HmBBEdpfVa4w==
X-Received: by 2002:a63:5f15:: with SMTP id t21mr12555182pgb.402.1612785146640;
        Mon, 08 Feb 2021 03:52:26 -0800 (PST)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a9sm12875564pfr.204.2021.02.08.03.52.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:52:26 -0800 (PST)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, haidong.yao@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 2/3] mailbox: sprd: Add supplementary inbox support
Date:   Mon,  8 Feb 2021 19:51:03 +0800
Message-Id: <1612785064-3072-2-git-send-email-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com>
References: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

Some sensors connected to Unisoc mailbox will send data very frequently.
This makes channel 0 very busy and the messages from other remote cores
not able to be handled as soon as possible.

Then a supplementary inbox is added to the host core side for transferring
mass but not emergency messages from the remote cores, such as step
counting sensor, with an independent FIFO and interrupt.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 drivers/mailbox/sprd-mailbox.c | 93 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index e606f52..74648db 100644
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
+#define SPRD_SUPP_INBOX_ID_SC9860		6
 
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
+static inline irqreturn_t do_outbox_isr(void __iomem *base, struct sprd_mbox_priv *priv)
 {
-	struct sprd_mbox_priv *priv = data;
 	struct mbox_chan *chan;
 	u32 fifo_sts, fifo_len, msg[2];
 	int i, id;
 
-	fifo_sts = readl(priv->outbox_base + SPRD_MBOX_FIFO_STS);
+	fifo_sts = readl(base + SPRD_MBOX_FIFO_STS);
 
 	fifo_len = sprd_mbox_get_fifo_len(priv, fifo_sts);
 	if (!fifo_len) {
@@ -112,23 +116,41 @@ static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
 	}
 
 	for (i = 0; i < fifo_len; i++) {
-		msg[0] = readl(priv->outbox_base + SPRD_MBOX_MSG_LOW);
-		msg[1] = readl(priv->outbox_base + SPRD_MBOX_MSG_HIGH);
-		id = readl(priv->outbox_base + SPRD_MBOX_ID);
+		msg[0] = readl(base + SPRD_MBOX_MSG_LOW);
+		msg[1] = readl(base + SPRD_MBOX_MSG_HIGH);
+		id = readl(base + SPRD_MBOX_ID);
 
 		chan = &priv->chan[id];
-		mbox_chan_received_data(chan, (void *)msg);
+		if (chan->cl)
+			mbox_chan_received_data(chan, (void *)msg);
+		else
+			dev_warn_ratelimited(priv->dev,
+				    "message's been dropped at ch[%d]\n", id);
 
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
@@ -231,6 +253,14 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
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
 
@@ -246,6 +276,10 @@ static void sprd_mbox_shutdown(struct mbox_chan *chan)
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
@@ -268,8 +302,8 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sprd_mbox_priv *priv;
-	int ret, inbox_irq, outbox_irq;
-	unsigned long id;
+	int ret, inbox_irq, outbox_irq, supp_irq;
+	unsigned long id, supp;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -280,11 +314,15 @@ static int sprd_mbox_probe(struct platform_device *pdev)
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
@@ -310,7 +348,7 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	inbox_irq = platform_get_irq(pdev, 0);
+	inbox_irq = platform_get_irq_byname(pdev, "inbox");
 	if (inbox_irq < 0)
 		return inbox_irq;
 
@@ -321,7 +359,7 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	outbox_irq = platform_get_irq(pdev, 1);
+	outbox_irq = platform_get_irq_byname(pdev, "outbox");
 	if (outbox_irq < 0)
 		return outbox_irq;
 
@@ -332,6 +370,24 @@ static int sprd_mbox_probe(struct platform_device *pdev)
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
@@ -354,7 +410,8 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sprd_mbox_of_match[] = {
-	{ .compatible = "sprd,sc9860-mailbox", },
+	{ .compatible = "sprd,sc9860-mailbox",
+	  .data = (void *)SPRD_SUPP_INBOX_ID_SC9860 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sprd_mbox_of_match);
-- 
2.7.4

