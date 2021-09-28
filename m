Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C1F41B548
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbhI1RjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242211AbhI1RjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632850656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dge3VVGgzmJFOKMEGjGlEoUpp6t8t6xym7qtRDntnkM=;
        b=KtjSjZeKaqx4Ci6t0RBO5jqhkiLwRdlxWmkTx/kmz/UrBrYxR0nb6Xbknz3FN2+u0EPaEi
        8Pm0NGtAsr4YzvdSXttAzZM/KGNw+DrRp8RRNT4rdWok3goMZN9QabUIGIcrjpKnCJ1hSf
        F/lVzYtcEe9VwR2TFYOve8nY/YSJEBw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-o4rSt-emNkKLkTSuqYsCGA-1; Tue, 28 Sep 2021 13:37:35 -0400
X-MC-Unique: o4rSt-emNkKLkTSuqYsCGA-1
Received: by mail-ed1-f71.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so22648471edn.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dge3VVGgzmJFOKMEGjGlEoUpp6t8t6xym7qtRDntnkM=;
        b=XhDeQtr3Pockz0vZ0J1DGjmUpPx79SPlrqychVUQPzccqSPQ9VnESzlJJPjn45ujYH
         FyVngA/ew/1h5yLEGR6boZXzWIvgo1G/A+vf0lFQ2IhnRUnkJyFjZSRjupT30nhM/QTD
         kqAoLmGeo0FV99lq4XMA9r6Xa4y+eKNsqnuK1VUyg6BnqXdFMECtq+9lxENMeWrzAExL
         vfLrn+OHOyWJx7E5BxnFbcpN3biEHR+h+QtYljPXn0kEPHbnSrSo4ywZeOOzTNAcDY5E
         56WtrXyaw+x2nF3Op26JYlMh2RF6FIpw1zC42UnQvFlX9ThEKmMeRHqdKEXNs3qiRtDw
         g7MA==
X-Gm-Message-State: AOAM5337HipzbetVgQFw4e5t9lKK3CBElf4AEtjV3KH5yYXkPCOButQr
        uM8KrfPTZ9owgJQnB1lvUX54EsDCa6S1vX49YUnwhtpQKx9tyzqAfrG3USaiBZ+nk7UmiL1NE6S
        o+vZdPYKKXiHq1fbN43wcpvYT6IZwDm/dJ1y3Fd+6nIOGzjEcU2i4KurzST7kIVAOxL5ptOhh3L
        tc
X-Received: by 2002:a50:eac4:: with SMTP id u4mr8852481edp.259.1632850653685;
        Tue, 28 Sep 2021 10:37:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybEQpF8E6cr85iiKnEUDARYctZPPgmTbaT8p8ixzPpQAIyjAm+0Gu0biSEaZvQip5/a6JcOg==
X-Received: by 2002:a50:eac4:: with SMTP id u4mr8852425edp.259.1632850653270;
        Tue, 28 Sep 2021 10:37:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lb12sm10993043ejc.28.2021.09.28.10.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 10:37:32 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: Switch to common use of
 attributes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210926111908.6950-1-len.baker@gmx.com>
 <YVBaQAFVX1CeQUPE@kroah.com>
 <50135c0e-e291-509f-2286-a1e443fdf4f3@redhat.com>
 <YVM9BhHcMRVnEder@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <de92227c-5f39-ecdc-af6d-87970eba07b9@redhat.com>
