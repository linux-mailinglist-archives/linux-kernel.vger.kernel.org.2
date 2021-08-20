Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC93F26F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhHTGnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhHTGnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:43:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF8DC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:42:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y23so8191520pgi.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6hE1IwbcD/W0J8iLODxuA+fomqEuqcycOTMy2P9S7y4=;
        b=rLVGoejHlJKFNTpNrieIDupRrj/jAGb07v/vsoixmpSTO+QUfUIbGjr+doazWsETGe
         ak8sA9GNMyFJ8saeGCXn1xj1k28aWW7sCfQjSoBK/9Ky+pZBivfXQTytXZz6/F8ocfvy
         63jtIxF9LGBtkYUAwB2F6dhEjS+fVkY6mKP11rvdcegGAjMWdxZoaSr2VrggyIEcnVm2
         RcU5HLJun/88UbrBss+6+43JaPIX53R3HRu5CrStZkZCBO51W6StugowMh5pxPT9jAT+
         4WyJlAu8XXMwmH+JzArd6OSgxk3EJKOo05OFT21hHLqUebHfq3I+MNr3jCJtk0/qiQwi
         hgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6hE1IwbcD/W0J8iLODxuA+fomqEuqcycOTMy2P9S7y4=;
        b=Q5Xw2HUXn0Eq9hOe3AIjkSWQCBTdUWGco8uYe5m5SRkRf0T4RaN7UTJQJ1RJUhMok0
         veQeEIlXUNEUZFdFSAyxJi3jDsowX8GEhqpsAPoFuAiMSxHPiXjZOEnCRKFpDsh5Wr4t
         c7327VSGRv8kxO67vQjBSXwWNmj7hbRyqtYOf8qpInb9yTQkiWH0iI/YVgbHeCdRVEJt
         yOFpFJh4gPQ++RmjKToDRC/MlPBiMALqx6Eea4qgiDwTu7OfoLIkPS13SSt4zdz8I/DP
         jhFO97cF+pQm5zMB6ZJuD5cfi23seoc0T9E3EcB5WCH62vHxSu+K65k1ZfHvVHSt9JWK
         4JLA==
X-Gm-Message-State: AOAM531ELqBzTK9d13G4VE8BwOlLS0mbtmMe22l0ITistrUYbv1lQUTh
        z5rW/+ZNxFd3xLx3cd043h61tyPu15PqhA==
X-Google-Smtp-Source: ABdhPJxDt6Hn3mdV88Z1fZn0pqd9mCs3I5QX3BaCXW1OL8QI7ryJ7oap+vwFNX6X1LyQuD6DEcMT3w==
X-Received: by 2002:a65:62cb:: with SMTP id m11mr17342007pgv.425.1629441744057;
        Thu, 19 Aug 2021 23:42:24 -0700 (PDT)
Received: from [10.252.0.53] (ec2-54-199-237-251.ap-northeast-1.compute.amazonaws.com. [54.199.237.251])
        by smtp.gmail.com with ESMTPSA id z2sm6813828pgz.43.2021.08.19.23.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 23:42:23 -0700 (PDT)
Cc:     akira.tsukamoto@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>, linux@roeck-us.net,
        geert@linux-m68k.org, qiuwenbo@kylinos.com.cn,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] riscv: __asm_copy_to-from_user: Improve using word
 copy if size < 9*SZREG
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <e3e9fb3a-40b1-50f3-23cc-50bfa53baa8d@gmail.com>
 <mhng-f83b1d51-c006-4b01-830a-0f827f0c56a1@palmerdabbelt-glaptop>
 <87zgthjjun.fsf@igel.home>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <ebfbcb26-5f17-2cc2-4845-6cdb24326338@gmail.com>
