Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB75D41F43C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355584AbhJASC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbhJASC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:02:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8302C061775;
        Fri,  1 Oct 2021 11:01:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v25so6115898wra.2;
        Fri, 01 Oct 2021 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YiwsTKhENtND/VRrUezpna6DtkksH1FJ/vIonOabwY=;
        b=O/ji9JBkcM6kPDJ/yCDoJHqhXU6HlwUIZksdw/n9JGe3+TaCnLrtmUJBCh72bDsrNP
         iUINfLjapn+AU+EPw0mbZrECslJ21k1Fym2BRnbEBAm1VAjrHxs2ovbTYh14AQ5e/h1K
         HqyA6mrz51xH29O17XcJZquL0k39cqTaCNxO68g9ZUwaKl9192DPl5t6MvtoPXHzsH5T
         N/PsmHX0CfADKQ+DUelwaNUxdEj1SAf9K/ObxfNYijmRtmX2IaWxojiIKbhd396qQHUH
         mR2XxIe913o0EE6p55jXq2Ba+XU5jH+ZcsWy1+ogU3h7o08JhobSu36CYC1RmSwcJCbE
         71NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YiwsTKhENtND/VRrUezpna6DtkksH1FJ/vIonOabwY=;
        b=3vvjpGdcHCGTw7Nky5eyNh7JAEKJhVZVhybE+zlf1hUsKKclwM8ovTVvEPwl2vVolg
         jjFp1bW8SeoQVRkxHKhkQTQFFDuZYUmXx5haKlDufnS4xKCmj7Ys9NylxjclV7LWR3H2
         EU+cxLhwsPTFWAdg4M9HovVF3xP/4bo12T3/r07zlocgUtSw/LMjSVr5iJpipk3UIaRh
         DpxPzOfBH+v0wqpGX2Sgs0m08lYR9ddne9f6IcCrJsNYB++4MkS+qvYN2T8KwcEzgGyy
         VgdYP50q9DzSZfg6h4kqVXlWVnhE6gy2lTwuDRvm2cGg68J9cSSFbEofe0rjt7aFhL/o
         Dkcw==
X-Gm-Message-State: AOAM530KrvSQ0LtB/cAw52O2Du/1Mioef09l3CNUbuI+UHSFo2sR3f1T
        HFGGOn02A3AloA4L94slbqxDp75+mhPYZobCWE0=
X-Google-Smtp-Source: ABdhPJzRw8jbJTVeP91m2lwMYt3qwIxsKNzKK1Q4yM0hDCGtUkkUVBe0E9BHYI/yqNpTzeeauIfvrJlRc4sOLAlCqRM=
X-Received: by 2002:adf:bbd1:: with SMTP id z17mr10867749wrg.61.1633111271135;
 Fri, 01 Oct 2021 11:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210927180345.878859-1-robdclark@gmail.com> <9b3a8067-79d6-e4c2-8025-96f2ebe7fd6a@linaro.org>
