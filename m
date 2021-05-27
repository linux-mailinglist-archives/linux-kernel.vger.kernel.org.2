Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6D3931BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbhE0PHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbhE0PHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5536BC06138A
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:33 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o27so912005qkj.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l3SGBPbH3T8MZIM5VPxw+w4kFGUdmwAVrjo+9WKhb6A=;
        b=lKkn7FEbTutFu0AJibWJbh7gvLM6Up0Orzxu/3QynB6mWeF920eLv/nRIAjn0HTWbz
         kRhnM1FhPgEgKDcFLc0RU7+8HDyuVrDf1nOdQR+DxW+V/MU79MqDfiJMev3LvByNYJcG
         mosH1G9Mvi/NBnrEeQoBPbalZSrRc9viFcC8kFho3Oq48p2L9WDorq4FQts5PrzjhPvY
         PQXufesw6t3klHivvCa41fH7WyDUbQwQhgjcy69LGoTTy5HoW5rSaakGdTqk4RRi31+u
         qU/1ksTD7uZt2uZRkEseLan5+B9wF27wnlPJAwpkKXvmMj1unG3unZvMI0rv/GW8p4o1
         xqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3SGBPbH3T8MZIM5VPxw+w4kFGUdmwAVrjo+9WKhb6A=;
        b=W3VAbCdIQ9aWJAXQXUB3Gh01hZNkKBzLFq9FebMLMpAAgFBLIIfDWiOBUZoY4MHyBy
         qat+ZUHg1vkBVnq9+cP3L9BRzZGa99gNzAzGfFpx6SuoLDtcX/SDSoz4pyeopHIlxQTI
         1YFZG2USUy+IhgMJVImb7nmXe1R+ZhVF0ASHeYZOkT0bxq9D9pyONhon6lP+AzQotVIE
         IbOKTk6sXIN2fLBjz3eq/8Q9CGh65+LnvYwbLex3bE8VqcZ0Y9V4L5wBcX7Q9mG1s/Ui
         yEqZwcVCtSL5jRFdjkZcTN/euDDFRF4xKS7BCwiUUhWluvnxu3YFniuFUtiTSJE5ITsx
         +v5g==
X-Gm-Message-State: AOAM532NnL9GEvCUZQyf69dnS1RIUXWOmO4STT5vgn+uo0DSwP43e45K
        NOKx04b+bBrQGKC1v+maq19efw==
X-Google-Smtp-Source: ABdhPJxOofNUG3149CvRQe7xgHOAYxhjpmqWLXhWUL/moDKhXxMhTLFFTYyF/8yiB65KCQQlF0YIPQ==
X-Received: by 2002:a37:f909:: with SMTP id l9mr2053163qkj.428.1622127932312;
        Thu, 27 May 2021 08:05:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:31 -0700 (PDT)
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
Subject: [PATCH 02/18] arm64: hyp-stub: Move invalid vector entries into the vectors
Date:   Thu, 27 May 2021 11:05:10 -0400
Message-Id: <20210527150526.271941-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
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
 arch/arm64/kernel/hyp-stub.S | 62 +++++++++++++++---------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 91aab4121463..18a97bee3779 100644
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
-
-	ventry	elx_sync			// Synchronous EL2h
-	ventry	el2_irq_invalid			// IRQ EL2h
-	ventry	el2_fiq_invalid			// FIQ EL2h
-	ventry	el2_error_invalid		// Error EL2h
-
-	ventry	elx_sync			// Synchronous 64-bit EL1
-	ventry	el1_irq_invalid			// IRQ 64-bit EL1
-	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
-	ventry	el1_error_invalid		// Error 64-bit EL1
-
-	ventry	el1_sync_invalid		// Synchronous 32-bit EL1
-	ventry	el1_irq_invalid			// IRQ 32-bit EL1
-	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
-	ventry	el1_error_invalid		// Error 32-bit EL1
+	invalid_vector	hyp_stub_el2t_sync_invalid	// Synchronous EL2t
+	invalid_vector	hyp_stub_el2t_irq_invalid	// IRQ EL2t
+	invalid_vector	hyp_stub_el2t_fiq_invalid	// FIQ EL2t
+	invalid_vector	hyp_stub_el2t_error_invalid	// Error EL2t
+
+	ventry	elx_sync				// Synchronous EL2h
+	invalid_vector	hyp_stub_el2h_irq_invalid	// IRQ EL2h
+	invalid_vector	hyp_stub_el2h_fiq_invalid	// FIQ EL2h
+	invalid_vector	hyp_stub_el2h_error_invalid	// Error EL2h
+
+	ventry	elx_sync				// Synchronous 64-bit EL1
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
@@ -174,23 +181,6 @@ SYM_CODE_END(enter_vhe)
 
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

