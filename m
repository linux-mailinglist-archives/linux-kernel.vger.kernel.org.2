Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC71D360E79
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhDOPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235475AbhDOPFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:05:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A60F7613B0;
        Thu, 15 Apr 2021 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618499030;
        bh=dXnmeqHEJKNmTkFsNw2zlTfrOvZF8N2q6pwjSmvheCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osl2YtcgAOFqbTYB6tqu6NuqdNSBtOQ35np6Q1mqoB7zW4S1ajWyksRuCcrgOiRL2
         tMoFRKyuE/tqSJPUeC6bD8dXvX8Ijfx5z7IVpR62ufbkpBVaslsKKuG0jeWZN9rwJH
         /mkzr6MP6X1JdeAT1a481cHFfH9YRd84YEqB98lg=
Date:   Thu, 15 Apr 2021 16:53:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 00/13] tty.h cleanups
Message-ID: <YHhTfL6eIJzCOt7W@kroah.com>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
 <YG8SUl+B8+76JZwV@hovoldconsulting.com>
 <YG9E5GpLljkXARDj@kroah.com>
 <YHADHYKMhfYE1aNw@hovoldconsulting.com>
 <YHf3ojj44ex2dd3M@kroah.com>
 <YHhKSdVpo9mo0sCn@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHhKSdVpo9mo0sCn@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 04:14:33PM +0200, Johan Hovold wrote:
> On Thu, Apr 15, 2021 at 10:21:54AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 09, 2021 at 09:32:45AM +0200, Johan Hovold wrote:
> > > On Thu, Apr 08, 2021 at 08:01:08PM +0200, Greg Kroah-Hartman wrote:
> > > > On Thu, Apr 08, 2021 at 04:25:22PM +0200, Johan Hovold wrote:
> > > > > On Thu, Apr 08, 2021 at 02:51:21PM +0200, Greg Kroah-Hartman wrote:
> > > > > > Turns out there is a lot of tty-internal stuff in include/linux/tty.h
> > > > > > that do not belong there.  Create a internal-to-the-tty-layer .h file
> > > > > > for these types of things and move function prototypes to it instead of
> > > > > > being in the system-wide header file.
> > > > > > 
> > > > > > Along the way clean up the use of some old tty-only debugging macros and
> > > > > > use the in-kernel dev_*() calls instead.
> > > > > 
> > > > > I'm afraid that's not a good idea since not all ttys have a
> > > > > corresponding class device. Notable exception include pseudo terminals
> > > > > and serdev.
> > > > > 
> > > > > While dev_printk() can handle a NULL device argument without crashing,
> > > > > we'll actually lose log information by removing the tty printk helpers.
> > > > 
> > > > I think the same info will be printed here as before, just some NULL
> > > > information at the beginning, right?  And the benifits overall (for real
> > > > tty devices), should outweigh the few devices that do not have this
> > > > information.
> > > 
> > > No, you'll only be losing information (tty driver and tty name). Here's
> > > a pty example, where the first line in each pair use dev_info() and the
> > > second tty_info():
> > > 
> > > [   10.235331] (NULL device *): tty_get_device
> > > [   10.235441] ptm ptm0: tty_get_device
> > > 
> > > [   10.235586] (NULL device *): tty_get_device
> > > [   10.235674] pts pts0: tty_get_device
> > > 
> > > and similar for serdev, which is becoming more and more common.
> > 
> > Ok, good point, I'll go apply only the first 2 patches in this series
> > (moving the macros out of tty.h and removing the unused one) and then
> > will redo this set of patches again.
> 
> Perhaps no harm in leaving the tty_info() on in there for consistency.
> We have users of the _ratelimited() flavour of it (even if there's no
> dependency).

I dropped it, no need to keep around unused macros :)

> > I think a better tty_msg() macro is warrented so that we can provide
> > dev_*() output if we have a device, otherwise fall back to the old
> > style to preserve functionality.
> 
> Possibly, but the dev_printk() for the tty class devices wouldn't
> provide any more info than what's already there (i.e. driver name + tty
> name).
> 
> (And associating ttys with other devices and drivers (e.g. a serdev
> client and its driver) might not be what we want since you lose the
> connection to the underlying tty driver.)

Yeah, I messed with this for a bit today and I think I'm just going to
give up and leave it as-is for now...

thanks,

greg k-h
