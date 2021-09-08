Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C3403831
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346277AbhIHKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhIHKt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:49:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 006EE61163;
        Wed,  8 Sep 2021 10:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631098130;
        bh=dViuyiiozoC/WhPhQRNwqN73Ka18ZJIJwF6nPiWVHhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGXUNojfFA2QNJUYlBNAh39aqQDSOUjraHQL0wZfcAn+U8LmU4AdYKz1wnwvaJe/R
         MHfz2cBL1Iiju/gd/NI9jJ6tVFDVMjeK2MEI9GQmz973DeAbnXUHled6l/QtXjkbW8
         Fp5TwTh2yc1Y0qQhfn+6zeJYfTB3X+AjBqhw+ByE=
Date:   Wed, 8 Sep 2021 12:48:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: usb: gadget: u_serial: check Null pointer in EP callback
Message-ID: <YTiVD/py5d6rvSgU@kroah.com>
References: <CGME20210806080835epcas2p2134b8b635e27d129a9e2f2f400a814fc@epcas2p2.samsung.com>
 <1628236406-185160-1-git-send-email-dh10.jung@samsung.com>
 <YQzu+Xy+3wAyXeDK@kroah.com>
 <000001d7a482$93438b20$b9caa160$@samsung.com>
 <20210908073235.GA13332@ubuntu>
 <20210908102129.GB13332@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908102129.GB13332@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 07:21:29PM +0900, Jung Daehwan wrote:
> On Fri, Aug 06, 2021 at 05:13:34PM +0200, Greg Kroah-Harman wrote:
> > On Fri, Aug 06, 2021 at 04:53:26PM +0900, Daehwan Jung wrote:
> > > From: taehyun cho <taehyun.cho@samsung.com>
> > > 
> > > Endpoint complete function in u_serial can be executed when 'gs_port' 
> > > is Null. This situation happens when 'dwc3_gadget_pullup' returns 
> > > ETIMEDOUT. The reason why ETIMEDOUT is returned is that whole system 
> > > is out of order including interrupt regardless of USB.
> > > 
> > > pc : __lock_acquire+0x54/0x5ec
> > > lr : lock_acquire+0xe8/0x198
> > > sp : ffffffc03914b9d0
> > > x29: ffffffc03914b9d0 x28: ffffff895f13b680
> > > x27: 0000000000000000 x26: 0000000000000000
> > > x25: 00000000000003c8 x24: 0000000000000080
> > > x23: ffffffc010a8f650 x22: 0000000000000000
> > > x21: 0000000000000000 x20: 0000000000000000
> > > x19: ffffffc010a8f650 x18: ffffffc02d70a0b0
> > > x17: 0000000000000000 x16: 00000000000229e0
> > > x15: 0000000000000004 x14: 00000000000004f2
> > > x13: ffffffc0120fe178 x12: 0000000000000003
> > > x11: 00000000ffffffff x10: 0000000100000001
> > > x9 : 0000000000000001 x8 : 00000000000003c8
> > > x7 : 0000000000000000 x6 : ffffffc010a8f650
> > > x5 : 0000000000000000 x4 : 0000000000000080
> > > x3 : 0000000000000000 x2 : 0000000000000000
> > > x1 : 0000000000000000 x0 : 00000000000003c8 Call trace:
> > >  __lock_acquire+0x54/0x5ec
> > >  lock_acquire+0xe8/0x198
> > >  _raw_spin_lock+0x70/0x88
> > >  gs_read_complete+0x48/0xac
> > >  usb_gadget_giveback_request+0x48/0x80
> > >  dwc3_gadget_giveback+0xcc/0xe8
> > >  dwc3_remove_requests+0xa8/0x188
> > >  __dwc3_gadget_ep_disable+0x98/0x110
> > >  dwc3_gadget_ep_disable+0x50/0xbc
> > >  usb_ep_disable+0x44/0x94
> > >  gserial_disconnect+0xc0/0x250
> > >  acm_free_func+0x30/0x48
> > >  usb_put_function+0x34/0x68
> > >  config_usb_cfg_unlink+0xdc/0xf8
> > >  configfs_unlink+0x144/0x264
> > >  vfs_unlink+0x134/0x218
> > >  do_unlinkat+0x13c/0x2a0
> > >  __arm64_sys_unlinkat+0x48/0x60
> > >  el0_svc_common.llvm.10277270529376503802+0xb8/0x1b4
> > >  do_el0_svc+0x24/0x8c
> > >  el0_svc+0x10/0x1c
> > >  el0_sync_handler+0x68/0xac
> > >  el0_sync+0x18c/0x1c0
> > > 
> > > Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
> > > ---
> > >  drivers/usb/gadget/function/u_serial.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/usb/gadget/function/u_serial.c 
> > > b/drivers/usb/gadget/function/u_serial.c
> > > index 6f68cbe..af08a18 100644
> > > --- a/drivers/usb/gadget/function/u_serial.c
> > > +++ b/drivers/usb/gadget/function/u_serial.c
> > > @@ -450,6 +450,15 @@ static void gs_read_complete(struct usb_ep *ep, 
> > > struct usb_request *req)  {
> > >  	struct gs_port	*port = ep->driver_data;
> > >  
> > > +	/*
> > > +	 * Port became NULL when 'dwc3_gadget_pullup' returns ETIMEDOUT.
> > > +	 * Return here to avoid panic.
> > > +	 */
> > > +	if (!port) {
> > > +		pr_err("%s, failed to get port\n", __func__);
> > > +		return;
> > > +	}
> > > +
> > 
> 	spin_lock(&port->port_lock);
> 	...
> 	spin_unlock(&port->port_lock);
> > What prevents port from being null right after checking this?  Where is the
> > lock to prevent this?
> >
> It tries to get lock first in gs_read_complete/gs_write_complete like above.
> That's why the panic occured during getting lock but this issue is not related
> to lock. We just want to prevent doing something after port becomes null.

I do not understand, you are not protecting anything here, what happens
if port becomes NULL right after checking it and before the lock?

Either this needs to be tested like this, or it does not at all.  This
change does not really fix the issue.


> > >  	/* Queue all received data until the tty layer is ready for it. */
> > >  	spin_lock(&port->port_lock);
> > >  	list_add_tail(&req->list, &port->read_queue); @@ -461,6 +470,15 @@ 
> > > static void gs_write_complete(struct usb_ep *ep, struct usb_request 
> > > *req)  {
> > >  	struct gs_port	*port = ep->driver_data;
> > >  
> > > +	/*
> > > +	 * port became NULL when 'dwc3_gadget_pullup' returns ETIMEDOUT.
> > > +	 * Return here to avoid panic.
> > > +	 */
> > > +	if (!port) {
> > > +		pr_err("%s, failed to get port\n", __func__);
> > > +		return;
> > > +	}
> > 
> > Same here, where is the lock?
> > 
> > And why report an error, what can a user do about it?
> > 
> 
> It could happen to access null pointer and occur whole system panic.

Again, what is setting that pointer to NULL and why isn't it caught
before this?  Shouldn't everything be properly torn down and the
completions finished _before_ the port is set to NULL?

If not, then fix that issue, as this change will not fix the real
problem here, only delay it.

thanks,

greg k-h
