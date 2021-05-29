Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397E1394E2C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhE2Ujs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhE2Ujr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:39:47 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68324C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:38:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f22so5243538pgb.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FaKAKWgTGAF75nlDcT+nxeoW3pPMI6Wa1hWEXx7JRJ8=;
        b=KXbwErhInDJmgxHoBTPjt5gjPSnwxW/kBZkRBej1XQMnaCtmbDhJRo0arQU5oisUhn
         i1n/WsF3V61hp2fEjB3OJ3BRYReI2yeacvqwhLBZ1bRIKrwopmtLE5Ip8WsBqDAkfDM0
         FyII2aoYRtjhlHrjnRdJBqQqo+eDwQr5qmxYJNp3hAnILtTCkcjG60J3zj6+X1fwssyJ
         XWnVQUozzo5fI+NuJgx68Z9czl+MxxgNzEe1MjgwOwABntF2M6FWx+mmyqLxbl7tteCp
         CkfvA7tERJveQgFXUk6lWnxTKdkCC1wIJT8I0zy9vX7SW42NftuG2hJZp8rdjeX54T95
         zv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FaKAKWgTGAF75nlDcT+nxeoW3pPMI6Wa1hWEXx7JRJ8=;
        b=SWCJU0RPR+kKKYGXR/v8Srq6+5rbh6dNrrkblYYLLjxSP3wgxfKD/RW6gdWAMCG0mO
         Mlc8tVwjch3tI/eb5jPEWlwaWv1e371JTBBXKTKhGM5RT5sJu0nXRIpW+SemWLPxYic9
         G/wc4GP+QM1wXa+2t0oDywqvSPCdMLnRDcenh1CsU+bZ5hpZMYZ7VBqmAqmBquWJ7y5V
         LON19zhTDwDIgxoiW1PLQx+NQ/jPtDZWh2rAPObIUV0CVOhuCiFFMcB2MUdQQYQT9obb
         pF4UMJrmeJsnOlRL/X4tSBAMKAxY98KU+732zvrGsGhrCjfR06pTcDX3Q+5IexY66fAZ
         wx5Q==
X-Gm-Message-State: AOAM533KuB3T+au69f3pj3PiUn5KeLD8q3FGe4ssVjGt6V2JlIIz9MKx
        qu494NQ7kLDsSA8YO/8LY7Tsdw==
X-Google-Smtp-Source: ABdhPJxYikI3/E8XUsCFa1Je+83ieoXbfxo1EPLo2zpTY2HKbPRWYOimxaJlg0ZHL3KOfFy1R8OTAg==
X-Received: by 2002:a63:d30e:: with SMTP id b14mr15331161pgg.237.1622320689748;
        Sat, 29 May 2021 13:38:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o7sm7740814pgs.45.2021.05.29.13.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:38:09 -0700 (PDT)
