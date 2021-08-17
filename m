Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADB93EE912
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhHQJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhHQJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:04:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC732C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 02:03:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n5so10579460pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PhWxmc8derdQF3ciSQTXL4gicsn8XaD0Xw+UiOkSNfE=;
        b=dhHi8o3ngIQUg9/6xFAUsFR6MH1zfyTk5yl+TmU+QvURYS7z3XTjs6kV6XwjY7NEHg
         xN8QipriwivaRm+bBNcJqkLhFWPPPRkC6v/AnoeyU4yT/cgG28ccgeu2NXYhLiSoOmpp
         yEpdKPuKRHjHRFyl0zrnCgCd5bh15ui9XEOXfJsD2hP58QkL6eieRKJF3tmZXGpJU2N0
         prwSzOzUmTwRu9PSv/6BeqsBjEwQBYTsxifqjukhfM+QoH3m3rdxV/BA1ofvDXp6Jj3+
         JN/VE20+OzG/qKHxlgoVUowuq/43tq3LbAtN4q78Okn5ULVC+RnzLkKp6DrIof6UkrQG
         lfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PhWxmc8derdQF3ciSQTXL4gicsn8XaD0Xw+UiOkSNfE=;
        b=gG31R/Mm6Jc48cY3mitMTTJ54GX0bg7paoLP4kA+35yMJG3hEmQT5bJV9mWK3jcGdN
         4WE9F7dmmvY2oJ38KEfluMsfvHNg04UAZRZeOzrre85bvJFyVaE5faqwUFJfOVT02NXW
         UpnCtPsLrKm95SC5N+CizWxpBstcYvgZOAffs1vfTUSW23rGhSlBn8HlroEi9LCWde5R
         Trph1fjM2fv2JqVZ1rQLG5zJdaoFiL3DOg60tW0WE+foQzOTpuV3m6pVzeGMWnXNCVpB
         PwTD4Erv2I0SA7CYQWEzh+2u8DFT3FYB8+gVdFUQFW2QbfNUFyK3bnapHY2kXk4KnsF5
         fxAw==
X-Gm-Message-State: AOAM531JRAa4qGaIrlOE/LjEvMgbSbNL+nl6/B+ct9AUQVBRdM23gRq8
        QM0BXNwh5H7oc8enqnZuvp8QrthntEE=
X-Google-Smtp-Source: ABdhPJy0c3WEiR8hPLWgXGJDEd84TGY7ELR4uHSfQ8aWHNpBDXhLAAZRZQyXyzM/SfSCAriJWQDXPw==
X-Received: by 2002:a63:1460:: with SMTP id 32mr2578900pgu.323.1629191003883;
        Tue, 17 Aug 2021 02:03:23 -0700 (PDT)
Received: from [10.252.0.198] (ec2-54-250-108-108.ap-northeast-1.compute.amazonaws.com. [54.250.108.108])
        by smtp.gmail.com with ESMTPSA id d5sm1566461pju.28.2021.08.17.02.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 02:03:23 -0700 (PDT)
Cc:     akira.tsukamoto@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>, linux@roeck-us.net,
        geert@linux-m68k.org, qiuwenbo@kylinos.com.cn,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] riscv: __asm_copy_to-from_user: Improve using word
 copy if size < 9*SZREG
To:     Palmer Dabbelt <palmer@dabbelt.com>
References: <mhng-f83b1d51-c006-4b01-830a-0f827f0c56a1@palmerdabbelt-glaptop>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <468725dc-d110-5ede-e290-c7a97feacd43@gmail.com>
Date:   Tue, 17 Aug 2021 18:03:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <mhng-f83b1d51-c006-4b01-830a-0f827f0c56a1@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/17/2021 3:09 AM, Palmer Dabbelt wrote:
> On Fri, 30 Jul 2021 06:52:44 PDT (-0700), akira.tsukamoto@gmail.com wrote:
>> Reduce the number of slow byte_copy when the size is in between
>> 2*SZREG to 9*SZREG by using none unrolled word_copy.
>>
>> Without it any size smaller than 9*SZREG will be using slow byte_copy
>> instead of none unrolled word_copy.
>>
>> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
>> ---
>>  arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
>> index 63bc691cff91..6a80d5517afc 100644
>> --- a/arch/riscv/lib/uaccess.S
>> +++ b/arch/riscv/lib/uaccess.S
>> @@ -34,8 +34,10 @@ ENTRY(__asm_copy_from_user)
>>      /*
>>       * Use byte copy only if too small.
>>       * SZREG holds 4 for RV32 and 8 for RV64
>> +     * a3 - 2*SZREG is minimum size for word_copy
>> +     *      1*SZREG for aligning dst + 1*SZREG for word_copy
>>       */
>> -    li    a3, 9*SZREG /* size must be larger than size in word_copy */
>> +    li    a3, 2*SZREG
>>      bltu    a2, a3, .Lbyte_copy_tail
>>
>>      /*
>> @@ -66,9 +68,40 @@ ENTRY(__asm_copy_from_user)
>>      andi    a3, a1, SZREG-1
>>      bnez    a3, .Lshift_copy
>>
>> +.Lcheck_size_bulk:
>> +    /*
>> +     * Evaluate the size if possible to use unrolled.
>> +     * The word_copy_unlrolled requires larger than 8*SZREG
>> +     */
>> +    li    a3, 8*SZREG
>> +    add    a4, a0, a3
>> +    bltu    a4, t0, .Lword_copy_unlrolled
>> +
>>  .Lword_copy:
>> -        /*
>> -     * Both src and dst are aligned, unrolled word copy
>> +    /*
>> +     * Both src and dst are aligned
>> +     * None unrolled word copy with every 1*SZREG iteration
>> +     *
>> +     * a0 - start of aligned dst
>> +     * a1 - start of aligned src
>> +     * t0 - end of aligned dst
>> +     */
>> +    bgeu    a0, t0, .Lbyte_copy_tail /* check if end of copy */
>> +    addi    t0, t0, -(SZREG) /* not to over run */
>> +1:
>> +    REG_L    a5, 0(a1)
>> +    addi    a1, a1, SZREG
>> +    REG_S    a5, 0(a0)
>> +    addi    a0, a0, SZREG
>> +    bltu    a0, t0, 1b
>> +
>> +    addi    t0, t0, SZREG /* revert to original value */
>> +    j    .Lbyte_copy_tail
>> +
>> +.Lword_copy_unlrolled:
>> +    /*
>> +     * Both src and dst are aligned
>> +     * Unrolled word copy with every 8*SZREG iteration
>>       *
>>       * a0 - start of aligned dst
>>       * a1 - start of aligned src
>> @@ -97,7 +130,12 @@ ENTRY(__asm_copy_from_user)
>>      bltu    a0, t0, 2b
>>
>>      addi    t0, t0, 8*SZREG /* revert to original value */
>> -    j    .Lbyte_copy_tail
>> +
>> +    /*
>> +     * Remaining might large enough for word_copy to reduce slow byte
>> +     * copy
>> +     */
>> +    j    .Lcheck_size_bulk
>>
>>  .Lshift_copy:
> 
> I'm still not convinced that going all the way to such a large unrolling factor is a net win, but this at least provides a much smoother cost curve.

