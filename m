Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B131E7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 09:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhBRIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:53:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhBRHof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:44:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62B7A64DE9;
        Thu, 18 Feb 2021 07:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613634232;
        bh=EK13nicCXPSy8Kqu5Ez1Dt1gkcZUfLETZMoBvWxfkDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVpW5s6PmB4OxkiT59go9OZzaFXkJbhILJrYKSOu+9fngBeYs7hvMoJmPOBr4+4Jl
         W0dSYrZkAHoD2DOqAp1YYYfx6AArrKmZPhfylXlqZntB3EYa+VAwjqsf/hj8A3INQ9
         KSUx9e/3phr0+Wegsujpk8eBR2qKUbY+/jQNY3JY=
Date:   Thu, 18 Feb 2021 08:43:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC4atKmK7ZqlOGER@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 11:48:21AM -0800, Scott Branden wrote:
> Hi Greg,
> 
> On 2021-02-17 1:40 a.m., Greg Kroah-Hartman wrote:
> > On Tue, Jan 26, 2021 at 07:51:18PM +0100, Greg Kroah-Hartman wrote:
> >> On Tue, Jan 26, 2021 at 10:30:16AM -0800, Scott Branden wrote:
> >>> Hi Greg,
> >>>
> >>>
> >>> On 2021-01-25 11:29 p.m., Greg Kroah-Hartman wrote:
> >>>> On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
> >>>>> Hi All,
> >>>>>
> >>>>> The 5.10 LTS kernel being officially LTS supported for 2 years presents a problem:
> >>>>> why would anyone select a 5.10 kernel with 2 year LTS when 5.4 kernel has a 6 year LTS.
> >>>> Because they want to use all of the latest stuff that 5.10 provides
> >>>> them.  Don't you want faster and more secure kernels for your devices?
> >>> Yes, 5.10 is a more secure and less buggy kernel than 5.4.
> >>
> >> Great, use it, ship it to your customers and we are all happy.  What do
> >> you need me for any of this?  :)
> >>
> >>>>>   And AOSP has already declared the use
> >>>>> of 5.10 kernel in their Android S and T releases.
> >>>> Publically?  Where?  And is that really the name of the new Android
> >>>> releases, I thought they switched to numbers now (hence the naming of
> >>>> the current android-common kernel branches, marketing is fun...)
> >>> https://source.android.com/devices/architecture/kernel/android-common
> >>> Feature and launch kernels provides kernels supported per version.
> >>
> >> Oh nice, didn't know that.
> >>
> >> But note, Android kernels do not reflect the lifespan of LTS kernels.
> >> If that were the case, I would still be supporting 3.18 as they are
> >> doing that at the moment for their devices and customers, and will be
> >> doing so for I think another full year.
> >>
> >> So while Android is nice to see here, remember that is what Google is
> >> promising to support for their users.  You can do the same thing for
> >> your users, what do you need me here for this?  You can do the same
> >> thing that Google is doing for 3.18 right now, pick the stable fixes
> >> from upstream, backport them, test them, and push them out to their
> >> users.
> >>
> >> While Google is a great help to me in the LTS effort, providing huge
> >> amounts of resources to enable my life easier with this (i.e. funding
> >> Linaro's testing efforts), their promise to their customers/users does
> >> not depend on me keeping LTS kernels alive, if I stopped tomorrow their
> >> contracts are still in place and they know how to do this work
> >> themselves (as is proof with 3.18).
> >>
> >> So you can provide the same kind of guarantee to support any kernel
> >> version for any amount of time to any customer you like, it shouldn't
> >> require me to do that work for you, right?
> >>
> >>>>> Is there some way we could make the LTS support more clear.
> >>>>> A 2 year declaration is not LTS any more.
> >>>> Not true at all, a "normal" stable kernel is dropped after the next
> >>>> release happens, making their lifespan about 4 months long.  2 years is
> >>>> much longer than 4 months, so it still is a "long term supported" kernel
> >>>> in contrast, correct?
> >>> Perhaps a new name needs to be made for "LTS" for 6 years to distinguish it from 2 years.
> >>> The timeframes are very different.
> >>
> >> At this point in time, anyone wanting a kernel longer than 2 years
> >> should know how this all works.
> >>
> >> If not, please do some basic research, I have written whitepapers on
> >> this and given numerous talks.  The information is out there...
> >>
> >>>>> If 5.10 is "actually" going to be supported for 6 years it would be quite valuable to make such a declaration.
> >>>>> https://www.kernel.org/category/releases.html
> >>>> Why?  What would that change?
> >>>>
> >>>> Ok, seriously, this happens every year, and every year we go through the
> >>>> same thing, it's not like this is somehow new, right?
> >>> No, but why do we need to keep playing the same game every year now.
> >>
> >> Because, 5.4 almost did not become "6 years" of support from me.  That
> >> was because in the beginning, no one said they were going to use it in
> >> their devices and offer me help in testing and backporting.  Only when I
> >> knew for sure that we had people helping this out did I change the date
> >> on kernel.org.
> >>
> >> So far the jury is still out for 5.10, are you willing to help with
> >> this?  If not, why are you willing to hope that others are going to do
> >> your work for you?  I am talking to some companies, but am not willing
> >> to commit to anything in public just yet, because no one has committed
> >> to me yet.
> > 
> > Following up on this as I did not hear back from you.  Are you and/or
> > your company willing to help out with the testing of 5.10 to ensure that
> > it is a LTS kernel?  So far I have not had any companies agree to help
> > out with this effort, which is sad to see as it seems that companies
> > want 6 years of stable kernels, yet do not seem to be able to at the
> > least, do a test-build/run of those kernels, which is quite odd...
> I personally cannot commit to supporting this kernel for 6 years
> (and personally do not want to backport new features to a 6 year old kernel).

Why would you backport new features to an old kernel?  That's not what
they are there for.

> And customers are finicky and ask for one thing and then change their mind later.

Sure, but it's up to you to define what you will support, for your
customers, which is what I am asking here.

> We'll have to see what decisions are made at a company level for this as there
> are added costs to run tests on LTS kernel branches.  We already run extensive QA on
> whatever active development branches are in use and a subset on the mainline
> branch as well.  QA resources are finite and committing those for 6 years is
> not something that makes sense if customers drop that kernel version.
> Testing of the LTS kernel changes really moves out of our hands and into the
> customer's testing after our major releases to them.

That feels wrong, but hey, I'm not your customer.  If I was, I would be
demanding all LTS updates for the specific kernel branch you gave me as
I am paying for that support :)

