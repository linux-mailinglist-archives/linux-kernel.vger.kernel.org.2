Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCE3461C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhCWOqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhCWOpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:45:43 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A660FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:45:43 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id z15so17254618oic.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ot2VgT3jS1mJCKLMJwUsvVHjYoW0mNerejw5COyXqTQ=;
        b=EFm7H+qo+cSFqvwSwjlazg8pGbQ8pMT2IKzgMKHkP0J6vL9fj6dV975WB6xO0CvlaS
         vHD41m+HrRdVjXBf3BM794Jh0Jilxdbw+3chbj0ImAfrw+QBNmAed96dvYT+AI+UnB16
         61dp8tvaR/C4RP0k0A2QPwgt7Ds/Y/5HLD7r0doY84uFZWNHNLawtd5bziC8cBLVYqzG
         sv81bsudTnTpV9d/zVqbE+V9vU69jMCxPWU6sHfFC4QjMULQR/lQzzOiKcb25KI/8MgK
         HW6y3HQyZgslBWaD+h+QTjoC657TTk4FN/Ay0S9ppVUGX3OhQvaYkHAlTWFt6rANAp/i
         208A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ot2VgT3jS1mJCKLMJwUsvVHjYoW0mNerejw5COyXqTQ=;
        b=GcxEgs8OywLnBje1xwV1xEqwC5TmpzfyUOAD0+1RDKbVWhcyrD8D5xsUKd3l90UGNF
         FFUhqM1DHAUee+xYDONUmBBZ9Bc+bjoCgcrhSPHsq6U5KgF2COt66mtaGF/rjZArkH6c
         nbAiZEY6QiBzo9NkmQpKVxi40fSTzDgLPAoOzopX6j97N1G6DV32WaaVExzaFNpZISGZ
         Q+UF+sSR0+ewT+3E2RMOsGqCV/8VuFTIIrjGkaKjIGnlWyD4zy9m5yTMQE6iBXRiLcys
         /+8zkYs/kxujVxAmA+KdqGBccTZVq6F975JdBxdUxYKx3RMz0iQUBVC/V2tU1Gyldx02
         0xCA==
X-Gm-Message-State: AOAM533HvQEMA42arUSToTekTkM80irjSKykbw26pBvs1IjovIwnTda2
        rdHh69ZzTpkLSWTTL7jLgyn5Zl4ivoXpAJ7U7tE=
X-Google-Smtp-Source: ABdhPJwMSL/FjLLqaSjPX0XwgrVcownXwcjvWEdZfgbYV4mn6WnQoBpWSRX+78RnOomObI0IhxFr2gWFQbeWc05L10g=
X-Received: by 2002:aca:af10:: with SMTP id y16mr3576679oie.120.1616510743152;
 Tue, 23 Mar 2021 07:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210321151907.367586-1-ztong0001@gmail.com> <259c234f-ca6a-7f9a-8df1-69055f2fc1b6@amd.com>
In-Reply-To: <259c234f-ca6a-7f9a-8df1-69055f2fc1b6@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Mar 2021 10:45:31 -0400
Message-ID: <CADnq5_Njn4SxzhLOc6rUwFv1b0AsSmP7-KWONBuxiGMaQ-FpLg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: don't evict if not initialized
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Tong Zhang <ztong0001@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Mar 22, 2021 at 3:40 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 21.03.21 um 16:19 schrieb Tong Zhang:
> > TTM_PL_VRAM may not initialized at all when calling
> > radeon_bo_evict_vram(). We need to check before doing eviction.
> >
> > [    2.160837] BUG: kernel NULL pointer dereference, address: 000000000=
0000020
> > [    2.161212] #PF: supervisor read access in kernel mode
> > [    2.161490] #PF: error_code(0x0000) - not-present page
> > [    2.161767] PGD 0 P4D 0
> > [    2.163088] RIP: 0010:ttm_resource_manager_evict_all+0x70/0x1c0 [ttm=
]
> > [    2.168506] Call Trace:
> > [    2.168641]  radeon_bo_evict_vram+0x1c/0x20 [radeon]
> > [    2.168936]  radeon_device_fini+0x28/0xf9 [radeon]
> > [    2.169224]  radeon_driver_unload_kms+0x44/0xa0 [radeon]
> > [    2.169534]  radeon_driver_load_kms+0x174/0x210 [radeon]
> > [    2.169843]  drm_dev_register+0xd9/0x1c0 [drm]
> > [    2.170104]  radeon_pci_probe+0x117/0x1a0 [radeon]
> >
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > v2: coding style fix
> >
> >   drivers/gpu/drm/radeon/radeon_object.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/r=
adeon/radeon_object.c
> > index 9b81786782de..499ce55e34cc 100644
> > --- a/drivers/gpu/drm/radeon/radeon_object.c
> > +++ b/drivers/gpu/drm/radeon/radeon_object.c
> > @@ -384,6 +384,8 @@ int radeon_bo_evict_vram(struct radeon_device *rdev=
)
> >       }
> >   #endif
> >       man =3D ttm_manager_type(bdev, TTM_PL_VRAM);
> > +     if (!man)
> > +             return 0;
> >       return ttm_resource_manager_evict_all(bdev, man);
> >   }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
