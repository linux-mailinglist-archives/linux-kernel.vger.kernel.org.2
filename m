Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28253977B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhFAQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhFAQOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:14:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE2AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:12:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n2so15009098wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=RTKTEbmxtrsch+/FsTbSgaDR8cW8alqmoHnBJyVa4fU=;
        b=lEZEUX5YalH9qYDfjGWOEnJ+BJcEuS86aYL1qvWP0Uzx9RQMDdbmAGFeRsqHj/0drU
         oR/RmpxVZVrrBiIhhAWzw0Xcc0pUEw2sBg+5959EvGva3BM2wkqf+hj2Ta9Gk8cFjgs5
         v+Huo5Hj1n3Qun+7hxdey42iUoGPBh0uBvjBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=RTKTEbmxtrsch+/FsTbSgaDR8cW8alqmoHnBJyVa4fU=;
        b=DblSOJbcc507NaOdy/fKkHaYR1yxTj212kchaeQJ1Ald03TTh4Fb8JWjZtshQmvlq0
         rC4OROnlfFlMB43F3UKumh9o3PD6/UG2ROh0SnlhkY6k9RroG/fuN1YzPJnfc3T+8+FX
         zNXJanLLok8C//Y1DYEdY2oVdGSSBzhxMwk1SvCbfBKiXlosKMvf6CwC+UyAY8en6yU0
         TRzrSJI7tQ4qNttLiVmQWTEg1W/ZrHVYEtFtwDfz+2KiCrLcVC/rfIKksD/GZiLF0u8D
         WHiOWFtJxuS4oxNVZmC9wPfHGLD6AkLqBEdpD2JfFD5igNCAj0s7Sqg81eK+i7Z27gcw
         FIkQ==
X-Gm-Message-State: AOAM532QtCKlwjtNWSPyL61Q2+F3H7Y2HYdYb+EHZZIpRps9ErOyKUMq
        f60pZF/fOuJiNSBXnWTTCQkaxQ==
X-Google-Smtp-Source: ABdhPJx9NQM2M7DacpouqiStB2xAgVGDNmo/q2e0z44Mn/8CYlaQzcPV4AL2zZj7Yo2r8a+tqzNMmg==
X-Received: by 2002:adf:f990:: with SMTP id f16mr3658485wrr.340.1622563976810;
        Tue, 01 Jun 2021 09:12:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w8sm3948891wre.70.2021.06.01.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:12:56 -0700 (PDT)
Date:   Tue, 1 Jun 2021 18:12:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        list@opendingux.net,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH] drm: Fix misleading documentation of drm_gem_cma_create()
Message-ID: <YLZchmKujXJoyp1y@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20210601095405.8975-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601095405.8975-1-paul@crapouillou.net>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:54:05AM +0100, Paul Cercueil wrote:
> The backing memory does not necessarily have the writecombine attribute
> set, since commit cf8ccbc72d61 ("drm: Add support for GEM buffers backed
> by non-coherent memory").
> 
> Fixes: cf8ccbc72d61 ("drm: Add support for GEM buffers backed by non-coherent memory")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_gem_cma_helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index 4a24af2c5c43..d53388199f34 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -104,8 +104,7 @@ __drm_gem_cma_create(struct drm_device *drm, size_t size, bool private)
>   * @size: size of the object to allocate
>   *
>   * This function creates a CMA GEM object and allocates a contiguous chunk of
> - * memory as backing store. The backing memory has the writecombine attribute
> - * set.
> + * memory as backing store.
>   *
>   * Returns:
>   * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative
> -- 
> 2.30.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
