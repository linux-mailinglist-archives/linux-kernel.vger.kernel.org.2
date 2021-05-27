Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160DD392883
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhE0H2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhE0H2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:28:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7982F6054E;
        Thu, 27 May 2021 07:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622100419;
        bh=heiu7CttlGAn3jsUC6x/m1TVLzaTKArTVR1Pqh113kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wiZWZrPJXQOb5ONPuJmI5MRbHf12MwJPzNG7VeI5KobDtJIvr5we87fhe2TAPSlj1
         4TZPiUY8kiuE1lhB1xx/JpNkynqlosr6KLFZe5u+lrfpbXbyJ8oH087F4ICkLQXU1Q
         +OSeH3LuLnBADAavvP6emEKEbKjlmhxW4D6ePqcg=
Date:   Thu, 27 May 2021 09:26:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 17/24] usb: host: xhci: Remove unused variable 'len'
Message-ID: <YK9Ju9/kdaRv1jcT@kroah.com>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-18-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210526130037.856068-18-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 02:00:30PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/host/xhci.c: In function ‘xhci_unmap_temp_buf’:
>  drivers/usb/host/xhci.c:1349:15: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/host/xhci.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 27283654ca080..ac2a7d4288883 100644
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

Sorry, but no, I keep rejecting this over and over, it needs to handle
the error handling properly and not paper over it like this :(

All the bots keep tripping up on it, you are not alone.

thanks,

greg k-h
