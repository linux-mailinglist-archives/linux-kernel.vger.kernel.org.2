Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C46347638
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhCXKgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhCXKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:36:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B09C0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:36:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c8so10988539wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dEFFBRSXu0odutvmmG/Rwg2Sz2HimxEx+pN3ka/bnVc=;
        b=DOZKukNzPwBLODbuM7S0fhx3nEbU8wUrLkI+akr9xvK/Gn2cEkrVU5mSaLlohKzWUM
         IQkfJ4YQkOKMBazPQvbAWzdDFP3Pw6sQVJz5npSdYbHyY5D+97tiYkJ7sHJNebnH5qsm
         0tl9dSCS/MCcNsWpo95djxWqsO64QF8ensbtsRQ+wiq5hwJ8ZBDySd8GUAFJFBxdGmvR
         jEKykXmw1j4WN055zMGSRxaoUH0Mk1lSbDSTB67aaiipXHd9Df435ucMGT4YF0wFargI
         i/kPWeaegH1BvjP03zxQGdMBRdPYrgta44l0928G9W3U65Nais46ChTzh4NwrxzMpihp
         EVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dEFFBRSXu0odutvmmG/Rwg2Sz2HimxEx+pN3ka/bnVc=;
        b=dWPcCSEimvqRl8TVJHJYgKMjEUpgJPR883+olPmF83bljFW3tRLv3JCg9Vhdh1Ed/h
         pYnv2PZHvLrpcYbGEvkWlwhd/R8Zw31n/d7WbpRVxsJ67SYKwaEIGXvHmRAgNEz/ur7z
         ewcnPAfkgG6DHnToHO08B9KTB/KTHgQctiZQh2uDswO7B13+AUB1Vvhz9OqoV8PPUGDd
         TE/sZ/mID0qMslhgK569OWES602dUAgYCMwgyh7YIyfOMCeG47pFLmcqAppemkGKI5Aw
         +CF2GWc3LtdUcicllK2/rygYQX698nem+PKxiTt6uQ0MR/cczidz6J/rBVpsCVaA0fya
         IwPQ==
X-Gm-Message-State: AOAM530Curkg24bnLTvavyPK+YN3kPID0fkKmB6Z69llVOgZbxO6EFii
        O2HyfTGSoG5nx5OBrvprglOLXRZ13cHAkg==
X-Google-Smtp-Source: ABdhPJxI3r3iiWfvHOD+ErGz9Iu/oghrzTasZEnAeZqBD2lmagfmv90aTaU0jHjCwgR5t2MyzwXykw==
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr2725687wru.401.1616582174392;
        Wed, 24 Mar 2021 03:36:14 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id l6sm2070476wrn.3.2021.03.24.03.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 03:36:14 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:36:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Anthony Koo <Anthony.Koo@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Jeremy Kolb <jkolb@brandeis.edu>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Leo Li <sunpeng.li@amd.com>, linaro-mm-sig@lists.linaro.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        nouveau@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [RESEND 00/19] Rid GPU from W=1 warnings
Message-ID: <20210324103611.GJ2916463@dell>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This is a resend of the remaining patches.
> 
> All of these patches have been sent before.

Are you still keen to 'hoover these up'?

Just leave the one that requires work and take the rest perhaps?

> Lee Jones (19):
>   drm/nouveau/nvkm/subdev/bios/init: Demote obvious abuse of kernel-doc
>   drm/nouveau/dispnv50/disp: Remove unused variable 'ret'
>   drm/msm/dp/dp_display: Remove unused variable 'hpd'
>   include: drm: drm_atomic: Make use of 'new_plane_state'
>   drm/nouveau/nvkm/subdev/volt/gk20a: Demote non-conformant kernel-doc
>     headers
>   drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the
>     stack to the heap
>   drm/amd/display/dc/calcs/dce_calcs: Remove some large variables from
>     the stack
>   drm/amd/display/dc/dce80/dce80_resource: Make local functions static
>   drm/nouveau/nvkm/engine/gr/gf100: Demote non-conformant kernel-doc
>     header
>   drm/nouveau/nouveau_bo: Remove unused variables 'dev'
>   drm/nouveau/nouveau_display: Remove set but unused variable 'width'
>   drm/nouveau/dispnv04/crtc: Demote non-conforming kernel-doc headers
>   drm/nouveau/dispnv50/disp: Remove unused variable 'ret' from function
>     returning void
>   drm/nouveau/dispnv50/headc57d: Make local function 'headc57d_olut'
>     static
>   drm/nouveau/nv50_display: Remove superfluous prototype for local
>     static functions
>   drm/nouveau/dispnv50/disp: Include header containing our prototypes
>   drm/nouveau/nouveau_ioc32: File headers are not good candidates for
>     kernel-doc
>   drm/nouveau/nouveau_svm: Remove unused variable 'ret' from void
>     function
>   drm/nouveau/nouveau_ioc32: Demote kernel-doc abuse to standard comment
>     block
> 
>  .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 1154 +++++++++--------
>  .../drm/amd/display/dc/dce80/dce80_resource.c |   16 +-
>  drivers/gpu/drm/msm/dp/dp_display.c           |    3 -
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c       |    4 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c       |   10 +-
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c   |    2 +-
>  drivers/gpu/drm/nouveau/nouveau_bo.c          |    4 -
>  drivers/gpu/drm/nouveau/nouveau_display.c     |    8 +-
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c       |    4 +-
>  drivers/gpu/drm/nouveau/nouveau_svm.c         |    5 +-
>  drivers/gpu/drm/nouveau/nv50_display.h        |    3 -
>  .../gpu/drm/nouveau/nvkm/engine/gr/gf100.c    |    2 +-
>  .../gpu/drm/nouveau/nvkm/subdev/bios/init.c   |  204 +--
>  .../gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c  |    4 +-
>  include/drm/drm_atomic.h                      |    3 +-
>  15 files changed, 692 insertions(+), 734 deletions(-)
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Jeremy Kolb <jkolb@brandeis.edu>
> Cc: Kuogee Hsieh <khsieh@codeaurora.org>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: nouveau@lists.freedesktop.org
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
