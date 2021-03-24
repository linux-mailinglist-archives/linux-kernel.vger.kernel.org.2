Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F9C347035
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhCXDhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhCXDhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:37:47 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE44C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 20:37:47 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l76so1632769pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 20:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Scpkc+99pBAZyf4X9FUTLeY4be6wnkguK+kKt2gu3AU=;
        b=R0oAaGGB2zuALYZoBV42JTPvZSumUY94V8pqfE3xmU6UE3La3aXsWT4W9EZEEgjSNn
         65ZFNW/QJeu/1FqXikFDhluL2l3MPSwULNWhlKU68GGQToh1mtZD2teHmXzXCAAuD25k
         Sa2Mk9n4ur1sw9Gxrmgy7DbT49rImrV0kbNkb9RYtahzQiiU0tOGCo9S99gbKa1gj8yN
         9ubRxjAyAaJpL6lsV7DXWij/KuT3J5zApZ326Ev474x1NlRsjGEtEc7oIHeqNE16mFqe
         Tdyq5Om0vzjQClzJ/DiGw5clksoarIDXc/15lFGztVXUvseyqjSljyMhPFWWeXYPhxfU
         0T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Scpkc+99pBAZyf4X9FUTLeY4be6wnkguK+kKt2gu3AU=;
        b=DQNiUyPdRMmIOKw24ikdOMkPcQOP9y6GA04ZRvPp+2h+JJLyXHpyPFpORTscSb8fQX
         jTiam8Vq1Gbg9xRg106zTQTRoPpld3RRJibqbnVLmeFJTyPHZ9n04Si5k6j0v62LDAAt
         NWCrddW88gRRZcGxTz6u6VM1MSf7pUJRUlZadDmXiks3ik37qGD4ERGd91V02+2uF2qX
         MvLEQaJGKlbpcgkdIpevFkS0AkYRBvSuyHaEtTItp13zRgFsrQlbJM3jiU03hd9xBkoe
         hvt4mgQ5zKWzvzZrBI72k2NHwesEAtYabyQ3GCn8Yy9S4r1NZVvD5ERSuPCckcRELdN5
         ccbQ==
X-Gm-Message-State: AOAM532VuY5bDwacqyNE0vYU4GdAImcvljeC2EzZRWQTx4Mo1ewRYUe2
        vVIyrYXMvOCqUzMLOeyWZMQ=
X-Google-Smtp-Source: ABdhPJzURV/2ocdWj0YF97qRlk1QKMnQiKE4Qa4uq7KwlHJzXdZghRkhzBSK24VKlPA36ZaGkmNYGg==
X-Received: by 2002:a63:4d0a:: with SMTP id a10mr1248047pgb.177.1616557066856;
        Tue, 23 Mar 2021 20:37:46 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z2sm569936pfq.198.2021.03.23.20.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 20:37:46 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Qais Yousef <qais.yousef@arm.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
 <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
 <20210314220217.4mexdide7sqjfved@e107158-lin>
 <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
 <20210322110106.2bed3d50@gandalf.local.home>
 <20210322163248.id7qplbk6och6kuw@e107158-lin>
 <504d72ec-70a6-7e50-dbbb-16d693ce6150@nokia.com>
 <20210323222230.2d63hdcxq6strbug@e107158-lin>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2404ff10-7acc-3946-6592-31508f257f33@gmail.com>
Date:   Tue, 23 Mar 2021 20:37:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323222230.2d63hdcxq6strbug@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 3/23/2021 3:22 PM, Qais Yousef wrote:
> Hi Alexander
> 
> On 03/22/21 18:02, Alexander Sverdlin wrote:
>> Hi Qais,
>>
>> On 22/03/2021 17:32, Qais Yousef wrote:
>>> Yes you're right. I was a bit optimistic on CONFIG_DYNAMIC_FTRACE will imply
>>> CONFIG_ARM_MODULE_PLTS is enabled too.
>>>
>>> It only has an impact on reducing ifdefery when calling
>>>
>>> 	ftrace_call_replace_mod(rec->arch.mod, ...)
>>>
>>> Should be easy to wrap rec->arch.mod with its own accessor that will return
>>> NULL if !CONFIG_ARM_MODULE_PLTS or just ifdef the functions.
>>>
>>> Up to Alexander to pick what he prefers :-)
>>
>> well, I of course prefer v7 as-is, because this review is running longer than two
>> years and I actually hope these patches to be finally merged at some point.
>> But you are welcome to optimize them with follow up patches :)
> 
> I appreciate that and thanks a lot for your effort. My attempt to review and
> test here is to help in getting this merged.
> 
> FWIW my main concern is about duplicating the range check in
> ftrace_call_replace() and using magic values that already exist in
> __arm_gen_branch_{arm, thumb2}() and better remain encapsulated there.

