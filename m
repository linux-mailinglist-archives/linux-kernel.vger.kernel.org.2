Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CA736A454
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 05:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhDYDJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 23:09:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52730 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYDJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 23:09:00 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 91D62ED;
        Sun, 25 Apr 2021 05:08:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1619320099;
        bh=Qq0p0ICsIakO1oWz+z9LSXPUEEHiuJO/sMFZGcF6bp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRuyb5ZkFtsN+VybuQVzRXsnVkHQ7QL1rA8bSlwfaCYs/T0KNS6duQ90jmgpMVcQ3
         Foz7x+UXNlBwll93tMfa5k1xdl0/JZS5+UlRo6enb1jnhG/xFpNO1d22WB7JRRHWyK
         7uADCTMLtBMS6c1b4/a9Pp2iutu5SGbBe9RqPZE8=
Date:   Sun, 25 Apr 2021 06:08:14 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] usb: gadget: Drop unnecessary NULL checks after
 container_of
Message-ID: <YITdHl3vb5qiCHPC@pendragon.ideasonboard.com>
References: <20210424145443.170413-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210424145443.170413-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thank you for the patch.

On Sat, Apr 24, 2021 at 07:54:43AM -0700, Guenter Roeck wrote:
> The parameters passed to allow_link and drop_link functions are never NULL.
> That means the result of container_of() on those parameters is also
> never NULL, even though the reference into the structure points to the
> first element of the structure. Remove the unnecessary NULL checks.
> 
> This change was made automatically with the following Coccinelle script.
> A now obsolete 'out:' label was removed manually.
> 
> @@
> type t;
> identifier v;
> statement s;
> @@
> 
> <+...
> (
>   t v = container_of(...);
> |
>   v = container_of(...);
> )
>   ...
>   when != v
> - if (\( !v \| v == NULL \) ) s
> ...+>
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2: Dropped RFC, added Acked-by:, dropped now obsolete 'out:' label
> 
>  drivers/usb/gadget/function/uvc_configfs.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
> index 00fb58e50a15..7775f9902360 100644
> --- a/drivers/usb/gadget/function/uvc_configfs.c
> +++ b/drivers/usb/gadget/function/uvc_configfs.c
> @@ -914,8 +914,6 @@ static int uvcg_streaming_header_allow_link(struct config_item *src,
>  
>  	target_fmt = container_of(to_config_group(target), struct uvcg_format,
>  				  group);
> -	if (!target_fmt)
> -		goto out;
>  
>  	uvcg_format_set_indices(to_config_group(target));
>  
> @@ -955,8 +953,6 @@ static void uvcg_streaming_header_drop_link(struct config_item *src,
>  	mutex_lock(&opts->lock);
>  	target_fmt = container_of(to_config_group(target), struct uvcg_format,
>  				  group);
> -	if (!target_fmt)
> -		goto out;
>  
>  	list_for_each_entry_safe(format_ptr, tmp, &src_hdr->formats, entry)
>  		if (format_ptr->fmt == target_fmt) {
> @@ -968,7 +964,6 @@ static void uvcg_streaming_header_drop_link(struct config_item *src,
>  
>  	--target_fmt->linked;
>  
> -out:
>  	mutex_unlock(&opts->lock);
>  	mutex_unlock(su_mutex);
>  }

-- 
Regards,

Laurent Pinchart
