Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23381392C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhE0LLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232891AbhE0LLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:11:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C26C613C3;
        Thu, 27 May 2021 11:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622113795;
        bh=S50i7V9zKqp9ykst0hBUpLzOjqYDdl+ARgnpmCYzUKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzeNixbI+DBhHFQgy4SwLLSanKMFEHVM1BMqaO84c3N7bNXbOGyjVwBxHoH+BuTPq
         3jqPbuY+EAo13Wg/hwUw8EXMTZ+lDPh6h9zcbnNaXiBhCVndbC698nG6Kd7Uwq/t8d
         jkPvwBJ6P2ykWeo1hTy9cl/QmN0MHIi+ea4wwwgg=
Date:   Thu, 27 May 2021 13:09:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Swapnil <swocp19@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed kernel code formatting
Message-ID: <YK9+AXt/XsUh3G1a@kroah.com>
References: <20210524143741.GA529321@cryptik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524143741.GA529321@cryptik>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:07:41PM +0530, Swapnil wrote:
> Fixed lines ending with '(' by moving an actual function parameter from
> the next line to the end of the current line.
> 
> Signed-off-by: Swapnil <swocp19@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index ecc5c9da9027..b6abd3770e81 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -1073,9 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
>  		i_word_length = length / sizeof(u32);
>  		if (i_word_length > 0) {
>  			for (i = 0; i < i_word_length; i++) {
> -				_nbu2ss_writel(
> -					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
> -					p_buf_32->dw);
> +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
> +					       p_buf_32->dw);
>  
>  				p_buf_32++;
>  			}
> @@ -1225,8 +1224,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
>  		return;
>  
>  	if (ep->epnum > 0) {
> -		length = _nbu2ss_readl(
> -			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
> +		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
>  
>  		length &= EPN_LDATA;
>  		if (length < ep->ep.maxpacket)
> @@ -1462,8 +1460,7 @@ static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc,
>  		for (limit_cnt = 0
>  			; limit_cnt < IN_DATA_EMPTY_COUNT
>  			; limit_cnt++) {
> -			regdata = _nbu2ss_readl(
> -				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
> +			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
>  
>  			if ((regdata & EPN_IN_DATA) == 0)
>  				break;
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
