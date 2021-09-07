Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6FB4026D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbhIGKJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236985AbhIGKJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B057603E7;
        Tue,  7 Sep 2021 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631009326;
        bh=pIiemJLPaAy67hAx81382ZlctfAZvjwMb3odoIi4t8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJprcHQPU4NJe7pu023OmmO3hX7YlxxIngzyharrQmFRr3jrCraouT3qGwm8VY6wq
         N09HZ1BRF8EnyOcfFuyDzmeUBmRqp1dg63vnZURCjQSUgHjPKqXFBnRfLt+VA603+W
         yd3VKUOy8kukhReVajZlCMwjodmug6RAo4XNoJOM=
Date:   Tue, 7 Sep 2021 12:08:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     paskripkin@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, larry.finger@lwfinger.net,
        phil@philpotter.co.uk
Subject: Re: patch "staging: r8188eu: Remove _enter/_exit_critical_mutex()"
 added to staging-testing
Message-ID: <YTc6LCathRnb0U6U@kroah.com>
References: <1630997812180231@kroah.com>
 <3355001.phisWU0qcP@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3355001.phisWU0qcP@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 11:00:28AM +0200, Fabio M. De Francesco wrote:
> On Tuesday, September 7, 2021 8:56:52 AM CEST gregkh@linuxfoundation.org 
> wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     staging: r8188eu: Remove _enter/_exit_critical_mutex()
> > 
> > to my staging git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> > in the staging-testing branch.
> > 
> > The patch will show up in the next release of the linux-next tree
> > (usually sometime within the next 24 hours during the week.)
> > 
> > The patch will be merged to the staging-next branch sometime soon,
> > after it passes testing, and the merge window is open.
> > 
> > If you have any questions about this process, please let me know.
> > 
> > 
> > From d3c6dfb00bd9fe75f3a44246d6db7991f6443bac Mon Sep 17 00:00:00 2001
> > From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> > Date: Sat, 28 Aug 2021 13:36:56 +0200
> > Subject: staging: r8188eu: Remove _enter/_exit_critical_mutex()
> > 
> > Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> > unnecessary wrappers, respectively to mutex_lock_interruptible() and
> > to mutex_unlock(). They also have an odd interface that takes an unused
> > argument named pirqL of type unsigned long.
> > The original code enters the critical section if the mutex API is
> > interrupted while waiting to acquire the lock; therefore it could lead
> > to a race condition. Use mutex_lock() because it is uninterruptible and
> > so avoid that above-mentioned potential race condition.
> 
> Dear Greg,
> 
> I've just read this message. Thank you for applying my patch. I really 
> appreciated that you trust the code :)
> 
> Unfortunately it makes me wonder if I should have added a "Fixes:" tag 
> because it (among other things) prevents a (possible while remote - I guess)
> bug. The code entered the critical section if the sleeping of the 
> interruptible mutex were interrupted by signals and so it could lead to race 
> conditions.
> 
> I have this doubt. Please let me know if I'd better redo the commit message 
> and add the above-mentioned tag.

Given the mess that is this driver right now, no, that's not needed at
all.  Only worry about that when you are fixing a real issue that should
be backported to older kernel releases.

thanks,

greg k-h
