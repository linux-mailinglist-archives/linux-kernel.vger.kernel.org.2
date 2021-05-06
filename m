Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F93753CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhEFM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhEFM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:27:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E363C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 05:26:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v12so5397496wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ifHkTWOlt0DCppHf0tpts48yR60EAMQ4VuIqqohHTk=;
        b=cIxAAr/UHi0mhTlZ2dvqpczrkI87aVz4IiHEjr3BX2ILV8dGTxwiRSMUSMLGjVeKfn
         NAzGDKYNfZbCBIlWEOOJPqj99nHbBs8ggFRYPuWMpejYj/R9296ANExKyDRutmJaWp3Y
         oZXAhiZVNBVPj2f3QbSjIYWAyIvBffmYfpnDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/ifHkTWOlt0DCppHf0tpts48yR60EAMQ4VuIqqohHTk=;
        b=flhEtmxE4xIAn8yGMmHBq47j4b6jPUWBkPkUlg+83sDTfatm+3/TCK4sgiU9tjobgE
         NvhkzfnQL0TjFvjLYFF79MLrKH/HB1R0s3RAtRKtaeQZ8WODFbf/gTGuq5euCpyvDuaI
         WoUV8LygnOQHkt5wlQOPztKyIUC1jk9kCZ2p11U80+5QBvKUdRjEV34+OaonM5Hm1Y3U
         gWmI/w4VGXMsNrur4spQOT95wSQ22KBEOdYGYjZ3cRoXYZFUdTIVXcZnB7bqzCAxqY6z
         BP9wiOWjCH5CcAjrsnQ4i4ZZEglwTbd90h7I5qmMu2MnvRPz++f7WXlCXuhmEoxLdJfr
         4TaQ==
X-Gm-Message-State: AOAM5313YiDECImPs4IgBcfUo0MWI8QF8qsMBpAjc/JabOSNfDtPMpg4
        tSr2z2mu+qdZCPQuCPeN1Svglg==
X-Google-Smtp-Source: ABdhPJzNckMKDFTCHdiXh/0znHW0NmpfbmlQAeOAP2a53r7g8zV70gcy6c0b66SMNORZaZ7dF7ZdKw==
X-Received: by 2002:a05:6000:110c:: with SMTP id z12mr4706973wrw.188.1620303972145;
        Thu, 06 May 2021 05:26:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l12sm4428819wrq.36.2021.05.06.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 05:26:11 -0700 (PDT)
Date:   Thu, 6 May 2021 14:26:09 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] drm/gma500: update comment of psb_spank()
Message-ID: <YJPgYaQfDwQF5iJz@phenom.ffwll.local>
Mail-Followup-To: Wan Jiabing <wanjiabing@vivo.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
References: <20210506112851.20315-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506112851.20315-1-wanjiabing@vivo.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 07:28:51PM +0800, Wan Jiabing wrote:
> In commit 5c209d8056b9 ("drm/gma500: psb_spank() doesn't need it's
> own file"), accel_2d.c was deleted and psb_spank() was moved into
> psb_drv.c. Fix the comment here.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Queued up for 5.14, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/gma500/psb_drv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
> index 49afa577d442..d6e7c2c2c947 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.h
> +++ b/drivers/gpu/drm/gma500/psb_drv.h
> @@ -646,7 +646,7 @@ extern u32 psb_get_vblank_counter(struct drm_crtc *crtc);
>  extern int psbfb_probed(struct drm_device *dev);
>  extern int psbfb_remove(struct drm_device *dev,
>  			struct drm_framebuffer *fb);
> -/* accel_2d.c */
> +/* psb_drv.c */
>  extern void psb_spank(struct drm_psb_private *dev_priv);
>  
>  /* psb_reset.c */
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
