Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830CC33736E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhCKNI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbhCKNIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:08:18 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCEEC061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:08:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so1812992wrz.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=qrZXdv7fA+TcxxTTrB5ztlGjFi4s6fIUC/dA2snL+J4=;
        b=H1Mx4eM+pBm8MyWuGXMOKHl3WtuARTV9DvGf+45bIvtmO0jV3xm/8C3F3IzIlvCuWB
         /sJU/QgidjO8Yc7gPPwK3BePumHRo34w09nStf7KTuFip2dqg6aQOUR8jnO1rK8qgpfd
         jV0YXuHYWNxUEr8ckF70BRM49DclZ2EjZg9RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=qrZXdv7fA+TcxxTTrB5ztlGjFi4s6fIUC/dA2snL+J4=;
        b=kmAPxAx9ck60SBE4oHqX6h0xN3BDyAGuOEEbcB8k2pA+N/5aQoEnoXT16ktnPMVwVg
         fXP4ro3x65HQnIsbvAxRdaBZTvRupqRG4KNee1liDnhsdi/2e9uuuE8KpP3z13dkgl05
         kt8QnpyI2U4jafrHjg0h5e88SrolPYO3jhVAqAsJFxRZe9cie+5qR9IKQlPY/UCZrKOp
         OUECUsNe+bgqunWmv2lYFUgF2Lmmzs2R1kz18gQvhRE6Nv0jHY4bU2mXFgol5tHQSSRf
         fsCgnugEh2rKQUrQxLFOljL/QP5MTkpVcOMwlO+RVF6GIz0pk9y62lA7m/VLtca7ePeU
         X2hQ==
X-Gm-Message-State: AOAM5321MRSuSUqq8FgdIe5TD7DSnkxOAMIKNMRtrQL1oQeTPUfnd6Sx
        Hayr7AGxcXdgowxxqEahwbSWwA==
X-Google-Smtp-Source: ABdhPJw/Fk5Unx0u9LEM2CG3q6jKm9fGk6h7EJuj5MzNUKYgO1OO/uCt2XtGHsu0Cdq/UlAXo2DtKg==
X-Received: by 2002:a5d:58e8:: with SMTP id f8mr8698775wrd.102.1615468097072;
        Thu, 11 Mar 2021 05:08:17 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j12sm3883091wrx.59.2021.03.11.05.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 05:08:16 -0800 (PST)
Date:   Thu, 11 Mar 2021 14:08:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 04/44] vgacon: comment on vga_rolled_over
Message-ID: <YEoWPoXq0Ob5+2yS@phenom.ffwll.local>
Mail-Followup-To: Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20210302062214.29627-1-jslaby@suse.cz>
 <20210302062214.29627-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302062214.29627-4-jslaby@suse.cz>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 07:21:34AM +0100, Jiri Slaby wrote:
> Long time ago, I figured out what this number is good for and documented
> that locally. But never submitted, so do it now.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

I think Greg volunteered to take care of these ... Also my brain is toast
and I'm not even close to ready to grok vc code to review this properly
:-/

Cheers, Daniel
> ---
>  drivers/video/console/vgacon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index 962c12be9774..0d26e821e73b 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -96,7 +96,7 @@ static bool 		vga_is_gfx;
>  static bool 		vga_512_chars;
>  static int 		vga_video_font_height;
>  static int 		vga_scan_lines		__read_mostly;
> -static unsigned int 	vga_rolled_over;
> +static unsigned int 	vga_rolled_over; /* last vc_origin offset before wrap */
>  
>  static bool vgacon_text_mode_force;
>  static bool vga_hardscroll_enabled;
> -- 
> 2.30.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
