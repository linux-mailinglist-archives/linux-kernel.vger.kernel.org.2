Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C43931C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbhE0PIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbhE0PHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:21 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8C8C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:43 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h24so398499qtm.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I6lkOzPEa6syzQf8r+RZ8XuPpKpclGEbIUwShbrK82U=;
        b=TnnFfUUvHvEm/etkMIl6FavDDCjxG9hxxxgfKcLeF7n8pbKBfizh0PVGR9SMdhavpQ
         /qaXI18/FRxFUfElEb2Mw/gUsiyEEVcvLvMB17wq4wMBqThZ8ZW1wxboXPji+jtFXAzA
         dmFznHFw0mFTEWzs07I5Or3POBDkvY2Li5BAWGSV9TlzSh3tpEA7QozmVmOde0tdRNWJ
         Ho9DhH92QuT2QsQkhMfXBenFVxdWr5De+0nSVKKvmbALAiuom+VmBP2Ocl+xIXaospwh
         fhvqjPCz2kafZH+AeYAvRnXpZ979KsJEGkCMNPqV9/MZKUUhRoCgzAp927vHfgXWTBlK
         QONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6lkOzPEa6syzQf8r+RZ8XuPpKpclGEbIUwShbrK82U=;
        b=SkuICPIqP/LV1Fotb6f8sGNlb2ZoMu+lY9TKBANTrCFlet9/aQSXC3WgQU6ic2bnPj
         xzlmpLWBKgg7JKVlD/swwK5fqmuNe+rU06fK36UDuuul/aRQ34y/VMGzVne6TPu0+1UD
         sx2LeiFchwEpoSXTvqoC6PZJ4iWUWULE0wcpH3X/NiQ+JN5Q2ZrfaAK65ZybR6+4YmKc
         F64uKH72A8jvURBoFaTqqNGg8NGcq5Pog5+DjCc1QZic19bet7wXYODWQlEAeicBeG1W
         8NoEChSPiS5FpyF3RWRBzJdYhZfS4Q0oDoLKOdDV7y0AkieXI03vhyq4e2gyB7PtoPrx
         W19g==
X-Gm-Message-State: AOAM532zXeMdIB6zsrZzrLh5G/xY9Y0sQ3RvxIkko60tFVGgMq9qrLD+
        viGp4xzd25VCUYas95Q1XCaPAw==
X-Google-Smtp-Source: ABdhPJyswzPAqJ6yfkg4N9Ue8mJrxUt1+TgPxwsNMw1UD8Ns1Nxidx0p88Kxuz6WsVPrCUipNJJJbg==
X-Received: by 2002:ac8:5e98:: with SMTP id r24mr3491247qtx.25.1622127942481;
        Thu, 27 May 2021 08:05:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:42 -0700 (PDT)
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
Subject: [PATCH 09/18] arm64: kexec: Use dcache ops macros instead of open-coding
Date:   Thu, 27 May 2021 11:05:17 -0400
Message-Id: <20210527150526.271941-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

kexec does dcache maintenance when it re-writes all memory. Our
dcache_by_line_op macro depends on reading the sanitised DminLine
from memory. Kexec may have overwritten this, so open-codes the
sequence.

dcache_by_line_op is a whole set of macros, it uses dcache_line_size
which uses read_ctr for the sanitsed DminLine. Reading the DminLine
is the first thing the dcache_by_line_op does.

Rename dcache_by_line_op dcache_by_myline_op and take DminLine as
an argument. Kexec can now use the slightly smaller macro.

This makes up-coming changes to the dcache maintenance easier on
the eye.

Code generated by the existing callers is unchanged.

Signed-off-by: James Morse <james.morse@arm.com>

[Fixed merging issues]

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/assembler.h  | 12 ++++++++----
 arch/arm64/kernel/relocate_kernel.S | 13 +++----------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 8418c1bd8f04..f1367863d995 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -393,10 +393,9 @@ alternative_else
 alternative_endif
 	.endm
 
-	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
-	dcache_line_size \tmp1, \tmp2
+	.macro dcache_by_myline_op op, domain, kaddr, size, linesz, tmp2
 	add	\size, \kaddr, \size
-	sub	\tmp2, \tmp1, #1
+	sub	\tmp2, \linesz, #1
 	bic	\kaddr, \kaddr, \tmp2
 9998:
 	.ifc	\op, cvau
@@ -416,12 +415,17 @@ alternative_endif
 	.endif
 	.endif
 	.endif
-	add	\kaddr, \kaddr, \tmp1
+	add	\kaddr, \kaddr, \linesz
 	cmp	\kaddr, \size
 	b.lo	9998b
 	dsb	\domain
 	.endm
 
+	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
+	dcache_line_size \tmp1, \tmp2
+	dcache_by_myline_op \op, \domain, \kaddr, \size, \tmp1, \tmp2
+	.endm
+
 /*
  * Macro to perform an instruction cache maintenance for the interval
  * [start, end)
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 8058fabe0a76..718037bef560 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -41,16 +41,9 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
 
 	/* Invalidate dest page to PoC. */
-	mov     x2, x13
-	add     x20, x2, #PAGE_SIZE
-	sub     x1, x15, #1
-	bic     x2, x2, x1
-2:	dc      ivac, x2
-	add     x2, x2, x15
-	cmp     x2, x20
-	b.lo    2b
-	dsb     sy
-
+	mov	x2, x13
+	mov	x1, #PAGE_SIZE
+	dcache_by_myline_op ivac, sy, x2, x1, x15, x20
 	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
 	b	.Lnext
 .Ltest_indirection:
-- 
2.25.1

