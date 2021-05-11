Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB2337B0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhEKVc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:32:27 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09601C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:31:21 -0700 (PDT)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 14BLPd2K027188;
        Tue, 11 May 2021 22:31:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=9+Q4xnS7RrVmGpZ2y79+QUb6JyhBsgEhpfGAthy/fYo=;
 b=nelLnh0Vwbd/mKZh7FoKwfq1DtGtvfYnesCX9se0P9aZlabeatsassqHf4SHTKJ9HU13
 MXXuIzJG9fyB7ENAABj9I7PbnUxTQGJ4yVUxHKfgYHdUFWnxzEZQZsHqPxC1qXO1S7NG
 08inc2Cy6wRtqJP0GfGqCbe4haYSg0S3svKi4U82jg19XLCMS+Sf5tgwyYCZMdJHzKlP
 ar8hMBHXbzl0tYNmdqBDeMM8rIqDKVbXPTfNpyDhsPZMeiveM1uVpQWXkt08tkVfqqgT
 N1+l6QxZY+dIFz5GiotMfgHUdsFv7yOvne7i+fSd2K6Ax9h4WMPDVfdCkDSczPEBCGsw uA== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 38fn506wnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 22:31:09 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 14BLIil4023128;
        Tue, 11 May 2021 17:31:08 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
        by prod-mail-ppoint4.akamai.com with ESMTP id 38dp003yab-1;
        Tue, 11 May 2021 17:31:07 -0400
Received: from [0.0.0.0] (unknown [172.27.119.138])
        by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id 6739F558;
        Tue, 11 May 2021 21:31:07 +0000 (GMT)
Subject: Re: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log
 with debug messages
