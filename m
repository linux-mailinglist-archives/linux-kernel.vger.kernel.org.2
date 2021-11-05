Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2D446431
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhKENgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:36:51 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52751 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229924AbhKENgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:36:50 -0400
Received: (qmail 1591263 invoked by uid 1000); 5 Nov 2021 09:34:10 -0400
Date:   Fri, 5 Nov 2021 09:34:10 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH 2/2] USB: ehci_brcm_hub_control: replace wIndex-1 with
 temp
Message-ID: <20211105133410.GB1590803@rowland.harvard.edu>
References: <20211105083357.29715-1-tcs_kernel@tencent.com>
 <YYTwveXGgNKXCfpk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYTwveXGgNKXCfpk@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 09:52:13AM +0100, Greg KH wrote:
> On Fri, Nov 05, 2021 at 04:33:57PM +0800, Haimin Zhang wrote:
> > In function `ehci_brcm_hub_control`, like following code,  
> > it filters out the case where the upper byte of wIndex is nonzero, 
> > so it need be replaced with temp.
> 
> I do not understand this text, can you try to reword it?
> 
> And you have trailing whitespace.
> 
> And why use `?
> 
> > ```
> 
> What is this for?  Changelog comments are not in markdown format.
> 
> > 	if ((typeReq == GetPortStatus) &&
> > 	    (wIndex && wIndex <= ports) &&       // need to be replaced
> 
> What does this comment mean?
> 
> > 	    ehci->reset_done[wIndex-1] &&
> > 	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
> > 	    (ehci_readl(ehci, status_reg) & PORT_RESUME)) {
> > ```
> > 
> > Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> > Reported-by: TCS Robot <tcs_robot@tencent.com>
> 
> Again, lines need to be in different order, and your from: line is not
> correct.
> 
> Also, you need an individual email address, not a group email alias for
> your contributions.  We work with individuals, not groups.
> 
> 
> 
> > ---
> >  drivers/usb/host/ehci-brcm.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
> > index a1e3290e5459..efcfca162126 100644
> > --- a/drivers/usb/host/ehci-brcm.c
> > +++ b/drivers/usb/host/ehci-brcm.c
> > @@ -73,9 +73,9 @@ static int ehci_brcm_hub_control(
> >  	 * of RESUME
> >  	 */
> >  	if ((typeReq == GetPortStatus) &&
> > -	    (wIndex && wIndex <= ports) &&
> > -	    ehci->reset_done[wIndex-1] &&
> > -	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
> > +	    (temp < ports) &&
> 
> Where did temp come from?

Also, as long as this piece of code is being changed, it would be a good 
idea to get rid of all the unnecessary parentheses.

Alan Stern
