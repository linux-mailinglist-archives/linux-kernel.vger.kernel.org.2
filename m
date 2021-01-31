Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA5309F0B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 22:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhAaVJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 16:09:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbhAaVAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 16:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612126745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTdfeZUlmDAGnUPUg1Sx+tWBlHdEKi++bIDvsDvVpgY=;
        b=B8xQ6At5iBbNkz8F1PmFCvLWCDGMui4HDa1Cntw0o4bCKjeDZs6fcYJ/gdYeO081ULacAg
        9/sE73MOXZKMw6IX5qLCn8eFprAoXoXSMTxEcdIGOQvZ5T5r+J8Juwu8zIVNW52K50AoOi
        yfOEqjbnDpvyYtmCxjTBdKXuTdWv8Qg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-gn9vdxpeNjSU_FJO3xXkPg-1; Sun, 31 Jan 2021 15:59:03 -0500
X-MC-Unique: gn9vdxpeNjSU_FJO3xXkPg-1
Received: by mail-ed1-f69.google.com with SMTP id a24so6900009eda.14
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 12:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BTdfeZUlmDAGnUPUg1Sx+tWBlHdEKi++bIDvsDvVpgY=;
        b=tM3mX0UR+NPEEMTG8y+QncYGqGPsE24JNpemYEO0BQmRC1CquVN0xgWNtMqvMQHKT3
         XIFHKxcbflxjlvba7OXGEWlZT/n3M1G9vSqg8If27NgfpbJC0YuzalfsnuZNfAOtNffc
         rCC9TmUJikHBgrZlzWOdPmuI5HXB7qAOgDQVz2QANYmVyCnbJNyuomF9r0khh2FXttd7
         L+UvIdEr8Ws1JtkDV5SH1b6Re5XeOgnWoLEjMkc/FsXWVmFiQvtTP8pSdEg0FUx4clzq
         jW4Zall+qh/Bouz7RO21GmpSWVk6g7pmLvBBrnPqpiMg0wM3VP5XtcC6cvhqyXQ3MF2F
         bvBQ==
X-Gm-Message-State: AOAM532PG4HvutewZhKyrBr/4+ViULvLye2O5B2WkIPjjQKyVm8oAwmM
        +MdZFZWRrdvneAw7vlm86PuM37Ptrblg95oMzh/do68GOFzJZcVKOUr8YVCsYcJqJQt5oHnRvnp
        b7xdgfke6y+lAl7o1SE6P6uCU
X-Received: by 2002:a17:906:69c2:: with SMTP id g2mr14105193ejs.249.1612126741663;
        Sun, 31 Jan 2021 12:59:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjz533QMFNl6H/Ne8MsDH5LPiFLL/aCHyz1ZQYHciPk1o13+N380W5/ysDpK+OT6xjT3K8Gw==
X-Received: by 2002:a17:906:69c2:: with SMTP id g2mr14105189ejs.249.1612126741520;
        Sun, 31 Jan 2021 12:59:01 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id cw21sm7601846edb.85.2021.01.31.12.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 12:59:00 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20210129172654.2326751-1-mario.limonciello@dell.com>
 <0da9ca30-53b1-8d34-4fc7-62edb6423b26@redhat.com>
 <SA1PR19MB49263EE7ECF0D06962BE00ECFAB79@SA1PR19MB4926.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a371c1c9-d803-f2e6-dfca-607a0650345f@redhat.com>