Date:   Fri, 20 Aug 2021 15:42:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87zgthjjun.fsf@igel.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 8/17/2021 4:00 AM, Andreas Schwab wrote:
> On Aug 16 2021, Palmer Dabbelt wrote:
> 
>> On Fri, 30 Jul 2021 06:52:44 PDT (-0700), akira.tsukamoto@gmail.com wrote:
>>> Reduce the number of slow byte_copy when the size is in between
>>> 2*SZREG to 9*SZREG by using none unrolled word_copy.
>>>
>>> Without it any size smaller than 9*SZREG will be using slow byte_copy
>>> instead of none unrolled word_copy.
>>>
>>> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
>>> ---
>>>  arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
>>>  1 file changed, 42 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
>>> index 63bc691cff91..6a80d5517afc 100644
>>> --- a/arch/riscv/lib/uaccess.S
>>> +++ b/arch/riscv/lib/uaccess.S
>>> @@ -34,8 +34,10 @@ ENTRY(__asm_copy_from_user)
>>>  	/*
>>>  	 * Use byte copy only if too small.
>>>  	 * SZREG holds 4 for RV32 and 8 for RV64
>>> +	 * a3 - 2*SZREG is minimum size for word_copy
>>> +	 *      1*SZREG for aligning dst + 1*SZREG for word_copy
>>>  	 */
>>> -	li	a3, 9*SZREG /* size must be larger than size in word_copy */
>>> +	li	a3, 2*SZREG
>>>  	bltu	a2, a3, .Lbyte_copy_tail
>>>
>>>  	/*
>>> @@ -66,9 +68,40 @@ ENTRY(__asm_copy_from_user)
>>>  	andi	a3, a1, SZREG-1
>>>  	bnez	a3, .Lshift_copy
>>>
>>> +.Lcheck_size_bulk:
>>> +	/*
>>> +	 * Evaluate the size if possible to use unrolled.
>>> +	 * The word_copy_unlrolled requires larger than 8*SZREG
>>> +	 */
>>> +	li	a3, 8*SZREG
>>> +	add	a4, a0, a3
>>> +	bltu	a4, t0, .Lword_copy_unlrolled
>>> +
>>>  .Lword_copy:
>>> -        /*
>>> -	 * Both src and dst are aligned, unrolled word copy
>>> +	/*
>>> +	 * Both src and dst are aligned
>>> +	 * None unrolled word copy with every 1*SZREG iteration
>>> +	 *
>>> +	 * a0 - start of aligned dst
>>> +	 * a1 - start of aligned src
>>> +	 * t0 - end of aligned dst
>>> +	 */
>>> +	bgeu	a0, t0, .Lbyte_copy_tail /* check if end of copy */
>>> +	addi	t0, t0, -(SZREG) /* not to over run */
>>> +1:
>>> +	REG_L	a5, 0(a1)
>>> +	addi	a1, a1, SZREG
>>> +	REG_S	a5, 0(a0)
>>> +	addi	a0, a0, SZREG
>>> +	bltu	a0, t0, 1b
>>> +
>>> +	addi	t0, t0, SZREG /* revert to original value */
>>> +	j	.Lbyte_copy_tail
>>> +
>>> +.Lword_copy_unlrolled:
>>> +	/*
>>> +	 * Both src and dst are aligned
>>> +	 * Unrolled word copy with every 8*SZREG iteration
>>>  	 *
>>>  	 * a0 - start of aligned dst
>>>  	 * a1 - start of aligned src
>>> @@ -97,7 +130,12 @@ ENTRY(__asm_copy_from_user)
>>>  	bltu	a0, t0, 2b
>>>
>>>  	addi	t0, t0, 8*SZREG /* revert to original value */
>>> -	j	.Lbyte_copy_tail
>>> +
>>> +	/*
>>> +	 * Remaining might large enough for word_copy to reduce slow byte
>>> +	 * copy
>>> +	 */
>>> +	j	.Lcheck_size_bulk
>>>
>>>  .Lshift_copy:
>>
>> I'm still not convinced that going all the way to such a large unrolling
>> factor is a net win, but this at least provides a much smoother cost 
>> curve.
>>
>> That said, this is causing my 32-bit configs to hang.
> 
> It's missing fixups for the loads in the loop.
> 
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index a835df6bd68f..12ed1f76bd1f 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -89,9 +89,9 @@ ENTRY(__asm_copy_from_user)
>  	bgeu	a0, t0, .Lbyte_copy_tail /* check if end of copy */
>  	addi	t0, t0, -(SZREG) /* not to over run */
>  1:
> -	REG_L	a5, 0(a1)
> +	fixup REG_L	a5, 0(a1), 10f
>  	addi	a1, a1, SZREG
> -	REG_S	a5, 0(a0)
> +	fixup REG_S	a5, 0(a0), 10f
>  	addi	a0, a0, SZREG
>  	bltu	a0, t0, 1b

Thanks, our messages crossed.
I also made the same changes after Qiu's comment, and contacting him
so I also could try it at my place and confirm if there are any other
changes required or not.

Please give me a little more while.

Akira
