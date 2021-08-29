Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8653FAAB6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhH2KEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 06:04:44 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48485 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234925AbhH2KEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:04:43 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E46413200908;
        Sun, 29 Aug 2021 06:03:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 29 Aug 2021 06:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=L7DHWc
        GAuxWk0nS9qJh1MlT5GUJHq6Kbw4zUDG09KIY=; b=XPt4/gWU3NMqag1T1ZNr8X
        bsFTLwpxxa1q6LJ4y/VBSQ5FC0TN9fl3FpYm0BzB6LhidLaIs24h6LYiYZDT09si
        N5270fz2HDz7BPfuCHeB25X9Rv8nZVJi5+tys6N8KbkGSX/F3ax60K6DfDyJZu51
        sCxRwCITAVFobFnTj5NH0nRYcT1m0V1itXZ+6YJZSQaSdAqBVIIb75hmRFT1aPO/
        aHxWCceSy/yEQPIwYe1m8RXwr531aTA/pOxS3CJq5Ve7jlAHi7/2UwZ5dCqoHZRr
        Fgo/kg6JBowDOO/siLhZJNpuhypHRx92nauOY6n8UP/8Cl2V8jIWmypQbMGVrWXw
        ==
X-ME-Sender: <xms:hVsrYZxYij8xtW_1qbmhojUWgW7Wpoyyh1ZaT54oXggWqhp2Fmhd_g>
    <xme:hVsrYZT-SZmP2j0qmRQiLV9faif--wMaDAii0kpVXVFqqIYSiUw4IXHi9y074KhXw
    KZ2HctDhKeoEjcQwcw>
X-ME-Received: <xmr:hVsrYTW1Cr-dS3Db9MJY8p1TSdDgeFAaJvR8u6Vr6-qj3uAFSjLMPw-Ul8nELB7GlTZF_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddujedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    fgfeefudffhffgueehgeffffeggeevieefueethfeijefftedugfeuveethedtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslh
    hjohhnvghsrdguvghv
X-ME-Proxy: <xmx:hVsrYbgxHD7PwddCkT7Wmphr_I_kZ8Z72ZSsXB0RUYauImKRON8rxw>
    <xmx:hVsrYbA_kGisPKs3yx5Xz9dJBc8lqd31bjT6oFglgvuzIjmvcuYtLQ>
    <xmx:hVsrYULayfXN_3Swm1ZY7atEZrj5rU93oIym3XP67u52CB7ExuSCDQ>
    <xmx:hlsrYeOSYVO48Mm-yxMr4u7Zfn5Df7-p2BvQrNqSt9hIhRiEAdzzaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Aug 2021 06:03:43 -0400 (EDT)
Date:   Sun, 29 Aug 2021 22:03:27 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v6 0/1] asus-wmi: Add support for custom fan curves
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, pobrn@protonmail.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org
Message-Id: <RLILYQ.0GH3JY7UCTPI2@ljones.dev>
In-Reply-To: <cf42ddd7-29ed-ff8b-7d03-958187863b70@redhat.com>
References: <20210829071402.576380-1-luke@ljones.dev>
        <cf42ddd7-29ed-ff8b-7d03-958187863b70@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Aug 29 2021 at 11:57:55 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Luke,
> 
> On 8/29/21 9:14 AM, Luke D. Jones wrote:
>>  Add support for custom fan curves found on some ASUS ROG laptops.
>> 
>>  - V1
>>    + Initial patch work
>>  - V2
>>    + Don't fail and remove wmi driver if error from
>>      asus_wmi_evaluate_method_buf() if error is -ENODEV
>>  - V3
>>    + Store the "default" fan curves
>>    + Call throttle_thermal_policy_write() if a curve is erased to 
>> ensure
>>      that the factory default for a profile is applied again
>>  - V4
>>    + Do not apply default curves by default. Testers have found that 
>> the
>>      default curves don't quite match actual no-curve behaviours
>>    + Add method to enable/disable curves for each profile
>>  - V5
>>    + Remove an unrequired function left over from previous iterations
>>    + Ensure default curves are applied if user writes " " to a curve 
>> path
>>    + Rename "active_fan_curve_profiles" to 
>> "enabled_fan_curve_profiles" to
>>      better reflect the behavious of this setting
>>    + Move throttle_thermal_policy_write_*pu_curves() and rename to
>>      fan_curve_*pu_write()
>>    + Merge fan_curve_check_valid() and fan_curve_write()
>>    + Remove some leftover debug statements
>>  - V6
>>    + Refactor data structs to store  array or u8 instead of strings.
>>      This affects the entire patch except the enabled_fan_curves 
>> block
>>    + Use sysfs_match_string in enabled_fan_curve block
>>    + Add some extra comments to describe things
>>    + Allow some variation in how fan curve input can be formatted
>>    + Use SENSOR_DEVICE_ATTR_2_RW() to reduce the amount of lines per
>>      fan+profile combo drastically
> 
> Thank you for your continued work on this. I read in the discussin of 
> v5
> that you discussed using the standard auto_point#_pwm, 
> auto_point#_temp
> pairs. I see here that you have decided to not go that route, may I 
> ask
> why ?

Sure, primary reason is because the RPM for the fans is in percentage 
so it didn't really make sense to me to use that format.

Also if the max for that is 255 then I'd need to introduce scaling to 
make match what the ACPI method expects (max 100). But yeah, 
auto_point#_pwm changes the meaning.

> 
> Regards,
> 
> Hans
> 


