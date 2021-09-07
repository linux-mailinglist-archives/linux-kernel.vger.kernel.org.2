Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3466402D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbhIGQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345481AbhIGQ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:59:32 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB8EC061575;
        Tue,  7 Sep 2021 09:58:24 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n27so13646322oij.0;
        Tue, 07 Sep 2021 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SvBBnr80NWkvIsim2a+nqfVn5CtPkVnz5CJmaxVXNrY=;
        b=Abd3ZEMoBaLVMobq1zM2GvTELFuBOdk0S3vpbSCxkgJNnKeu+2tR5aK7EHe5z1W7u/
         Y6wly0x/Ke3x94C4VGIo6nZklRVuFaMh0aCZ3zm/HRCW9tLGkZMvzKw0RPEiEjUrsFF2
         nJHJJI/y/dSSmMneRYatqOF9FtuEXKLrYgQp8dSwtaoeIA0LJjxhcSLMS0fPvt0jHc+1
         wEukmpABWoOV0D8McUMdS0jW74Is6mblYGKY9ZHgdfhTn4V1CexKgsUMaOhOT0gzyPZT
         MHQDHeZOZHqDKOi4NReUMYcnLTKwR4L/ENUH80tqRrKp9kipnZRze6toFyi7ENCblZ2h
         /rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SvBBnr80NWkvIsim2a+nqfVn5CtPkVnz5CJmaxVXNrY=;
        b=kTdjMFO36D9k9sIz3XTnbQp6P74wS4FXuqCEtyA/HI7DaC5rmAiu3GJji9VUykBnRi
         mVbB110hi6pZGcNdQYVwQ74MyGr0F0FQpCQORYgEIdVcDxvGWjZfilg+KsvLQVEpYfPk
         OBexVLn2St72yGj/MVC3UWtdCqk3NlNfjC8xjmC+n9u5YRGX1ThjIH8ZT1fXLBMT2Dei
         f3KOGALS4Wb8KgLpTA236kJTM8SZ/w+9643K/OGVg4DtTk25MZ77uBE8Zti0jyvKXBlq
         vhZ3IuvFp6CmPsoua21edmbKSnviknKIXReWtK9BufUtfqad5fs22VO069Xnwdue8w6v
         9Xeg==
X-Gm-Message-State: AOAM532rIe87x52P6QfSRpefmhci7JKteisvskSRe+uCOOTO6TT4EV59
        8knPaKqU1n5Y6B/lWg0gI07p8vEZYqGflYI1wjo=
X-Google-Smtp-Source: ABdhPJwX8AvM29XUfK/LG2v17nA8C38ihZmRL2Sr0hMbXUNbjSSiBrR/yt0fFsp0N/OneIDzRpPT8sV003ExuGTJp2c=
X-Received: by 2002:aca:ab06:: with SMTP id u6mr2611956oie.120.1631033903838;
 Tue, 07 Sep 2021 09:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210902214510.55070-1-colin.king@canonical.com> <62384d80-8ef8-35bb-083e-61036d989efc@amd.com>
In-Reply-To: <62384d80-8ef8-35bb-083e-61036d989efc@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Sep 2021 12:58:12 -0400
Message-ID: <CADnq5_NgVEO6JhSmY=Fyz0QVjt1gYLmPb1G7u0k4aGp37+Vf2Q@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: clean up inconsistent indenting
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Sep 3, 2021 at 2:31 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 02.09.21 um 23:45 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There are a couple of statements that are indented one character
> > too deeply, clean these up.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index d6aa032890ee..a573424a6e0b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -60,10 +60,9 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *=
vmf)
> >                       goto unlock;
> >               }
> >
> > -              ret =3D ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_=
prot,
> > -                                             TTM_BO_VM_NUM_PREFAULT, 1=
);
> > -
> > -              drm_dev_exit(idx);
> > +             ret =3D ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_p=
rot,
> > +                                            TTM_BO_VM_NUM_PREFAULT, 1)=
;
> > +             drm_dev_exit(idx);
> >       } else {
> >               ret =3D ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot)=
;
> >       }
>
