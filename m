Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942943CFBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhGTNfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbhGTN1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:27:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC818C0613DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:07:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso2141196wmm.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NhiaQkSCHPQx+ne2ETdlu6yODY4PxPdrO6TLTCHDEvo=;
        b=AbV7T8HvSTYfx7yF5o/wHZ6AbP9cbbnHR6simTxT5F2QgalLEh3Zv7zaCsj+iLKyB+
         Pj86CpN7A4sNSRwvVjPdfaX8QWev0o9Y3SuETieOM3yAYO1hPR17h/6YHdLKCBfpYqOq
         0xanI2HXzwfifg0mxPZDCYmHVwhR3CiSIXtXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=NhiaQkSCHPQx+ne2ETdlu6yODY4PxPdrO6TLTCHDEvo=;
        b=T2YsvPq5IqcFOhiqDv9ViimVhs2+BCILTFitzraF+kZk6/0fSSIa/iQjnIvCogUwBL
         ogGrXEfee82Jtq6aqnIIZ2vS7KrSE4KqO6By5UtYjXT95ELeyBVx7q3/CzW4Cnd8GXJK
         kROI+8U2nHtxwnylC0dE04VGCdyQMngYSxgU80iJWsrXfX332JFiLXTUgZAUQtpCLoP3
         oi83fAzlLaMHsQ7CBsR7Tj08j2fhqve/xNlNArmiAke8oex0rBtcy3cfTR+uF3WXlLMS
         HQJE289P3PJqwS8X8fHJG77tSEE+rWSA4Vczq3F6SXplxt7wws1vdofsoJECYuFWUIUR
         lfig==
X-Gm-Message-State: AOAM532blomX5x8tZ6W7FbmdFcuhGAfsCdhFEJqVba1POeCEG7n6Z4T7
        ePgMtwzuS9IevqU6Fk7dqxlruQ==
X-Google-Smtp-Source: ABdhPJympAVWx+89WOJs70xZyzGidYkvS7+zE+nPVH5Jqu38ByIK/jJxawzGearAHIs1mQR4Vm9qng==
X-Received: by 2002:a05:600c:20b:: with SMTP id 11mr39063501wmi.112.1626790048280;
        Tue, 20 Jul 2021 07:07:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s17sm24408502wrv.2.2021.07.20.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:07:26 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:07:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        freedreno@lists.freedesktop.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Emma Anholt <emma@anholt.net>, Bernard Zhao <bernard@vivo.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lee Jones <lee.jones@linaro.org>,
        Dave Airlie <airlied@redhat.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [Linaro-mm-sig] [PATCH 00/11] drm/msm: drm scheduler conversion
 and cleanups
Message-ID: <YPbYnLBin9N4weiC@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>, freedreno@lists.freedesktop.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Emma Anholt <emma@anholt.net>,
        Bernard Zhao <bernard@vivo.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lee Jones <lee.jones@linaro.org>, Dave Airlie <airlied@redhat.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
References: <20210717202924.987514-1-robdclark@gmail.com>
 <582b8869-f370-3803-60a8-df31088f8088@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <582b8869-f370-3803-60a8-df31088f8088@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 10:40:57AM +0200, Christian König wrote:
> Am 17.07.21 um 22:29 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Conversion to gpu_scheduler, and bonus removal of
> > drm_gem_object_put_locked()
> 
> Oh yes please!
> 
> If I'm not completely mistaken that was the last puzzle piece missing to
> unify TTMs and GEMs refcount of objects.

Why does drm/msm, a driver not using ttm at all, block ttm refactorings?
We can just check whether the TTM using driver is potentially using locked
final unref and have a special version of
drm_gem_object_put_guaranteed_unlocked or whatever the bikeshed will look
like, which doesn't have the migth_lock.

Anyway, deed is done now :-)
-Daniel

> 
> Only problem is that I only see patch 7 and 9 in my inbox. Where is the
> rest?
> 
> Thanks,
> Christian.
> 
> > 
> > Rob Clark (11):
> >    drm/msm: Docs and misc cleanup
> >    drm/msm: Small submitqueue creation cleanup
> >    drm/msm: drop drm_gem_object_put_locked()
> >    drm: Drop drm_gem_object_put_locked()
> >    drm/msm/submit: Simplify out-fence-fd handling
> >    drm/msm: Consolidate submit bo state
> >    drm/msm: Track "seqno" fences by idr
> >    drm/msm: Return ERR_PTR() from submit_create()
> >    drm/msm: Conversion to drm scheduler
> >    drm/msm: Drop struct_mutex in submit path
> >    drm/msm: Utilize gpu scheduler priorities
> > 
> >   drivers/gpu/drm/drm_gem.c                   |  22 --
> >   drivers/gpu/drm/msm/Kconfig                 |   1 +
> >   drivers/gpu/drm/msm/adreno/a5xx_debugfs.c   |   4 +-
> >   drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |   6 +-
> >   drivers/gpu/drm/msm/adreno/a5xx_power.c     |   2 +-
> >   drivers/gpu/drm/msm/adreno/a5xx_preempt.c   |   7 +-
> >   drivers/gpu/drm/msm/adreno/a6xx_gmu.c       |  12 +-
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |   2 +-
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |   4 +-
> >   drivers/gpu/drm/msm/adreno/adreno_gpu.c     |   6 +-
> >   drivers/gpu/drm/msm/msm_drv.c               |  30 +-
> >   drivers/gpu/drm/msm/msm_fence.c             |  39 ---
> >   drivers/gpu/drm/msm/msm_fence.h             |   2 -
> >   drivers/gpu/drm/msm/msm_gem.c               |  91 +-----
> >   drivers/gpu/drm/msm/msm_gem.h               |  37 ++-
> >   drivers/gpu/drm/msm/msm_gem_submit.c        | 300 ++++++++++++--------
> >   drivers/gpu/drm/msm/msm_gpu.c               |  50 +---
> >   drivers/gpu/drm/msm/msm_gpu.h               |  41 ++-
> >   drivers/gpu/drm/msm/msm_ringbuffer.c        |  70 ++++-
> >   drivers/gpu/drm/msm/msm_ringbuffer.h        |  12 +
> >   drivers/gpu/drm/msm/msm_submitqueue.c       |  49 +++-
> >   include/drm/drm_gem.h                       |   2 -
> >   include/uapi/drm/msm_drm.h                  |  10 +-
> >   23 files changed, 440 insertions(+), 359 deletions(-)
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
