Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2091B3812B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhENVQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhENVQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:16:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A37AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 14:15:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s82so383248wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pg+bSOJDLqnOTxoxCThMvTLmR5EUiDSHoPgbEx3a1AM=;
        b=di4Q/0PnIxJtkBoUkmtQWvt91npUwGHToPeTg23VTDoto4cqnWDAzt9Hq6XzCYDQgA
         2S1srosUrC/jJL7eOCpoQHxFGb7LGtDt1zNrRqDsD5VT1ZO/0vtK+01bLNnTdf57Kj6z
         C9vwOBs4pgVCpGmXUqYHq2fEewzDMcudUJuc0SFB5kaKoTLDhbQEnFGg60UICGzLROLp
         ODvz5R3T9gi+LJWIuZ/IckcLod1KPLjw2078ZOirNH3C1KgIaQhZ19jTDXd2pVsi56B2
         EY1EGwjivmUadO8xnd7EsGaZkDfWvB+tBSINoyfQOUdmb0DIU69SE9II9aSFu/ukNAK8
         8zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pg+bSOJDLqnOTxoxCThMvTLmR5EUiDSHoPgbEx3a1AM=;
        b=AqauE5TVrcybu2pgnR8HDHLQEKQbBGNHHxWU1oxmbty/2AdoW2S1D8A4LknFk4uIwb
         2AboHkosgtHFWA/AMxKpPLI8y991btEbgWgaAeHdmZjsIJmCECHB4no24T8EUPDQcSO4
         a0N9rqN7oJrVK2FWaXc+qubw9zkIqYPmxbttCj1sQLo4jBOQgtXs7KIL9KJZDdD5icP1
         vAFTwLSF6BQ2wEOS38Z1fpDJCaz9vQdiYMcVraGEsbV+HFvgFWX8VyULHk+AztXgbUSh
         4fyK95FFu3lASdAKt/AYWvfXXhBUvOFi0ryNzfvyo2lGXW3F9Fz6YPn5eK7EUigFoA9v
         6pcw==
X-Gm-Message-State: AOAM533hW06knyaKgQdSf8lRo6ZmnNje7o6e6rbcgwX5hwoS5By4R5cu
        A9STGKXH28BIa+4pq7Ku008iqErv5MN4fg==
X-Google-Smtp-Source: ABdhPJyDNYoBykswi9JwijOaA7MC+Vi20RZ0vbe862ORTFVgDk/rP/3QncFdjHtN4Jylcx2kLo8fkg==
X-Received: by 2002:a05:600c:4152:: with SMTP id h18mr11197608wmm.155.1621026923361;
        Fri, 14 May 2021 14:15:23 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:2cd4:2a33:f9b8:9573? (p200300ea8f3846002cd42a33f9b89573.dip0.t-ipconnect.de. [2003:ea:8f38:4600:2cd4:2a33:f9b8:9573])
        by smtp.googlemail.com with ESMTPSA id 16sm6222513wmi.13.2021.05.14.14.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 14:15:22 -0700 (PDT)
To:     Jason Baron <jbaron@akamai.com>, Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
 <6d55670d-2f06-d768-699f-5a79cece6ce0@gmail.com>
 <d181b674-66fb-1719-e3c6-e4217cf5519c@akamai.com>
 <59985635-665b-773f-de8f-b15fe3f60196@gmail.com>
 <1789b1da-7a0f-9fc9-6ed2-ff68e2306342@akamai.com>
 <204a99e1-de7a-4434-0932-45f1b507e9ec@gmail.com>
 <5a416031-ddcd-7ef4-ec33-47134bf064bb@akamai.com>
 <7cc30a8a6644bb60e5f3358e89253d9fc783fe54.camel@perches.com>
 <e0116c3e-21a3-50a4-e9fd-cb227ef0b63b@akamai.com>
 <2c95dc4c4347b048abee283be90a9a2ae272ddbe.camel@perches.com>
 <dc9a9818-da7f-8ca0-5583-9082e7e9c5e8@akamai.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log
 with debug messages
