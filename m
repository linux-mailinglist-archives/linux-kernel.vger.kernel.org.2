Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB7641ADFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbhI1Lp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:45:57 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33299 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231202AbhI1Lp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:45:56 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 432293201F5E;
        Tue, 28 Sep 2021 07:44:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Sep 2021 07:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0279Pd
        ip628A8cUk7Ao1RX66qlNENJVj4VUfnSvDWsU=; b=prAQl7XN18RhlqHS1jzpgB
        LSgSr4X41bfh99gvjqsOCj89x5MZRRPUBkDjHnMPXuPtaL0J2ekAyAg6VZdfIjoU
        67TfSCX1uE0mYy/ToariZkqw9x8UexNCvaSBJNbS648ozhCr/MSeSKJl00DqVbP8
        26nxfKU8/uMmB4cNZ+aKLO/8XEXb749fTIUAnuhau2uzPboFAEWQot/XuKRFfEk8
        R23Q8gQklNmYjXVedsOrABaik6Ev1RUNI6dcg6DDf6RQzFxiSFQTGiI9q2NFYX8r
        lw4n3DwzSOUY/1QVbkP7wAPjvaVdNmL0BGaN61h4NK3i+rmD0RcUBYvMhpl3dXtQ
        ==
X-ME-Sender: <xms:DwBTYbzdTxGoNs5gkP4Pa-DW5m-rHThyhO0ojeja1E3-rBO_RbUTCw>
    <xme:DwBTYTRtftkppfYtNyA8ByVwlr39HazFy_x8w-e2wS7watnSAA-423B8RH4sw6f_t
    14yOszsaoV_JvF9RmI>
X-ME-Received: <xmr:DwBTYVWPQewedXVg9KraZXN91JaafLmGsZLFwpdbpXzYW9_LlkOiAq3LcFeL56jEiLYTWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgesthdtre
    dtredtvdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnheptedtfedvueffgfejleeiudefieetfeekudethe
    dvhfeiiefgffdvueeujeejueetnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:DwBTYVjR75vjJ9oEx8EyjmJR6_sJHRYuUzHQSaoV2PIIlHG7qIh4mg>
    <xmx:DwBTYdD2lGSW9w3HPlNjiKy587BSoAxGb15LG8OmOSiyCcRcKKqV-A>
    <xmx:DwBTYeKS0hHo-816ZW9f3UR3pRJkgQTi09xL-LYcQxW4woGp8pFrJQ>
    <xmx:DwBTYcOysZNso0Cip3BE_1EpqdQa2Jtn6frgbNVv5onlU-qG1KEZLg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 07:44:10 -0400 (EDT)
Date:   Wed, 29 Sep 2021 00:43:57 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <99750R.GZYR2PKX93HX@ljones.dev>
In-Reply-To: <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
References: <20210907232232.5205-1-luke@ljones.dev>
        <20210907232232.5205-2-luke@ljones.dev>
        <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, the path is similar to 
/sys/devices/platform/asus-nb-wmi/hwmon/hwmon4/pwm1_enable where hwmon4 
will likely be different depending on init, and pwm2_enable is the 
second fan if it exists. The values are 1,2,3 - where 1 = fan curve 
enabled/manual, 2 = auto. 3 here is custom extra that writes default 
curve back then defaults to 2.

As I understand it, this should be adhering to the accepted kernel 
standard, so if you use this for ASUS laptops, then it should carry 
over to other brands that implement it also.

Hope this is helpful,
Luke.

On Tue, Sep 28 2021 at 13:36:57 +0200, Bastien Nocera 
<hadess@hadess.net> wrote:
> On Wed, 2021-09-08 at 11:22 +1200, Luke D. Jones wrote:
>>  Add support for custom fan curves found on some ASUS ROG laptops.
>> 
>>  These laptops have the ability to set a custom curve for the CPU
>>  and GPU fans via two ACPI methods.
>> 
>>  This patch adds two pwm<N> attributes to the hwmon sysfs,
>>  pwm1 for CPU fan, pwm2 for GPU fan. Both are under the hwmon of the
>>  name `asus_custom_fan_curve`. There is no safety check of the set
>>  fan curves - this must be done in userspace.
>> 
>>  The fans have settings [1,2,3] under pwm<N>_enable:
>>  1. Enable and write settings out
>>  2. Disable and use factory fan mode
>>  3. Same as 2, additionally restoring default factory curve.
>> 
>>  Use of 2 means that the curve the user has set is still stored and
>>  won't be erased, but the laptop will be using its default auto-fan
>>  mode. Re-enabling the manual mode then activates the curves again.
>> 
>>  Notes:
>>  - pwm<N>_enable = 0 is an invalid setting.
>>  - pwm is actually a percentage and is scaled on writing to device.
> 
> I was trying to update:
> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/80
> but I don't understand what files I need to check for what values to
> detect whether custom fan curves were used.
> 
> Can you help me out here?
> 
> Also, was this patch accepted in the pdx86 tree?
> 
> Cheers
> 


