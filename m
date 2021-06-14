Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593983A6F51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhFNToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:44:44 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:40570 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbhFNTol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:44:41 -0400
Received: by mail-vs1-f45.google.com with SMTP id b1so8452359vsh.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSHdbBdLxbYZlWemrHLO8rn/WxjGLmePBCR/uXkKydQ=;
        b=gXbiB53zsC9A0e6yeqxynJ8K2CU29DzKA4rzf1CmwQvBwYBn+qnXX00hnKL5om0qVR
         cZYQavTAVYQMj1TX1A03OZ0h8xN0QWjRi+Ot6oIO5CtnxrYernwAO+aRzRp3yH64G1rr
         ayU0qODqGk8qCobFP6cO3js4NbtPKGRSEHEZha27t/AxNpXM90jHZFHYCV199wbhQJwc
         8y1yo+s1VL5UTlxtX51mcg1lHVG49NvzDvT7V0wTFv/iEdQe8jPd4hqxvYzOUN702JC8
         /3JI292H5UcLiwYfN8HGcIP4pH2klkqR0/tKzMJjkhtUPZFpAe8tFKz3PscRB4LnvXz6
         lufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSHdbBdLxbYZlWemrHLO8rn/WxjGLmePBCR/uXkKydQ=;
        b=l8owYRtfQ3Ffr+b8xfHyfG4gbIb/N/LQVyeftoe/etZynREf9aFyivaDj5bCIVRhff
         UN+uMcG3W1xKxqWXpYWero+vEC1pK3tYwH3wvJepe5yGFEMHtglWIQ8hDzUy4NFJpegG
         /S26W3ItVGwakBKfzFfesbkpyX8w/2wP2J9IweQRqG65Wg7iqrXWjHLj5zkmdcuBxUZV
         k3D1WtWl9QYR+FehPnZu9LMYnIZ3nf4avYN1d6i52PJEXRNiBlHgecjiH1s4MNhw2K+L
         y3L6RfuMf8yG0frPaJUkPgsesQBvN6W4x4yyjOG4/GCtrWl4QNVavb5tyjgLWTSMgmBZ
         9yCg==
X-Gm-Message-State: AOAM530tGZRtWFbYKyT4T6KkjCd+jt7NvRUJKYSvpzfFSR3FktpmxS7h
        VTQlPSpsEXs0xEV1Rsc/rWMqweG8+own5QZ9w70=
X-Google-Smtp-Source: ABdhPJytersYuO9TTLsR8N3gF2P4x9FpF+WT26vt3Abg72qCHav0Z8Q32sRLjm0DV7rnqHjAmyOKCwgXPuG7IinDHjY=
X-Received: by 2002:a05:6102:2159:: with SMTP id h25mr1281799vsg.19.1623699697567;
 Mon, 14 Jun 2021 12:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210612125426.6451-1-desmondcheongzx@gmail.com> <20210612125426.6451-3-desmondcheongzx@gmail.com>
In-Reply-To: <20210612125426.6451-3-desmondcheongzx@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 14 Jun 2021 20:41:26 +0100
Message-ID: <CACvgo51r3NK_ddQPPD9vBzkJq7A4CcYS4nawxZqqDB8FXK5gcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: Protect drm_master pointers in drm_lease.c
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 at 13:55, Desmond Cheong Zhi Xi
<desmondcheongzx@gmail.com> wrote:
>
> This patch ensures that the device's master mutex is acquired before
> accessing pointers to struct drm_master that are subsequently
> dereferenced. Without the mutex, the struct drm_master may be freed
> concurrently by another process calling drm_setmaster_ioctl(). This
> could then lead to use-after-free errors.
>
> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---

<snip>

> @@ -578,6 +594,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>         /* Hook up the fd */
>         fd_install(fd, lessee_file);
>
> +       mutex_unlock(&dev->master_mutex);

I was going to suggest pushing the unlock call further up - after the
drm_lease_create call. Although that would make the error path rather
messy, so let's keep it as-is.

<snip>

> @@ -662,7 +684,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
>         struct drm_mode_get_lease *arg = data;
>         __u32 __user *object_ids = (__u32 __user *) (uintptr_t) (arg->objects_ptr);
>         __u32 count_objects = arg->count_objects;
> -       struct drm_master *lessee = lessee_priv->master;
> +       struct drm_master *lessee;
>         struct idr *object_idr;
>         int count;
>         void *entry;
> @@ -678,8 +700,10 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
>
>         DRM_DEBUG_LEASE("get lease for %d\n", lessee->lessee_id);
>
> +       mutex_lock(&dev->master_mutex);

As-is we're dereferencing an uninitialised pointer in DRM_DEBUG_LEASE.
Move the lock and assignment before the DRM_DEBUG_LEASE, just like
you've done in the list ioctl.

With this fix, the patch is;
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

-Emil
