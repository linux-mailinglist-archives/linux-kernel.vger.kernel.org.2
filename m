Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC312374821
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhEESlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbhEESlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:41:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE05C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 11:40:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g65so2003598wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xPiqDUobm90PwEQWaNvmZpAUGE8LEPZKn4LE1Dhhu88=;
        b=fMNsg1SJ+gZkYd5zRGwWKYszUpZVsEgoh1d3VdwmOTitwIdCoUQ5RwuzEWrucNy8Gb
         2dUEIxTv15YNpEDIBFuFHfE0X4bhlbuFQK9y3tDTGHsspKJ1doqK9fP+rytuMALuehkm
         macLrDJYZQDDYL8TlFhUTPwrLUjf3FB8RvNkWup4sg3KVnMF+/PkTNeGr1koxUi9htsK
         fBbMMtyeqp98F+v6/G8qPW/BXlcSd3KK749lFvLl5Md1XlAnRNuZb7ZG/NTOuUAKwK3r
         yXh8+KwbWuAK2psXM1hafo/mrYgNib/zApqJGdLGI8HqHhNjIyzKnLSf0UC7ZtquXc7d
         8UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xPiqDUobm90PwEQWaNvmZpAUGE8LEPZKn4LE1Dhhu88=;
        b=Bo1LdlqKdtU4ml3AAzzU5xOMf0hE0AARQdoHbRdHN3YA7B/2CCZr3nnulTUgpFIsm5
         1mZUn6+Y9BK/MWZ6NXnOmxpKNWeQC9oo6LfiPd+gEwj3NeQCr1z0bUZo2+EWMGwSvYUG
         ePtLfKG+rAc4Sx7rcQu6dfH4k/hy+HrdtBWVJZV9Iu4YPhERuAHAAPXWpUnvwVX/0S3Y
         tEIzvAg9F4Ampud9UPWnCs3HT+JNZGipts3Cs0NqI1feEokrv2AvnVKJVKJmTWJGSmJe
         ZeklmoTry2DwANB5E4kQ+gitamYoMQvGqGkbCEvGSvC5yIMjaJzb6ujLSxa+XgYh+e+L
         6few==
X-Gm-Message-State: AOAM533CE+leB/hA/52TQwnmRxpYNPVdnlDpUkV0k50vnxXJSLGfWUqu
        3K5xvf+PCr1l9cyFV3zXpHwL8CHMkX0mVg==
X-Google-Smtp-Source: ABdhPJyAU5ZlPh8GoKvWmDeZmBh1X74dVbtHBJQaw2sWuLmGQAInyzQnG2e6U8NMyR0xnyv7bagqEQ==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr11713522wmn.82.1620240045965;
        Wed, 05 May 2021 11:40:45 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:e1a9:6a7f:ee3b:8d0b? (p200300ea8f384600e1a96a7fee3b8d0b.dip0.t-ipconnect.de. [2003:ea:8f38:4600:e1a9:6a7f:ee3b:8d0b])
        by smtp.googlemail.com with ESMTPSA id r36sm7119139wmp.18.2021.05.05.11.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:40:45 -0700 (PDT)
To:     Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
 <6d55670d-2f06-d768-699f-5a79cece6ce0@gmail.com>
 <d181b674-66fb-1719-e3c6-e4217cf5519c@akamai.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log
 with debug messages
