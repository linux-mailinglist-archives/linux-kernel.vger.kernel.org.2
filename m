Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E535435CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhJUIOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJUIOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:14:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2021D610EA;
        Thu, 21 Oct 2021 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634803231;
        bh=AN4yQj3R/L6Utyw/bIYGBaFdbUzMpv6pWsfYDjS1t74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Djf/uchKNMzhvackK23asCzzrk1/KRQXEpXDsVMzU13O0DRpuxBraa33kaFe9BgEz
         xSJeUoqC1eCf4qjyzxGRTR+8g1a7v0j9V83feox6X+M9SO+AYMI9Bo9tEictSmRbaA
         pCwSPuH188aYhK3gEy0Mb4/+D1Q/MiCcvX6wgsms=
Date:   Thu, 21 Oct 2021 10:00:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] Docs: usb: update struct usb_driver, __init and __exit
Message-ID: <YXEeHCySQF+jbVty@kroah.com>
References: <20211020201446.GA8482@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020201446.GA8482@matrix-ESPRIMO-P710>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 10:14:46PM +0200, Philipp Hortmann wrote:
> update struct usb_driver from usb-skeleton.c.
> update __init and __exit functions that are moved from
> usb-skeleton.c to common used multi-stage macros.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> V1 -> V2: changed :c:func:`usb_register` to usb_register()
>           changed the :c:func:`usb_deregister` to usb_deregister()
>           used literal blocks for makro module_usb_driver and added one more
>           stage of multi-stage macros.
> 
>  .../driver-api/usb/writing_usb_driver.rst     | 70 ++++++++++---------
>  1 file changed, 36 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
> index 2176297e5765..12e0481cceae 100644
> --- a/Documentation/driver-api/usb/writing_usb_driver.rst
> +++ b/Documentation/driver-api/usb/writing_usb_driver.rst
> @@ -54,12 +54,15 @@ information is passed to the USB subsystem in the :c:type:`usb_driver`
>  structure. The skeleton driver declares a :c:type:`usb_driver` as::
>  
>      static struct usb_driver skel_driver = {
> -	    .name        = "skeleton",
> -	    .probe       = skel_probe,
> -	    .disconnect  = skel_disconnect,
> -	    .fops        = &skel_fops,
> -	    .minor       = USB_SKEL_MINOR_BASE,
> -	    .id_table    = skel_table,
> +           .name        = "skeleton",
> +           .probe       = skel_probe,
> +           .disconnect  = skel_disconnect,
> +           .suspend     = skel_suspend,
> +           .resume      = skel_resume,
> +           .pre_reset   = skel_pre_reset,
> +           .post_reset  = skel_post_reset,
> +           .id_table    = skel_table,
> +           .supports_autosuspend = 1,

Why remove the tabs?  Is that needed here?

>      };
>  
>  
> @@ -81,36 +84,35 @@ this user-space interaction. The skeleton driver needs this kind of
>  interface, so it provides a minor starting number and a pointer to its
>  :c:type:`file_operations` functions.
>  
> -The USB driver is then registered with a call to :c:func:`usb_register`,
> -usually in the driver's init function, as shown here::
> -
> -    static int __init usb_skel_init(void)
> -    {
> -	    int result;
> -
> -	    /* register this driver with the USB subsystem */
> -	    result = usb_register(&skel_driver);
> -	    if (result < 0) {
> -		    err("usb_register failed for the "__FILE__ "driver."
> -			"Error number %d", result);
> -		    return -1;
> -	    }
> -
> -	    return 0;
> -    }
> -    module_init(usb_skel_init);
> -
> +The USB driver is then registered with a call to usb_register()
> +which is usually in the driver's init function. Since this functionality
> +is usable with many USB drivers, it is hidden behind multi-stage macros.

I don't understand the need for the "multi-stage macros" term here.

And what functionality is referred to here by "this"?


> +While the first macros are USB specific the later macros are used in different
> +subsystems. This removes a lot of boilerplate code.

What later macros?  Is that really needed to describe here?

I think the above code example should remain, as it is good for learning
and understanding, and maybe just add something that says "Or you can
use the following macro to replace all of the above common code."


>  
>  When the driver is unloaded from the system, it needs to deregister
> -itself with the USB subsystem. This is done with the :c:func:`usb_deregister`
> -function::
> -
> -    static void __exit usb_skel_exit(void)
> -    {
> -	    /* deregister this driver with the USB subsystem */
> -	    usb_deregister(&skel_driver);
> -    }
> -    module_exit(usb_skel_exit);
> +itself with the USB subsystem. This is done with usb_deregister()
> +which is also hidden behind multi-stage macros.
> +
> +The init and exit functions are included in the macro module_usb_driver.
> +Find the first three stages of macros below::
> +
> +    module_usb_driver(skel_driver);
> +                         |
> +                         V
> +    module_driver(__usb_driver, usb_register, usb_deregister)
> +                         |               \               \
> +                         V                ----------      ----------
> +    static int __init __driver##_init(void) \      |               |
> +    { \                 v---------------------------               |
> +            return __register(&(__driver) , ##__VA_ARGS__); \      |
> +    } \                                                            |
> +    module_init(__driver##_init); \                                |
> +    static void __exit __driver##_exit(void) \                     |
> +    { \            v------------------------------------------------
> +            __unregister(&(__driver) , ##__VA_ARGS__); \
> +    } \
> +    module_exit(__driver##_exit);

As the one who wrote these macros, I can't really understand the
ascii-art here, so I worry about anyone else :)

Again, do not think trying to show an implementation detail like this is
needed.

thanks,

greg k-h