Date:   Sun, 31 Jan 2021 21:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SA1PR19MB49263EE7ECF0D06962BE00ECFAB79@SA1PR19MB4926.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/31/21 3:04 PM, Limonciello, Mario wrote:
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Saturday, January 30, 2021 15:44
>> To: Limonciello, Mario; Mark Gross
>> Cc: LKML; platform-driver-x86@vger.kernel.org
>> Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
>> dereference
>>
>>
>> [EXTERNAL EMAIL]
>>
>> Hi,
>>
>> On 1/29/21 6:26 PM, Mario Limonciello wrote:
>>> An upcoming Dell platform is causing a NULL pointer dereference
>>> in dell-wmi-sysman initialization.  Validate that the input from
>>> BIOS matches correct ACPI types and abort module initialization
>>> if it fails.
>>>
>>> This leads to a memory leak that needs to be cleaned up properly.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>>> ---
>>>  drivers/platform/x86/dell-wmi-sysman/sysman.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c
>> b/drivers/platform/x86/dell-wmi-sysman/sysman.c
>>> index dc6dd531c996..38b497991071 100644
>>> --- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
>>> +++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
>>> @@ -419,13 +419,19 @@ static int init_bios_attributes(int attr_type, const
>> char *guid)
>>>  		return retval;
>>>  	/* need to use specific instance_id and guid combination to get right
>> data */
>>>  	obj = get_wmiobj_pointer(instance_id, guid);
>>> -	if (!obj)
>>> +	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
>>> +		release_attributes_data();
>>
>> All calls of  init_bios_attributes() have the following error handling:
>>
>>         ret = init_bios_attributes(INT, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
>>         if (ret) {
>>                 pr_debug("failed to populate integer type attributes\n");
>>                 goto fail_create_group;
>>         }
>>
>> 	...
>>
>> fail_create_group:
>>         release_attributes_data();
>>
>> So that added release_attributes_data() call is not necessary. If you can
>> respin
>> this patch Monday with the release_attributes_data(); addition dropped, then
>> I will try to get this to Linus in time for 5.11 .
>>
>> Or I can fix this up locally if you agree with dropping the unnecessary
>> release_attributes_data() call.
>>
> 
> Yes, please go ahead and drop the unnecessary call locally.

Ok, I've merged this into my review-hans branch and I will push this out
to for-next as soon as a local build has finished. I'll also include
this in my last fixes pull-req for Linus later this week.

While working on this I did notice that the function in question still
has a bunch of further issues. But since this patch fixes a crash and has
been tested I've decided to move forward with it as is (with the duplicate
release_attributes_data() call dropped). The further issues can be fixed
with follow-up patches.

So the other issues which I noticed are:

1. Calling release_attributes_data() in the error-path here:

	obj = get_wmiobj_pointer(instance_id, guid);
	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
		return -ENODEV;
	}

Is not necessary as discussed, but the added obj->type != ACPI_TYPE_PACKAGE
which I assume triggers to fix the reported crash, means that obj is not
NULL in which case we should free it. So this should become:

	obj = get_wmiobj_pointer(instance_id, guid);
	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
		kfree(obj);
		return -ENODEV;
	}

Note that the kfree() will be a no-op when obj == NULL. This means that
with just the current fix merged there is a small memleak on machines
where we hit the error-path. I've decided that we can live with that,
since the alternative is the crash or me pushing something untested.


2. There is a while below this if, which gets a new obj pointer:

	obj = get_wmiobj_pointer(instance_id, guid);
	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
		kfree(obj);
		return -ENODEV;
	}
	elements = obj->package.elements;

	mutex_lock(&wmi_priv.mutex);
	while (elements) {
		...

nextobj:
		kfree(obj);
		instance_id++;
		obj = get_wmiobj_pointer(instance_id, guid);
		elements = obj ? obj->package.elements : NULL;
	}

This is missing a check for the obj->type for the new obj when
going into a second (or higher) iteration of the loop.

This check can be added by moving the original check to inside
the loop like this:

	obj = get_wmiobj_pointer(instance_id, guid);

	mutex_lock(&wmi_priv.mutex);	
	while (obj) {
		if (obj->type != ACPI_TYPE_PACKAGE) {
			err = ENODEV;
			goto err_attr_init;
		}
		elements = obj->package.elements;

		...

nextobj:
		kfree(obj);
		instance_id++;
		obj = get_wmiobj_pointer(instance_id, guid);
	}


3. Functions like populate_enum_data() (and the others) index the
elements array with an index > 0 without checking the package length
and also make assumptions about the types embedded in the package
without checking them.


4. The err_attr_init exit path of init_bios_attributes() calls
release_attributes_data() but that call does not just cleanup
the results of that single init_bios_attributes() call but also
of all previous init_bios_attributes() calls as such it makes more
sense to leave the calling of release_attributes_data() to the caller.

Either way calling it twice once from the err_attr_init exit path
and then again in sysman_init() feels wrong, even though I think it
does no harm.

Regards,

Hans














> 
> Thank you
> 
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>>  		return -ENODEV;
>>> +	}
>>>  	elements = obj->package.elements;
>>>
>>>  	mutex_lock(&wmi_priv.mutex);
>>>  	while (elements) {
>>>  		/* sanity checking */
>>> +		if (elements[ATTR_NAME].type != ACPI_TYPE_STRING) {
>>> +			pr_debug("incorrect element type\n");
>>> +			goto nextobj;
>>> +		}
>>>  		if (strlen(elements[ATTR_NAME].string.pointer) == 0) {
>>>  			pr_debug("empty attribute found\n");
>>>  			goto nextobj;
>>>
> 

