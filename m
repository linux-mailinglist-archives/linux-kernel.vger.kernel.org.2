Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D402634134E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhCSC6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhCSC6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:58:07 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4830C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 19:58:06 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id i3so3269356oik.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 19:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RBR7Hd3ySBna/Hfik3FWd3AmVPItNtAx2VnWQfQMOtA=;
        b=LOq+TL2bJjWRXKqEvOkTdJsgKy/13MqVE36N5iMH1Bj0llQbhko0YY5JAW+ReA0enl
         lr4gz4rDVj/4Jk3iUAa/8uG/ORTBVnp8g0SqR4I4yMM+asltswR9u9V2zz7kviPO3DpV
         CKTHhOiTaI6BUu8urpk1nQS6AnXMXeWZgKbPOD3ml5LIFV2XQb83hGT7l4193kB2oOXX
         Xsf+6mOk00zsUPaVGwpwhUA4NvUUwGbPjgSRZySRYJ+HmEMmRk3mBdSeFzQuaEq2p3Zy
         ro/CvU4cZMxeci5H8MqKNQCReOSPfUJt5LIQ3xRhIsuGF+/GDPLa5u9inWRE0a+a0mys
         XQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RBR7Hd3ySBna/Hfik3FWd3AmVPItNtAx2VnWQfQMOtA=;
        b=CZMlO8rEWmxkO+Y1uaRM6XnCwnhcaEM1XrlIOFF5P+4TyubIfCEF6LYcNO86ylo/JY
         bW32T7eVlqaxbLOjKKkkNZy8+/oPvPTBNmhWCZ3pXJPzW1+E/DMpj4c960Hbnq4zQu5n
         JYa2vfnpXuc/T4ePR9mWIiezo3fOfl2URZwHq/o+agXhKawe1GtIViBXs+LXoljpcnyD
         +sCesVX32i+YBfJrJhkNowfkDraL3RytvZCP7fAbPwGOaIzTZl6UvcnYPL2lRJQfda3Z
         ky+EWkbEvKaB7z71kU4dr/JfQ+BQlr8s34N+I6abbTGi5zkcdgTK82OPaY8JTRZ+/BCD
         SmLQ==
X-Gm-Message-State: AOAM531PrqorfpqEPpEQMmXGHel2ineU2Ac7Ek4z83i89KsFZCmGcGUF
        HfLv94zg1o1xTS0r/txwrXnlOqtXjp3OrDgwqtg=
X-Google-Smtp-Source: ABdhPJx2GbinTfv76DyZyuRAxdzAwKPlKBZmrgdj9p9kzAlfdvldv5N3RtYGvTyTumpWIfrxDohF5Y61vyZWD/sX30s=
X-Received: by 2002:aca:4284:: with SMTP id p126mr5343160oia.123.1616122684736;
 Thu, 18 Mar 2021 19:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210318083236.43578-1-daniel@qtec.com> <MN2PR12MB37755DAAB03FC0065E98EF1183699@MN2PR12MB3775.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB37755DAAB03FC0065E98EF1183699@MN2PR12MB3775.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 18 Mar 2021 22:57:53 -0400
Message-ID: <CADnq5_MMTBXt50sqJvYmXWn0uBALz2fNvpSrCfjSuMa99VLa=w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Daniel Gomez <daniel@qtec.com>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "dagmcr@gmail.com" <dagmcr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Mar 18, 2021 at 5:00 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ________________________________
> Von: Daniel Gomez <daniel@qtec.com>
> Gesendet: Donnerstag, 18. M=C3=A4rz 2021 09:32
> Cc: dagmcr@gmail.com <dagmcr@gmail.com>; Daniel Gomez <daniel@qtec.com>; =
Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christia=
n.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@f=
fwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dr=
i-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-kern=
el@vger.kernel.org <linux-kernel@vger.kernel.org>
> Betreff: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
>
> If userptr pages have been pinned but not bounded,
> they remain uncleared.
>
> Signed-off-by: Daniel Gomez <daniel@qtec.com>
> ---
>  drivers/gpu/drm/radeon/radeon_ttm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index e8c66d10478f..bbcc6264d48f 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -485,13 +485,14 @@ static void radeon_ttm_backend_unbind(struct ttm_bo=
_device *bdev, struct ttm_tt
>          struct radeon_ttm_tt *gtt =3D (void *)ttm;
>          struct radeon_device *rdev =3D radeon_get_rdev(bdev);
>
> +       if (gtt->userptr)
> +               radeon_ttm_tt_unpin_userptr(bdev, ttm);
> +
>          if (!gtt->bound)
>                  return;
>
>          radeon_gart_unbind(rdev, gtt->offset, ttm->num_pages);
>
> -       if (gtt->userptr)
> -               radeon_ttm_tt_unpin_userptr(bdev, ttm);
>          gtt->bound =3D false;
>  }
>
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
