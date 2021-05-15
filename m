Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8639C381706
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhEOIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 04:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhEOIwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 04:52:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 098B761090;
        Sat, 15 May 2021 08:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621068696;
        bh=m3lBRiOspltdvm2XIQhoLSyKo9zzgLjpz5rqo97Zg8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+PVqT4O+Wzbsg7XtUwRdEUv2SD8Jq4u8EiZrfEFQTiqGFRCodsxMzbZ0m5R//jFN
         3+4HpOFkSVbhVfD6pOaKI6fmzuu3aUzYf7G2tjbytB8QzsOe0Fgt3ygZ0al6vbKyOG
         5klzyoGLf4Cj2Lnb1kOyUFZcA2ZBBfmRwnf9QdSQ=
Date:   Sat, 15 May 2021 10:51:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] usb: xhci: Remove useless variable
Message-ID: <YJ+LlTUFgr1YFg9f@kroah.com>
References: <20210515084647.179580-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210515084647.179580-1-chengzhihao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 04:46:47PM +0800, Zhihao Cheng wrote:
> Fix the following gcc warning:
> 
> drivers/usb/host/xhci.c:1349:15: warning: variable ‘len’ set but not
> used [-Wunused-but-set-variable ]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/usb/host/xhci.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index ca9385d22f68..b38a14ef2e15 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1346,7 +1346,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
>  
>  static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  {
> -	unsigned int len;
>  	unsigned int buf_len;
>  	enum dma_data_direction dir;
>  
> @@ -1362,10 +1361,10 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  				 dir);
>  
>  	if (usb_urb_dir_in(urb))
> -		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> -					   urb->transfer_buffer,
> -					   buf_len,
> -					   0);
> +		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> +				     urb->transfer_buffer,
> +				     buf_len,
> +				     0);
>  
>  	urb->transfer_flags &= ~URB_DMA_MAP_SINGLE;
>  	kfree(urb->transfer_buffer);
> -- 
> 2.25.4
> 

Isn't this the same thing that I have asked "please fix this by checking
the return value!" in the past?

Please do so.

greg k-h
