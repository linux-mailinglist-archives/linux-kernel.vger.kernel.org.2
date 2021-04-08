Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCBA357B0F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhDHEGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhDHEFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:05:54 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523CC061761
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id n44so247820qvg.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ys4BurbzE8f3xOtcZckwDgg+eZ/2ibCIBaYK/PrLc5I=;
        b=juqdJ1+rPty+mZcJWzuSbk/vYifDHS3s3mojAmWOO+G3qlz7jgNSEEr4f0hG/M5Jpz
         aw5IKBcea62xB54/m6w+NyeqowI5FwwiwHyTaw6lq6VK5IRdOjzT1vIcWu1vBaBc9Dks
         LEMgkcImNq1vT7jsoJmB0yPzqkmdvjISYyHKlIglDEXSTmTN+bl3hCkpinJlw9owJSjZ
         Pt6Guc7V+JIgF6rOLn73KQv2wGXWNbNlCqzxYe7k45r8vnwcZ6SJRPIUBV6qpZjfCqPo
         bRG1IhRT2MZYsMPCE9cDpsb9zqKsMxgemCJo0vnGi5U5P+iz5i0DiYjYyDasJIOjkdUI
         XXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ys4BurbzE8f3xOtcZckwDgg+eZ/2ibCIBaYK/PrLc5I=;
        b=b3Shmu0hUD6/URRJvmn+mozovCUycR5PKONtrCXrXepgyi6mnnWyqQdgpxYmakimPN
         q5nQB8rGVya1k1O0UmCQnqSGxZ/leJ9T22uhHuwzDsprK5l2uM90fCU3p7SbAu4RLcHL
         vkn16TusV7Yogzj7XzIPhwJjG0lW8GBpO1leB7SCp3LKB3v20pFPc/W8sTRFbo3VagpO
         wo/cSThIga6JhmsFdbAjltZnsqxRGF6cIM/AYr50PHa/17dg/AWjXzBryQoGavSoRN4Y
         93Oe/suZQEUrsC7L0AdGaNgd0Pzdh5julJYKPoutV3X+A9IQVtE1YnoeZNJgFF7R/217
         gT/A==
X-Gm-Message-State: AOAM531x5lLRB3Ydfh18PJaL6OYq1fcuVfgbtY3STa9A4v5lR7AzfSDj
        QOnv4mrXkImnFVLeXFQVmQGG8A==
X-Google-Smtp-Source: ABdhPJwMb53rZZbQdfaU1akeMPvCbZqVXP8rhlkM/XM+uDXitGdEDxjjUj6mbyKR2RxS/SJppBRTmQ==
X-Received: by 2002:a0c:9e0f:: with SMTP id p15mr7047700qve.27.1617854743132;
        Wed, 07 Apr 2021 21:05:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:42 -0700 (PDT)
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
        kernelfans@gmail.com
Subject: [PATCH v13 03/18] arm64: hyp-stub: Move el1_sync into the vectors
Date:   Thu,  8 Apr 2021 00:05:22 -0400
Message-Id: <20210408040537.2703241-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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

