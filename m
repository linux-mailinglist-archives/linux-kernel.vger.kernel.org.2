Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC275373E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhEEPUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 11:20:16 -0400
Received: from netrider.rowland.org ([192.131.102.5]:32835 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232596AbhEEPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 11:20:13 -0400
Received: (qmail 698740 invoked by uid 1000); 5 May 2021 11:19:15 -0400
Date:   Wed, 5 May 2021 11:19:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
Message-ID: <20210505151915.GA696631@rowland.harvard.edu>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <8735v1ibj4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735v1ibj4.fsf@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 03:57:03PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Wesley Cheng <wcheng@codeaurora.org> writes:
> > On 5/3/2021 7:20 PM, Thinh Nguyen wrote:
> >> Hi,
> >> 
> >> Wesley Cheng wrote:
> >>> If an error is received when issuing a start or update transfer
> >>> command, the error handler will stop all active requests (including
> >>> the current USB request), and call dwc3_gadget_giveback() to notify
> >>> function drivers of the requests which have been stopped.  Avoid
> >>> having to cancel the current request which is trying to be queued, as
> >>> the function driver will handle the EP queue error accordingly.
> >>> Simply unmap the request as it was done before, and allow previously
> >>> started transfers to be cleaned up.
> >>>
> >
> > Hi Thinh,
> >
> >> 
> >> It looks like you're still letting dwc3 stopping and cancelling all the
> >> active requests instead letting the function driver doing the dequeue.
> >> 
> >
> > Yeah, main issue isn't due to the function driver doing dequeue, but
> > having cleanup (ie USB request free) if there is an error during
> > usb_ep_queue().
> >
> > The function driver in question at the moment is the f_fs driver in AIO
> > mode.  When async IO is enabled in the FFS driver, every time it queues
> > a packet, it will allocate a io_data struct beforehand.  If the
> > usb_ep_queue() fails it will free this io_data memory.  Problem is that,
> > since the DWC3 gadget calls the completion with -ECONNRESET, the FFS
> > driver will also schedule a work item (within io_data struct) to handle
> > the completion.  So you end up with a flow like below
> >
> > allocate io_data (ffs)
> >  --> usb_ep_queue()
> >    --> __dwc3_gadget_kick_transfer()
> >    --> dwc3_send_gadget_ep_cmd(EINVAL)
> >    --> dwc3_gadget_ep_cleanup_cancelled_requests()
> >    --> dwc3_gadget_giveback(ECONNRESET)
> > ffs completion callback
> > queue work item within io_data
> >  --> usb_ep_queue returns EINVAL
> > ffs frees io_data
> > ...
> >
> > work scheduled
> >  --> NULL pointer/memory fault as io_data is freed

Am I reading this correctly?  It looks like usb_ep_queue() returns a 
-EINVAL error, but then the completion callback gets invoked with a 
status of -ECONNRESET.

> I have some vague memory of discussing (something like) this with Alan
> Stern long ago and the conclusion was that the gadget driver should
> handle cases such as this. 

Indeed, this predates the creation of the Gadget API; the same design 
principle applies to the host-side API.  It's a very simple idea:

	If an URB or usb_request submission succeeds, it is guaranteed
	that the completion routine will be called when the transfer is
	finished, cancelled, aborted, or whatever (note that this may 
	happen before the submission call returns).

	If an URB or usb_request submission fails, it is guaranteed that
	the completion routine will not be called.

So if dwc3 behaves as described above (usb_ep_queue() fails _and_ the 
completion handler is called), this is a bug.

Alan Stern

> OTOH, we're returning failure during
> usb_ep_queue() which tells me there's something with dwc3 (perhaps not
> exclusively, but that's yet to be shown).
> 
> If I understood the whole thing correctly, we want everything except the
> current request (the one that failed START or UPDATE transfer) to go
> through giveback(). This really tells me that we're not handling error
> case in kick_transfer and/or prepare_trbs() correctly.
> 
> I also don't want to pass another argument to kick_transfer because it
> should be unnecessary: the current request should *always* be the last
> one in the list. Therefore we should rely on something like
> list_last_entry() followed by list_for_each_entry_safe_reverse() to
> handle this without a special case.
> 
> ret = dwc3_send_gadget_ep_cmd();
> if (ret < 0) {
> 	current = list_last_entry();
> 
> 	unmap(current);
>         for_each_trb_in(current) {
>         	clear_HWO(trb);
>         }
> 
> 	list_for_entry_safe_reverse() {
>         	move_cancelled();
>         }
> }
> 
> -- 
> balbi


