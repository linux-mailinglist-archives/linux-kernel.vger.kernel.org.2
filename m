Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05923377991
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 02:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhEJA4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 20:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhEJA4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 20:56:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A080613CD;
        Mon, 10 May 2021 00:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620608117;
        bh=Cg+Qf/Kiv1aQGBq6X+ZOMeULI7z8X72fzmy/0si3naA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/IHw+opG80m/7CfEYFPurQPCUNaBfzea3rCyTKgn4akLr+p1ruOw5IfvcLCjeTS5
         9cdBPqaSSOn4krncqX2HyqVlX1gIlT61K4zqui6PhoWyeZUWZSOHfeq/7XKLm085lk
         j4Viov0902f7uFLw/wu6Y7HgdnpX9ZEYf5Z6G3c1pwOHSKNdOXVobAXBQ9twRpxYN3
         g4QlVd6jjlz2Baojm3xtnQl3PLHpYZVHXvyo0FFSxmzBghlH0AslLh7QPPMfKBR/rl
         Xbd8ZmKZ5N5qnunQGQd6bqYSMGwLrrwJhEWBWBT7xBrwM1RBjUPrk9C/UI/fmxVS57
         zmJ9I6USEgu8g==
Date:   Mon, 10 May 2021 08:55:12 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Replace list_for_each_entry_safe() if
 using giveback
Message-ID: <20210510005512.GA7668@nchen>
References: <1620412923-11990-1-git-send-email-wcheng@codeaurora.org>
 <20210508034551.GA2728@nchen>
 <cec4b493-ff09-4543-661e-68c0c4d44e0f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec4b493-ff09-4543-661e-68c0c4d44e0f@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-08 01:15:49, Wesley Cheng wrote:
> 
> 
> On 5/7/2021 8:45 PM, Peter Chen wrote:
> > On 21-05-07 11:42:03, Wesley Cheng wrote:
> >> The list_for_each_entry_safe() macro saves the current item (n) and
> >> the item after (n+1), so that n can be safely removed without
> >> corrupting the list.  However, when traversing the list and removing
> >> items using gadget giveback, the DWC3 lock is briefly released,
> 
> Hi Peter,
> 
> Thanks for the review.
> 
> > 
> > I see dwc3_gadget_del_and_unmap_request remove the list, the lock is
> > still held there. Am I something wrong?
> > 
> 
> The scenario the issue happens in is say the follow thread is running
> the sequence below:
> 
> Thread#1:
> __dwc3_gadget_ep_set_halt() - CLEAR HALT
>   -> dwc3_gadget_ep_cleanup_cancelled_requests()
>     ->list_for_each_entry_safe()
>     ->dwc3_gadget_giveback()
>       ->dwc3_gadget_del_and_unmap_request()-n deleted cancelled_list
>       ->spin_unlock
> 
> Thread#2:
> dwc3_gadget_pullup()
>   ->waiting for dwc3 spin_lock
>   ->Thread#1 released lock
>   ->dwc3_stop_active_transfers()
>     ->dwc3_remove_requests()
>       ->fetches n+1 item from cancelled_list (n removed by thread#1)
>       ->dwc3_gadget_giveback()
>         ->dwc3_gadget_del_and_unmap_request()-n+1 deleted cancelled_list
>         ->spin_unlock
> 
> So now, if thread#1 takes the DWC3 lock again, it will continue to item
> n+1, which was already removed by thread#2, leading to a double list
> removal.  We saw this issue on our platform after enabling list debug.

It is cleared now. Would you please update commit log a little by appending
your call stack analysis?

Reviewed-by: Peter Chen <peter.chen@kernel.org>

Peter
> 
> Thanks
> Wesley Cheng
> 
> > Peter
> >        
> >> allowing other routines to execute.  There is a situation where while
> >> items are being removed from the cancelled_list using
> >> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
> >> routine is running in parallel (due to UDC unbind).  As the cleanup
> >> routine removes n, and the pullup disable removes n+1, once the
> >> cleanup retakes the DWC3 lock, it references a request who was already
> >> removed/handled.  With list debug enabled, this leads to a panic.
> >> Ensure all instances of the macro are replaced where gadget giveback
> >> is used.
> >>
> >> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
> >> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> >> ---
> >>  drivers/usb/dwc3/gadget.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> >> index dd80e5c..efa939b 100644
> >> --- a/drivers/usb/dwc3/gadget.c
> >> +++ b/drivers/usb/dwc3/gadget.c
> >> @@ -1737,10 +1737,10 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
> >>  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
> >>  {
> >>  	struct dwc3_request		*req;
> >> -	struct dwc3_request		*tmp;
> >>  	struct dwc3			*dwc = dep->dwc;
> >>  
> >> -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
> >> +	while (!list_empty(&dep->cancelled_list)) {
> >> +		req = next_request(&dep->cancelled_list);
> >>  		dwc3_gadget_ep_skip_trbs(dep, req);
> >>  		switch (req->status) {
> >>  		case DWC3_REQUEST_STATUS_DISCONNECTED:
> >> @@ -2935,11 +2935,11 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
> >>  		const struct dwc3_event_depevt *event, int status)
> >>  {
> >>  	struct dwc3_request	*req;
> >> -	struct dwc3_request	*tmp;
> >>  
> >> -	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
> >> +	while (!list_empty(&dep->started_list)) {
> >>  		int ret;
> >>  
> >> +		req = next_request(&dep->started_list);
> >>  		ret = dwc3_gadget_ep_cleanup_completed_request(dep, event,
> >>  				req, status);
> >>  		if (ret)
> >> -- 
> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> >> a Linux Foundation Collaborative Project
> >>
> > 
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 

Thanks,
Peter Chen