Date:   Sat, 29 May 2021 13:38:09 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 13:37:27 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: Map the kernel with correct permissions the first time
In-Reply-To: <fe6fe4ba-00df-4695-c31e-7078bd77be50@ghiti.fr>
CC:     Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, jszhang@kernel.org, zong.li@sifive.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-7da55144-a2f6-458b-9e47-235391855832@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 01:24:43 PDT (-0700), alex@ghiti.fr wrote:
> Hi Christoph,
>
> Le 27/05/2021 à 08:35, Christoph Hellwig a écrit :
>> On Wed, May 26, 2021 at 03:41:10PM +0200, Alexandre Ghiti wrote:
>>>   #ifdef CONFIG_64BIT
>>> +#define is_kernel_mapping(x)	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
>>> +#define is_linear_mapping(x)	((x) >= PAGE_OFFSET && (x) < kernel_virt_addr)
>>> +
>>
>> Overly long lines.  Independ of that complex macros are generally much
>> more readable if they are written more function-like, that is the name
>> and paramtes are kept on a line of their own:
>>
>> #define is_kernel_mapping(x) \
>> 	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
>>
>> But what is the reason to not make them type-safe inline functions
>> anyway?
>
> No reason. I will then make those macros inline functions and send
> another patchset to make the below macro an inline function too.
>
>>
>>>   #define __va_to_pa_nodebug(x)	({						\
>>>   	unsigned long _x = x;							\
>>> -	(_x < kernel_virt_addr) ?						\
>>> +	is_linear_mapping(_x) ?							\
>>>   		linear_mapping_va_to_pa(_x) : kernel_mapping_va_to_pa(_x);	\
>>>   	})
>>
>> ... especially for something complex like this.
>>
>>> +static inline bool is_va_kernel_lm_alias_text(uintptr_t va)
>>> +{
>>> +	return (va >= (uintptr_t)lm_alias(_start) && va < (uintptr_t)lm_alias(__init_text_begin));
>>
>> Overly long line as well.  And useless braces.
>
> Ok.
>
>>
>>> +static inline bool is_va_kernel_init_text(uintptr_t va)
>>> +{
>>> +	return (va >= (uintptr_t)__init_text_begin && va < (uintptr_t)__init_data_begin);
>>> +}
>>
>> Same here.
>
> checkpatch does not complain about those lines which are under 100
> characters, what's the point in breaking them on multiple lines?
>
>>
>>> +#ifdef CONFIG_STRICT_KERNEL_RWX
>>> +static __init pgprot_t pgprot_from_va(uintptr_t va)
>>> +{
>>> +#ifdef CONFIG_64BIT
>>> +	if (is_va_kernel_text(va) || is_va_kernel_init_text(va))
>>> +		return PAGE_KERNEL_READ_EXEC;
>>> +
>>> +	/*
>>> +	 * We must mark only text as read-only as init text will get freed later
>>> +	 * and rodata section is marked readonly in mark_rodata_ro.
>>> +	 */
>>> +	if (is_va_kernel_lm_alias_text(va))
>>> +		return PAGE_KERNEL_READ;
>>> +
>>> +	return PAGE_KERNEL;
>>> +#else
>>> +	if (is_va_kernel_text(va))
>>> +		return PAGE_KERNEL_READ_EXEC;
>>> +
>>> +	if (is_va_kernel_init_text(va))
>>> +		return PAGE_KERNEL_EXEC;
>>> +
>>> +	return PAGE_KERNEL;
>>> +#endif /* CONFIG_64BIT */
>>> +}
>>
>> If the entire function is different for config symbols please just
>> split it into two separate functions.  But to make the difference more
>> clear IS_ENABLED might fit better here:
>>
>> static __init pgprot_t pgprot_from_va(uintptr_t va)
>> {
>> 	if (is_va_kernel_text(va))
>> 		return PAGE_KERNEL_READ_EXEC;
>> 	if (is_va_kernel_init_text(va))
>> 		return IS_ENABLED(CONFIG_64BIT) ?
>> 			PAGE_KERNEL_READ_EXEC : PAGE_KERNEL_EXEC;
>> 	if (IS_ENABLED(CONFIG_64BIT) && is_va_kernel_lm_alias_text(va))
>> 		return PAGE_KERNEL_READ;
>> 	return PAGE_KERNEL;
>> }
>>
>> Preferable with comments explaining the 32-bit vs 64-bit difference.
>
> Ok this is more compact, I'll do that with the comment.
>
>>
>>> +void mark_rodata_ro(void)
>>> +{
>>> +	unsigned long rodata_start = (unsigned long)__start_rodata;
>>> +	unsigned long data_start = (unsigned long)_data;
>>> +	unsigned long __maybe_unused lm_rodata_start = (unsigned long)lm_alias(__start_rodata);
>>> +	unsigned long __maybe_unused lm_data_start = (unsigned long)lm_alias(_data);
>>> +
>>> +	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
>>> +#ifdef CONFIG_64BIT
>>> +	set_memory_ro(lm_rodata_start, (lm_data_start - lm_rodata_start) >> PAGE_SHIFT);
>>> +#endif
>>
>> Lots of unreadable overly lone lines.  Why not add a helper and do
>> something like:
>>
>> static void set_kernel_memory_ro(char *startp, char *endp)
>> {
>>          unsigned long start = (unsigned long)startp;
>> 	unsigned long end = (unsigned long)endp;
>>
>> 	set_memory_ro(start, (start - end) >> PAGE_SHIFT);
>> }
>>
>>          set_kernel_memory_ro(_start_rodata, _data);
>> 	if (IS_ENABLED(CONFIG_64BIT))
>> 		set_kernel_memory_ro(lm_alias(__start_rodata), lm_alias(_data));
>>
>>
>
> Ok, that's better indeed. I will do something like that instead, to
> avoid multiple versions of this helper:
>
> int set_kernel_memory(char *startp, char *endp,
>
>                        int (*set_memory)(unsigned long start, int
> num_pages))
>
>>> +static __init pgprot_t pgprot_from_va(uintptr_t va)
>>> +{
>>> +#ifdef CONFIG_64BIT
>>> +	if (is_kernel_mapping(va))
>>> +		return PAGE_KERNEL_EXEC;
>>> +
>>> +	if (is_linear_mapping(va))
>>> +		return PAGE_KERNEL;
>>> +
>>> +	return PAGE_KERNEL;
>>> +#else
>>> +	return PAGE_KERNEL_EXEC;
>>> +#endif /* CONFIG_64BIT */
>>> +}
>>> +#endif /* CONFIG_STRICT_KERNEL_RWX */
>>> +
>>
>> Same comment as for the other version.  This could become:
>>
>> static __init pgprot_t pgprot_from_va(uintptr_t va)
>> {
>> 	if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
>> 		return PAGE_KERNEL;
>> 	return PAGE_KERNEL_EXEC;
>> }
>
> Ok I'll do that.
>
>>
>>> -static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>>> +static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size, bool early)
>>
>> Overly long line.
>>
>>>   	for (va = kernel_virt_addr; va < end_va; va += map_size)
>>>   		create_pgd_mapping(pgdir, va,
>>>   				   load_pa + (va - kernel_virt_addr),
>>> -				   map_size, PAGE_KERNEL_EXEC);
>>> +				   map_size, early ? PAGE_KERNEL_EXEC : pgprot_from_va(va));
>>
>> Same here.  But why not pass in a "pgprot_t ram_pgprot" instead of the
>> bool, which would be self-documenting.
>
> This function is used to map the kernel mapping, the pgprot_t is then
> different in create_kernel_page_table depending on the virtual address
> so I can't pass a single pgprot_t for that or I would need a dummy
> pgprot_t to test anyway.

Thanks.  I've got a riscv-wx-mappings branch with the fix on it, I'll 
take this on there when we have something ready to go and then merge 
both into for-next so we can avoid merge conflicts.

>
> Thank you for your review,
>
> Alex
>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
