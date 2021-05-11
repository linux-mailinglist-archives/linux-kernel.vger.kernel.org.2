Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C537B020
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEKUh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKUh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:37:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A06C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:36:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c22so24428710edn.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0K8+cWl4f660lQ2NTy5zX43BxUX/8XbunR/X8stSqw0=;
        b=ZBgzndLOUixi7xyu1QiP0jZ5+3bIdytpwtfH+llYnBjH3bTrfu7HU1bpfGoKH1Dr7z
         FWO5F5o+fZjPzzHs6SF0jx7Eib0GjhSwjb2S4gAuRGiytZT4eyDrzMigtH+t0NiXeyCF
         gYD6oN2VImkm4RKE5zp8lAKPqC1NHcQBS0ceC4Hrp+6dhDlANefiW1xVb/AoLD4OvqKz
         30r/AsCCik5/k3mJRqIOLkWdGs1NTz43auXG3S8HvWn8SxbafervNO4/jK8rah86XB0S
         FGMviSGB51c10M6kfjk1amQdRnZPrSGFFB6d0dGV7MO37SH/TIHyfDbto9Nu50j3gl+y
         +rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0K8+cWl4f660lQ2NTy5zX43BxUX/8XbunR/X8stSqw0=;
        b=FsosCJlNLys+C7PnFxPFs+rRbkSSbfRJtHvGOcJjA+K6Nk6pLtZR0u/Wl1nivnn+84
         njJI66i7TmrJW/X6i7W6Cp7agQqHoM2TJ27hb34vURpkOqxdN7jeoAANoGhA3Cacba0m
         lt/Jay8HimEaDAUFHgxJqDmWKVLk1ZsZ1+oPmMYnQ3YC6qJJt2a8+kCywox61boSRD0E
         ePFjAYR4PrnF4Fv94RvfLOltW7cdMY8SiwILp1WOoYuCuBuXEt+N4WiIjJrteOlqNwtL
         FZbkL+fWVP6jveX6iY9ieQ5ojmHv7kbk8tksvCBvthNHkxW7D25zdu2ETw3ewboX21Q0
         aaig==
X-Gm-Message-State: AOAM531KBIZlsSkIxsuhox7i4k0WqPC5o8fKya0Kjuvd162ooVgFMQ+x
        7a3pAM10XSp4Xv412yp+vKeOO9i6d4yxMA==
X-Google-Smtp-Source: ABdhPJzYrDzyIBGtvET27VGO9Tybe0ODd6Dc4gkO4PyzpAIUmGFoKqIjZay9XsdFrizBHi0LpHVuWA==
X-Received: by 2002:a05:6402:3131:: with SMTP id dd17mr38900192edb.304.1620765407712;
        Tue, 11 May 2021 13:36:47 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:986d:2b01:b594:22a4? (p200300ea8f384600986d2b01b59422a4.dip0.t-ipconnect.de. [2003:ea:8f38:4600:986d:2b01:b594:22a4])
        by smtp.googlemail.com with ESMTPSA id y8sm3418560edo.90.2021.05.11.13.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 13:36:46 -0700 (PDT)
To:     Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
 <6d55670d-2f06-d768-699f-5a79cece6ce0@gmail.com>
 <d181b674-66fb-1719-e3c6-e4217cf5519c@akamai.com>
 <59985635-665b-773f-de8f-b15fe3f60196@gmail.com>
 <1789b1da-7a0f-9fc9-6ed2-ff68e2306342@akamai.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log
 with debug messages
