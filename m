Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7CB40792D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhIKPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 11:48:03 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57669 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232353AbhIKPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 11:48:01 -0400
Received: (qmail 69147 invoked by uid 1000); 11 Sep 2021 11:46:48 -0400
Date:   Sat, 11 Sep 2021 11:46:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci: Prefer struct_size over open coded arithmetic
Message-ID: <20210911154648.GA68944@rowland.harvard.edu>
References: <20210911112631.10004-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911112631.10004-1-len.baker@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 01:26:31PM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-hcd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 1f5e69314a17..666b1c665188 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -191,8 +191,7 @@ static int ohci_urb_enqueue (
>  	}
> 
>  	/* allocate the private part of the URB */
> -	urb_priv = kzalloc (sizeof (urb_priv_t) + size * sizeof (struct td *),
> -			mem_flags);
> +	urb_priv = kzalloc(struct_size(urb_priv, td, size), mem_flags);
>  	if (!urb_priv)
>  		return -ENOMEM;
>  	INIT_LIST_HEAD (&urb_priv->pending);
> --
> 2.25.1
> 
