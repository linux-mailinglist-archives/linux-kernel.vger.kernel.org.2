Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7F357F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhDHJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhDHJhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:37:11 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D56C061763
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 02:37:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g20so1524408qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghzoHE8k0viCzGCIXUnUb1wmrbHaDWfO8HjiU066O5o=;
        b=PVbRM/22xY28WeeeXUVsnvlTolRNlGTfWj3YwP6DiZ/EVeaVUQhVv7loyTrFhwc+nP
         Yl56oDANvOX16JH2jUgStFjNXf2rAeMCWadmCAXfIyS2dX1hKhQmAba5gpzD3czKJqwY
         xor4O22UEoNO/BZIDDcNezrtQIzvyQxammj0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghzoHE8k0viCzGCIXUnUb1wmrbHaDWfO8HjiU066O5o=;
        b=VqC5jltp3z0BzkGz+3QAyD1CKG+lKguWRjW9RrbnzqjpXkzNvs160lpnRkbiFhVtds
         Eyn6r61yWZNCGhP6NFMC4JSrzaqah9wlkI0sTX4DQ3MvNBgaQEeoLp3tfliKVkR9xAdo
         +QlJlzbUZsnXZ89cqH04NjJXWEMribtBOw9zRSbyTpnNUrQozKXtqGdd0mBiZQxcAU2h
         9Jy02v00kuMZ83H5aI8b+JHSwwr56NqmAs73Qy0SqYMSKIBzTSf62ib5okkzHpvZv1F8
         0oATxFRURtouCh41pXQ7tLR/YhMLz6gZqHRfMPOglNH9OdTh1M/YwKLBf07/65Z3RREN
         1xYw==
X-Gm-Message-State: AOAM530ULq+R/1kbHCl3qcgPO2EbG2nH+l/kpxLQqzVSKKNBfT6vvqBy
        DMLwf4vAwDFYPoWYQAYFDHU5TbCwW73Gt+1SXgCE1w==
X-Google-Smtp-Source: ABdhPJy0VZh68sbDGfVx/USnKKb7xczieJsPs3t+EAlcUBcHHDIsp9ppQtPlhF20C7VLgw19SE4ZU0Fmwwr2Kuztc+E=
X-Received: by 2002:a05:620a:2190:: with SMTP id g16mr7412243qka.241.1617874619944;
 Thu, 08 Apr 2021 02:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210408093448.3897988-1-stevensd@google.com>
In-Reply-To: <20210408093448.3897988-1-stevensd@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 8 Apr 2021 18:36:49 +0900
Message-ID: <CAD=HUj4up04e5kto3zhABdjxPtBMAchkSJx_WshZmTRcD-fTow@mail.gmail.com>
Subject: Re: [PATCH] drm/syncobj: use newly allocated stub fences
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to checkpatch this, I'll resend it momentarily.

-David

