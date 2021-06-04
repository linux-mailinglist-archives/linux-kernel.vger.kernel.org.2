Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193EB39BDD1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFDRAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:00:30 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39849 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFDRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:00:29 -0400
Received: by mail-oi1-f172.google.com with SMTP id m137so6506916oig.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IN3SgezFLQfNZ7veTbzUM3bPaQ1v48sm/05DwTa7/PU=;
        b=tBcoFOsv6b8ruMCJzxqbZ7QxP0UdsQMhL22S84VurvWGPoKPkq0mm2qfBbxR5v5iHR
         kUqCVUVnxX0ZXiUFFV5PzTNR/SqTFJkZYe7g7OeCa6ODdLxm7Zxc2e4kLHG36z/A5gcL
         39XoA+F+kyAXsS+gxPws9Hwlswz0/oe0ZJBDWro/VPTilrdWQ2eqr9WT5vcV6UvrVABw
         VbofKoss8GTut/9QzqOLoPlbK7O8MXGQ+r4Vr6xOqedV461uOlR2Kn357m7PE1gURvKJ
         vTagEoDcDW0z03oWaiVo35xr6K20QNYslFjo4fvU42TQRr8/cf1aJyh0GVrFHXPVaUUY
         3FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IN3SgezFLQfNZ7veTbzUM3bPaQ1v48sm/05DwTa7/PU=;
        b=RrA0Cb3qI6VbT08tyaBo376BT4Q8RaANOMbmQGJ1dHWAWWfyTF32zmABvTWTwyGyQy
         rOMnHN7UkuzZHhf4Ow7wcsJDUVeHhgiL9Qw/wQKYlaf58WvFLs5TdqIgkdQuKKtzlVgk
         2l/kxXCTB68j8jG/lC12ggn++rTy4YLSIhxH4mzBWik3c/yA7hXGALafu9cht50ZZxZW
         SOLN0LvuLcjfwkvc7MpqIg8lSxgw1lQhhPd1iMln46n958g3OEInwC/8445O9F8FhYVx
         CydBpY5CaxgcErPM2qFkrqItb2x7gRgYSCxN3CtTArQoO7xkdjkfAfGnYCZmsIm2Q4D6
         jHeg==
X-Gm-Message-State: AOAM531ycN6mVx+9KvkCi1lyTEQXCEmo2Z3TEO86LEcAwcQt3k9P4keN
        +Hnls1O0SXZ3P2CGiLcRROA0NfXygnyNCBkf4wQ=
X-Google-Smtp-Source: ABdhPJycUpGDHDmpx2H0gKioVDhBClmCP6ZvzuaN3KQq9J2gvL7XNOsEat8k57/mMr8h9vtahb00hVhbvGi77TBEjXI=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr10953538oie.5.1622825848035;
 Fri, 04 Jun 2021 09:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <1622690940-10972-1-git-send-email-wanjiabing@vivo.com> <3d7fcdb9-990b-270b-f87b-d7fe157c6b2f@gmail.com>
In-Reply-To: <3d7fcdb9-990b-270b-f87b-d7fe157c6b2f@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Jun 2021 12:57:17 -0400
Message-ID: <CADnq5_M5p=id9EtvtNGQyM6QC6QJNNWuraMi1LyoUZir6vUeZQ@mail.gmail.com>
Subject: Re: [PATCH] drm: amdgpu: Remove unneeded semicolon in amdgpu_vm.c
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
        Roy Sun <Roy.Sun@amd.com>,
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

On Fri, Jun 4, 2021 at 3:03 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 03.06.21 um 05:28 schrieb Wan Jiabing:
> > Fix following coccicheck warning:
> > ./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1726:2-3: Unneeded semicolon
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 2460371..231745b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1723,7 +1723,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_dev=
ice *adev,
> >
> >               amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SI=
ZE);
> >               start =3D tmp;
> > -     };
> > +     }
> >
> >       r =3D vm->update_funcs->commit(&params, fence);
> >
>
