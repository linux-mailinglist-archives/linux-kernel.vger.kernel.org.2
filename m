Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6174C4175E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346530AbhIXNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346282AbhIXNed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:34:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550CBC061A15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:29:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t4so6533280plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EPqUASWwyNuUhMior37hMo+yqFA/0CFRmHFpRpWedHU=;
        b=jXd4h1P5tG3/KArfkSmvmYJXBb6aKx5mKYkgNooa6owTVly6XeFrlShLn/IKEikiTK
         WuSSDdkdb5CgOwivKMKLoWx15Vmqf2dk30u2oP0KyTfnabjWFX79lwcaNhQRAL8o2QHh
         WBTF0mJXYwd8h1CIXUaj9ZBN8iYqYU1LA7XAelBRsLG580OII2hvCSJeLrkR/12RFSmt
         RGSQ7bbGY522F+kcyr7J7nw9UwXb6ILp9hFeLpJ1fJfzmZFSGc2fDVgeYBieNmri4gQz
         kKfLoZ1HRe9bz59jH26aC52N7CadjXU8x4dY9R8aon5YWDHDmg7hydn0/sjPAzoub5Dq
         ut6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPqUASWwyNuUhMior37hMo+yqFA/0CFRmHFpRpWedHU=;
        b=tgcyr6cx/tMa3Bsh1Cqjr4VUvfCERB1mKofV1LHmCm0yCPMNd/bxLaC0LjN15rEgu+
         9ziejJ1I7zMFBe7rbQJm3QihVPeNhCim7J92cD/X2dXuWk6JsMtv2qWEZ21dwAV1uvoo
         EDZFkSGMRtXeGWw/gLnMRarKgAMzWLqO+sh6aw7GxiDe5elheS4VqYsfMj6NyQrYUIQZ
         EeYI/EoOiNcesKhPq+Q9dVzYTZkkMf1NG7t2vuyQzF8G39YPubnzxZLah5pZUlELFGNR
         5x9DklyF105iE6KN2dU+WbaI/uQInk99hLL1n2dS/g/vbgN3GS5Lg06/bf/jnuGpdPxq
         FVzw==
X-Gm-Message-State: AOAM533TnR/gI4eW71OLHyQY5WrTOS7j02AIKQzVWT+VNp98peKAs6Rz
        gFQ2mFnyEbig2JcBl8wCow==
X-Google-Smtp-Source: ABdhPJyQ1WXP2tX0QuZxhDZ5p5kDJty62Fr2t/SIdOFtZmPHAVPyEc7Cgby/F951HIOQL+ltoiSLzA==
X-Received: by 2002:a17:902:a50f:b029:11a:b033:e158 with SMTP id s15-20020a170902a50fb029011ab033e158mr9345901plq.26.1632490161936;
        Fri, 24 Sep 2021 06:29:21 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 26sm11756573pgx.72.2021.09.24.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:29:21 -0700 (PDT)
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
Subject: [PATCHv2 5/5] irqchip/GICv3: make reschedule-ipi light weight
Date:   Fri, 24 Sep 2021 21:28:37 +0800
Message-Id: <20210924132837.45994-6-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924132837.45994-1-kernelfans@gmail.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To achieve the light weight as
DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_reschedule_ipi) on x86, it had
better treat irqnr differently at the frontend. And let IPI_RESCHEDULE
call __irq_enter_raw() instead of irq_enter_rcu().

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
 drivers/irqchip/irq-gic-v3.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 906538fa8771..593d4539a209 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -709,6 +709,9 @@ static void gic_handle_nmi(struct pt_regs *regs)
 		gic_deactivate_unhandled(irqnr);
 }
 
+/* RESCHEDULE IPI hwirq nr is 0, and the only raw one */
+static unsigned long raw_interrupt_mask = 1;
+
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
@@ -729,12 +732,20 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	else
 		isb();
 
-	irq_enter_rcu();
+	if (raw_interrupt_mask & 1 << irqnr)
+		__irq_enter_raw();
+	else
+		irq_enter_rcu();
+
 	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
 		WARN_ONCE(true, "Unexpected interrupt received!\n");
 		gic_deactivate_unhandled(irqnr);
 	}
-	irq_exit_rcu();
+
+	if (raw_interrupt_mask & 1 << irqnr)
+		__irq_exit_raw();
+	else
+		irq_exit_rcu();
 }
 
 static u32 gic_get_pribits(void)
-- 
2.31.1

