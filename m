Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAC530A05E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBACh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhBAChT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:37:19 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61657C061573;
        Sun, 31 Jan 2021 18:36:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q2so9150305plk.4;
        Sun, 31 Jan 2021 18:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sWFvtqmIzfg0qnFyfhvcC23CkIyw9pCRksC4X+0MZ7o=;
        b=iVFPFpdNWKOwQHXcoTWOCSR4xLec/rsnYC537cPL74vDjY5oiFxhlmKkj+6RkKwfgW
         0gMya+ovQnTTXFxyzsCzuK2fes0LTckmhkG7R1snhIG3xi1pIZM+1xZ21ZtnjDbx8Hbq
         gUIyhB9QJtjMJWvMxE6ny0aBe0dvRAq9nV3YOD8EiTiRc1Pjh4NRCOqc7jAV2dOjwapa
         nJG1mJJkg9WU+1bKnzBvioaIIRewHfXMMn6eAHX9dfiW/JOnLklEOuWq/9z7HOFLT8v6
         1BxysPihvFLJJ5LvswkwBpGYxFBBLbnLSRwR+SfVTTbkrXqAaliA0w2+IFFXW2hqAgDO
         kQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sWFvtqmIzfg0qnFyfhvcC23CkIyw9pCRksC4X+0MZ7o=;
        b=kU7KgFzgw2ntVzuiceOpS00qn0f+/+jpwIXLuDMh3mOUqhomJHV7eBA+lORUM/YWuN
         CE5Gp8esNZSGz5jOnOLh1fqFaR9A3n1BpsuF3Z7gq477GXHzTQ1KxQGs82EdnmvspeED
         ioK0oExGeS7QIYj+m9HgFIZ66hWlusZJhMUhGe+kyrjKxtwm7fxI+FYmiD96V2QHhQFO
         fSXQxPYDJ4Dh2pO92rin5Hm0qe4LpAtuNb8dQCqVtu6d5KV6H87wCoNSDN4y/ShGQoLJ
         N562GN5QudiALqF9xH88z75PnI/EKNKDvlseDbFGzxlGAdwqAYIRIn5Dm/IMuXOlC1U1
         dWmw==
X-Gm-Message-State: AOAM5306OYq0tQIISBkKqQJ/jlcIdwv6Ixn8matMeYTbDKlL15R2hEau
        z4+VSc1CyYwGFE2j8V7ubqQvFY0QmDxx1g==
X-Google-Smtp-Source: ABdhPJyXK1YD1NC+s7qF2Pfib6QmoRBkbx6OjeTnThr08jkOBPFzxiNmNvVaWHMCuWs7BSAfpS+igg==
X-Received: by 2002:a17:902:309:b029:e1:536b:4ab with SMTP id 9-20020a1709020309b02900e1536b04abmr4200277pld.65.1612146998412;
        Sun, 31 Jan 2021 18:36:38 -0800 (PST)
Received: from [0.0.0.0] (n218250008152.netvigator.com. [218.250.8.152])
        by smtp.gmail.com with ESMTPSA id c11sm13960524pfl.185.2021.01.31.18.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 18:36:37 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
To:     Hans de Goede <hdegoede@redhat.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20210129172654.2326751-1-mario.limonciello@dell.com>
 <0da9ca30-53b1-8d34-4fc7-62edb6423b26@redhat.com>
 <SA1PR19MB49263EE7ECF0D06962BE00ECFAB79@SA1PR19MB4926.namprd19.prod.outlook.com>
 <a371c1c9-d803-f2e6-dfca-607a0650345f@redhat.com>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <8c51e60a-f5be-610a-ab13-84223d291a45@gmail.com>
