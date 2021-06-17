Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140183ABACC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhFQRqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhFQRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:46:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C58C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:44:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so6949324wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0gu9khqafYbRngyKiTFSC+bYHLyhKbFlrZ0UOe7U7qE=;
        b=TtQWcNMpgBza9QW4TQTgS7qaug29DGNm1h5of6PDbO5NKu/566NDNLdiXFPjsk/tPn
         5MQuis9g9zgNew6kPlb2UPtbpgxrY/g+J+IygEQrlm/xIfJCIS9VtJivuDmk2/k1kvtr
         T6jJmg1SmjBCk9i6QpHnkerzC5uA+d5z+NOdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0gu9khqafYbRngyKiTFSC+bYHLyhKbFlrZ0UOe7U7qE=;
        b=KLguKaM/OSZWABJvdYBBY8nb6HUrrn3xCLFkDRac1ux4rzSzHeOQaV55I0QWeeM2EW
         O6PhmpWXjGAYvk6lzR68mrxOYgM1D/Eu+g5v9fRZDC1mYPj0Cm475CNtXesJOgGEUVbg
         d2rB2/L++tBCq46Ial4Q8F/wn7EyCH9h5PBCF//fyhN9/uxuI+SCVfDpgmixp2/+1b4s
         2vk8mKcAD9Omx3pwpYEULte4HMzivj1y8TAUcXiGIrDiuUDOTSLKKDBWfjOWmvE8EglU
         /4etR/1bq3k8ioCGz8djwnM4U6G64HB7VmrAZQMn6bIZuNxiJg/ReP3v/hzpKi9c0LNg
         auAw==
X-Gm-Message-State: AOAM533GGKloGZL4P71ZQPHesv+yQU0/KYodZDzEe7O/kJAaUDhval6K
        yftDYQ1VoRahniHCqmVsZHDbwg==
X-Google-Smtp-Source: ABdhPJyTvxlyO/vdBn2yGT4wglYu6U9uOEjCwb9SQTK3XbdJmVJMN8xZehNwz7qHud6fuzXVGMfreA==
X-Received: by 2002:a7b:c110:: with SMTP id w16mr6685991wmi.4.1623951874860;
        Thu, 17 Jun 2021 10:44:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9sm5506437wmq.14.2021.06.17.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:44:34 -0700 (PDT)
Date:   Thu, 17 Jun 2021 19:44:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Fix duplicate included intel_region_lmem.h
Message-ID: <YMuKAHhaYOaLP8JL@phenom.ffwll.local>
Mail-Followup-To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1623823318-6759-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623823318-6759-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 02:01:58PM +0800, Jiapeng Chong wrote:
> Clean up the following includecheck warning:
> 
> ./drivers/gpu/drm/i915/gt/intel_region_lmem.c: intel_region_lmem.h is
> included more than once.
> 
> No functional change.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Already merged another one of these:

commit 6796c772850574ec0a9adc977e9889606b23d0f4 (HEAD -> drm-intel-gt-next, drm-intel/drm-intel-gt-next)
Author: Wan Jiabing <wanjiabing@vivo.com>
Date:   Tue Jun 15 19:35:20 2021 +0800

    drm/i915: Remove duplicate include of intel_region_lmem.h

Thanks anyway.

Cheers, Daniel

> ---
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> index f7366b0..aa3cfca 100644
> --- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> +++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> @@ -5,7 +5,6 @@
>  
>  #include "i915_drv.h"
>  #include "intel_memory_region.h"
> -#include "intel_region_lmem.h"
>  #include "intel_region_ttm.h"
>  #include "gem/i915_gem_lmem.h"
>  #include "gem/i915_gem_region.h"
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
