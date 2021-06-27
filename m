Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7345E3B50CD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 04:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhF0CvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 22:51:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23172 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhF0CvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 22:51:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624762140; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MRStp5Lf5S4mzb1+rC3cp0h9PtU2m4YOTYmUov94j2Y=;
 b=XrXoVaty5X4d0StJXJYqoyeJAGNzCV4xdqaylN2webhMH1crCuojcKkMg+3ZhtYGHVjGtrmH
 nvHmafxl5PsGQD7ZsHqjF1cDtjnDvq4pFnjbpT7kQZ8x29tamAmbnH1jVWc1NSFNU8XuY5/D
 efXM7lxRXK2168lcUlbj5cYYfVg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60d7e7192a2a9a9761c77f50 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 27 Jun 2021 02:48:57
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B249FC43460; Sun, 27 Jun 2021 02:48:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CED2BC433F1;
        Sun, 27 Jun 2021 02:48:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 27 Jun 2021 10:48:56 +0800
From:   linyyuan@codeaurora.org
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: fix race of usb_gadget_driver operation
In-Reply-To: <20210626150304.GA601624@rowland.harvard.edu>
References: <20210625104415.8072-1-linyyuan@codeaurora.org>
 <20210625163707.GC574023@rowland.harvard.edu>
 <b24825113327c72c742d55e89ec2726e@codeaurora.org>
 <20210626150304.GA601624@rowland.harvard.edu>
Message-ID: <1d1f06763c7cdeb67264128537c6a8f4@codeaurora.org>
X-Sender: linyyuan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-26 23:03, Alan Stern wrote:
> On Sat, Jun 26, 2021 at 09:16:25AM +0800, linyyuan@codeaurora.org 
> wrote:
>> On 2021-06-26 00:37, Alan Stern wrote:
>> > On Fri, Jun 25, 2021 at 06:44:15PM +0800, Linyu Yuan wrote:
> 
>> > > --- a/drivers/usb/dwc3/ep0.c
>> > > +++ b/drivers/usb/dwc3/ep0.c
>> > > @@ -597,10 +597,11 @@ static int dwc3_ep0_set_address(struct dwc3
>> > > *dwc, struct usb_ctrlrequest *ctrl)
>> > >
>> > >  static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct
>> > > usb_ctrlrequest *ctrl)
>> > >  {
>> > > -	int ret;
>> > > +	int ret = 0;
>> > >
>> > >  	spin_unlock(&dwc->lock);
>> > > -	ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
>> > > +	if (dwc->async_callbacks)
>> > > +		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
>> > >  	spin_lock(&dwc->lock);
>> >
>> > Here and in the other places, you should test dwc->async_callbacks
>> > _before_ dropping the spinlock.  Otherwise there is a race (the flag
>> > could be written at about the same time it is checked).
>> thanks for your comments,
>> 
>> if you think there is race here, how to make sure gadget_driver 
>> pointer is
>> safe,
>> this is closest place where we can confirm it is non-NULL by checking
>> async_callbacks ?
> 
> I explained this twice already: We know that gadget_driver is not
> NULL because usb_gadget_remove_driver calls synchronize_irq before
> doing usb_gadget_udc_stop.
> 
> Look at this timing diagram:
> 
> 	CPU0				CPU1
> 	----				----
> 	IRQ happens for setup packet
> 	  Handler sees async_callbacks
> 	    is enabled
> 	  Handler unlocks dwc->lock
> 					usb_gadget_remove_driver runs
> 					  Disables async callbacks
> 					  Calls synchronize_irq
> 	  Handler calls dwc->		  . waits for IRQ handler to
> 	    gadget_driver->setup	  .   return
> 	  Handler locks dwc-lock	  .
> 	  ...				  .
> 	  Handler returns		  .
> 					  . synchronize_irq returns
> 					  Calls usb_gadget_udc_stop
> 					    dwc->gadget_driver is
> 					      set to NULL
> 
> As you can see, dwc->gadget_driver is non-NULL when CPU0 uses it,
> even though async_callbacks gets cleared during the time when the
> lock is released.
thanks for your patient explanation,
but from this part, seem it is synchronize_irq() help to avoid NULL 
pointer crash.

can you also explain how async_callbacks flag help here  ?
> 
> Alan Stern
