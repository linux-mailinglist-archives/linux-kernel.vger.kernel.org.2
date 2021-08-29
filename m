Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC9D3FAEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhH2WWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:22:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40443 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233919AbhH2WWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:22:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4EC9B5C0087;
        Sun, 29 Aug 2021 18:21:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 29 Aug 2021 18:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=nRlS9k
        nEqQhICUh7BwNxBqV2KKp81w2wrUXYJM2Bi8M=; b=SpV+nvYzBdGbZGrv9hgBDS
        92HQV/dFl0a/HnrQy2npVrKgEk+xS6XytpE/CPXiNSevBfYaTINxrhOTCrpyIlzv
        OyhUzupgv7MO5zgOJdWeIvr8rq4YlPS/sz1JQd+DqvNVMg0b+NH7dc05VjTLItYe
        y0U19FySRVxzXnrQ+xyBC4HVJ0D54L+9BBu2Av8JdbG0u6aG20vRUlHnaWpNxe2a
        jxXB2LU8ktGYCzmr0d2H9+J9MboNyJfmAPQGVhNouz94R4dsNVL1/L8QBpcN4aAj
        DjQ3j5X20yy00b1D5AnwhV3vEqkMCCeP//+OnD09yMYLW8a8u9W9+z88aJYETqiA
        ==
X-ME-Sender: <xms:XAgsYamimqbxdUIcJEs_MmRTTb2LgIRO72bmQYh8dYABNO4VhfUmPA>
    <xme:XAgsYR00vaeaWHvTQVGDP5LcuTcJ86-t-GPX0A3wfU-GK0LrXGkIsCb8pR8GRtcct
    4-uUClQHL5hGPGeIxY>
X-ME-Received: <xmr:XAgsYYqWfZBZmsvwJ9nVA7penHMAd-iJq8-g7h536Hn9tXSYxaGfIYiWk62YvfvP9E3kAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddukedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    fgfeefudffhffgueehgeffffeggeevieefueethfeijefftedugfeuveethedtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslh
    hjohhnvghsrdguvghv
X-ME-Proxy: <xmx:XAgsYemA1BJGvGgZJSziRDF61V3OdyUZ3k3oWvO2lg3P-hyJvVwQjQ>
    <xmx:XAgsYY39WxHTy7yf1GmH1e-1S1C4x0EKOTdhixB_f-jgkobmwmm7uA>
    <xmx:XAgsYVs_2o54w21r1n6nCdlyeJrW30NoHQzaQPBrah-Wqe_VkHkZ2w>
    <xmx:XQgsYWBPglQ0NWHBDuG4nNYjJHPGHg7tLs54YJhCKkrnqFrYPwsM6Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Aug 2021 18:21:12 -0400 (EDT)
Date:   Mon, 30 Aug 2021 10:20:57 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v6 0/1] asus-wmi: Add support for custom fan curves
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com, platform-driver-x86@vger.kernel.org
Message-Id: <XQGMYQ.9VWHCW8VQN7K1@ljones.dev>
In-Reply-To: <5SCMYQ.7F7995ZKI2HT3@ljones.dev>
References: <20210829071402.576380-1-luke@ljones.dev>
        <cf42ddd7-29ed-ff8b-7d03-958187863b70@redhat.com>
        <RLILYQ.0GH3JY7UCTPI2@ljones.dev>
        <2af6628e-118f-6a75-8074-2f4144c7f8e7@roeck-us.net>
        <5SCMYQ.7F7995ZKI2HT3@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Aug 30 2021 at 08:55:17 +1200, Luke Jones <luke@ljones.dev> 
