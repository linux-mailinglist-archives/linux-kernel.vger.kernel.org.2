Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565DC3AD9DC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhFSLkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 07:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhFSLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:40:02 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E382C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:37:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e20so10123607pgg.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vXLVQsXj6FC6nXeevSc8Ao3YS/Kg37+h24F/TyUkG4c=;
        b=FpmHzw9ecJn1mlRFA0MovE301HRBZjiQTpyNM4UrqH7L1sr0MtHSIs4gMoYM64SXkN
         ugIN3cXt0xSYfsWzTvL5SwsrQYTMxx9cuwqlHUJcMObsfHC2PTn+0nUg8bLC9LLah8/h
         jd5vM7Rr/yd6x1nrtNj04B5d5WNHX5xB4fTwCkT/wEGNcoOSjd4eilrs2aTdixgr1J3o
         iRgepBp/UD5LlB+mQ9qsKNeA+dD+7WMOPfa2WQH6zEcXyXskk+VIx7Z4H+ganGPeFDAE
         W3nFKtaKCjch35SuC/1gWpPZlkifhiogDi4S/eXIxF0hFv+mvsSj6ca8t2F+bgSQCvTo
         q66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vXLVQsXj6FC6nXeevSc8Ao3YS/Kg37+h24F/TyUkG4c=;
        b=YU7oMV7LF3REI9H6z2fbClsXCAIOnwhJSTChHLiR6buAzpOCwaufGz29IMYZpv5aEq
         HWuBR354fFLFX6dIUycmEgqFtnpUIOktxX4aSHU5s+fQmnK+pXgMU46yPfwhlX8xNTAt
         A8lvOhVJzuTPrSrqdevvowPnWQy43ULofdlxHh/QUfIDtJxmm2XhpObt5WtpmqsueVbP
         Dfu224YKrMi9ay2xc5VMnNvd50wiFlF0oeenb6HrXvImfLW9+XsV2fdayU9YMgeriRPh
         qJut6HsZapA0axXo+1/BQhQKiUeAAZ2IcXjhu5sAnn2exte8MaCv8BoZehQVgM/UBvaG
         GWQw==
X-Gm-Message-State: AOAM532Yh727YoE5Du5oaoJGqs3jHJQbPfrjYFQfyxNqnjFZqF4cqaQ1
        4gGmdd+H+9BiicEFg0VMCHQ=
X-Google-Smtp-Source: ABdhPJy1L+2Pe5g/52F2AiehAyM0Rvkeekl8RrJbMqiPvZQYDx/zPa/hkZ+9SkONG1a2Dxt8DGvRTg==
X-Received: by 2002:a62:788b:0:b029:300:21b3:d630 with SMTP id t133-20020a62788b0000b029030021b3d630mr7860968pfc.77.1624102671655;
        Sat, 19 Jun 2021 04:37:51 -0700 (PDT)
Received: from [192.168.1.153] (87.19.178.217.shared.user.transix.jp. [217.178.19.87])
        by smtp.gmail.com with ESMTPSA id d13sm10218023pfn.136.2021.06.19.04.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 04:37:51 -0700 (PDT)
Subject: [PATCH 4/5] riscv: __asm_to/copy_from_user: Bulk copy while shifting
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <767aa7e1-0cd0-1e60-3081-77b4c07d14ff@gmail.com>
Date:   Sat, 19 Jun 2021 20:37:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The destination address is aligned now, but often time the source address
is not in an aligned boundary.

To reduce the unaligned memory access, it reads the data from source in
aligned boundaries, which will cause the data to have an offset, and then
combines the data in the next iteration by fixing offset with shifting
before writing to destination.

The majority of the improving copy speed comes from this shift copy.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 4906b5ca91c3..e2e57551fc76 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -56,10 +56,70 @@ ENTRY(__asm_copy_from_user)
 	bltu	a0, t1, 1b	/* t1 - start of aligned dst */
 
 .Lskip_first_bytes:
+	/*
+	 * Now dst is aligned.
+	 * Use shift-copy if src is misaligned.
+	 * Use word-copy if both src and dst are aligned because
+	 * can not use shift-copy which do not require shifting
+	 */
+	/* a1 - start of src */
+	andi	a3, a1, SZREG-1
+	bnez	a3, .Lshift_copy
 
 .Lword_copy:
 .Lshift_copy:
 
+	/*
+	 * Word copy with shifting.
+	 * For misaligned copy we still perform aligned word copy, but
+	 * we need to use the value fetched from the previous iteration and
+	 * do some shifts.
+	 * This is safe because reading less than a word size.
+	 *
+	 * a0 - start of aligned dst
+	 * a1 - start of src
+	 * a3 - a1 & mask:(SZREG-1)
+	 * t0 - end of uncopied dst
+	 * t1 - end of aligned dst
+	 */
+	/* calculating aligned word boundary for dst */
+	andi	t1, t0, ~(SZREG-1)
+	/* Converting unaligned src to aligned arc */
+	andi	a1, a1, ~(SZREG-1)
+
+	/*
+	 * Calculate shifts
+	 * t3 - prev shift
+	 * t4 - current shift
+	 */
+	slli	t3, a3, LGREG
+	li	a5, SZREG*8
+	sub	t4, a5, t3
+
+	/* Load the first word to combine with seceond word */
+	fixup REG_L   a5, 0(a1), 10f
+
+3:
+	/* Main shifting copy
+	 *
+	 * a0 - start of aligned dst
+	 * a1 - start of aligned src
+	 * t1 - end of aligned dst
+	 */
+
+	/* At least one iteration will be executed */
+	srl	a4, a5, t3
+	fixup REG_L   a5, SZREG(a1), 10f
+	addi	a1, a1, SZREG
+	sll	a2, a5, t4
+	or	a2, a2, a4
+	fixup REG_S   a2, 0(a0), 10f
+	addi	a0, a0, SZREG
+	bltu	a0, t1, 3b
+
+	/* Revert src to original unaligned value  */
+	add	a1, a1, a3
+
 .Lbyte_copy_tail:
 	/*
 	 * Byte copy anything left.
-- 
2.17.1


