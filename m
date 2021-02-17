Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30BB31D5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBQHe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 02:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhBQHeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:34:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A4EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:33:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i2so17118915ybl.16
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=lOAK9IBrMCCtns9spRcLU7grHL9xP9PXBr01poTnJKY=;
        b=P5gyLLrxKOVGU82VrYnGNZR9YQ8DEUufItIWC1jzHPG3BqSxp7C3OyFVNzXbUfhP/2
         cDOOlPgBQDbGbFNzWH/5mTW7476Gf4ujHV6J5qJvHwdvyqb5MpH9aLMqBOlaAwLX4MGW
         uzcm9IeFYvaJImfJaeutslEa7gdOmZ8uuP7tTmWuj2HnUMmzGUPI0xhsMzW9swyaxtaC
         OReaE0rCjyekMoHLekdekSlY5N3TE+Dk1zMdTzKxt2wnpf+JXkp6HGWHXuLrjRUt3bkg
         mqAbTdGMM3Te+ASL5Kl3d+JkpHaSGp+HJJtUexQ0QoU8+P2h4OYb6dnmDjliyBqnnexa
         ZjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=lOAK9IBrMCCtns9spRcLU7grHL9xP9PXBr01poTnJKY=;
        b=apOpgNcJ50pc/t9JTngNod7H6GmlvHLiwS3WK+TX1cHDzZInNr9yiBmvST9Rf53Bpu
         38rrPrzixpCdZ8hhloKMhOY0Qe0iJznxsY7DBwml1EYGyAeABzr+Jt+ubN0w1JEFVvwt
         EkEbVeweZFRmwNpjik7oFsI5y4SsmdGUZQTIDeVKm9NbpBVGO3wnQfiMxoyErSPomCvC
         Hyg9+xnui5FR2zC0TL5MTUOFDg1ZfktH6bOEw/mdftyMqcCGrps20g4tVr1zh5jSRoCj
         7MwP3hdvRIh4WSo2dWHlygY8/MgmtqxuY3TD5XAJN6/qzM2vzM3pDQyJzY0NSE7FBASs
         1V/A==
X-Gm-Message-State: AOAM5311RTw+Hm4gWRhyYhBDZtHgboZLH9CbloBTOvCCnOmlh8D5DOw1
        iU5tMOCZwBNeOBPH35Iq3wO82oo=
X-Google-Smtp-Source: ABdhPJzYB7CSY+bsx+FwoZb40f5/sdDpsrEVDYihSkZCXu8FC6rGnStezZAhqtcO27fQjXacbrkLiA4=
Sender: "wak via sendgmr" <wak@wak-linux.svl.corp.google.com>
X-Received: from wak-linux.svl.corp.google.com ([2620:15c:2c5:3:e984:b7fc:110a:274a])
 (user=wak job=sendgmr) by 2002:a25:850e:: with SMTP id w14mr28906187ybk.259.1613547220757;
 Tue, 16 Feb 2021 23:33:40 -0800 (PST)
Date:   Tue, 16 Feb 2021 23:33:14 -0800
Message-Id: <20210217073318.540369-1-wak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 1/4] ipmi: kcs_bmc: Simplify irq handling
From:   "William A. Kennington III" <wak@google.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "William A. Kennington III" <wak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms specific IRQ handles repeat the same logic, calling a
sub-handler in the kcs_bmc generic code that should just conform to the
irqhandler callback.

Signed-off-by: William A. Kennington III <wak@google.com>
---
 drivers/char/ipmi/kcs_bmc.c         | 10 +++++-----
 drivers/char/ipmi/kcs_bmc.h         |  3 ++-
 drivers/char/ipmi/kcs_bmc_aspeed.c  | 12 +-----------
 drivers/char/ipmi/kcs_bmc_npcm7xx.c | 12 +-----------
 4 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index f292e74bd4a5..ccb35f1645cf 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -209,10 +209,11 @@ static void kcs_bmc_handle_cmd(struct kcs_bmc *kcs_bmc)
 	}
 }
 
