Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE76D346221
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhCWO6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhCWO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:58:14 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:58:14 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so4999200ooe.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OStDH/D377UMcgi9v6LDjP8DqC/uToi16zyd57lRDnc=;
        b=Nyx1fjXcz9tDHbOF5AKsnvYU1EMZAY+o/6UBsTK99ynu4SqsQakCtDZ1wxaJFV+p85
         M5HyWjTxRdXGA2qaRiLitOsKfuZ3YUdXeaEEzQeV8JhNjEaQXty93cWsnEEhQgHiLyiq
         f8tuCOJktuxFag+vZjhLCReBjXmTJk8/OX58gXPK0JSZHp4MSXG22DMtyAw/he2rUyIs
         dC8HhALyfJO/JSzPdsTpJDGsbvllk4D7JBTVgs/qMO/tQA6BuRGtW2RmwoieCeYiD5lm
         7Rf0RtR0D7Q07MAR6IsDaEXhdMcploJ+xh8sz3ta4cX9xF+qiochtH+KoKxrB1M+tyP7
         7v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OStDH/D377UMcgi9v6LDjP8DqC/uToi16zyd57lRDnc=;
        b=IM+0Yj8EYtArvt07YSVYVOkqmm+I2h9EjOEeWytJ0jtnsQW799NfLqIplwGRY1V7Ea
         KqpyIDp3TsLsidjcPD7VxJq30qCBGpKxpfzLVnqNOMyhSqXaAwJnIj+dg0rqZc9Ln353
         guvl71eaQY0xXXRzLCXrCNwqGJy60me01CPCVzA+WhyJuANcIP+1ONDfJtNoGk2yPn9z
         LTCc1r1wusz6ep3HGxUaga1g0p/bYARkABHNcgfw/+zcK2bNM4WqXqnA27jGGGR1mh1I
         HamYWyddbhuN7XQEon9HG72HuHYlsb9rRPuQoJAHiajFNbW8oOPXbwj8w/N3fttKI2th
         OG0g==
X-Gm-Message-State: AOAM530c2HQWypc8HCW4CFt2ELNYx5lSf+Mjyt2fjZe4LTOqvgEIWqly
        WiZqz71/Z/QSaG1Iv6ovzbDtk4lbsgWq30ko9YM=
X-Google-Smtp-Source: ABdhPJxjbnFrI6rECBfC1TqAKH6QGuLkdSIAT4vPaebNaRg199psAdzkQWQ+6TeVzG4PLlydH4USY68uvP0zSMEAd0E=
X-Received: by 2002:a4a:4005:: with SMTP id n5mr4143613ooa.61.1616511493663;
 Tue, 23 Mar 2021 07:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210322120227.60953-1-wanjiabing@vivo.com> <de34c5b1-1827-cc91-f719-a36a33717cb9@amd.com>
In-Reply-To: <de34c5b1-1827-cc91-f719-a36a33717cb9@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Mar 2021 10:58:02 -0400
Message-ID: <CADnq5_MVVvvuz+WfTVZFn31nb0YgK=BmE+ZuwvFvN+La9QO32A@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpu: Remove duplicate include of amdgpu_hdp.h
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Mar 22, 2021 at 8:10 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 22.03.21 um 13:02 schrieb Wan Jiabing:
> > amdgpu_hdp.h has been included at line 91, so remove
> > the duplicate include.
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 49267eb64302..68836c22ef25 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -107,7 +107,6 @@
> >   #include "amdgpu_gfxhub.h"
> >   #include "amdgpu_df.h"
> >   #include "amdgpu_smuio.h"
> > -#include "amdgpu_hdp.h"
> >
> >   #define MAX_GPU_INSTANCE            16
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
