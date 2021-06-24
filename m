Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB763B2519
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 04:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFXCjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 22:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhFXCjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:39:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5871EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 19:36:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso2529518pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 19:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PA0sGsnWn7x6YWMb364WdKSRZr6JVc7r09OSPHJyTVk=;
        b=bE7Ut1O6iEYhIzFYgS1kBHToBaRwb/B7k+v81/L3nAJV4duuuiXjpCwWPApRgLqP+C
         EnSiLIXsZjAz29cVdDq0shYtP+Bjk60JqK4sMgivH2RsI/exQv3FR4cJ9+GMkfU9wGJL
         Kl00N45p8PMsMHtCWRsr/wnmjyx+N2ydS5GG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PA0sGsnWn7x6YWMb364WdKSRZr6JVc7r09OSPHJyTVk=;
        b=Jg+OSOpi+p6ta+/SIRyjpLXsqvrcg/ju5e2m8jqol/gdQDpa6Qy6icUayptyUJe5pf
         hyxHOb9JiXLQPg0HSNN+TponTsD1SIDd5YUB1IwaierhgATxOgOgUzjmArdFOQ/TuDhv
         UVKpj33omZCrEFHg+AnI8CM7hYwXN/BMG0dccx6e9JZFMXIvXnRozR8lfhp39mHMAcv2
         hlzNyY86nSFFQFIT/++NEMUZpkYZneMeigCe+Cs4Z2mJN3RdZSMLgVkZk2zodezVV1yb
         9LjFanBw0QMVs0TiYYr/hZG45Tb3lmAkuf1JuXh9k/XTdxE4Ovdsd/xr2ddtAwr8xX/Q
         1qvg==
X-Gm-Message-State: AOAM530xcj1TBdNBmUetuArkFP2yyGvqqt5SyoZPtVGez+vQg2QC0fel
        MzTliedFaXxn4WrHPD4XKWQ68g==
X-Google-Smtp-Source: ABdhPJy9QZIYxHRsZyK7FJh0LJUF507UJ3DFUZzXdvU/CLgGpPexvwUcuURZcEFZRwUQQ+WMl2/9/w==
X-Received: by 2002:a17:90b:4b0f:: with SMTP id lx15mr2918093pjb.34.1624502208883;
        Wed, 23 Jun 2021 19:36:48 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id v1sm746256pjg.19.2021.06.23.19.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:36:48 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc: Define swapper_pg_dir[] in C
In-Reply-To: <87czsc21st.fsf@mpe.ellerman.id.au>
References: <5838caffa269e0957c5a50cc85477876220298b0.1623063174.git.christophe.leroy@csgroup.eu>
 <5e3f1b8a4695c33ccc80aa3870e016bef32b85e1.1623063174.git.christophe.leroy@csgroup.eu>
 <871r8siyqm.fsf@dja-thinkpad.axtens.net>
 <87czsc21st.fsf@mpe.ellerman.id.au>
Date:   Thu, 24 Jun 2021 12:36:43 +1000
Message-ID: <874kdoyon8.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:

> Daniel Axtens <dja@axtens.net> writes:
>> Hi Christophe,
>>
>> This breaks booting a radix KVM guest with 4k pages for me:
>>
>> make pseries_le_defconfig
>> scripts/config -d CONFIG_PPC_64K_PAGES
>> scripts/config -e CONFIG_PPC_4K_PAGES
>> make vmlinux
>> sudo qemu-system-ppc64 -enable-kvm -M pseries -m 1G -nographic -vga none -smp 4 -cpu host -kernel vmlinux
>>
>> Boot hangs after printing 'Booting Linux via __start()' and qemu's 'info
>> registers' reports that it's stuck at the instruction fetch exception.
>>
>> My host is Power9, 64k page size radix, and
>> gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34
>>
>
> ...
>>> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
>>> index 730838c7ca39..79f2d1e61abd 100644
>>> --- a/arch/powerpc/kernel/head_64.S
>>> +++ b/arch/powerpc/kernel/head_64.S
>>> @@ -997,18 +997,3 @@ start_here_common:
>>>  0:	trap
>>>  	EMIT_BUG_ENTRY 0b, __FILE__, __LINE__, 0
>>>  	.previous
>>> -
>>> -/*
>>> - * We put a few things here that have to be page-aligned.
>>> - * This stuff goes at the beginning of the bss, which is page-aligned.
>>> - */
>>> -	.section ".bss"
>>> -/*
>>> - * pgd dir should be aligned to PGD_TABLE_SIZE which is 64K.
>>> - * We will need to find a better way to fix this
>>> - */
>>> -	.align	16
>>> -
>>> -	.globl	swapper_pg_dir
>>> -swapper_pg_dir:
>>> -	.space	PGD_TABLE_SIZE
>
> This is now 4K aligned whereas it used to be 64K.
>
> This fixes it and is not completely ugly?
>
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 1707ab580ee2..298469beaa90 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -28,7 +28,13 @@
>  #include <asm/hugetlb.h>
>  #include <asm/pte-walk.h>
>  
> -pgd_t swapper_pg_dir[MAX_PTRS_PER_PGD] __page_aligned_bss;
> +#ifdef CONFIG_PPC64
> +#define PGD_ALIGN 0x10000
> +#else
> +#define PGD_ALIGN PAGE_SIZE
> +#endif
> +
> +pgd_t swapper_pg_dir[MAX_PTRS_PER_PGD] __section(".bss..page_aligned") __aligned(PGD_ALIGN);

The fix works for me, thank you.

Kind regards,
Daniel
>  
>  static inline int is_exec_fault(void)
>  {
>
>
> cheers
