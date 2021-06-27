Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0663B52F7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 13:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhF0LEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 07:04:45 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47131 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhF0LEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 07:04:43 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 031315804CC;
        Sun, 27 Jun 2021 07:02:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 27 Jun 2021 07:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=YJ1LUJRGUmPeyDjDjR2CRwZDQ72
        clg+sqlgzYMJOsFY=; b=pkmeuJofPNVeHgD0O0tXvU6+aOeS0L33QoKL+s6goAs
        L2vbgCtXXjk4OJdt5ol0MaO9e+37u1sf8A3CJkLVMmwHM9fIL3At9XeCfnncI1ff
        z8TTSyfKSfnXpD7bmbzUadOgoXxp9e+Q+z3JtNeZKkzqS+VsjPjfkdbvC+DxOuCX
        SM50zjwift3WjbeJJZamYlGA8h0XXjx44MJd7eXCBk8rbq+ym9dPC/wMDyxI5yk2
        lKOyYLDzi1ou4U4q9VF/N61oF0NAobmMWeAFMyyPtScJWbsVfeOJBAULQE2I3gdB
        zKly/O89zFPpebbMt7gAuOClVvXaf+Sv2dRrrWrt/uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YJ1LUJ
        RGUmPeyDjDjR2CRwZDQ72clg+sqlgzYMJOsFY=; b=BtGxqj3Jd5zIbjhnL9GWAc
        ukSEsd118rrQXLk1g67gPUShCz22ib0WXSTbvfC/kxMKXsJnKXbGpijBIyXdPNSr
        5LSBHJFI4beBnUf+BulUHhafhwDRzzge9TxXgrTCKWpgW9VR/bokh4dH2vJIUqTf
        pzRfy3NcVJA1DEzyOwmjN5599i+xX3lCjqQ8KJMrYg1huj1RCHjGVd2Mspe5Xp+y
        hxFbW4/vfldD3O/mBhE85pvSpkfaQvy0vJU1wlGKzpUEPZEWW0NUgPDkCToxasx1
        u4YuG4fORya2FbAXFLHVl4h+t0tTaGopy0kaMEgInT7pYUXj0Wofw8AUUTi9bI9g
        ==
X-ME-Sender: <xms:ulrYYPj_ypdgvkVEXW2nC-04NJOVCGi_H_I5NDanU8lIgns-Oy67jA>
    <xme:ulrYYMDo_VO53sG8xKk-KF3UkZmwt6VUCcra7eExeYWQnKznSsMh_JkZNQp_fNo2G
    KLwuXSQMiMc2w>
X-ME-Received: <xmr:ulrYYPHxmOpzEbO1h-9IvBcLcW9tHU_c6FH_3g2HcP2u9WAzZ1YTm5hWFfjbA9CK6Vmt6ADhUDMC1i86u3uAuJoSdnWcM4SJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehvddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:ulrYYMT1jJmQ4whKToCwoRTO0goMpxKBrf_Sh-oCThB8rlelsLGJkQ>
    <xmx:ulrYYMyAxsqjZQGfc5OzsK9Q2NBeZUFDJrW6SzBTVfVx0oebfFbFiA>
    <xmx:ulrYYC67MtN05oLMg0mPXeu3XQoNumcq6w0exWnJJZ40kKCrcMRgOA>
    <xmx:u1rYYBihwfHq5DiUKMqWI5u_8zwHY2F0wVEhC85YzFWyAmjnCbP0Iw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jun 2021 07:02:18 -0400 (EDT)
Date:   Sun, 27 Jun 2021 13:02:16 +0200
From:   Greg KH <greg@kroah.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNhauAgaUxMfTa+c@kroah.com>
References: <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
 <YNVneO6exCS4ETRt@kroah.com>
 <540d8a38-da12-56c8-8306-8d3d61ae1d6b@linux.intel.com>
 <YNXqXwq1+o09eHox@kroah.com>
 <e670abe2-67b9-a602-410a-0c4170796ec7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e670abe2-67b9-a602-410a-0c4170796ec7@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 07:49:36AM -0700, Andi Kleen wrote:
> 
> > Device names will change, that's always a given, as the kernel can never
> > always make them the same.  That's why userspace needs to scan the bus
> > for all devices and then pick out the one that it wants to look at.
> 
> In perf the tool doesn't normally know what devices (= pmu) the users want
> to look at. It's all specified on the command line depending on what events
> you want to measure. There's no way for the tool to figure that out on its
> own.
> 
> 
> > Don't hard-encode device names into userspace tools, that way lies
> > madness.
> 
> There's no hard coding in the tools (or at least not for the non json event
> list case). It all comes from the command line. But that is where the
> problem comes from.

Then do not break things by renaming the device name, as you all have
now stated that this name is part of the user/kernel api.

But really, I do not see why this is an issue, why isn't userspace just
properly walking the list of devices and picking the one on this
specific system that they want to look at?

> > > Anyways thinking about it if Greg doesn't want symlinks (even though sysfs
> > > already has symlinks elsewhere), maybe we could just create two devices
> > > without symlinks. Kan, do you think that would work?
> > Do not have 2 different structures represent the same hardware device,
> > that too is a shortcut to madness.
> > 
> > What prevents userspace from handling device names changing today?  Why
> > are you forcing userspace to pick a specific device name at all?
> 
> The way the perf tool works is that you have to specify the names on the
> command line:
> 
> perf stat -a -e uncore_cha/event=1/ ...
> 
> With the numeric identifiers it would be
> 
> perf stat -a -e uncore_type_X_Y/event=1/
> 
> The tool handles it all abstractly.

Great, and that device name is something that is unique per machine.
And per boot.  So why are you suddenly thinking that this name has to be
"stable"?

If you think it does have to be stable, that was your choice, so now you
must keep it stable.  Don't try to mess with symlinks and the like
please, as again, that way lies madness and unmaintainability for the
next 20+ years.

> So yes the user tools itself can handle it. But the problem is that it is
> directly exposed to the users, so the users would need to change all their
> scripts when switching between the two cases. That is what we're trying to
> avoid -- provide them a way that works on both.

But these are different systems!  Why would anyone expect that the
device name is the same on different systems?  If you insist on keeping
the name identical for newer kernel versions, then again, that was your
choice and now you have to do that.  Do not try to work around your own
requirement by using a symlink.

greg k-h