> Other difficulty with the LTS version is the frequency it is updated.  We would not
> pickup the changes that frequently to test.  A quarterly, bi-annually, or when a critical fix
> is identified would be when we update and perform any meaningful testing when in maintainence.

How are you "identifying" these "critical fixes"?  We fix at least one
known security issue a week, and probably multitudes of
unknown-at-this-moment ones.  How are you determining when you need to
send a new base kernel update off to your customers?  At such long
intervals it feels like anyone using your kernel releases is woefully
insecure.

Although if you do get people to update on a quarterly basis no matter
what, that's better than nothing, I'll take that.  What's the odds that
this really happens?

> > If you want to point people at your company this link that explains it
> > all in a single location instead of an email thread:
> > 	http://www.kroah.com/log/blog/2021/02/03/helping-out-with-lts-kernel-releases/
> > that would be great.
> Thanks for the link.  Will forward it to see if it helps make any commitment from customers
> or company.

Thanks.  When can I expect to hear something back, even if it is a "no,
we don't care about supporting 5.10"?

> The link Pavel sent looks interesting.
> "CIP project intends to maintain 5.10 for a long time, so you can expect testing/help from them:
> https://www.cip-project.org/blog/2020/12/02/cip-to-embark-on-kernel-5-10-development-for-slts
> "
> 
> If the CIP project has committed to 10 years you would think they would be in contact
> with you to add their support to the 5.10 LTS effort.

They are doing testing right now, see the announcements where they test
each stable -rc release.  But they have not talked to me about 5.10
yet, Their model is that they will, somehow in a way that is yet to be
determined, take over maintaining these releases _after_ I drop them.
But they are only going to do so for a very specific hardware platform
or two, so anyone using anything other than their specific boards, is
going to be out of luck.

Which makes sense, scoping support like this to those that actually care
about a specific hardware platform is much easier than the work that I
and Sasha do in support it for all platforms.  So if you are interested
in 10 years, please work with CIP to get your platform into that list.

thanks,

greg k-h
