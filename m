Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1BA344C43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhCVQs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230345AbhCVQsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:48:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2136157F;
        Mon, 22 Mar 2021 16:48:35 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lONjG-0037Ov-5x; Mon, 22 Mar 2021 16:48:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        tabba@google.com, ardb@kernel.org, mark.rutland@arm.com,
        dbrazdil@google.com
Subject: [PATCH 1/3] KVM: arm64: Constraint KVM's own __flush_dcache_area to protectected mode
Date:   Mon, 22 Mar 2021 16:48:26 +0000
Message-Id: <20210322164828.800662-2-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322164828.800662-1-maz@kernel.org>
References: <20210322164828.800662-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: qperret@google.com, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org, mark.rutland@arm.com, dbrazdil@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to specialise KVM's version of __flush_dcache_area
via a hack opn the read_ctr macro, make sure that we won't ever
use KVM's copy of __flush_dcache_area(), as things would otherwise
break for late arriving CPUs.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/cache.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/cache.S b/arch/arm64/kvm/hyp/nvhe/cache.S
index 36cef6915428..1c177d3ec5c6 100644
--- a/arch/arm64/kvm/hyp/nvhe/cache.S
+++ b/arch/arm64/kvm/hyp/nvhe/cache.S
@@ -6,8 +6,12 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/alternative.h>
+#include <asm/asm-bug.h>
 
 SYM_FUNC_START_PI(__flush_dcache_area)
+alternative_if_not ARM64_KVM_PROTECTED_MODE
+	ASM_BUG()
+alternative_else_nop_endif
 	dcache_by_line_op civac, sy, x0, x1, x2, x3
 	ret
 SYM_FUNC_END_PI(__flush_dcache_area)
-- 
2.29.2

