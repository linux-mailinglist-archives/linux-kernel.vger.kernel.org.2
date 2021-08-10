Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B286E3E533E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbhHJGGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhHJGGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6111360F55;
        Tue, 10 Aug 2021 06:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628575552;
        bh=XzOB96wPHfu9rYOv3j1ASEVIo26lUkIuCcFER+63L8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAq67zxxGf6IEcxsp+4K/IT2Ae6lwQvydXhnzZ384j5vu/+DyivXXWJB12bz9MTcO
         dIMLKXbnLyvvFW3wyae0GLIxZEhBHeFRm3MTxEzAyWvb7/RCaS9u4QNUv4JqgEYOfl
         Re46rweTC3OQbB4xfNVir8Aow9dRPk+IhT/Fp85c=
Date:   Tue, 10 Aug 2021 08:05:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Petri Gynther <pgynther@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
Message-ID: <YRIXPflAPtCPHQde@kroah.com>
References: <CANcMJZCEVxVLyFgLwK98hqBEdc0_n4P0x_K6Gih8zNH3ouzbJQ@mail.gmail.com>
 <20210809223159.2342385-1-john.stultz@linaro.org>
 <4e1bef57-8520-36b9-f5cb-bbc925626a19@synopsys.com>
 <CALAqxLXPGt69ceiXkGT-nDjeP72mmCUgEzDdMpXr=rSNwpespw@mail.gmail.com>
 <0dfa8cd6-99b6-55c7-8099-0f6f1187b7fd@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dfa8cd6-99b6-55c7-8099-0f6f1187b7fd@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:57:27PM +0000, Thinh Nguyen wrote:
> John Stultz wrote:
> > On Mon, Aug 9, 2021 at 3:44 PM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> >>
> >> John Stultz wrote:
> >>> In commit d25d85061bd8 ("usb: dwc3: gadget: Use
> >>> list_replace_init() before traversing lists"), a local list_head
> >>> was introduced to process the started_list items to avoid races.
> >>>
> >>> However, in dwc3_gadget_ep_cleanup_completed_requests() if
> >>> dwc3_gadget_ep_cleanup_completed_request() fails, we break early,
> >>> causing the items on the local list_head to be lost.
> >>>
> >>> This issue showed up as problems on the db845c/RB3 board, where
> >>> adb connetions would fail, showing the device as "offline".
> >>>
> >>> This patch tries to fix the issue by if we are returning early
> >>> we splice in the local list head back into the started_list
> >>> and return (avoiding an infinite loop, as the started_list is
> >>> now non-null).
> >>>
> >>> Not sure if this is fully correct, but seems to work for me so I
> >>> wanted to share for feedback.
> >>>
> >>> Cc: Wesley Cheng <wcheng@codeaurora.org>
> >>> Cc: Felipe Balbi <balbi@kernel.org>
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Cc: Alan Stern <stern@rowland.harvard.edu>
> >>> Cc: Jack Pham <jackp@codeaurora.org>
> >>> Cc: Thinh Nguyen <thinh.nguyen@synopsys.com>
> >>> Cc: Todd Kjos <tkjos@google.com>
> >>> Cc: Amit Pundir <amit.pundir@linaro.org>
> >>> Cc: YongQin Liu <yongqin.liu@linaro.org>
> >>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> >>> Cc: Petri Gynther <pgynther@google.com>
> >>> Cc: linux-usb@vger.kernel.org
> >>> Fixes: d25d85061bd8 ("usb: dwc3: gadget: Use list_replace_init() before traversing lists")
> >>> Signed-off-by: John Stultz <john.stultz@linaro.org>
> >>> ---
> >>>  drivers/usb/dwc3/gadget.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> >>> index b8d4b2d327b23..a73ebe8e75024 100644
> >>> --- a/drivers/usb/dwc3/gadget.c
> >>> +++ b/drivers/usb/dwc3/gadget.c
> >>> @@ -2990,6 +2990,12 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
> >>>                       break;
> >>>       }
> >>>
> >>> +     if (!list_empty(&local)) {
> >>> +             list_splice_tail(&local, &dep->started_list);
> >>> +             /* Return so we don't hit the restart case and loop forever */
> >>> +             return;
> >>> +     }
> >>> +
> >>>       if (!list_empty(&dep->started_list))
> >>>               goto restart;
> >>>  }
> >>>
> >>
> >> No, we should revert the change for
> >> dwc3_gadget_ep_cleaup_completed_requests(). As I mentioned previously,
> >> we don't cleanup the entire started_list. If the original problem is due
> >> to disconnection in the middle of request completion, then we can just
> >> check for pullup_connected and exit the loop and let the
> >> dwc3_remove_requests() do the cleanup.
> > 
> > Ok, sorry, I didn't read your mail in depth until I had this patch
> > sent out. If a revert of d25d85061bd8 is the better fix, I'm fine with
> > that too.
> > 
> > thanks
> > -john
> > 
> 
> IMO, we should revert this patch for now since it will cause regression.
> We can review and test a proper fix at a later time.

Ok, can someone send me a revert please?  That will go faster than me
having to create it myself...

thanks,

greg k-h
