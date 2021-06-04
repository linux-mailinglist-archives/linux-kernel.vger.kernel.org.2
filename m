Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D69C39C1CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFDVCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:02:24 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34677 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhFDVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:02:23 -0400
Received: by mail-oi1-f174.google.com with SMTP id u11so11057339oiv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hcL1duf2cmVS2FFozNPUZ6B5aiW4MPId9J+rVmkQUYk=;
        b=Y3QUX1ZAvnl/3ato47zA/tKEluRFWys/uYy3LhRgHryxJy2v3HpkGSBbNRtRMeFYv/
         ygX8EevDFP1KKbg1U2360M0YCC720fLNFdPjNlRkeqlJs1HSqOFPDZRYpiLcy+j2K5+D
         3vcB/6sobewdj640tdMhp4agMFL8k3XJzAE8zJS75Z/gEBQ2vhZeg4dzDb54oBcKxnHt
         OSPTZ0/CaLJlC0rZRtm9tWghIbGTcd8B3KSN+0oTMRrkqzTwqmrIEaOQLT2vgDfkfTeE
         hWPaCj0fH+m2+XE5/THM8CXTNPd73SeWW9RO1wE1eLKtsGrmDRR9bNZ3AV0cZj2ZZ173
         RY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hcL1duf2cmVS2FFozNPUZ6B5aiW4MPId9J+rVmkQUYk=;
        b=QDpQcjbVEgN7eA9dJFqEhesqJ4attGKF0xMyLDpu5YGxhSPzHvGHV4wj8fjUBPEXvK
         VyJ2Ea7DCTDYwSyp5hzkKMrom+jWN7E0/a55E2pxKok/WpCxgAnwY/C1dDObw1+f8P8B
         qamDlLhCQhJzJ1vsLQyJbSHd2oaWh0/0yGyoqxA6qo+dZ3Bf3Zb1siLC7a4Ejg/6xuMq
         edcyEITbPQ0sa3+UduA6ovYH0as3BqjftirtirWDB5pz4D9fNngx7SDyvw7zoLpbfrEs
         wpYNgVAQYI/JIBT/S57ko/ymfatTBibhLEM0+GguGaM32ej877m20gGQDi5WtWsM0+TI
         +UNA==
X-Gm-Message-State: AOAM533LfT21uPDIbhEGPDUgJefZFzCw5WOuA+bmSKZulUyawbtaHg+9
        5CbRnUxnjiZFl7Hp7PPv25tBsdsBHs2+LcLwREw=
X-Google-Smtp-Source: ABdhPJw4eES4VW3g/ubIWR4XRCfecTT650bw+GiTjrYM4m9lJI5z15zWHzNxpYjZfQXlqa9fMW8UX3Esa/xQxythEUs=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr11541621oie.5.1622840361985;
 Fri, 04 Jun 2021 13:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210603160928.3854180-1-Liam.Howlett@Oracle.com> <4d2e62c7-af4c-b977-a05c-97b664b532b3@gmail.com>
In-Reply-To: <4d2e62c7-af4c-b977-a05c-97b664b532b3@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Jun 2021 16:59:10 -0400
Message-ID: <CADnq5_Nc_ifTV9mREwnQuNsH8r2LuYELvY3B9SU0Pir+HTQD8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use vma_lookup() in amdgpu_ttm_tt_get_user_pages()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 7:11 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 03.06.21 um 18:09 schrieb Liam Howlett:
> > Use vma_lookup() to find the VMA at a specific address.  As vma_lookup(=
)
> > will return NULL if the address is not within any VMA, the start addres=
s
> > no longer needs to be validated.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>

I'm fine to have this go through whatever tree makes sense.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 7cb7ffdd1900..dfb5ca3f8da8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -680,9 +680,9 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *=
bo, struct page **pages)
> >               return -ESRCH;
> >
> >       mmap_read_lock(mm);
> > -     vma =3D find_vma(mm, start);
> > +     vma =3D vma_lookup(mm, start);
> >       mmap_read_unlock(mm);
> > -     if (unlikely(!vma || start < vma->vm_start)) {
> > +     if (unlikely(!vma)) {
> >               r =3D -EFAULT;
> >               goto out_putmm;
> >       }
>
