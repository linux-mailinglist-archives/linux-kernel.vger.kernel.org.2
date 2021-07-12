Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B193C5FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhGLPxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhGLPxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:53:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B00C161221;
        Mon, 12 Jul 2021 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626105059;
        bh=+MjO3ta1BlU+l5guVK+FcHDHKXPCfDZf6w7qgKWHlN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NOqJEvhuKnKR9xDtq/J42efDjVAL9ny5OPgUSG55plRtFrF/Vbs89dtgGe0s/OFUg
         oeS+8BfqxrIGmnBPajMlaM2zVvp0ON0GkNmODE9KlMcXm74GXLyk/iRHSEuwxZZjD6
         Bq+5o1ns6CbD9VPGOVm1/6HGr8NwvKxUhIPU2HXegLs/EdOqcrLakDK1VQ4JqGVosh
         y+Nxa2QqF5Q22SxJfVzTMyFePHs/CIPxKpIoq2/rWlcki2ZUvAU6mX64tWklPt8bt0
         FM68o+urF/I5u4Qg5fIV4qjjSUSQVFNO0NAf/U32yuHGSy7zE1RCImcsV4BPzPtOKP
         pI4aIlf5ot+PA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m2yCf-0007Um-62; Mon, 12 Jul 2021 17:50:41 +0200
Date:   Mon, 12 Jul 2021 17:50:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
Message-ID: <YOxk0URZrLYv8SNU@hovoldconsulting.com>
References: <20210711155345.GB293743@rowland.harvard.edu>
 <00000000000068b24405c6db3249@google.com>
 <20210712140004.GA316776@rowland.harvard.edu>
 <YOxf0OvoGOvWf14m@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOxf0OvoGOvWf14m@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 05:29:20PM +0200, Johan Hovold wrote:
> On Mon, Jul 12, 2021 at 10:00:04AM -0400, Alan Stern wrote:
> > On Sun, Jul 11, 2021 at 09:07:09AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > WARNING in do_proc_control/usb_submit_urb

> > I don't get this.  It shouldn't be possible.  The fact that the 
> > direction bit is set in both bRequestType and pipe means that the URB 
> > was submitted as a control-IN but had length 0.  But the patch addresses 
> > exactly that case:
> > 
> > --- usb-devel.orig/drivers/usb/core/devio.c
> > +++ usb-devel/drivers/usb/core/devio.c
> > @@ -1133,7 +1133,7 @@ static int do_proc_control(struct usb_de
> >  		"wIndex=%04x wLength=%04x\n",
> >  		ctrl->bRequestType, ctrl->bRequest, ctrl->wValue,
> >  		ctrl->wIndex, ctrl->wLength);
> > -	if (ctrl->bRequestType & 0x80) {
> > +	if ((ctrl->bRequestType & USB_DIR_IN) && ctrl->wLength) {
> >  		pipe = usb_rcvctrlpipe(dev, 0);
> >  		snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT, NULL, 0);
> >  
> > and causes the kernel to handle it as a control-OUT instead.
> > 
> > Johan, any ideas?
> 
> Did syzbot actually test the patch? I can't see how the direction bit of
> the pipe argument can be set with the above applied either.

It looks like the second patch you submitted was hand-edited and still
quoted.

And looking at the dashboard it seems like no patch was applied for your
second test attempt:

	https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b

I've been bitten by something like this before when erroneously thinking
that a test command could be submitted as a reply to a patch.

Perhaps the report mail could include the patch tested or something so
we don't spend time investigating syzbot interface failures.

Johan
