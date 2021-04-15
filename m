Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16553360B98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhDOOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233324AbhDOOO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:14:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89B53611F1;
        Thu, 15 Apr 2021 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618496073;
        bh=yNptOTNB9XNO8218LdPcrvhxfXswOzhpZVCSbvOxAmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfgqJWsF5tn6cUwRDWluNMjgXy/U11l0WL8ddQrP7nWLp2Qajgwne6uMUVSgy5Qil
         RjGFs3iXZ+a+GmuJcNlyaQ9Kp4cP2UHwQkiA2Im5vOzZpW+nVaC88/tLn7eiME3FAT
         oLWFMQZ2Sk9+ZcsRUZiq9QbYkVYP89vomzLoYPPR5hFjyYmMqg1iN324KafucmZ0M8
         wtnO8aU2O5M6QIIMS4lTqwMTreWJKCmjBfkepBz3oxaQJ0Tyxz1q2G93MYx/GLrU2i
         ++VqlH+fuBb/Yxpsx+PMm1MH3/AgAo4jnt+VOh7TzKJdMr3aNycEWABMHJdova9cmU
         oCoW19/SmKidA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lX2lN-0000PF-Jy; Thu, 15 Apr 2021 16:14:33 +0200
Date:   Thu, 15 Apr 2021 16:14:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 00/13] tty.h cleanups
Message-ID: <YHhKSdVpo9mo0sCn@hovoldconsulting.com>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
 <YG8SUl+B8+76JZwV@hovoldconsulting.com>
 <YG9E5GpLljkXARDj@kroah.com>
 <YHADHYKMhfYE1aNw@hovoldconsulting.com>
 <YHf3ojj44ex2dd3M@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHf3ojj44ex2dd3M@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 10:21:54AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 09, 2021 at 09:32:45AM +0200, Johan Hovold wrote:
> > On Thu, Apr 08, 2021 at 08:01:08PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Apr 08, 2021 at 04:25:22PM +0200, Johan Hovold wrote:
> > > > On Thu, Apr 08, 2021 at 02:51:21PM +0200, Greg Kroah-Hartman wrote:
> > > > > Turns out there is a lot of tty-internal stuff in include/linux/tty.h
> > > > > that do not belong there.  Create a internal-to-the-tty-layer .h file
> > > > > for these types of things and move function prototypes to it instead of
> > > > > being in the system-wide header file.
> > > > > 
> > > > > Along the way clean up the use of some old tty-only debugging macros and
> > > > > use the in-kernel dev_*() calls instead.
> > > > 
> > > > I'm afraid that's not a good idea since not all ttys have a
> > > > corresponding class device. Notable exception include pseudo terminals
> > > > and serdev.
> > > > 
> > > > While dev_printk() can handle a NULL device argument without crashing,
> > > > we'll actually lose log information by removing the tty printk helpers.
> > > 
> > > I think the same info will be printed here as before, just some NULL
> > > information at the beginning, right?  And the benifits overall (for real
> > > tty devices), should outweigh the few devices that do not have this
> > > information.
> > 
> > No, you'll only be losing information (tty driver and tty name). Here's
> > a pty example, where the first line in each pair use dev_info() and the
> > second tty_info():
> > 
> > [   10.235331] (NULL device *): tty_get_device
> > [   10.235441] ptm ptm0: tty_get_device
> > 
> > [   10.235586] (NULL device *): tty_get_device
> > [   10.235674] pts pts0: tty_get_device
> > 
> > and similar for serdev, which is becoming more and more common.
> 
> Ok, good point, I'll go apply only the first 2 patches in this series
> (moving the macros out of tty.h and removing the unused one) and then
> will redo this set of patches again.

Perhaps no harm in leaving the tty_info() on in there for consistency.
We have users of the _ratelimited() flavour of it (even if there's no
dependency).

> I think a better tty_msg() macro is warrented so that we can provide
> dev_*() output if we have a device, otherwise fall back to the old
> style to preserve functionality.

Possibly, but the dev_printk() for the tty class devices wouldn't
provide any more info than what's already there (i.e. driver name + tty
name).

(And associating ttys with other devices and drivers (e.g. a serdev
client and its driver) might not be what we want since you lose the
connection to the underlying tty driver.)

Johan
