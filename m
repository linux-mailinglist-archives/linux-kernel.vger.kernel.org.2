Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE7E3B45E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhFYOlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:41:01 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:48243 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhFYOku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:40:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id DB5672B00B1C;
        Fri, 25 Jun 2021 10:38:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 25 Jun 2021 10:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=GpArqP1e/0nk1yUO/CK1bfXcmbJ
        DmDt6zrZYry34CYg=; b=laRCk6YGSWR+NltLSDAJJORGewwhgzptyaZL5oNt+R3
        wfoLMGQo8IN0Ok5LKL+fKI63BIWNxcnZdUN9Dxi1vbXgmYX8XC0LpjLnwEVo5D2u
        HU0FJtJnmh7e/+PpTZqRLj0Hrs8bHUbgyWnejUbT7vGIltTdGl/woIkjNDYs8q1W
        Cvut3UNvyo/PGAptO6SZeAbZ1HkFLckoSjbv123KznNzq3VO3hohwxbamY2c+nSw
        NXBgwUWCDpEhyu7RDVoo/xoawRY6sB+/U7SEHWNJ8SJf9xOJTbKqZVgLcRYG5XIB
        y4fTHtqUOoioxzhYyRj/Y+xaD/6/cvUdu2aYiEoTMAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GpArqP
        1e/0nk1yUO/CK1bfXcmbJDmDt6zrZYry34CYg=; b=u59MrQSJbB0JOaU+UgLtZL
        Num87Gm8S4YlxGZjycbmbHz+k0M+QGj02s9kTvseUGuqkjr48aNDci1bqBpvN5e9
        +HQjSB+97sl2uVnMLucTe2xb1TPx+fJ0jQ3pAg1gr+LQKG0K2pDe4T3XphUZ5mjT
        IjDTfHP1If5rLwdkCqX2f3zuSKv43g7XlwIyMHEsr8sJarXlIyFEmghZr//SMniQ
        lq+BjkJ9Wa/H88CF3vpjaMQsEVeKD70gOVyz51i9gvxdq+ZL9aYUznfnyNj0o1wa
        /rQ7y93XIL/Mf1c+CC99OdyjeOKXC7BM9W+09U8lCZbH4Gse9N+q/aYr5QnyFoiA
        ==
X-ME-Sender: <xms:YurVYB_kCDMQrLNK-wU45PtTftfWcjlfQcW4d0Q2-1cMfb_VvqyayA>
    <xme:YurVYFsXRy4s1r4xfzHwk1dhqLGAHiMHoVRXetJTDAbmQclOOHM6tV8XbrzSG8Bvy
    m81xOWn3kIi-g>
X-ME-Received: <xmr:YurVYPALhfx3dLb5K3u0IMXHJgQztMYo0eP3mZ7TN6NI4PF5705TNx6Nsg96bHqUmmEMdzQpaB7B0sozX-lGvoRFGw5nD9LX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:YurVYFchg3PoVdm69aGlVbVvjXD0k4jZe57idWbWVZJ65LmQ39mA5w>
    <xmx:YurVYGMgQWlHNnn1cD6IrlAMczEfjITKdmN0lDDLhN58_jay5ssveQ>
    <xmx:YurVYHlY_okKvMJTf-_FdYNBDfZxtPP5kzNijaSY4O69imPbOxt3Lg>
    <xmx:Y-rVYLfRodD1wgQ4j8E82wWsrE16bbadJ7sNniLp_FphSNU_R51v2LHGyRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jun 2021 10:38:26 -0400 (EDT)
Date:   Fri, 25 Jun 2021 16:38:23 +0200
From:   Greg KH <greg@kroah.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNXqXwq1+o09eHox@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
 <YNVneO6exCS4ETRt@kroah.com>
 <540d8a38-da12-56c8-8306-8d3d61ae1d6b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540d8a38-da12-56c8-8306-8d3d61ae1d6b@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 07:22:08AM -0700, Andi Kleen wrote:
> 
> On 6/24/2021 10:19 PM, Greg KH wrote:
> > On Thu, Jun 24, 2021 at 10:28:36AM -0700, Andi Kleen wrote:
> > > > But a driver does not caer.  And if perf does not care, who cares?
> > > The users who write scripts that specify the perf events on the perf command
> > > line.
> > Great, then as you have deemed the device name part of your documented
> > api, then keep it stable as that is what you decided to do a long time
> > ago when it was created.
> 
> The fully supported driver keeps it stable, but the driver in fallback mode
> (as in running on a yet unknown system) can't because it doesn't have enough
> information. It has to fall back to the numeric identifiers.
> 
> Supporting yet unknown systems is a big advantage, missing full kernel
> support is the number one reason people can't use uncore monitoring today.
> 
> The symlink keeps some degree of compatibility between the two.

But it creates something that is not needed at the moment, and then
userspace will rely on it.  Don't make userspace rely on it today and
all should be fine.

Device names will change, that's always a given, as the kernel can never
always make them the same.  That's why userspace needs to scan the bus
for all devices and then pick out the one that it wants to look at.
Don't hard-encode device names into userspace tools, that way lies
madness.

> Anyways thinking about it if Greg doesn't want symlinks (even though sysfs
> already has symlinks elsewhere), maybe we could just create two devices
> without symlinks. Kan, do you think that would work?

Do not have 2 different structures represent the same hardware device,
that too is a shortcut to madness.

What prevents userspace from handling device names changing today?  Why
are you forcing userspace to pick a specific device name at all?

thanks,

greg k-h
