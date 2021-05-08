Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2AC376F29
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 05:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhEHDq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 23:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhEHDq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 23:46:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADEAE610FA;
        Sat,  8 May 2021 03:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620445556;
        bh=jnpqzqHEpZpKJi1Q0SJGsMxqgY/ElQuf5wSOLpkHKTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBfogrTMo9jZD3sYFCpBXpY9wIORrgUJ0ZLPBSLFyvLTpD1pEmlkKn4xQuHLHYd5v
         3AAom7rFeQUQazAvAEaU8DqeIO+JQwe/Ufmq2Fi4tgk86T6X5gEw9l+++1Q0Di5Wsi
         y/v+rq8Y1g0ifQf/96CLHjf4stdEcQg6VUFyuwbxzir5VRhCmmlKaVpUPyluAHbJc7
         E20fP+BtraPTpkuLIP/RSXIs1hoAGXXS39ZXvGSAhn3yBtvNzTWBdavCCF/LU369TR
         /LcGA+umMJXXo0wCOXPb8dH6KcCMHT44WQ9EiKH3cM1nCEOdrBPlmKftwEFHGVEjbf
         xxS5VxSy8k9uw==
Date:   Sat, 8 May 2021 11:45:51 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Replace list_for_each_entry_safe() if
 using giveback
Message-ID: <20210508034551.GA2728@nchen>
References: <1620412923-11990-1-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620412923-11990-1-git-send-email-wcheng@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-07 11:42:03, Wesley Cheng wrote:
> The list_for_each_entry_safe() macro saves the current item (n) and
> the item after (n+1), so that n can be safely removed without
> corrupting the list.  However, when traversing the list and removing
> items using gadget giveback, the DWC3 lock is briefly released,

I see dwc3_gadget_del_and_unmap_request remove the list, the lock is
still held there. Am I something wrong?

Peter
       
> allowing other routines to execute.  There is a situation where while
> items are being removed from the cancelled_list using
> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
> routine is running in parallel (due to UDC unbind).  As the cleanup
> routine removes n, and the pullup disable removes n+1, once the
> cleanup retakes the DWC3 lock, it references a request who was already
> removed/handled.  With list debug enabled, this leads to a panic.
> Ensure all instances of the macro are replaced where gadget giveback
> is used.
> 
> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/dwc3/gadget.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index dd80e5c..efa939b 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1737,10 +1737,10 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
>  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
>  {
>  	struct dwc3_request		*req;
> -	struct dwc3_request		*tmp;
>  	struct dwc3			*dwc = dep->dwc;
>  
> -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
> +	while (!list_empty(&dep->cancelled_list)) {
> +		req = next_request(&dep->cancelled_list);
>  		dwc3_gadget_ep_skip_trbs(dep, req);
>  		switch (req->status) {
>  		case DWC3_REQUEST_STATUS_DISCONNECTED:
> @@ -2935,11 +2935,11 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
>  		const struct dwc3_event_depevt *event, int status)
>  {
>  	struct dwc3_request	*req;
> -	struct dwc3_request	*tmp;
>  
> -	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
> +	while (!list_empty(&dep->started_list)) {
>  		int ret;
>  
> +		req = next_request(&dep->started_list);
>  		ret = dwc3_gadget_ep_cleanup_completed_request(dep, event,
>  				req, status);
>  		if (ret)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 

Thanks,
Peter Chen

