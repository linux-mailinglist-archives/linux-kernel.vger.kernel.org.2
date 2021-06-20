Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8494D3ADEED
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhFTNt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 09:49:58 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58685 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229600AbhFTNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 09:49:56 -0400
Received: (qmail 377833 invoked by uid 1000); 20 Jun 2021 09:47:43 -0400
Date:   Sun, 20 Jun 2021 09:47:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     linyyuan@codeaurora.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH v3 1/2] usb: udc: core: hide struct usb_gadget_driver to
 gadget driver
Message-ID: <20210620134743.GA377492@rowland.harvard.edu>
References: <20210619154309.52127-1-linyyuan@codeaurora.org>
 <20210619154309.52127-2-linyyuan@codeaurora.org>
 <20210620021337.GA361976@rowland.harvard.edu>
 <42b3ebc2316495328e2d0061af81ef17@codeaurora.org>
 <018a4e222c2c3d6f5ca63b5f2036f8d8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018a4e222c2c3d6f5ca63b5f2036f8d8@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 11:53:18AM +0800, linyyuan@codeaurora.org wrote:
> On 2021-06-20 11:46, linyyuan@codeaurora.org wrote:
> > On 2021-06-20 10:13, Alan Stern wrote:
> > > On Sat, Jun 19, 2021 at 11:43:08PM +0800, Linyu Yuan wrote:
> > > > currently most gadget driver have a pointer to save
> > > > struct usb_gadget_driver from upper layer,
> > > > it allow upper layer set and unset of the pointer.
> > > > 
> > > > there is race that upper layer unset the pointer first,
> > > > but gadget driver use the pointer later,
> > > > and it cause system crash due to NULL pointer access.
> > > 
> > > This race has already been fixed in Greg's usb-next branch.  See
> > > commit
> > > 7dc0c55e9f30 ("USB: UDC core: Add udc_async_callbacks gadget op") and
> > > following commits 04145a03db9d ("USB: UDC: Implement
> > > udc_async_callbacks in dummy-hcd") and b42e8090ba93 ("USB: UDC:
> > > Implement udc_async_callbacks in net2280").
> > > 
> > thanks, this is better, lower driver only need change several places.
> > > You just need to write a corresponding patch implementing the
> > > async_callbacks op for dwc3.
> > yes, i will do.
> > > 
> Alan, i want to discuss your suggestion again in b42e8090ba93 ("USB: UDC:
> Implement udc_async_callbacks in net2280")
> 
> +                       if (dev->async_callbacks) { ----> if CPU1 saw this
> is true
> +                               spin_unlock(&dev->lock); ---> CPU2 get lock
> after this unlock,
> it will set async_callbacks to false, then follow call also crash, right ?
> +                               tmp = dev->driver->setup(&dev->gadget,
> &u.r);
> +                               spin_lock(&dev->lock);
> +                       }

No, this is okay.  The reason is because usb_gadget_remove_driver (CPU2 
in your example) does this:

        usb_gadget_disable_async_callbacks(udc);
        if (udc->gadget->irq)
                synchronize_irq(udc->gadget->irq);
        udc->driver->unbind(udc->gadget);
        usb_gadget_udc_stop(udc);

The synchronize_irq call will make CPU2 wait until CPU1 has finished 
handling the interrupt for the setup packet.  The system won't crash, 
because dev->driver->setup will be called before unbind and udc_stop 
instead of after.

Alan Stern
