Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897A141B35B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbhI1P5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:57:10 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58429 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241729AbhI1P5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:57:05 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9D8FC580C23;
        Tue, 28 Sep 2021 11:55:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Sep 2021 11:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=l7l2ToDgnvybd
        Ml4obXc3cfMQHrVz6bhWaTvDSMxSUA=; b=Pdm5zUeMOXG2d//6NoexJqLVpWWZ7
        UEx+yCZcGbXJeiFPAvdH+mLUcas6ME/Y/fiDGm+dENyqBhzvbm7kvqmy77lY+Oag
        bktIPzzaoJcbUkBQBUqS03DESeWRMmdCBaUFLS1zaeoR4sYl59aDZ+3KkoP/Ubtz
        vig+RIGAkMz6AlFRP+gMOqW9J260CCuPB5WUThXehqDLRjG+raMp5qm+t7vr++wk
        c9ep3dSzHB6YuLvJwNd7o2t3jgLjulOPVgG2JRxBx7uhxYq3dQfkdAq0ncplmJNt
        OtgIalpC7hkMf0wo1GbMnvdNJBCZ5MTL2RkAJP+QnFZ9dmM94yBZYf6Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=l7l2ToDgnvybdMl4obXc3cfMQHrVz6bhWaTvDSMxSUA=; b=NJZFzXVy
        lmpJBSH1b3ou1HW2vjXZ+6AgQTV2nOf85QihyEAYsWbg5gUlTC+P1jWVPScjp1tt
        aTwYiXBo+VVplF5fsaYvFsMr80ZiG/ez/1ewf58Tp8TXiRV+FcnBZM8fcruDvvAt
        eOz+g8LCQTusP4IZoxTFv+MbEkSWPNpiByF7LcQc+KC6erwz1VwAwwLFVXgKB3YT
        cfiMLEaXaJPLlpYK9r/1eEf3fnReopNA81g/K4d/bD0+C3eQhmlTrMBep5H53jFa
        CFnBhj/sMyoTUlGEIeFp0Apff4GMyj6I7Fb+PbmtxgHMra6JSmN072k+YmlVci5R
        8WusdL+ZP3j04g==
X-ME-Sender: <xms:7TpTYYj4xytI-x4in-Kgd0tPFc1dz6KzccL1g9Y6hyjzkeHmJlPdMw>
    <xme:7TpTYRAexaLTuGa_FRMZc_bEIUy7ldv_Z28m2RufhXIZ4cpXVcW6e_r3UpiSnjNbK
    vPrn_kjSPWCKkX4R4U>
X-ME-Received: <xmr:7TpTYQGFEPWPCKvAD8p_A6xkEsHV_6iesQcW6vKcdaAMUf_N0Fjw_P9J7UELTR3-0o8hp5x6KYREx0gh_CVaEtMT3Wc5BGr9i0c000RdtPWBH_zOIUVPxF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:7TpTYZTzVu9_fYG0Rn9xjsFwCNQGb4fnchQmKKi9lUqK9Zbg4AzM0A>
    <xmx:7TpTYVxykCf_mC5uWEThys_oJ_6cyz2qnPG0b-PBcGAkhxKFNH7eFA>
    <xmx:7TpTYX719VT_1u72joW5mK_W2ajVibFPMy8qFGVEnKazV34A2lB-eQ>
    <xmx:7TpTYb5jDDpXwsf8bEPycTSAs-Y30qzxaMmZmN-f6emAogR0DD9qww>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 11:55:23 -0400 (EDT)
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
Subject: [PATCH v3 3/6] usb: typec: tipd: Add short-circuit for no irqs
Date:   Tue, 28 Sep 2021 17:54:59 +0200
Message-Id: <20210928155502.71372-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210928155502.71372-1-sven@svenpeter.dev>
References: <20210928155502.71372-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no interrupts are set in IntEventX directly skip to the end of the
interrupt handler and return IRQ_NONE instead of IRQ_HANDLED.
This possibly allows to detect spurious interrupts if the i2c bus is fast
enough.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
no changes since v2

changes since v1:
  - added Heikki's r-b
  - s/event/(event1 | event2)/

 drivers/usb/typec/tipd/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 172715c6c238..e785e4aa2d4b 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -479,6 +479,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 	trace_tps6598x_irq(event1, event2);
 
+	if (!(event1 | event2))
+		goto err_unlock;
+
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
@@ -501,7 +504,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	return IRQ_HANDLED;
+	if (event1 | event2)
+		return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int tps6598x_check_mode(struct tps6598x *tps)
-- 
2.25.1

