Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA541AE60
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbhI1MDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:03:07 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43977 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240471AbhI1MDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:03:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 12C015C0126;
        Tue, 28 Sep 2021 08:01:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 28 Sep 2021 08:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=soRmW/
        drOJCliOyx+fO7VLL9WVqPUcGMti9RXPA3YNM=; b=ONj0nquSnawX+aur9pDytZ
        U6rEpS6Jpv122xPSdn/RchuppNWDSBJrs1lf7kiJiRPvoTF7T5cmH6g1wABikdnN
        o+79KnRIFDQhXOeRZTmARpX6q2CI82qgqU2TQLthyIQv2QURET1iqAe00Ze+Iw7L
        jyLgiZ0C+klUpXTBpVC820k0rM89a8bPLM7xoPnZnZUdvmcnG50HyAZSLIsOZzjv
        wRzX1cAbpi6QpNp8G80fl3QDoGGf24g4grHSngm0tYe4I9R4mh8P7IvksJ84t24N
        yT0Y/TfiaJj7G0j654C6IDhrt3r2GtSTOnKlMfU8PuBaPay5uroC2D+CIl10pFOg
        ==
X-ME-Sender: <xms:FgRTYTtC-87ePW6VEvBsCqeHA40CISmBPXSV_o9n3rxca8OctBpUwA>
    <xme:FgRTYUdR1l63ikDbJ_ZhGt26L2LWdrgbbzIa_ElNqSkf9HgRMF3UP-PFuvug4VSml
    w7dNFYc8zzPtK1ggEk>
X-ME-Received: <xmr:FgRTYWy9GmXTQ8AP2EvVoQ4Il7LWfqjOut5Wl_Y5WaMFmUlpCfPcqW-fo_yGHUxaQSroNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    ettdefvdeufffgjeeliedufeeiteefkeduteehvdfhieeigfffvdeuueejjeeuteenucff
    ohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:FgRTYSMbBZ8fnglUlWyCMOG9-ijQbTENRhbcpDUSaVmBnq07DO_XPg>
    <xmx:FgRTYT_EFeY16Arhe9d8QzxiAWXAkPx0Fq2mrYNwKOOEjGJhhV2cbw>
    <xmx:FgRTYSXFj5IjUIqSy9FQ1cIlYoc1FGob4fl6uInfcWa5-sMNUgIPhw>
    <xmx:FwRTYWbK-46ikjGyVqHfQR7GhIdvhQ2_7K8SO5L555gSvPK6N1spKA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 08:01:22 -0400 (EDT)
Date:   Wed, 29 Sep 2021 01:01:09 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <X1850R.K87ZAZR7ALEU2@ljones.dev>
In-Reply-To: <b3eee6a7-5c8b-e0f9-d7cc-291fbdebd3b1@redhat.com>
References: <20210907232232.5205-1-luke@ljones.dev>
        <20210907232232.5205-2-luke@ljones.dev>
        <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
        <ef22aa1f-288a-4e5a-0210-d62c7fc89307@redhat.com>
        <TT750R.ES1JPTD16XUL@ljones.dev>
        <b3eee6a7-5c8b-e0f9-d7cc-291fbdebd3b1@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Sep 28 2021 at 13:59:31 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 9/28/21 1:56 PM, Luke Jones wrote:
>>  Hmm,
>>  A change via /sys/firmware/acpi/platform_profile does disable the 
>> fan-curve until a user re-enables it.
> 
> Ah ok, so did get that part right :)
> 
> So basically any write to /sys/firmware/acpi/platform_profile
> will reset the pwm1_enable to "2" if it was not "2" already.
> 
>>  It doesn't wipe the actual curve setting though, I thought that 
>> would be bad UX,
> 
> Ok that is fine.
> 
>>  but yes the curve is definitely disabled on profile change and will 
>> remain disabled until turned on again. At which point another 
>> profile change will disable it again.
>> 
>>  And as stated in previous reply use of 
>> /sys/devices/platform/asus-nb-wmi/hwmon/hwmon<N>/pwm<N>_enable to 
>> check the status is stabilised (1 = manual fan).
>> 
>>  Looking at it with fresh eyes I just spotted some things I can 
>> clean up further. Very sorry, there'll be a v15 :(
> 
> No worries, maybe wait a bit with posting v15 till Bastien has a 
> chance
> to way in on this discussion though.

