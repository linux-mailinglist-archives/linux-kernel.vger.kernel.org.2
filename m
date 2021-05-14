Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45243811D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhENUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhENUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:33:36 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B81C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:32:24 -0700 (PDT)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 14EKTtDa027805;
        Fri, 14 May 2021 21:32:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=wW7H7glHKzE73ZmnXDS13cez+jot49thtnO1hqWfkwQ=;
 b=FbU4UoYxSrqNYPWSVQ/CYm/iwp1KEXvpvB7UL8LpAJlC+rLs5NPAdhAVh9RmXRloOMYE
 je3IqLWvCO5gJ/UQDlv6+LPU9EVdwuSIdVi9vjOVhlFLaYOFAryIQcdkZSRSMM/3BskT
 1MJ6JLeNwXX+uEv+xgG8WZ5dog3tBoPGsazPhLkERNzfp5qWoqhMcqUHonnWjILRAig7
 Z6T/NT+0RNKJJwAom8W2jZCtXKK14ZbRYqnrmQwpd3gGXzxO0eTmlwnq/IC3p62rfIhs
 kYHNGgyEGYFdBc9Lsj82xZgoAKrOVZ5OwdPXEI3fMr5fhVLv3HfS6atcX+3nVXMT2Mzi tw== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 38hexpxguf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 21:32:04 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 14EKKgYx011961;
        Fri, 14 May 2021 16:32:03 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint2.akamai.com with ESMTP id 38gpmrn8pk-1;
        Fri, 14 May 2021 16:32:03 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id D679B450C2;
        Fri, 14 May 2021 20:32:02 +0000 (GMT)
Subject: Re: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log
 with debug messages
To:     Joe Perches <joe@perches.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <dc9a9818-da7f-8ca0-5583-9082e7e9c5e8@akamai.com>
Date:   Fri, 14 May 2021 16:32:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2c95dc4c4347b048abee283be90a9a2ae272ddbe.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_10:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140161
X-Proofpoint-ORIG-GUID: 30G4ta0vuAf0o_MVvxtALe1RXMLWC4Ft
X-Proofpoint-GUID: 30G4ta0vuAf0o_MVvxtALe1RXMLWC4Ft
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_10:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140163
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.19)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/21 4:22 PM, Joe Perches wrote:
> On Fri, 2021-05-14 at 15:56 -0400, Jason Baron wrote:
>>
>> On 5/14/21 1:38 PM, Joe Perches wrote:
>>> On Tue, 2021-05-11 at 17:31 -0400, Jason Baron wrote:
>>>
>>>> That said, I do see the value in not having to open code the branch stuff, and
>>>> making pr_debug() consistent with printk which does return a value. So that
>>>> makes sense to me.
>>>
>>> IMO: printk should not return a value.
>>>
>>
>> Ok, the issue we are trying to resolve is to control whether a 'pr_debug()' statement
>> is enabled and thus use that to control subsequent output. The proposed patch does:
>>
>>
>> +	printed = pr_debug("e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>> +	if (printed > 0) {
>> +		e820_print_type(old_type);
>> +		pr_cont(" ==> ");
>> +		e820_print_type(new_type);
>> +		pr_cont("\n");
>> +	}
>>
>> I do think pr_debug() here is different from printk() b/c it can be explicitly
>> toggled.
>>
>> I also suggested an alternative, which is possible with the current code which
>> is to use DYNAMIC_DEBUG_BRANCH().
>>
>> if (DYNAMIC_DEBUG_BRANCH(e820_debg)) {
>>     printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>>     e820_print_type(old_type);
>>     pr_cont(" ==> ");
>>     e820_print_type(new_type);
>>     pr_cont("\n");
>> }
>>
>> That however does require one to do something like this first:
>>
>> DEFINE_DYNAMIC_DEBUG_METADATA(e820_dbg, "e820 verbose mode");
>>
>> So I don't feel too strongly either way, but maybe others do?
> 
> Why not avoid the problem by using temporaries on the stack
> and not use pr_cont altogether?

Nice. That's fine with me Heiner?

I think though Heiner wants to use pr_debug() below instead of printk
with KERN_DEBUG, at least that was my understanding. But that would
be a simpple s/printk/pr_debug().

Thanks,

-Jason




