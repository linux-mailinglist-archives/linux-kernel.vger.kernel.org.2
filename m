Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDD343F65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCVLO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhCVLNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:13:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 492ED6198E;
        Mon, 22 Mar 2021 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616411633;
        bh=MmdQR1dEmdHbDyukqcT2pW9HWuOlB5PSPi63m85UTG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdctlYaSx5YrEOLbgTdnTP7pyB7NgwhspReH6FZgRGKJsTkvZaZmHiQWMGKBVudVp
         2RiZUe63WCT1HzUQqu7VwWeHRZp/4HdSc8L0gvEtmOMmsWUc8sUrKefnhkSv7Lx94q
         Azbvsa2lt/X6zrqSbXGzsn9d/ZO7VdxO1dqmcNis=
Date:   Mon, 22 Mar 2021 12:13:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     devel@driverdev.osuosl.org, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v4 2/2] staging: Add driver for XillyUSB (Xillybus
 variant for USB)
Message-ID: <YFh77/L3o4MbuQxi@kroah.com>
References: <20210311095033.20956-1-eli.billauer@gmail.com>
 <20210311095033.20956-3-eli.billauer@gmail.com>
 <YFc6z9REEo27FMA+@kroah.com>
 <60587922.2040903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60587922.2040903@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:01:54PM +0200, Eli Billauer wrote:
> Hello, Greg.
> 
> Thanks for your comments. I'd like to address a couple of them.
> 
> First, there's the lockless FIFO that is implemented in the driver:
> 
> On 21/03/21 14:23, Greg KH wrote:
> > 
> > > +
> > > +static unsigned int fifo_read(struct xillyfifo *fifo,
> > > +			      void *data, unsigned int len,
> > > +			      int (*copier)(void *, const void *, int))
> > > +{
> > > +	unsigned int done = 0;
> > > +	unsigned int todo = len;
> > > +	unsigned int fill;
> > > +	unsigned int readpos = fifo->readpos;
> > > +	unsigned int readbuf = fifo->readbuf;
> > > +
> > > +	fill = atomic_read(&fifo->fill);
> > And the number changed right after reading it :(
> > 
> > Again, no atomics, use a lock please.
> > 
> > This is a USB device, you are NOT doing high-speed data transfers at
> > all.
> > 
> The current XillyUSB hardware is USB 3.0 based, running at ~400 MB/s, and
> this is just the beginning. For comparison, when the PCIe-based Xillybus
> started at 200 MB/s, I didn't believe it would reach 6.6 GB/s.
> 
> So that's why I made the effort to implement a lockless FIFO, with all the
> extra synchronization fuss. And yes, it works perfectly, and has been
> heavily fuzz tested on an x86_64 machine. The memory barriers are carefully
> placed to make this work on less favorable platforms as well, but even if I
> got it wrong -- odds are that the fix will be a line or two.
> 
> Replacing atomics with spinlocks is a piece of cake, of course. But given
> this extra information, do you still think it's a good idea?

Trying to review this code is hard, if not impossible because of the
structure.  Again, USB interfaces are slow, a "custom lockless FIFO" is
something for the core kernel to implement, not for a random individual
driver, to ensure it is working properly.

And it seems like an overkill, are you sure those locks are a slowdown?

thanks,

greg k-h
