Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4595410643
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbhIRMMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:12:02 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51017 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235075AbhIRMLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:11:24 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 88CD5580A89;
        Sat, 18 Sep 2021 08:10:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 18 Sep 2021 08:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=43QUIQl/3S9/J
        FKbD85BT0gzw5E/ho94fIt2sDWG2Ig=; b=FSfomUJGxWDbhKXQmFClCILkUn/Wu
        bpxyEUuk6JwhLWYQALigYVPtyF2pjI3i8GgZwkxL9K4+TAFfJ0AyJ0mk+R5mDTek
        KCw+P9iAGPrusWb3Xfen5jcTG96EZ0Wk7WBEv2o49fHCVUk6QLpzhFKVGRTuPvLx
        qP1NBeuYmMJMwnxC4uGxLJxqknSwzJafPk5UTD5QwcNVX4S9L6j5+h5XZqnmhV5X
        4eaM+yuZ6PRkQQofjWg1kK8BMGvUgSrn4gp9MGlnzjZr0hA66LA4JGSBqiTDgh20
        pQyheZTJeAkAUu+X6hJH33z0kOcbX2NTwMddwgTPs0cpWdoLaTQ5ob86w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=43QUIQl/3S9/JFKbD85BT0gzw5E/ho94fIt2sDWG2Ig=; b=Tw1kVD/m
        LjOd5k+PE7Oi08ub93wDH5TRkY8BROaPk35/3bC90up82oGAGwQTZqMiFR9NCLwh
        o4bqQtweRODXnVS5GvZPEBhAwNNamY50cbHR2pj+BjWAdWgd4o6jIIjEaBVyq5HA
        YwqM7dDGGtcHKkt85zMlC69ktiDlTPormBkO99mlYDVkc+Swv6DsYoPmaU8nzFdM
        fVkSrxRn1jlYu3VIqmZF4FtttPkxea6cOZFFAmGLOhHX72TvC78gfCPdiph35jG4
        uDFOH6dDmhNC5aR1kwfuMeOBhTpMuC+7YNL29G2YmtXXSMrzSljQI21QGTHtOkJB
        F4wnwl9z3KOjgA==
X-ME-Sender: <xms:GNdFYTu7cfjx6vrQn9XYQPrxG-aHWh3KmTi7QM_tM5Md1AsqF-umlg>
    <xme:GNdFYUfW_QJQdtBq7FP4kw-ulxfOFddnEwYmZ6k8AvQ8dkcDcj_9CaoUCRqO3jGuT
    ZgZjXefhk3mq81UI48>
X-ME-Received: <xmr:GNdFYWxebGfJ4Xg9TJ0rkPesYWdVmWcJTV-9c01_ivycTwkv0Lu8T3RNLC6sYYclnnSZ-gv1-2_7NHp_niOp77TUVjFCdpJhgJJVIcXwpj1oDzN5tz9PxGR9_KYHYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:GNdFYSOobF4KklFtAqSbroNKPPhCuxomx2LE82G3fn9_hi7_U0hu7g>
    <xmx:GNdFYT_N2mlpEEnNsJHNNrUhjI0saF7Goc3RrHpB2b-mhhS59G2RuA>
    <xmx:GNdFYSWaiv_t922Koxp89ou2oYH0teEYnKogeMBxqxCVjtPFq6rLkA>
    <xmx:GNdFYSWAv-5O1M0owfy0zBt01yXKherEGdax5uNrpRwIX62eqL_zPg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Sep 2021 08:09:58 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [RFT PATCH 4/9] usb: typec: tipd: Add short-circuit for no irqs
Date:   Sat, 18 Sep 2021 14:09:29 +0200
Message-Id: <20210918120934.28252-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210918120934.28252-1-sven@svenpeter.dev>
References: <20210918120934.28252-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no interrupts are set in IntEventX directly skip to the end of the
interrupt handler and return IRQ_NONE instead of IRQ_HANDLED.
This possibly allows to detect spurious interrupts if the i2c bus is fast
enough.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index c2c399722c37..4a6d66250fef 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -434,6 +434,8 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	trace_tps6598x_irq(event1, event2);
 
 	event = event1 | event2;
+	if (!event)
+		goto err_unlock;
 
 	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
 	if (ret) {
@@ -481,7 +483,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	return IRQ_HANDLED;
+	if (event)
+		return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int tps6598x_check_mode(struct tps6598x *tps)
-- 
2.25.1