I would like to meet and discuss the unrolling factor at some events.
The assembler version of memset in arch/riscv/lib/memset.S had thirty two consequent unrolling loading and stores and initially I also thought it was too much unrolling and crazy. 

However, I could not beat it with the speed with any of my customization when reducing the
unrolling. I never thought such a large unrolling would have benefit, my initial thought was minimum two or three would be enough for five or so pipeline cores with in-order and single issue design.

At the same time I experienced in the past some x86’s in-order cores would benefit from large unrolling, so I decided to go which was faster after the measurement.
The speed of the memset is critical for clearing the entire 4KiB page. 

The biggest down size is that the large unrolling will increase the binary size, and most of out-of-order cores are able to compensate without large unrolling by reordering instructions internally, so when I am able to rewrite the function with inline assembler, I would like to
switch with #ifdef of choosing the portion of unrolling between in-order cores and out-of cores in the future. Currently all physical risc-v cores are in-order design but probably out-of-order cores are coming some time and could benefit from reducing the binary size and relaxing the required memory bandwidth.

> 
> That said, this is causing my 32-bit configs to hang.  There were a few conflicts so I may have messed something up, but nothing is jumping out at me.  I've put what I ended up with on a branch, if you have time to look that'd be great but if not then I'll take another shot at this when I get back around to it.
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=wip-word_user_copy
> 
> Here's the backtrace, though that's probably not all that useful:
> 
> [    0.703694] Unable to handle kernel NULL pointer dereference at virtual address 000005a8
> [    0.704194] Oops [#1]
> [    0.704301] Modules linked in:[    0.704463] CPU: 2 PID: 1 Comm: init Not tainted 5.14.0-rc1-00016-g59461ddb9dbd #5
> [    0.704660] Hardware name: riscv-virtio,qemu (DT)
> [    0.704802] epc : walk_stackframe+0xac/0xc2[    0.704941]  ra : dump_backtrace+0x1a/0x22
> [    0.705074] epc : c0004558 ra : c0004588 sp : c1c5fe10
> [    0.705216]  gp : c18b41c8 tp : c1cd8000 t0 : 00000000[    0.705357]  t1 : ffffffff t2 : 00000000 s0 : c1c5fe40
> [    0.705506]  s1 : c11313dc a0 : 00000000 a1 : 00000000
> [    0.705647]  a2 : c06fd2c2 a3 : c11313dc a4 : c084292d[    0.705787]  a5 : 00000000 a6 : c1864cb8 a7 : 3fffffff
> [    0.705926]  s2 : 00000000 s3 : c1123e88 s4 : 00000000
> [    0.706066]  s5 : c11313dc s6 : c06fd2c2 s7 : 00000001[    0.706206]  s8 : 00000000 s9 : 95af6e28 s10: 00000000
> [    0.706345]  s11: 00000001 t3 : 00000000 t4 : 00000000
> [    0.706482]  t5 : 00000001 t6 : 00000000[    0.706594] status: 00000100 badaddr: 000005a8 cause: 0000000d
> [    0.706809] [<c0004558>] walk_stackframe+0xac/0xc2
> [    0.707019] [<c0004588>] dump_backtrace+0x1a/0x22[    0.707149] [<c06fd312>] show_stack+0x2c/0x38
> [    0.707271] [<c06ffba4>] dump_stack_lvl+0x40/0x58
> [    0.707400] [<c06ffbce>] dump_stack+0x12/0x1a[    0.707521] [<c06fd4f6>] panic+0xfa/0x2a6
> [    0.707632] [<c000e2f4>] do_exit+0x7a8/0x7ac
> [    0.707749] [<c000eefa>] do_group_exit+0x2a/0x7e[    0.707872] [<c000ef60>] __wake_up_parent+0x0/0x20
> [    0.707999] [<c0003020>] ret_from_syscall+0x0/0x2
> [    0.708385] ---[ end trace 260976561a3770d1 ]---

I am suspecting the error above might be the same cause as Qiu have mentioning at the other thread.

Akira