Date:   Tue, 28 Sep 2021 19:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVM9BhHcMRVnEder@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/28/21 6:04 PM, Greg Kroah-Hartman wrote:
> On Tue, Sep 28, 2021 at 04:55:25PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> On 9/26/21 1:32 PM, Greg Kroah-Hartman wrote:
>>> On Sun, Sep 26, 2021 at 01:19:08PM +0200, Len Baker wrote:
>>>> As noted in the "Deprecated Interfaces, Language Features, Attributes,
>>>> and Conventions" documentation [1], size calculations (especially
>>>> multiplication) should not be performed in memory allocator (or similar)
>>>> function arguments due to the risk of them overflowing. This could lead
>>>> to values wrapping around and a smaller allocation being made than the
>>>> caller was expecting. Using those allocations could lead to linear
>>>> overflows of heap memory and other misbehaviors.
>>>>
>>>> So, to avoid open-coded arithmetic in the kzalloc() call inside the
>>>> create_attr_set() function the code must be refactored. Using the
>>>> struct_size() helper is the fast solution but it is better to switch
>>>> this code to common use of attributes.
>>>>
>>>> Then, remove all the custom code to manage hotkey attributes and use the
>>>> attribute_group structure instead, refactoring the code accordingly.
>>>> Also, to manage the optional hotkey attributes (hotkey_tablet_mode and
>>>> hotkey_radio_sw) use the is_visible callback from the same structure.
>>>>
>>>> Moreover, now the hotkey_init_tablet_mode() function never returns a
>>>> negative number. So, the check after the call can be safely removed.
>>>>
>>>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>>>>
>>>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Signed-off-by: Len Baker <len.baker@gmx.com>
>>>> ---
>>>> Hi,
>>>>
>>>> Following the suggestions made by Greg I have switch the code to common
>>>> use of attributes. However this code is untested. If someone could test
>>>> it would be great.
>>>
>>> Much better, thanks.
>>
>> This indeed is much better and a great cleanup, thanks.
>>
>>>
>>> But, I have a few questions here:
>>>
>>>> @@ -3161,9 +3106,7 @@ static void hotkey_exit(void)
>>>>  	hotkey_poll_stop_sync();
>>>>  	mutex_unlock(&hotkey_mutex);
>>>>  #endif
>>>> -
>>>> -	if (hotkey_dev_attributes)
>>>> -		delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
>>>> +	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
>>>
>>> Why do you have to manually add/remove these groups still?
>>>
>>> A huge hint that something is going wrong is when you have to call a
>>> sysfs_*() call from within a driver.  There should be proper driver_*()
>>> calls for you instead to get the job done.
>>>
>>> As this is a platform device, why not set the dev_groups variable in the
>>> platform_driver field so that these attribute groups get added and
>>> removed automatically?
>>
>> The thinkpad_acpi code talks to the ACPI object representing the
>> ThinkPad embedded-controller and that has a lot of different sub-functionalities
>> which may or may not be present depending on the model laptop as well
>> as on the hw-configuration of the model.
>>
>> The code is organized around all the different sub-functions with there
>> being a separate init + exit function for each sub-function, including
>> with first detecting in the init function if the functionality is present
>> (e.g. don't register SW_TABLETMODE_SW evdev reporting when the device
>> is not convertible / don register a WWAN rfkill if there is no WWAN modem).
>>
>> Many (but not all) of the sub-functions come with a few sysfs-attributes
>> under /sys/bus/platform/devices/thinkpad_acpi/ many of the separate
>> function_init functions therefor call sysfs_create_group() for their own
>> set of sysfs-attributes, if the function is present on the machine.
>>
>>> An example commit to look at that shows how this was converted for one
>>> driver is 5bd08a4ae3d0 ("platform: x86: hp-wmi: convert platform driver
>>> to use dev_groups").  See if that helps here as well.
>>
>> Right, that results in a very nice cleanup. But there all the attributes
>> were always registered before the patch so throwing them together in a
>> ATTRIBUTE_GROUPS(hp_wmi) makes a ton of sense.
>>
>> Here however we have all the separate function_init() blocks each
>> conditionally adding their own attributes if the function is present,
>> so that is different.
>>
>> Currently there already are 8 separate sysfs_create_group() calls in
>> the thinkpad_acpi code, so even if we want to refactor this (I'm not
>> sure that we do) then doing so would fall outside of the scope of this
>> patch.
>>
>> Greg, since this resolves / defers your remark and since this otherwise
>> is a nice cleanup I'm going to merge this version of this patch now.
> 
> Ok, but having this all in one big list of attributes does work.  You
> can have multiple attribute groups listed together (that's why it's a
> list of attribute groups, not just one attribute group that the driver
> core is expecting.)
> 
> You just put the logic of "is this group needed or not?" in the
> is_visible() callback for that group.  You then don't need the
> function_init() blocks to do anything with sysfs except maybe set a
> device variable of "I have type foo" for the is_visible() callback to
> check.
> 
> Yes, it's not obvious, but should clean up a lot of code in the end.

That is an interesting suggestion, if someone feels up to giving this
a try I wonder what the end-result will look like.

Regards,

Hans

