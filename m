Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AB64175E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346469AbhIXNem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346558AbhIXNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:34:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D48C08E9AD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:29:07 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e7so9893030pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2re79r/KMQm8fC1r1C1DX1MnLIusIxSofGmOWtOLv8=;
        b=pu20CDJ63FPAZYqTMiqLBsWmahvQuNVWq+rjQjOyUIBcwGDWU1xS6o7oUh56yY0iFi
         xhgEyY4QuwLAfHjCCLCp8GBGg2+LKvg6R2tsyDOBY3eA4tjgPP3KQerr6HIKfD2VBWJg
         OlJIKFhMDIUXEJQKOyAqnhsj4PdEQ2FtQY193GAu9BP6wgkJkJ3VI9+7RkjLmFIoqi2M
         J93vY5xWBxYgSl8YLQTL/pzpbFR1Qu7XYy9q/NQzPIeDAv+oF/IQGpk/ZvTJWAKy69a1
         mcaPPZFQcwwrX2x1hbaWRLFUmGPWH1/Oid+oy6m1yMhGMoOkFB0okrWaNcrTdW9c/S8p
         k08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2re79r/KMQm8fC1r1C1DX1MnLIusIxSofGmOWtOLv8=;
        b=ENvpP9r754DtsaxrUlmcbZyOxHZ04PQPxPpXAaY09x/KxIps2rFs6qjPmlBlQ/yWVY
         n26jnVZxE4AWNtCahGXLxD00M1ZxgPPjgdBrsHAh77Soy9mUogxZfBliz1zN/ZUXToKC
         76ZTzCg/to/0Ni1uDKlTZ2bcpfpl01mDryGbMK1e5J7SFHvJsUzV6OzrgO2/8n69T8LC
         UyAr5Huvc/JwsZJ2O62H9mfB1YLPFh4Q3i7X34WM+3641oHZPw6RQyeZ36XYszHBNbOO
         Uy3xu5gD1CMFbw9w/n5jzmoQp5ubz03iK5DSOy2v5Us+6JTKj6NzsUzdcg+OwyXVaTsh
         wuIg==
X-Gm-Message-State: AOAM533PgIbeqrEX1FlX7l6lfkXI/ts8LywcBhpK80Cgrtmmy28aJQNZ
        aSdPD4llBokN1it6GnjH7Q==
X-Google-Smtp-Source: ABdhPJyVLf2VBROoVBckvGi5mCtdHnpZ3wBEsV++tAn/ln2TpuxIAOv5tUd/N6zOk8DqvUq47PzLdQ==
X-Received: by 2002:a63:ef01:: with SMTP id u1mr3784992pgh.336.1632490146668;
        Fri, 24 Sep 2021 06:29:06 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 26sm11756573pgx.72.2021.09.24.06.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:29:06 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/5] irqchip/GICv3: expose handle_nmi() directly
Date:   Fri, 24 Sep 2021 21:28:34 +0800
Message-Id: <20210924132837.45994-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924132837.45994-1-kernelfans@gmail.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous patch, the NMI should be dispatched at irqentry level.
Accordingly adjust GICv3 to utilize the hooks, so NMI handler can be
dispatched.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/irq.h |  2 ++
 drivers/irqchip/irq-gic-v3.c | 53 +++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index a59b1745f458..c39627290a60 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -11,6 +11,8 @@ struct pt_regs;
 int set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #define set_handle_irq	set_handle_irq
 int set_handle_fiq(void (*handle_fiq)(struct pt_regs *));
+int set_handle_nmi(void (*handle_nmi)(struct pt_regs *));
+int set_nmi_discriminator(bool (*discriminator)(void));
 
 extern void (*handle_arch_irq)(struct pt_regs *regs);
 extern void (*handle_arch_fiq)(struct pt_regs *regs);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd4e9a37fea6..89dcec902a82 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -644,28 +644,12 @@ static void gic_deactivate_unhandled(u32 irqnr)
 	}
 }
 
-static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
+static bool gic_is_in_nmi(void)
 {
-	bool irqs_enabled = interrupts_enabled(regs);
-	int err;
-
-	if (irqs_enabled)
-		nmi_enter();
-
-	if (static_branch_likely(&supports_deactivate_key))
-		gic_write_eoir(irqnr);
-	/*
-	 * Leave the PSR.I bit set to prevent other NMIs to be
-	 * received while handling this one.
-	 * PSR.I will be restored when we ERET to the
-	 * interrupted context.
-	 */
-	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
-	if (err)
-		gic_deactivate_unhandled(irqnr);
+	if (gic_supports_nmi() && unlikely(gic_read_rpr() == GICD_INT_NMI_PRI))
+		return true;
 
-	if (irqs_enabled)
-		nmi_exit();
+	return false;
 }
 
 static u32 do_read_iar(struct pt_regs *regs)
@@ -702,21 +686,38 @@ static u32 do_read_iar(struct pt_regs *regs)
 	return iar;
 }
 
-static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+static void gic_handle_nmi(struct pt_regs *regs)
 {
 	u32 irqnr;
+	int err;
 
 	irqnr = do_read_iar(regs);
 
 	/* Check for special IDs first */
 	if ((irqnr >= 1020 && irqnr <= 1023))
 		return;
+	if (static_branch_likely(&supports_deactivate_key))
+		gic_write_eoir(irqnr);
+	/*
+	 * Leave the PSR.I bit set to prevent other NMIs to be
+	 * received while handling this one.
+	 * PSR.I will be restored when we ERET to the
+	 * interrupted context.
+	 */
+	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
+	if (err)
+		gic_deactivate_unhandled(irqnr);
+}
 
-	if (gic_supports_nmi() &&
-	    unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI))) {
-		gic_handle_nmi(irqnr, regs);
+static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+{
+	u32 irqnr;
+
+	irqnr = do_read_iar(regs);
+
+	/* Check for special IDs first */
+	if ((irqnr >= 1020 && irqnr <= 1023))
 		return;
-	}
 
 	if (gic_prio_masking_enabled()) {
 		gic_pmr_mask_irqs();
@@ -1791,6 +1792,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	}
 
 	set_handle_irq(gic_handle_irq);
+	set_handle_nmi(gic_handle_nmi);
+	set_nmi_discriminator(gic_is_in_nmi);
 
 	gic_update_rdist_properties();
 
-- 
2.31.1