Message-ID: <6f86e0d5-338e-6321-dacd-8666a30e8f09@gmail.com>
Date:   Fri, 14 May 2021 23:15:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dc9a9818-da7f-8ca0-5583-9082e7e9c5e8@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2021 22:32, Jason Baron wrote:
> 
> 
> On 5/14/21 4:22 PM, Joe Perches wrote:
>> On Fri, 2021-05-14 at 15:56 -0400, Jason Baron wrote:
>>>
>>> On 5/14/21 1:38 PM, Joe Perches wrote:
>>>> On Tue, 2021-05-11 at 17:31 -0400, Jason Baron wrote:
>>>>
>>>>> That said, I do see the value in not having to open code the branch stuff, and
>>>>> making pr_debug() consistent with printk which does return a value. So that
>>>>> makes sense to me.
>>>>
>>>> IMO: printk should not return a value.
>>>>
>>>
>>> Ok, the issue we are trying to resolve is to control whether a 'pr_debug()' statement
>>> is enabled and thus use that to control subsequent output. The proposed patch does:
>>>
>>>
>>> +	printed = pr_debug("e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>>> +	if (printed > 0) {
>>> +		e820_print_type(old_type);
>>> +		pr_cont(" ==> ");
>>> +		e820_print_type(new_type);
>>> +		pr_cont("\n");
>>> +	}
>>>
>>> I do think pr_debug() here is different from printk() b/c it can be explicitly
>>> toggled.
>>>
>>> I also suggested an alternative, which is possible with the current code which
>>> is to use DYNAMIC_DEBUG_BRANCH().
>>>
>>> if (DYNAMIC_DEBUG_BRANCH(e820_debg)) {
>>>     printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>>>     e820_print_type(old_type);
>>>     pr_cont(" ==> ");
>>>     e820_print_type(new_type);
>>>     pr_cont("\n");
>>> }
>>>
>>> That however does require one to do something like this first:
>>>
>>> DEFINE_DYNAMIC_DEBUG_METADATA(e820_dbg, "e820 verbose mode");
>>>
>>> So I don't feel too strongly either way, but maybe others do?
>>
>> Why not avoid the problem by using temporaries on the stack
>> and not use pr_cont altogether?
> 
> Nice. That's fine with me Heiner?
> 
I once tested a similar approach, just using kasprintf() to dynamically
allocate the substrings. Still using pr_cont() looks a little bit
more elegant to me, but it has its drawbacks. Having said that:
Yes, fine with me (with pr_debug).

> I think though Heiner wants to use pr_debug() below instead of printk
> with KERN_DEBUG, at least that was my understanding. But that would
> be a simpple s/printk/pr_debug().
> 
> Thanks,
> 
> -Jason
> 

Heiner

