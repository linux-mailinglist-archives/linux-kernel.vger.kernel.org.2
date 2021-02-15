Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E531C0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhBORsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:48:38 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33199 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231247AbhBORmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:42:36 -0500
Received: (qmail 961148 invoked by uid 1000); 15 Feb 2021 12:41:45 -0500
Date:   Mon, 15 Feb 2021 12:41:45 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: usb: dwc3: gadget: Change runtime pm function for DWC3 runtime
 suspend
Message-ID: <20210215174145.GA960831@rowland.harvard.edu>
References: <CGME20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51@epcas2p2.samsung.com>
 <1613356739-91734-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613356739-91734-1-git-send-email-dh10.jung@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 11:38:58AM +0900, Daehwan Jung wrote:
> It seems pm_runtime_put calls runtime_idle callback not runtime_suspend callback.

How is this fact related to your patch?

> It's better to use pm_runtime_put_sync_suspend to allow DWC3 runtime suspend.

Why do you think it is better?  The advantage of pm_runtime_put is that 
it allows the suspend to occur at a later time in a workqueue thread, so 
the caller doesn't have to wait for the device to go into suspend.

Alan Stern

> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/dwc3/gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index aebcf8e..4a4b93b 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2229,7 +2229,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  	 */
>  	ret = pm_runtime_get_sync(dwc->dev);
>  	if (!ret || ret < 0) {
> -		pm_runtime_put(dwc->dev);
> +		pm_runtime_put_sync_suspend(dwc->dev);
>  		return 0;
>  	}
>  
> -- 
> 2.7.4
> 
