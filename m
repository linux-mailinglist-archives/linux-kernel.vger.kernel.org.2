Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C69C358177
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhDHLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhDHLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:15:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A27C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 04:15:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so1711495wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AcAFUqp6UAoctTPigHac0GLdbrDMBzvgfm1w3MAPCVc=;
        b=gGVo0KdtGQFzn+gxvhAI7/mbF2A4l4VfZBwtPQU6K9eV3ca1vm5pLoji6HAfVncZrs
         1LLFVDeqlQleRFCHV19mRzY0GQCTbs4IrhypdEy/VGbI001vRiAYAJ/jqzBOz251K1Zl
         4PeICtkXuYO/XR2Hil7Uer17XqYYN7+RcIUEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AcAFUqp6UAoctTPigHac0GLdbrDMBzvgfm1w3MAPCVc=;
        b=pUtfdBKOQ7o+17RWNe2sOWceoLfN9GM36HaCTrSWjBDCLJGSclJjbUk32Ea0fsDinb
         iMUJn0fkJZ3YBRIAU3Q6Z6la86Ac6EGY9Kzbpet/F99BbIbXxGxJEsZVG+Nt4FTeN14X
         3uaCG5qRssW5wzocgw/61y4V0KSRfQLBLKydvSXF6LlzsRkdnw9NUcsFHxhdDCQBDj7A
         sviJJ3b25+hCMvuzCFYSbCX6Y3LUyJbR86tjb2hAMqIvNOWBRtHkjFMjY+fOLwM/MMdO
         S+J3YfMg6V3tnJr8fR2ryFwt+PyYrxvjm5etqJacO07fYjCeIjq4+zkBn8WSc6PPUDcY
         xE0w==
X-Gm-Message-State: AOAM530EqKv0choz9oCBGarGSmUJSXHQRtTMtLJ3WfFkvsyooLaIGHkJ
        GfgYAQRAsHXl39T6yQt0dVc5sg==
X-Google-Smtp-Source: ABdhPJxsrvJEP26+VkzvzCqzDNRxmHcvrkr2wjLdHOCmOy+nZZfHQ5wDk3KDW5f115ZZy75z4/ZORA==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr10713632wru.0.1617880530387;
        Thu, 08 Apr 2021 04:15:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o2sm18376833wry.4.2021.04.08.04.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:15:29 -0700 (PDT)
Date:   Thu, 8 Apr 2021 13:15:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
Subject: Re: [PATCH 0/8] drm/msm: Swappable GEM objects
Message-ID: <YG7l0LwVQ2s4Y0Sa@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>
References: <20210405174532.1441497-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405174532.1441497-1-robdclark@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 10:45:23AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> One would normally hope not to be under enough memory pressure to need
> to swap GEM objects to disk backed swap.  But memory backed zram swap
> (as enabled on chromebooks, for example) can actually be quite fast
> and useful on devices with less RAM.  On a 4GB device, opening up ~4
> memory intensive web pages (in separate windows rather than tabs, to try
> and prevent tab discard), I see ~500MB worth of GEM objects, of which
> maybe only 10% are active at any time, and with unpin/evict enabled,
> only about half resident (which is a number that gets much lower if you
> simulate extreme memory pressure).  Assuming a 2:1 compression ratio (I
> see a bit higher in practice, but cannot isolate swapped out GEM pages
> vs other), that is like having an extra 100+MB of RAM, or more under
> higher memory pressure.
> 
> Rob Clark (8):
>   drm/msm: ratelimit GEM related WARN_ON()s
>   drm/msm: Reorganize msm_gem_shrinker_scan()
>   drm/msm: Clear msm_obj->sgt in put_pages()
>   drm/msm: Split iova purge and close
>   drm/msm: Add $debugfs/gem stats on resident objects
>   drm/msm: Track potentially evictable objects
>   drm/msm: Small msm_gem_purge() fix
>   drm/msm: Support evicting GEM objects to swap

Given how much entertainement shrinkers are, should we aim for more common
code here?

Christian has tons of fun with adding something like this for ttm (well
different shades of grey). i915 is going to adopt ttm, at least for
discrete.

The locking is also an utter pain, and msm seems to still live a lot in
its own land here. I think as much as possible a standard approach here
would be really good, ideally maybe as building blocks shared between ttm
and gem-shmem drivers ...
-Daniel

> 
>  drivers/gpu/drm/msm/msm_drv.c          |   2 +-
>  drivers/gpu/drm/msm/msm_drv.h          |  13 ++-
>  drivers/gpu/drm/msm/msm_gem.c          | 155 +++++++++++++++++--------
>  drivers/gpu/drm/msm/msm_gem.h          |  68 +++++++++--
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 129 ++++++++++++--------
>  drivers/gpu/drm/msm/msm_gpu_trace.h    |  13 +++
>  6 files changed, 272 insertions(+), 108 deletions(-)
> 
> -- 
> 2.30.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
