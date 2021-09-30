Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52B441DAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350921AbhI3NTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350894AbhI3NTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:19:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C247C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:17:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q23so4954518pfs.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cWLoh4CcvhLIKXy9j6hWHn1puHnoZvSz+6V1tIrhSk=;
        b=YfKG4IUcpSD7uSwsssV39u5kc8ZC2MbIPeDm8sgud8s3bBX/YRXM6c1vSmbIpj8EBt
         tnkAw11U4fIHFXVcRjiAKL5Rd3fWPl1ZNgSYGldu4IJ8SzgoGTkrBFT9g4K+QB2C98Fb
         4HCZFS4onI3HYrtegYyaJn08syHn+lQqbyaet6e/ErRh4ahKlXYWxC+iMdmgpNBMdzzB
         a341uFQ0wuv+s0OjYC5suSrjSMULh3MfCHLsfJWFk45031miqQ20k++gAaGUp53/USAG
         dPCu85eqytFEcoN4Oh8E9fvKiWiP+8dr9ovxiUncvKD9nZNUnjVLe37DhnvQwmDN0/f+
         dU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cWLoh4CcvhLIKXy9j6hWHn1puHnoZvSz+6V1tIrhSk=;
        b=qpyiTnAQW2QpTLSQ78cK79LtP1PMkEOWeOTpPmof+aPxMTjm0gl4WyeQsCxNAR5w8s
         ZRUputri/v4F9vx/WXQsTjD8w/RE3lbxKWm8E48Yi1qWXX1SmexTs6KPbFk4H5jzEUKc
         zrUVqVo+s3UUJbWQY2XkywhhTdA86w3Re0mzQknLvTrnavC5HLq0dHThExpZTe51qGmj
         ESx1YMAW8Q8hyJ1dtAr8KnOq3QlIV8THPzslmoQGhJStnmkGXDLhuBFIfT8Kyyv+TKrh
         Ozh9bsyU7F1R1cQwlgTivDqLoHU6TSnrO7AxsrsRlLz+HNiQ0X1TQu35rpuZJSyvvhrJ
         OmkQ==
X-Gm-Message-State: AOAM5313NTxMPO/qi/hnU1vlS0TbRRPqMLRaZKnSSFZGio3jT8oFAnVi
        eZuPk4+tk4Ckdy/u6I2yVg==
X-Google-Smtp-Source: ABdhPJycB7rq7UJHpu341EboMwpUw/7YqAzCRDLpdyf1azRDx54df25WpeVOis767oN6z24e3R8baQ==
X-Received: by 2002:a62:15c3:0:b0:43d:e6be:156a with SMTP id 186-20020a6215c3000000b0043de6be156amr4403272pfv.1.1633007860790;
        Thu, 30 Sep 2021 06:17:40 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q3sm3083167pgf.18.2021.09.30.06.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:17:40 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 1/3] kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch optional
Date:   Thu, 30 Sep 2021 21:17:06 +0800
Message-Id: <20210930131708.35328-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930131708.35328-1-kernelfans@gmail.com>
References: <20210930131708.35328-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an IRQ is taken, some accounting needs to be performed to enter and
exit IRQ context around the IRQ handler. Historically arch code would
leave this to the irqchip or core IRQ code, but these days we want this
to happen in exception entry code, and architectures such as arm64 do
this.

Currently handle_domain_irq() performs this entry/exit accounting, and
if used on an architecture where the entry code also does this, the
entry/exit accounting will be performed twice per IRQ. This is
problematic as core RCU code such as rcu_is_cpu_rrupt_from_idle()
depends on this happening once per IRQ, and will not detect quescent
periods correctly, leading to stall warnings.

As irqchip drivers which use handle_domain_irq() need to work on
architectures with or without their own entry/exit accounting, this
patch makes handle_domain_irq() conditionally perform the entry
accounting depending on a new HAVE_ARCH_IRQENTRY Kconfig symbol that
architectures can select if they perform this entry accounting
themselves.

For architectures which do not select the symbol. there should be no
functional change as a result of this patch.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 kernel/irq/Kconfig   | 3 +++
 kernel/irq/irqdesc.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index fbc54c2a7f23..defa1db2d664 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -100,6 +100,9 @@ config IRQ_MSI_IOMMU
 config HANDLE_DOMAIN_IRQ
 	bool
 
+config HAVE_ARCH_IRQENTRY
+	bool
+
 config IRQ_TIMINGS
 	bool
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4e3c29bb603c..fd5dd9d278b5 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -693,7 +693,9 @@ int handle_domain_irq(struct irq_domain *domain,
 	struct irq_desc *desc;
 	int ret = 0;
 
+#ifndef CONFIG_HAVE_ARCH_IRQENTRY
 	irq_enter();
+#endif
 
 	/* The irqdomain code provides boundary checks */
 	desc = irq_resolve_mapping(domain, hwirq);
@@ -702,7 +704,9 @@ int handle_domain_irq(struct irq_domain *domain,
 	else
 		ret = -EINVAL;
 
+#ifndef CONFIG_HAVE_ARCH_IRQENTRY
 	irq_exit();
+#endif
 	set_irq_regs(old_regs);
 	return ret;
 }
-- 
2.31.1

