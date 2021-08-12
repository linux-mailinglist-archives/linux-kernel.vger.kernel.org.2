Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D03EAA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhHLTDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234899AbhHLTC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:02:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37728610CC;
        Thu, 12 Aug 2021 19:02:34 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mEFyK-004c9r-JU; Thu, 12 Aug 2021 20:02:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
Subject: [PATCH 2/5] arm64: Handle UNDEF in the EL2 stub vectors
Date:   Thu, 12 Aug 2021 20:02:10 +0100
Message-Id: <20210812190213.2601506-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812190213.2601506-1-maz@kernel.org>
References: <20210812190213.2601506-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, zajec5@gmail.com, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, ardb@kernel.org, f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we want to handle the silly case where HVC has been disabled
from EL3, augment our ability to handle exception at EL2.

Check for unknown exceptions (usually UNDEF) coming from EL2,
and treat them as a failing HVC call into the stubs. While
this isn't great and obviously doesn't catter for the gigantic
range of possible exceptions, it isn't any worse than what we
have today.

Just don't try and use it for anything else.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/hyp-stub.S | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 43d212618834..026a34515b21 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -46,7 +46,16 @@ SYM_CODE_END(__hyp_stub_vectors)
 	.align 11
 
 SYM_CODE_START_LOCAL(elx_sync)
-	cmp	x0, #HVC_SET_VECTORS
+	mrs	x4, spsr_el2
+	and	x4, x4, #PSR_MODE_MASK
+	orr	x4, x4, #1
+	cmp	x4, #PSR_MODE_EL2h
+	b.ne	0f
+	mrs	x4, esr_el2
+	eor	x4, x4, #ESR_ELx_IL
+	cbz	x4, el2_undef
+
+0:	cmp	x0, #HVC_SET_VECTORS
 	b.ne	1f
 	msr	vbar_el2, x1
 	b	9f
@@ -71,6 +80,14 @@ SYM_CODE_START_LOCAL(elx_sync)
 
 9:	mov	x0, xzr
 	eret
+
+el2_undef:
+	// Assumes this was a HVC that went really wrong...
+	mrs	x0, elr_el2
+	add	x0, x0, #4
+	msr	elr_el2, x0
+	mov_q	x0, HVC_STUB_ERR
+	eret
 SYM_CODE_END(elx_sync)
 
 // nVHE? No way! Give me the real thing!
-- 
2.30.2

