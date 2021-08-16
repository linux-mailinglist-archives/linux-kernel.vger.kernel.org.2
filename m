Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEAE3EDD78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhHPTBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:01:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34362 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHPTA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:00:58 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GpNlQ4jSRz1qwGp;
        Mon, 16 Aug 2021 21:00:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GpNlQ3lsxz1r6P1;
        Mon, 16 Aug 2021 21:00:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id C_DzlPCR5dQ3; Mon, 16 Aug 2021 21:00:17 +0200 (CEST)
X-Auth-Info: Rw1j2hvSxw+BeG4hBnBmc2okW6IsahQRiTeFyGFwkw5fEIf7BhrTh0d9IoJAMmc+
Received: from igel.home (ppp-46-244-185-182.dynamic.mnet-online.de [46.244.185.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 16 Aug 2021 21:00:17 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C1A902C2640; Mon, 16 Aug 2021 21:00:16 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     akira.tsukamoto@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>, linux@roeck-us.net,
        geert@linux-m68k.org, qiuwenbo@kylinos.com.cn,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] riscv: __asm_copy_to-from_user: Improve using word
 copy if size < 9*SZREG
References: <e3e9fb3a-40b1-50f3-23cc-50bfa53baa8d@gmail.com>
        <mhng-f83b1d51-c006-4b01-830a-0f827f0c56a1@palmerdabbelt-glaptop>
X-Yow:  Now I'm having INSIPID THOUGHTS about the beautiful, round
 wives of HOLLYWOOD MOVIE MOGULS encased in PLEXIGLASS CARS
 and being approached by SMALL BOYS selling FRUIT..
Date:   Mon, 16 Aug 2021 21:00:16 +0200
In-Reply-To: <mhng-f83b1d51-c006-4b01-830a-0f827f0c56a1@palmerdabbelt-glaptop>
        (Palmer Dabbelt's message of "Mon, 16 Aug 2021 11:09:45 -0700 (PDT)")
Message-ID: <87zgthjjun.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 16 2021, Palmer Dabbelt wrote:

> On Fri, 30 Jul 2021 06:52:44 PDT (-0700), akira.tsukamoto@gmail.com wrote:
>> Reduce the number of slow byte_copy when the size is in between
>> 2*SZREG to 9*SZREG by using none unrolled word_copy.
>>
>> Without it any size smaller than 9*SZREG will be using slow byte_copy
>> instead of none unrolled word_copy.
>>
>> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
>> ---
>>  arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
>> index 63bc691cff91..6a80d5517afc 100644
>> --- a/arch/riscv/lib/uaccess.S
>> +++ b/arch/riscv/lib/uaccess.S
>> @@ -34,8 +34,10 @@ ENTRY(__asm_copy_from_user)
>>  	/*
>>  	 * Use byte copy only if too small.
>>  	 * SZREG holds 4 for RV32 and 8 for RV64
>> +	 * a3 - 2*SZREG is minimum size for word_copy
>> +	 *      1*SZREG for aligning dst + 1*SZREG for word_copy
>>  	 */
>> -	li	a3, 9*SZREG /* size must be larger than size in word_copy */
>> +	li	a3, 2*SZREG
>>  	bltu	a2, a3, .Lbyte_copy_tail
>>
>>  	/*
>> @@ -66,9 +68,40 @@ ENTRY(__asm_copy_from_user)
>>  	andi	a3, a1, SZREG-1
>>  	bnez	a3, .Lshift_copy
>>
>> +.Lcheck_size_bulk:
>> +	/*
>> +	 * Evaluate the size if possible to use unrolled.
>> +	 * The word_copy_unlrolled requires larger than 8*SZREG
>> +	 */
>> +	li	a3, 8*SZREG
>> +	add	a4, a0, a3
>> +	bltu	a4, t0, .Lword_copy_unlrolled
>> +
>>  .Lword_copy:
>> -        /*
>> -	 * Both src and dst are aligned, unrolled word copy
>> +	/*
>> +	 * Both src and dst are aligned
>> +	 * None unrolled word copy with every 1*SZREG iteration
>> +	 *
>> +	 * a0 - start of aligned dst
>> +	 * a1 - start of aligned src
>> +	 * t0 - end of aligned dst
>> +	 */
>> +	bgeu	a0, t0, .Lbyte_copy_tail /* check if end of copy */
>> +	addi	t0, t0, -(SZREG) /* not to over run */
>> +1:
>> +	REG_L	a5, 0(a1)
>> +	addi	a1, a1, SZREG
>> +	REG_S	a5, 0(a0)
>> +	addi	a0, a0, SZREG
>> +	bltu	a0, t0, 1b
>> +
>> +	addi	t0, t0, SZREG /* revert to original value */
>> +	j	.Lbyte_copy_tail
>> +
>> +.Lword_copy_unlrolled:
>> +	/*
>> +	 * Both src and dst are aligned
>> +	 * Unrolled word copy with every 8*SZREG iteration
>>  	 *
>>  	 * a0 - start of aligned dst
>>  	 * a1 - start of aligned src
>> @@ -97,7 +130,12 @@ ENTRY(__asm_copy_from_user)
>>  	bltu	a0, t0, 2b
>>
>>  	addi	t0, t0, 8*SZREG /* revert to original value */
>> -	j	.Lbyte_copy_tail
>> +
>> +	/*
>> +	 * Remaining might large enough for word_copy to reduce slow byte
>> +	 * copy
>> +	 */
>> +	j	.Lcheck_size_bulk
>>
>>  .Lshift_copy:
>
> I'm still not convinced that going all the way to such a large unrolling
> factor is a net win, but this at least provides a much smoother cost 
> curve.
>
> That said, this is causing my 32-bit configs to hang.

It's missing fixups for the loads in the loop.

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index a835df6bd68f..12ed1f76bd1f 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -89,9 +89,9 @@ ENTRY(__asm_copy_from_user)
 	bgeu	a0, t0, .Lbyte_copy_tail /* check if end of copy */
 	addi	t0, t0, -(SZREG) /* not to over run */
 1:
-	REG_L	a5, 0(a1)
+	fixup REG_L	a5, 0(a1), 10f
 	addi	a1, a1, SZREG
-	REG_S	a5, 0(a0)
+	fixup REG_S	a5, 0(a0), 10f
 	addi	a0, a0, SZREG
 	bltu	a0, t0, 1b
 

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
