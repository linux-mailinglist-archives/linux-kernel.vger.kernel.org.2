Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A432B733
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383255AbhCCKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbhCCAYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:24:31 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE082C06121D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:37 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id a9so7781734qkn.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ys4BurbzE8f3xOtcZckwDgg+eZ/2ibCIBaYK/PrLc5I=;
        b=dcWduAuTpEnsZ23w4q/nGHITQ9VeRVbopJtAQolCLmSGYvvi8NkPc5iT5pqOtLEI+X
         /sN64YP6ApTGMwT4gN0aCuIbX2Wf5v4YZFTXQwBOPHm5src59LNHJDHloF+tQBkzuW6H
         W24eGwHiIzWRAaystxYlL0kVLtHGNHklPZtuwO+YFXmkTv8YCN+qaNaRdJ574xHDHN7n
         Xl5EbudHJckK44CfwjCJvtC80arwVKn0HT4+PXXkI8IRd+qhia0D+KE2nv8hEhlvqYWx
         osSeISMrNU39E2zAoOMWs+dLxNpFl9AVxtMy9JdcplGBSucizAVfKfRAnp8EPZLiGRQv
         reLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ys4BurbzE8f3xOtcZckwDgg+eZ/2ibCIBaYK/PrLc5I=;
        b=JoAZiXJOEC1wEJ4P+k6nymD6eRmyy5TlYaie7qSaauJ/86tOrnKwyGDKuhAmdwuFL9
         z4mM9KB+vVHQAKckXnXzmBhfzMiBpdZO1cra2L8KjU4SupY8rH5RUcH+zFaK7F2hZU7w
         41q06420vMm+KZKpHtklJO4DHEZ5B4AWrllIjV5wI/aEABPt8OsvO6oK225uhJz5MsNH
         W0av3hrIJoudi3RsWR/OXWd0g2C7BJfUiRLgIC/8t+iVsn9nVQN/vzNlB7xQe6aPEHhD
         aMNflRoQrR0nx9HYJBBHXUSVpbTbtilqZ/5iYLnLsC4T9EjnPYYmLf7NNE10mkOtyzuE
         21Og==
X-Gm-Message-State: AOAM533qaP1C1c8o1ZydEd4Dg1VLaa2lrkG0A6owG4SR7W+nREfCVAMp
        ZfsTPH/QTyc7Owb38bfs6zdP8Q==
X-Google-Smtp-Source: ABdhPJy9cSXd6XyxnY9AZClyXZ4f6veKnYkkla2SRvqY4v7p7SiG4DwUFuL6Yj3oldPgCXfdo+UiPw==
X-Received: by 2002:a05:620a:c0e:: with SMTP id l14mr13557520qki.91.1614730957001;
        Tue, 02 Mar 2021 16:22:37 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:36 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v12 03/17] arm64: hyp-stub: Move el1_sync into the vectors
Date:   Tue,  2 Mar 2021 19:22:16 -0500
Message-Id: <20210303002230.1083176-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

The hyp-stub's el1_sync code doesn't do very much, this can easily fit
in the vectors.

With this, all of the hyp-stubs behaviour is contained in its vectors.
This lets kexec and hibernate copy the hyp-stub when they need its
behaviour, instead of re-implementing it.

Signed-off-by: James Morse <james.morse@arm.com>

[Fixed merging issues]

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hyp-stub.S | 59 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index ff329c5c074d..d1a73d0f74e0 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -21,6 +21,34 @@ SYM_CODE_START_LOCAL(\label)
 	.align 7
 	b	\label
 SYM_CODE_END(\label)
+.endm
+
+.macro hyp_stub_el1_sync
+SYM_CODE_START_LOCAL(hyp_stub_el1_sync)
+	.align 7
+	cmp	x0, #HVC_SET_VECTORS
+	b.ne	2f
+	msr	vbar_el2, x1
+	b	9f
+
+2:	cmp	x0, #HVC_SOFT_RESTART
+	b.ne	3f
+	mov	x0, x2
+	mov	x2, x4
+	mov	x4, x1
+	mov	x1, x3
+	br	x4				// no return
+
+3:	cmp	x0, #HVC_RESET_VECTORS
+	beq	9f				// Nothing to reset!
+
+	/* Someone called kvm_call_hyp() against the hyp-stub... */
+	mov_q	x0, HVC_STUB_ERR
+	eret
+
+9:	mov	x0, xzr
+	eret
+SYM_CODE_END(hyp_stub_el1_sync)
 .endm
 
 	.text
@@ -39,7 +67,7 @@ SYM_CODE_START(__hyp_stub_vectors)
 	invalid_vector	hyp_stub_el2h_fiq_invalid	// FIQ EL2h
 	invalid_vector	hyp_stub_el2h_error_invalid	// Error EL2h
 
-	ventry	el1_sync			// Synchronous 64-bit EL1
+	hyp_stub_el1_sync				// Synchronous 64-bit EL1
 	invalid_vector	hyp_stub_el1_irq_invalid	// IRQ 64-bit EL1
 	invalid_vector	hyp_stub_el1_fiq_invalid	// FIQ 64-bit EL1
 	invalid_vector	hyp_stub_el1_error_invalid	// Error 64-bit EL1
@@ -55,35 +83,6 @@ SYM_CODE_END(__hyp_stub_vectors)
 # Check the __hyp_stub_vectors didn't overflow
 .org . - (__hyp_stub_vectors_end - __hyp_stub_vectors) + SZ_2K
 
-
-SYM_CODE_START_LOCAL(el1_sync)
-	cmp	x0, #HVC_SET_VECTORS
-	b.ne	1f
-	msr	vbar_el2, x1
-	b	9f
-
-1:	cmp	x0, #HVC_VHE_RESTART
-	b.eq	mutate_to_vhe
-
-2:	cmp	x0, #HVC_SOFT_RESTART
-	b.ne	3f
-	mov	x0, x2
-	mov	x2, x4
-	mov	x4, x1
-	mov	x1, x3
-	br	x4				// no return
-
-3:	cmp	x0, #HVC_RESET_VECTORS
-	beq	9f				// Nothing to reset!
-
-	/* Someone called kvm_call_hyp() against the hyp-stub... */
-	mov_q	x0, HVC_STUB_ERR
-	eret
-
-9:	mov	x0, xzr
-	eret
-SYM_CODE_END(el1_sync)
-
 // nVHE? No way! Give me the real thing!
 SYM_CODE_START_LOCAL(mutate_to_vhe)
 	// Sanity check: MMU *must* be off
-- 
2.25.1

