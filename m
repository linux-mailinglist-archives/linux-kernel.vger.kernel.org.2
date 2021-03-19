Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A651E341548
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 07:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhCSGQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhCSGQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:16:27 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C407EC06174A;
        Thu, 18 Mar 2021 23:16:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y27so2994303pga.9;
        Thu, 18 Mar 2021 23:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qay7WUQ/qU5axWyvmlEDb+SE3CcuhisRt3267Js2yUs=;
        b=XZM64n+9RvRvWR31jkd3hV2Bp0L3+t71H55qQY0/HiWa30+hk9VdRSimFpvRQSesfA
         uY+kQkDfmb7u6SGJsQlcPW/8AWcscU1fyGwJDsqv+SL7Z821kq3zM3hnQSmGqeWWt+iP
         Nchfce4naxmLiV6ejOEukCEeBWz3wMMF3zqRhXFjalstOtJ/r/Oax2dD6iTOMh7Q984P
         zMQp1ZjgtFbvuHTwP1R9LHKJzNVYqdv/62s4h2rsK0+Nx/qG14EeOdry72tvDJoSZ/tI
         DwRzEntwM09tO0A1De6qxdvNEXSqYxZAt1DOldEcZvRtTNDpjO+F8ubX6urJRMN3ABam
         iU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qay7WUQ/qU5axWyvmlEDb+SE3CcuhisRt3267Js2yUs=;
        b=RgJeovYIlSEARV9dz3ZePWwAGoTPOTsUwVYWL/4PuvwtPdqqC7TD2O0/mFvuk0kin6
         Wu8nEmbr4a7lYHi8IqrEiGgtln2f/7jt2z7Xa24b8fmRULofBIOnY/ANEI3Y6XbutLka
         /Iymqa82Q9Xi18TlGz61yLr7gvW8/BKxjgM3VU6nND1m6AbRYRj7B0agT1n+goLTDJ34
         LPFmi240pNLodLtfzUeAuTz5jWKS5lf/t6pxdEHFYMFjEwYlFaSFmXVnGJzUhzTgP34p
         qPKJOvQco0/mBHo2Jm9SG8XQb/jvvKmHJnh+d7HHUQ3zUAITSHHd13SfDcbV/rtQ24Y5
         mJJA==
X-Gm-Message-State: AOAM5323S6IDRcgoe2lsOsBK1FgR8FcdRRUSPozUbTRCE9o/5Qlrnflf
        Rjk7Ctyw1LbpvPb/C1jsqQ8=
X-Google-Smtp-Source: ABdhPJxOhAjpWWxwjFlvYjOC6Uv2XBXMzS9Z2P7/4cpEtyrKxh9bchlgqu1Jov+PxncwomUQwb5giw==
X-Received: by 2002:a62:6045:0:b029:20c:b6a6:6077 with SMTP id u66-20020a6260450000b029020cb6a66077mr7627890pfb.51.1616134581374;
        Thu, 18 Mar 2021 23:16:21 -0700 (PDT)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o1sm4223103pjp.4.2021.03.18.23.16.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 23:16:21 -0700 (PDT)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, haidong.yao@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH v3 1/3] mailbox: sprd: Introduce refcnt when clients requests/free channels
Date:   Fri, 19 Mar 2021 14:15:35 +0800
Message-Id: <1616134537-27966-2-git-send-email-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616134537-27966-1-git-send-email-orsonzhai@gmail.com>
References: <1616134537-27966-1-git-send-email-orsonzhai@gmail.com>
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
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mailbox/sprd-mailbox.c | 43 ++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index 4c32530..94d9067d 100644
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
2.7.4

