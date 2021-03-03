Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95332B730
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383132AbhCCKuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbhCCAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:24:01 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC37C061356
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:36 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o1so11849687qta.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Me+IJOmpVZMJE6OZITjjNJXxLybVS0PvpkZtNmZgu9s=;
        b=TexeuK1LzjZUxl+qx3qQULwT87vQYc1MD6Bj68BOVjP3cGLOT2rRwv1i74chPgGfYO
         UbwIjulEE5WjuUopzaIzxJPEuV7hmvshndmHJBpW/eW8BnrLt1Cr+b2u4gSWJdSJ3OGP
         JwY+w0YB4TdGP9WGlGzIaL5gqIKtQQYXEyCZUEkKWc4+LfQjREDeMeDJf799nFNdtcYa
         3loS2FGH6MBJ5vfpVkn8MnukQ54Se5vlVbHC6yPt9D67uZmJrJJh8vJDHEUtq80ftZPG
         l026k6HCjmsCE6HHevk/8lCVPEc5jzpfn6+0cF6QpQLBswS06CStNq8tM/bnGM6z0lET
         sIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Me+IJOmpVZMJE6OZITjjNJXxLybVS0PvpkZtNmZgu9s=;
        b=flyMOKbCx0yXmTcDm2Vu5IDhk8CF4zZhlrWfu2OKJ/J2e943T5jZ+WSG4TjYXjtTk0
         frdza5hZvKZeDjOAwgP40LYGuQKk5RjqpxHhRP8vdReQI7EJBLJ7M2t+ZHT5Vem9aasY
         jkazbbx/xt+v6FMh7p+3UyRlDwFq1k+VVwrUcifO5H9Kr9fgVyMvZT0wBkU+rCqDy/EO
         z1f5sP7yVXT1MPIvDd41VneRgB4jzBysfqHquLyUKTs8tojB7jVHOzAf4LWAI8YF96Pj
         4lnPRpUSEncMLFvRSs0z59ZkNJximhzGhYE18XMl/ICeWjwAM0eyo5u20VygrXydqg9G
         XfuA==
X-Gm-Message-State: AOAM533LmrlXvoY72irDgV6I5Rqp51xVZb12iHJCiV7u2JQt7+96dEmb
        1EYC4c7ZS/UudI62eunTdDLHjA==
X-Google-Smtp-Source: ABdhPJwug5BfAFqjtQc6bxUz5+jervNuBn1c/vyjkzVFvBEuDqyurtMGznEMcQrgeoHuudD6UVUuOA==
X-Received: by 2002:ac8:544:: with SMTP id c4mr20060173qth.245.1614730955693;
        Tue, 02 Mar 2021 16:22:35 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:35 -0800 (PST)
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
Subject: [PATCH v12 02/17] arm64: hyp-stub: Move invalid vector entries into the vectors
Date:   Tue,  2 Mar 2021 19:22:15 -0500
Message-Id: <20210303002230.1083176-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

Most of the hyp-stub's vector entries are invalid. These are each
a unique function that branches to itself. To move these into the
vectors, merge the ventry and invalid_vector macros and give each
one a unique name.

This means we can copy the hyp-stub as it is self contained within
its vectors.

Signed-off-by: James Morse <james.morse@arm.com>

[Fixed merging issues]

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hyp-stub.S | 56 +++++++++++++++---------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 572b28646005..ff329c5c074d 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -16,31 +16,38 @@
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
+.macro invalid_vector	label
+SYM_CODE_START_LOCAL(\label)
+	.align 7
+	b	\label
+SYM_CODE_END(\label)
+.endm
+
 	.text
 	.pushsection	.hyp.text, "ax"
 
 	.align 11
 
 SYM_CODE_START(__hyp_stub_vectors)
-	ventry	el2_sync_invalid		// Synchronous EL2t
-	ventry	el2_irq_invalid			// IRQ EL2t
-	ventry	el2_fiq_invalid			// FIQ EL2t
-	ventry	el2_error_invalid		// Error EL2t
+	invalid_vector	hyp_stub_el2t_sync_invalid	// Synchronous EL2t
+	invalid_vector	hyp_stub_el2t_irq_invalid	// IRQ EL2t
+	invalid_vector	hyp_stub_el2t_fiq_invalid	// FIQ EL2t
+	invalid_vector	hyp_stub_el2t_error_invalid	// Error EL2t
 
-	ventry	el2_sync_invalid		// Synchronous EL2h
-	ventry	el2_irq_invalid			// IRQ EL2h
-	ventry	el2_fiq_invalid			// FIQ EL2h
-	ventry	el2_error_invalid		// Error EL2h
+	invalid_vector	hyp_stub_el2h_sync_invalid	// Synchronous EL2h
+	invalid_vector	hyp_stub_el2h_irq_invalid	// IRQ EL2h
+	invalid_vector	hyp_stub_el2h_fiq_invalid	// FIQ EL2h
+	invalid_vector	hyp_stub_el2h_error_invalid	// Error EL2h
 
 	ventry	el1_sync			// Synchronous 64-bit EL1
-	ventry	el1_irq_invalid			// IRQ 64-bit EL1
-	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
-	ventry	el1_error_invalid		// Error 64-bit EL1
-
-	ventry	el1_sync_invalid		// Synchronous 32-bit EL1
-	ventry	el1_irq_invalid			// IRQ 32-bit EL1
-	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
-	ventry	el1_error_invalid		// Error 32-bit EL1
+	invalid_vector	hyp_stub_el1_irq_invalid	// IRQ 64-bit EL1
+	invalid_vector	hyp_stub_el1_fiq_invalid	// FIQ 64-bit EL1
+	invalid_vector	hyp_stub_el1_error_invalid	// Error 64-bit EL1
+
+	invalid_vector	hyp_stub_32b_el1_sync_invalid	// Synchronous 32-bit EL1
+	invalid_vector	hyp_stub_32b_el1_irq_invalid	// IRQ 32-bit EL1
+	invalid_vector	hyp_stub_32b_el1_fiq_invalid	// FIQ 32-bit EL1
+	invalid_vector	hyp_stub_32b_el1_error_invalid	// Error 32-bit EL1
 	.align 11
 SYM_INNER_LABEL(__hyp_stub_vectors_end, SYM_L_LOCAL)
 SYM_CODE_END(__hyp_stub_vectors)
@@ -173,23 +180,6 @@ SYM_CODE_END(enter_vhe)
 
 	.popsection
 
-.macro invalid_vector	label
-SYM_CODE_START_LOCAL(\label)
-	b \label
-SYM_CODE_END(\label)
-.endm
-
-	invalid_vector	el2_sync_invalid
-	invalid_vector	el2_irq_invalid
-	invalid_vector	el2_fiq_invalid
-	invalid_vector	el2_error_invalid
-	invalid_vector	el1_sync_invalid
-	invalid_vector	el1_irq_invalid
-	invalid_vector	el1_fiq_invalid
-	invalid_vector	el1_error_invalid
-
-	.popsection
-
 /*
  * __hyp_set_vectors: Call this after boot to set the initial hypervisor
  * vectors as part of hypervisor installation.  On an SMP system, this should
-- 
2.25.1

