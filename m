Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8E3B5FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhF1OMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:12:55 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53219 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230033AbhF1OMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:12:54 -0400
Received: (qmail 657388 invoked by uid 1000); 28 Jun 2021 10:10:27 -0400
Date:   Mon, 28 Jun 2021 10:10:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     linyyuan@codeaurora.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: fix race of usb_gadget_driver operation
Message-ID: <20210628141027.GA656159@rowland.harvard.edu>
References: <20210625104415.8072-1-linyyuan@codeaurora.org>
 <20210625163707.GC574023@rowland.harvard.edu>
 <b24825113327c72c742d55e89ec2726e@codeaurora.org>
 <20210626150304.GA601624@rowland.harvard.edu>
 <1d1f06763c7cdeb67264128537c6a8f4@codeaurora.org>
 <20210627140903.GB624763@rowland.harvard.edu>
 <ca669cb24f424e1c28adfa3a84d7bad2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca669cb24f424e1c28adfa3a84d7bad2@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 05:36:22PM +0800, linyyuan@codeaurora.org wrote:
> On 2021-06-27 22:09, Alan Stern wrote:
> > 
> > 	CPU0				CPU1
> > 	----				----
> > 					usb_gadget_remove_driver runs
> > 					  Calls synchronize_irq
> > 					    synchronize_irq returns
> > 					  Calls udc_driver_unbind
> > 	IRQ happens for disconnect
> > 	  Handler unlocks dwc->lock
> > 	  Calls dwc->gadget_driver->disconnect
> > 	    Gadget driver has already been unbound
> > 	      and is not prepared to handle a
> > 	      callback, so it crashes
> > 					  Calls usb_gadget_udc_stop
> > 					    dwc->gadget_driver is
> > 					      set to NULL
> > 
> > Without the async_callbacks mechanism, the gadget driver can get a
> > callback at the wrong time (after it has been unbound), which might
> > cause it to crash.
> 1. do you think we need to back to my original patch,
> https://lore.kernel.org/linux-usb/20210619154309.52127-1-linyyuan@codeaurora.org/T/#t

No, I think the async_callbacks approach is slightly better.

> i think we can add the spin lock or mutex lock to protect this kind of race
> from UDC layer, it will be easy understanding.

We don't actually need a lock or mutex to fix this problem.  We just 
need to make the remove_driver sequence issue two calls to the UDC 
driver rather than just one: async_callbacks and udc_stop.

> 2. if you insist this kind of change, how to change following code in dwc3 ?
> if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
> 
> 2.1 if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
> or
> 2.2 if (dwc->async_callbacks && vdwc->gadget_driver &&
> dwc->gadget_driver->disconnect) {

Either one would be okay.  If async_callbacks is enabled then 
dwc->gadget_driver should never be NULL, but it won't hurt to check.  
After all, disconnect does not occur often and it doesn't need to run 
extremely quickly.

Alan Stern
