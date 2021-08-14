Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A84E3EC2AF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhHNMsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 08:48:05 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35663 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhHNMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 08:48:04 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 9ECD532001C6;
        Sat, 14 Aug 2021 08:47:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 14 Aug 2021 08:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=RtYFiE
        MHz6FIwyIETFo/SymU19AOSe5BNvM77FSnom0=; b=b41eb5YcjAXQU2S5+schE7
        rgYmo1xtQoz5Ifip5RRSVR+p7vDRKMuz1S5KkDhx5Sa5uSpG45lS96ahV798uwA2
        6+GtA96+zGMtkPy/D8gz5kLVpspalvU9oIe95AKG2ziovqmIlQQAdZcma7vZqHBZ
        iuB1OPiAPDE/SYCac+T0NjBBoBtF/yaGW62DPYCeaDXAOV+Iz6Wlj2jEB93utgYD
        cx2lt2MZcboTacolpnJg2X9DHolquzUsnxkRPfx6fG6at+XTEK4bEkBqBOxi2cRE
        0R5xA7vKitsfBrHoy1oa60VwjD0Prfru9Ur5USfCm4KNP+K6VOuGczmzN8C/GHvg
        ==
X-ME-Sender: <xms:ZrsXYcqyUp1YZWSfSSnASzHdyga-iLIdhrHZGhmhk3l0zH1txz4C-A>
    <xme:ZrsXYSq4BY-HNaD9Y5i6eP2URryFr1nxNTrz5FSLkVIcgOX5w7Szc-nYaW3O44JpQ
    zQvT2LJcYh84xi9Ha4>
X-ME-Received: <xmr:ZrsXYRN-_TLedoJxAY9yH5z2Sw-FMi4tCyxRqCvELIQOsjq-5SypRcZgPXqDlTRkCiCnsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeejgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvffkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgvucfl
    ohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgf
    effedufffhgfeuheegffffgeegveeifeeutefhieejffetudfgueevteehtdetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljh
    honhgvshdruggvvh
X-ME-Proxy: <xmx:ZrsXYT4sm20A3akEDlXnsh1Gey2-gATPPWyfb5qsiYhtAYLfww_IrA>
    <xmx:ZrsXYb5OPd4OOtnUPg9BchxIlC7LTZ8EUAEUTZ-4k0-VAj1ODT6D9w>
    <xmx:ZrsXYTjX55CdyJQVeraAUF0tOLcejvfv_dBkdvboyNAWdukdA3GnAQ>
    <xmx:Z7sXYbE1ENrlK98fx6dQ6NILLWFKhXL0_HmZuMpWoO9oEzwtOjjN6g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Aug 2021 08:47:30 -0400 (EDT)
Date:   Sun, 15 Aug 2021 00:47:17 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 1/1] asus-wmi: Add support for platform_profile
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Message-Id: <T6YTXQ.N7QG3527OXWU1@ljones.dev>
In-Reply-To: <UCVTXQ.8ME64G0S1BQ8@ljones.dev>
References: <20210814043103.2535842-1-luke@ljones.dev>
        <20210814043103.2535842-2-luke@ljones.dev>
        <CAHp75VcCzjb7TKZ84iVjJr27+nCcA10n38nwCAGATucfAAMkKA@mail.gmail.com>
        <UCVTXQ.8ME64G0S1BQ8@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A very quick question: should I be enabling platform_profile by default 
if asus_wmi is enabled in kconfig?

On Sat, Aug 14 2021 at 23:46:06 +1200, Luke Jones <luke@ljones.dev> 
wrote:
> Hi Andy, thanks for the feedback. All is addressed, and some inline 
> comment/reply. New version incoming pending pr_info() vs dev_info()
> 
> On Sat, Aug 14 2021 at 12:40:39 +0300, Andy Shevchenko 
> <andy.shevchenko@gmail.com> wrote:
>> On Sat, Aug 14, 2021 at 7:33 AM Luke D. Jones <luke@ljones.dev> 
>> wrote:
>>> 
>>>  Add initial support for platform_profile where the support is
>>>  based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>>> 
>>>  Because throttle_thermal_policy is used by platform_profile and is
>>>  writeable separately to platform_profile any userspace changes to
>>>  throttle_thermal_policy need to notify platform_profile.
>>> 
>>>  In future throttle_thermal_policy sysfs should be removed so that
>>>  only one method controls the laptop power profile.
>> 
>> Some comments below.
>> 
>> ...
>> 
>>>  +       /*
>>>  +        * Ensure that platform_profile updates userspace with the 
>>> change to ensure
>>>  +        * that platform_profile and throttle_thermal_policy_mode 
>>> are in sync
>> 
>> Missed period here and in other multi-line comments.
>> 
>>>  +        */
>> 
>> ...
>> 
>>>  +       /* All possible toggles like throttle_thermal_policy here 
>>> */
>>>  +       if (asus->throttle_thermal_policy_available) {
>>>  +               tp = asus->throttle_thermal_policy_mode;
>>>  +       } else {
>>>  +               return -1;
>>>  +       }
>>>  +
>>>  +       if (tp < 0)
>>>  +               return tp;
>> 
>> This will be better in a form
>> 
>>     if (!..._available)
>>         return -ENODATA; // what -1 means?
>> 
> 
> I wasn't sure what the best return was here. On your suggestion I've 
> changed to ENODATA
> 
>>     tp = ...;
>>     if (tp < 0)
>>         return tp;
>> 
>> ...
>> 
>>>  +       /* All possible toggles like throttle_thermal_policy here 
>>> */
>>>  +       if (!asus->throttle_thermal_policy_available) {
>>>  +               return -1;
>> 
>> See above.
>> 
>>>  +       }
>> 
>> ...
>> 
>>>  +       if (asus->throttle_thermal_policy_available) {
>>>  +               pr_info("Using throttle_thermal_policy for 
>>> platform_profile support\n");
>> 
>> Why pr_*()?
> 
> That seemed to be the convention? I see there is also dev_info(), so 
> I've switched to that as it seems more appropriate.
> 
>> 
>>>  +       } else {
>>>  +               /*
>>>  +                * Not an error if a component platform_profile 
>>> relies on is unavailable
>>>  +                * so early return, skipping the setup of 
>>> platform_profile.
>>>  +               */
>>>  +               return 0;
>> 
>> Do it other way around,
>> 
>> /*
>>  * Comment
>>  */
>> if (!...)
>>   return 0;
> 
> Thanks, I think I was transliterating thought process to code as I 
> went along.
> All updated now.
> 
>> 
>>>  +       }
>> 
>> 
>> --
>> With Best Regards,
>> Andy Shevchenko
> 


