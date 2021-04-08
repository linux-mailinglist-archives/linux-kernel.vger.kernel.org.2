Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09E2357B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhDHEF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHEFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:05:53 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA6C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:42 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z10so895979qkz.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Me+IJOmpVZMJE6OZITjjNJXxLybVS0PvpkZtNmZgu9s=;
        b=HrdrsH+/LJvmodXx6qJUKjxjbprurxBWQX7rF7YH/tot181AndUWuV7gbnA0UKrCI7
         P33v6LFzUMT/CxhdJRYj39gFLLn8Kl24eYKMWwa5ryYEp8ZR56p76Dx73+juO2TS5fmp
         03vZh8F/ou36y+EHeihspp1zs5O7FTxECJIbzCqeYzBohoD8eVUWtj5V6ci9q3xx7aO5
         65ZjTbwF8/uVodijBWQC1fYHP0gWkn7GLjbIKlV1CsDmRzTQV9JCjReAOMPviz5wlbsO
         gGMCoefM2xm2+wWIHCBHlGKMERalPbcFc8KYZkj4p3rp0rYMbNOKjl4AAZ7ZMZnf7Vwn
         dEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Me+IJOmpVZMJE6OZITjjNJXxLybVS0PvpkZtNmZgu9s=;
        b=gFc0ZaN4EOaLjSeLWubZHkToUmnFFgFDbBZKUow6iGDUDm5h9VH8IY4dYKJPld8ZyO
         w5bvdd1Uyj72AKP6lrPYzXRX9Pi+RFYAcfmjdxkgyMzn/3hGrJl7BBI0IlEZP+61FefW
         NFiptpmbwxX7oJwd72nwQIMebTBNCmPoxuHtCXW/fpWX/eZWQCCYAEGql4ICT8/kIjCC
         vj8KULQGKeJGtDSM5xIsxNg4OI+ceEXXV9NjTyVLXm16BxlXf1f6P1Of1I6NPUsWiQVT
         wS/pU931IEIB2EkQyKe18ml+EAduEiPy1ZG0ZFLZVCgpx6OeauGPy67WaZ/L8oRY6ajX
         nc2w==
X-Gm-Message-State: AOAM532Y7eX37cAWepQxT0xfKDzTsIgeIHWQEuQcRL8MU8dDw8yHjevm
        Ie4cJ2sGaMxbKabaJnnfLaGFaA==
X-Google-Smtp-Source: ABdhPJxYHvA6IkQyz8orCAuu/6NxJtk1GKdC6ouuVl2yzdNWDbtFSj8FFUMuYUgnnPsyTxVVAcEuTw==
X-Received: by 2002:a05:620a:10a6:: with SMTP id h6mr6649236qkk.366.1617854741843;
        Wed, 07 Apr 2021 21:05:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:41 -0700 (PDT)
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
Subject: [PATCH v13 02/18] arm64: hyp-stub: Move invalid vector entries into the vectors
Date:   Thu,  8 Apr 2021 00:05:21 -0400
Message-Id: <20210408040537.2703241-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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