-int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
+irqreturn_t kcs_bmc_irq(int irq, void *arg)
 {
+	struct kcs_bmc *kcs_bmc = arg;
 	unsigned long flags;
-	int ret = -ENODATA;
+	irqreturn_t ret = IRQ_NONE;
 	u8 status;
 
 	spin_lock_irqsave(&kcs_bmc->lock, flags);
@@ -225,15 +226,14 @@ int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
 			kcs_bmc_handle_cmd(kcs_bmc);
 		else
 			kcs_bmc_handle_data(kcs_bmc);
-
-		ret = 0;
+		ret = IRQ_HANDLED;
 	}
 
 	spin_unlock_irqrestore(&kcs_bmc->lock, flags);
 
 	return ret;
 }
-EXPORT_SYMBOL(kcs_bmc_handle_event);
+EXPORT_SYMBOL(kcs_bmc_irq);
 
 static inline struct kcs_bmc *to_kcs_bmc(struct file *filp)
 {
diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
index eb9ea4ce78b8..959d7042e6d2 100644
--- a/drivers/char/ipmi/kcs_bmc.h
+++ b/drivers/char/ipmi/kcs_bmc.h
@@ -6,6 +6,7 @@
 #ifndef __KCS_BMC_H__
 #define __KCS_BMC_H__
 
+#include <linux/irqreturn.h>
 #include <linux/miscdevice.h>
 
 /* Different phases of the KCS BMC module.
@@ -102,7 +103,7 @@ static inline void *kcs_bmc_priv(struct kcs_bmc *kcs_bmc)
 	return kcs_bmc->priv;
 }
 
-int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc);
+irqreturn_t kcs_bmc_irq(int irq, void *arg);
 struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv,
 					u32 channel);
 #endif /* __KCS_BMC_H__ */
diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index a140203c079b..6451a8af2664 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -203,16 +203,6 @@ static void aspeed_kcs_enable_channel(struct kcs_bmc *kcs_bmc, bool enable)
 	}
 }
 
-static irqreturn_t aspeed_kcs_irq(int irq, void *arg)
-{
-	struct kcs_bmc *kcs_bmc = arg;
-
-	if (!kcs_bmc_handle_event(kcs_bmc))
-		return IRQ_HANDLED;
-
-	return IRQ_NONE;
-}
-
 static int aspeed_kcs_config_irq(struct kcs_bmc *kcs_bmc,
 			struct platform_device *pdev)
 {
@@ -223,7 +213,7 @@ static int aspeed_kcs_config_irq(struct kcs_bmc *kcs_bmc,
 	if (irq < 0)
 		return irq;
 
-	return devm_request_irq(dev, irq, aspeed_kcs_irq, IRQF_SHARED,
+	return devm_request_irq(dev, irq, kcs_bmc_irq, IRQF_SHARED,
 				dev_name(dev), kcs_bmc);
 }
 
diff --git a/drivers/char/ipmi/kcs_bmc_npcm7xx.c b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
index 722f7391fe1f..f417813cf900 100644
--- a/drivers/char/ipmi/kcs_bmc_npcm7xx.c
+++ b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
@@ -108,16 +108,6 @@ static void npcm7xx_kcs_enable_channel(struct kcs_bmc *kcs_bmc, bool enable)
 			   enable ? KCS_IE_IRQE | KCS_IE_HIRQE : 0);
 }
 
-static irqreturn_t npcm7xx_kcs_irq(int irq, void *arg)
-{
-	struct kcs_bmc *kcs_bmc = arg;
-
-	if (!kcs_bmc_handle_event(kcs_bmc))
-		return IRQ_HANDLED;
-
-	return IRQ_NONE;
-}
-
 static int npcm7xx_kcs_config_irq(struct kcs_bmc *kcs_bmc,
 				  struct platform_device *pdev)
 {
@@ -128,7 +118,7 @@ static int npcm7xx_kcs_config_irq(struct kcs_bmc *kcs_bmc,
 	if (irq < 0)
 		return irq;
 
-	return devm_request_irq(dev, irq, npcm7xx_kcs_irq, IRQF_SHARED,
+	return devm_request_irq(dev, irq, kcs_bmc_irq, IRQF_SHARED,
 				dev_name(dev), kcs_bmc);
 }
 
-- 
2.30.0.478.g8a0d178c01-goog

