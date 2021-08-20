Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF43F360B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbhHTVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:31:02 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49999 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231761AbhHTVbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:31:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4146A3200933;
        Fri, 20 Aug 2021 17:30:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 20 Aug 2021 17:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=U5X+tI
        73SRv3hWvY6y5Sg5KMMobaVA4WYF5XYgKBPIc=; b=GLzNIOM/ezHv7mTy4UJ+gC
        LkEexKc/PcfAfbzhfSlVWSoWC5jnI+BTnbpDARKxrSbIqB2oWgLXKjgfUw3Jzhd3
        aglevuoWnA6FXDv1xEAE0brHXthW32X825umIzZsxAJqlP9CT+G7YQxeoE9Nl6qI
        V65JXbupifmlmA9qLteS2GGDCIZKGaqs+3tY/K4dfBOXfToGFZhEV8zLXEPVJLEq
        zd085eFd+AetqkbCwEJSEza3tg3yussUWxycbRPYRc1kmA0QMxBesGPhrpXithCN
        2lCmDEp/hfQAORMEmXKwy2h9XzzjZkjb0i52jjWmnvE17cjSIpA3GbkUToCrrg7Q
        ==
X-ME-Sender: <xms:7B4gYaD3XmO5YMuvhCFcTCrHiT67Pr31j5TubNCBk4XgxAY7QOicPA>
    <xme:7B4gYUhLX_FSTqUduL30DnVe2-FwQ9EmNy9njU23lOhmCnzrt764-olgvsKZq2km1
    AwP7FZ5a-HLFBIeiGY>
X-ME-Received: <xmr:7B4gYdkV9jA40e2antrZEBprT2ySfOVJEjv3Y6HnN5aomH7GkyoIaI-BCRtHoEXPHmfekw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgesthdtre
    dtredtvdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnhepgfeffedufffhgfeuheegffffgeegveeifeeute
    fhieejffetudfgueevteehtdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:7B4gYYyvV4eugDH-kvtWwmFFxSch4tvnD8hFo8nzvn3_1WlMT65LSw>
    <xmx:7B4gYfRKYeGZfTad7BqafZHVrnAEcYJHZuHdkhLHT5e97rI92HGyMQ>
    <xmx:7B4gYTa-mpHHLQoF5d6jAVuDFGLErMTf-qCz7nYMR4Tu0ctcSdLZ_w>
    <xmx:7R4gYWKg6FaRz24bDLDU6yFPexG507r2cgVlxTejHs-QPtuW2umTsA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 17:30:16 -0400 (EDT)
Date:   Sat, 21 Aug 2021 09:30:00 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v4 1/1] asus-wmi: Add support for custom fan curves
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org
Message-Id: <1EQ5YQ.6O8MNIPTU6V4@ljones.dev>
In-Reply-To: <b20a879dce98f27dfc68b86aaf486be9e623eacf.camel@hadess.net>
References: <20210820095726.14131-1-luke@ljones.dev>
        <20210820095726.14131-2-luke@ljones.dev>
        <321afe1a293be3a623a9be53feea3a008e044b31.camel@hadess.net>
        <L0W4YQ.ZVWQDLFJE8NR2@ljones.dev>
        <e7fbcf85f61b5c727a93df07b3bfe1624547067f.camel@hadess.net>
        <c19dfdde11754c234ca8a45c4af2187699498ee8.camel@hadess.net>
        <U8X4YQ.79I8GZJ1LDW02@ljones.dev>
        <b20a879dce98f27dfc68b86aaf486be9e623eacf.camel@hadess.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 20 2021 at 13:39:02 +0200, Bastien Nocera 
<hadess@hadess.net> wrote:
> On Fri, 2021-08-20 at 23:00 +1200, Luke Jones wrote:
>> 
>> 
>>  On Fri, Aug 20 2021 at 12:51:08 +0200, Bastien Nocera
>>  <hadess@hadess.net> wrote:
>>  > On Fri, 2021-08-20 at 12:43 +0200, Bastien Nocera wrote:
>>  > >  On Fri, 2021-08-20 at 22:33 +1200, Luke Jones wrote:
>>  > >  > > Am I going to get bug reports from Asus users that will
>>  > > complain
>>  > >  > > that
>>  > >  > > power-profiles-daemon doesn't work correctly, where I will
>>  > > have
>>  > >  > > to
>>  > >  > > wearily ask if they're using an Asus Rog laptop?
>>  > >  >
>>  > >  > No. Definitely not. The changes to fan curves per-profile 
>> need
>>  > > to
>>  > >  > be
>>  > >  > explicitly enabled and set. So a new user will be unaware 
>> that
>>  > > this
>>  > >  > control exists (until they look for it) and their laptop will
>>  > >  > behave
>>  > >  > exactly as default.
>>  > >
>>  > >  "The user will need to change the fan curves manually so will
>>  > >  definitely remember to mention it in bug reports" is a very
>>  > > different
>>  > >  thing to "the user can't change the fan curves to be 
>> nonsensical
>>  > > and
>>  > >  mean opposite things".
>>  > >
>>  > >  I can assure you that I will eventually get bug reports from
>>  > > "power
>>  > >  users" who break their setup and wonder why things don't work
>>  > >  properly,
>>  > >  without ever mentioning the changes they made changes to the 
>> fan
>>  > >  curves, or anything else they might have changed.
>>  >
>>  > A way to taint the settings that power-profiles-daemon could catch
>>  > would be fine by me. I absolutely don't want to have to support
>>  > somebody's tweaks until they undo them.
>> 
>>  Definitely understood. Do you have something in mind?
> 
> A sysfs attribute with boolean data that shows whether custom fan
> curves are used would be enough.

The path /sys/devices/platform/asus-nb-wmi/active_fan_curve_profiles 
should be usable like this? I added this as the method for controlling 
which fan curves for which profiles are active.

If empty, then no custom fan curves are active at all. If it contains 
any combination of strings "quiet, balanced, performance" then those 
associated (named) platform_profiles have an active fan curve and you 
can throw up a general warning, maybe add the contents of that file too?

> 
> I could then check whether that file exists on startup, and throw a
> warning if custom curves are used, or become used, so that it shows up
> in power-profiles-daemon's logs.
> 