Message-ID: <59985635-665b-773f-de8f-b15fe3f60196@gmail.com>
Date:   Wed, 5 May 2021 20:40:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d181b674-66fb-1719-e3c6-e4217cf5519c@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.2021 18:58, Jason Baron wrote:
> 
> 
> On 5/3/21 3:40 PM, Heiner Kallweit wrote:
>> e820 emits quite some debug messages to the dmesg log. Let's restrict
>> this to cases where the debug output is actually requested. Switch to
>> pr_debug() for this purpose and make sure by checking the return code
>> that pr_cont() is only called if applicable.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  arch/x86/kernel/e820.c | 27 ++++++++++++++++-----------
>>  1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index bc0657f0d..67ad4d8f0 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -465,6 +465,7 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>>  	u64 end;
>>  	unsigned int i;
>>  	u64 real_updated_size = 0;
>> +	int printed;
>>  
>>  	BUG_ON(old_type == new_type);
>>  
>> @@ -472,11 +473,13 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>>  		size = ULLONG_MAX - start;
>>  
>>  	end = start + size;
>> -	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>> -	e820_print_type(old_type);
>> -	pr_cont(" ==> ");
>> -	e820_print_type(new_type);
>> -	pr_cont("\n");
>> +	printed = pr_debug("e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>> +	if (printed > 0) {
>> +		e820_print_type(old_type);
>> +		pr_cont(" ==> ");
>> +		e820_print_type(new_type);
>> +		pr_cont("\n");
>> +	}
> 
> 
> Hi Heiner,
> 
> We've been doing these like:
> 
> DEFINE_DYNAMIC_DEBUG_METADATA(e820_dbg, "e820 verbose mode");
> 
> .
> .
> .
> 
> if (DYNAMIC_DEBUG_BRANCH(e820_debg)) {
>     printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>     e820_print_type(old_type);
>     pr_cont(" ==> ");
>     e820_print_type(new_type);
>     pr_cont("\n");
> }
> 
> 
> You could then have one DEFINE_DYNAMIC_DEBUG_METADATA statement - such that it enables
> it all in one go, or do separate ones that enable it how you see fit.
> 
> Would that work here?
> 

How would we handle the case that CONFIG_DYNAMIC_DEBUG_CORE isn't defined?
Then also DEFINE_DYNAMIC_DEBUG_METADATA isn't defined and we'd need to
duplicate the logic used here:

#if defined(CONFIG_DYNAMIC_DEBUG) || \
	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
#include <linux/dynamic_debug.h>
#define pr_debug(fmt, ...)			\
	dynamic_pr_debug(fmt, ##__VA_ARGS__)
#elif defined(DEBUG)
#define pr_debug(fmt, ...) \
	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#else
#define pr_debug(fmt, ...) \
	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#endif

IMO it's better to have the complexity of using DEFINE_DYNAMIC_DEBUG_METADATA
only once in the implementation of dynamic_pr_debug(), and not in every
code that wants to use pr_debug() in combination with pr_cont().

Also I think that to a certain extent pr_debug() is broken currently in case
of dynamic debugging because it has no return value, one drawback of
using not type-safe macros. This doesn't hurt so far because no caller seems to
check the return value or very few people have dynamic debugging enabled.

> Thanks,
> 
> -Jason
> 

Heiner

>>  
>>  	for (i = 0; i < table->nr_entries; i++) {
>>  		struct e820_entry *entry = &table->entries[i];
>> @@ -540,7 +543,7 @@ static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type o
>>  /* Remove a range of memory from the E820 table: */
>>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
>>  {
>> -	int i;
>> +	int printed, i;
>>  	u64 end;
>>  	u64 real_removed_size = 0;
>>  
>> @@ -548,10 +551,12 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
>>  		size = ULLONG_MAX - start;
>>  
>>  	end = start + size;
>> -	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
>> -	if (check_type)
>> -		e820_print_type(old_type);
>> -	pr_cont("\n");
>> +	printed = pr_debug("e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
>> +	if (printed > 0) {
>> +		if (check_type)
>> +			e820_print_type(old_type);
>> +		pr_cont("\n");
>> +	}
>>  
>>  	for (i = 0; i < e820_table->nr_entries; i++) {
>>  		struct e820_entry *entry = &e820_table->entries[i];
>> @@ -1230,7 +1235,7 @@ void __init e820__reserve_resources_late(void)
>>  		if (start >= end)
>>  			continue;
>>  
>> -		printk(KERN_DEBUG "e820: reserve RAM buffer [mem %#010llx-%#010llx]\n", start, end);
>> +		pr_debug("e820: reserve RAM buffer [mem %#010llx-%#010llx]\n", start, end);
>>  		reserve_region_with_split(&iomem_resource, start, end, "RAM buffer");
>>  	}
>>  }
>>

