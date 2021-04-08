Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14D357F64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhDHJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230351AbhDHJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617874566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zgeZtu7lYTJNoMgLEgfZhX/Ur/OD43zyv0k/SO8ovA=;
        b=aw0qKL7pTE/f0eXqZ5xw7Izuxx7xO3TjfNjs4epwW3X+JdhAg/yT+rT3KboFX+8Cziq2Pr
        VGKr0POPZGN4IofELExymZncOXDsk4qKcDrG4qETregyrMGtT3wjOAxWqcUD/ZkO0o4nx8
        Bff2ZpHBDr4fFN6fSZTjVpkx9ll/itU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-0qNo0wAUMO-2rW1hVpkI-w-1; Thu, 08 Apr 2021 05:36:04 -0400
X-MC-Unique: 0qNo0wAUMO-2rW1hVpkI-w-1
Received: by mail-ej1-f71.google.com with SMTP id kx22so582623ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 02:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4zgeZtu7lYTJNoMgLEgfZhX/Ur/OD43zyv0k/SO8ovA=;
        b=Qe/YBwWxPrFNP/PlWClPb6x/B5HcFejs8JRbkueFAo23P8MgAuwr20yaa9XcVkAJk6
         CYWoTJNlWV6/2fsWRIK5aRhy8OCdvGu6JG5C2siDAQY0xpDtlAp5v2Uc+F0NAgavdyLS
         CJnbGrglNtOW8dYAePSRKmfxryJ+pBXFCnmpH4/bsXolc1O8gMnxBOumXXl7o4YvOjNO
         lHJSLwZE7KxSq96ZA0H70BcEnt4LvenlMMBBeYXetjf98Zq9FSuIy9Sdcbp+lAwYCfXr
         gzFGgglrL3ZAK4IW3bizS5YWr5MNGup33LOJN/MULlxh4MFHMnS2R94aBscW+tRM1wGd
         phPg==
X-Gm-Message-State: AOAM533NJ1znHNqVjstrnMIcE6OY9whSp6ru7YTzG1IgVlbiRnsr4mqW
        sooclXW/5MdZFNIwUxjupzQyF9etKkJlTBAIah3afFPeRPB2vlKZJINFpOLA2iaejv/AYF/+UGY
        HOYbVeYpB4ibyAmp8z7lY4N52
X-Received: by 2002:aa7:d917:: with SMTP id a23mr715804edr.80.1617874562234;
        Thu, 08 Apr 2021 02:36:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFr6Y2nAYtzqi11MsiVgwD7tg9czpm+1uB6BALSBPzE5H9ZD4ZCidjCtnwnpb4v+YB3gG+Tw==
X-Received: by 2002:aa7:d917:: with SMTP id a23mr715785edr.80.1617874562010;
        Thu, 08 Apr 2021 02:36:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id fs21sm1169029ejc.111.2021.04.08.02.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 02:36:01 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
 <44fbb57c-88ee-62f0-c72c-507cad17eb7d@redhat.com>
 <123d021b-b86b-4356-b234-fb46fa260193@t-8ch.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6993d257-fdc1-2be6-555d-86c6b8c9d18d@redhat.com>
Date:   Thu, 8 Apr 2021 11:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <123d021b-b86b-4356-b234-fb46fa260193@t-8ch.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/7/21 9:43 PM, Thomas Weißschuh wrote:
> Hi Hans,
> 
> On Mi, 2021-04-07T17:54+0200, Hans de Goede wrote:
>> Thank you for your new driver and thank you for the quick respin
>> addressing Barnabás' request to make it a WMI driver.
>>
>> The code looks good, so merging this should be a no-brainer,
>> yet I'm not sure if I should merge this driver as-is, let me
>> explain.
> 
> thanks for the encouraging words.
> 
>> The problem is that I assume that this is based on reverse-engineering?
> 
> Yes, it is completely reverse-engineered.
> Essentially I stumbled upon Matthews comment at
> https://bugzilla.kernel.org/show_bug.cgi?id=204807#c37 and went from there.
> 
>> We have some mixes experiences with reverse-engineered WMI drivers,
>> sometimes a feature is not supported yet the wmi_evaluate_method()
>> call happily succeeds. One example of this causing trouble is:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1797d588af15174d4a4e7159dac8c800538e4f8c
> 
> There actually are reports of recent, similar mainboards with recent firmware and
> similar sensor chips that do not support the temperature query.
> (https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/3 and
> https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/2)
> 
> Unfortunately for unknown WMI queries the firmware does not return any value.
> This ends up as an ACPI integer with value 0 on the driver side.
> (Which I could not yet find documentation for if that is expected)
> In the current version of the driver EIO is returned for 0 values which
> get translated to N/A by lm-sensors.
> 
>> At a minimum I think your driver should check in its
>> probe function that
>>
>> gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, ...)
>>
>> actually succeeds on the machine the driver is running on chances
>> are that Gigabyte has been using the DEADBEEF-2001-0000-00A0-C90629100000
>> GUID for ages, where as the 0x125 value for GIGABYTE_WMI_TEMPERATURE_QUERY
>> suggests that this is a pretty new API.
> 
> Would it be enough to probe all six sensors and check if all return 0?

