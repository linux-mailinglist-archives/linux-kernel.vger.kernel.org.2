Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CE135814B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhDHLGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhDHLGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:06:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986ACC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 04:06:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y124-20020a1c32820000b029010c93864955so2687768wmy.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=p0vtgOvE8iFrrW+FYLV4+rHA4rgvxJ8gg28Kh71P4qc=;
        b=kiFArAnZyBqtytpQIkNm5rEsRYCs5r6j4ZfOrS3OLJ7Tsux0s/Q/LgL6AVo3mxzz6o
         gvYQqRO5G6JmpJS32Uzi3tXm5SY3MDyT8UFiZRd9wuZknp3ajr3sDNUp5RIEsxptUe4M
         /HV33tb8kvUQXz+gyDd2XWUBnpuryuXCNmjGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=p0vtgOvE8iFrrW+FYLV4+rHA4rgvxJ8gg28Kh71P4qc=;
        b=Gv0bMT3fPMAFL/WW//wVxuEAidvmRzfUDrxxTzVQfLud9FpjIsSZEJrQSkH8zfoi7p
         AggtAVIr0Ot9LjJ8iWuN//tu08KoDFe+RDOk2EL5AR8Ww5HcrNan861ERIInUR1IJYTI
         VRHd/WAX1eLeSo8CxBIw4rO2SG7Jn4tA+VfqCvCdW3Tj5ypeTW+VO1qoL1wZqcKPZMED
         Fo0BPW0/6kVXvfyHGtQaT3pDcG0N3da3pJYDFbB6tywYUxYacWnBus4jpjf7AyF1zPKR
         2+V0oKkRxyq+bmNXuXlsS0t2lmvBx7ODhaUIN3bzY5UVCSoFEe/v3LVhOkD1NuKT9hMj
         kXTQ==
X-Gm-Message-State: AOAM530NRXxGEPFEjThSKjtopM7tHiOJfiTLwzFxeHJlk3X2X7QUBvcg
        I83Ds5HvUK0Y8FzIU3RY9d0x8A==
X-Google-Smtp-Source: ABdhPJwgyQbYDJJ03aWo7qFX343DdQllaEQEIJhPy+tbRI5+2U3016msP4YmDClhO/2MUePG8sheWg==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr7815815wmc.106.1617879976185;
        Thu, 08 Apr 2021 04:06:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y31sm2907091wmp.46.2021.04.08.04.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:06:15 -0700 (PDT)
Date:   Thu, 8 Apr 2021 13:06:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] drm/drm_internal.h: Remove repeated struct declaration
Message-ID: <YG7jpSjGcCmMdoP7@phenom.ffwll.local>
Mail-Followup-To: Wan Jiabing <wanjiabing@vivo.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
References: <20210401081704.1000863-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401081704.1000863-1-wanjiabing@vivo.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 04:17:03PM +0800, Wan Jiabing wrote:
> struct drm_gem_object is declared twice. One is declared
> at 40th line. The blew one is not needed. Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Pushed to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_internal.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index fad2249ee67b..1265de2b9d90 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -170,7 +170,6 @@ void drm_sysfs_connector_remove(struct drm_connector *connector);
>  void drm_sysfs_lease_event(struct drm_device *dev);
>  
>  /* drm_gem.c */
> -struct drm_gem_object;
>  int drm_gem_init(struct drm_device *dev);
>  int drm_gem_handle_create_tail(struct drm_file *file_priv,
>  			       struct drm_gem_object *obj,
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
