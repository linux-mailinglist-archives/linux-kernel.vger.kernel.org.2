Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD232FBDF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 17:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCFQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 11:25:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhCFQZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 11:25:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5228065005;
        Sat,  6 Mar 2021 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615047916;
        bh=CVP5kR74Pu36RHohYTytHQFOqe51SYgpkePNbq51+hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VscOPZ+fSxvnSQRd3rV78Obpf1l3xJsl4m1/7bPtdREbld0ssNRnummiiADBwT0tQ
         wfT97P/TnSmqCx3fNxHHTH9+G/VvyzbOEsxbQoWWc5aIwZjvyQ7w8Kd6zTDJl/bbtM
         1fEhJINix2YxFXVu3JJkWR240o8gkqw2k9eq1qDY=
Date:   Sat, 6 Mar 2021 17:25:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangkun4jr@163.com
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Kun <zhangkun@cdjrlc.com>
Subject: Re: [PATCH] xhci: Remove unused value len from xhci_unmap_temp_buf
Message-ID: <YEOs5w8AYutM27/u@kroah.com>
References: <20210306120644.74406-1-zhangkun4jr@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306120644.74406-1-zhangkun4jr@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 08:06:44PM +0800, zhangkun4jr@163.com wrote:
> From: Zhang Kun <zhangkun@cdjrlc.com>
> 
> The value assigned to len by sg_pcopy_from_buffer() never used for
> anything, so remove it.
> 
> Signed-off-by: Zhang Kun <zhangkun@cdjrlc.com>
> ---
>  drivers/usb/host/xhci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index bd27bd670104..6ebda89d476c 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1335,7 +1335,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
>  
>  static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  {
> -	unsigned int len;
>  	unsigned int buf_len;
>  	enum dma_data_direction dir;
>  
> @@ -1351,7 +1350,7 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  				 dir);
>  
>  	if (usb_urb_dir_in(urb))
> -		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> +		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
>  					   urb->transfer_buffer,
>  					   buf_len,
>  					   0);

SHouldn't this be checked instead of ignored?

thanks,

greg k-h
