Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6447E360430
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhDOIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhDOIWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:22:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94372611AC;
        Thu, 15 Apr 2021 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618474917;
        bh=MzgBwo6AvTH3Xni+y03+CAO5/Yr7OdgG7HKKkkwlV5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLBtLksNikM5Oy26xFOqMe0HES0hX/EkAWnX2quUoqQn8cobXY1ABlJwAOH2+rC7c
         3eWHg4n6J4qfoWP5KWrgEGdEnPSAla2IIleDywNSdSpXtS/Q0pGQap5MyYOhMn6oce
         QtvPYLoP0X9jOGUPhiRlwOkx1ccQKHL1FM8qfmP8=
Date:   Thu, 15 Apr 2021 10:21:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 00/13] tty.h cleanups
Message-ID: <YHf3ojj44ex2dd3M@kroah.com>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
 <YG8SUl+B8+76JZwV@hovoldconsulting.com>
 <YG9E5GpLljkXARDj@kroah.com>
 <YHADHYKMhfYE1aNw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHADHYKMhfYE1aNw@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 09:32:45AM +0200, Johan Hovold wrote:
> On Thu, Apr 08, 2021 at 08:01:08PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 08, 2021 at 04:25:22PM +0200, Johan Hovold wrote:
> > > On Thu, Apr 08, 2021 at 02:51:21PM +0200, Greg Kroah-Hartman wrote:
> > > > Turns out there is a lot of tty-internal stuff in include/linux/tty.h
> > > > that do not belong there.  Create a internal-to-the-tty-layer .h file
> > > > for these types of things and move function prototypes to it instead of
> > > > being in the system-wide header file.
> > > > 
> > > > Along the way clean up the use of some old tty-only debugging macros and
> > > > use the in-kernel dev_*() calls instead.
> > > 
> > > I'm afraid that's not a good idea since not all ttys have a
> > > corresponding class device. Notable exception include pseudo terminals
> > > and serdev.
> > > 
> > > While dev_printk() can handle a NULL device argument without crashing,
> > > we'll actually lose log information by removing the tty printk helpers.
> > 
> > I think the same info will be printed here as before, just some NULL
> > information at the beginning, right?  And the benifits overall (for real
> > tty devices), should outweigh the few devices that do not have this
> > information.
> 
> No, you'll only be losing information (tty driver and tty name). Here's
> a pty example, where the first line in each pair use dev_info() and the
> second tty_info():
> 
> [   10.235331] (NULL device *): tty_get_device
> [   10.235441] ptm ptm0: tty_get_device
> 
> [   10.235586] (NULL device *): tty_get_device
> [   10.235674] pts pts0: tty_get_device
> 
> and similar for serdev, which is becoming more and more common.

Ok, good point, I'll go apply only the first 2 patches in this series
(moving the macros out of tty.h and removing the unused one) and then
will redo this set of patches again.   I think a better tty_msg() macro
is warrented so that we can provide dev_*() output if we have a device,
otherwise fall back to the old style to preserve functionality.

thanks,

greg k-h