On Thu, Apr 8, 2021 at 6:34 PM David Stevens <stevensd@chromium.org> wrote:
>
> From: David Stevens <stevensd@chromium.org>
>
> Allocate a new private stub fence in drm_syncobj_assign_null_handle,
> instead of using a static stub fence.
>
> When userspace creates a fence with DRM_SYNCOBJ_CREATE_SIGNALED or when
> userspace signals a fence via DRM_IOCTL_SYNCOBJ_SIGNAL, the timestamp
> obtained when the fence is exported and queried with SYNC_IOC_FILE_INFO
> should match when the fence's status was changed from the perspective of
> userspace, which is during the respective ioctl.
>
> When a static stub fence started being used in by these ioctls, this
> behavior changed. Instead, the timestamp returned by SYNC_IOC_FILE_INFO
> became the first time anything used the static stub fence, which has no
> meaning to userspace.
>
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  drivers/dma-buf/dma-fence.c   | 33 ++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/drm_syncobj.c | 28 ++++++++++++++++++++--------
>  include/linux/dma-fence.h     |  1 +
>  3 files changed, 53 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index d64fc03929be..6081eb962490 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -26,6 +26,11 @@ EXPORT_TRACEPOINT_SYMBOL(dma_fence_signaled);
>  static DEFINE_SPINLOCK(dma_fence_stub_lock);
>  static struct dma_fence dma_fence_stub;
>
> +struct drm_fence_private_stub {
> +       struct dma_fence base;
> +       spinlock_t lock;
> +};
> +
>  /*
>   * fence context counter: each execution context should have its own
>   * fence context, this allows checking if fences belong to the same
> @@ -123,7 +128,9 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
>  /**
>   * dma_fence_get_stub - return a signaled fence
>   *
> - * Return a stub fence which is already signaled.
> + * Return a stub fence which is already signaled. The fence's
> + * timestamp corresponds to the first time after boot this
> + * function is called.
>   */
>  struct dma_fence *dma_fence_get_stub(void)
>  {
> @@ -141,6 +148,30 @@ struct dma_fence *dma_fence_get_stub(void)
>  }
>  EXPORT_SYMBOL(dma_fence_get_stub);
>
> +/**
> + * dma_fence_allocate_private_stub - return a private, signaled fence
> + *
> + * Return a newly allocated and signaled stub fence.
> + */
> +struct dma_fence *dma_fence_allocate_private_stub(void)
> +{
> +       struct drm_fence_private_stub *fence;
> +
> +       fence = kzalloc(sizeof(*fence), GFP_KERNEL);
> +       if (fence == NULL)
> +               return ERR_PTR(-ENOMEM);
> +
> +       spin_lock_init(&fence->lock);
> +       dma_fence_init(&fence->base,
> +                      &dma_fence_stub_ops,
> +                      &fence->lock,
> +                      0, 0);
> +       dma_fence_signal(&fence->base);
> +
> +       return &fence->base;
> +}
> +EXPORT_SYMBOL(dma_fence_allocate_private_stub);
> +
>  /**
>   * dma_fence_context_alloc - allocate an array of fence contexts
>   * @num: amount of contexts to allocate
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 349146049849..c6125e57ae37 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -350,12 +350,15 @@ EXPORT_SYMBOL(drm_syncobj_replace_fence);
>   *
>   * Assign a already signaled stub fence to the sync object.
>   */
> -static void drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
> +static int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
>  {
> -       struct dma_fence *fence = dma_fence_get_stub();
> +       struct dma_fence *fence = dma_fence_allocate_private_stub();
> +       if (IS_ERR(fence))
> +              return PTR_ERR(fence);
>
> -       drm_syncobj_replace_fence(syncobj, fence);
> -       dma_fence_put(fence);
> +       drm_syncobj_replace_fence(syncobj, fence);
> +       dma_fence_put(fence);
> +       return 0;
>  }
>
>  /* 5s default for wait submission */
> @@ -469,6 +472,7 @@ EXPORT_SYMBOL(drm_syncobj_free);
>  int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
>                        struct dma_fence *fence)
>  {
> +       int ret;
>         struct drm_syncobj *syncobj;
>
>         syncobj = kzalloc(sizeof(struct drm_syncobj), GFP_KERNEL);
> @@ -479,8 +483,13 @@ int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
>         INIT_LIST_HEAD(&syncobj->cb_list);
>         spin_lock_init(&syncobj->lock);
>
> -       if (flags & DRM_SYNCOBJ_CREATE_SIGNALED)
> -               drm_syncobj_assign_null_handle(syncobj);
> +       if (flags & DRM_SYNCOBJ_CREATE_SIGNALED) {
> +               ret = drm_syncobj_assign_null_handle(syncobj);
> +               if (ret < 0) {
> +                       drm_syncobj_put(syncobj);
> +                       return ret;
> +               }
> +       }
>
>         if (fence)
>                 drm_syncobj_replace_fence(syncobj, fence);
> @@ -1322,8 +1331,11 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
>         if (ret < 0)
>                 return ret;
>
> -       for (i = 0; i < args->count_handles; i++)
> -               drm_syncobj_assign_null_handle(syncobjs[i]);
> +       for (i = 0; i < args->count_handles; i++) {
> +               ret = drm_syncobj_assign_null_handle(syncobjs[i]);
> +               if (ret < 0)
> +                       break;
> +       }
>
>         drm_syncobj_array_free(syncobjs, args->count_handles);
>
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 9f12efaaa93a..6ffb4b2c6371 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -587,6 +587,7 @@ static inline signed long dma_fence_wait(struct dma_fence *fence, bool intr)
>  }
>
>  struct dma_fence *dma_fence_get_stub(void);
> +struct dma_fence *dma_fence_allocate_private_stub(void);
>  u64 dma_fence_context_alloc(unsigned num);
>
>  #define DMA_FENCE_TRACE(f, fmt, args...) \
> --
> 2.31.0.208.g409f899ff0-goog
>
