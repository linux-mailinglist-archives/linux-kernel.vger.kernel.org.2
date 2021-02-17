Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86DF31D711
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 10:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhBQJld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 04:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBQJl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 04:41:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D36A64E24;
        Wed, 17 Feb 2021 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613554847;
        bh=zTBnhUBicLMK418XoQbCeYvpc/x8gnxbS2YfdtEKuW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3pRHJm5RuCScnkV2FicMYeFVvsYXBuhMI0z1fu4C9b+LkxK/gHRT8gosgPefzWUf
         DB7+Ub0X+oGys7JXo4gbXeK79HSNbiX3cB4Dk5I0yTWKkeO49+oqLn4DVfHSQoweHG
         wwXAMFNTn+xiXFNt5esrOCLsUXUGhYBM/dZvMML8=
Date:   Wed, 17 Feb 2021 10:40:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YCzknUTDytY8gRA8@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YBBkplRxzzmPYKC+@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:51:18PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 26, 2021 at 10:30:16AM -0800, Scott Branden wrote:
> > Hi Greg,
> > 
> > 
> > On 2021-01-25 11:29 p.m., Greg Kroah-Hartman wrote:
> > > On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
> > >> Hi All,
> > >>
> > >> The 5.10 LTS kernel being officially LTS supported for 2 years presents a problem:
> > >> why would anyone select a 5.10 kernel with 2 year LTS when 5.4 kernel has a 6 year LTS.
> > > Because they want to use all of the latest stuff that 5.10 provides
> > > them.  Don't you want faster and more secure kernels for your devices?
> > Yes, 5.10 is a more secure and less buggy kernel than 5.4.
> 
> Great, use it, ship it to your customers and we are all happy.  What do
> you need me for any of this?  :)
> 
> > >>   And AOSP has already declared the use
> > >> of 5.10 kernel in their Android S and T releases.
> > > Publically?  Where?  And is that really the name of the new Android
> > > releases, I thought they switched to numbers now (hence the naming of
> > > the current android-common kernel branches, marketing is fun...)
> > https://source.android.com/devices/architecture/kernel/android-common
> > Feature and launch kernels provides kernels supported per version.
> 
> Oh nice, didn't know that.
> 
> But note, Android kernels do not reflect the lifespan of LTS kernels.
> If that were the case, I would still be supporting 3.18 as they are
> doing that at the moment for their devices and customers, and will be
> doing so for I think another full year.
> 
> So while Android is nice to see here, remember that is what Google is
> promising to support for their users.  You can do the same thing for
> your users, what do you need me here for this?  You can do the same
> thing that Google is doing for 3.18 right now, pick the stable fixes
> from upstream, backport them, test them, and push them out to their
> users.
> 
> While Google is a great help to me in the LTS effort, providing huge
> amounts of resources to enable my life easier with this (i.e. funding
> Linaro's testing efforts), their promise to their customers/users does
> not depend on me keeping LTS kernels alive, if I stopped tomorrow their
> contracts are still in place and they know how to do this work
> themselves (as is proof with 3.18).
> 
> So you can provide the same kind of guarantee to support any kernel
> version for any amount of time to any customer you like, it shouldn't
> require me to do that work for you, right?
> 
> > >> Is there some way we could make the LTS support more clear.
> > >> A 2 year declaration is not LTS any more.
> > > Not true at all, a "normal" stable kernel is dropped after the next
> > > release happens, making their lifespan about 4 months long.  2 years is
> > > much longer than 4 months, so it still is a "long term supported" kernel
> > > in contrast, correct?
> > Perhaps a new name needs to be made for "LTS" for 6 years to distinguish it from 2 years.
> > The timeframes are very different.
> 
> At this point in time, anyone wanting a kernel longer than 2 years
> should know how this all works.
> 
> If not, please do some basic research, I have written whitepapers on
> this and given numerous talks.  The information is out there...
> 
> > >> If 5.10 is "actually" going to be supported for 6 years it would be quite valuable to make such a declaration.
> > >> https://www.kernel.org/category/releases.html
> > > Why?  What would that change?
> > >
> > > Ok, seriously, this happens every year, and every year we go through the
> > > same thing, it's not like this is somehow new, right?
> > No, but why do we need to keep playing the same game every year now.
> 
> Because, 5.4 almost did not become "6 years" of support from me.  That
> was because in the beginning, no one said they were going to use it in
> their devices and offer me help in testing and backporting.  Only when I
> knew for sure that we had people helping this out did I change the date
> on kernel.org.
> 
> So far the jury is still out for 5.10, are you willing to help with
> this?  If not, why are you willing to hope that others are going to do
> your work for you?  I am talking to some companies, but am not willing
> to commit to anything in public just yet, because no one has committed
> to me yet.

Following up on this as I did not hear back from you.  Are you and/or
your company willing to help out with the testing of 5.10 to ensure that
it is a LTS kernel?  So far I have not had any companies agree to help
out with this effort, which is sad to see as it seems that companies
want 6 years of stable kernels, yet do not seem to be able to at the
least, do a test-build/run of those kernels, which is quite odd...

If you want to point people at your company this link that explains it
all in a single location instead of an email thread:
	http://www.kroah.com/log/blog/2021/02/03/helping-out-with-lts-kernel-releases/
that would be great.

thanks,

greg k-h
