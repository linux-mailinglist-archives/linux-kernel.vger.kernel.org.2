Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7480E41AE53
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhI1MBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:01:10 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58965 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240400AbhI1MBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:01:08 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 216513201F62;
        Tue, 28 Sep 2021 07:59:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 28 Sep 2021 07:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sz1MgN
        EtAaZM1aD7+aAjba3ESARjE2Dk6GktvSB9Axg=; b=e+5N4TxOiQbPKVt7GkESQx
        F3yutSXCmmx9kW5tvMj5qs+U35GBRRv2xG5Vdf7mGx5NpP2u4HSGug49DWwg7v0f
        DxLJJv8zufvAVbvCF6ek3csx5deRNKjOFmFlc+PZ7nA/ZOpvmQGuAXZ3GTkcNaJS
        LEMHftHSitqzt1KOwaJKL+MYvDB7kG02ZIIdwM2eX6nIE8fcWSt+Z0P6Gvzr68kE
        DBlKVi54nXZjeGtKBF1SrcO0k5DAiabHif5P1Px3ddB5LYgNcvBR2hUMXPb37cY1
        1uwjeaBQ9eNsZoBncJUGmFVnVv6FzjvpI7Bg9CSadM0pl/IKZ8R2Sdg51JZPv19g
        ==
X-ME-Sender: <xms:oANTYUjdVeXL-ISkvnApTHWA0YAolVcvSjMK3Qan6SbmKr_0jqT8fA>
    <xme:oANTYdADtICsGDAxwCWLGPZWI4X_yM8qX--8yUN7pZTXk7Fzwnj0EDEZOjM2FV5sB
    0c4wdMsHjfcU-HYS2k>
X-ME-Received: <xmr:oANTYcHXMmPReRSVlysCB0YwgAjj_BWj0ICxDsl_zHrU17s-aD7zzrrp-EyNU2V_3VPfqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    ettdefvdeufffgjeeliedufeeiteefkeduteehvdfhieeigfffvdeuueejjeeuteenucff
    ohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:oANTYVSvTHPqXZyGQh8-0imFUCId5GIv4sEnJ_fb9F7bhlE1Y-wqgw>
    <xmx:oANTYRzj37LESB3hc-5W1XBeG0KzW6HrNJXQAFgS-ZBuu4lXRL7sBA>
    <xmx:oANTYT53FXaHMZNM1_JdnNjnDAf7k9f6WbS7VHiLJj6OyTh7M786UQ>
    <xmx:oANTYZ9GcjFYhvuQ2-8g99yRbIkpdz77FgA64QrOV9EHzREzqKHZ7g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 07:59:24 -0400 (EDT)
Date:   Wed, 29 Sep 2021 00:59:11 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <NY750R.JRUHTBKNLH1F1@ljones.dev>
In-Reply-To: <10be9244-0d89-ef79-08d0-fe7024609ee2@redhat.com>
References: <20210907232232.5205-1-luke@ljones.dev>
        <20210907232232.5205-2-luke@ljones.dev>
        <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
        <99750R.GZYR2PKX93HX@ljones.dev>
        <10be9244-0d89-ef79-08d0-fe7024609ee2@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Sep 28 2021 at 13:56:05 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 9/28/21 1:43 PM, Luke Jones wrote:
>>  Sure, the path is similar to 
>> /sys/devices/platform/asus-nb-wmi/hwmon/hwmon4/pwm1_enable where 
>> hwmon4 will likely be different depending on init, and pwm2_enable 
>> is the second fan if it exists. The values are 1,2,3 - where 1 = fan 
>> curve enabled/manual, 2 = auto. 3 here is custom extra that writes 
>> default curve back then defaults to 2.
>> 
>>  As I understand it, this should be adhering to the accepted kernel 
>> standard, so if you use this for ASUS laptops, then it should carry 
>> over to other brands that implement it also.
> 
> Ah, so this is a bit different then how I thought this would work
> (this is probably better though).
> 
> <snip>
> 
>>>>   The fans have settings [1,2,3] under pwm<N>_enable:
>>>>   1. Enable and write settings out
>>>>   2. Disable and use factory fan mode
>>>>   3. Same as 2, additionally restoring default factory curve.
> 
> Quoting Documentation/hwmon/sysfs-interface.rst
> 
> `pwm[1-*]_enable`
>                 Fan speed control method:
> 
>                 - 0: no fan speed control (i.e. fan at full speed)
>                 - 1: manual fan speed control enabled (using 
> `pwm[1-*]`)
>                 - 2+: automatic fan speed control enabled
> 
> 1 normally means the fans runs at a fixed speed, but you are using it
> for the custom/manual profile, which is still a temp<->pwm table,
> right?
> 
> I guess this make sense since full manual control is not supported
> and this keeps "2" aka auto as being the normal factory auto
> setting which is good.
> 
> Bastien is this interface usable for p-p-d ?
> 
> I guess that it is a bit annoying that you need to figure out
> the # in the hwmon# part of the path, but there will be only
> one hwmon child.
> 
> You could also go through /sys/class/hwmon but then you really
> have no idea which one to use. Ideally we would have some way
> to indicate that there is a hmwon class-dev associated with
> /sys/firmware/acpi/platform_profile but as we mentioned before
> we should defer coming up with a generic solution for this
> until we have more then 1 user, so that we hopefully get the
> generic solution right in one go.

If it's at all helpful, I named the interface as 
"asus_custom_fan_curve". I use this to verify I have the correct hwmon 
for asusctl. Open to suggestions on that.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>>>> 
>>>>   Use of 2 means that the curve the user has set is still stored 
>>>> and
>>>>   won't be erased, but the laptop will be using its default 
>>>> auto-fan
>>>>   mode. Re-enabling the manual mode then activates the curves 
>>>> again.
>>>> 
>>>>   Notes:
>>>>   - pwm<N>_enable = 0 is an invalid setting.
>>>>   - pwm is actually a percentage and is scaled on writing to 
>>>> device.
>>> 
>>>  I was trying to update:
>>>  
>>> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/80
>>>  but I don't understand what files I need to check for what values 
>>> to
>>>  detect whether custom fan curves were used.
>>> 
>>>  Can you help me out here?
>>> 
>>>  Also, was this patch accepted in the pdx86 tree?
>>> 
>>>  Cheers
>>> 
>> 
>> 
> 


