Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0793662A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 01:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhDTX5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 19:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhDTX5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 19:57:10 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654CCC061763
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 16:56:38 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so32326538otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sdH2eLsN/T4FPLAS3vSHNhFsKsAJGVwX3hswXoseQrs=;
        b=T8DM8LMHHxNR+xL04MypQHCUOpnUSxwcsohbH7C/xAssA3/Ocj27flU8eKIZflClpR
         PWM1gsP2J2KzBuR2NdX+i0DQVZbVpqkshYGm1sZ+K7eQxGO216DRSMP2CAKZDxASKpKg
         kMNkzemaBhRD4shnYdjNmKclUKvrdirMd+J3Zcgna/cWH14zIhCzfdbJuIezF/v0Q91/
         qIFZ8scZQLDFr8lcyq5r3WHTH1wg99Dd9oY0Na2LARByiHBVOYezuPO5Elt+n+Fn4ptB
         uvGDlJdDXFRW60fRUxGJniIBIhFdArXbKuHloNbOW2IZBR+Q71HowjOwrYduKV2BrzOl
         HSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sdH2eLsN/T4FPLAS3vSHNhFsKsAJGVwX3hswXoseQrs=;
        b=TAgfwB/NQfB2aCUJnbiuE2aRXLfE2XXL0xtdYAYu5+a2fylqGnlpdp9kr4+SMUJxWA
         PT3Dqy9ioZ2+2h/LKgCKMaMJRIa6e23PHCwGw1YRaJU1A3GXreGPjaTYzZVuxWs0VUW4
         aYtzxn76ZiWEmwz/C30ZPw89sbI3KphelabsGXpMmqOn6Wv1oC1hX14atTNwBHmt5C1f
         CRSmpFjdjftccrtgFH6qSzHB9awI9dYTT/p99rvQXh733d+o6GCuPSgrPITChcEIEupN
         2zdJv//y74+JUQd3Vacd3PIpnpAD9Tm7f0Xjjy01Eo7BqmKLZYWIxTB0V16tZ7xoMFzL
         5U3A==
X-Gm-Message-State: AOAM531HEu0osa/HpVpcvRcBOtgVPqb5UQMy/taWCgqoR7AfaOFrwCoB
        n90eV7/QkknRqCMREn+fG2htf+fDt77afaAgc/8=
X-Google-Smtp-Source: ABdhPJzGm4OklrZh8TLIZOWNex83qTUhrLP0gk1wujZgV3tbg0zGCwXxN0idchvfqSfFWqD+Dx0mTXqsCFioQfyVYAc=
X-Received: by 2002:a05:6830:15d3:: with SMTP id j19mr11441916otr.23.1618962997888;
 Tue, 20 Apr 2021 16:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-26-lee.jones@linaro.org> <a368fff1-88a8-1515-6bac-5fe51eb0e059@amd.com>
In-Reply-To: <a368fff1-88a8-1515-6bac-5fe51eb0e059@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 20 Apr 2021 19:56:26 -0400
Message-ID: <CADnq5_NO1gOWVg_n6UjZSw52J7M44P35RAVNFOeR7tLLZEA41g@mail.gmail.com>
Subject: Re: [PATCH 25/40] drm/radeon/radeon_device: Provide function name in
 kernel-doc header
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Lee Jones <lee.jones@linaro.org>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Apr 16, 2021 at 11:51 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.04.21 um 16:37 schrieb Lee Jones:
> > Fixes the following W=3D1 kernel build warning(s):
> >
> >   drivers/gpu/drm/radeon/radeon_device.c:1101: warning: This comment st=
arts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-gu=
ide/kernel-doc.rst
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_device.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/r=
adeon/radeon_device.c
> > index cc445c4cba2e3..46eea01950cb1 100644
> > --- a/drivers/gpu/drm/radeon/radeon_device.c
> > +++ b/drivers/gpu/drm/radeon/radeon_device.c
> > @@ -1098,7 +1098,8 @@ static bool radeon_check_pot_argument(int arg)
> >   }
> >
> >   /**
> > - * Determine a sensible default GART size according to ASIC family.
> > + * radeon_gart_size_auto - Determine a sensible default GART size
> > + *                         according to ASIC family.
> >    *
> >    * @family: ASIC family name
> >    */
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
