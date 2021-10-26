Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D177343BBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhJZU72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:59:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50731 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231396AbhJZU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:59:27 -0400
Received: (qmail 1300783 invoked by uid 1000); 26 Oct 2021 16:57:01 -0400
Date:   Tue, 26 Oct 2021 16:57:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Disable eps during
 disconnect
Message-ID: <20211026205701.GA1300692@rowland.harvard.edu>
References: <20211026004456.23054-1-quic_wcheng@quicinc.com>
 <20211026144140.GA1288435@rowland.harvard.edu>
 <81fc3f6d-f747-736b-32db-aecbca77dd31@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81fc3f6d-f747-736b-32db-aecbca77dd31@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 12:40:04PM -0700, Wesley Cheng wrote:
> Hi Alan,
> 
> On 10/26/2021 7:41 AM, Alan Stern wrote:
> > On Mon, Oct 25, 2021 at 05:44:56PM -0700, Wesley Cheng wrote:
> >> From: Wesley Cheng <wcheng@codeaurora.org>
> >>
> >> When receiving a disconnect event from the UDC, the mass storage
> >> function driver currently runs the handle_exception() routine
> >> asynchronously.  For UDCs that support runtime PM, there is a
> >> possibility the UDC is already suspended by the time the
> >> do_set_interface() is executed.  This can lead to HW register access
> >> while the UDC is already suspended.
> >>
> >> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> >> ---
> >>  drivers/usb/gadget/function/f_mass_storage.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> >> index 3cabf7692ee1..752439690fda 100644
> >> --- a/drivers/usb/gadget/function/f_mass_storage.c
> >> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> >> @@ -2342,6 +2342,16 @@ static void fsg_disable(struct usb_function *f)
> >>  {
> >>  	struct fsg_dev *fsg = fsg_from_func(f);
> >>  
> >> +	/* Disable the endpoints */
> >> +	if (fsg->bulk_in_enabled) {
> >> +		usb_ep_disable(fsg->bulk_in);
> > 
> > According to the kerneldoc, this routine must be called in process 
> > context.
> > 
> >> +		fsg->bulk_in_enabled = 0;
> >> +	}
> >> +	if (fsg->bulk_out_enabled) {
> >> +		usb_ep_disable(fsg->bulk_out);
> >> +		fsg->bulk_out_enabled = 0;
> >> +	}
> >> +
> >>  	__raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE, NULL);
> >>  }
> > 
> > Looks like you'll have to find a different way to avoid the problem.  
> > For example, if an exception is pending then you might prevent the 
> > gadget from going into runtime suspend until the exception has been 
> > handled.
> > 
> Thanks for the suggestion.  I noticed that a lot of other FDs currently
> call usb_ep_disable() in the disable/disconnect path as well.  Actually,
> f_mass_storage seems to be the only one that doesn't do so.  Maybe we
> should change the kerneldoc :)

You're right; I don't see any real reason why the usb_ep_{en,dis}able 
routines can't run in an atomic context.  So if you to make this change 
to f_mass_storage, you should first submit a patch changing the 
kerneldoc.

Alan Stern
