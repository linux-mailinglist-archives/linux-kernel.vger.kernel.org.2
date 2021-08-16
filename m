Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9813EDCE5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhHPSKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhHPSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:10:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927FC0612A4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:09:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so655985pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=p2bkqWFEC2gR2YtuFUx6Fm7qYd1zZdWbBWhk55kWfPA=;
        b=a2tVNda0WPfrJUw66HIu72ovJiFEENcVs4kaBBZ++kllMOZqV2QLrtqOxDWz3czrbp
         WfSp55yY9ZysyKQW9q5/bm++/rWkAz4/buGG4G1HLv3QwcC2UALa3b5E9XK84NVBwXC/
         FTYyqS2F106horA2gZpCs1tPa47BJf71yM0gmITYiFBWgF2dUknhn+zZ46lsMja6ZTKL
         Dlj0r4xQEKt4ABoGbVRDjroXAnV3Mqx6hSJazfcczijWk/PfPURd92RomCfOyQnTWDbY
         068hp5vjXluNF9B3R6p4JCN0Fl8WYuYtXMJVL7rxHX+1U2rNPk3VeOYtBXyZj2ajuWOW
         DlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=p2bkqWFEC2gR2YtuFUx6Fm7qYd1zZdWbBWhk55kWfPA=;
        b=AZGudx3ojYhhg+6hy4nzJOKERylwnGrO5TnAj0QKf3so+wuryJ9Xu7QM5QReAFNEME
         tf0TOOqDqyMUSHRCl28xxA3517MvpijOrAY9ZZq63K8tk5HcN+k7d3aqUeUw7fS+khKq
         pATOmbTiWGzmHf8V9vj9/6GHEfAqJHA3UrO+duVX8ysFZ0C5ZIqnaZHj7goKTXf//b01
         r2ZJ/ecEbecuub3fPa2+XNmPqRPYYAzg4DIhF8uesLHT7xeD86VgpSZ2y8V0o7WltHLa
         g6++ehK2gX8venG93qQUjjouJvf9EhQc6ZCJdGg2Gw+H9Q6uTrt5efB7wrA9Sz01m9ru
         0EXA==
X-Gm-Message-State: AOAM532Odp1DDRdRWNFRkWAnBNA5AueK8503fW2yJrH7G3x2s1AH1mb2
        yFoptHF7N6C60OuCkzKuTJ9v0Q==
X-Google-Smtp-Source: ABdhPJx6qk04s9V+PiQeWIf6lJD6Fodj3Tj/KvxstJ8AiEsyYECec+zhqFGWJCp6Zb+C5CUk4VwmRQ==
X-Received: by 2002:a65:4307:: with SMTP id j7mr58100pgq.387.1629137386557;
        Mon, 16 Aug 2021 11:09:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gd14sm165849pjb.4.2021.08.16.11.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 11:09:45 -0700 (PDT)
Date:   Mon, 16 Aug 2021 11:09:45 -0700 (PDT)
X-Google-Original-Date: Mon, 16 Aug 2021 11:09:43 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: __asm_copy_to-from_user: Improve using word copy if size < 9*SZREG
In-Reply-To: <e3e9fb3a-40b1-50f3-23cc-50bfa53baa8d@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, linux@roeck-us.net,
        geert@linux-m68k.org, qiuwenbo@kylinos.com.cn,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akira.tsukamoto@gmail.com
