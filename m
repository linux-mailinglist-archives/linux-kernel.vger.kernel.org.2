Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA434F67B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhCaCG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCaCGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:06:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BE3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 19:06:01 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v25so1917830oic.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 19:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qeMcdT+CRbj8MN9wl9Xvhljc1oUDZd6u2VZN7SlxQEo=;
        b=rKlvRdGzaGNJW+L/dG8PZfKwqYB0SVrNLrkpqGi5JtMmVhR0ektQBTOpn4t1ZGmqia
         cHW2kYB0zVWYh4d9Wm+wQBy4Afu6m3SGfVEoygnk0BFYcKh6UJYQnnEy1xB5828e9I6I
         wR7B5GQmdS3q67/oyOeVVtb1GQj12BRjcC6PkntB1mrDskOGGQI2oTSPqPnvKcHXCYBs
         ukJp+PC8wB0QQZwp3Wbv/p1pmpj32X6S6g8PAWCv1zTdUn0H0cqXGf7Rhws7IgJoyLJx
         +F8j/88TnM/FoNgJrT2DZwJnMz6qfWKGPT80FOMflB4EBr2Qo2EQtkSMj1a++59G64m9
         GAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qeMcdT+CRbj8MN9wl9Xvhljc1oUDZd6u2VZN7SlxQEo=;
        b=N0KwP2fY+0nc/bXz7Pb+yddi5GDVnijnTeJCzRz48pEIVe1heh7vYxPpl+RsKVy+US
         GyO7AZdm6YZJ4Wb4zn/MloQ4nDbqjoSA+8JItfbvvR9zxMr6RDXBaWYMKyMqHYGeA7Sq
         ZjpkoR6iikY9+xRwaSYi8nCPfLb0yKoac+5IPkh1gWfQbi0xJwVh1achG/g852kpwd5L
         w35S5jQHK6gjHg5mUJTuY76Q24ROwcZ/E4z+WNEE5aWuKV+exCGWvbDDbY8dw79zVNPi
         3BCE/XmB7pJTqN684Hz4N0iGRbJfDCXNaRppfj0soIYtvw6gbfPAy/opdEkgLerBLDae
         6g2g==
X-Gm-Message-State: AOAM531cit6fImXgZKgTvbqzK5alubc3MJHpnLTVslhF45YkWNdeNUpA
        VSArFrq9ETUuaNK4yHl2UyoR+038aFAKmL5pDAqctTRs
X-Google-Smtp-Source: ABdhPJz7DQZKRIQNF3Y+MK+QaA21Mi5zD4MaBqzLOHoMYHnmGevqb1Ge9xnPgseX1xda/SqjnVuAVJU2ggjpXK2Mhm4=
X-Received: by 2002:aca:4748:: with SMTP id u69mr594782oia.5.1617156360659;
 Tue, 30 Mar 2021 19:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210330153334.44570-1-xry111@mengyan1223.wang> <7c5e3a40-9889-1cc2-583d-51f8c3294908@amd.com>
In-Reply-To: <7c5e3a40-9889-1cc2-583d-51f8c3294908@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 30 Mar 2021 22:05:49 -0400
Message-ID: <CADnq5_MrsQfyS6eJdPrJEyHUQCM1=pP=jre7Ur6D8ULQj00P2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] ensure alignment on CPU page for bo mapping
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?B?WOKEuSBSdW95YW8=?= <xry111@mengyan1223.wang>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Dan_Hor=C3=A1k?= <dan@danny.cz>,
        Huacai Chen <chenhuacai@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Mar 30, 2021 at 12:21 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the enti=
re
> series.
>
> Alex will probably pick them up for the next feature pull request.
>
> Regards,
> Christian.
>
> Am 30.03.21 um 17:33 schrieb X=E2=84=B9 Ruoyao:
> > In AMDGPU driver, the bo mapping should always align to CPU page or
> > the page table is corrupted.
> >
> > The first patch is cherry-picked from Loongson community, which sets a
> > suitable dev_info.gart_page_size so Mesa will handle the alignment
> > correctly.
> >
> > The second patch is added to ensure an ioctl with unaligned parameter t=
o
> > be rejected -EINVAL, instead of causing page table corruption.
> >
> > The patches should be applied for drm-next.
> >
> > Huacai Chen (1):
> >    drm/amdgpu: Set a suitable dev_info.gart_page_size
> >
> > X=E2=84=B9 Ruoyao (1):
> >    drm/amdgpu: check alignment on CPU page for bo map
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 8 ++++----
> >   2 files changed, 6 insertions(+), 6 deletions(-)
> >
> >
> > base-commit: a0c8b193bfe81cc8e9c7c162bb8d777ba12596f0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
