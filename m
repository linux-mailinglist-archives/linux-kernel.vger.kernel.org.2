Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8712441DAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351361AbhI3NTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350913AbhI3NTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:19:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A7AC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:17:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so6166748pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iq4X0g0bNv3iySMgE6XWInM1VJ3s/S3gRmcd7OQw2M0=;
        b=p/ixfUPW2sb4xybJnAWeBmWUyUUMy2u1gWtZsfWva68Uc1TRNXzFuG0cGRMduhsYVw
         MkpgnSBTD13whXV0B6kA4SAx3E+kAyGPyq2I7DQBD4i5MNBVMZSGXg6V/nb1BmKwReAa
         lkiOciPmGdDLSbe+AqLQpNbhXGHLGy32TltxGQZjPT0drVXYjrd8ba4jUHJk+70Hcffg
         CDusJp+uBXK71w2ziNCNaKMJKFbTZSnKoco0PDc6JbviYhsV1wiFEo6Qaul5NnW6Yl27
         DmY7arAtnTxHrOvuDQ9Xj3cM2+4pzNGnoAZDlBoGD4bewDbpp1hjBZEI1lk77CDgd+VQ
         gvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iq4X0g0bNv3iySMgE6XWInM1VJ3s/S3gRmcd7OQw2M0=;
        b=OFeVUyIeFFrqJbftWK2I79G2i/rrwL/2ItYjEIzc5gwU3+m842K5IBZ9a55yqwllmm
         HhXmbaaAmcAQWpNCFAnDVKqswoQ+Ml+jq2d1VdPzayGpGYT1hA0nKz6i9nTvPhSdkmzs
         0zKagDOe7/8bjDC3QEikTgaQhyasEJyMVChNHi0v+xdwPanocn+z7uoAkbDYChZMls+L
         KTyYoW6TiSruIKP82wSYXUTz88Sy7JfE3fgqarGqtatUAdor3WP3b7WsC/y0L2lRJFy5
         wj9SZXVCJt+s0srUJwvr2PBjiPsI/ZUgv8a3mVsOvyCgcZwMexwhR8Zl0M67nVOGdnh5
         hjYQ==
X-Gm-Message-State: AOAM533jX+/6WTOr8i0j1NyJa3HsKh54gkKJ3Xxcy+fiCIKS5I9//4xJ
        KGZ1WgOaeQCqr7JHx+awnQ==
X-Google-Smtp-Source: ABdhPJx+5fIXNU6NKWcbhaG2hsXLhuIGjjwcxQmCR2ctOpGFWoUy907StHbtq8LaCDzRe93yxFAhbQ==
X-Received: by 2002:a05:6a00:cd4:b0:44b:b523:4d7 with SMTP id b20-20020a056a000cd400b0044bb52304d7mr4320025pfv.72.1633007870535;
        Thu, 30 Sep 2021 06:17:50 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q3sm3083167pgf.18.2021.09.30.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:17:50 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 3/3] arm64/entry-common: supplement irq accounting
Date:   Thu, 30 Sep 2021 21:17:08 +0800
Message-Id: <20210930131708.35328-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930131708.35328-1-kernelfans@gmail.com>
References: <20210930131708.35328-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, the irq entry/exit accounting, which is performed by
handle_domain_irq(), overlaps with arm64 exception entry code somehow.

By supplementing irq accounting on arm64 exception entry code, the
accounting in handle_domain_irq() can be dropped totally by selecting
the macro HAVE_ARCH_IRQENTRY.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
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
 arch/arm64/Kconfig               | 1 +
 arch/arm64/kernel/entry-common.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..d29bae38a951 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -98,6 +98,7 @@ config ARM64
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
+	select HAVE_ARCH_IRQENTRY
 	select ARM_GIC
 	select AUDIT_ARCH_COMPAT_GENERIC
 	select ARM_GIC_V2M if PCI
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 5f1473319fb0..6d4dc3b3799f 100644
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
@@ -667,7 +669,9 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
 	if (regs->pc & BIT(55))
 		arm64_apply_bp_hardening();
 
+	irq_enter_rcu();
 	do_interrupt_handler(regs, handler);
+	irq_exit_rcu();
 
 	exit_to_user_mode(regs);
 }
-- 
2.31.1

