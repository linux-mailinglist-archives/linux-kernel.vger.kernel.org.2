Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2718C403F23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349931AbhIHSfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhIHSfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:35:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE43C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 11:34:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id x11so6177199ejv.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tu/avCrn+ABQ6q0ueHilploaye/4nQZBWOnrswc2jNo=;
        b=MH0XO9DXrxj0YkPGtwDjfBI/TJeUEMsQqtbJI/xUyK9pcQTu1C9kv9cHGT2LZbZe7O
         NkFeYDgFHmgFUFEC5+5AskYhR3F4fMF5ikXDRXgbxERQbBC+E0H//h8K7KpZOjPAlm45
         Rxog2BlbgJRFgHdBotqzInmOTfRBW/iHUDnyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Tu/avCrn+ABQ6q0ueHilploaye/4nQZBWOnrswc2jNo=;
        b=NpgRtNQFEZ+lnqK1F6rD0PriNj0d1Ql3PyPiixE5NdJlItswl8S00YbYJS2W7jufO/
         dw4UXnG5PO5ty5bki7meLMrGQBxguYiKWDstbPR1suxru6/kHyyulqSK46Z3NAakPPvf
         6oUKf33dd9aDL3MVi7K9+ZxTvOjVX3BzwXHmxzo0z0WxuFGvPCTTOJ25g6g07BnQGNGc
         S2RqY1gExanloP0S64o4tc9RRzLcLFt7e7QoIy96fLZ38/d3/S9nBc2nabC7aewLQ/PK
         hL4R8LhQn2MCHe4hfQwEbrGICuUXY9IO5awDgRfA8fG6yxSEj/t+ARYsqqr6x2k+2bOj
         i7yw==
X-Gm-Message-State: AOAM531Rz+64Xkv3OPxdKoOKbFnKvNyOQNyDqoWEmBSNludSKYi3HDKn
        XtRAWKrvrZPfei0BB6vBtM12+w==
X-Google-Smtp-Source: ABdhPJwkQoTc7Lc/Jrnzkglj0t5YKCXtw09Pauu38dAvqHRCY8GWNetApF9YVGATFyy2VPLSMPZbRw==
X-Received: by 2002:a17:906:3498:: with SMTP id g24mr1363825ejb.490.1631126082090;
        Wed, 08 Sep 2021 11:34:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b13sm1702286ede.97.2021.09.08.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:34:41 -0700 (PDT)
Date:   Wed, 8 Sep 2021 20:34:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/plane-helper: fix uninitialized variable reference
Message-ID: <YTkCQCPwZPbhMfeF@phenom.ffwll.local>
Mail-Followup-To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20210907140836.323149-1-alex_y_xu.ref@yahoo.ca>
 <20210907140836.323149-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907140836.323149-1-alex_y_xu@yahoo.ca>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 10:08:36AM -0400, Alex Xu (Hello71) wrote:
> drivers/gpu/drm/drm_plane_helper.c: In function 'drm_primary_helper_update':
> drivers/gpu/drm/drm_plane_helper.c:113:32: error: 'visible' is used uninitialized [-Werror=uninitialized]
>   113 |         struct drm_plane_state plane_state = {
>       |                                ^~~~~~~~~~~
> drivers/gpu/drm/drm_plane_helper.c:178:14: note: 'visible' was declared here
>   178 |         bool visible;
>       |              ^~~~~~~
> cc1: all warnings being treated as errors
> 
> visible is an output, not an input. in practice this use might turn out
> OK but it's still UB.
> 
> Fixes: df86af9133 ("drm/plane-helper: Add drm_plane_helper_check_state()")

I need a signed-off-by from you before I can merge this. See

https://dri.freedesktop.org/docs/drm/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Patch lgtm otherwise.
-Daniel

> ---
>  drivers/gpu/drm/drm_plane_helper.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane_helper.c b/drivers/gpu/drm/drm_plane_helper.c
> index 5b2d0ca03705..838b32b70bce 100644
> --- a/drivers/gpu/drm/drm_plane_helper.c
> +++ b/drivers/gpu/drm/drm_plane_helper.c
> @@ -123,7 +123,6 @@ static int drm_plane_helper_check_update(struct drm_plane *plane,
>  		.crtc_w = drm_rect_width(dst),
>  		.crtc_h = drm_rect_height(dst),
>  		.rotation = rotation,
> -		.visible = *visible,
>  	};
>  	struct drm_crtc_state crtc_state = {
>  		.crtc = crtc,
> -- 
> 2.33.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
