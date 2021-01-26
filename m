Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DAB30527D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhA0DQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:16:28 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49367 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732376AbhAZUQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:16:55 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10QKFh47016094;
        Tue, 26 Jan 2021 21:15:43 +0100
Date:   Tue, 26 Jan 2021 21:15:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210126201543.GA16044@1wt.eu>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBBkplRxzzmPYKC+@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Jan 26, 2021 at 07:51:18PM +0100, Greg Kroah-Hartman wrote:
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

This is interesting, because I used to extend LTS kernels after you dropped
them exactly for the reason I needed them. With 6 months of porting+testing,
~3 years of major version life in field, and roughly 6 extra months covering
late starts or minor extensions to help match a deadline, I figured that 4
years was the minimum we needed for our products. As such, 6 years add some
comfort, but as you probably remember I once got scared not knowing if 4.19
was going to be extended or not as we were having plenty in field and I did
not plan to get back to that maintenance myself. These days, the 6 years
duration allows us to skip one upgrade if we're too late, but we still
prefer to upgrade every year. It's also true that before engaging in that
direction before the official statement was on the site, each time I
preferred to ask you how you felt about it, and I'm sure most major players
decide after checking with you as well. For sure knowing better early would
be much better but I understand your concerns about doing that job for free
and for no reason.

I initially got the impression that the extra resources you got were enough
to help you and to keep me away from annoying you again with pushing my late
branches, but it's certain that free time cannot extend forever. And You,
Ben, Sasha and me definitely know how painful it is to backport past 2.5-3
years, especially with security stuff that everyone expects but often is
the riskiest. While most of my time is spent in userland these days, I'm
still willing to help as I can if that saves from from having to takeover
an old kernel again on my week-ends.

One of my impression, which might or might not be shared, is that the
duration is more important than the frequency, which means that having
one extended kernel every two years would bring much more value than
maintaining all of them only 3 years, and would equally result in cutting
the effort in half: with 6 years, you still have 5 years if you upgrade
every two years.

> What would you do if you were in my situation?

I'd continue to ask for a shared effort for extended support, which
everyone benefits from.

Maybe one possibility would be to start gauging upfront around september
whether or not the end-of-year's LTS should be an extended LTS or not,
and if so, what's needed and who's willing to particpate. I suspect that
numerous companies have available resources to help but are not even
aware that they could help, and they're seeing something which works
extremely well so there's nothing to try to improve. And if nobody
provides resources, it means there's not enough interest to create yet
another extra LTS kernel so better save the effort.

Just my two cents,
Willy
