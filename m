Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ABB3654A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhDTIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhDTIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:54:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0807C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:53:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g5so50376094ejx.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vfvESN/gBp6lSDsc53ylG47pXzs7CkRT+8vTU5ER8fE=;
        b=UVt3Jj+giddEw1gXzvvJgW7GH2rByotrzjsklb3TMUhTakV6N9PIyk8XwIMDRXdCwe
         4bT8kJ8t3ClZYZLyYZxAIvAdGx1RObZlIeHOj5LMS5ydh3mipINJjX0euIENiUBv3Nsx
         onodR7A4PMIZJ/Xdaq3xHvVKK+z3BcrI3sg+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=vfvESN/gBp6lSDsc53ylG47pXzs7CkRT+8vTU5ER8fE=;
        b=Z+K2+qLNQ03SUGC991Cgs7I1wOx3W/RUt//yIKRm92kQ+yN1gBPTS+Fjv2R6vLgGZq
         h2q2gDYIrOzzPSb3zA/wTc/F5ULJLFX6f3yCbZsPudbPJ38LTBq89lFk5O+gb/Dw4z84
         0jSTzs5X9iJQ/Qcm/GmOEhKzuWltD3hMTcQZH8rDX+TVlj6TKD6+47J2BR41pNU8tY/H
         O209G5CROSEG2T2qN3j8CHmQWYfzrJFZCf4xs2urBPbK2HLoOH9ILaZ8P/hDNru1GysI
         yYoYvdgJo9wMnRpAlFbQVXlto3HsZJuJqxsnwvpHfJww8qu96KpvYBP0CHiZBwk/o3fx
         tPrg==
X-Gm-Message-State: AOAM530IaBP7+tzaFRHm5UVyPeAvYluKE1uBx86pURuUJhXeiQyZfeDR
        dw2/2o0H0xn6izFlRmrJ5GiEHA==
X-Google-Smtp-Source: ABdhPJyATYz5gFThajrn+vAZ03jRTZbYI/wOtEqW7s6k/cmJat7HnnMVoyPrPmMo5dE9s+QZv34IjQ==
X-Received: by 2002:a17:907:c0b:: with SMTP id ga11mr25987809ejc.545.1618908813188;
        Tue, 20 Apr 2021 01:53:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id lj21sm11937012ejb.74.2021.04.20.01.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 01:53:32 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:53:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 27/40] drm/ttm/ttm_device: Demote kernel-doc abuses
Message-ID: <YH6Wiuy/Vw1Et4Kn@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-28-lee.jones@linaro.org>
 <e5d30ac1-3037-0101-0e1a-9df6a8580c70@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5d30ac1-3037-0101-0e1a-9df6a8580c70@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:32:52PM +0200, Christian König wrote:
> Am 16.04.21 um 16:37 schrieb Lee Jones:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/gpu/drm/ttm/ttm_device.c:42: warning: Function parameter or member 'ttm_global_mutex' not described in 'DEFINE_MUTEX'
> >   drivers/gpu/drm/ttm/ttm_device.c:42: warning: expecting prototype for ttm_global_mutex(). Prototype was for DEFINE_MUTEX() instead
> >   drivers/gpu/drm/ttm/ttm_device.c:112: warning: Function parameter or member 'ctx' not described in 'ttm_global_swapout'
> >   drivers/gpu/drm/ttm/ttm_device.c:112: warning: Function parameter or member 'gfp_flags' not described in 'ttm_global_swapout'
> >   drivers/gpu/drm/ttm/ttm_device.c:112: warning: expecting prototype for A buffer object shrink method that tries to swap out the first(). Prototype was for ttm_global_swapout() instead
> > 
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

Can you pls also land all the patches you reviewed from Lee into
drm-misc-next? Just so they wont' get lost. Will all head in for 5.14.
-Daniel
> 
> > ---
> >   drivers/gpu/drm/ttm/ttm_device.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
> > index 9b787b3caeb50..a8bec8358350d 100644
> > --- a/drivers/gpu/drm/ttm/ttm_device.c
> > +++ b/drivers/gpu/drm/ttm/ttm_device.c
> > @@ -36,7 +36,7 @@
> >   #include "ttm_module.h"
> > -/**
> > +/*
> >    * ttm_global_mutex - protecting the global state
> >    */
> >   DEFINE_MUTEX(ttm_global_mutex);
> > @@ -104,7 +104,7 @@ static int ttm_global_init(void)
> >   	return ret;
> >   }
> > -/**
> > +/*
> >    * A buffer object shrink method that tries to swap out the first
> >    * buffer object on the global::swap_lru list.
> >    */
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
