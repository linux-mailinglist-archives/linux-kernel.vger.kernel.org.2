Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433F03B4F1A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFZPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 11:05:31 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37607 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229871AbhFZPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 11:05:28 -0400
Received: (qmail 602741 invoked by uid 1000); 26 Jun 2021 11:03:04 -0400
Date:   Sat, 26 Jun 2021 11:03:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     linyyuan@codeaurora.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: fix race of usb_gadget_driver operation
Message-ID: <20210626150304.GA601624@rowland.harvard.edu>
References: <20210625104415.8072-1-linyyuan@codeaurora.org>
 <20210625163707.GC574023@rowland.harvard.edu>
 <b24825113327c72c742d55e89ec2726e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24825113327c72c742d55e89ec2726e@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 09:16:25AM +0800, linyyuan@codeaurora.org wrote:
> On 2021-06-26 00:37, Alan Stern wrote:
> > On Fri, Jun 25, 2021 at 06:44:15PM +0800, Linyu Yuan wrote:

> > > --- a/drivers/usb/dwc3/ep0.c
> > > +++ b/drivers/usb/dwc3/ep0.c
> > > @@ -597,10 +597,11 @@ static int dwc3_ep0_set_address(struct dwc3
> > > *dwc, struct usb_ctrlrequest *ctrl)
> > > 
> > >  static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct
> > > usb_ctrlrequest *ctrl)
> > >  {
> > > -	int ret;
> > > +	int ret = 0;
> > > 
> > >  	spin_unlock(&dwc->lock);
> > > -	ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
> > > +	if (dwc->async_callbacks)
> > > +		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
> > >  	spin_lock(&dwc->lock);
> > 
> > Here and in the other places, you should test dwc->async_callbacks
> > _before_ dropping the spinlock.  Otherwise there is a race (the flag
> > could be written at about the same time it is checked).
> thanks for your comments,
> 
> if you think there is race here, how to make sure gadget_driver pointer is
> safe,
> this is closest place where we can confirm it is non-NULL by checking
> async_callbacks ?

I explained this twice already: We know that gadget_driver is not 
NULL because usb_gadget_remove_driver calls synchronize_irq before 
doing usb_gadget_udc_stop.

Look at this timing diagram:

	CPU0				CPU1
	----				----
	IRQ happens for setup packet
	  Handler sees async_callbacks
	    is enabled
	  Handler unlocks dwc->lock
					usb_gadget_remove_driver runs
					  Disables async callbacks
					  Calls synchronize_irq
	  Handler calls dwc->		  . waits for IRQ handler to 
	    gadget_driver->setup	  .   return
	  Handler locks dwc-lock	  .
	  ...				  .
	  Handler returns		  .
					  . synchronize_irq returns
					  Calls usb_gadget_udc_stop
					    dwc->gadget_driver is
					      set to NULL

As you can see, dwc->gadget_driver is non-NULL when CPU0 uses it, 
even though async_callbacks gets cleared during the time when the 
lock is released.

Alan Stern
