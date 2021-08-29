Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2313FAE9A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhH2U4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 16:56:34 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42283 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232989AbhH2U4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 16:56:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EB63C5C00AD;
        Sun, 29 Aug 2021 16:55:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 29 Aug 2021 16:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NcQg4S
        QF/ZIoqi7h9T6xv7ula+TxR9mC6WKm/upv5HE=; b=ntHKrdp64sQQKrIu1xmCla
        z+E5Vb3mJDX1PsDuk9U/As/rL16YpXfAnGLlRwRPB1MzJjXZcj3iTHVoeNWgf9d9
        tPBetAyCjBR2M0CZSRW2ljUzH1/vOrmaa8MEVUMQKfKwQgc6sZmco9VGd62PqTE7
        Bs9N8hyQmCQiUcrtrIg6R25y7K3xBchRTcsXCJPmc+jps5N1hEJ9KKk8+gqYX5du
        nSDNfsEzK+qMAo5AKIqNPOnjX/uGJW1nPr+q61vmbEHJRAyJkEIpetlf7XicVXDi
        tnapZPdajA6AmnqGxbqHo2CYR9r4Kp2zsmNBfjDkP18aw3iEAUNKT4UMHjykqtjQ
        ==
X-ME-Sender: <xms:S_QrYS-ZMmziEytmMzzQ6rl6CF7hjN5nvjpx2U4v-X3ZeI3LO_l8jA>
    <xme:S_QrYSuPdcic43SExEE59h9F50vuWSxMW8CayZpiXv7lzFVsUsX9_agWMjsRbug2O
    p3w7DJk7IK4NpsVH-o>
X-ME-Received: <xmr:S_QrYYDvsjWApgdJVI5UUESPcrbXU1QjzBmlonStLDXfRVDAgEgmyvRaKgsRqh5FIZSgZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddujedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvffkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epgfeffedufffhgfeuheegffffgeegveeifeeutefhieejffetudfgueevteehtdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:S_QrYadlQK8CNDSjq5jedkRPfIJ7FLe-ncmow5O9f_3-_l0iQtla5g>
    <xmx:S_QrYXMW9z3m-86wVaOmh3Hr6TsTdOU3fgJqLypl68PsMFt1kkmUaw>
    <xmx:S_QrYUl9Sk2ulEahl4qHniKRrA0pilf2sd7cebcR8Ol6_z64vNdzNQ>
    <xmx:S_QrYQZfNdyioMrjUE2Bv5fqgxclr4Tg-z42CDGW2QdLtT8LRRvx2Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Aug 2021 16:55:33 -0400 (EDT)
Date:   Mon, 30 Aug 2021 08:55:17 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v6 0/1] asus-wmi: Add support for custom fan curves
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com, platform-driver-x86@vger.kernel.org
Message-Id: <5SCMYQ.7F7995ZKI2HT3@ljones.dev>
In-Reply-To: <2af6628e-118f-6a75-8074-2f4144c7f8e7@roeck-us.net>
References: <20210829071402.576380-1-luke@ljones.dev>
        <cf42ddd7-29ed-ff8b-7d03-958187863b70@redhat.com>
        <RLILYQ.0GH3JY7UCTPI2@ljones.dev>
        <2af6628e-118f-6a75-8074-2f4144c7f8e7@roeck-us.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Aug 29 2021 at 08:18:01 -0700, Guenter Roeck 
<linux@roeck-us.net> wrote:
> On 8/29/21 3:03 AM, Luke Jones wrote:
>> 
>> 
>> On Sun, Aug 29 2021 at 11:57:55 +0200, Hans de Goede 
>> <hdegoede@redhat.com> wrote:
>>> Hi Luke,
>>> 
>>> On 8/29/21 9:14 AM, Luke D. Jones wrote:
>>>>  Add support for custom fan curves found on some ASUS ROG laptops.
>>>> 
>>>>  - V1
>>>>    + Initial patch work
>>>>  - V2
>>>>    + Don't fail and remove wmi driver if error from
>>>>      asus_wmi_evaluate_method_buf() if error is -ENODEV
>>>>  - V3
>>>>    + Store the "default" fan curves
>>>>    + Call throttle_thermal_policy_write() if a curve is erased to 
>>>> ensure
>>>>      that the factory default for a profile is applied again
>>>>  - V4
>>>>    + Do not apply default curves by default. Testers have found 
>>>> that the
>>>>      default curves don't quite match actual no-curve behaviours
>>>>    + Add method to enable/disable curves for each profile
>>>>  - V5
>>>>    + Remove an unrequired function left over from previous 
>>>> iterations
>>>>    + Ensure default curves are applied if user writes " " to a 
>>>> curve path
>>>>    + Rename "active_fan_curve_profiles" to 
>>>> "enabled_fan_curve_profiles" to
>>>>      better reflect the behavious of this setting
>>>>    + Move throttle_thermal_policy_write_*pu_curves() and rename to
>>>>      fan_curve_*pu_write()
>>>>    + Merge fan_curve_check_valid() and fan_curve_write()
>>>>    + Remove some leftover debug statements
>>>>  - V6
>>>>    + Refactor data structs to store  array or u8 instead of 
>>>> strings.
>>>>      This affects the entire patch except the enabled_fan_curves 
>>>> block
>>>>    + Use sysfs_match_string in enabled_fan_curve block
>>>>    + Add some extra comments to describe things
>>>>    + Allow some variation in how fan curve input can be formatted
>>>>    + Use SENSOR_DEVICE_ATTR_2_RW() to reduce the amount of lines 
>>>> per
>>>>      fan+profile combo drastically
>>> 
>>> Thank you for your continued work on this. I read in the discussin 
>>> of v5
>>> that you discussed using the standard auto_point#_pwm, 
>>> auto_point#_temp
>>> pairs. I see here that you have decided to not go that route, may I 
>>> ask
>>> why ?
>> 
>> Sure, primary reason is because the RPM for the fans is in 
>> percentage so it didn't really make sense to me to use that format.
>> 
>> Also if the max for that is 255 then I'd need to introduce scaling 
>> to make match what the ACPI method expects (max 100). But yeah, 
>> auto_point#_pwm changes the meaning.
>> 
> 
> Bad argument. That is true for other controllers as well. You could
> just scale it up and down as needed.
> 
> The whole point of an ABI is that it is standardized.
> If others would [be permitted to] follow your line of argument,
> we would not have a useful ABI because "my chip provides/needs
> data in some other format".
> 
> Guenter

Understood. But lets see if I understand fully:

The key part is "pwmX_auto_pointN_temp and pwmX_auto_pointN_pwm", with 
X being a profile, and N the point in the curve graph. If I use this 
format I have:

- 3 profiles
- each profile has two fans
- each fan has 8 points on it
- each point has 2 integers

so that makes for a total of 96 individual sysfs paths. Is that really 
okay? And where would the new paths god?
- Under /sys/devices/platform/asus-nb-wmi/ still, or
- /sys/devices/platform/asus-nb-wmi/hwmon/ ?

I'm currently using SENSOR_DEVICE_ATTR_2_RW with index = profile, nr = 
fan. If there weren't profiles involved then I could see it being 
easily achieved with that.. Maybe I could use the index(profile) with a 
mask to get the fan number.

I've done all the groundwork for it at least, so it can certainly be 
done. My only worry is that because of the sheer number of sysfs paths 
being added (96) it could become unwieldy to use.

Could I use the existing method + the above?

Many thanks,
Luke.


