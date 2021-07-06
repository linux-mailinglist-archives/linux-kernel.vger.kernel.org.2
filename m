Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC463BDFB1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 01:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGFXTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 19:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFXTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 19:19:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2239FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 16:16:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f17so471407pfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rZm6iConQ0+70rOq6SJqb5VjkIBGzrf3R88stzAGT2c=;
        b=GORRnxNXaioJsris67tjS/YABeT7L9ucXhiTv0ymTL0guYSnACl8LHtQIPuAVee63T
         e710dWHwKYTDQ5PYY/KI5iZ4A6KzIfil6q+4gVRW6NR+nUNFNOoGXST74NoDbXT5Ch1e
         U5dMSS+zXgyeH2cPhxXl+8Y2sfuS+8/3njvO+5V9j7RW+pZZ4M3oWj/QWiv1Yq9JRvmN
         gVrDqucKRjAuaN1hI6a74RFnLRapfgLrpIeWtZMHz3CvEH2oYm3piO8oAErJbMefEaj+
         mbk8tk/gpl6f1ow9Dik77sMlJjMJ+bDpA/PTxIvPnwL3BdENy4YvJ+SgkFluZnb6qENt
         tmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rZm6iConQ0+70rOq6SJqb5VjkIBGzrf3R88stzAGT2c=;
        b=TpBnh6DQERkFaVpFpTmrASJAa4nra6kWmGon6QmrZVKgrPOU6BVjdSGTFalfj8bdeF
         OU55IdzU/xkMTAYm3+TcWgUhqHdyY9sMydWSHX/cFO56YrdFisy5sbqd7kxpX/Zte4so
         mRgP2IO/xe0cP39FSm5RWw9+DIx7q+8Ixol9oFkrPn74dJvskkYodNJ//I9fTw4FZoFI
         bN4dSFOF8pH2AM+7jJAazzU4e9Qi/gpZf/r53XczgK/tCaekCkTJa/tGLCw4XclG+vK4
         1fAg2nrQID9idQHCpj5cGZckvxkUt/xGuREXXYEjvXteK1/VARY58zxYqmrl2vyEVA9E
         q8yw==
X-Gm-Message-State: AOAM533lWtRMudeWmRYlyJnyWzGtff5JJcdodyueY08VdYxqgEwT0HAG
        AsqBHV4dUzYn9MQ9+C4r64pZbg==
X-Google-Smtp-Source: ABdhPJwx8ztbXP3bz8wfRVEjxnoHRNRIzABc3uuSeGxEOzrJWhpKCeWcodtBX21SEeb//C/TRvf5aQ==
X-Received: by 2002:a62:2bc6:0:b029:2cc:242f:ab69 with SMTP id r189-20020a622bc60000b02902cc242fab69mr22870091pfr.16.1625613412541;
        Tue, 06 Jul 2021 16:16:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a23sm16551149pff.43.2021.07.06.16.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 16:16:52 -0700 (PDT)