wrote:
> 
> 
> On Sun, Aug 29 2021 at 08:18:01 -0700, Guenter Roeck 
> <linux@roeck-us.net> wrote:
>> On 8/29/21 3:03 AM, Luke Jones wrote:
>>> 
>>> 
>>> On Sun, Aug 29 2021 at 11:57:55 +0200, Hans de Goede 
>>> <hdegoede@redhat.com> wrote:
>>>> Hi Luke,
>>>> 
>>>> On 8/29/21 9:14 AM, Luke D. Jones wrote:
>>>>>  Add support for custom fan curves found on some ASUS ROG laptops.
>>>>> 
>>>>>  - V1
>>>>>    + Initial patch work
>>>>>  - V2
>>>>>    + Don't fail and remove wmi driver if error from
>>>>>      asus_wmi_evaluate_method_buf() if error is -ENODEV
>>>>>  - V3
>>>>>    + Store the "default" fan curves
>>>>>    + Call throttle_thermal_policy_write() if a curve is erased to 
>>>>> ensure
>>>>>      that the factory default for a profile is applied again
>>>>>  - V4
>>>>>    + Do not apply default curves by default. Testers have found 
>>>>> that the
>>>>>      default curves don't quite match actual no-curve behaviours
>>>>>    + Add method to enable/disable curves for each profile
>>>>>  - V5
>>>>>    + Remove an unrequired function left over from previous 
>>>>> iterations
>>>>>    + Ensure default curves are applied if user writes " " to a 
>>>>> curve path
>>>>>    + Rename "active_fan_curve_profiles" to 
>>>>> "enabled_fan_curve_profiles" to
>>>>>      better reflect the behavious of this setting
>>>>>    + Move throttle_thermal_policy_write_*pu_curves() and rename to
>>>>>      fan_curve_*pu_write()
>>>>>    + Merge fan_curve_check_valid() and fan_curve_write()
>>>>>    + Remove some leftover debug statements
>>>>>  - V6
>>>>>    + Refactor data structs to store  array or u8 instead of 
>>>>> strings.
>>>>>      This affects the entire patch except the enabled_fan_curves 
>>>>> block
>>>>>    + Use sysfs_match_string in enabled_fan_curve block
>>>>>    + Add some extra comments to describe things
>>>>>    + Allow some variation in how fan curve input can be formatted
>>>>>    + Use SENSOR_DEVICE_ATTR_2_RW() to reduce the amount of lines 
>>>>> per
>>>>>      fan+profile combo drastically
>>>> 
>>>> Thank you for your continued work on this. I read in the discussin 
>>>> of v5
>>>> that you discussed using the standard auto_point#_pwm, 
>>>> auto_point#_temp
>>>> pairs. I see here that you have decided to not go that route, may 
>>>> I ask
>>>> why ?
>>> 
>>> Sure, primary reason is because the RPM for the fans is in 
>>> percentage so it didn't really make sense to me to use that 
>>> format.
>>> 
>>> Also if the max for that is 255 then I'd need to introduce scaling 
>>> to make match what the ACPI method expects (max 100). But yeah, 
>>> auto_point#_pwm changes the meaning.
>>> 
>> 
>> Bad argument. That is true for other controllers as well. You could
>> just scale it up and down as needed.
>> 
>> The whole point of an ABI is that it is standardized.
>> If others would [be permitted to] follow your line of argument,
>> we would not have a useful ABI because "my chip provides/needs
>> data in some other format".
>> 
>> Guenter
> 
> Understood. But lets see if I understand fully:
> 
> The key part is "pwmX_auto_pointN_temp and pwmX_auto_pointN_pwm", 
> with X being a profile, and N the point in the curve graph. If I use 
> this format I have:
> 
> - 3 profiles
> - each profile has two fans
> - each fan has 8 points on it
> - each point has 2 integers
> 
> so that makes for a total of 96 individual sysfs paths. Is that 
> really okay? And where would the new paths god?
> - Under /sys/devices/platform/asus-nb-wmi/ still, or
> - /sys/devices/platform/asus-nb-wmi/hwmon/ ?
> 
> I'm currently using SENSOR_DEVICE_ATTR_2_RW with index = profile, nr 
> = fan. If there weren't profiles involved then I could see it being 
> easily achieved with that.. Maybe I could use the index(profile) with 
> a mask to get the fan number.
> 
> I've done all the groundwork for it at least, so it can certainly be 
> done. My only worry is that because of the sheer number of sysfs 
> paths being added (96) it could become unwieldy to use.
> 
> Could I use the existing method + the above?

I've had a bit of a think after morning coffee and I think there is 
another way to do this:

- CPU Fan = pwm1_auto_pointN_pwm + pwm1_auto_pointN_temp
- GPU Fan = pwm2_auto_pointN_pwm + pwm2_auto_pointN_temp
for example. So we're not breaking the meaning of anything or making 
things obtuse and complex.

Ending up with:
/* CPU */
// (name, function, fan, point)
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_temp, fan_curve, 1, 0);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_temp, fan_curve, 1, 1);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_temp, fan_curve, 1, 2);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point4_temp, fan_curve, 1, 3);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point5_temp, fan_curve, 1, 4);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point6_temp, fan_curve, 1, 5);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point7_temp, fan_curve, 1, 6);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point8_temp, fan_curve, 1, 7);

static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_pwm, fan_curve, 1, 0);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_pwm, fan_curve, 1, 1);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_pwm, fan_curve, 1, 2);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point4_pwm, fan_curve, 1, 3);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point5_pwm, fan_curve, 1, 4);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point6_pwm, fan_curve, 1, 5);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point7_pwm, fan_curve, 1, 6);
static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point8_pwm, fan_curve, 1, 7);
/* and the same for GPU fan */

But because we still have 3 profiles to consider, I would propose that 
the settings be show/store dependant on the profile that the machine is 
in, e.g, internally show/store to correct profile via checking current 
profile number active.

I do need some suggestions on what I see as an issue though:
(1)
Given that it now becomes difficult to write all the settings at once, 
at what point should I attempt to write the "block" to the device? 
Write out for every change?
(2)
Also given the above, how do I reasonably check the user isn't trying 
to create an invalid graph? E.g, lower fan speeds for higher 
temperature? Check that a point isn't higher/lower than neighbouring 
points and expect users to write the points in reverse?

I could maybe also have pwm1_enable and pwm2_enable. Perhaps set this 
to false if a change is made, then only write out the full block if it 
is then set to enabled. Further to this, if the user changes profiles 
and the curves have been previously set and enabled, then that curve is 
written out per usual.

Looking forward to some guidance on this. I'll try making a start on 
what I've proposed above for now.


> Many thanks,
> Luke.
> 


