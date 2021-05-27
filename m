Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D263931B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhE0PHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbhE0PHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCEFC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id k19so439689qta.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Dd4OYNLmvVEa/N4zByXvuOh+6Xq8z1RHPtKQnceMU+s=;
        b=PAy8oUO7YX8LhrT2i2a4coviv4EjGLjt9zdp4yLK7smhcEYSnOPuWxth8pQ2sJKm+p
         2jg8Z8xa3QAfUFb6YPB7i6dNFCgjUSpCNNTF4y2TBPfNZI+7cCG57PyzHQ9Of9f20W6B
         R7bkFVD0/i3hf1SwqNdYQsnQuKcFwRo7leOcm3+FWAqSlbSv3tKKbTWkEpxfIENLQcP7
         Avke/bt4sGbmFGea4UxrsFvQiaqrhp1VhY7VKD6d9SVV7vKuSzxZ9sKf4SCTFCA3py1E
         o37jHAYoXineM+R2Or5/XjDQtnkuW/wiU2rUyJdY25VcLfzBGnauKIoXd+B4KclFdTl7
         0iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dd4OYNLmvVEa/N4zByXvuOh+6Xq8z1RHPtKQnceMU+s=;
        b=W8KUo0zmFE6ybnkoTMTjlwa+xN5QESEPX8YPZMJksTQNABizABp1r1GrlpUUSRmQXh
         9eFOL0tnZDCdOxWswfWRhFKDb5a5dGJIZewHgzrHrilDwIJYqu++8UcXc7Ggk3xAXcZ5
         9dbzmSvEPqRI1bKqASVrvfsM7vitKjQcV1b9JTbV2XABwJB+q4hly9U34t8en/M8Uu9q
         PEi2UeueOvRorItBYUfK1tvGLO6cj8OiquHHLjPYXkcg/L24d7BIAb05gHwDHd5AT2aB
         GW8m3JzLLHOOslyzX/my4cXIWnUJBxZCaZ0RY96tA7RHknljqaUQIJ6AF1In1RgUKAUu
         gAfw==
X-Gm-Message-State: AOAM531Bq1zSYYKWd1YcsbxRHG3pL94EVLW73msys+SjWcWM3CRCoTR4
        lgPEC8Trro0xUzWR7oYpi2S5Cg==
X-Google-Smtp-Source: ABdhPJxtuOVFOKAsCuiHh9cOyHIEi9No+IlR64k2qAMP9VTvqHYTpO1ydEtOEgxg9B4D+CYuBIBhhQ==
X-Received: by 2002:ac8:74c2:: with SMTP id j2mr3522136qtr.185.1622127933716;
        Thu, 27 May 2021 08:05:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:33 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: [PATCH 03/18] arm64: hyp-stub: Move elx_sync into the vectors
Date:   Thu, 27 May 2021 11:05:11 -0400
Message-Id: <20210527150526.271941-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hyp-stub's elx_sync code fits in the vector.

With this, all of the hyp-stubs behaviour is contained in its vectors.
This lets kexec and hibernate copy the hyp-stub when they need its
behaviour, instead of re-implementing it.

Co-developed-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hyp-stub.S | 64 +++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 18a97bee3779..86af6c4e52b9 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -21,6 +21,37 @@ SYM_CODE_START_LOCAL(\label)
 	.align 7
 	b	\label
 SYM_CODE_END(\label)
+.endm
+
+.macro elx_sync_vector	label
+SYM_CODE_START_LOCAL(\label)
+	.align 7
+	cmp	x0, #HVC_SET_VECTORS
+	b.ne	1f
+	msr	vbar_el2, x1
+	b	9f
+
+1:	cmp	x0, #HVC_VHE_RESTART
+	b.eq	mutate_to_vhe
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
+SYM_CODE_END(\label)
 .endm
 
 	.text
@@ -34,12 +65,12 @@ SYM_CODE_START(__hyp_stub_vectors)
 	invalid_vector	hyp_stub_el2t_fiq_invalid	// FIQ EL2t
 	invalid_vector	hyp_stub_el2t_error_invalid	// Error EL2t
 
-	ventry	elx_sync				// Synchronous EL2h
+	elx_sync_vector	el2h_sync			// Synchronous EL2h
 	invalid_vector	hyp_stub_el2h_irq_invalid	// IRQ EL2h
 	invalid_vector	hyp_stub_el2h_fiq_invalid	// FIQ EL2h
 	invalid_vector	hyp_stub_el2h_error_invalid	// Error EL2h
 
-	ventry	elx_sync				// Synchronous 64-bit EL1
+	elx_sync_vector	el1_sync			// Synchronous 64-bit EL1
 	invalid_vector	hyp_stub_el1_irq_invalid	// IRQ 64-bit EL1
 	invalid_vector	hyp_stub_el1_fiq_invalid	// FIQ 64-bit EL1
 	invalid_vector	hyp_stub_el1_error_invalid	// Error 64-bit EL1
@@ -55,35 +86,6 @@ SYM_CODE_END(__hyp_stub_vectors)
 # Check the __hyp_stub_vectors didn't overflow
 .org . - (__hyp_stub_vectors_end - __hyp_stub_vectors) + SZ_2K
 
-
-SYM_CODE_START_LOCAL(elx_sync)
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
-SYM_CODE_END(elx_sync)
-
 // nVHE? No way! Give me the real thing!
 SYM_CODE_START_LOCAL(mutate_to_vhe)
 	// Sanity check: MMU *must* be off
-- 
2.25.1

