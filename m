Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107B933192C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCHVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCHVPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:15:05 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC60C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 13:15:05 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id d20so12516279oiw.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 13:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bK1egWRIYmAM57JGkevuvF9LMdJfxUITtPUiQtDDxH8=;
        b=EenPaZb8C5Pijx6LJUC0kSF/ossy/pi8y6ZPOsNrLIEGnRwr+gDjWinvE/IfeHPl0B
         Kwqh/gBucHSUJfPse7F9QsHL5OVGBnSGQKBvNrth5IPfVHFNyAmfGDaYvPsFCY8eKkYv
         25ug1JFNnNqDwSqXhPd0HUU13YhGyUgxMOVAT1MU7U4Z+1YfDTV3KW3E1ViLyLdhUkBV
         SAD5oPTvLGBS5fHJQG28JKAG4kv/V74CAvHXT4uTHKMVl7klbfdMvgelxr1ug53dP26X
         6F0sQtG4CBIVgJMwx5RxRaIkQXs4YjFcBFuQUz/WOVlptAMzm6R85WPpyqUIMnBigfch
         JLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bK1egWRIYmAM57JGkevuvF9LMdJfxUITtPUiQtDDxH8=;
        b=a0w8mE8r8yE0N9/MzC/KTx8XcUVlJ5WBYStslJY993aszfXK/soXU9F+bh7esqWHH4
         L8qGLD3G9EO6YSYadHgiEzWYy5+96maCGmzFkmVi5KS+4Z4oq8VZzH6w0FwcJnqrGLGE
         gAAASfFG7uWKgy6cOuOsT7KxohPvEMSkqxM7fnzam+8/GndwKaZkdBKCCVnn0eydegZG
         U+24a8KEtgcVgUPjcX/EkeYvqyM/lkBpVDLc935xuvwMJWYE1p3BodoNUAle09Zr0Snl
         dsYLqIriQnUSFhCl5nA2/TmL/Ae73KWL9PhMyNYzNEoGZoJeXrXyC/X3Z8VelReEvMtv
         eDhA==
X-Gm-Message-State: AOAM532khsgvbZkjKDnG6fu3ArKhS+yA2EbOKhOenRAbYi+b00YOCsMp
        I8HJFrAp/IN3aZYemb28DP9ITpWyufBxgl9Up8o=
X-Google-Smtp-Source: ABdhPJxScjMLq05XElf34SOT5GTz4dxjnLMllur9XID5rsea9TR6bipOie5rALc2/DMyuKzAGrR7QNAHzksvpQaARGw=
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr606723oiw.123.1615238104977;
 Mon, 08 Mar 2021 13:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20210305035428.6750-1-baijiaju1990@gmail.com> <DM6PR12MB26198FF9499CD3ADCCF93546E4969@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26198FF9499CD3ADCCF93546E4969@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Mar 2021 16:14:53 -0500
Message-ID: <CADnq5_MquFxnRxLrfjrUL_jcj6fSi=5ymuDS5ovMRiBJH3odMw@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: swsmu: fix error return code of smu_v11_0_set_allowed_mask()
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
        "Gao, Likun" <Likun.Gao@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Mar 4, 2021 at 11:02 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Public Use]
>
> Thanks. Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> -----Original Message-----
> From: Jia-Ju Bai <baijiaju1990@gmail.com>
> Sent: Friday, March 5, 2021 11:54 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; airlied@linux.ie; daniel@ffwll.ch; Quan, Evan <Eva=
n.Quan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Kevin(Yang) =
<Kevin1.Wang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux=
-kernel@vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>
> Subject: [PATCH] gpu: drm: swsmu: fix error return code of smu_v11_0_set_=
allowed_mask()
>
> When bitmap_empty() or feature->feature_num triggers an error, no error r=
eturn code of smu_v11_0_set_allowed_mask() is assigned.
> To fix this bug, ret is assigned with -EINVAL as error return code.
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 90585461a56e..82731a932308 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -747,8 +747,10 @@ int smu_v11_0_set_allowed_mask(struct smu_context *s=
mu)
>         int ret =3D 0;
>         uint32_t feature_mask[2];
>
> -       if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->f=
eature_num < 64)
> +       if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->f=
eature_num < 64) {
> +               ret =3D -EINVAL;
>                 goto failed;
> +       }
>
>         bitmap_copy((unsigned long *)feature_mask, feature->allowed, 64);
>
> --
> 2.17.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
