Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCFC343327
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCUPVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 11:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhCUPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 11:20:51 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8B5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:20:49 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c17so12566946ilj.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iveq/InwG0NxRodieZpwalqg0AiIbR/FGTza27sje0=;
        b=U5pUfTYFylM3ZfFzbk0ZGABNL3nP+UgnVGq/byUUlCFZo7j7h0yPanbrEAq6quQGiG
         7OaOgxoXU8zhuqKqZjyeWlbBD6TCS8f9iXd+VHGktbLb9n5S6hWXGMHTEHyNykfaBSre
         w0p1YtHFefHX+EY1vxfWR3uQTMiE5NEEp2QAhoCVsuNBq88VLJ8Vb57+cmwkJwAviSG2
         yk/wRhQpbrO+8pM5exPiolJW9dHyY31uz5uk4jLcWWg8xdy0bCJ+PlYEqdRyskVmjC7r
         PclTC2AD7nlVCINnHDspHGSXkJ3Iaq1Z4NRGXJJ9FZzJevC1hEgI6+IzE0X1HZNdMqGo
         L/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iveq/InwG0NxRodieZpwalqg0AiIbR/FGTza27sje0=;
        b=VXUO8l9zk+G15+8KmMMtufdPDouDN3whS96omi9nLE0xdrlG7op+c74fdoJ1KMOnNY
         LRpcfs3YCcv7TPFaGnlPd6Ucwb6Z9Gn+Yspj7jBfY4dXIKmaEoT2QrCEVNZ7/y4uEpmJ
         dcNH/m1AKNl5d0/ZhyIuKkN2vkdgmMZBehzMOsmKfpmRwDDyHJtBHEZK6MpY7eg9IKsq
         pWuuq5NPutVrbTHMWZzCue5ER5D02vWntqeyjmmpK+NzeiKaFxBtmRwYxHSBlswNNYDV
         i7lzSAv8kD51lBfarJUhhfmXwtJHynKZndzaLAxGqmoV0OrF1xbX6nGeTWR+qb2Bx7Fm
         KiGA==
X-Gm-Message-State: AOAM533QAMBrIoWzshnTTRXS14jZ9bL5pbG3RcijQ2olOUGoEj0ICfB+
        cmSCIWV6a76/UWvLHaBmx7+4W1xTGu27rWposkA=
X-Google-Smtp-Source: ABdhPJzNj2lIIaszPhO1R9rGn2EO3uB5F5zPoFTWKCNBbA73YHQJnZTdQQDlsiNAFSl0Vf5IHu+KM0O8tz7YuKKudHk=
X-Received: by 2002:a05:6e02:2:: with SMTP id h2mr8729495ilr.81.1616340049181;
 Sun, 21 Mar 2021 08:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210320201052.114775-1-ztong0001@gmail.com> <d50c08e5-51d7-148c-464f-7699e6f6a115@amd.com>
In-Reply-To: <d50c08e5-51d7-148c-464f-7699e6f6a115@amd.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Sun, 21 Mar 2021 11:20:38 -0400
Message-ID: <CAA5qM4DCN1PQqyWxH3o27ixAkbWHf3so12Ba7=9gxUpdk2wkGA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: don't evict if not initialized
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,
Fixed as suggested and sent as v2.
- Tong

On Sun, Mar 21, 2021 at 9:26 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 20.03.21 um 21:10 schrieb Tong Zhang:
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
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >   drivers/gpu/drm/radeon/radeon_object.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/r=
adeon/radeon_object.c
> > index 9b81786782de..04e9a8118b0e 100644
> > --- a/drivers/gpu/drm/radeon/radeon_object.c
> > +++ b/drivers/gpu/drm/radeon/radeon_object.c
> > @@ -384,7 +384,9 @@ int radeon_bo_evict_vram(struct radeon_device *rdev=
)
> >       }
> >   #endif
> >       man =3D ttm_manager_type(bdev, TTM_PL_VRAM);
> > -     return ttm_resource_manager_evict_all(bdev, man);
> > +     if (man)
> > +             return ttm_resource_manager_evict_all(bdev, man);
> > +     return 0;
>
> You should probably code this the other way around, e.g.
>
> If (!man)
>      return 0;
> ...
>
> Apart from that looks good to me.
>
> Christian.
>
> >   }
> >
> >   void radeon_bo_force_delete(struct radeon_device *rdev)
>
