Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9866E45DFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348833AbhKYR2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348098AbhKYR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:26:39 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453AC06175C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:15:51 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e8so6456165ilu.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uYJR7BpBUZnQlATvrNBpAhoCNJC2VJDDuo/0Wdks2I=;
        b=U1wy3xNctEYKtUSbQx4rQXWxWtAp3C6P5JqLjhqLydfu/j7qzEy22qOVSYZ8CT4Q0E
         KVf41IlVtfIa4dkrSkmRdOr7Mqn9KxanQNNnwy3jx2/d4CNhit0+YKJ3rmErXoNkDT9h
         EPVq9/nY4i12LhSgQ+wt8DA6NbflF6T7isKlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uYJR7BpBUZnQlATvrNBpAhoCNJC2VJDDuo/0Wdks2I=;
        b=ZzWUf/7IgzsCjsvDnCZDrpKDDRCuf04iUFsIQhlh7kLHULcrFr67R3yEBwn01ZUtXL
         jAyKyNY6xkkXwuvoOamD4dPqueAK6YEvo1O0NdhdzRah45T20rwgcixlTBCZ9lFz4o2T
         19h9OwVkIiq1D44dMBqP4Ytoai0HuZ0R2pW1atZWhY7n1OYNcGGgCjv6h/NrhXRQe66l
         DKB4ZxY+3s+udDybHSR95NKRotjTjN85Ahh5W2J1we1v6/EEZ+EizKkTpGY50++iocEA
         I5vACso8TKlOVFRLRJqrECvBllQNVbRUFLWzB1Qt6BXdBemEZOpIZCRjm4EY3b3apagB
         4hWA==
X-Gm-Message-State: AOAM532tkrE7XOTXY6ujHDxMUb0CyP0xleOg3PA36lWGTMUi5Q5evAsc
        fW0v7nc2nzfEsO9uZ3fSvnxW3LhIYUyNJRuylQdw+w==
X-Google-Smtp-Source: ABdhPJwllgvWyk4LNbY/PtxJGQlD+gEgV7b5sp6fqyvfUdRDRSzNrnZLFjdBH7EIEcEybhBkeEKxek8U1YU0hnor4HU=
X-Received: by 2002:a92:c54d:: with SMTP id a13mr23882839ilj.143.1637860551141;
 Thu, 25 Nov 2021 09:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20210428193654.1498482-1-robdclark@gmail.com> <20210428193654.1498482-2-robdclark@gmail.com>
 <e6f04ed5-100d-6ef9-c272-1a1370e45579@linaro.org>
In-Reply-To: <e6f04ed5-100d-6ef9-c272-1a1370e45579@linaro.org>
From:   Rob Clark <robdclark@chromium.org>
Date:   Thu, 25 Nov 2021 09:20:57 -0800
Message-ID: <CAJs_Fx6cJSkU=+C7Fh14=xojn0n-ad9_qNFXuimFFm_X3WfUOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm: Handle ringbuffer overflow
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Eric Anholt <emma@anholt.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dave Airlie <airlied@redhat.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:36 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 28/04/2021 22:36, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Currently if userspace manages to fill up the ring faster than the GPU
> > can consume we (a) spin for up to 1sec, and then (b) overwrite the
> > ringbuffer contents from previous submits that the GPU is still busy
> > executing.  Which predictably goes rather badly.
> >
> > Instead, just skip flushing (updating WPTR) and reset ring->next back to
> > where it was before we tried writing the submit into the ringbuffer, and
> > return an error to userspace (which can then try again).
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Rob, you've posted this patch, but never merged it. Should it be merged
> at some point?

I think it is a bit less needed now, since drm/sched will limit the #
of in-flight submits (when I sent that patch, it was before conversion
to use drm/sched)

With a bit more locking re-work we could do something more clever like
just blocking until there is space in the ringbuffer.. but aren't
there quite yet.

BR,
-R