Your patch in addition to Alexander's patch work for me as well, so feel
free to add a:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

FWIW, what is nice about Alexander's original patch is that it applies
relatively cleanly to older kernels as well where this is equally
needed. There is not currently any Fixes: tag being provided but maybe
we should amend the second patch with one?

Thanks!

> 
> Thanks
> 
> --
> Qais Yousef
> 
> ----->8------
> 
> 
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index a4dbac07e4ef..8545b3ff8317 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -25,6 +25,27 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	/* With Thumb-2, the recorded addresses have the lsb set */
>  	return addr & ~1;
>  }
> +
> +#ifdef CONFIG_ARM_MODULE_PLTS
> +static inline void ftrace_set_mod(struct dyn_arch_ftrace *arch, struct module *mod)
> +{
> +	arch->mod = mod;
> +}
> +
> +static inline struct module *ftrace_get_mod(struct dyn_arch_ftrace *arch)
> +{
> +	return arch->mod;
> +}
> +#else
> +static inline void ftrace_set_mod(struct dyn_arch_ftrace *arch, struct module *mod)
> +{
> +}
> +
> +static inline struct module *ftrace_get_mod(struct dyn_arch_ftrace *arch)
> +{
> +	return NULL;
> +}
> +#endif
>  #endif
>  
>  #endif
> diff --git a/arch/arm/include/asm/insn.h b/arch/arm/include/asm/insn.h
> index f20e08ac85ae..71c3edefe629 100644
> --- a/arch/arm/include/asm/insn.h
> +++ b/arch/arm/include/asm/insn.h
> @@ -13,18 +13,24 @@ arm_gen_nop(void)
>  }
>  
>  unsigned long
> -__arm_gen_branch(unsigned long pc, unsigned long addr, bool link);
> +__arm_gen_branch(unsigned long pc, unsigned long addr, bool link, bool check);
>  
>  static inline unsigned long
>  arm_gen_branch(unsigned long pc, unsigned long addr)
>  {
> -	return __arm_gen_branch(pc, addr, false);
> +	return __arm_gen_branch(pc, addr, false, true);
>  }
>  
>  static inline unsigned long
>  arm_gen_branch_link(unsigned long pc, unsigned long addr)
>  {
> -	return __arm_gen_branch(pc, addr, true);
> +	return __arm_gen_branch(pc, addr, true, true);
> +}
> +
> +static inline unsigned long
> +arm_gen_branch_link_nocheck(unsigned long pc, unsigned long addr)
> +{
> +	return __arm_gen_branch(pc, addr, true, false);
>  }
>  
>  #endif
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index fa867a57100f..63ea34edd222 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -70,20 +70,28 @@ int ftrace_arch_code_modify_post_process(void)
>  
>  static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
>  {
> -	s32 offset = addr - pc;
> -	s32 blim = 0xfe000008;
> -	s32 flim = 0x02000004;
> +	return arm_gen_branch_link(pc, addr);
> +}
>  
> -	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> -		blim = 0xff000004;
> -		flim = 0x01000002;
> -	}
> +static unsigned long
> +ftrace_call_replace_mod(struct module *mod, unsigned long pc, unsigned long addr)
> +{
> +#ifdef CONFIG_ARM_MODULE_PLTS
> +	unsigned long new;
>  
> -	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
> -	    (offset < blim || offset > flim))
> -		return 0;
> +	if (likely(!mod))
> +		return arm_gen_branch_link(pc, addr);
>  
> +	new = arm_gen_branch_link_nocheck(pc, addr);
> +	if (!new) {
> +		addr = get_module_plt(mod, pc, addr);
> +		new = arm_gen_branch_link(pc, addr);
> +	}
> +
> +	return new;
> +#else
>  	return arm_gen_branch_link(pc, addr);
> +#endif
>  }
>  
>  static int ftrace_modify_code(unsigned long pc, unsigned long old,
> @@ -141,18 +149,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  
>  	old = ftrace_nop_replace(rec);
>  
> -	new = ftrace_call_replace(ip, aaddr);
> -
> -#ifdef CONFIG_ARM_MODULE_PLTS
> -	if (!new) {
> -		struct module *mod = rec->arch.mod;
> -
> -		if (mod) {
> -			aaddr = get_module_plt(mod, ip, aaddr);
> -			new = ftrace_call_replace(ip, aaddr);
> -		}
> -	}
> -#endif
> +	new = ftrace_call_replace_mod(ftrace_get_mod(&rec->arch), ip, aaddr);
>  
>  	return ftrace_modify_code(rec->ip, old, new, true);
>  }
> @@ -183,23 +180,11 @@ int ftrace_make_nop(struct module *mod,
>  	unsigned long new;
>  	int ret;
>  
> -#ifdef CONFIG_ARM_MODULE_PLTS
>  	/* mod is only supplied during module loading */
> -	if (!mod)
> -		mod = rec->arch.mod;
> -	else
> -		rec->arch.mod = mod;
> -#endif
> -
> -	old = ftrace_call_replace(ip, aaddr);
> -
> -#ifdef CONFIG_ARM_MODULE_PLTS
> -	if (!old && mod) {
> -		aaddr = get_module_plt(mod, ip, aaddr);
> -		old = ftrace_call_replace(ip, aaddr);
> -	}
> -#endif
> +	if (mod)
> +		ftrace_set_mod(&rec->arch, mod);
>  
> +	old = ftrace_call_replace_mod(ftrace_get_mod(&rec->arch), ip, aaddr);
>  	new = ftrace_nop_replace(rec);
>  	ret = ftrace_modify_code(ip, old, new, true);
>  
> diff --git a/arch/arm/kernel/insn.c b/arch/arm/kernel/insn.c
> index 2e844b70386b..37ec5734309e 100644
> --- a/arch/arm/kernel/insn.c
> +++ b/arch/arm/kernel/insn.c
> @@ -4,7 +4,7 @@
>  #include <asm/opcodes.h>
>  
>  static unsigned long
> -__arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
> +__arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link, bool check)
>  {
>  	unsigned long s, j1, j2, i1, i2, imm10, imm11;
>  	unsigned long first, second;
> @@ -12,7 +12,7 @@ __arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
>  
>  	offset = (long)addr - (long)(pc + 4);
>  	if (offset < -16777216 || offset > 16777214) {
> -		WARN_ON_ONCE(1);
> +		WARN_ON_ONCE(check);
>  		return 0;
>  	}
>  
> @@ -34,7 +34,7 @@ __arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
>  }
>  
>  static unsigned long
> -__arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
> +__arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link, bool check)
>  {
>  	unsigned long opcode = 0xea000000;
>  	long offset;
> @@ -44,7 +44,7 @@ __arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
>  
>  	offset = (long)addr - (long)(pc + 8);
>  	if (unlikely(offset < -33554432 || offset > 33554428)) {
> -		WARN_ON_ONCE(1);
> +		WARN_ON_ONCE(check);
>  		return 0;
>  	}
>  
> @@ -54,10 +54,10 @@ __arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
>  }
>  
>  unsigned long
> -__arm_gen_branch(unsigned long pc, unsigned long addr, bool link)
> +__arm_gen_branch(unsigned long pc, unsigned long addr, bool link, bool check)
>  {
>  	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
> -		return __arm_gen_branch_thumb2(pc, addr, link);
> +		return __arm_gen_branch_thumb2(pc, addr, link, check);
>  	else
> -		return __arm_gen_branch_arm(pc, addr, link);
> +		return __arm_gen_branch_arm(pc, addr, link, check);
>  }
> 

-- 
Florian