> ---
>  arch/x86/kernel/e820.c | 71 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index bc0657f0deed..a6e7ab4b522b 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -184,20 +184,38 @@ void __init e820__range_add(u64 start, u64 size, enum e820_type type)
>  	__e820__range_add(e820_table, start, size, type);
>  }
>  
> -static void __init e820_print_type(enum e820_type type)
> +static char * __init e820_fmt_type(enum e820_type type, char *buf, size_t size)
>  {
>  	switch (type) {
> -	case E820_TYPE_RAM:		/* Fall through: */
> -	case E820_TYPE_RESERVED_KERN:	pr_cont("usable");			break;
> -	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
> -	case E820_TYPE_SOFT_RESERVED:	pr_cont("soft reserved");		break;
> -	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
> -	case E820_TYPE_NVS:		pr_cont("ACPI NVS");			break;
> -	case E820_TYPE_UNUSABLE:	pr_cont("unusable");			break;
> -	case E820_TYPE_PMEM:		/* Fall through: */
> -	case E820_TYPE_PRAM:		pr_cont("persistent (type %u)", type);	break;
> -	default:			pr_cont("type %u", type);		break;
> +	case E820_TYPE_RAM:
> +	case E820_TYPE_RESERVED_KERN:
> +		strscpy(buf, "usable", size);
> +		break;
> +	case E820_TYPE_RESERVED:
> +		strscpy(buf, "reserved", size);
> +		break;
> +	case E820_TYPE_SOFT_RESERVED:
> +		strscpy(buf, "soft reserved", size);
> +		break;
> +	case E820_TYPE_ACPI:
> +		strscpy(buf, "ACPI data", size);
> +		break;
> +	case E820_TYPE_NVS:
> +		strscpy(buf, "ACPI NVS", size);
> +		break;
> +	case E820_TYPE_UNUSABLE:
> +		strscpy(buf, "unusable", size);
> +		break;
> +	case E820_TYPE_PMEM:
> +	case E820_TYPE_PRAM:
> +		scnprintf(buf, size, "persistent (type %u)", type);
> +		break;
> +	default:
> +		scnprintf(buf, size, "type %u", type);
> +		break;
>  	}
> +
> +	return buf;
>  }
>  
>  void __init e820__print_table(char *who)
> @@ -205,13 +223,14 @@ void __init e820__print_table(char *who)
>  	int i;
>  
>  	for (i = 0; i < e820_table->nr_entries; i++) {
> -		pr_info("%s: [mem %#018Lx-%#018Lx] ",
> +		char type[32];
> +
> +		pr_info("%s: [mem %#018Lx-%#018Lx] %s\n",
>  			who,
>  			e820_table->entries[i].addr,
> -			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
> -
> -		e820_print_type(e820_table->entries[i].type);
> -		pr_cont("\n");
> +			e820_table->entries[i].addr + e820_table->entries[i].size - 1,
> +			e820_fmt_type(e820_table->entries[i].type,
> +				      type, sizeof(type)));
>  	}
>  }
>  
> @@ -465,6 +484,8 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>  	u64 end;
>  	unsigned int i;
>  	u64 real_updated_size = 0;
> +	char type1[32];
> +	char type2[32];
>  
>  	BUG_ON(old_type == new_type);
>  
> @@ -472,11 +493,10 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>  		size = ULLONG_MAX - start;
>  
>  	end = start + size;
> -	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
> -	e820_print_type(old_type);
> -	pr_cont(" ==> ");
> -	e820_print_type(new_type);
> -	pr_cont("\n");
> +	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] %s ==> %s\n",
> +	       start, end - 1,
> +	       e820_fmt_type(old_type, type1, sizeof(type1)),
> +	       e820_fmt_type(new_type, type2, sizeof(type2)));
>  
>  	for (i = 0; i < table->nr_entries; i++) {
>  		struct e820_entry *entry = &table->entries[i];
> @@ -543,15 +563,16 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
>  	int i;
>  	u64 end;
>  	u64 real_removed_size = 0;
> +	char type[32];
>  
>  	if (size > (ULLONG_MAX - start))
>  		size = ULLONG_MAX - start;
>  
>  	end = start + size;
> -	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
> -	if (check_type)
> -		e820_print_type(old_type);
> -	pr_cont("\n");
> +	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx]%s%s\n",
> +	       start, end - 1,
> +	       check_type ? " " : "",
> +	       check_type ? e820_fmt_type(old_type, type, sizeof(type)) : "");
>  
>  	for (i = 0; i < e820_table->nr_entries; i++) {
>  		struct e820_entry *entry = &e820_table->entries[i];
> 
> 
