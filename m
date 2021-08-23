Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E603F49B8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhHWL1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:27:46 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50557 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234997AbhHWL1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:27:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id ADA563200922;
        Mon, 23 Aug 2021 07:27:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 23 Aug 2021 07:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=t1veiu
        KjOsnBwnABF/fE0dElfCh4AAyj7JifPOqt5cM=; b=llC1UQ6PIUA57O5DmEdXyS
        1DDESElQ9d4iLmD47z02fv2hq2uEDK0X/LtwF6krtWOq+1ZLCtNTb30asv/zJMoP
        H7qck0wrM0Xyjdgv6kKxhV+cKgR0DzX1yI2oMv/JOEpeFIRFkzX08/xfR+m+diPE
        0OHIGUWMHcDGlM7mp8lIYC4b3IJbHMn6Hju+PEa4FXRVB0+nj7RA7gLmateEwp/2
        V9AxOFo6qiPfmy1yp5+beAPM/mwtJBAme9H2iJfQcbPIQbzkvVpKCBGsfnlmunvZ
        CFfoLfCD3I4RRI3ZWysL2IYYP08ajv2pXgr326qgZ4ggC6EAOXikOythTbp0BxHQ
        ==
X-ME-Sender: <xms:BYYjYacOAG-ExEKJEAjYsrOfKrY0-Uoi1CRHAaYgtRzo7Itw6uW29g>
    <xme:BYYjYUNjGuzxvghgt5MnsEBCNSqeZawgWrH9rewM0sW8rhpUcO1Ootfi5ybiWQI2r
    yBd5lxJQq9jKvNGnSM>
X-ME-Received: <xmr:BYYjYbjNjs_Lia0aF4ZgF16P5r9u8BiryvHaFEl4DA3r-cqUXsxctsdJZK3O8-zsQNSbbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddthedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgesthdtre
    dtredtvdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnhepgfeffedufffhgfeuheegffffgeegveeifeeute
    fhieejffetudfgueevteehtdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:BYYjYX9TJCfEXvoArnu5Sso20eNms8Ajg-Mw3xMp9X5KSLWYprXbdA>
    <xmx:BYYjYWtr06Rpve3GbVVeXNlpon5depx8QNLOYbU7EvTWWZaTwf-eWw>
    <xmx:BYYjYeF6EXLpAY_hmK8IwCErBjAniLUa55UwBTaQN-NIP5Zlc0KxFg>
    <xmx:BoYjYbWvPKnAekwixs8ZPU0Qcg6ZcwgY3CJfeE00sjMyWAgtnCWqng>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 07:26:56 -0400 (EDT)
Date:   Mon, 23 Aug 2021 23:26:40 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v4 1/1] asus-wmi: Add support for custom fan curves
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org
Message-Id: <GGIAYQ.PS5EB67PH64N@ljones.dev>
In-Reply-To: <7a8a8d56c4e6addfc41b5dd5262968bd169f538f.camel@hadess.net>
References: <20210820095726.14131-1-luke@ljones.dev>
        <20210820095726.14131-2-luke@ljones.dev>
        <321afe1a293be3a623a9be53feea3a008e044b31.camel@hadess.net>
        <L0W4YQ.ZVWQDLFJE8NR2@ljones.dev>
        <e7fbcf85f61b5c727a93df07b3bfe1624547067f.camel@hadess.net>
        <c19dfdde11754c234ca8a45c4af2187699498ee8.camel@hadess.net>
        <U8X4YQ.79I8GZJ1LDW02@ljones.dev>
        <b20a879dce98f27dfc68b86aaf486be9e623eacf.camel@hadess.net>
        <1EQ5YQ.6O8MNIPTU6V4@ljones.dev>
        <7a8a8d56c4e6addfc41b5dd5262968bd169f538f.camel@hadess.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Aug 23 2021 at 12:28:21 +0200, Bastien Nocera 
<hadess@hadess.net> wrote:
> On Sat, 2021-08-21 at 09:30 +1200, Luke Jones wrote:
>> 
>> 
>>  On Fri, Aug 20 2021 at 13:39:02 +0200, Bastien Nocera
>>  <hadess@hadess.net> wrote:
>>  > On Fri, 2021-08-20 at 23:00 +1200, Luke Jones wrote:
>>  > >
>>  > >
>>  > >  On Fri, Aug 20 2021 at 12:51:08 +0200, Bastien Nocera
>>  > >  <hadess@hadess.net> wrote:
>>  > >  > On Fri, 2021-08-20 at 12:43 +0200, Bastien Nocera wrote:
>>  > >  > >  On Fri, 2021-08-20 at 22:33 +1200, Luke Jones wrote:
>>  > >  > >  > > Am I going to get bug reports from Asus users that 
>> will
>>  > >  > > complain
>>  > >  > >  > > that
>>  > >  > >  > > power-profiles-daemon doesn't work correctly, where I
>>  > > will
>>  > >  > > have
>>  > >  > >  > > to
>>  > >  > >  > > wearily ask if they're using an Asus Rog laptop?
>>  > >  > >  >
>>  > >  > >  > No. Definitely not. The changes to fan curves 
>> per-profile
>>  > > need
>>  > >  > > to
>>  > >  > >  > be
>>  > >  > >  > explicitly enabled and set. So a new user will be 
>> unaware
>>  > > that
>>  > >  > > this
>>  > >  > >  > control exists (until they look for it) and their laptop
>>  > > will
>>  > >  > >  > behave
>>  > >  > >  > exactly as default.
>>  > >  > >
>>  > >  > >  "The user will need to change the fan curves manually so
>>  > > will
>>  > >  > >  definitely remember to mention it in bug reports" is a 
>> very
>>  > >  > > different
>>  > >  > >  thing to "the user can't change the fan curves to be
>>  > > nonsensical
>>  > >  > > and
>>  > >  > >  mean opposite things".
>>  > >  > >
>>  > >  > >  I can assure you that I will eventually get bug reports
>>  > > from
>>  > >  > > "power
>>  > >  > >  users" who break their setup and wonder why things don't
>>  > > work
>>  > >  > >  properly,
>>  > >  > >  without ever mentioning the changes they made changes to
>>  > > the
>>  > > fan
>>  > >  > >  curves, or anything else they might have changed.
>>  > >  >
>>  > >  > A way to taint the settings that power-profiles-daemon could
>>  > > catch
>>  > >  > would be fine by me. I absolutely don't want to have to
>>  > > support
>>  > >  > somebody's tweaks until they undo them.
>>  > >
>>  > >  Definitely understood. Do you have something in mind?
>>  >
>>  > A sysfs attribute with boolean data that shows whether custom fan
>>  > curves are used would be enough.
>> 
>>  The path /sys/devices/platform/asus-nb-wmi/active_fan_curve_profiles
>>  should be usable like this? I added this as the method for
>>  controlling
>>  which fan curves for which profiles are active.
>> 
>>  If empty, then no custom fan curves are active at all. If it 
>> contains
>>  any combination of strings "quiet, balanced, performance" then those
>>  associated (named) platform_profiles have an active fan curve and 
>> you
>>  can throw up a general warning, maybe add the contents of that file
>>  too?
> 
> That works for me, although I would probably have preferred a way that
> wasn't specific to the asus-wmi module, I'm sure I can made do with
> that.

Oh I see, you were looking to get a more general solution implemented? 
Maybe something like 
"/sys/devices/platform/asus-nb-wmi/platform_profile_tainted"? This 
could be an opportunity to maybe make a standardised naming scheme for 
it.

If you want something like that I'll get it done for asus-wmi.

> 
> Thanks
> 


