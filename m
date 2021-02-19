Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7B31FC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBSPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhBSPyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:54:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B2D064EAF;
        Fri, 19 Feb 2021 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613750010;
        bh=EH8b9ukogYGAiNb+Z4fCszO4iJkHMWzL/zD2TZFlvkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjMA2sI9o0UYM+dp+b2BNQ5wWzpfEacidLFUiQgRSJV4vi7W/jAbenqYA9EZN8ElU
         APspdvgRVz4VNDNsY2RyFiynUW8A7Z0pXFxH3BKyiIOesoawWBanYdy+uuja54Rw2e
         Fgfa4KIGuvwSQsP9AEq29nPjU4YDjllfrPu+8WvM=
Date:   Fri, 19 Feb 2021 16:53:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Willy Tarreau <w@1wt.eu>, Sasha Levin <sashal@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC/e93UHxa8V9Q6I@kroah.com>
References: <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com>
 <YC6ptKgsMh20tmu6@kroah.com>
 <20210218182050.GB15217@1wt.eu>
 <YC6zq3u2jciI2gyZ@kroah.com>
 <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
 <YC915N/9YNqePueL@kroah.com>
 <cf9323b7-71c8-dd96-1755-ce90370af6d5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf9323b7-71c8-dd96-1755-ce90370af6d5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 07:05:41AM -0800, Florian Fainelli wrote:
> 
> 
> On 2/19/2021 12:25 AM, Greg Kroah-Hartman wrote:
> > On Thu, Feb 18, 2021 at 12:16:50PM -0800, Scott Branden wrote:
> >> On 2021-02-18 10:36 a.m., Greg Kroah-Hartman wrote:
> >>> On Thu, Feb 18, 2021 at 07:20:50PM +0100, Willy Tarreau wrote:
> >>>> On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
> >>>>> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
> >>>>>> As a company, we are most likely shooting ourselves in the foot by not
> >>>>>> having a point of coordination with the Linux Foundation and key people
> >>>>>> like you, Greg and other participants in the stable kernel.
> >>>>>
> >>>>> What does the LF have to do with this?
> >>>>>
> >>>>> We are here, on the mailing lists, working with everyone.  Just test the
> >>>>> -rc releases we make and let us know if they work or not for you, it's
> >>>>> not a lot of "coordination" needed at all.
> >>>>>
> >>>>> Otherwise, if no one is saying that they are going to need these for 6
> >>>>> years and are willing to use it in their project (i.e. and test it),
> >>>>> there's no need for us to maintain it for that long, right?
> >>>>
> >>>> Greg, please remember I expressed I really need them for slightly more than
> >>>> 3 years (say 3.5-4) :-) I'm fine with helping a bit more as time permits if
> >>>> this saves me from having to take over these kernels after you, like in the
> >>>> past, but I cannot engage on the regularity of my availability.
> >>>
> >>> Ok, great!
> >>>
> >>> That's one person/company saying they can help out (along with what CIP
> >>> has been stating.)
> >>>
> >>> What about others?  Broadcom started this conversation, odd that they
> >>> don't seem to want to help out :)
> >> Greg, I'm sorry but I'm not in a position to provide such a commitment.
> > 
> > Ok, who at Broadcom do I need to talk to to get that type of commitment?
> 
> I am not sure if I was too subtle before, we (Broadcom) cannot give you
> an unified voice to speak with because we are divided in silos/business
> units that make their independent decisions.

That's fine, I'm totally used to that, large (and even small) companies
always have different groups with different roadmaps and policies.

> The group I work in (STB/CM, different from Scott's) is committed to
> using the 5.10 kernel for 6 years and that is a decision that has been
> taken.

Great!  Will you all be testing the -rc releases and letting me know how
they work for your systems?

> I could give you names of other decision makers in other business units
> I know who also deliver Linux for their respective business units
> however some of them may not make public appearances on mailing lists,
> let alone care about upstreaming their changes so I do not know whether
> a 6 years 5.10 kernel is even something they remotely entertain.

That's fine, I'm not expecting emails from the list, we can take this
off-list if you like as it sounds like I need to talk to some different
managers there, right?  :)

thanks,

greg k-h
