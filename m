Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9748350A6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhCaWov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhCaWoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:44:39 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D3C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:44:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id 1so232405qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAjs9EXx6Yc80YSTGK/3hcA/MZAHT8V3jPabf02H2g4=;
        b=M8JTOyCV+omhztb3AOc76Z2AYBAfNhaBfcELYiMbILrjm988hUt/iB9zi/7/Ye5al2
         Sn6VCj2mDj3ceKf+3fr2qzzD47B2KNRVS4F1UIOg7YbXoq/bC/lk9IHsrh1eehX7uBNX
         VjmHcTe+Qf5Bi5FQJsrSXKg4tBnotQmwxT59Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAjs9EXx6Yc80YSTGK/3hcA/MZAHT8V3jPabf02H2g4=;
        b=CxEmranFAr7dZST3PQZpeHkc2bBEy8AU+M6mSadCpvnnZqoLcq3tt551oO3WLnoZ+m
         XCjaaLGtZVRjWCvfN8+8bvyNcO44Q7XxL+BWPF7gDlEgj+iqmy7qVtU5iHf0Ro5ZXGbp
         qCv2csQfd+4iD1lmtiL5KgSyeWBxXpuQ+LVnuB/ipCkbsF8/+sGvWQ8pCE+XJYHrmCYA
         0nidHRAKgDZ7Zo7UueL4B6CNFJ5xQw9rliD3Rzj5ZJKSLjOY5g55PrjdnqIl0MT09IYm
         1ri21TUKS+6pmiOwE+zN6NHq/PJQwyUtMemdNwzvomltfEix9rlOm+ffS9BIXvqvojSt
         l6dQ==
X-Gm-Message-State: AOAM532BMOwmShNcdX1nFlxNJoe/D6EnknanAvUdpNDKQmUnn2r6NUgQ
        iNaqvvEYisYQXse6XUWGmAUEmQbTQBZLig==
X-Google-Smtp-Source: ABdhPJwc8tPrZetXDWbAuxRkDYFkQ8WW2cBtej4mn9QKRaL1o/p1dG149NN0SoB+tAr8EB5zp3XGOw==
X-Received: by 2002:ac8:7b8b:: with SMTP id p11mr4484844qtu.57.1617230677572;
        Wed, 31 Mar 2021 15:44:37 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id o197sm2538073qka.26.2021.03.31.15.44.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 15:44:36 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id g38so22841615ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:44:36 -0700 (PDT)
X-Received: by 2002:a25:74ca:: with SMTP id p193mr7640863ybc.405.1617230676164;
 Wed, 31 Mar 2021 15:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210331221630.488498-1-robdclark@gmail.com> <20210331221630.488498-3-robdclark@gmail.com>
In-Reply-To: <20210331221630.488498-3-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Mar 2021 15:44:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=USXBm-ZLafNWbUK=Ny7_vwtyG164mQFs87SkXqim-Vpw@mail.gmail.com>
Message-ID: <CAD=FV=USXBm-ZLafNWbUK=Ny7_vwtyG164mQFs87SkXqim-Vpw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/msm: Avoid mutex in shrinker_count()
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 3:14 PM Rob Clark <robdclark@gmail.com> wrote:
>
> @@ -818,11 +820,19 @@ static void update_inactive(struct msm_gem_object *msm_obj)
>         mutex_lock(&priv->mm_lock);
>         WARN_ON(msm_obj->active_count != 0);
>
> +       if (msm_obj->dontneed)
> +               mark_unpurgable(msm_obj);
> +
>         list_del_init(&msm_obj->mm_list);
> -       if (msm_obj->madv == MSM_MADV_WILLNEED)
> +       if (msm_obj->madv == MSM_MADV_WILLNEED) {
>                 list_add_tail(&msm_obj->mm_list, &priv->inactive_willneed);
> -       else
> +       } else if (msm_obj->madv == MSM_MADV_DONTNEED) {
>                 list_add_tail(&msm_obj->mm_list, &priv->inactive_dontneed);
> +               mark_purgable(msm_obj);
> +       } else {
> +               WARN_ON(msm_obj->madv != __MSM_MADV_PURGED);
> +               list_add_tail(&msm_obj->mm_list, &priv->inactive_purged);

I'm probably being dense, but what's the point of adding it to the
"inactive_purged" list here? You never look at that list, right? You
already did a list_del_init() on this object's list pointer
("mm_list"). I don't see how adding it to a bogus list helps with
anything.


> @@ -198,6 +203,33 @@ static inline bool is_vunmapable(struct msm_gem_object *msm_obj)
>         return (msm_obj->vmap_count == 0) && msm_obj->vaddr;
>  }
>
> +static inline void mark_purgable(struct msm_gem_object *msm_obj)
> +{
> +       struct msm_drm_private *priv = msm_obj->base.dev->dev_private;
> +
> +       WARN_ON(!mutex_is_locked(&priv->mm_lock));
> +
> +       if (WARN_ON(msm_obj->dontneed))
> +               return;

The is_purgeable() function also checks other things besides just
"MSM_MADV_DONTNEED". Do we need to check those too? Specifically:

 msm_obj->sgt && !msm_obj->base.dma_buf && !msm_obj->base.import_attach

...or is it just being paranoid?

I guess I'm just worried that if any of those might be important then
we'll consistently report back that we have a count of things that can
be purged but then scan() won't find anything to do. That wouldn't be
great.


> +       priv->shrinkable_count += msm_obj->base.size >> PAGE_SHIFT;
> +       msm_obj->dontneed = true;
> +}
> +
> +static inline void mark_unpurgable(struct msm_gem_object *msm_obj)
> +{
> +       struct msm_drm_private *priv = msm_obj->base.dev->dev_private;
> +
> +       WARN_ON(!mutex_is_locked(&priv->mm_lock));
> +
> +       if (WARN_ON(!msm_obj->dontneed))
> +               return;
> +
> +       priv->shrinkable_count -= msm_obj->base.size >> PAGE_SHIFT;
> +       WARN_ON(priv->shrinkable_count < 0);

If you changed the order maybe you could make shrinkable_count
"unsigned long" to match the shrinker API?

 new_shrinkable = msm_obj->base.size >> PAGE_SHIFT;
 WARN_ON(new_shrinkable > priv->shrinkable_count);
 priv->shrinkable_count -= new_shrinkable


-Doug