Date:   Mon, 1 Feb 2021 10:36:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <a371c1c9-d803-f2e6-dfca-607a0650345f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/1 4:59, Hans de Goede wrote:
> Hi,
> 
> On 1/31/21 3:04 PM, Limonciello, Mario wrote:
>>
>>
>>> -----Original Message-----
>>> From: Hans de Goede <hdegoede@redhat.com>
>>> Sent: Saturday, January 30, 2021 15:44
>>> To: Limonciello, Mario; Mark Gross
>>> Cc: LKML; platform-driver-x86@vger.kernel.org
>>> Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
>>> dereference
>>>
>>>
>>> [EXTERNAL EMAIL]
>>>
>>> Hi,
>>>
>>> On 1/29/21 6:26 PM, Mario Limonciello wrote:
>>>> An upcoming Dell platform is causing a NULL pointer dereference
>>>> in dell-wmi-sysman initialization.  Validate that the input from
>>>> BIOS matches correct ACPI types and abort module initialization
>>>> if it fails.
>>>>
>>>> This leads to a memory leak that needs to be cleaned up properly.
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>>>> ---
>>>>   drivers/platform/x86/dell-wmi-sysman/sysman.c | 8 +++++++-
>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c
>>> b/drivers/platform/x86/dell-wmi-sysman/sysman.c
>>>> index dc6dd531c996..38b497991071 100644
>>>> --- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
>>>> +++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
>>>> @@ -419,13 +419,19 @@ static int init_bios_attributes(int attr_type, const
>>> char *guid)
>>>>   		return retval;
>>>>   	/* need to use specific instance_id and guid combination to get right
>>> data */
>>>>   	obj = get_wmiobj_pointer(instance_id, guid);
>>>> -	if (!obj)
>>>> +	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
>>>> +		release_attributes_data();
>>>
>>> All calls of  init_bios_attributes() have the following error handling:
>>>
>>>          ret = init_bios_attributes(INT, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
>>>          if (ret) {
>>>                  pr_debug("failed to populate integer type attributes\n");
>>>                  goto fail_create_group;
>>>          }
>>>
>>> 	...
>>>
>>> fail_create_group:
>>>          release_attributes_data();
>>>
>>> So that added release_attributes_data() call is not necessary. If you can
>>> respin
>>> this patch Monday with the release_attributes_data(); addition dropped, then
>>> I will try to get this to Linus in time for 5.11 .
>>>
>>> Or I can fix this up locally if you agree with dropping the unnecessary
>>> release_attributes_data() call.
>>>
>>
>> Yes, please go ahead and drop the unnecessary call locally.
> 
> Ok, I've merged this into my review-hans branch and I will push this out
> to for-next as soon as a local build has finished. I'll also include
> this in my last fixes pull-req for Linus later this week.
> 
> While working on this I did notice that the function in question still
> has a bunch of further issues. But since this patch fixes a crash and has
> been tested I've decided to move forward with it as is (with the duplicate
> release_attributes_data() call dropped). The further issues can be fixed
> with follow-up patches.
> 
> So the other issues which I noticed are:
> 
> 1. Calling release_attributes_data() in the error-path here:
> 
> 	obj = get_wmiobj_pointer(instance_id, guid);
> 	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
> 		return -ENODEV;
> 	}
> 
> Is not necessary as discussed, but the added obj->type != ACPI_TYPE_PACKAGE
> which I assume triggers to fix the reported crash, means that obj is not
> NULL in which case we should free it. So this should become:
> 
> 	obj = get_wmiobj_pointer(instance_id, guid);
> 	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
> 		kfree(obj);
> 		return -ENODEV;
> 	}
> 
> Note that the kfree() will be a no-op when obj == NULL. This means that
> with just the current fix merged there is a small memleak on machines
> where we hit the error-path. I've decided that we can live with that,
> since the alternative is the crash or me pushing something untested.
> 
> 
> 2. There is a while below this if, which gets a new obj pointer:
> 
> 	obj = get_wmiobj_pointer(instance_id, guid);
> 	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
> 		kfree(obj);
> 		return -ENODEV;
> 	}
> 	elements = obj->package.elements;
> 
> 	mutex_lock(&wmi_priv.mutex);
> 	while (elements) {
> 		...
> 
> nextobj:
> 		kfree(obj);
> 		instance_id++;
> 		obj = get_wmiobj_pointer(instance_id, guid);
> 		elements = obj ? obj->package.elements : NULL;
> 	}
> 
> This is missing a check for the obj->type for the new obj when
> going into a second (or higher) iteration of the loop.
> 
> This check can be added by moving the original check to inside
> the loop like this:
> 
> 	obj = get_wmiobj_pointer(instance_id, guid);
> 
> 	mutex_lock(&wmi_priv.mutex);	
> 	while (obj) {
> 		if (obj->type != ACPI_TYPE_PACKAGE) {
> 			err = ENODEV;
> 			goto err_attr_init;
> 		}
> 		elements = obj->package.elements;
> 
> 		...
> 
> nextobj:
> 		kfree(obj);
> 		instance_id++;
> 		obj = get_wmiobj_pointer(instance_id, guid);
> 	}
> 
> 
> 3. Functions like populate_enum_data() (and the others) index the
> elements array with an index > 0 without checking the package length
> and also make assumptions about the types embedded in the package
> without checking them.
> 
> 
> 4. The err_attr_init exit path of init_bios_attributes() calls
> release_attributes_data() but that call does not just cleanup
> the results of that single init_bios_attributes() call but also
> of all previous init_bios_attributes() calls as such it makes more
> sense to leave the calling of release_attributes_data() to the caller.
> 
> Either way calling it twice once from the err_attr_init exit path
> and then again in sysman_init() feels wrong, even though I think it
> does no harm.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
>>
>> Thank you
>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>
>>>>   		return -ENODEV;
>>>> +	}
>>>>   	elements = obj->package.elements;
>>>>
>>>>   	mutex_lock(&wmi_priv.mutex);
>>>>   	while (elements) {
>>>>   		/* sanity checking */
>>>> +		if (elements[ATTR_NAME].type != ACPI_TYPE_STRING) {
>>>> +			pr_debug("incorrect element type\n");
>>>> +			goto nextobj;
>>>> +		}
>>>>   		if (strlen(elements[ATTR_NAME].string.pointer) == 0) {
>>>>   			pr_debug("empty attribute found\n");
>>>>   			goto nextobj;
>>>>
>>
> 
Hi Hans.
Could you share your the commit link after you apply this patch to your 
for-next branch?

Thank you!
Perry.

