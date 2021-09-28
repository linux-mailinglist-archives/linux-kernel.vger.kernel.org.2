Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9274841AE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbhI1L6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:58:18 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:56369 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240381AbhI1L6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:58:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EF8593201F2D;
        Tue, 28 Sep 2021 07:56:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Sep 2021 07:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+3uHsK
        gDTn8aRiOuu8PAM8PZg2kM3nK2vprWufBGbfs=; b=ipdAU7VUAdlbiB48aeaffn
        dmjO45ipjjmK8Oy7v/pD9P4hQpf2HOfHS2uv2vlpODeRdV7QRSSSVov0DHGNDdAO
        vGfGDus2Grp6r6rWszQVm9WB7SeHo7PQvXdBgp550CDMBADEf3kaLAfdUk9ZSV7q
        7X55kSoz6CxmhYnQPhQvJ7A+MAt5ocVBf4NwMXzcB486aGiHfNQj/onoB4hlp6eP
        MBk+RiD179zvP1cwQaswCpaU+DYMmKOx7yWEm9QJTy1OiM5oCiSwakVK73qLQnWY
        Tsdd1cL6Oi940sGEvn7dgM0WKmgTcsS+08V4NYeDG5g7tSET6A0nzkwJV2l4JK/g
        ==
X-ME-Sender: <xms:9AJTYeThz5CkI31qhLpk2lGSC9TDclhNhpIrBMCqOjK3l0eZpGeNEw>
    <xme:9AJTYTwinKufwDfVl-77RJk_O-nlM5QoXkRkaX6fK5Hzg_fjAhhekP8rxeIjkDAaH
    ZMhxlJ9De0nYJtehz8>
X-ME-Received: <xmr:9AJTYb3T7Oa2n3QJTFSi6HQA5hiQw7RGkciMOueksW1wTjqosRvb7wetxsEaM404FovUdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    ettdefvdeufffgjeeliedufeeiteefkeduteehvdfhieeigfffvdeuueejjeeuteenucff
    ohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:9AJTYaBhMXYfarNwpe9v_Gm4xTvg9Mygf0Fut8Vk-JSJQnInaxjn7A>
    <xmx:9AJTYXgVgKyUX6491PyhnPkzWmALNd6tjfqFHDtLplu0xGQi22syyg>
    <xmx:9AJTYWqQWeHAm2DA9ljSqyk_7KjmD4letG8TsotIwVIf8J8fROdbkA>
    <xmx:9AJTYUvZN0jFA7ipIg_CuuR2BO_5eLOz0aW0VhF6lJqNOHoQ8js6SQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 07:56:31 -0400 (EDT)
Date:   Wed, 29 Sep 2021 00:56:17 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <TT750R.ES1JPTD16XUL@ljones.dev>
In-Reply-To: <ef22aa1f-288a-4e5a-0210-d62c7fc89307@redhat.com>
References: <20210907232232.5205-1-luke@ljones.dev>
        <20210907232232.5205-2-luke@ljones.dev>
        <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
        <ef22aa1f-288a-4e5a-0210-d62c7fc89307@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm,
A change via /sys/firmware/acpi/platform_profile does disable the 
fan-curve until a user re-enables it.
It doesn't wipe the actual curve setting though, I thought that would 
be bad UX, but yes the curve is definitely disabled on profile change 
and will remain disabled until turned on again. At which point another 
profile change will disable it again.

And as stated in previous reply use of 
/sys/devices/platform/asus-nb-wmi/hwmon/hwmon<N>/pwm<N>_enable to check 
the status is stabilised (1 = manual fan).

Looking at it with fresh eyes I just spotted some things I can clean up 
further. Very sorry, there'll be a v15 :(

Many thanks,
Luke.


On Tue, Sep 28 2021 at 13:44:32 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 9/28/21 1:36 PM, Bastien Nocera wrote:
>>  On Wed, 2021-09-08 at 11:22 +1200, Luke D. Jones wrote:
>>>  Add support for custom fan curves found on some ASUS ROG laptops.
>>> 
>>>  These laptops have the ability to set a custom curve for the CPU
>>>  and GPU fans via two ACPI methods.
>>> 
>>>  This patch adds two pwm<N> attributes to the hwmon sysfs,
>>>  pwm1 for CPU fan, pwm2 for GPU fan. Both are under the hwmon of the
>>>  name `asus_custom_fan_curve`. There is no safety check of the set
>>>  fan curves - this must be done in userspace.
>>> 
>>>  The fans have settings [1,2,3] under pwm<N>_enable:
>>>  1. Enable and write settings out
>>>  2. Disable and use factory fan mode
>>>  3. Same as 2, additionally restoring default factory curve.
>>> 
>>>  Use of 2 means that the curve the user has set is still stored and
>>>  won't be erased, but the laptop will be using its default auto-fan
>>>  mode. Re-enabling the manual mode then activates the curves again.
>>> 
>>>  Notes:
>>>  - pwm<N>_enable = 0 is an invalid setting.
>>>  - pwm is actually a percentage and is scaled on writing to device.
>> 
>>  I was trying to update:
>>  
>> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/80
>>  but I don't understand what files I need to check for what values to
>>  detect whether custom fan curves were used.
>> 
>>  Can you help me out here?
> 
> How to deal with this is actually one of my remaining questions too.
> 
> I've not looked at the new code closely yet, but if I understand
> things correctly, the now code basically only allows to set 1
> custom profile and setting that profile overrides the last
> profile set through /sys/firmware/acpi/platform_profile.
> 
> And any write to /sys/firmware/acpi/platform_profile will
> overwrite / replace the last custom set profile (if any) with
> the one matching the requested platform-profile.
> 
> So basically users of custom fan profiles are expected to
> disable power-profiles-daemon or at least to refrain from
> making any platform_profile changes.
> 
> And if power-profile-daemon is actually active and
> makes a change then any custom settings will be thrown away,
> IOW p-p-d will always win. So I believe that it no longer needs
> to check for custom profiles, since any time it requests a
> standard profile that will overwrite any custom profile
> which may be present.
> 
> Luke, do I have that right ?
> 
>>  Also, was this patch accepted in the pdx86 tree?
> 
> No, I still need to find/make some time to review it and
> I still have the same question as you :)
> 
> Regards,
> 
> Hans
> 