> 
> 
> 
>> ---
>>  arch/x86/kernel/e820.c | 71 ++++++++++++++++++++++++++++++++------------------
>>  1 file changed, 46 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index bc0657f0deed..a6e7ab4b522b 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -184,20 +184,38 @@ void __init e820__range_add(u64 start, u64 size, enum e820_type type)
>>  	__e820__range_add(e820_table, start, size, type);
>>  }
>>  
>> -static void __init e820_print_type(enum e820_type type)
>> +static char * __init e820_fmt_type(enum e820_type type, char *buf, size_t size)
>>  {
>>  	switch (type) {
>> -	case E820_TYPE_RAM:		/* Fall through: */
>> -	case E820_TYPE_RESERVED_KERN:	pr_cont("usable");			break;
>> -	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
>> -	case E820_TYPE_SOFT_RESERVED:	pr_cont("soft reserved");		break;
>> -	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
>> -	case E820_TYPE_NVS:		pr_cont("ACPI NVS");			break;
>> -	case E820_TYPE_UNUSABLE:	pr_cont("unusable");			break;
>> -	case E820_TYPE_PMEM:		/* Fall through: */
>> -	case E820_TYPE_PRAM:		pr_cont("persistent (type %u)", type);	break;
>> -	default:			pr_cont("type %u", type);		break;
>> +	case E820_TYPE_RAM:
>> +	case E820_TYPE_RESERVED_KERN:
>> +		strscpy(buf, "usable", size);
>> +		break;
>> +	case E820_TYPE_RESERVED:
>> +		strscpy(buf, "reserved", size);
>> +		break;
>> +	case E820_TYPE_SOFT_RESERVED:
>> +		strscpy(buf, "soft reserved", size);
>> +		break;
>> +	case E820_TYPE_ACPI:
>> +		strscpy(buf, "ACPI data", size);
>> +		break;
>> +	case E820_TYPE_NVS:
>> +		strscpy(buf, "ACPI NVS", size);
>> +		break;
>> +	case E820_TYPE_UNUSABLE:
>> +		strscpy(buf, "unusable", size);
>> +		break;
>> +	case E820_TYPE_PMEM:
>> +	case E820_TYPE_PRAM:
>> +		scnprintf(buf, size, "persistent (type %u)", type);
>> +		break;
>> +	default:
>> +		scnprintf(buf, size, "type %u", type);
>> +		break;
>>  	}
>> +
>> +	return buf;
>>  }
>>  
>>  void __init e820__print_table(char *who)
>> @@ -205,13 +223,14 @@ void __init e820__print_table(char *who)
>>  	int i;
>>  
>>  	for (i = 0; i < e820_table->nr_entries; i++) {
>> -		pr_info("%s: [mem %#018Lx-%#018Lx] ",
>> +		char type[32];
>> +
>> +		pr_info("%s: [mem %#018Lx-%#018Lx] %s\n",
>>  			who,
>>  			e820_table->entries[i].addr,
>> -			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
>> -
>> -		e820_print_type(e820_table->entries[i].type);
>> -		pr_cont("\n");
>> +			e820_table->entries[i].addr + e820_table->entries[i].size - 1,
>> +			e820_fmt_type(e820_table->entries[i].type,
>> +				      type, sizeof(type)));
>>  	}
>>  }
>>  
>> @@ -465,6 +484,8 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>>  	u64 end;
>>  	unsigned int i;
>>  	u64 real_updated_size = 0;
>> +	char type1[32];
>> +	char type2[32];
>>  
>>  	BUG_ON(old_type == new_type);
>>  
>> @@ -472,11 +493,10 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>>  		size = ULLONG_MAX - start;
>>  
>>  	end = start + size;
>> -	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>> -	e820_print_type(old_type);
>> -	pr_cont(" ==> ");
>> -	e820_print_type(new_type);
>> -	pr_cont("\n");
>> +	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] %s ==> %s\n",
>> +	       start, end - 1,
>> +	       e820_fmt_type(old_type, type1, sizeof(type1)),
>> +	       e820_fmt_type(new_type, type2, sizeof(type2)));
>>  
>>  	for (i = 0; i < table->nr_entries; i++) {
>>  		struct e820_entry *entry = &table->entries[i];
>> @@ -543,15 +563,16 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
>>  	int i;
>>  	u64 end;
>>  	u64 real_removed_size = 0;
>> +	char type[32];
>>  
>>  	if (size > (ULLONG_MAX - start))
>>  		size = ULLONG_MAX - start;
>>  
>>  	end = start + size;
>> -	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
>> -	if (check_type)
>> -		e820_print_type(old_type);
>> -	pr_cont("\n");
>> +	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx]%s%s\n",
>> +	       start, end - 1,
>> +	       check_type ? " " : "",
>> +	       check_type ? e820_fmt_type(old_type, type, sizeof(type)) : "");
>>  
>>  	for (i = 0; i < e820_table->nr_entries; i++) {
>>  		struct e820_entry *entry = &e820_table->entries[i];
>>
>>

