Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5DB31C95D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBPLHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230207AbhBPLEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:04:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DC2264DE0;
        Tue, 16 Feb 2021 11:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613473449;
        bh=vQG/+IVE2HDpboM3G/UKYla7ebws+7A1VUMGOZ8EJ9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d//fOz1hjXU6HuJF8IXKj1vAmvPvw2i6h5wjqPUlzO68J5LgsV2le+hy/4TeueDdF
         9T34O/qqt1w/ohQRnQv7ZTk4zOek0/piFehhIFr1kXXmVac5hLzRDp8NUhyImd3Apx
         Rd2s8CNWLNME3HKciewgL1GFAgwroooQoHZ8hLNU=
Date:   Tue, 16 Feb 2021 12:04:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ftrace: Do not reference symbols in sections without size
Message-ID: <YCumppsKxaheg/II@kroah.com>
References: <20210215164446.530f6311@gandalf.local.home>
 <20210216000504.axm3k4xho47c6drz@treble>
 <20210215200639.67141685@oasis.local.home>
 <20210215210057.4ceb6339@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215210057.4ceb6339@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:00:57PM -0500, Steven Rostedt wrote:
> On Mon, 15 Feb 2021 20:06:39 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Strange, that when I applied this to the latest kernel on a my build
> > system (binutils 2.35), it still created all the necessary mcount
> > locations??
> 
> I know why it worked. If you are using the latest gcc on the latest
> mainline, it will not even bother with recordmcount, and will just
> create the __mcount_loc sections, as latest gcc knows about ftrace.
> 
> (this is what I get for working on a company holiday)
> 
> Since this is a toolchain issue, perhaps the correct thing to do is to
> backport to stable the changes to have it build with -mrecord-mcount if
> the build system enables it.
> 
> If you are using the lastest compilers to build stable releases, and
> that's causing issues, then you should have the stable releases use the
> latest kernel compiler options.
> 
> Greg,
> 
> Can you test the following two backports. It does change the semantics
> of what is built, but then again if you are using a newer compiler to
> build stable kernels, that can change things too.
> 
> 96f60dfa5819a ("trace: Use -mcount-record for dynamic ftrace")
> 07d0408120216 ("tracing: Avoid calling cc-option -mrecord-mcount for every Makefile")
> 
> I attached the backports to 4.4. (just compiled tested, I'll test them more tomorrow)
> 

Yes, they build here for me!

Thanks for this.

Should I also queue these up for 4.9 and 4.14 which do not have these
commits in them either (but somehow do not show the problem, yet)?

thanks,

greg k-h
