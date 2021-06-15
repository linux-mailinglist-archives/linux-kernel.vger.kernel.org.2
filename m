Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EA23A809B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhFONlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231748AbhFONko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:40:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FA9D61433;
        Tue, 15 Jun 2021 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623764318;
        bh=O5Y0aKLxP57G6eD4VvQhfLKkS1JXEl1LRNGOPnF/hhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rl7MmoXOauyx9rjlIhYd60x5xmj8BZDlXURvfNidi4nP5SfIr6NuUxfhe5bGaNFvq
         2ZufZyh25IELO2p+VYaK8c/znj4IOObgd1oiwwSi+BXtFv5RvlensWNQ2ri5O5sBM5
         Z4ArQrpofp7/GIE1h2q1G7BJXnN0lcYO4RG9Ixmc=
Date:   Tue, 15 Jun 2021 15:38:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linyu Yuan <linyyuan@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linyu Yuan <linyyuan@codeaurora.com>
Subject: Re: [PATCH v2] usb: gadget: eem: fix echo command packet response
 issue
Message-ID: <YMitW5K85kGTqPTf@kroah.com>
References: <20210614234133.17708-1-linyyuan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614234133.17708-1-linyyuan@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:41:33AM +0800, Linyu Yuan wrote:
> From: Linyu Yuan <linyyuan@codeaurora.com>
> 
> when receive eem echo command, it will send a response,
> but queue this response to the usb request which allocate
> from gadget device endpoint zero,
> and transmit the request to IN endpoint of eem interface.
> 
> on dwc3 gadget, it will trigger following warning in function
> __dwc3_gadget_ep_queue(),
> 
> 	if (WARN(req->dep != dep, "request %pK belongs to '%s'\n",
> 				&req->request, req->dep->name))
> 		return -EINVAL;
> 
> fix it by allocating a usb request from IN endpoint of eem interface,
> and transmit the usb request to same IN endpoint of eem interface.
> 
> Signed-off-by: Linyu Yuan <linyyuan@codeaurora.com>
> ---
> 
> v2: fix mail format and expand commit message
> 
>  drivers/usb/gadget/function/f_eem.c | 44 +++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/function/f_eem.c
> index 2cd9942707b4..7de355c63189 100644
> --- a/drivers/usb/gadget/function/f_eem.c
> +++ b/drivers/usb/gadget/function/f_eem.c
> @@ -30,6 +30,11 @@ struct f_eem {
>  	u8				ctrl_id;
>  };
>  
> +struct in_context {
> +	struct sk_buff	*skb;
> +	struct usb_ep	*ep;
> +};
> +
>  static inline struct f_eem *func_to_eem(struct usb_function *f)
>  {
>  	return container_of(f, struct f_eem, port.func);
> @@ -320,9 +325,12 @@ static int eem_bind(struct usb_configuration *c, struct usb_function *f)
>  
>  static void eem_cmd_complete(struct usb_ep *ep, struct usb_request *req)
>  {
> -	struct sk_buff *skb = (struct sk_buff *)req->context;
> +	struct in_context *ctx = req->context;
>  
> -	dev_kfree_skb_any(skb);
> +	dev_kfree_skb_any(ctx->skb);
> +	kfree(req->buf);
> +	usb_ep_free_request(ctx->ep, req);
> +	kfree(ctx);
>  }
>  
>  /*
> @@ -410,7 +418,9 @@ static int eem_unwrap(struct gether *port,
>  		 * b15:		bmType (0 == data, 1 == command)
>  		 */
>  		if (header & BIT(15)) {
> -			struct usb_request	*req = cdev->req;
> +			struct usb_request	*req;
> +			struct in_context	*ctx;
> +			struct usb_ep		*ep;
>  			u16			bmEEMCmd;
>  
>  			/* EEM command packet format:
> @@ -439,13 +449,37 @@ static int eem_unwrap(struct gether *port,
>  				skb_trim(skb2, len);
>  				put_unaligned_le16(BIT(15) | BIT(11) | len,
>  							skb_push(skb2, 2));
> +
> +				ep = port->in_ep;
> +				req = usb_ep_alloc_request(ep, GFP_ATOMIC);
> +				if (!req)
> +					goto freeskb;
> +
> +				ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> +				if (!ctx)
> +					goto freereq;
> +				ctx->skb = skb2;
> +				ctx->ep = ep;
> +
> +				req->buf = kmalloc(skb2->len, GFP_KERNEL);
> +				if (!req->buf)
> +					goto freectx;
> +
>  				skb_copy_bits(skb2, 0, req->buf, skb2->len);
>  				req->length = skb2->len;
>  				req->complete = eem_cmd_complete;
>  				req->zero = 1;
> -				req->context = skb2;
> -				if (usb_ep_queue(port->in_ep, req, GFP_ATOMIC))
> +				req->context = ctx;
> +				if (usb_ep_queue(ep, req, GFP_ATOMIC)) {
>  					DBG(cdev, "echo response queue fail\n");
> +					kfree(req->buf);
> +freectx:
> +					kfree(ctx);
> +freereq:
> +					usb_ep_free_request(ep, req);
> +freeskb:
> +					dev_kfree_skb_any(skb2);

As much fun as it is jumping to the middle of a case statement, are you
sure you want to maintain this?

And you do not return an error?  Why not?  What happens then?

thanks,

greg k-h
