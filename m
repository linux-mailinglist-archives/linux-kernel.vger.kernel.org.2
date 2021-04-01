Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE235352162
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhDAVPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDAVPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:15:40 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C515C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:15:40 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so3374442otn.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mz7i+O/62DXgGIQyQsg18R3Fvz4BySpF9dt5BSlgKK8=;
        b=EvINbiO5R9MEULvTambjfGRw/tggaCs6bGmgVlfnQ7EYfraVpcPhuVPvf15SpEqwIA
         x2SM2sD8JrCgB8leKbD2u0UFdCNZGUD9dXtR+AMaVjMXv8SkVyAlcyxMzmV/dknauBVP
         tUGfa3cSqdGoPDuTn7gXG9rQ1+8XPNYSyftQAebbFF3g0sdC2BFU1k8pz1SsAQYS095Q
         c28dAsQnSKv/OVKqpUbboI6WP5Ye1fCtaNneik0QTYeKgAYF9x3hlKqUqw+fUyWF4upe
         WG/QkSOq/qitsybcG/jGtGzOAOBzgZO0cHVj3WNmL3wZ5qxpw2CO5YnbE/KBi06evgBJ
         7W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mz7i+O/62DXgGIQyQsg18R3Fvz4BySpF9dt5BSlgKK8=;
        b=B7MkfYkYBVQgvHvyeQPprdao5qhrxX2utlplzRWJQS1M+OGEIlWQz3UqNF/XWjK+0d
         gVz5FutTff9WFZ0BhSvUgm8Ahm4JJe7MOvGPQOynJmdyy9IDkBwCPdFABoCj2DOMNHH4
         fm3HotMvq/9YkSkZ4yOeFs5jToMXIXYbwNF7siC+oaOc4YJE0kBxPFoGbUTZlrOFa5Xi
         4jsvAznd4I0FY7ghbll5ScFA0ZHaFDDb7Y/dO/G4L6r0RIaQswVuzUFOYpPOQzbabxgI
         NKhli3jeZkWCoG/e0Jks2aofWnPJaDcEdLmTNY1AI45WSuEQfC+UjexEQnPfj+Ffym+Y
         +lMA==
X-Gm-Message-State: AOAM531b9CZix+UtWvNxPwBnnlNZSM7ARpPh522905ATJGtmBylYpU7a
        yxS080tAI0YfyXZtZ4DUSawWl4zGQagKBNydnkk=
X-Google-Smtp-Source: ABdhPJwIGFK9P8QDS7j0r2S0z8pKk2Wh3QtwP8CPlBpqBbniOgq3YXMIAV9/NOXJYPtybSuUj4XTX7uBFCk+yDYZcE8=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr8507614ots.23.1617311739900;
 Thu, 01 Apr 2021 14:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201024004706.24518-1-linux@rasmusvillemoes.dk> <d09f16d8-528e-2815-8f26-ab85c27b1fea@gmail.com>
In-Reply-To: <d09f16d8-528e-2815-8f26-ab85c27b1fea@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Apr 2021 17:15:29 -0400
Message-ID: <CADnq5_PLZoz0Ns0i8ur2i6YY1H==g+WRvFJZ6K3EDDvd9Qfmyw@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: add __user annotation in radeon_ttm_vram_read
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code already contains the fix.

Alex


On Thu, Apr 1, 2021 at 9:09 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 24.10.20 um 02:47 schrieb Rasmus Villemoes:
> > Keep sparse happy by preserving the __user annotation when casting.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Going over old patches and stumbled over that once.
>
> Alex did you missed to pick it up?
>
> Regards,
> Christian.
>
> > ---
> >
> > kernel test robot has already started spamming me due to 9c5743dff. If
> > I don't fix those warnings I'll keep getting those emails for
> > months, so let me do the easy ones.
> >
> >
> >   drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/rade=
on/radeon_ttm.c
> > index 36150b7f31a90aa1eece..ecfe88b0a35d8f317712 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > @@ -1005,7 +1005,7 @@ static ssize_t radeon_ttm_vram_read(struct file *=
f, char __user *buf,
> >               value =3D RREG32(RADEON_MM_DATA);
> >               spin_unlock_irqrestore(&rdev->mmio_idx_lock, flags);
> >
> > -             r =3D put_user(value, (uint32_t *)buf);
> > +             r =3D put_user(value, (uint32_t __user *)buf);
> >               if (r)
> >                       return r;
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