Date:   Tue, 06 Jul 2021 16:16:52 -0700 (PDT)
X-Google-Original-Date: Tue, 06 Jul 2021 15:16:10 PDT (-0700)
Subject:     Re: [PATCH v3 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall
In-Reply-To: <60c1f087-1e8b-8f22-7d25-86f5f3dcee3f@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akira.tsukamoto@gmail.com
Message-ID: <mhng-f4c7d64b-f4e9-491a-8868-bc1baa7a72a7@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 05:40:39 PDT (-0700), akira.tsukamoto@gmail.com wrote:
>
> This patch will reduce cpu usage dramatically in kernel space especially
> for application which use sys-call with large buffer size, such as network
> applications. The main reason behind this is that every unaligned memory
> access will raise exceptions and switch between s-mode and m-mode causing
> large overhead.
>
> First copy in bytes until reaches the first word aligned boundary in
> destination memory address. This is the preparation before the bulk
> aligned word copy.
>
> The destination address is aligned now, but oftentimes the source address
> is not in an aligned boundary. To reduce the unaligned memory access, it
> reads the data from source in aligned boundaries, which will cause the
> data to have an offset, and then combines the data in the next iteration
> by fixing offset with shifting before writing to destination. The majority
> of the improving copy speed comes from this shift copy.
>
> In the lucky situation that the both source and destination address are on
> the aligned boundary, perform load and store with register size to copy the
> data. Without the unrolling, it will reduce the speed since the next store
> instruction for the same register using from the load will stall the
> pipeline.
>
> At last, copying the remainder in one byte at a time.
>
> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
> ---
>  arch/riscv/lib/uaccess.S | 181 +++++++++++++++++++++++++++++++--------
>  1 file changed, 146 insertions(+), 35 deletions(-)
>
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index fceaeb18cc64..bceb0629e440 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -19,50 +19,161 @@ ENTRY(__asm_copy_from_user)
>  	li t6, SR_SUM
>  	csrs CSR_STATUS, t6
>
> -	add a3, a1, a2
> -	/* Use word-oriented copy only if low-order bits match */
> -	andi t0, a0, SZREG-1
> -	andi t1, a1, SZREG-1
> -	bne t0, t1, 2f
> +	/* Save for return value */
> +	mv	t5, a2
>
> -	addi t0, a1, SZREG-1
> -	andi t1, a3, ~(SZREG-1)
> -	andi t0, t0, ~(SZREG-1)
>  	/*
> -	 * a3: terminal address of source region
> -	 * t0: lowest XLEN-aligned address in source
> -	 * t1: highest XLEN-aligned address in source
> +	 * Register allocation for code below:
> +	 * a0 - start of uncopied dst
> +	 * a1 - start of uncopied src
> +	 * a2 - size
> +	 * t0 - end of uncopied dst
>  	 */
> -	bgeu t0, t1, 2f
> -	bltu a1, t0, 4f
> +	add	t0, a0, a2
> +	bgtu	a0, t0, 5f
> +
> +	/*
> +	 * Use byte copy only if too small.
> +	 */
> +	li	a3, 8*SZREG /* size must be larger than size in word_copy */
> +	bltu	a2, a3, .Lbyte_copy_tail
> +
> +	/*
> +	 * Copy first bytes until dst is align to word boundary.
> +	 * a0 - start of dst
> +	 * t1 - start of aligned dst
> +	 */
> +	addi	t1, a0, SZREG-1
> +	andi	t1, t1, ~(SZREG-1)
> +	/* dst is already aligned, skip */
> +	beq	a0, t1, .Lskip_first_bytes
>  1:
> -	fixup REG_L, t2, (a1), 10f
> -	fixup REG_S, t2, (a0), 10f
> -	addi a1, a1, SZREG
> -	addi a0, a0, SZREG
> -	bltu a1, t1, 1b
> +	/* a5 - one byte for copying data */
> +	fixup lb      a5, 0(a1), 10f
> +	addi	a1, a1, 1	/* src */
> +	fixup sb      a5, 0(a0), 10f
> +	addi	a0, a0, 1	/* dst */
> +	bltu	a0, t1, 1b	/* t1 - start of aligned dst */
> +
> +.Lskip_first_bytes:
> +	/*
> +	 * Now dst is aligned.
> +	 * Use shift-copy if src is misaligned.
> +	 * Use word-copy if both src and dst are aligned because
> +	 * can not use shift-copy which do not require shifting
> +	 */
> +	/* a1 - start of src */
> +	andi	a3, a1, SZREG-1
> +	bnez	a3, .Lshift_copy
> +
> +.Lword_copy:
> +        /*
> +	 * Both src and dst are aligned, unrolled word copy
> +	 *
> +	 * a0 - start of aligned dst
> +	 * a1 - start of aligned src
> +	 * a3 - a1 & mask:(SZREG-1)
> +	 * t0 - end of aligned dst
> +	 */
> +	addi	t0, t0, -(8*SZREG-1) /* not to over run */
>  2:
> -	bltu a1, a3, 5f
> +	fixup REG_L   a4,        0(a1), 10f
> +	fixup REG_L   a5,    SZREG(a1), 10f
> +	fixup REG_L   a6,  2*SZREG(a1), 10f
> +	fixup REG_L   a7,  3*SZREG(a1), 10f
> +	fixup REG_L   t1,  4*SZREG(a1), 10f
> +	fixup REG_L   t2,  5*SZREG(a1), 10f
> +	fixup REG_L   t3,  6*SZREG(a1), 10f
> +	fixup REG_L   t4,  7*SZREG(a1), 10f
> +	fixup REG_S   a4,        0(a0), 10f
> +	fixup REG_S   a5,    SZREG(a0), 10f
> +	fixup REG_S   a6,  2*SZREG(a0), 10f
> +	fixup REG_S   a7,  3*SZREG(a0), 10f
> +	fixup REG_S   t1,  4*SZREG(a0), 10f
> +	fixup REG_S   t2,  5*SZREG(a0), 10f
> +	fixup REG_S   t3,  6*SZREG(a0), 10f
> +	fixup REG_S   t4,  7*SZREG(a0), 10f

This seems like a suspiciously large unrolling factor, at least without 
a fallback.  My guess is that some workloads will want some smaller 
unrolling factors, but given that we run on these single-issue in-order 
processors it's probably best to have some big unrolling factors as well 
since they're pretty limited WRT integer bandwidth.

> +	addi	a0, a0, 8*SZREG
> +	addi	a1, a1, 8*SZREG
> +	bltu	a0, t0, 2b
> +
> +	addi	t0, t0, 8*SZREG-1 /* revert to original value */
> +	j	.Lbyte_copy_tail
> +
> +.Lshift_copy:
> +
> +	/*
> +	 * Word copy with shifting.
> +	 * For misaligned copy we still perform aligned word copy, but
> +	 * we need to use the value fetched from the previous iteration and
> +	 * do some shifts.
> +	 * This is safe because reading less than a word size.
> +	 *
> +	 * a0 - start of aligned dst
> +	 * a1 - start of src
> +	 * a3 - a1 & mask:(SZREG-1)
> +	 * t0 - end of uncopied dst
> +	 * t1 - end of aligned dst
> +	 */
> +	/* calculating aligned word boundary for dst */
> +	andi	t1, t0, ~(SZREG-1)
> +	/* Converting unaligned src to aligned arc */
> +	andi	a1, a1, ~(SZREG-1)
> +
> +	/*
> +	 * Calculate shifts
> +	 * t3 - prev shift
> +	 * t4 - current shift
> +	 */
> +	slli	t3, a3, LGREG
> +	li	a5, SZREG*8
> +	sub	t4, a5, t3
> +
> +	/* Load the first word to combine with seceond word */
> +	fixup REG_L   a5, 0(a1), 10f
>
>  3:
> +	/* Main shifting copy
> +	 *
> +	 * a0 - start of aligned dst
> +	 * a1 - start of aligned src
> +	 * t1 - end of aligned dst
> +	 */
> +
> +	/* At least one iteration will be executed */
> +	srl	a4, a5, t3
> +	fixup REG_L   a5, SZREG(a1), 10f
> +	addi	a1, a1, SZREG
> +	sll	a2, a5, t4
> +	or	a2, a2, a4
> +	fixup REG_S   a2, 0(a0), 10f
> +	addi	a0, a0, SZREG
> +	bltu	a0, t1, 3b
> +
> +	/* Revert src to original unaligned value  */
> +	add	a1, a1, a3
> +
> +.Lbyte_copy_tail:
> +	/*
> +	 * Byte copy anything left.
> +	 *
> +	 * a0 - start of remaining dst
> +	 * a1 - start of remaining src
> +	 * t0 - end of remaining dst
> +	 */
> +	bgeu	a0, t0, 5f
> +4:
> +	fixup lb      a5, 0(a1), 10f
> +	addi	a1, a1, 1	/* src */
> +	fixup sb      a5, 0(a0), 10f
> +	addi	a0, a0, 1	/* dst */
> +	bltu	a0, t0, 4b	/* t0 - end of dst */
> +
> +5:
>  	/* Disable access to user memory */
>  	csrc CSR_STATUS, t6
> -	li a0, 0
> +	li	a0, 0
>  	ret
> -4: /* Edge case: unalignment */
> -	fixup lbu, t2, (a1), 10f
> -	fixup sb, t2, (a0), 10f
> -	addi a1, a1, 1
> -	addi a0, a0, 1
> -	bltu a1, t0, 4b
> -	j 1b
> -5: /* Edge case: remainder */
> -	fixup lbu, t2, (a1), 10f
> -	fixup sb, t2, (a0), 10f
> -	addi a1, a1, 1
> -	addi a0, a0, 1
> -	bltu a1, a3, 5b
> -	j 3b
>  ENDPROC(__asm_copy_to_user)
>  ENDPROC(__asm_copy_from_user)
>  EXPORT_SYMBOL(__asm_copy_to_user)
> @@ -117,7 +228,7 @@ EXPORT_SYMBOL(__clear_user)
>  10:
>  	/* Disable access to user memory */
>  	csrs CSR_STATUS, t6
> -	mv a0, a2
> +	mv a0, t5
>  	ret
>  11:
>  	csrs CSR_STATUS, t6

That said, this is good enough for me.  If someone comes up with a case 
where the extra unrolling is an issue I'm happy to take something to fix 
it, but until then I'm fine with this as-is.  Like the string fuctions 
it's probably best to eventually put this in C, but IIRC last time I 
tried it was kind of a headache.

This is on for-next.

Thanks!
