Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C943587B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhDHPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhDHPAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:00:36 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62336C061760;
        Thu,  8 Apr 2021 08:00:25 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id i81so2455896oif.6;
        Thu, 08 Apr 2021 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DUxBpxs/369vcco1VxDjt78/jo05xcIgCHr4C9KoACQ=;
        b=uzT0qfiwDOLvKLLxLMTEcC7cd0imsRGprgvSri70yhHBnUX17KxVClw24YehuOEGMq
         /Zgc/jAfIXJLYMVijCR1Hy1puvU4pc6AZ3WP859icpW77sOWDm+tGRESyxBknwwNsRH4
         +BCJt7VOLGCwfuY8ykYoL4257IEwtl4OTTbUPyGmbB1jfkFKe8O1Nwpq7Poc2z32D6Ex
         gt9Wp8M3x45Yq7GvSA+G1ZZqIhS42GXIRobQ5XVJ6OmT3FhE5GyvvdSc1yu4/AJu4BmT
         wpmghf90cxy3ielnzGNLEjOQ4JOWY8eiVNcRw7t+W9ikXt1Gfj/DL0pVvwnMpTGPElqb
         +XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DUxBpxs/369vcco1VxDjt78/jo05xcIgCHr4C9KoACQ=;
        b=r+zm1niCDRORhw0GGZOOUNwjP/tHKmHMfqLw+r70q53nHRifkEBkkMWf4LvfEEaYCb
         qIzdWuGJaDQvA2LofA8Mo//4MRyQ3z/EMI4uP4VVO+QVRkGtwZ/GFll+mHkjia4PTNk3
         pvolnut4QMhZuJNEKsZZA3MqWwNRz+EO2+XvTAGUzcx2T/fgmHYEqRGMY7ofFXP2vw0p
         vmx3E4N3wIhWiA6hFc3MPgKawQRjGUh9I3y/Iu8OnFVMTz9KaHTNv49WiW3Qw8r2LprI
         QmbSNYTfQfTnShCGrkuE+mT9WSjlaAsF6aw8qBYozcCVJdNadAzK3Q1JV1W4y2Od6Sc/
         6H3w==
X-Gm-Message-State: AOAM530JZD8rSaizXB4FYa6INvabfIIOybe7hqvcHLUEdHtUiVGUv6Y8
        0oVpjZpBK+CqAuBshEvi14c=
X-Google-Smtp-Source: ABdhPJy9N/c7DNHv3MQRvbgVDxm7HLJ88QSQYTQskVQOk+69Adriqb23gMftOxgd2zRhoaAVQTv2Mw==
X-Received: by 2002:aca:2103:: with SMTP id 3mr6409312oiz.80.1617894024668;
        Thu, 08 Apr 2021 08:00:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11sm4790288oiv.19.2021.04.08.08.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:00:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
 <44fbb57c-88ee-62f0-c72c-507cad17eb7d@redhat.com>
 <123d021b-b86b-4356-b234-fb46fa260193@t-8ch.de>
 <6993d257-fdc1-2be6-555d-86c6b8c9d18d@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <d6cc98f4-1be2-f8bf-0426-58e324fc495b@roeck-us.net>
