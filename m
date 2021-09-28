Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD85341ADA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbhI1LQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239068AbhI1LQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632827683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZU+KVR0y2VTh3ZrdA51D/L+4k30fXIYJ6SUmvuXTBtU=;
        b=FcaykwPZNo92lJaeTP35evk3+6CY2OWeLx9VgdynD2AtD02wBD0bUUoBS04RUL5NF/yVj7
        3tkwCFGF4m1kHFCQ5r0QI2wxMySb7N6ZN+bOlZUDVKBS3RZhFiCHaKR57sq+iEYmyXyY73
        W5qcMIG4wtzQbjVGEzPs49ZOmZ/C7KU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-aBfOszqWPgKOPSVN4waDGw-1; Tue, 28 Sep 2021 07:14:42 -0400
X-MC-Unique: aBfOszqWPgKOPSVN4waDGw-1
Received: by mail-wm1-f72.google.com with SMTP id j82-20020a1c2355000000b0030cec9c9a66so1848835wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU+KVR0y2VTh3ZrdA51D/L+4k30fXIYJ6SUmvuXTBtU=;
        b=4axxNTdElP1uTq7kQNPBcTJWbS0U6DfH25WKXObSExsttPVmrgSW0JYIimhugpJi2Z
         OO4E6/+Swa9W485FMuzOcGEnqeQdCqDsSsRGhYHwsdZrox+0HmnmyowcQzTEyRHmeVaj
         ceNQFvxrkRajiOF0FkXOzZgQgQYzzEPH5cDKougTDJRlmMlfKBXGIcvgAOgPU24KhnQ0
         1P6q3AMmp1D9PKyLlDqeik6T1eWf2nyzFKTbSlyuYHoMdXqNGhxSf7ehGP7h0lLTJ514
         sUPXs0kq1YoIjo31wterHUMyTRGZgcntWmEl7UguBklnX0ytAMZPszBjwK2+ArQGCR7d
         ZDTg==
X-Gm-Message-State: AOAM531bgc8W5axwGm92rdxAUuVs6mwZdU6Xvq+2bW4nKnsSuWBPop4+
        aVuO7jcyzYaqfrOJc7PaubAPCHeLfPlyQBrznZXU/doN20bDT+YaO1RgX7r4J9juHY3CX1YfUsp
        EyHts5o43ccIzx7zgH+tplZMnmxY8oErQoKvKrm01
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr4054953wmj.146.1632827681479;
        Tue, 28 Sep 2021 04:14:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmyS/k9wYJiX+xvA60Ee54wMfLNQLygQJU7Coe9SlPvQKuE0bZ2nADyYTfZL/XxVTwdXQwLWEQNDjqQrl73Dg=
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr4054944wmj.146.1632827681334;
 Tue, 28 Sep 2021 04:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210821021106.27010-1-luo.penghao@zte.com.cn>
In-Reply-To: <20210821021106.27010-1-luo.penghao@zte.com.cn>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 28 Sep 2021 13:14:30 +0200
Message-ID: <CACO55tv5PoPL122+XSwS8Fyq9bbRNzqBghy7CPX1uTCKea9eUA@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/nouveau/mmu: drop unneeded assignment in
 the nvkm_uvmm_mthd_page()
To:     CGEL <cgel.zte@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Sat, Aug 21, 2021 at 10:46 AM CGEL <cgel.zte@gmail.com> wrote:
>
> From: Luo penghao <luo.penghao@zte.com.cn>
>
> In order to keep the code style consistency of the whole file,
> the 'ret' assignments should be deleted.
>
> The clang_analyzer complains as follows:
>
> drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:317:8:warning:
> Although the value storedto 'ret' is used in the enclosing expression,
> the value is never actually read from 'ret'.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c
> index c43b824..d9f8e11 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c
> @@ -314,7 +314,7 @@ nvkm_uvmm_mthd_page(struct nvkm_uvmm *uvmm, void *argv, u32 argc)
>         page = uvmm->vmm->func->page;
>         for (nr = 0; page[nr].shift; nr++);
>
> -       if (!(ret = nvif_unpack(ret, &argv, &argc, args->v0, 0, 0, false))) {
> +       if (!(nvif_unpack(ret, &argv, &argc, args->v0, 0, 0, false))) {
>                 if ((index = args->v0.index) >= nr)
>                         return -EINVAL;
>                 type = page[index].type;
> --
> 2.15.2
>
>

