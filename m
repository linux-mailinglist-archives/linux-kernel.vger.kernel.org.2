Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E588C3CF675
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhGTIQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhGTIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:12:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7F1C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:53:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c15so11095942pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=iZ11XlQ/7LpvSWqpfLjYjm5v/1yKJ1MGXqTuOdCwXh4=;
        b=Sd2kIfTvXXfKi0494oKwDhzLl9t6+qHQ0y9S6DpyTVWMiJ20Mr8LG2sRSNXFo+aPax
         EBmAJ22daE/xFihfPX1dqF4A6Av6BMFF2M1mML3NzEMu88A9cV6eyMBSoZjVUT3YkKSb
         lfcKRx51h3aanM7YhezfUXC9JU+DEv1v9K4s8/dLB1TsEtFBoUq5ItmLuCAW7C35c3kB
         YLd3i8+Kr4EdAl/OHnIFSpV1mx4TDXrYpzhwE1ICm8ZPvrhgm0tB+ZoxHDGTyxKbU1Eb
         LS36UzpBcXKte4R6z8sH+i5WjiS8Jous+gXC5HFWlRbmBC15tx3S4MBOOdZQXUUoGCJa
         WapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZ11XlQ/7LpvSWqpfLjYjm5v/1yKJ1MGXqTuOdCwXh4=;
        b=ugSN1M7js5kLMV6IQqWRFzoxt4dfxQjQV9insTK1TRfkpHKEKLab1y+A9dE0IJi6JY
         TKbkuKeq3V1h8Yv1DXKgQSP2WfKxZ/jblVJn0GXwrVQH/+vbbMPq6uNAJLYf2bz1Oory
         3vPSSoIOCU9Wv7F6anoCKjDFIZsppzKkgt9i0NtWA2KmXgBxg8yROGP8Q1Z9Lex6GN/0
         rzZA5rPAnt+0R3iHSadEFWt0MXu5nekEtFcKTdPsxT3VarpleGdmRtxfcksQhHTCvX8n
         2MArBkw+/YjQBp6qjRHoH8RCOrxc1P8c3WyZf4hx/+fZ9oc9W4AyvJQXE6w5Uv99B5Gj
         waAw==
X-Gm-Message-State: AOAM531aU1k9fhVn0GE2FqU0C8o4Iy/RgnJklDDdLlo1ea0vx3CehhgM
        NTg/gTJKFimQoe/V8W51GivggYKWwTU=
X-Google-Smtp-Source: ABdhPJwOvzonlcX/HWjjXzujzIEk+xCMC3woFJ4KKx1NW8wFFacD8C/pXaILCf05nRSjHuiVCUuhRA==
X-Received: by 2002:a17:90b:1d84:: with SMTP id pf4mr28729285pjb.166.1626771208547;
        Tue, 20 Jul 2021 01:53:28 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id z15sm25461191pgc.13.2021.07.20.01.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 01:53:28 -0700 (PDT)
Subject: [PATCH 4/4] riscv: __asm_copy_to-from_user: Fix: Typos in comments
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <23960a08-22aa-c0dd-57aa-80e73d6859ab@gmail.com>
Date:   Tue, 20 Jul 2021 17:53:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixing typos and grammar mistakes and using more intuitive label
name.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 54d497a03164..63bc691cff91 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -33,19 +33,20 @@ ENTRY(__asm_copy_from_user)
 
 	/*
 	 * Use byte copy only if too small.
+	 * SZREG holds 4 for RV32 and 8 for RV64
 	 */
 	li	a3, 9*SZREG /* size must be larger than size in word_copy */
 	bltu	a2, a3, .Lbyte_copy_tail
 
 	/*
-	 * Copy first bytes until dst is align to word boundary.
+	 * Copy first bytes until dst is aligned to word boundary.
 	 * a0 - start of dst
 	 * t1 - start of aligned dst
 	 */
 	addi	t1, a0, SZREG-1
 	andi	t1, t1, ~(SZREG-1)
 	/* dst is already aligned, skip */
-	beq	a0, t1, .Lskip_first_bytes
+	beq	a0, t1, .Lskip_align_dst
 1:
 	/* a5 - one byte for copying data */
 	fixup lb      a5, 0(a1), 10f
@@ -54,7 +55,7 @@ ENTRY(__asm_copy_from_user)
 	addi	a0, a0, 1	/* dst */
 	bltu	a0, t1, 1b	/* t1 - start of aligned dst */
 
-.Lskip_first_bytes:
+.Lskip_align_dst:
 	/*
 	 * Now dst is aligned.
 	 * Use shift-copy if src is misaligned.
@@ -71,7 +72,6 @@ ENTRY(__asm_copy_from_user)
 	 *
 	 * a0 - start of aligned dst
 	 * a1 - start of aligned src
-	 * a3 - a1 & mask:(SZREG-1)
 	 * t0 - end of aligned dst
 	 */
 	addi	t0, t0, -(8*SZREG) /* not to over run */
@@ -106,7 +106,7 @@ ENTRY(__asm_copy_from_user)
 	 * For misaligned copy we still perform aligned word copy, but
 	 * we need to use the value fetched from the previous iteration and
 	 * do some shifts.
-	 * This is safe because reading less than a word size.
+	 * This is safe because reading is less than a word size.
 	 *
 	 * a0 - start of aligned dst
 	 * a1 - start of src
@@ -116,7 +116,7 @@ ENTRY(__asm_copy_from_user)
 	 */
 	/* calculating aligned word boundary for dst */
 	andi	t1, t0, ~(SZREG-1)
-	/* Converting unaligned src to aligned arc */
+	/* Converting unaligned src to aligned src */
 	andi	a1, a1, ~(SZREG-1)
 
 	/*
@@ -128,7 +128,7 @@ ENTRY(__asm_copy_from_user)
 	li	a5, SZREG*8
 	sub	t4, a5, t3
 
-	/* Load the first word to combine with seceond word */
+	/* Load the first word to combine with second word */
 	fixup REG_L   a5, 0(a1), 10f
 
 3:
@@ -160,7 +160,7 @@ ENTRY(__asm_copy_from_user)
 	 * a1 - start of remaining src
 	 * t0 - end of remaining dst
 	 */
-	bgeu	a0, t0, 5f
+	bgeu	a0, t0, .Lout_copy_user  /* check if end of copy */
 4:
 	fixup lb      a5, 0(a1), 10f
 	addi	a1, a1, 1	/* src */
@@ -168,7 +168,7 @@ ENTRY(__asm_copy_from_user)
 	addi	a0, a0, 1	/* dst */
 	bltu	a0, t0, 4b	/* t0 - end of dst */
 
-5:
+.Lout_copy_user:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
 	li	a0, 0
-- 
2.17.1

