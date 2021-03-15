Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D432A33B1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCOL4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:56:50 -0400
Received: from foss.arm.com ([217.140.110.172]:35040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhCOL4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:56:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C096ED1;
        Mon, 15 Mar 2021 04:56:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 530F73F792;
        Mon, 15 Mar 2021 04:56:38 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com
Cc:     james.morse@arm.com, marcan@marcan.st, mark.rutland@arm.com,
        maz@kernel.org, tglx@linutronix.de
Subject: [PATCHv3 1/6] genirq: Allow architectures to override set_handle_irq() fallback
Date:   Mon, 15 Mar 2021 11:56:24 +0000
Message-Id: <20210315115629.57191-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210315115629.57191-1-mark.rutland@arm.com>
References: <20210315115629.57191-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

Some architectures want to provide the generic set_handle_irq() API, but
for structural reasons need to provide their own implementation. For
example, arm64 needs to do this to provide uniform set_handle_irq() and
set_handle_fiq() registration functions.

Make this possible by allowing architectures to provide their own
implementation of set_handle_irq when CONFIG_GENERIC_IRQ_MULTI_HANDLER
is not selected.

Signed-off-by: Marc Zyngier <maz@kernel.org>
[Mark: expand commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Hector Martin <marcan@marcan.st>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/irq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 2efde6a79b7e..9890180b84fd 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1258,11 +1258,13 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *));
  */
 extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
 #else
+#ifndef set_handle_irq
 #define set_handle_irq(handle_irq)		\
 	do {					\
 		(void)handle_irq;		\
 		WARN_ON(1);			\
 	} while (0)
 #endif
+#endif
 
 #endif /* _LINUX_IRQ_H */
-- 
2.11.0

