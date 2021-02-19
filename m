Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7287C31F783
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhBSKo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:44:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhBSKoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613731372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHQcr2/sIGEkNpsTNCW8sWG7GDqb/gPUn+AcpCELTFw=;
        b=TXOjVOUdagxJkMGS4cg5rp1vW4LNpRyGAi+fH4+jG3367Iss5NYSjfodHGUGyqsQ+N4fao
        1d9ubIpOKIkWKHjWFs8vUKYT1mEx7UVQ88YpXrjm+e4fBMnmCnvqdAbf4hDCcO4hQFKy1G
        gAYlbBwZNhYN1Q50r6p7dlFTa+kzL/o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-rjujWQWOPNe9aUUL2kH5Dw-1; Fri, 19 Feb 2021 05:42:50 -0500
X-MC-Unique: rjujWQWOPNe9aUUL2kH5Dw-1
Received: by mail-ej1-f72.google.com with SMTP id jl9so1843967ejc.18
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHQcr2/sIGEkNpsTNCW8sWG7GDqb/gPUn+AcpCELTFw=;
        b=TGn4zSS7KIdJjSnfqp9o9w1WC69lm8VYwlxomxNdsATn365AjWqLXvgYjcQTLmkHC1
         r3nRP8FOZS3afDDl4e6WevWJgzjcF2Au4SQRh+XQEW3e4Tu0KXv8Uzi5p26G6eCoXNUL
         Ljuzx7JggoKTc8VA8d0M7dYVsSNVWdMSVPRkOJIAI2QEZfQSJ9LQRWJyKQrPcRC52mcs
         6KnVPZTrZ3z+jZpRIYBbCWHgmVKbrm8knKBK+sMxOUkgkMTL8itK6DH6Mf/4SWpU3Kbz
         Uiq2RHeL5o7zTPEcekpiL9o1+BjuHs7+R1dgNjrDwQfaUyqi1Bh5p8EKr46TwEJNwV6K
         mM8g==
X-Gm-Message-State: AOAM533v8kBdtskFOHVJbek3bVWNDvlleFVYYnExuOVj2TiP0bNBtD5R
        OiQm12/n8E9YFoPwL+2NGQhGXC14A1F+6nUYo8sgd1tG14yJyNw9EXIpk3sz8RwUbRYReLO+GgI
        YrRPT6R14KmphK0vND5z4dOzP
X-Received: by 2002:a17:906:c01:: with SMTP id s1mr8252410ejf.412.1613731369394;
        Fri, 19 Feb 2021 02:42:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvJBv5dF7NIC6t+tnVdXePC77S52Aufd8Lr3gzlYGPc4NpMg1STmKjtEtdNsZMpNASZdH6xw==
X-Received: by 2002:a17:906:c01:: with SMTP id s1mr8252407ejf.412.1613731369215;
        Fri, 19 Feb 2021 02:42:49 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q2sm4578676edv.93.2021.02.19.02.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 02:42:48 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: correct an initialization
 failure
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Alexander Naumann <alexandernaumann@gmx.de>
References: <20210218191723.20030-1-mario.limonciello@dell.com>
 <20210218224848.GB134379@linux.intel.com>
 <SA1PR19MB49261FC8B24465A86A985975FA859@SA1PR19MB4926.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <863cffc8-7257-7ee3-ecd7-d7acfbb11475@redhat.com>
Date:   Fri, 19 Feb 2021 11:42:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <SA1PR19MB49261FC8B24465A86A985975FA859@SA1PR19MB4926.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/19/21 12:26 AM, Limonciello, Mario wrote:
> 
> 
>> -----Original Message-----
>> From: mark gross <mgross@linux.intel.com>
>> Sent: Thursday, February 18, 2021 16:49
>> To: Limonciello, Mario
>> Cc: Hans De Goede; Mark Gross; LKML; platform-driver-x86@vger.kernel.org;
>> Bharathi, Divya; Alexander Naumann
>> Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: correct an initialization
>> failure
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On Thu, Feb 18, 2021 at 01:17:23PM -0600, Mario Limonciello wrote:
>>> On Dell systems that don't support this interface the module is
>>> mistakingly returning error code "0", when it should be returning
>>> -ENODEV.  Correct a logic error to guarantee the correct return code.
>>>
>>> Cc: Divya Bharathi <Divya_Bharathi@Dell.com>
>>> Reported-by: Alexander Naumann <alexandernaumann@gmx.de>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>>> ---
>>>  drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c     | 4 +++-
>>>  drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c | 4 +++-
>>>  drivers/platform/x86/dell-wmi-sysman/sysman.c                 | 4 ++--
>>>  3 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
>> b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
>>> index f95d8ddace5a..8d59f81f9db4 100644
>>> --- a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
>>> +++ b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
>>> @@ -175,7 +175,9 @@ static struct wmi_driver bios_attr_set_interface_driver
>> = {
>>>
>>>  int init_bios_attr_set_interface(void)
>>>  {
>>> -	return wmi_driver_register(&bios_attr_set_interface_driver);
>>> +	int ret = wmi_driver_register(&bios_attr_set_interface_driver);
>> I have to ask if the propper fix should be in wmi_driver_register
> 
> Do you mean something like this?
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index c669676ea8e8..89d04c5e3ab9 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1415,6 +1415,11 @@ static int acpi_wmi_probe(struct platform_device *device)
>  int __must_check __wmi_driver_register(struct wmi_driver *driver,
>                                        struct module *owner)
>  {
> +       const struct wmi_device_id *id = driver->id_table;
> +
> +       if (!wmi_has_guid(id->guid_string))
> +               return -ENODEV;
> +
>         driver->driver.owner = owner;
>         driver->driver.bus = &wmi_bus_type;
> 

No, drivers should be able to register before the GUID shows up. I know that
the GUID showing up later will likely never happen with WMI, but having a match
check like this in the driver_register function is highly unusual and would
be different from what all other busses do.

But your initial fix here is wrong too, because it does call wmi_driver_register,
which succeeds and then makes sysman_init() exit with -ENODEV.

Returning -ENODEV from sysman_init() is what we want, this causes the entire
insmod to be aborted, without logging an error (because of -ENODEV) so the
code will not be taking up memory.

This means that the memory into which the module was loaded before the kernel
calls sysman_init() will be free-ed and now the *still* registered WMI driver
entry will point to that free-ed memory, which is not good (TM).

So instead init_bios_attr_set_interface() should become something like this:

int init_bios_attr_set_interface(void)
{
	int ret;

	ret = wmi_driver_register(&bios_attr_set_interface_driver);
	if (ret)
		return ret;

	if (!wmi_priv.bios_attr_wdev) {
		wmi_driver_unregister(&bios_attr_set_interface_driver);
		return -ENODEV;
	}

	return 0;
}

And the same for the init_bios_attr_pass_interface() function.

This follows the standard kernel pattern that a function should always
undo any things / resource-allocations it has done on error before
exiting with an error.

Regards,

Hans