No problem at all. Very little will change except for code clean up :)

> 
> Regards,
> 
> Hans
> 
> 
> 
>>  On Tue, Sep 28 2021 at 13:44:32 +0200, Hans de Goede 
>> <hdegoede@redhat.com> wrote:
>>>  Hi,
>>> 
>>>  On 9/28/21 1:36 PM, Bastien Nocera wrote:
>>>>   On Wed, 2021-09-08 at 11:22 +1200, Luke D. Jones wrote:
>>>>>   Add support for custom fan curves found on some ASUS ROG 
>>>>> laptops.
>>>>> 
>>>>>   These laptops have the ability to set a custom curve for the CPU
>>>>>   and GPU fans via two ACPI methods.
>>>>> 
>>>>>   This patch adds two pwm<N> attributes to the hwmon sysfs,
>>>>>   pwm1 for CPU fan, pwm2 for GPU fan. Both are under the hwmon of 
>>>>> the
>>>>>   name `asus_custom_fan_curve`. There is no safety check of the 
>>>>> set
>>>>>   fan curves - this must be done in userspace.
>>>>> 
>>>>>   The fans have settings [1,2,3] under pwm<N>_enable:
>>>>>   1. Enable and write settings out
>>>>>   2. Disable and use factory fan mode
>>>>>   3. Same as 2, additionally restoring default factory curve.
>>>>> 
>>>>>   Use of 2 means that the curve the user has set is still stored 
>>>>> and
>>>>>   won't be erased, but the laptop will be using its default 
>>>>> auto-fan
>>>>>   mode. Re-enabling the manual mode then activates the curves 
>>>>> again.
>>>>> 
>>>>>   Notes:
>>>>>   - pwm<N>_enable = 0 is an invalid setting.
>>>>>   - pwm is actually a percentage and is scaled on writing to 
>>>>> device.
>>>> 
>>>>   I was trying to update:
>>>> 
>>>>  
>>>> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/80
>>>>   but I don't understand what files I need to check for what 
>>>> values to
>>>>   detect whether custom fan curves were used.
>>>> 
>>>>   Can you help me out here?
>>> 
>>>  How to deal with this is actually one of my remaining questions 
>>> too.
>>> 
>>>  I've not looked at the new code closely yet, but if I understand
>>>  things correctly, the now code basically only allows to set 1
>>>  custom profile and setting that profile overrides the last
>>>  profile set through /sys/firmware/acpi/platform_profile.
>>> 
>>>  And any write to /sys/firmware/acpi/platform_profile will
>>>  overwrite / replace the last custom set profile (if any) with
>>>  the one matching the requested platform-profile.
>>> 
>>>  So basically users of custom fan profiles are expected to
>>>  disable power-profiles-daemon or at least to refrain from
>>>  making any platform_profile changes.
>>> 
>>>  And if power-profile-daemon is actually active and
>>>  makes a change then any custom settings will be thrown away,
>>>  IOW p-p-d will always win. So I believe that it no longer needs
>>>  to check for custom profiles, since any time it requests a
>>>  standard profile that will overwrite any custom profile
>>>  which may be present.
>>> 
>>>  Luke, do I have that right ?
>>> 
>>>>   Also, was this patch accepted in the pdx86 tree?
>>> 
>>>  No, I still need to find/make some time to review it and
>>>  I still have the same question as you :)
>>> 
>>>  Regards,
>>> 
>>>  Hans
>>> 
>> 
>> 
> 


