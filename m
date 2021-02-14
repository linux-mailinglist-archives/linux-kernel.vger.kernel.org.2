Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E731AFE3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 10:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhBNJsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 04:48:38 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:50595 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhBNJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 04:48:33 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D4C6E9BB;
        Sun, 14 Feb 2021 04:47:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 14 Feb 2021 04:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=N/OF9Dq+2/vds7umAQJyb4qdd/D
        R0TApev4VFEX8LFA=; b=QH3LN7KICOY4b/aOOMahfVLr0pXEgLWKk/VqMGlzxKf
        gOmm+RWmBM0gd7V2eUZu1WrBDgjV6s+vEWJIDTOggvTeOC3aM0YQaItedbMJjPxe
        r8VLR5+mX4TefLKllcJYJJsK2zOHyVQKVgXfXzcFNwglTkGe67lteOqF0xzZ4ms1
        FyJzTo8ofN7scN11PVxQAKLIOQ3njtw9zPe1aVaZztEZLjrpMs+MtJ0+Wu6IxPuh
        qcbqRpfwRbXow3PNawIbZnjn/jvxfu54tJENT+emwCM2z2d52gI3D9vAvWQ7KUjI
        EYKtKyHNybWzH/OFNoO0Ucz2ZrFQ5ZqUDRK0jjtlTrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=N/OF9D
        q+2/vds7umAQJyb4qdd/DR0TApev4VFEX8LFA=; b=Nm2ZQS8KpeojaphzU+RuS/
        98UdDBEAxBgFzr8kjzzH8g2JE0GBgLOk5gMbZML+FpdE+d4LLnIyZNNHQNcxmsHu
        fsD9spTjmvQVoWQe+OLUYNV4kedF/JMfIRvHqn+Bl1vRZ9mAjh6uLiGSPHq6WrAK
        7OQE7JUQAZYe0PLE0LOwoEk+BlsJTqKdh7iWZschvlKDIbZlE0Hy6O3trUJty7RR
        cgoISWMk95rZZGSoZGFNTOEuEtYqAxmCUYQnW7MgQH5t1YRBglF/7WJg86EjyVYr
        Meulio/MmUbf8OqX30Cpu8oATSX7u3DU7f5yqFhz8RLCnQ2gFlKr5EmlgjrYiB0g
        ==
X-ME-Sender: <xms:rfEoYP-_CN3ZDykdiYRhhDaT5QxqNK8ZxzzBLgMBVazQHUGradbDmg>
    <xme:rfEoYLv1QmLcJOPBGJ2JKtsQCl39R8v2jPSIfse_vS4sAinvZKQ2ng7LdEZyFpVwC
    ogkoXBBdiUwkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrieehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucfkphepkeefrdekiedrjeegrdeigeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:rfEoYND6DKkWXfMZSVGuBft1U8fxjIUAJnTpsChuz1mmCHm_90XthQ>
    <xmx:rfEoYLcWgYAMS7d4cSGAW9HDtbd-awGBe_yUpSjroLYOumMxk_50yQ>
    <xmx:rfEoYEPaVpA7elp9XwLuuI1liP2oXCCIesFfOWW9aNtykQWX8yo4yA>
    <xmx:rfEoYO2hicoJ0bLDgf5esD75NFqi7cwGnxi0ORvd6mBsZ7fGomT-hA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id EF26D240057;
        Sun, 14 Feb 2021 04:47:24 -0500 (EST)
Date:   Sun, 14 Feb 2021 10:47:22 +0100
From:   Greg KH <greg@kroah.com>
To:     AristoChen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] Fix typo in f_printer.c
Message-ID: <YCjxqontDxHYq+cH@kroah.com>
References: <20210214094025.7380-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214094025.7380-1-jj251510319013@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 05:40:25PM +0800, AristoChen wrote:
> In line 824, it is trying to open `out_ep`, so
> I believe in line 826, it should print `out_ep`
> instead of `in_ep`
> 
> Signed-off-by: AristoChen <jj251510319013@gmail.com>
> ---
>  drivers/usb/gadget/function/f_printer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index 2f1eb2e81d30..a3b17ec00bf0 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -823,7 +823,7 @@ set_printer_interface(struct printer_dev *dev)
>  
>  	result = usb_ep_enable(dev->out_ep);
>  	if (result != 0) {
> -		DBG(dev, "enable %s --> %d\n", dev->in_ep->name, result);
> +		DBG(dev, "enable %s --> %d\n", dev->out_ep->name, result);
>  		goto done;
>  	}
>  
> -- 
> 2.25.1
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
