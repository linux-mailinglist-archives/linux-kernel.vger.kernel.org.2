Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036943FB253
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhH3IRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhH3IRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:17:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F8DC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:16:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so20367524edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4V8zQGj1Gqf1F2tUDyAxGYR3CqJxPsTeRp5ZOBqSIDQ=;
        b=TuRY2sKW4BSfhJDjqVGbNRktK9LKQd2XLWSD40j4bkwxZWVIoWgb227dKGlbXTtTY5
         AEV0TuIGQPvrFZ6iy4MYEhgyGjzIMrilibmAUyqrwhDs4+AVxXMienXkDEGlpbaRnTFh
         hTFf9cDd5j+dozZN/drbUiSS0HawPZce23FDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4V8zQGj1Gqf1F2tUDyAxGYR3CqJxPsTeRp5ZOBqSIDQ=;
        b=Ykh0XiQ6x8hN50mlFUfEngwyG7nfvVDA9wcYijEnaknP2yrRsGeYpj2RvjN9v55uYv
         JGsRTKe7wB3pcoj0duv8O62F8vBsAjrvAzW8Zd4QcTg/AIswqjoKnPoDgIQQ3pMYCaET
         sOOl+irQBGdupeahJH0RxNGLa1krIci+R2nwEf2TD1/I9TGFfrfxBfj0h/DwYMurQNha
         lK485FGFYHjkDII1wu8hyEZVA6pD+IctJoRRYEsnOV/szvN+ObmalFymQrKo6G4gJlPH
         llRlnctq2P/QvRWqgtmlm1f9CHzhhH0zlNgQTkrgLs3lMurnX1Hm81ilxa/owozQReNM
         syaw==
X-Gm-Message-State: AOAM531cy8qSbZwr5KbdwT02C8iiHULpw+gFodpV8VYkdVV2nK6JkuyA
        kBdbvFV9/GPiVW+oW6IAZ7ckvg==
X-Google-Smtp-Source: ABdhPJzrm65vrU6FbeDHBqEE0r78ZCI76NdXsgPcErghrJZM0wZPOGz21FvSxt91jZIRA0bIPWz8rg==
X-Received: by 2002:a50:998f:: with SMTP id m15mr22603150edb.193.1630311385540;
        Mon, 30 Aug 2021 01:16:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q5sm7275049edt.50.2021.08.30.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 01:16:25 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:16:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     tcs.kernel@gmail.com
Cc:     daniel.vetter@ffwll.ch, willy@infradead.org,
        george.kennedy@oracle.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        penguin-kernel@i-love.sakura.ne.jp,
        Haimin Zhang <tcs_kernel@tencent.com>
Subject: Re: [PATCH V4] fbcon: fix fbcon out-of-bounds write in sys_imageblit
Message-ID: <YSyTzlUEhrxD7rU4@phenom.ffwll.local>
Mail-Followup-To: tcs.kernel@gmail.com, willy@infradead.org,
        george.kennedy@oracle.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        penguin-kernel@i-love.sakura.ne.jp,
        Haimin Zhang <tcs_kernel@tencent.com>
References: <1630294223-7225-1-git-send-email-tcs_kernel@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630294223-7225-1-git-send-email-tcs_kernel@tencent.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:30:23AM +0800, tcs.kernel@gmail.com wrote:
> From: Haimin Zhang <tcs_kernel@tencent.com>
> 
> yres and vyres can be controlled by user mode parameters, and cause
> p->vrows to become a negative value. While this value be passed to real_y
> function, the ypos will be out of screen range.This is an out-of-bounds
> write bug.
> some driver will check xres and yres in fb_check_var callback,but some not
> so we add a common check after that callback.
> 
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

Does this fix a syzbot crash or how was this discovered?
-Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 1c85514..5599372 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1013,6 +1013,10 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
>  	if (ret)
>  		return ret;
>  
> +	/* virtual resolution cannot be smaller than visible resolution. */
> +	if (var->yres_virtual < var->yres || var->xres_virtual < var->xres)
> +		return -EINVAL;
> +
>  	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
>  		return 0;
>  
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
