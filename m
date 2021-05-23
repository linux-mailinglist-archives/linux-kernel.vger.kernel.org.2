Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B263A38D81A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 03:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhEWBsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 21:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhEWBs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 21:48:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198A9C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 18:47:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q67so858269pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 18:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TvH3BDRJW0Vn39BXyOxIAFm2kF+cEjmUhZ/Z8uHEXT8=;
        b=HVrZ3gq5Sb9v/bCn6lE6lyd9F+Eodkaeh+qSjDZGZjJ0+1xYFdcmVdBI8Aywc6wC62
         42/Zc4sxpzjemTiZ1W5lQl/YFJDqwz7rIaCNkQPUTDUmiHGa5Cgk/UM9uBEHp4QpLip1
         KnfbgPD0Xx4mqzsqcuh5vR/B5eK+a3ADMO69Jk7mAVhaEJ6olvbNdHN6kVO6nNBSYX91
         mLqzypfvXfJwYVbATTNtQg3XM1dB0ez3cK2reha4bVEuD9YCjsi6PwODGvpg5voBs+J2
         5ILmCSCo7FWCp5ZxYw9SGxGLVlxJTRv0RtSabnI/piUpqm89+dppN6To1yUFeEAG7Esx
         FB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TvH3BDRJW0Vn39BXyOxIAFm2kF+cEjmUhZ/Z8uHEXT8=;
        b=E32GfNYf4ExAibS/v2Pz9EN1g24O2s53YzqQ3SoJj9Hhwpq/TTrPDYvWEaTcVCGpFO
         650xR4QaIbN+vP85dYea9gb+t26ZMrOt6LARfsI9+x7/bFZWQdYfn6OwNrm7ARXdTEBe
         Y+vL1JN9a41p+GxzthPwh64m3Uht6+5btKEhu5BqYsLP8tCgteu7Vk2d0YUBCEMte+GX
         +BccTGB/N0EMuiBNvqFrOikHj/o+xu1Ec9B4ph4FnQYLXgf5xBNkP/iOx6uTm1V606u4
         6IOYGtoraX+A7KD8B6vsxwnggqTGFv7I4nfRNCHqkVyuN8TdLTbWEnVvkdZ5H7gtEfgX
         3NKQ==
X-Gm-Message-State: AOAM532sMWVX1xHIdICzfJYhHQ07tjkuBUHeF1MnWiDfZGcfPDjKt6aK
        4Kk5ZbTB+32xWT+vfMfjWH3DTw==
X-Google-Smtp-Source: ABdhPJwuz/9P0x7vVoM97qqgxJaqvVMARK/fIYARqLju083kVuUzBepVprPtibGhQwjifLDCodF1Hg==
X-Received: by 2002:a62:ea10:0:b029:25a:9902:43f3 with SMTP id t16-20020a62ea100000b029025a990243f3mr17383546pfh.68.1621734422203;
        Sat, 22 May 2021 18:47:02 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id iq16sm6917933pjb.31.2021.05.22.18.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 18:47:01 -0700 (PDT)
