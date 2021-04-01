Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64633513D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhDAKoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233780AbhDAKoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:44:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87FD560FED;
        Thu,  1 Apr 2021 10:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617273847;
        bh=7grKtL4HFoTKoGxPCq5J7Opvb2ADbNce8guDq6kam5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zP20778W8eSy6iD1mXRZknns9TyE5nt4vh1CuZG+rBs6EljQ6IM/pEhEjF7rQ2+kU
         63yafNk8Tg4Skv32PJSLSanlUJP9mB/5jTah31go2F9oGX5wiAvlXurE66l48M/aH7
         EDftMAOtfAPGjRTyDpcjdcWJhy/o/eA2v1r01/Zg=
Date:   Thu, 1 Apr 2021 12:44:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: remove unused variable
Message-ID: <YGWj9KKtEd+sAdtH@kroah.com>
References: <1617272235-62515-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617272235-62515-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 06:17:15PM +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
> 
> drivers/usb/host/xhci.c:1346:15: warning: variable ‘len’ set but not
> used [-Wunused-but-set-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/usb/host/xhci.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 1975016..0ead09c 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1343,7 +1343,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
>  
>  static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  {
> -	unsigned int len;
>  	unsigned int buf_len;
>  	enum dma_data_direction dir;
>  
> @@ -1359,10 +1358,9 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  				 dir);
>  
>  	if (usb_urb_dir_in(urb))
> -		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> -					   urb->transfer_buffer,
> -					   buf_len,
> -					   0);
> +		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> +				     urb->transfer_buffer,
> +				     buf_len, 0);
>  
>  	urb->transfer_flags &= ~URB_DMA_MAP_SINGLE;
>  	kfree(urb->transfer_buffer);
> -- 
> 1.8.3.1
> 

Why resubmit this same change when I rejected it in the past?

{sigh}

greg k-h