I think that failing the probe with -ENODEV, with a dev_info() explaining why when
all six sensors return 0 would be good yes, that should also fix those 2
issues on https://github.com/t-8ch/linux-gigabyte-wmi-driver/.

>> It would be good if you can see if you can find some DSDT-s for older
>> gigabyte motherboards attached to various distro's bug-tracking systems
>> or forum posts and see how those respond to an unknown gigabyte_wmi_commandtype.
> 
> Will do.

Since you alreayd have bugreports of boards where this does not work,
please don't spend too much time on this. I guess those older DSDT-s will
also just return an integer with value 0.

>> Another open question to make sure this driver is suitable
>> as a generic driver (and does not misbehave) is how to figure out
>> how many temperature sensors there actually are.
> 
> So far I could not find out how to query this from the firmware.
> The IT8688 chip can report the state of each sensor but that is not exposed by
> the firmware.
> But even the state information from the IT8688 is not accurate as is.
> One of the sensors that is reported as being active (directly via it87) on my
> machine always reports -55°C (yes, negative).

Ok.

>> Perhaps the WMI interface returns an error when you query an out-of-range
>> temperature channel?
> 
> Also "0" as mentioned above.

Hmm, so maybe this can be used to limit the amount of reported temperature
sensors, IOW if sensors 5 and 6 report 0, only register 4 sensors ?

> 
>> One option here might be to add a DMI matching table and only load on
>> systems on that table for now. That table could then perhaps also provide
>> labels for each of the temperature channels, which is something which
>> would be nice to have regardless of my worries about how well this driver
>> will work on motherboards on which it has not been tested.
> 
> I am collecting reports for working motherboards at
> https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/1 .

Good, you should probably ask reporters there to provide the output of:

grep . /sys/class/dmi/id/* 2> /dev/null

Ran as a normal user (so that the serial-numbers will be skipped) so that
you will have DMI strings to match on if you decide to go that route.

> 
>> You could combine this DMI matching table with a "force" module option to
>> continue with probing on boards which are not on the table to allow users
>> to test and report their results to you.
>>
>> And hopefully after a while, when we're confident that the code works
>> well on most gigabyte boards we can drop the DMI table, or at least
>> only use it for the channel labels.
> 
> That sounds good.
> 
>> Please don't take this the wrong way; I think it is great that you are
>> working on this. And the quick turnaround of the v2 of this drivers makes
>> me pretty certain that we can figure something out and get this merged.
> 
> Thank you for the feedback!
> 
>> Have you tried contacting Gigabyte about this? I don't think the WMI
>> interface is something which they need to keep secret for competitive
>> reasons, so maybe they can help? Note if they want you to sign a NDA
>> of sorts to view docs, then make sure that it contains some language
>> about them allowing you to release an opensource driver for their
>> hardware based on the "protected" information.
> 
> I have not contacted them yet, will do.
> 
> As mentioned in the initial patch submission there would be different ways to
> access this information firmware:
> 
> * Directly call the underlying ACPI methods (these are present in all so far
>   observed firmwares, even if not exposed via WMI).
> * Directly access the ACPI IndexField representing the it87 chip.
> * Directly access the it87 registers while holding the relevant locks via ACPI.
> 
> I assume all of those mechanisms have no place in a proper kernel driver but
> would like to get your opinion on it.

Actually the "Directly access the it87 registers" option is potentially interesting
since it will allow using the it87 driver which gives a lot more features.

I actually wrote a rough outline of how something like this could work here:

https://bugzilla.kernel.org/show_bug.cgi?id=204807#c47

Note I'm not sure if that is the right approach, but it definitely is an
option. It seems that this one might also solve the X470-AORUS-ULTRA-GAMING
case (https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/2)

Hopefully the direct-register ACPI/WMI access methods will also allow
reading the super-io vendor and product ids so that we can be reasonably
sure that we are not loading the wrong driver on a board.

OTOH the WMI-temp method approach may also work on boards where the sensors
(or some of the sensors) are not supported.

I'm afraid there is no obviously correct answer here. If you feel like it
experimenting with the "Directly access the it87 registers" option would certainly
be interesting IMHO.

It might be good to get hwmon subsystems maintainer's opinion on this
before sinking a lot of time into this though (added to the Cc).

Jean, Guenter,

Thomas has been working on a WMI driver to expose various motherboard
temperatures on a gigabyte board where the IO-addresses for the it87 chip
are reserved by ACPI. We are discussing how best to deal with this, there
are some ACPI methods to directly access the super-IO registers (with locking
to protect against other ACPI accesses). This reminded me of an idea I had
a while ago to solve a similar issue with an other superIO chip, abstract
the superIO register access-es using some reg_ops struct and allow an ACPI/WMI
driver to provide alternative reg_ops:
https://bugzilla.kernel.org/show_bug.cgi?id=204807#c47

Do you think this is a good idea (or a bad one)? And would something like that
be acceptable to you ?

Regards,

Hans

