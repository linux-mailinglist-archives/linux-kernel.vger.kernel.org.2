Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52B43405A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhJSVUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:20:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:53264 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhJSVUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:20:05 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AA2DC738;
        Tue, 19 Oct 2021 21:17:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AA2DC738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634678271; bh=UCRDCuJa8KPpx1EsK+Fxjrdirrt8HupK/FB9Ht4UhsY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YIEAG/3ngtwg4ajkuJOUWI/bVFHx2fjSHZyVnMDLoaIbjSFZu5VmrolIP/xjhZ83N
         l7dxwTEZoi+qFmq3X1XS50IyEc5UR1km25s0cg3fFFD4A1oHTUkWdXDS8Hq4w1lXya
         we2yPx3yV4YEvywY88d59EL4kJNlXwkHAIsZMj/JYgH7ZIKRBJCh/EJDGkALLCHC1o
         NUHwoNiJ0aaopXmhbgSF1bdkxKNAg1XFZIujvxJ3Mob/WwWVbSvbcN57mB+Uv/sQan
         +Z5ZDEJPYlDBqHrsHpkENn6WF4JgyA4ma60YaMgXX+HE3mrWY/LdWekCkmoWyBUtuI
         16NpgYQ7u7BeA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: Re: [PATCH] Docs: usb: update struct usb_driver, __init and __exit
In-Reply-To: <20211017214948.GA9901@matrix-ESPRIMO-P710>
References: <20211017214948.GA9901@matrix-ESPRIMO-P710>
Date:   Tue, 19 Oct 2021 15:17:51 -0600
Message-ID: <87h7dcsohs.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Hortmann <philipp.g.hortmann@gmail.com> writes:

> update struct usb_driver from usb-skeleton.c.
> update __init and __exit functions that are moved from
> usb-skeleton.c to common used multi-stage macros.
>
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  .../driver-api/usb/writing_usb_driver.rst     | 51 +++++++------------
>  1 file changed, 19 insertions(+), 32 deletions(-)

Adding linux-usb: this seems like a reasonable change (though see
below), but the USB folks should have a chance to look it over too.

> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
> index 2176297e5765..1064adf79ccb 100644
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
>      };
>  
>  
> @@ -81,36 +84,20 @@ this user-space interaction. The skeleton driver needs this kind of
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
> +The USB driver is then registered with a call to :c:func:`usb_register`

We shouldn't be using :c:func: anymore; just say usb_register() and the
right things will happen.  Definitely worth fixing while you are in the
neighborhood.

> +which is usually in the driver's init function. Since this functionality
> +is usable with many USB drivers, it is hidden behind multi-stage macros.
> +While the first macros are USB specific the later macros are used in different
> +subsystems. This removes a lot of boilerplate code.
>  
>  When the driver is unloaded from the system, it needs to deregister
>  itself with the USB subsystem. This is done with the :c:func:`usb_deregister`
> -function::
> +which is also hidden behind multi-stage macros.

If you're making this change, take out "the" (as well as :c:func:).

> -    static void __exit usb_skel_exit(void)
> -    {
> -	    /* deregister this driver with the USB subsystem */
> -	    usb_deregister(&skel_driver);
> -    }
> -    module_exit(usb_skel_exit);
> +The init and exit functions are included in the macro :
> +module_usb_driver(skel_driver);
> +which is in the first stage replaced by:
> +module_driver(__usb_driver, usb_register, usb_deregister)

This will not render the way you want; consider using literal blocks
here. 

Thanks,

jon
