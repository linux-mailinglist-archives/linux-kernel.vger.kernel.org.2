Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF03C603B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhGLQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:17:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50365 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230019AbhGLQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:17:34 -0400
Received: (qmail 321950 invoked by uid 1000); 12 Jul 2021 12:14:45 -0400
Date:   Mon, 12 Jul 2021 12:14:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Johan Hovold <johan@kernel.org>
Cc:     syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
Message-ID: <20210712161445.GA321728@rowland.harvard.edu>
References: <20210711155345.GB293743@rowland.harvard.edu>
 <00000000000068b24405c6db3249@google.com>
 <20210712140004.GA316776@rowland.harvard.edu>
 <YOxf0OvoGOvWf14m@hovoldconsulting.com>
 <YOxk0URZrLYv8SNU@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOxk0URZrLYv8SNU@hovoldconsulting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 05:50:41PM +0200, Johan Hovold wrote:
> On Mon, Jul 12, 2021 at 05:29:20PM +0200, Johan Hovold wrote:
> > On Mon, Jul 12, 2021 at 10:00:04AM -0400, Alan Stern wrote:
> > > On Sun, Jul 11, 2021 at 09:07:09AM -0700, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > WARNING in do_proc_control/usb_submit_urb
> 
> > > I don't get this.  It shouldn't be possible.  The fact that the 
> > > direction bit is set in both bRequestType and pipe means that the URB 
> > > was submitted as a control-IN but had length 0.  But the patch addresses 
> > > exactly that case:
> > > 
> > > --- usb-devel.orig/drivers/usb/core/devio.c
> > > +++ usb-devel/drivers/usb/core/devio.c
> > > @@ -1133,7 +1133,7 @@ static int do_proc_control(struct usb_de
> > >  		"wIndex=%04x wLength=%04x\n",
> > >  		ctrl->bRequestType, ctrl->bRequest, ctrl->wValue,
> > >  		ctrl->wIndex, ctrl->wLength);
> > > -	if (ctrl->bRequestType & 0x80) {
> > > +	if ((ctrl->bRequestType & USB_DIR_IN) && ctrl->wLength) {
> > >  		pipe = usb_rcvctrlpipe(dev, 0);
> > >  		snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT, NULL, 0);
> > >  
> > > and causes the kernel to handle it as a control-OUT instead.
> > > 
> > > Johan, any ideas?
> > 
> > Did syzbot actually test the patch? I can't see how the direction bit of
> > the pipe argument can be set with the above applied either.
> 
> It looks like the second patch you submitted was hand-edited and still
> quoted.
> 
> And looking at the dashboard it seems like no patch was applied for your
> second test attempt:
> 
> 	https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b

Yes, that explains it.  Funny how easy it is to miss those "> " 
markings -- you just get too used to them.

> I've been bitten by something like this before when erroneously thinking
> that a test command could be submitted as a reply to a patch.
> 
> Perhaps the report mail could include the patch tested or something so
> we don't spend time investigating syzbot interface failures.

Good idea.

Anyway, here's the patch again, this time properly formatted.  Hopefully 
now it will work.

Alan Stern


#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git ee268dee

Index: usb-devel/drivers/usb/core/devio.c
===================================================================
--- usb-devel.orig/drivers/usb/core/devio.c
+++ usb-devel/drivers/usb/core/devio.c
@@ -1133,7 +1133,7 @@ static int do_proc_control(struct usb_de
 		"wIndex=%04x wLength=%04x\n",
 		ctrl->bRequestType, ctrl->bRequest, ctrl->wValue,
 		ctrl->wIndex, ctrl->wLength);
-	if (ctrl->bRequestType & 0x80) {
+	if ((ctrl->bRequestType & USB_DIR_IN) && ctrl->wLength) {
 		pipe = usb_rcvctrlpipe(dev, 0);
 		snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT, NULL, 0);
 
