Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766D2326D65
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 15:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhB0O1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 09:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhB0O1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 09:27:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 433A564EC6;
        Sat, 27 Feb 2021 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614436019;
        bh=BAUsoxDia95Yu5oGpOfWnmpRFLgOLXYVNWKOgTGNnHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1d4vU1NaR/j1qBBzwe3Ok22pMb9WjzDN1Kjv9nN2q4mdVWgLQ1D/g5MfYa235ZT5
         6F/uo39776HchffkML4oOv1Qt7QmAwguQXkE3o9YgQbp5AKv8Oq8Sf2mWO9qFVf5+f
         yEocOACSiVlp4j/LDAXWZ++htRDeR4D5Cs6+4bS8=
Date:   Sat, 27 Feb 2021 15:26:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL] Driver core / debugfs changes for 5.12-rc1
Message-ID: <YDpWsXwB6MJPjS7J@kroah.com>
References: <YDZiQoP8h/QDSNkJ@kroah.com>
 <CAHk-=wj2kJRPWx8B09AAtzj+_g+T6UBX11TP0ebs1WJdTtv=WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2kJRPWx8B09AAtzj+_g+T6UBX11TP0ebs1WJdTtv=WQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 10:20:44AM -0800, Linus Torvalds wrote:
> On Wed, Feb 24, 2021 at 6:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> >  [..] I've reverted that change at
> > the very end so we don't have to worry about regressions in 5.12.
> 
> Side note: it would have been really nice to see links to the actual
> problem reports in the revert commit.

Odd, this showed up in my gmail spam folder, just saw this now :(

> Yes, there's a "Link:" line there, but that points to the
> less-than-useful patch submission for the revert, not to the actual
> _reasons_ for the revert.
> 
> Now I'm looking at that revert, and I have absolutely no idea why it
> happened. Only a very vague "there are still reported regressions
> happening".
> 
> I've pulled it, but wanted to just point out that when there's some
> fairly fundamental revert like this, it really would be good to link
> to the problems, so that when people try to re-enable it, they have
> the history for why it didn't work the first time.
> 
> Now all that history is basically lost (well, hopefully Saravana and
> you actually remember, but you get my point).

Sorry, the history is on the original commit Link that was reverted, and
in lots of other emails on lkml over the past few weeks.  Next time I'll
include links to those threads as well.

thanks,

greg k-h