>
> > ---
> >   drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  3 +++
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  3 +++
> >   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 24 +++++++++++++++++-
> >   drivers/gpu/drm/msm/msm_gem_submit.c    |  7 +++++-
> >   drivers/gpu/drm/msm/msm_gpu.c           | 33 +++++++++++++++++++++++--
> >   drivers/gpu/drm/msm/msm_gpu.h           |  2 +-
> >   drivers/gpu/drm/msm/msm_ringbuffer.h    |  5 ++++
> >   7 files changed, 72 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > index ce13d49e615b..0c8faad3b328 100644
> > --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > @@ -36,6 +36,9 @@ void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
> >               OUT_RING(ring, upper_32_bits(shadowptr(a5xx_gpu, ring)));
> >       }
> >
> > +     if (unlikely(ring->overflow))
> > +             return;
> > +
> >       spin_lock_irqsave(&ring->preempt_lock, flags);
> >
> >       /* Copy the shadow to the actual register */
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index d553f62f4eeb..4a4728a774c0 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -68,6 +68,9 @@ static void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> >               OUT_RING(ring, upper_32_bits(shadowptr(a6xx_gpu, ring)));
> >       }
> >
> > +     if (unlikely(ring->overflow))
> > +             return;
> > +
> >       spin_lock_irqsave(&ring->preempt_lock, flags);
> >
> >       /* Copy the shadow to the actual register */
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index 0f184c3dd9d9..a658777e07b1 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -467,6 +467,9 @@ void adreno_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring, u32 reg)
> >   {
> >       uint32_t wptr;
> >
> > +     if (unlikely(ring->overflow))
> > +             return;
> > +
> >       /* Copy the shadow to the actual register */
> >       ring->cur = ring->next;
> >
> > @@ -788,12 +791,31 @@ static uint32_t ring_freewords(struct msm_ringbuffer *ring)
> >       return (rptr + (size - 1) - wptr) % size;
> >   }
> >
> > +static bool space_avail(struct msm_ringbuffer *ring, uint32_t ndwords)
> > +{
> > +     if (ring_freewords(ring) >= ndwords)
> > +             return true;
> > +
> > +     /* We don't have a good way to know in general when the RPTR has
> > +      * advanced.. newer things that use CP_WHERE_AM_I to update the
> > +      * shadow rptr could possibly insert a packet to generate an irq.
> > +      * But that doesn't cover older GPUs.  But if the ringbuffer is
> > +      * full, it could take a while before it is empty again, so just
> > +      * insert a blind sleep to avoid a busy loop.
> > +      */
> > +     msleep(1);
> > +
> > +     return false;
> > +}
> > +
> >   void adreno_wait_ring(struct msm_ringbuffer *ring, uint32_t ndwords)
> >   {
> > -     if (spin_until(ring_freewords(ring) >= ndwords))
> > +     if (spin_until(space_avail(ring, ndwords))) {
> >               DRM_DEV_ERROR(ring->gpu->dev->dev,
> >                       "timeout waiting for space in ringbuffer %d\n",
> >                       ring->id);
> > +             ring->overflow = true;
> > +     }
> >   }
> >
> >   /* Get legacy powerlevels from qcom,gpu-pwrlevels and populate the opp table */
> > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> > index 5480852bdeda..4bc669460fda 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > @@ -683,6 +683,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
> >       submitid = atomic_inc_return(&ident) - 1;
> >
> >       ring = gpu->rb[queue->prio];
> > +
> > +     GEM_WARN_ON(ring->overflow);
> > +
> >       trace_msm_gpu_submit(pid_nr(pid), ring->id, submitid,
> >               args->nr_bos, args->nr_cmds);
> >
> > @@ -829,7 +832,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
> >               }
> >       }
> >
> > -     msm_gpu_submit(gpu, submit);
> > +     ret = msm_gpu_submit(gpu, submit);
> > +     if (ret)
> > +             goto out;
> >
> >       args->fence = submit->fence->seqno;
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> > index ab7c167b0623..7655ad9108c8 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > @@ -787,7 +787,7 @@ void msm_gpu_retire(struct msm_gpu *gpu)
> >   }
> >
> >   /* add bo's to gpu's ring, and kick gpu: */
> > -void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
> > +int msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
> >   {
> >       struct drm_device *dev = gpu->dev;
> >       struct msm_drm_private *priv = dev->dev_private;
> > @@ -834,9 +834,38 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
> >       spin_unlock(&ring->submit_lock);
> >
> >       gpu->funcs->submit(gpu, submit);
> > -     priv->lastctx = submit->queue->ctx;
> >
> >       hangcheck_timer_reset(gpu);
> > +
> > +     if (unlikely(ring->overflow)) {
> > +             /*
> > +              * Reset the ptr back to before the submit, so the GPU
> > +              * doesn't see a partial submit:
> > +              */
> > +             ring->next = ring->cur;
> > +
> > +             /*
> > +              * Clear the overflow flag, hopefully the next submit on
> > +              * the ring actually fits
> > +              */
> > +             ring->overflow = false;
> > +
> > +             /*
> > +              * One might be tempted to remove the submit from the
> > +              * submits list, and drop it's reference (and drop the
> > +              * active reference for all the bos).  But we can't
> > +              * really signal the fence attached to obj->resv without
> > +              * disturbing other fences on the timeline.  So instead
> > +              * just leave it and let it retire normally when a
> > +              * later submit completes.
> > +              */
> > +
> > +             return -ENOSPC;
> > +     }
> > +
> > +     priv->lastctx = submit->queue->ctx;
> > +
> > +     return 0;
> >   }
> >
> >   /*
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > index d7cd02cd2109..2dd2ef1f8328 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -302,7 +302,7 @@ int msm_gpu_perfcntr_sample(struct msm_gpu *gpu, uint32_t *activetime,
> >               uint32_t *totaltime, uint32_t ncntrs, uint32_t *cntrs);
> >
> >   void msm_gpu_retire(struct msm_gpu *gpu);
> > -void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit);
> > +int msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit);
> >
> >   int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
> >               struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
> > diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
> > index fe55d4a1aa16..d8ad9818c389 100644
> > --- a/drivers/gpu/drm/msm/msm_ringbuffer.h
> > +++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
> > @@ -40,6 +40,8 @@ struct msm_ringbuffer {
> >       struct drm_gem_object *bo;
> >       uint32_t *start, *end, *cur, *next;
> >
> > +     bool overflow;
> > +
> >       /*
> >        * List of in-flight submits on this ring.  Protected by submit_lock.
> >        */
> > @@ -69,6 +71,9 @@ void msm_ringbuffer_destroy(struct msm_ringbuffer *ring);
> >   static inline void
> >   OUT_RING(struct msm_ringbuffer *ring, uint32_t data)
> >   {
> > +     if (ring->overflow)
> > +             return;
> > +
> >       /*
> >        * ring->next points to the current command being written - it won't be
> >        * committed as ring->cur until the flush
> >
>
>
> --
> With best wishes
> Dmitry