In-Reply-To: <9b3a8067-79d6-e4c2-8025-96f2ebe7fd6a@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 1 Oct 2021 11:05:45 -0700
Message-ID: <CAF6AEGs9AB1L-iTsdFzN-rp3AO=ChDEiEfrsPMs8v=gh=9+wmw@mail.gmail.com>
Subject: Re: [RFC] drm/msm/a6xx: Serialize GMU communication
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Eric Anholt <eric@anholt.net>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 10:39 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 27/09/2021 21:03, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > I've seen some crashes in our crash reporting that *look* like multiple
> > threads stomping on each other while communicating with GMU.  So wrap
> > all those paths in a lock.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > Are we allowed to use c99/gnu99 yet?
> >
> >   drivers/gpu/drm/msm/Makefile          |  2 +-
> >   drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  6 ++++
> >   drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  9 +++++
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 50 ++++++++++++++++++++-------
> >   4 files changed, 54 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> > index 904535eda0c4..57283bbad3f0 100644
> > --- a/drivers/gpu/drm/msm/Makefile
> > +++ b/drivers/gpu/drm/msm/Makefile
> > @@ -1,5 +1,5 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > -ccflags-y := -I $(srctree)/$(src)
> > +ccflags-y := -I $(srctree)/$(src) -std=gnu99
> >   ccflags-y += -I $(srctree)/$(src)/disp/dpu1
> >   ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(srctree)/$(src)/dsi
> >   ccflags-$(CONFIG_DRM_MSM_DP) += -I $(srctree)/$(src)/dp
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > index a7c58018959f..8b73f70766a4 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -296,6 +296,8 @@ int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
> >       u32 val;
> >       int request, ack;
> >
> > +     WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
> > +
> >       if (state >= ARRAY_SIZE(a6xx_gmu_oob_bits))
> >               return -EINVAL;
> >
> > @@ -337,6 +339,8 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
> >   {
> >       int bit;
> >
> > +     WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
> > +
> >       if (state >= ARRAY_SIZE(a6xx_gmu_oob_bits))
> >               return;
> >
> > @@ -1482,6 +1486,8 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
> >       if (!pdev)
> >               return -ENODEV;
> >
> > +     mutex_init(&gmu->lock);
> > +
> >       gmu->dev = &pdev->dev;
> >
> >       of_dma_configure(gmu->dev, node, true);
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> > index 3c74f64e3126..f05a00c0afd0 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> > @@ -44,6 +44,9 @@ struct a6xx_gmu_bo {
> >   struct a6xx_gmu {
> >       struct device *dev;
> >
> > +     /* For serializing communication with the GMU: */
> > +     struct mutex lock;
> > +
> >       struct msm_gem_address_space *aspace;
> >
> >       void * __iomem mmio;
> > @@ -88,6 +91,12 @@ struct a6xx_gmu {
> >       bool legacy; /* a618 or a630 */
> >   };
> >
> > +/* Helper macro for serializing GMU access: */
> > +#define with_gmu_lock(gmu) \
> > +     for (bool done = ({ mutex_lock(&(gmu)->lock); false; }); \
> > +             !done; \
> > +             done = ({ mutex_unlock(&(gmu)->lock); true; }))
>
> The intent is good, but I'm not sure this kind of syntax sugar would be
> a good approach. What about calling lock/unlock explicitly, like we
> typically do? Then we won't have to use c99.

Yeah, I was planning to resend without the sugar.. but it was a good
excuse to bring up c99.  Ie. I want c99 regardless ;-)

(The sugar was useful initially before I'd sorted thru all the code
paths and settled on using a mutex vs spinlock)

BR,
-R

> > +
> >   static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
> >   {
> >       return msm_readl(gmu->mmio + (offset << 2));
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index f6a4dbef796b..5e1ae3df42ba 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -881,7 +881,7 @@ static int a6xx_zap_shader_init(struct msm_gpu *gpu)
> >         A6XX_RBBM_INT_0_MASK_UCHE_OOB_ACCESS | \
> >         A6XX_RBBM_INT_0_MASK_UCHE_TRAP_INTR)
> >
> > -static int a6xx_hw_init(struct msm_gpu *gpu)
> > +static int hw_init(struct msm_gpu *gpu)
> >   {
> >       struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> >       struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> > @@ -1135,6 +1135,19 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
> >       return ret;
> >   }
> >
> > +static int a6xx_hw_init(struct msm_gpu *gpu)
> > +{
> > +     struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> > +     struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> > +     int ret;
> > +
> > +     with_gmu_lock(&a6xx_gpu->gmu) {
> > +             ret = hw_init(gpu);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >   static void a6xx_dump(struct msm_gpu *gpu)
> >   {
> >       DRM_DEV_INFO(&gpu->pdev->dev, "status:   %08x\n",
> > @@ -1509,7 +1522,9 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
> >
> >       trace_msm_gpu_resume(0);
> >
> > -     ret = a6xx_gmu_resume(a6xx_gpu);
> > +     with_gmu_lock(&a6xx_gpu->gmu) {
> > +             ret = a6xx_gmu_resume(a6xx_gpu);
> > +     }
> >       if (ret)
> >               return ret;
> >
> > @@ -1532,7 +1547,9 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
> >
> >       msm_devfreq_suspend(gpu);
> >
> > -     ret = a6xx_gmu_stop(a6xx_gpu);
> > +     with_gmu_lock(&a6xx_gpu->gmu) {
> > +             ret = a6xx_gmu_stop(a6xx_gpu);
> > +     }
> >       if (ret)
> >               return ret;
> >
> > @@ -1547,18 +1564,17 @@ static int a6xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
> >   {
> >       struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> >       struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> > -     static DEFINE_MUTEX(perfcounter_oob);
> >
> > -     mutex_lock(&perfcounter_oob);
> > +     with_gmu_lock(&a6xx_gpu->gmu) {
> > +             /* Force the GPU power on so we can read this register */
> > +             a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> >
> > -     /* Force the GPU power on so we can read this register */
> > -     a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> > +             *value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER_LO,
> > +                                 REG_A6XX_CP_ALWAYS_ON_COUNTER_HI);
> >
> > -     *value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER_LO,
> > -             REG_A6XX_CP_ALWAYS_ON_COUNTER_HI);
> > +             a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> > +     }
> >
> > -     a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> > -     mutex_unlock(&perfcounter_oob);
> >       return 0;
> >   }
> >
> > @@ -1622,6 +1638,16 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
> >       return (unsigned long)busy_time;
> >   }
> >
> > +void a6xx_gpu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
> > +{
> > +     struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> > +     struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> > +
> > +     with_gmu_lock(&a6xx_gpu->gmu) {
> > +             a6xx_gmu_set_freq(gpu, opp);
> > +     }
> > +}
> > +
> >   static struct msm_gem_address_space *
> >   a6xx_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev)
> >   {
> > @@ -1766,7 +1792,7 @@ static const struct adreno_gpu_funcs funcs = {
> >   #endif
> >               .gpu_busy = a6xx_gpu_busy,
> >               .gpu_get_freq = a6xx_gmu_get_freq,
> > -             .gpu_set_freq = a6xx_gmu_set_freq,
> > +             .gpu_set_freq = a6xx_gpu_set_freq,
> >   #if defined(CONFIG_DRM_MSM_GPU_STATE)
> >               .gpu_state_get = a6xx_gpu_state_get,
> >               .gpu_state_put = a6xx_gpu_state_put,
> >
>
>
> --
> With best wishes
> Dmitry
