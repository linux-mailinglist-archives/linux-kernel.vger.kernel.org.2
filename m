Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9063734B648
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 11:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhC0Klm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 06:41:42 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38471 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229875AbhC0Kll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 06:41:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 67B005803A8;
        Sat, 27 Mar 2021 06:41:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 27 Mar 2021 06:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rlCpEeZ8jDS1lgCxwL+8UG+0KQY
        J9NVQzqCdEKtSqNE=; b=dizU7vMg85Rxgf+LtmzxnwuBG80VnViEsFM36i6pC4S
        /PBUIKiarmO0uc25Gf/cj3KTh3E9nKvBnHjoOM9IZznUYFkSVqfqb6zWGM0AjEbE
        Fuu+avQT0VznZSoZwbkauEPiMDMmyamzpA2sibkIRV36iLveeBozBEdoPPwRcbgN
        IT3/LMF6xEttTvfLnHzNa+s+YrBGjx7fxmxaLUAYQsRtNjntGYq1blAAz/AvggaD
        5F3AAYwFforg634aSUNY/UL8Q3XD3WT+y0P1SJeCs8qzDluloAneJVhcxCgpKzKL
        jPQ3vo9GRwriEMmQ7DU/tOXxWNFRoGK52vmxJn/XOmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rlCpEe
        Z8jDS1lgCxwL+8UG+0KQYJ9NVQzqCdEKtSqNE=; b=uPe3K8Trvd5dbx5sZi42Ft
        TPYBa4QgM7tLCVkWkjBvuGb/q1slTJlZQ1LjVJBF/LEKU2Pgbou1AK8y2SkTQGV3
        NVeNi4yMpJiJls8tZ5HHmDBfXHk8FxcDc2+A9xOcxow/Wzz1ie5LDF8Ix33pDLu9
        HG/zrMxUqlAU+J+mUBK83EAO+FcfMCMzV4m9RIR3cavmc0g7Q1SIHTV9OFleAtN7
        2w4UhTi0kPEaNFeuETJtKZed94S5slWa113MZe4PhWa/5d2CGDQK1NA48+d84qB9
        /lfK4oKZFrt6Qxl+hKfEMA7BvDrhdjoaAcMLG9azYQ63XBn+qMTjkvaOXEStc6ww
        ==
X-ME-Sender: <xms:4wtfYKrcCGeBQgHjJ8W87F-CmDxG4Ti5ELYNrss2d-WN6wk-KhTVUA>
    <xme:4wtfYIrMtPV0rTE_yi5S5lUY27j9rUg57uvsfO48CiXsyBdV1T19to-ZlNuPLpBPu
    dY2dsJ_bB74Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:4wtfYPNqV0CqPF4MECHsXAnDinTJu7JQxPhBVu5Vf_EUqOWhrkBEgQ>
    <xmx:4wtfYJ5HNoZjBASjXdM5H0lTIvIsEoBTjI7PblkTYDsb11wonmlNGw>
    <xmx:4wtfYJ42YC-XseZDskjD-ZL6ioEYzIT4VB9fwpObD2AnnojcGA1Xmg>
    <xmx:5AtfYGys2VeE_ScBNSLvAfeZxtFI8UlnHt8tZVBpmWA-4xy3K7OdWg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id C04E7240057;
        Sat, 27 Mar 2021 06:41:38 -0400 (EDT)
Date:   Sat, 27 Mar 2021 11:41:36 +0100
From:   Greg KH <greg@kroah.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF8L4BMSMeuIq2JS@kroah.com>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
 <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
 <20210326142230.GJ4746@worktop.programming.kicks-ass.net>
 <c1be3728-40e7-f200-ece0-cd3f11349f65@rasmusvillemoes.dk>
 <20210326151912.GL4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326151912.GL4746@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:19:12PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 26, 2021 at 03:58:37PM +0100, Rasmus Villemoes wrote:
> > >   kmalloc(len + 2, ...);
> > 
> > No, because nul-terminating the stuff you pass to
> > simple_read_from_buffer is pointless cargo-culting. Yeah, read_file_bool
> > does it, but that's just bogus.
> 
> Urgh, feel yuck to not have it zero terminated, but if you feel strongly
> about it I suppose I can make it go away.
> 
> > > 	len = strscpy(copy, str, len);
> > > 	if (len < 0)
> > > 		return len;
> > 
> > To what end? The only way that could possibly return -EFOO is if the
> > nul-terminator in str vanished between the strlen() and here, and in
> > that case you have bigger problems.
> 
> There are strings in the kernel which we rewrite in most ugly ways,
> task_struct::comm comes to mind. Best be paranoid.
> 
> > > Copy-pasta from debugfs_*_bool(). This thing seems to export everything
> > > and I figured I'd go along with that.
> > 
> > I thought the convention was not to export anything until the kernel
> > itself had a (modular) user.
> 
> That's generally how I feel too. But this really isn't my subsystem so I
> more or less try to mimmick what I see done there.

I'll take some time next week and go through and remove any exports in
debugfs that are not actually needed for exports as it's been a while
since I last looked...

But that should not affect this change, it's fine to me as-is.

thanks,

greg k-h
