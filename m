Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2DA3AF755
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 23:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFUVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 17:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUVYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:24:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:22:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f2so21171395wri.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iuK/xSPhwyBQGwsFKjmihX2lWYavkv0/y3oH/Sh/Bbg=;
        b=RnufykAv6h3iF+MDiAa42Gzb1IKBtCAOWz2KeQfNLDy7MGDAKVKRPAB41CMtH9Z50I
         dr0MhHNvD3cgHhQgI0yOcykLef/rN8/6g//ASBYvFrl5+ZojjhB0pai4JNMj5KC/WsCM
         w/3rmw+0TT+8CCYV19YaDZiFrQOdwSM2JN38niyUu1xU2+WYoP0FP8wcqgbng9jJPftN
         zCr0frfYAML3iX2eKkpKN//bFQHY6ZtYfmkc5Tpk+Ts2YfzbERyyZBGfc5XK5qeIlH3z
         tz4iniX8v23G3ZbrlbxZfm1C9/Mht9AwErWbXA17SEAEMEy34LACEkSGQGiWh8iO6meH
         HXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iuK/xSPhwyBQGwsFKjmihX2lWYavkv0/y3oH/Sh/Bbg=;
        b=i3k0wRYKVCZZaK/nrlFnvCHvBA7ZsQfCNYd9y4dqDgr/jFFSa46MBWewQT4T8n4j2+
         BZUz8QT0e8SOsf7OH+og/N74P7Hetjd3Fr5lrbPUDN2AALSND6ZFN2waWm2oef/L45GU
         dSBDM/AyLGszcAEarp3oXNHm2SY5Cgi/BJodgBUYzL9iTwfEu0DR8Bt5/bEFBfoLmHlX
         2+WVkSEr97rzoLTNCw/lSgCRDQ0iyVmEjheUV3np8ZkowvqpQL7ycSTnxHtO0MbDoFK1
         x3SgRk9H46SmXTe4c7NkTeGXHhKYNU001SUAPB5eHHURnBa1pZhm0EQzQwme5Zh38toA
         PxrQ==
X-Gm-Message-State: AOAM531srl/F1q+z6KEOVYKxl+CavP+Zp5xwi4KX3FvERUCXgDo+ZGxk
        1CbsAipQDhiLPR4l4iDcEqfiMg==
X-Google-Smtp-Source: ABdhPJylQwn1qeOJE2/5+536pqceWFhmpUoDIF1i6sW38IsRYlksq3UKTXXlSX4AXobtLZ0BzFAOdQ==
X-Received: by 2002:adf:e652:: with SMTP id b18mr473252wrn.379.1624310544364;
        Mon, 21 Jun 2021 14:22:24 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i6sm13278123wro.12.2021.06.21.14.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 14:22:23 -0700 (PDT)
Subject: Re: [PATCH v3 22/23] powerpc/vdso: Migrate native signals to generic
 vdso_base
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-23-dima@arista.com>
 <1678c131-98e3-2d5c-7cf1-0dcb985d67bb@csgroup.eu>
 <fe44b73c-b2ca-4719-26f9-76f085d4d330@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <6cfdf043-b853-8559-f3f7-f52f46dc50e6@arista.com>
Date:   Mon, 21 Jun 2021 22:22:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fe44b73c-b2ca-4719-26f9-76f085d4d330@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chirstophe,

On 6/17/21 8:34 AM, Christophe Leroy wrote:
> 
> 
> Le 17/06/2021 à 08:36, Christophe Leroy a écrit :
>>
>>
>> Le 11/06/2021 à 20:02, Dmitry Safonov a écrit :
>>> Generic way to track the land vma area.
>>> Stat speaks for itself.
>>>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>>
>>
>> Build failure:
>>
>>    CC      arch/powerpc/kernel/asm-offsets.s
>> In file included from ./include/linux/mmzone.h:21,
>>                   from ./include/linux/gfp.h:6,
>>                   from ./include/linux/xarray.h:14,
>>                   from ./include/linux/radix-tree.h:19,
>>                   from ./include/linux/fs.h:15,
>>                   from ./include/linux/compat.h:17,
>>                   from arch/powerpc/kernel/asm-offsets.c:14:
>> ./include/linux/mm_types.h: In function 'init_vdso_base':
>> ./include/linux/mm_types.h:522:28: error: 'TASK_SIZE_MAX' undeclared
>> (first use in this function); did you mean 'XATTR_SIZE_MAX'?
>>    522 | #define UNMAPPED_VDSO_BASE TASK_SIZE_MAX
>>        |                            ^~~~~~~~~~~~~
>> ./include/linux/mm_types.h:627:40: note: in expansion of macro
>> 'UNMAPPED_VDSO_BASE'
>>    627 |         mm->vdso_base = (void __user *)UNMAPPED_VDSO_BASE;
>>        |                                        ^~~~~~~~~~~~~~~~~~
>> ./include/linux/mm_types.h:522:28: note: each undeclared identifier is
>> reported only once for each function it appears in
>>    522 | #define UNMAPPED_VDSO_BASE TASK_SIZE_MAX
>>        |                            ^~~~~~~~~~~~~
>> ./include/linux/mm_types.h:627:40: note: in expansion of macro
>> 'UNMAPPED_VDSO_BASE'
>>    627 |         mm->vdso_base = (void __user *)UNMAPPED_VDSO_BASE;
>>        |                                        ^~~~~~~~~~~~~~~~~~
>> make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
>> make[1]: *** [prepare0] Error 2
>> make: *** [__sub-make] Error 2
>>
> 
> Fixed by moving TASK_SIZE_MAX into asm/task_size_32.h and
> asm/task_size_64.h
> 
> diff --git a/arch/powerpc/include/asm/task_size_32.h
> b/arch/powerpc/include/asm/task_size_32.h
> index de7290ee770f..03af9e6bb5cd 100644
> --- a/arch/powerpc/include/asm/task_size_32.h
> +++ b/arch/powerpc/include/asm/task_size_32.h
> @@ -7,6 +7,7 @@
>  #endif
> 
>  #define TASK_SIZE (CONFIG_TASK_SIZE)
> +#define TASK_SIZE_MAX        TASK_SIZE
> 
>  /*
>   * This decides where the kernel will search for a free chunk of vm
> space during
> diff --git a/arch/powerpc/include/asm/task_size_64.h
> b/arch/powerpc/include/asm/task_size_64.h
> index c993482237ed..bfdb98c0ef43 100644
> --- a/arch/powerpc/include/asm/task_size_64.h
> +++ b/arch/powerpc/include/asm/task_size_64.h
> @@ -49,6 +49,7 @@
>                          TASK_SIZE_USER64)
> 
>  #define TASK_SIZE TASK_SIZE_OF(current)
> +#define TASK_SIZE_MAX        TASK_SIZE_USER64
> 
>  #define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
>  #define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64
> / 4))
> diff --git a/arch/powerpc/include/asm/uaccess.h
> b/arch/powerpc/include/asm/uaccess.h
> index 22c79ab40006..5823140d39f1 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -8,13 +8,6 @@
>  #include <asm/extable.h>
>  #include <asm/kup.h>
> 
> -#ifdef __powerpc64__
> -/* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
> -#define TASK_SIZE_MAX        TASK_SIZE_USER64
> -#else
> -#define TASK_SIZE_MAX        TASK_SIZE
> -#endif
> -
>  static inline bool __access_ok(unsigned long addr, unsigned long size)
>  {
>      return addr < TASK_SIZE_MAX && size <= TASK_SIZE_MAX - addr;


Thanks, that's very helpful!

-- 
          Dmitry
