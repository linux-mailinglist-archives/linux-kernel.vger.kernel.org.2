Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2610841EFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354627AbhJAOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhJAOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:46:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264C8C06177C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:44:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j15so6443566plh.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ad+1NfwHnbLkN/4DhPh8YfoW0rtkGTB5w67G5jKzAqA=;
        b=m4AoOUSeWpSf+BmE/E5JE7QAW2tuRX2lPWbrPrr9rFDDwcu+fkJv5fHqWTYvkVAfS9
         nyDfJG623FAQ6TzwfPGjIphoAVqWn78S0YkkNvAAb+1PHVvRaSrBRQZfPHsu8FVIv1CT
         Q51DGGxE2xiabv82hDlYmW68H6KIgUrpAOdy2t7vnat5ZE/huyPGWCW0aiNpgFcIhtz+
         qpVWzBO7OuPd2gOHVDwoApKG/vpWkUXTbJm4K1epfsDsV/C7XecY0uYXOa2dkf827S0D
         AofPgMwSxn2N60kBaOsTOwv4iN7kHPH+41iT3sZ13QeDkVHt45byN15UmonuU2qzpvH3
         8P8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ad+1NfwHnbLkN/4DhPh8YfoW0rtkGTB5w67G5jKzAqA=;
        b=OBTpS+JbFj89qDbMfWh2z4bWtyLFsn4OLXyGbuzawldkBkao5nZSi5jXmSdYQ2s9Ws
         lBMywJsGedUYnXs5a7dLk+xU6na0+zacR32GBjRI7P6EssOYtwpMvaqt3wXBu28SEBr/
         XnvW0x1+ffEYbpdR684bqxVrsYraTlCqeRS6QO+A7RZiAd/U7O5PE6WesxmPzcPtlwjU
         ex+d79zzvIuar+NCGjoQJtKA2guKzHblQppwgRgcPfBtrbjAMB8SrvWt360MZZcaNc0m
         N4D0cYWAYQFNcrddqDIXEdmJ38f5doD+05wzaAWjNHSAx12UIqHV3HxlbiWTtbiairGT
         haaA==
X-Gm-Message-State: AOAM533JBbVR5WrYsTZ/4eLCdp7sYml7yp93JzXDMBBKkD3rRIz2ZTKJ
        bo428cY5X/KotTSdbeNyag==
X-Google-Smtp-Source: ABdhPJzRN0EOIHvRUOUv9bkTENMQoAeWuRf06FqsKjZbaWa0u8oeHc3rRZvzDN47mdSXjksUi2ampA==
X-Received: by 2002:a17:902:708c:b0:13e:b42:88b5 with SMTP id z12-20020a170902708c00b0013e0b4288b5mr9862002plk.4.1633099475725;
        Fri, 01 Oct 2021 07:44:35 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z12sm6766203pge.16.2021.10.01.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:44:35 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv4 3/3] arm64: entry: avoid double-accounting IRQ RCU entry
Date:   Fri,  1 Oct 2021 22:44:06 +0800
Message-Id: <20211001144406.7719-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001144406.7719-1-kernelfans@gmail.com>
References: <20211001144406.7719-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an IRQ is taken, some accounting needs to be performed to enter and
exit IRQ context around the IRQ handler. On arm64 some of this
accounting is performed by both the architecture code and the IRQ domain
code, resulting in calling rcu_irq_enter() twice per exception entry,
violating the expectations of the core RCU code, and resulting in
failing to identify quiescent periods correctly (e.g. in
rcu_is_cpu_rrupt_from_idle()).

To fix this, we must perform all the accounting from the architecture
code. We prevent the IRQ domain code from performing any accounting by
selecting HAVE_ARCH_IRQENTRY, and must call irq_enter_rcu() and
irq_exit_rcu() around invoking the root IRQ handler.

When we take a pNMI from a context with IRQs disabled, we'll perform the
necessary accounting as part of arm64_enter_nmi() and arm64_exit_nmi(),
and should only call irq_enter_rcu() and irq_exit_rcu() when we may have
taken a regular interrupt.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig               | 1 +
 arch/arm64/kernel/entry-common.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..c0ba052116b2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -144,6 +144,7 @@ config ARM64
 	select HAVE_ARCH_BITREVERSE
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_HUGE_VMAP
+	select HAVE_ARCH_IRQENTRY
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index fecf046f0708..af931e63dc59 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -428,7 +428,9 @@ static __always_inline void
 __el1_interrupt(struct pt_regs *regs, void (*handler)(struct pt_regs *))
 {
 	enter_from_kernel_mode(regs);
+	irq_enter_rcu();
 	do_interrupt_handler(regs, handler);
+	irq_exit_rcu();
 	/*
 	 * Note: thread_info::preempt_count includes both thread_info::count
 	 * and thread_info::need_resched, and is not equivalent to
@@ -666,7 +668,9 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
 	if (regs->pc & BIT(55))
 		arm64_apply_bp_hardening();
 
+	irq_enter_rcu();
 	do_interrupt_handler(regs, handler);
+	irq_exit_rcu();
 
 	exit_to_user_mode(regs);
 }
-- 
2.31.1

