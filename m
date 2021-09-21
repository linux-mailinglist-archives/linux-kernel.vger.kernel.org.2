Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAC6412B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347159AbhIUCTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244820AbhIUCJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632190075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0kxhnvVXGqL/DkgQ0Xhuo7zEcFhuLSYFgkrJ0v2bY8=;
        b=KRLl3CEEq5//U+1dni2S90am3gJf9SJWQNwRsdIUrH88E8a5qJ3TWmsLJnw5WvXWVwRBrr
        D9YVysuqw8ExjP/TJT9ETirMjhNBzqbMH6jqC7SETOvRCiMHMz4ENsFR4Cop7lIq74tDpJ
        ERxqpLfPdtw4s6+APxV+jfgus9FF+AM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-8gszQrBjPMK-9eBi_7jmuw-1; Mon, 20 Sep 2021 22:07:53 -0400
X-MC-Unique: 8gszQrBjPMK-9eBi_7jmuw-1
Received: by mail-wr1-f72.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso7563397wrn.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 19:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0kxhnvVXGqL/DkgQ0Xhuo7zEcFhuLSYFgkrJ0v2bY8=;
        b=3UhEqRn5GLPFbw75REQw0MHq4qZPPdvm5E9n2pzZCN3CgOGMAP+bxYjMiVgCY7ALrT
         8/lM52WbjgSyBucJmBlFPuEo8paFJUhG3B+vUYrIlHzWAhWt/OTl1yP/gCnKuReGLGq8
         U6DerAfKY6nppC1YTwevSRCxIGQiGjYHU2v1FhZaqJWIW10nPlsCC5FG1+I2zey5S2aZ
         y7RCuZlnfseazNGsecu21HUbfHRwNkWyZHE8ZpxuPv7HJoK0wcWWrbq5F3pu/WHJRpAT
         ekqWAlrEcGHG43HxTSFShnn3QGAriusdDAwf8Gs77dmeunKBY7WtXqbbHe3nfDILqlQU
         Z1Ug==
X-Gm-Message-State: AOAM530zwI05DfIG/Dtp/MqCE90e1TIVrLxKKDK3QmEiSSpdqC7jqSGr
        YJse9/aL0ebBLAVe80TUnoyQppi6zen7yetpNrBO+oeFCXUh+R5VIJIJMCp5LYwbqP5GTKMc+6E
        cb1qkSYOCkySOzjTS1PnLemmrDeAC/9cJuPQ0GZs5
X-Received: by 2002:a5d:59a6:: with SMTP id p6mr31897323wrr.142.1632190072362;
        Mon, 20 Sep 2021 19:07:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrRzQplbk6pECz7R+jDK45fgzj2acrfM2YcTeVeurs7f31ushctXVBKRv9j3sozVJ/z6cTUf1MM8JcQ4F1Rfo=
X-Received: by 2002:a5d:59a6:: with SMTP id p6mr31897316wrr.142.1632190072226;
 Mon, 20 Sep 2021 19:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210920181647.22156-1-tim.gardner@canonical.com>
In-Reply-To: <20210920181647.22156-1-tim.gardner@canonical.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 21 Sep 2021 04:07:41 +0200
Message-ID: <CACO55ts0kJaHr0QTzqy5r9Gq4vbV=8bMokuVHSCAqMVEOKAgDw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/ga102: Free resources on error in ga102_chan_new()
To:     Tim Gardner <tim.gardner@canonical.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 8:17 PM Tim Gardner <tim.gardner@canonical.com> wrote:
>
> Coverity complains of a resource leak in ga102_chan_new():
>
> CID 119637 (#7 of 7): Resource leak (RESOURCE_LEAK)
> 13. leaked_storage: Variable chan going out of scope leaks the storage it points to.
> 190                return ret;
>
> Fix this by freeing 'chan' in the error path.
>

yeah, this is actually a false positive. I ran your patch through
kasan and got a use-after-free as we deallocate the passed in pointer
after calling the function pointer to the new function. One might
argue that the programming style isn't the best and we should be
explicit about freeing memory though.

> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>  .../gpu/drm/nouveau/nvkm/engine/fifo/ga102.c  | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
> index f897bef13acf..4dbdfb53e65f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
> @@ -175,19 +175,21 @@ ga102_chan_new(struct nvkm_device *device,
>                 }
>         }
>
> -       if (!chan->ctrl.runl)
> -               return -ENODEV;
> +       if (!chan->ctrl.runl) {
> +               ret = -ENODEV;
> +               goto free_chan;
> +       }
>
>         chan->ctrl.chan = nvkm_rd32(device, chan->ctrl.runl + 0x004) & 0xfffffff0;
>         args->token = nvkm_rd32(device, chan->ctrl.runl + 0x008) & 0xffff0000;
>
>         ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, 0x1000, 0x1000, true, &chan->mthd);
>         if (ret)
> -               return ret;
> +               goto free_chan;
>
>         ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, 0x1000, 0x1000, true, &chan->inst);
>         if (ret)
> -               return ret;
> +               goto free_chan;
>
>         nvkm_kmap(chan->inst);
>         nvkm_wo32(chan->inst, 0x010, 0x0000face);
> @@ -209,11 +211,11 @@ ga102_chan_new(struct nvkm_device *device,
>
>         ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, 0x1000, 0x1000, true, &chan->user);
>         if (ret)
> -               return ret;
> +               goto free_chan;
>
>         ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, 0x1000, 0x1000, true, &chan->runl);
>         if (ret)
> -               return ret;
> +               goto free_chan;
>
>         nvkm_kmap(chan->runl);
>         nvkm_wo32(chan->runl, 0x00, 0x80030001);
> @@ -228,10 +230,14 @@ ga102_chan_new(struct nvkm_device *device,
>
>         ret = nvkm_vmm_join(vmm, chan->inst);
>         if (ret)
> -               return ret;
> +               goto free_chan;
>
>         chan->vmm = nvkm_vmm_ref(vmm);
>         return 0;
> +
> +free_chan:
> +       kfree(chan);
> +       return ret;
>  }
>
>  static const struct nvkm_device_oclass
> --
> 2.33.0
>

