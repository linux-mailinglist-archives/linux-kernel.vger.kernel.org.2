Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B243B7429
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhF2OUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbhF2OUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:20:16 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2A9C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:17:49 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so22770373ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ca9b/RJBp6vFH4Z8SWl5H4/Izby04wi57Lwxa0JLyrs=;
        b=LJcaYPROk5PS/GO/KmuD4NNz/hB69mF5BLuqEZWjNJWkR5tss9yy9ob8LNmQ0LpHx1
         T4l5ruxUNJFzXKNKUranp6fvbr8bOuweBUVqf2n95m5si7ScYTzb9eueYMIxKM5Hr+Lr
         S6aL7we9LHKVCL5ydwi2O/GZMoFkOoil/SS2VmTT+U+fscM2Ha+KkT9h2gUP3MszFcqr
         k4Tk2mF6jo2Z66LFTKa4FaPa2z8hPSrDBkGmea7ufgDwLTt0d0sgAIMIBRKpea0LGo0D
         nS46tCP0MwkKsNKZfuIKLq2YBilWRgI+ywIim2+1pgg981yp4r/twiVowE88w9Nceb4D
         0grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ca9b/RJBp6vFH4Z8SWl5H4/Izby04wi57Lwxa0JLyrs=;
        b=gjG9EKb+d613fuMN7OeqJGzFXa/PknPU/PEWKM5TJPvyQxkTD3IrL2+pyhYuYphpwN
         miCv8K7Mo37Z5OlsutiZ8soBnhROK8NQFaw80JZOoN7aYYcj0fp4nDl3dEbaMwxyYs5x
         hZisF9wGac6ZHcuRck3qyr1kBgaIXLhlbPpgGhoj0MG1I4Z8cUuzdy3RA2gwTpYfdWXb
         aZDEcIpdRPHKQLN0B088Loz246I/yQRAI5oO4WYNxsh1KkEKB3+Y+r0hqcp0ftZRC0ne
         lVeFSvoW9oZxdcmaaMAiN8RHguvZD0nbRwJea7RTtJSCfYV1jVWZgabndprTwyRxmC68
         5g6A==
X-Gm-Message-State: AOAM533o665kgm35wS2pXHECbdpO5E4L04rR7rHSQSYrVOSIIzLAG7cn
        kPYXAijsumB5Ws9tk97YpaUiJpXXiZ0Maa/f4Fs=
X-Google-Smtp-Source: ABdhPJw2CJEKzgyewXcuEZEPTcfsz3H8f6me+j7nAF4nXArSiuFEdABdhNogjc6cwbt9NfbqjiN/eba0bUuDjcZfZyg=
X-Received: by 2002:a05:6830:33ef:: with SMTP id i15mr4672446otu.311.1624976269048;
 Tue, 29 Jun 2021 07:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210629114455.12963-1-jingxiangfeng@huawei.com> <5ff91e15-6014-bc72-40ca-3fa8b834f692@amd.com>
In-Reply-To: <5ff91e15-6014-bc72-40ca-3fa8b834f692@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Jun 2021 10:17:38 -0400
Message-ID: <CADnq5_P0whWU-j3ZasO2hUYLWQEy7v=2jtc7hOisfgALu84xsw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/radeon: Add the missed drm_gem_object_put() in radeon_user_framebuffer_create()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Jun 29, 2021 at 7:42 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 29.06.21 um 13:44 schrieb Jing Xiangfeng:
> > radeon_user_framebuffer_create() misses to call drm_gem_object_put() in
> > an error path. Add the missed function call to fix it.
> >
> > Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>
> I'm pretty sure that I already reviewed the same patch a few weeks ago,
> but it looks like it never went upstream.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Maybe add CC: stable as well?
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_display.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/=
radeon/radeon_display.c
> > index 652af7a134bd..1d03ec763604 100644
> > --- a/drivers/gpu/drm/radeon/radeon_display.c
> > +++ b/drivers/gpu/drm/radeon/radeon_display.c
> > @@ -1325,6 +1325,7 @@ radeon_user_framebuffer_create(struct drm_device =
*dev,
> >       /* Handle is imported dma-buf, so cannot be migrated to VRAM for =
scanout */
> >       if (obj->import_attach) {
> >               DRM_DEBUG_KMS("Cannot create framebuffer from imported dm=
a_buf\n");
> > +             drm_gem_object_put(obj);
> >               return ERR_PTR(-EINVAL);
> >       }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
