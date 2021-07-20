Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791623CFA20
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbhGTM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbhGTM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:27:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0CFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:08:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m2so25972102wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uvHTohQOXUo1eNzTbptDnQ980SKchLpYfyQkug8oLsM=;
        b=FZ7B87n7ZKH5WlwYufOcG72EJmbAaUBUE4aFuEpuEsqmjOIyRz6/XyFpVO7exRf5Wb
         dyZrHG+WOrHkEo9owvwnpXCrJcTd7X4Frz4ddtsdLCY2qk9tlFUBWk94lopmcQM3+zt6
         BjfmggyN4mvYvqpXEhBlTfCVoea5a0qDcd/Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uvHTohQOXUo1eNzTbptDnQ980SKchLpYfyQkug8oLsM=;
        b=DATgLP4z+loxrsTZ2eP4XjdASWttugSD0xUGzG2cgqPN1QB/nOXUttYRqxVi75+06i
         SAtKHOjai5H9kys7xHwtMqmMiKTduLxfN6hQHCbZxmwYP/hFzd1TjgYyuDn3xIzdqyoi
         FvZaF025sCUc+OcxJ4xaVce1YVBX1bt96V9i9FNoaWNup5tH2Fyvd70E71FzTX4aLh42
         /tHN5bq0+8Q/284vU2aQUg09u60z9u0HvGFDWUm4jUOsZf+bR9flFJmQ1QY9Bngl2hHF
         dURRYd4EEi4SLel8ak8TrE8lgjFzs3dUsXFdQCq8SvDazuDcKFM7CsPpXevXzgY1hHkG
         WYvQ==
X-Gm-Message-State: AOAM530CoPTK91ZxuzBVw0dqdOANG7mX0jQNt8t7dN1pxXC5qoWhOXQL
        OGXGoqDkebTu6eVRAu+wGVjgTA==
X-Google-Smtp-Source: ABdhPJyUbagFa2jJYY8PhdxQ3iWQEkYXCDmIYQQXB8xNIPSArbgllu0G7MR5Pi9l2jz7RgWOZA4nAw==
X-Received: by 2002:a05:6000:2a1:: with SMTP id l1mr35043388wry.128.1626786493358;
        Tue, 20 Jul 2021 06:08:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r17sm2423906wmq.13.2021.07.20.06.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:08:12 -0700 (PDT)
Date:   Tue, 20 Jul 2021 15:08:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jbaron@akamai.com
Subject: Re: [PATCH v3 1/5] drm/print: fixup spelling in a comment
Message-ID: <YPbKukQVbHt1Yuin@phenom.ffwll.local>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jbaron@akamai.com
References: <20210714175138.319514-1-jim.cromie@gmail.com>
 <20210714175138.319514-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714175138.319514-2-jim.cromie@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 11:51:34AM -0600, Jim Cromie wrote:
> s/prink/printk/ - no functional changes
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  include/drm/drm_print.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 9b66be54dd16..15a089a87c22 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -327,7 +327,7 @@ static inline bool drm_debug_enabled(enum drm_debug_category category)
>  /*
>   * struct device based logging
>   *
> - * Prefer drm_device based logging over device or prink based logging.
> + * Prefer drm_device based logging over device or printk based logging.
>   */
>  
>  __printf(3, 4)
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