Message-ID: <mhng-f83b1d51-c006-4b01-830a-0f827f0c56a1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 06:52:44 PDT (-0700), akira.tsukamoto@gmail.com wrote:
> Reduce the number of slow byte_copy when the size is in between
> 2*SZREG to 9*SZREG by using none unrolled word_copy.
>
> Without it any size smaller than 9*SZREG will be using slow byte_copy
> instead of none unrolled word_copy.
>
> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
> ---
>  arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index 63bc691cff91..6a80d5517afc 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -34,8 +34,10 @@ ENTRY(__asm_copy_from_user)
>  	/*
>  	 * Use byte copy only if too small.
>  	 * SZREG holds 4 for RV32 and 8 for RV64
> +	 * a3 - 2*SZREG is minimum size for word_copy
> +	 *      1*SZREG for aligning dst + 1*SZREG for word_copy
>  	 */
> -	li	a3, 9*SZREG /* size must be larger than size in word_copy */
> +	li	a3, 2*SZREG
>  	bltu	a2, a3, .Lbyte_copy_tail
>
>  	/*
> @@ -66,9 +68,40 @@ ENTRY(__asm_copy_from_user)
>  	andi	a3, a1, SZREG-1
>  	bnez	a3, .Lshift_copy
>
> +.Lcheck_size_bulk:
> +	/*
> +	 * Evaluate the size if possible to use unrolled.
> +	 * The word_copy_unlrolled requires larger than 8*SZREG
> +	 */
> +	li	a3, 8*SZREG
> +	add	a4, a0, a3
> +	bltu	a4, t0, .Lword_copy_unlrolled
> +
>  .Lword_copy:
> -        /*
> -	 * Both src and dst are aligned, unrolled word copy
> +	/*
> +	 * Both src and dst are aligned
> +	 * None unrolled word copy with every 1*SZREG iteration
> +	 *
> +	 * a0 - start of aligned dst
> +	 * a1 - start of aligned src
> +	 * t0 - end of aligned dst
> +	 */
> +	bgeu	a0, t0, .Lbyte_copy_tail /* check if end of copy */
> +	addi	t0, t0, -(SZREG) /* not to over run */
> +1:
> +	REG_L	a5, 0(a1)
> +	addi	a1, a1, SZREG
> +	REG_S	a5, 0(a0)
> +	addi	a0, a0, SZREG
> +	bltu	a0, t0, 1b
> +
> +	addi	t0, t0, SZREG /* revert to original value */
> +	j	.Lbyte_copy_tail
> +
> +.Lword_copy_unlrolled:
> +	/*
> +	 * Both src and dst are aligned
> +	 * Unrolled word copy with every 8*SZREG iteration
>  	 *
>  	 * a0 - start of aligned dst
>  	 * a1 - start of aligned src
> @@ -97,7 +130,12 @@ ENTRY(__asm_copy_from_user)
>  	bltu	a0, t0, 2b
>
>  	addi	t0, t0, 8*SZREG /* revert to original value */
> -	j	.Lbyte_copy_tail
> +
> +	/*
> +	 * Remaining might large enough for word_copy to reduce slow byte
> +	 * copy
> +	 */
> +	j	.Lcheck_size_bulk
>
>  .Lshift_copy:

I'm still not convinced that going all the way to such a large unrolling 
factor is a net win, but this at least provides a much smoother cost 
curve.

That said, this is causing my 32-bit configs to hang.  There were a few 
conflicts so I may have messed something up, but nothing is jumping out 
at me.  I've put what I ended up with on a branch, if you have time to 
look that'd be great but if not then I'll take another shot at this when 
I get back around to it.

    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=wip-word_user_copy

Here's the backtrace, though that's probably not all that useful:

[    0.703694] Unable to handle kernel NULL pointer dereference at virtual address 000005a8
[    0.704194] Oops [#1]
[    0.704301] Modules linked in:[    0.704463] CPU: 2 PID: 1 Comm: init Not tainted 5.14.0-rc1-00016-g59461ddb9dbd #5
[    0.704660] Hardware name: riscv-virtio,qemu (DT)
[    0.704802] epc : walk_stackframe+0xac/0xc2[    0.704941]  ra : dump_backtrace+0x1a/0x22
[    0.705074] epc : c0004558 ra : c0004588 sp : c1c5fe10
[    0.705216]  gp : c18b41c8 tp : c1cd8000 t0 : 00000000[    0.705357]  t1 : ffffffff t2 : 00000000 s0 : c1c5fe40
[    0.705506]  s1 : c11313dc a0 : 00000000 a1 : 00000000
[    0.705647]  a2 : c06fd2c2 a3 : c11313dc a4 : c084292d[    0.705787]  a5 : 00000000 a6 : c1864cb8 a7 : 3fffffff
[    0.705926]  s2 : 00000000 s3 : c1123e88 s4 : 00000000
[    0.706066]  s5 : c11313dc s6 : c06fd2c2 s7 : 00000001[    0.706206]  s8 : 00000000 s9 : 95af6e28 s10: 00000000
[    0.706345]  s11: 00000001 t3 : 00000000 t4 : 00000000
[    0.706482]  t5 : 00000001 t6 : 00000000[    0.706594] status: 00000100 badaddr: 000005a8 cause: 0000000d
[    0.706809] [<c0004558>] walk_stackframe+0xac/0xc2
[    0.707019] [<c0004588>] dump_backtrace+0x1a/0x22[    0.707149] [<c06fd312>] show_stack+0x2c/0x38
[    0.707271] [<c06ffba4>] dump_stack_lvl+0x40/0x58
[    0.707400] [<c06ffbce>] dump_stack+0x12/0x1a[    0.707521] [<c06fd4f6>] panic+0xfa/0x2a6
[    0.707632] [<c000e2f4>] do_exit+0x7a8/0x7ac
[    0.707749] [<c000eefa>] do_group_exit+0x2a/0x7e[    0.707872] [<c000ef60>] __wake_up_parent+0x0/0x20
[    0.707999] [<c0003020>] ret_from_syscall+0x0/0x2
[    0.708385] ---[ end trace 260976561a3770d1 ]---