Message-ID: <204a99e1-de7a-4434-0932-45f1b507e9ec@gmail.com>
Date:   Tue, 11 May 2021 22:36:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1789b1da-7a0f-9fc9-6ed2-ff68e2306342@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.2021 05:21, Jason Baron wrote:
> 
> 
> On 5/5/21 2:40 PM, Heiner Kallweit wrote:
>> On 05.05.2021 18:58, Jason Baron wrote:
>>>
>>>
>>> On 5/3/21 3:40 PM, Heiner Kallweit wrote:
>>>> e820 emits quite some debug messages to the dmesg log. Let's restrict
>>>> this to cases where the debug output is actually requested. Switch to
>>>> pr_debug() for this purpose and make sure by checking the return code
>>>> that pr_cont() is only called if applicable.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  arch/x86/kernel/e820.c | 27 ++++++++++++++++-----------
>>>>  1 file changed, 16 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>>>> index bc0657f0d..67ad4d8f0 100644
>>>> --- a/arch/x86/kernel/e820.c
>>>> +++ b/arch/x86/kernel/e820.c
>>>> @@ -465,6 +465,7 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>>>>  	u64 end;
>>>>  	unsigned int i;
>>>>  	u64 real_updated_size = 0;
>>>> +	int printed;
>>>>  
>>>>  	BUG_ON(old_type == new_type);
>>>>  
>>>> @@ -472,11 +473,13 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>>>>  		size = ULLONG_MAX - start;
>>>>  
>>>>  	end = start + size;
>>>> -	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>>>> -	e820_print_type(old_type);
>>>> -	pr_cont(" ==> ");
>>>> -	e820_print_type(new_type);
>>>> -	pr_cont("\n");
>>>> +	printed = pr_debug("e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>>>> +	if (printed > 0) {
>>>> +		e820_print_type(old_type);
>>>> +		pr_cont(" ==> ");
>>>> +		e820_print_type(new_type);
>>>> +		pr_cont("\n");
>>>> +	}
>>>
>>>
>>> Hi Heiner,
>>>
>>> We've been doing these like:
>>>
>>> DEFINE_DYNAMIC_DEBUG_METADATA(e820_dbg, "e820 verbose mode");
>>>
>>> .
>>> .
>>> .
>>>
>>> if (DYNAMIC_DEBUG_BRANCH(e820_debg)) {
>>>     printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>>>     e820_print_type(old_type);
>>>     pr_cont(" ==> ");
>>>     e820_print_type(new_type);
>>>     pr_cont("\n");
>>> }
>>>
>>>
>>> You could then have one DEFINE_DYNAMIC_DEBUG_METADATA statement - such that it enables
>>> it all in one go, or do separate ones that enable it how you see fit.
>>>
>>> Would that work here?
>>>
>>
>> How would we handle the case that CONFIG_DYNAMIC_DEBUG_CORE isn't defined?
>> Then also DEFINE_DYNAMIC_DEBUG_METADATA isn't defined and we'd need to
>> duplicate the logic used here:
>>
>> #if defined(CONFIG_DYNAMIC_DEBUG) || \
>> 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>> #include <linux/dynamic_debug.h>
>> #define pr_debug(fmt, ...)			\
>> 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
>> #elif defined(DEBUG)
>> #define pr_debug(fmt, ...) \
>> 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>> #else
>> #define pr_debug(fmt, ...) \
>> 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>> #endif
>>
> 
> I'm not sure we need to duplicate all that I think we just need something
> like the following for the !CONFIG_DYNAMIC_DEBUG_CORE case. Would this
> help?
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index a57ee75..91ede70 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -182,6 +182,15 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  #include <linux/errno.h>
>  #include <linux/printk.h>
> 
> +#ifdef DEBUG
> +#define DYNAMIC_DEBUG_BRANCH(descriptor) true
> +#else
> +#define DYNAMIC_DEBUG_BRANCH(descriptor) false
> +#if
> +
> +#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
> +
> +
>  static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
>                                     const char *modname)
>  {
> 
> 
> 
>> IMO it's better to have the complexity of using DEFINE_DYNAMIC_DEBUG_METADATA
>> only once in the implementation of dynamic_pr_debug(), and not in every
>> code that wants to use pr_debug() in combination with pr_cont().
> 
> I think for your use-case it would just require one DEFINE_DYNAMIC_DEBUG_METADATA()
> statement?
> 
The point is that e820 isn't interested in using dynamic debugging. It just
would need to be able to deal with it because pr_debug() uses it. The actual
issue is independent of e820. It boils down to pr_cont() having no way to find
out whether it should print something or not if it follows a pr_debug() and
dynamic debugging is enabled.

>>
>> Also I think that to a certain extent pr_debug() is broken currently in case
>> of dynamic debugging because it has no return value, one drawback of
>> using not type-safe macros. This doesn't hurt so far because no caller seems to
>> check the return value or very few people have dynamic debugging enabled.
> 
> The model of:
> 
> DEFINE_DYNAMIC_DEBUG_METADATA(foo, "enble_foo");
> 
> .
> .
> .
> 
> if (DYNAMIC_DEBUG_BRANCH(foo) {
> 	do debugging stuff;
> }
> 
> Seems more general since the 'do debugging stuff' doesn't have to be limited
> to printk, it can be anything. So if we add another different model for this
> use-case, it seems like it might be less general.
> 
> Thanks,
> 
> -Jason
> 
Heiner