Date:   Thu, 8 Apr 2021 08:00:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6993d257-fdc1-2be6-555d-86c6b8c9d18d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 2:36 AM, Hans de Goede wrote:
> Hi,
> 
> On 4/7/21 9:43 PM, Thomas Weißschuh wrote:
>> Hi Hans,
>>
>> On Mi, 2021-04-07T17:54+0200, Hans de Goede wrote:
>>> Thank you for your new driver and thank you for the quick respin
>>> addressing Barnabás' request to make it a WMI driver.
>>>
>>> The code looks good, so merging this should be a no-brainer,
>>> yet I'm not sure if I should merge this driver as-is, let me
>>> explain.
>>
>> thanks for the encouraging words.
>>
>>> The problem is that I assume that this is based on reverse-engineering?
>>
>> Yes, it is completely reverse-engineered.
>> Essentially I stumbled upon Matthews comment at
>> https://bugzilla.kernel.org/show_bug.cgi?id=204807#c37 and went from there.
>>
>>> We have some mixes experiences with reverse-engineered WMI drivers,
>>> sometimes a feature is not supported yet the wmi_evaluate_method()
>>> call happily succeeds. One example of this causing trouble is:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1797d588af15174d4a4e7159dac8c800538e4f8c
>>
>> There actually are reports of recent, similar mainboards with recent firmware and
>> similar sensor chips that do not support the temperature query.
>> (https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/3 and
>> https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/2)
>>
>> Unfortunately for unknown WMI queries the firmware does not return any value.
>> This ends up as an ACPI integer with value 0 on the driver side.
>> (Which I could not yet find documentation for if that is expected)
>> In the current version of the driver EIO is returned for 0 values which
>> get translated to N/A by lm-sensors.
>>
>>> At a minimum I think your driver should check in its
>>> probe function that
>>>
>>> gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, ...)
>>>
>>> actually succeeds on the machine the driver is running on chances
>>> are that Gigabyte has been using the DEADBEEF-2001-0000-00A0-C90629100000
>>> GUID for ages, where as the 0x125 value for GIGABYTE_WMI_TEMPERATURE_QUERY
>>> suggests that this is a pretty new API.
>>
>> Would it be enough to probe all six sensors and check if all return 0?
> 
> I think that failing the probe with -ENODEV, with a dev_info() explaining why when
> all six sensors return 0 would be good yes, that should also fix those 2
> issues on https://github.com/t-8ch/linux-gigabyte-wmi-driver/.
> 
>>> It would be good if you can see if you can find some DSDT-s for older
>>> gigabyte motherboards attached to various distro's bug-tracking systems
>>> or forum posts and see how those respond to an unknown gigabyte_wmi_commandtype.
>>
>> Will do.
> 
> Since you alreayd have bugreports of boards where this does not work,
> please don't spend too much time on this. I guess those older DSDT-s will
> also just return an integer with value 0.
> 
>>> Another open question to make sure this driver is suitable
>>> as a generic driver (and does not misbehave) is how to figure out
>>> how many temperature sensors there actually are.
>>
>> So far I could not find out how to query this from the firmware.
>> The IT8688 chip can report the state of each sensor but that is not exposed by
>> the firmware.
>> But even the state information from the IT8688 is not accurate as is.
>> One of the sensors that is reported as being active (directly via it87) on my
>> machine always reports -55°C (yes, negative).
> 
> Ok.
> 
>>> Perhaps the WMI interface returns an error when you query an out-of-range
>>> temperature channel?
>>
>> Also "0" as mentioned above.
> 
> Hmm, so maybe this can be used to limit the amount of reported temperature
> sensors, IOW if sensors 5 and 6 report 0, only register 4 sensors ?
> 
>>
>>> One option here might be to add a DMI matching table and only load on
>>> systems on that table for now. That table could then perhaps also provide
>>> labels for each of the temperature channels, which is something which
>>> would be nice to have regardless of my worries about how well this driver
>>> will work on motherboards on which it has not been tested.
>>
>> I am collecting reports for working motherboards at
>> https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/1 .
> 
> Good, you should probably ask reporters there to provide the output of:
> 
> grep . /sys/class/dmi/id/* 2> /dev/null
> 
> Ran as a normal user (so that the serial-numbers will be skipped) so that
> you will have DMI strings to match on if you decide to go that route.
> 
>>
>>> You could combine this DMI matching table with a "force" module option to
>>> continue with probing on boards which are not on the table to allow users
>>> to test and report their results to you.
>>>
>>> And hopefully after a while, when we're confident that the code works
>>> well on most gigabyte boards we can drop the DMI table, or at least
>>> only use it for the channel labels.
>>
>> That sounds good.
>>
>>> Please don't take this the wrong way; I think it is great that you are
>>> working on this. And the quick turnaround of the v2 of this drivers makes
>>> me pretty certain that we can figure something out and get this merged.
>>
>> Thank you for the feedback!
>>
>>> Have you tried contacting Gigabyte about this? I don't think the WMI
>>> interface is something which they need to keep secret for competitive
>>> reasons, so maybe they can help? Note if they want you to sign a NDA
>>> of sorts to view docs, then make sure that it contains some language
>>> about them allowing you to release an opensource driver for their
>>> hardware based on the "protected" information.
>>
>> I have not contacted them yet, will do.
>>
>> As mentioned in the initial patch submission there would be different ways to
>> access this information firmware:
>>
>> * Directly call the underlying ACPI methods (these are present in all so far
>>   observed firmwares, even if not exposed via WMI).
>> * Directly access the ACPI IndexField representing the it87 chip.
>> * Directly access the it87 registers while holding the relevant locks via ACPI.
>>
>> I assume all of those mechanisms have no place in a proper kernel driver but
>> would like to get your opinion on it.
> 
> Actually the "Directly access the it87 registers" option is potentially interesting
> since it will allow using the it87 driver which gives a lot more features.
> 
> I actually wrote a rough outline of how something like this could work here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=204807#c47
> 
> Note I'm not sure if that is the right approach, but it definitely is an
> option. It seems that this one might also solve the X470-AORUS-ULTRA-GAMING
> case (https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/2)
> 
> Hopefully the direct-register ACPI/WMI access methods will also allow
> reading the super-io vendor and product ids so that we can be reasonably
> sure that we are not loading the wrong driver on a board.
> 
> OTOH the WMI-temp method approach may also work on boards where the sensors
> (or some of the sensors) are not supported.
> 
> I'm afraid there is no obviously correct answer here. If you feel like it
> experimenting with the "Directly access the it87 registers" option would certainly
> be interesting IMHO.
> 
> It might be good to get hwmon subsystems maintainer's opinion on this
> before sinking a lot of time into this though (added to the Cc).
> 
> Jean, Guenter,
> 
> Thomas has been working on a WMI driver to expose various motherboard
> temperatures on a gigabyte board where the IO-addresses for the it87 chip
> are reserved by ACPI. We are discussing how best to deal with this, there
> are some ACPI methods to directly access the super-IO registers (with locking
> to protect against other ACPI accesses). This reminded me of an idea I had
> a while ago to solve a similar issue with an other superIO chip, abstract
> the superIO register access-es using some reg_ops struct and allow an ACPI/WMI
> driver to provide alternative reg_ops:
> https://bugzilla.kernel.org/show_bug.cgi?id=204807#c47
> 
> Do you think this is a good idea (or a bad one)? And would something like that
> be acceptable to you ?
> 

The upstream it87 driver is severely out of date. I had an out-of-tree driver
with various improvements which I didn't upstream, first because no one was willing
to review changes and then because it had deviated too much. I pulled it from
public view because I got pounded for not upstreaming it, because people started
demanding support (not asking, demanding) for it, and because Gigabyte stopped
providing datasheets for the more recent ITE chips and it became effectively
unmaintainable.

Some ITE chips have issues which can cause system hangs if accessed directly.
I put some work to remedy that into the non-upstream driver, but that was all
just guesswork. Gigabyte knows about the problem (or so I was told from someone
who has an NDA with them), but I didn't get them or ITE to even acknowledge it
to me. I even had a support case open with Gigabyte for a while, but all I could
get out of them is that they don't support Linux and what I would have to reproduce
the problem with Windows for them to provide assistance (even though, again,
they knew about it).

As for using ACPI locks or WMI to ensure that ACPI leaves the chip alone while
the driver accesses chips directly: That is an option, but it has (at least)
two problems.

First, ACPI access methods are not well documented or standardized. I had tried
to find useful means to do that some time ago, but I gave up because each board
(even from the same vendor) handles locking and accesses differently. We would
end up with lots of board specific code. Coincidentally, that was for ASUS boards
and the nct6775 driver.

Second, access through ACPI is only one of the issues. Turns out there are two
ITE chips on many of the Gigabyte boards nowadays, and the two chips talk to each
other using I2C. My out-of-tree driver tried to remedy that by blocking those
accesses while the driver used the chip, but, again, without Gigabyte / ITE
support this was never a perfect solution, and there was always the risk that
the board ended up hanging because that access was blocked for too long.
Recent ITE chips solve that problem by providing memory mapped access to the
chip registers, but that is only useful if one has a datasheet.

Overall, I don't think it makes much sense trying to make significant changes
to the it87 driver without pulling in all the changes I had made, and without
finding a better fix for the cross-chip access problems. I for sure won't have
time for that (and getting hwmon patches reviewed is still very much an issue).

Having said that, I am of course open to adding WMI/ACPI drivers for the various
boards. Good luck getting support from Gigabyte, though. Or from ASUS, for that
matter.

Guenter
