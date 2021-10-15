Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB5E42E922
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhJOGkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233075AbhJOGkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:40:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB0D060724;
        Fri, 15 Oct 2021 06:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634279895;
        bh=c+hC/02ps9Zl5VAHvbVkFeONHX0JbnrHm1oSYVMThgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03GGlSBRo4urnsj9cq1GKEAnHfS47+LpJa7fjJkO9+YE/tjimjK11y5v8BN1o6w+T
         yLTYy2nmXA8Y41qm+jrzah6mCR/+NplEr3xjAzjjnCzbBP/iO4loJzAbN0sjEZtp4w
         DWTk0W63YDrY5lSFhoUKyEcB6aEjMGqBZhYjJ5QY=
Date:   Fri, 15 Oct 2021 08:38:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jackp@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Remove dev_err() when queuing to
 inactive gadget/ep
Message-ID: <YWkh1NXmmMbf59Ee@kroah.com>
References: <20211014233534.2382-1-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014233534.2382-1-wcheng@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 04:35:34PM -0700, Wesley Cheng wrote:
> Since function drivers will still be active until dwc3_disconnect_gadget()
> is called, some applications will continue to queue packets to DWC3
> gadget.  This can lead to a flood of messages regarding failed ep queue,
> as the endpoint is in the process of being disabled.  Remove the print as
> function drivers will likely log queuing errors as well.
> 
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/dwc3/gadget.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 4845682a0408..674a9a527125 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1812,11 +1812,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>  {
>  	struct dwc3		*dwc = dep->dwc;
>  
> -	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
> -		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
> -				dep->name);

Why not just change this to dev_dbg() instead?

thanks,

greg k-h
