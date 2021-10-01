Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01E741EFDC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354613AbhJAOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhJAOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:46:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B0C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:44:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h3so9613527pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cWLoh4CcvhLIKXy9j6hWHn1puHnoZvSz+6V1tIrhSk=;
        b=jGBO1kPiEkCfAudaL3etNmrp3gjNL3qsBweVkIofU89tW18TzvoiSUAiaPWarJRLMz
         A6cPqTQsUn7k4Al4RQvAf7rdf0wQoAw0W8XzUCIr0FY6+/I8ci3/hhlTApjP1dM4h9na
         RdsUYiG3ZBFIFSEuPVow7TkymiAZdl0pLgUgWPGQIPtWCOB7mP+21mMhU9lQBpYtvvMX
         tonSYx3WC3gegNhxuAdreIST1iNAem+eu/kjJeM31Vifk1hqd1bjCsdij8bAQbOUlicr
         wSlwMPx2Z6ys2Afi/uQTq/Nw9orxskCqcur+yulxwiUmXh1OOGGuO8R9oimaVal8bzB1
         4Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cWLoh4CcvhLIKXy9j6hWHn1puHnoZvSz+6V1tIrhSk=;
        b=muZ5brHfNpd/3+UnRT2Do1qADVXrpeNQwNGweznJPi/ZuiQfQhvNLaCxU2UfuAJIWr
         R5QdAKW3r6KjSMMVOmNfYzs/3tJZ3KFxNlNKyW6IC6cToTPbB2plByXJcVB5VhZS+gd2
         JTxdjDCQ7EEUxRze3froOzEy6il0kTLxcqedmhVGy4jpEBXr6qQ37HicwFyOlHdKm0pq
         QUswkxFr0csOm1YJghyc/CfAatr8FR+gN3ZiCcDruVWqpEaDdEq7dun/4mZzbiHn6Fn/
         +izVN2DXd6pKfRt9sJUUDBBtrhApXgx2K1QFZS+CJx2YjiTkdMpP+4iWEuxrs+5zebrl
         rz2A==
X-Gm-Message-State: AOAM531M+D1rsysbAsJN+Wfb9ATv5E6B8HhODg9riUnGFYw6YmVyFjJf
        Y1nKTEC8Iw6RE/DywvUi8w==
X-Google-Smtp-Source: ABdhPJx24OOV3ZqQlMByojYTh43s1pLePS+exuzWPuaH3WHdiqD6ybdgYQDqljGmDpWIvJO3lLvajw==
X-Received: by 2002:a63:9911:: with SMTP id d17mr10076864pge.111.1633099466389;
        Fri, 01 Oct 2021 07:44:26 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z12sm6766203pge.16.2021.10.01.07.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:44:26 -0700 (PDT)
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
Subject: [PATCHv4 1/3] kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch optional
Date:   Fri,  1 Oct 2021 22:44:04 +0800
Message-Id: <20211001144406.7719-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001144406.7719-1-kernelfans@gmail.com>
References: <20211001144406.7719-1-kernelfans@gmail.com>
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