Date:   Sat, 22 May 2021 18:47:01 -0700 (PDT)
X-Google-Original-Date: Sat, 22 May 2021 18:47:00 PDT (-0700)
Subject:     Re: [PATCH] riscv: fix memmove and optimise memcpy when misalign
In-Reply-To: <20210522232256.00003f08@garyguo.net>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        nickhu@andestech.com, nylon7@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     gary@garyguo.net
Message-ID: <mhng-fdda10f7-fc83-4654-a0b2-e9c86b92c37e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 15:22:56 PDT (-0700), gary@garyguo.net wrote:
> On Tue, 16 Feb 2021 22:55:51 +0000
> Gary Guo <gary@garyguo.net> wrote:
>
>> 04091d6 introduces an assembly version of memmove but
>> it does take misalignment into account (it checks if
>> length is a multiple of machine word size but pointers
>> need also be aligned). As a result it will generate
>> misaligned load/store for the majority of cases and causes
>> significant performance regression on hardware that traps
>> misaligned load/store and emulate them using firmware.
>>
>> The current behaviour of memcpy is that it checks if both
>> src and dest pointers are co-aligned (aka congruent
>> modular SZ_REG). If aligned, it will copy data word-by-word
>> after first aligning pointers to word boundary. If src
>> and dst are not co-aligned, however, byte-wise copy will
>> be performed.
>>
>> This patch fixes the memmove and optimises memcpy for
>> misaligned cases. It will first align destination pointer
>> to word-boundary regardless whether src and dest are
>> co-aligned or not. If they indeed are, then wordwise copy
>> is performed. If they are not co-aligned, then it will
>> load two adjacent words from src and use shifts to assemble
>> a full machine word. Some additional assembly level
>> micro-optimisation is also performed to ensure more
>> instructions can be compressed (e.g. prefer a0 to t6).
>>
>> In my testing this speeds up memcpy 4~5x when src and dest
>> are not co-aligned (which is quite common in networking),
>> and speeds up memmove 1000+x by avoiding trapping to firmware.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  arch/riscv/lib/memcpy.S  | 223
>> ++++++++++++++++++++++++--------------- arch/riscv/lib/memmove.S |
>> 176 ++++++++++++++++++++---------- 2 files changed, 257
>> insertions(+), 142 deletions(-)
>>
>> diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
>> index 51ab716253fa..00672c19ad9b 100644
>> --- a/arch/riscv/lib/memcpy.S
>> +++ b/arch/riscv/lib/memcpy.S
>> @@ -9,100 +9,151 @@
>>  /* void *memcpy(void *, const void *, size_t) */
>>  ENTRY(__memcpy)
>>  WEAK(memcpy)
>> -	move t6, a0  /* Preserve return value */
>> +	/* Save for return value */
>> +	mv	t6, a0
>>
>> -	/* Defer to byte-oriented copy for small sizes */
>> -	sltiu a3, a2, 128
>> -	bnez a3, 4f
>> -	/* Use word-oriented copy only if low-order bits match */
>> -	andi a3, t6, SZREG-1
>> -	andi a4, a1, SZREG-1
>> -	bne a3, a4, 4f
>> +	/*
>> +	 * Register allocation for code below:
>> +	 * a0 - start of uncopied dst
>> +	 * a1 - start of uncopied src
>> +	 * t0 - end of uncopied dst
>> +	 */
>> +	add	t0, a0, a2
>>
>> -	beqz a3, 2f  /* Skip if already aligned */
>>  	/*
>> -	 * Round to nearest double word-aligned address
>> -	 * greater than or equal to start address
>> +	 * Use bytewise copy if too small.
>> +	 *
>> +	 * This threshold must be at least 2*SZREG to ensure at
>> least one
>> +	 * wordwise copy is performed. It is chosen to be 16 because
>> it will
>> +	 * save at least 7 iterations of bytewise copy, which pays
>> off the
>> +	 * fixed overhead.
>>  	 */
>> -	andi a3, a1, ~(SZREG-1)
>> -	addi a3, a3, SZREG
>> -	/* Handle initial misalignment */
>> -	sub a4, a3, a1
>> +	li	a3, 16
>> +	bltu	a2, a3, .Lbyte_copy_tail
>> +
>> +	/*
>> +	 * Bytewise copy first to align a0 to word boundary.
>> +	 */
>> +	addi	a2, a0, SZREG-1
>> +	andi	a2, a2, ~(SZREG-1)
>> +	beq	a0, a2, 2f
>>  1:
>> -	lb a5, 0(a1)
>> -	addi a1, a1, 1
>> -	sb a5, 0(t6)
>> -	addi t6, t6, 1
>> -	bltu a1, a3, 1b
>> -	sub a2, a2, a4  /* Update count */
>> +	lb	a5, 0(a1)
>> +	addi	a1, a1, 1
>> +	sb	a5, 0(a0)
>> +	addi	a0, a0, 1
>> +	bne	a0, a2, 1b
>> +2:
>> +
>> +	/*
>> +	 * Now a0 is word-aligned. If a1 is also word aligned, we
>> could perform
>> +	 * aligned word-wise copy. Otherwise we need to perform
>> misaligned
>> +	 * word-wise copy.
>> +	 */
>> +	andi	a3, a1, SZREG-1
>> +	bnez	a3, .Lmisaligned_word_copy
>>
>> +	/* Unrolled wordwise copy */
>> +	addi	t0, t0, -(16*SZREG-1)
>> +	bgeu	a0, t0, 2f
>> +1:
>> +	REG_L	a2,        0(a1)
>> +	REG_L	a3,    SZREG(a1)
>> +	REG_L	a4,  2*SZREG(a1)
>> +	REG_L	a5,  3*SZREG(a1)
>> +	REG_L	a6,  4*SZREG(a1)
>> +	REG_L	a7,  5*SZREG(a1)
>> +	REG_L	t1,  6*SZREG(a1)
>> +	REG_L	t2,  7*SZREG(a1)
>> +	REG_L	t3,  8*SZREG(a1)
>> +	REG_L	t4,  9*SZREG(a1)
>> +	REG_L	t5, 10*SZREG(a1)
>> +	REG_S	a2,        0(a0)
>> +	REG_S	a3,    SZREG(a0)
>> +	REG_S	a4,  2*SZREG(a0)
>> +	REG_S	a5,  3*SZREG(a0)
>> +	REG_S	a6,  4*SZREG(a0)
>> +	REG_S	a7,  5*SZREG(a0)
>> +	REG_S	t1,  6*SZREG(a0)
>> +	REG_S	t2,  7*SZREG(a0)
>> +	REG_S	t3,  8*SZREG(a0)
>> +	REG_S	t4,  9*SZREG(a0)
>> +	REG_S	t5, 10*SZREG(a0)
>> +	REG_L	a2, 11*SZREG(a1)
>> +	REG_L	a3, 12*SZREG(a1)
>> +	REG_L	a4, 13*SZREG(a1)
>> +	REG_L	a5, 14*SZREG(a1)
>> +	REG_L	a6, 15*SZREG(a1)
>> +	addi	a1, a1, 16*SZREG
>> +	REG_S	a2, 11*SZREG(a0)
>> +	REG_S	a3, 12*SZREG(a0)
>> +	REG_S	a4, 13*SZREG(a0)
>> +	REG_S	a5, 14*SZREG(a0)
>> +	REG_S	a6, 15*SZREG(a0)
>> +	addi	a0, a0, 16*SZREG
>> +	bltu	a0, t0, 1b
>>  2:
>> -	andi a4, a2, ~((16*SZREG)-1)
>> -	beqz a4, 4f
>> -	add a3, a1, a4
>> -3:
>> -	REG_L a4,       0(a1)
>> -	REG_L a5,   SZREG(a1)
>> -	REG_L a6, 2*SZREG(a1)
>> -	REG_L a7, 3*SZREG(a1)
>> -	REG_L t0, 4*SZREG(a1)
>> -	REG_L t1, 5*SZREG(a1)
>> -	REG_L t2, 6*SZREG(a1)
>> -	REG_L t3, 7*SZREG(a1)
>> -	REG_L t4, 8*SZREG(a1)
>> -	REG_L t5, 9*SZREG(a1)
>> -	REG_S a4,       0(t6)
>> -	REG_S a5,   SZREG(t6)
>> -	REG_S a6, 2*SZREG(t6)
>> -	REG_S a7, 3*SZREG(t6)
>> -	REG_S t0, 4*SZREG(t6)
>> -	REG_S t1, 5*SZREG(t6)
>> -	REG_S t2, 6*SZREG(t6)
>> -	REG_S t3, 7*SZREG(t6)
>> -	REG_S t4, 8*SZREG(t6)
>> -	REG_S t5, 9*SZREG(t6)
>> -	REG_L a4, 10*SZREG(a1)
>> -	REG_L a5, 11*SZREG(a1)
>> -	REG_L a6, 12*SZREG(a1)
>> -	REG_L a7, 13*SZREG(a1)
>> -	REG_L t0, 14*SZREG(a1)
>> -	REG_L t1, 15*SZREG(a1)
>> -	addi a1, a1, 16*SZREG
>> -	REG_S a4, 10*SZREG(t6)
>> -	REG_S a5, 11*SZREG(t6)
>> -	REG_S a6, 12*SZREG(t6)
>> -	REG_S a7, 13*SZREG(t6)
>> -	REG_S t0, 14*SZREG(t6)
>> -	REG_S t1, 15*SZREG(t6)
>> -	addi t6, t6, 16*SZREG
>> -	bltu a1, a3, 3b
>> -	andi a2, a2, (16*SZREG)-1  /* Update count */
>> -
>> -4:
>> -	/* Handle trailing misalignment */
>> -	beqz a2, 6f
>> -	add a3, a1, a2
>> -
>> -	/* Use word-oriented copy if co-aligned to word boundary */
>> -	or a5, a1, t6
>> -	or a5, a5, a3
>> -	andi a5, a5, 3
>> -	bnez a5, 5f
>> -7:
>> -	lw a4, 0(a1)
>> -	addi a1, a1, 4
>> -	sw a4, 0(t6)
>> -	addi t6, t6, 4
>> -	bltu a1, a3, 7b
>> +	/* Post-loop increment by 16*SZREG-1 and pre-loop decrement
>> by SZREG-1 */
>> +	addi	t0, t0, 15*SZREG
>>
>> -	ret
>> +	/* Wordwise copy */
>> +	bgeu	a0, t0, 2f
>> +1:
>> +	REG_L	a5, 0(a1)
>> +	addi	a1, a1, SZREG
>> +	REG_S	a5, 0(a0)
>> +	addi	a0, a0, SZREG
>> +	bltu	a0, t0, 1b
>> +2:
>> +	addi	t0, t0, SZREG-1
>>
>> -5:
>> -	lb a4, 0(a1)
>> -	addi a1, a1, 1
>> -	sb a4, 0(t6)
>> -	addi t6, t6, 1
>> -	bltu a1, a3, 5b
>> -6:
>> +.Lbyte_copy_tail:
>> +	/*
>> +	 * Bytewise copy anything left.
>> +	 */
>> +	beq	a0, t0, 2f
>> +1:
>> +	lb	a5, 0(a1)
>> +	addi	a1, a1, 1
>> +	sb	a5, 0(a0)
>> +	addi	a0, a0, 1
>> +	bne	a0, t0, 1b
>> +2:
>> +
>> +	mv	a0, t6
>>  	ret
>> +
>> +.Lmisaligned_word_copy:
>> +	/*
>> +	 * Misaligned word-wise copy.
>> +	 * For misaligned copy we still perform word-wise copy, but
>> we need to
>> +	 * use the value fetched from the previous iteration and do
>> some shifts.
>> +	 * This is safe because we wouldn't access more words than
>> necessary.
>> +	 */
>> +
>> +	/* Calculate shifts */
>> +	slli	t3, a3, 3
>> +	sub	t4, x0, t3 /* negate is okay as shift will only
>> look at LSBs */ +
>> +	/* Load the initial value and align a1 */
>> +	andi	a1, a1, ~(SZREG-1)
>> +	REG_L	a5, 0(a1)
>> +
>> +	addi	t0, t0, -(SZREG-1)
>> +	/* At least one iteration will be executed here, no check */
>> +1:
>> +	srl	a4, a5, t3
>> +	REG_L	a5, SZREG(a1)
>> +	addi	a1, a1, SZREG
>> +	sll	a2, a5, t4
>> +	or	a2, a2, a4
>> +	REG_S	a2, 0(a0)
>> +	addi	a0, a0, SZREG
>> +	bltu	a0, t0, 1b
>> +
>> +	/* Update pointers to correct value */
>> +	addi	t0, t0, SZREG-1
>> +	add	a1, a1, a3
>> +
>> +	j	.Lbyte_copy_tail
>>  END(__memcpy)
>> diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
>> index 07d1d2152ba5..fbe6701dbe4a 100644
>> --- a/arch/riscv/lib/memmove.S
>> +++ b/arch/riscv/lib/memmove.S
>> @@ -5,60 +5,124 @@
>>
>>  ENTRY(__memmove)
>>  WEAK(memmove)
>> -        move    t0, a0
>> -        move    t1, a1
>> -
>> -        beq     a0, a1, exit_memcpy
>> -        beqz    a2, exit_memcpy
>> -        srli    t2, a2, 0x2
>> -
>> -        slt     t3, a0, a1
>> -        beqz    t3, do_reverse
>> -
>> -        andi    a2, a2, 0x3
>> -        li      t4, 1
>> -        beqz    t2, byte_copy
>> -
>> -word_copy:
>> -        lw      t3, 0(a1)
>> -        addi    t2, t2, -1
>> -        addi    a1, a1, 4
>> -        sw      t3, 0(a0)
>> -        addi    a0, a0, 4
>> -        bnez    t2, word_copy
>> -        beqz    a2, exit_memcpy
>> -        j       byte_copy
>> -
>> -do_reverse:
>> -        add     a0, a0, a2
>> -        add     a1, a1, a2
>> -        andi    a2, a2, 0x3
>> -        li      t4, -1
>> -        beqz    t2, reverse_byte_copy
>> -
>> -reverse_word_copy:
>> -        addi    a1, a1, -4
>> -        addi    t2, t2, -1
>> -        lw      t3, 0(a1)
>> -        addi    a0, a0, -4
>> -        sw      t3, 0(a0)
>> -        bnez    t2, reverse_word_copy
>> -        beqz    a2, exit_memcpy
>> -
>> -reverse_byte_copy:
>> -        addi    a0, a0, -1
>> -        addi    a1, a1, -1
>> -
>> -byte_copy:
>> -        lb      t3, 0(a1)
>> -        addi    a2, a2, -1
>> -        sb      t3, 0(a0)
>> -        add     a1, a1, t4
>> -        add     a0, a0, t4
>> -        bnez    a2, byte_copy
>> -
>> -exit_memcpy:
>> -        move a0, t0
>> -        move a1, t1
>> -        ret
>> +	/*
>> +	 * Here we determine if forward copy is possible. Forward
>> copy is
>> +	 * preferred to backward copy as it is more cache friendly.
>> +	 *
>> +	 * If a0 >= a1, t0 gives their distance, if t0 >= a2 then we
>> can
>> +	 *   copy forward.
>> +	 * If a0 < a1, we can always copy forward. This will make t0
>> negative,
>> +	 *   so a *unsigned* comparison will always have t0 >= a2.
>> +	 *
>> +	 * For forward copy we just delegate the task to memcpy.
>> +	 */
>> +	sub	t0, a0, a1
>> +	bltu	t0, a2, 1f
>> +	tail	__memcpy
>> +1:
>> +
>> +	/*
>> +	 * Register allocation for code below:
>> +	 * a0 - end of uncopied dst
>> +	 * a1 - end of uncopied src
>> +	 * t0 - start of uncopied dst
>> +	 */
>> +	mv	t0, a0
>> +	add	a0, a0, a2
>> +	add	a1, a1, a2
>> +
>> +	/*
>> +	 * Use bytewise copy if too small.
>> +	 *
>> +	 * This threshold must be at least 2*SZREG to ensure at
>> least one
>> +	 * wordwise copy is performed. It is chosen to be 16 because
>> it will
>> +	 * save at least 7 iterations of bytewise copy, which pays
>> off the
>> +	 * fixed overhead.
>> +	 */
>> +	li	a3, 16
>> +	bltu	a2, a3, .Lbyte_copy_tail
>> +
>> +	/*
>> +	 * Bytewise copy first to align t0 to word boundary.
>> +	 */
>> +	andi	a2, a0, ~(SZREG-1)
>> +	beq	a0, a2, 2f
>> +1:
>> +	addi	a1, a1, -1
>> +	lb	a5, 0(a1)
>> +	addi	a0, a0, -1
>> +	sb	a5, 0(a0)
>> +	bne	a0, a2, 1b
>> +2:
>> +
>> +	/*
>> +	 * Now a0 is word-aligned. If a1 is also word aligned, we
>> could perform
>> +	 * aligned word-wise copy. Otherwise we need to perform
>> misaligned
>> +	 * word-wise copy.
>> +	 */
>> +	andi	a3, a1, SZREG-1
>> +	bnez	a3, .Lmisaligned_word_copy
>> +
>> +	/* Wordwise copy */
>> +	addi	t0, t0, SZREG-1
>> +	bleu	a0, t0, 2f
>> +1:
>> +	addi	a1, a1, -SZREG
>> +	REG_L	a5, 0(a1)
>> +	addi	a0, a0, -SZREG
>> +	REG_S	a5, 0(a0)
>> +	bgtu	a0, t0, 1b
>> +2:
>> +	addi	t0, t0, -(SZREG-1)
>> +
>> +.Lbyte_copy_tail:
>> +	/*
>> +	 * Bytewise copy anything left.
>> +	 */
>> +	beq	a0, t0, 2f
>> +1:
>> +	addi	a1, a1, -1
>> +	lb	a5, 0(a1)
>> +	addi	a0, a0, -1
>> +	sb	a5, 0(a0)
>> +	bne	a0, t0, 1b
>> +2:
>> +
>> +	mv	a0, t0
>> +	ret
>> +
>> +.Lmisaligned_word_copy:
>> +	/*
>> +	 * Misaligned word-wise copy.
>> +	 * For misaligned copy we still perform word-wise copy, but
>> we need to
>> +	 * use the value fetched from the previous iteration and do
>> some shifts.
>> +	 * This is safe because we wouldn't access more words than
>> necessary.
>> +	 */
>> +
>> +	/* Calculate shifts */
>> +	slli	t3, a3, 3
>> +	sub	t4, x0, t3 /* negate is okay as shift will only
>> look at LSBs */ +
>> +	/* Load the initial value and align a1 */
>> +	andi	a1, a1, ~(SZREG-1)
>> +	REG_L	a5, 0(a1)
>> +
>> +	addi	t0, t0, SZREG-1
>> +	/* At least one iteration will be executed here, no check */
>> +1:
>> +	sll	a4, a5, t4
>> +	addi	a1, a1, -SZREG
>> +	REG_L	a5, 0(a1)
>> +	srl	a2, a5, t3
>> +	or	a2, a2, a4
>> +	addi	a0, a0, -SZREG
>> +	REG_S	a2, 0(a0)
>> +	bgtu	a0, t0, 1b
>> +
>> +	/* Update pointers to correct value */
>> +	addi	t0, t0, -(SZREG-1)
>> +	add	a1, a1, a3
>> +
>> +	j	.Lbyte_copy_tail
>> +
>>  END(__memmove)
>
> ping. It's been 3 month since submission and I really would like to see
> this applied or at least have some feedbacks.
>
> Link to the original patch in archive:
> https://lore.kernel.org/linux-riscv/20210216225555.4976-1-gary@garyguo.net/

Sorry, I thought I replied to this one but it must have gotten lost 
somewhere.

IMO the right way to go here is to just move to C-based string routines, 
at least until we get to the point where we're seriously optimizing for 
specific processors.  We went with the C-based string rountines in glibc 
as part of the upstreaming process and found only some small performance 
differences when compared to the hand-written assembly, and they're way 
easier to maintain.

IIRC Linux only has trivial C string routines in lib, I think the best 
way to go about that would be to higher performance versions in there.  
That will allow other ports to use them.
