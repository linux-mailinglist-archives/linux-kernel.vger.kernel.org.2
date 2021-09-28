Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4141AE89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbhI1MRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:17:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39411 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240426AbhI1MRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:17:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A40575C0049;
        Tue, 28 Sep 2021 08:15:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Sep 2021 08:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SkSXdD
        etbZyS/ZbmXOgcdjPyO+YmJlYBhmx1zh1URkA=; b=iyNpZRSyU4linyRobjj7Xf
        D7SXPWhZC6+ggTb6P44hQdS7P6cN4M/fJNsxmAnFzjUUXTwMmSjkx1qRetDxNho1
        3AAAqyEkL/sfFA5zNEAJ+lIVOcODzhy8qbhLDqYNneHdiK+DDBvM83KSL/t57XXB
        mm/mNg0S7lNSgYDX1PoxYGTI7P1lh7+g8JwPyp6AZVk3Dy8ysbQ8TNV79zEti72P
        YKYyK8qPVpkpIE41UO9EeeI7HPYGz55JjVKNfn98S8zSqm9IhCtv1j7S6NabmQFt
        NeTbNp3201ode3iJu+xDAUOYwCO9Bkn3yclGMP4nzdMyg6O/9Id1ov8ryJJn04ug
        ==
X-ME-Sender: <xms:eQdTYUYKhdionhy-FTAr534FEaC9fG1mfub6LXF8SbFhvHlFHxRUIw>
    <xme:eQdTYfZfXiy4l0mnjrFQijVZuGqdqR1I-gqqwtGonsbhkr2Acyml6FLC2UQN062Z9
    mYVFNEHug31eoooOg8>
X-ME-Received: <xmr:eQdTYe83jnCcWqpAwvKjFCRWwuZQZ-UfsrAAuDn_MLWFfQZYOhO-QKNEx7woUkO-NoyhZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    fgfeefudffhffgueehgeffffeggeevieefueethfeijefftedugfeuveethedtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslh
    hjohhnvghsrdguvghv
X-ME-Proxy: <xmx:eQdTYer2BcpuEyvLBP2S1NYNXZLIGniPPjm1EzwUGsVoX0tZtPxLsA>
    <xmx:eQdTYfohXCj9WyEZiracTRE9BTXIRBRHJC2tjnu4HWYDy9d7vihLFA>
    <xmx:eQdTYcSvH5XwkuabCd4R_G5TDQQZAWLs7rg8XY9g6TS0tF0KySOo6A>
    <xmx:eQdTYeXJPPDnjAWNgS5t1jTRJC2ceeZDHGA1wvZdyTVUcZ022JhrxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 08:15:49 -0400 (EDT)
Date:   Wed, 29 Sep 2021 01:15:34 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <YP850R.AMCS62ND6R8R3@ljones.dev>
In-Reply-To: <461e3768-7c6d-7351-3482-2545ad0af754@redhat.com>
References: <20210907232232.5205-1-luke@ljones.dev>
        <20210907232232.5205-2-luke@ljones.dev>
        <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
        <99750R.GZYR2PKX93HX@ljones.dev>
        <10be9244-0d89-ef79-08d0-fe7024609ee2@redhat.com>
        <NY750R.JRUHTBKNLH1F1@ljones.dev>
        <461e3768-7c6d-7351-3482-2545ad0af754@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Sep 28 2021 at 14:03:54 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 9/28/21 1:59 PM, Luke Jones wrote:
>> 
>> 
>>  On Tue, Sep 28 2021 at 13:56:05 +0200, Hans de Goede 
>> <hdegoede@redhat.com> wrote:
>>>  Hi,
>>> 
>>>  On 9/28/21 1:43 PM, Luke Jones wrote:
>>>>   Sure, the path is similar to 
>>>> /sys/devices/platform/asus-nb-wmi/hwmon/hwmon4/pwm1_enable where 
>>>> hwmon4 will likely be different depending on init, and pwm2_enable 
>>>> is the second fan if it exists. The values are 1,2,3 - where 1 = 
>>>> fan curve enabled/manual, 2 = auto. 3 here is custom extra that 
>>>> writes default curve back then defaults to 2.
>>>> 
>>>>   As I understand it, this should be adhering to the accepted 
>>>> kernel standard, so if you use this for ASUS laptops, then it 
>>>> should carry over to other brands that implement it also.
>>> 
>>>  Ah, so this is a bit different then how I thought this would work
>>>  (this is probably better though).
>>> 
>>>  <snip>
>>> 
>>>>>>    The fans have settings [1,2,3] under pwm<N>_enable:
>>>>>>    1. Enable and write settings out
>>>>>>    2. Disable and use factory fan mode
>>>>>>    3. Same as 2, additionally restoring default factory curve.
>>> 
>>>  Quoting Documentation/hwmon/sysfs-interface.rst
>>> 
>>>  `pwm[1-*]_enable`
>>>                  Fan speed control method:
>>> 
>>>                  - 0: no fan speed control (i.e. fan at full speed)
>>>                  - 1: manual fan speed control enabled (using 
>>> `pwm[1-*]`)
>>>                  - 2+: automatic fan speed control enabled
>>> 
>>>  1 normally means the fans runs at a fixed speed, but you are using 
>>> it
>>>  for the custom/manual profile, which is still a temp<->pwm table,
>>>  right?
>>> 
>>>  I guess this make sense since full manual control is not supported
>>>  and this keeps "2" aka auto as being the normal factory auto
>>>  setting which is good.
>>> 
>>>  Bastien is this interface usable for p-p-d ?
>>> 
>>>  I guess that it is a bit annoying that you need to figure out
>>>  the # in the hwmon# part of the path, but there will be only
>>>  one hwmon child.
>>> 
>>>  You could also go through /sys/class/hwmon but then you really
>>>  have no idea which one to use. Ideally we would have some way
>>>  to indicate that there is a hmwon class-dev associated with
>>>  /sys/firmware/acpi/platform_profile but as we mentioned before
>>>  we should defer coming up with a generic solution for this
>>>  until we have more then 1 user, so that we hopefully get the
>>>  generic solution right in one go.
>> 
>>  If it's at all helpful, I named the interface as 
>> "asus_custom_fan_curve". I use this to verify I have the correct 
>> hwmon for asusctl. Open to suggestions on that.
> 
> Ah yes, that means the interface could be looked up through 
> /sys/class/hwmon
> too, that is probably the safest route to go then, as the
> /sys/devices/platform/asus-nb-wmi/ path might change if we e.g. ever
> convert the asus-wmi code to use the new wmi bus interface.

Oh man... can you link me to relevant bits? I'll stick this on my to-do 
for future. There will be more patches from me over time so this might 
be good to have done?

> 
> Now that you have confirmed that any writes to
> /sys/firmware/acpi/platform_profile override any custom profiles
> I wonder if p-p-d needs to take this into account at all though.
> 
> The easiest way to deal with this in p-p-d, is just to not deal
> with it at all...    If that turns out to be a bad idea, we
> can always reconsider and add some special handling to p-p-d for
> this later.

I believe Bastiens concern here will be that manual control can still 
be enabled and ppd won't be aware of it without a check. For example 
the user may switch profile then re-enable the fan-curve. If some 
problem arises due to manual control of fan then there is no way for 
ppd to determine if manual was enabled without actually looking.

This does mean the pwm name here is set in stone. But also means it's 
special-cased I guess. Perhaps a check for pwm<N>_enable, then check 
for the pairs of pwm<N>_auto_<xX> that come with it?

Ciao,
Luke.

> 
> Regards,
> 
> Hans
> 


