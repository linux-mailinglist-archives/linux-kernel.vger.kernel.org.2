Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CF53F2D33
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhHTNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:35:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhHTNfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:35:23 -0400
Date:   Fri, 20 Aug 2021 13:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629466484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIcVo3GrU0USPRFlaMAfgjkkTvVDTRVoP4ZQuCvHXks=;
        b=GwLPwBjp4Pl9MZR5aO3ZghciwF5XgBvnehB1BkkmNYxCHazcdYZegbySO2/SX6ehmdXFY6
        fk2EeOy5QvItCvP0MqRx3cDiw/XaXdF6ZQ3cjsFxnSHxeYvoE3lL8VGX7DNPH9tlBbu+5j
        xGBvxCppj/9Je3UMKT4KV7oKI8HOFOAxJde60MNdito2n3snHqEXW3ZeIzh4wnBv339kVk
        9gityzFqpQsKck74G3TusSCCWNVtkPUGDfWZOL7RgViNqvRF8pGGJB5xnL5hQNLwsXxR1O
        YKmtGKXvbRtVaTAH/Ai3tUsNQS3dN6PiISSzhKV6OOes3DG1PxzMGixvoirh8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629466484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIcVo3GrU0USPRFlaMAfgjkkTvVDTRVoP4ZQuCvHXks=;
        b=v0MG8pAm8b9Jf3KMp9viMe+zV4wq7UBtlnS09pgWq7M2Iw1+cTSHkxWDR5fGwCeVovWO+/
        GaItW0ZkZqc4byCQ==
From:   "irqchip-bot for Chen-Yu Tsai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Fix priority comparison
 when non-secure priorities are used
Cc:     "Chen-Yu Tsai" <wenst@chromium.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210811171505.1502090-1-wenst@chromium.org>
References: <20210811171505.1502090-1-wenst@chromium.org>
MIME-Version: 1.0
Message-ID: <162946648351.25758.16891734926891718781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2341aaa8fa8f8f6be550e6c4d4c1ce4283d15ea9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2341aaa8fa8f8f6be550e6c4d4c1ce4283d15ea9
Author:        Chen-Yu Tsai <wenst@chromium.org>
AuthorDate:    Thu, 12 Aug 2021 01:15:05 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 20 Aug 2021 14:32:40 +01:00

irqchip/gic-v3: Fix priority comparison when non-secure priorities are used

When non-secure priorities are used, compared to the raw priority set,
the value read back from RPR is also right-shifted by one and the
highest bit set.

Add a macro to do the modifications to the raw priority when doing the
comparison against the RPR value. This corrects the pseudo-NMI behavior
when non-secure priorities in the GIC are used. Tested on 5.10 with
the "IPI as pseudo-NMI" series [1] applied on MT8195.

[1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/

Fixes: 336780590990 ("irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210811171505.1502090-1-wenst@chromium.org
---
 drivers/irqchip/irq-gic-v3.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4deb..e7a0b55 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -100,6 +100,15 @@ EXPORT_SYMBOL(gic_pmr_sync);
 DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
 EXPORT_SYMBOL(gic_nonsecure_priorities);
 
+#define GICD_INT_RPR_PRI(priority)					\
+	({								\
+		u32 __priority = (priority);				\
+		if (static_branch_unlikely(&gic_nonsecure_priorities))	\
+			__priority = 0x80 | (__priority >> 1);		\
+									\
+		__priority;						\
+	})
+
 /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
 static refcount_t *ppi_nmi_refs;
 
@@ -687,7 +696,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		return;
 
 	if (gic_supports_nmi() &&
-	    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+	    unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI))) {
 		gic_handle_nmi(irqnr, regs);
 		return;
 	}