To:     Heiner Kallweit <hkallweit1@gmail.com>,
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
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <5a416031-ddcd-7ef4-ec33-47134bf064bb@akamai.com>
Date:   Tue, 11 May 2021 17:31:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <204a99e1-de7a-4434-0932-45f1b507e9ec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_04:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110144
X-Proofpoint-ORIG-GUID: eMkNRDdrp0JZmr0dysUEvKZGel8VHgtE
X-Proofpoint-GUID: eMkNRDdrp0JZmr0dysUEvKZGel8VHgtE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_04:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110145
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.32)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/21 4:36 PM, Heiner Kallweit wrote:
> On 11.05.2021 05:21, Jason Baron wrote:
>>
>>
>> On 5/5/21 2:40 PM, Heiner Kallweit wrote:
>>> On 05.05.2021 18:58, Jason Baron wrote:
>>>>
>>>>
>>>> On 5/3/21 3:40 PM, Heiner Kallweit wrote:
>>>>> e820 emits quite some debug messages to the dmesg log. Let's restrict
>>>>> this to cases where the debug output is actually requested. Switch to
>>>>> pr_debug() for this purpose and make sure by checking the return code
>>>>> that pr_cont() is only called if applicable.
>>>>>
>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>> ---
>>>>>  arch/x86/kernel/e820.c | 27 ++++++++++++++++-----------
>>>>>  1 file changed, 16 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>>>>> index bc0657f0d..67ad4d8f0 100644
>>>>> --- a/arch/x86/kernel/e820.c
>>>>> +++ b/arch/x86/kernel/e820.c
>>>>> @@ -465,6 +465,7 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>>>>>  	u64 end;
>>>>>  	unsigned int i;
>>>>>  	u64 real_updated_size = 0;
>>>>> +	int printed;
>>>>>  
>>>>>  	BUG_ON(old_type == new_type);
>>>>>  
>>>>> @@ -472,11 +473,13 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>>>>>  		size = ULLONG_MAX - start;
>>>>>  
>>>>>  	end = start + size;
>>>>> -	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>>>>> -	e820_print_type(old_type);
>>>>> -	pr_cont(" ==> ");
>>>>> -	e820_print_type(new_type);
>>>>> -	pr_cont("\n");
>>>>> +	printed = pr_debug("e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>>>>> +	if (printed > 0) {
>>>>> +		e820_print_type(old_type);
>>>>> +		pr_cont(" ==> ");
>>>>> +		e820_print_type(new_type);
>>>>> +		pr_cont("\n");
>>>>> +	}
>>>>
>>>>
>>>> Hi Heiner,
>>>>
>>>> We've been doing these like:
>>>>
>>>> DEFINE_DYNAMIC_DEBUG_METADATA(e820_dbg, "e820 verbose mode");
>>>>
>>>> .
>>>> .
>>>> .
>>>>
>>>> if (DYNAMIC_DEBUG_BRANCH(e820_debg)) {
>>>>     printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>>>>     e820_print_type(old_type);
>>>>     pr_cont(" ==> ");
>>>>     e820_print_type(new_type);
>>>>     pr_cont("\n");
>>>> }
>>>>
>>>>
>>>> You could then have one DEFINE_DYNAMIC_DEBUG_METADATA statement - such that it enables
>>>> it all in one go, or do separate ones that enable it how you see fit.
>>>>
>>>> Would that work here?
>>>>
>>>
>>> How would we handle the case that CONFIG_DYNAMIC_DEBUG_CORE isn't defined?
>>> Then also DEFINE_DYNAMIC_DEBUG_METADATA isn't defined and we'd need to
>>> duplicate the logic used here:
>>>
>>> #if defined(CONFIG_DYNAMIC_DEBUG) || \
>>> 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>>> #include <linux/dynamic_debug.h>
>>> #define pr_debug(fmt, ...)			\
>>> 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
>>> #elif defined(DEBUG)
>>> #define pr_debug(fmt, ...) \
>>> 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>> #else
>>> #define pr_debug(fmt, ...) \
>>> 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>> #endif
>>>
>>
>> I'm not sure we need to duplicate all that I think we just need something
>> like the following for the !CONFIG_DYNAMIC_DEBUG_CORE case. Would this
>> help?
>>
>> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
>> index a57ee75..91ede70 100644
>> --- a/include/linux/dynamic_debug.h
>> +++ b/include/linux/dynamic_debug.h
>> @@ -182,6 +182,15 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>>  #include <linux/errno.h>
>>  #include <linux/printk.h>
>>
>> +#ifdef DEBUG
>> +#define DYNAMIC_DEBUG_BRANCH(descriptor) true
>> +#else
>> +#define DYNAMIC_DEBUG_BRANCH(descriptor) false
>> +#if
>> +
>> +#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
>> +
>> +
>>  static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
>>                                     const char *modname)
>>  {
>>
>>
>>
>>> IMO it's better to have the complexity of using DEFINE_DYNAMIC_DEBUG_METADATA
>>> only once in the implementation of dynamic_pr_debug(), and not in every
>>> code that wants to use pr_debug() in combination with pr_cont().
>>
>> I think for your use-case it would just require one DEFINE_DYNAMIC_DEBUG_METADATA()
>> statement?
>>
> The point is that e820 isn't interested in using dynamic debugging. It just

I'm a little confused by this statement because in your changelog you say:

"
e820 emits quite some debug messages to the dmesg log. Let's restrict
this to cases where the debug output is actually requested.
"

So doesn't this mean you are intending to use dynamic debug to allow the user
to increase the verbosity if they want?

> would need to be able to deal with it because pr_debug() uses it. The actual
> issue is independent of e820. It boils down to pr_cont() having no way to find
> out whether it should print something or not if it follows a pr_debug() and
> dynamic debugging is enabled.

Ok, well the using the DYNAMIC_DEBUG_BRANCH() will address this b/c the branch
is controlled by dynamic debug.

That said, I do see the value in not having to open code the branch stuff, and
making pr_debug() consistent with printk which does return a value. So that
makes sense to me.

Thanks,

-Jason

> 
>>>
>>> Also I think that to a certain extent pr_debug() is broken currently in case
>>> of dynamic debugging because it has no return value, one drawback of
>>> using not type-safe macros. This doesn't hurt so far because no caller seems to
>>> check the return value or very few people have dynamic debugging enabled.
>>
>> The model of:
>>
>> DEFINE_DYNAMIC_DEBUG_METADATA(foo, "enble_foo");
>>
>> .
>> .
>> .
>>
>> if (DYNAMIC_DEBUG_BRANCH(foo) {
>> 	do debugging stuff;
>> }
>>
>> Seems more general since the 'do debugging stuff' doesn't have to be limited
>> to printk, it can be anything. So if we add another different model for this
>> use-case, it seems like it might be less general.
>>
>> Thanks,
>>
>> -Jason
>>
> Heiner
> 
