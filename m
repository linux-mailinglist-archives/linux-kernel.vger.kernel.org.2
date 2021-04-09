Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955D935966E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhDIHdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhDIHdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:33:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03AAC61107;
        Fri,  9 Apr 2021 07:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617953570;
        bh=GvVTq5brV34CvZ6GSWYRQLHzYPaMescflxgpD8SKrVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeYiuupHNuq5FcoR00Dq9Y+lOR/ELIVOIGwNuZddaiEvaiD+m4sD08Swc3VxpOR8u
         +Gb3BQsS36xnUbLR6kBSztHsOWzO7cvh8VdklSSy9S6vhTj83Pr+y1ELsfAKOcYIp6
         Spanzz9aM5TOriPDBoTnr4QMG0MjFIhKClQq+TKMH4oup7BGVWcbKlwkle83La0JN5
         IzwrVUSWIxCXVRi2dnSB5XZh9c0HcmspTM7Y9N6NWGwNiam26WKc56EWnlSnmiwtoA
         Vic6kxC2MsmvxCKPPJoc04o2GqUn3eNIio0ENuUPuSXKGm/FvF9K4G0CKGKuRbF/bX
         WQTipzx6VQsZQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUldF-0001lw-Gx; Fri, 09 Apr 2021 09:32:45 +0200
Date:   Fri, 9 Apr 2021 09:32:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 00/13] tty.h cleanups
Message-ID: <YHADHYKMhfYE1aNw@hovoldconsulting.com>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
 <YG8SUl+B8+76JZwV@hovoldconsulting.com>
 <YG9E5GpLljkXARDj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG9E5GpLljkXARDj@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:01:08PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 08, 2021 at 04:25:22PM +0200, Johan Hovold wrote:
> > On Thu, Apr 08, 2021 at 02:51:21PM +0200, Greg Kroah-Hartman wrote:
> > > Turns out there is a lot of tty-internal stuff in include/linux/tty.h
> > > that do not belong there.  Create a internal-to-the-tty-layer .h file
> > > for these types of things and move function prototypes to it instead of
> > > being in the system-wide header file.
> > > 
> > > Along the way clean up the use of some old tty-only debugging macros and
> > > use the in-kernel dev_*() calls instead.
> > 
> > I'm afraid that's not a good idea since not all ttys have a
> > corresponding class device. Notable exception include pseudo terminals
> > and serdev.
> > 
> > While dev_printk() can handle a NULL device argument without crashing,
> > we'll actually lose log information by removing the tty printk helpers.
> 
> I think the same info will be printed here as before, just some NULL
> information at the beginning, right?  And the benifits overall (for real
> tty devices), should outweigh the few devices that do not have this
> information.

No, you'll only be losing information (tty driver and tty name). Here's
a pty example, where the first line in each pair use dev_info() and the
second tty_info():

[   10.235331] (NULL device *): tty_get_device
[   10.235441] ptm ptm0: tty_get_device

[   10.235586] (NULL device *): tty_get_device
[   10.235674] pts pts0: tty_get_device

and similar for serdev, which is becoming more and more common.

Johan
