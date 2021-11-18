Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39E4565D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhKRWsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhKRWsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:48:51 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08E4C061748;
        Thu, 18 Nov 2021 14:45:50 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y68so22773686ybe.1;
        Thu, 18 Nov 2021 14:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drrxg0bait9D2hSu5Rb+lqByc8pviUXeN3/NBO2Mdw0=;
        b=ALelaSYbC0JAGYqDK1XiIqBleMj2mT/SaxMSw+/uyDrnimujzZtPhY0VtYFsUEqaXg
         mm/OIiSTamkgkCAyipQRGpRKcuZzigaaVhPUlGRailSg2QJTWJhHdCoeWjvLxS20SHRH
         MnPT2HsDkPxXMJoHb8O/VXSjN9BcJtZ4sHdihnpPwUo9NaxD2nb+25F+DljhM4n3frHW
         sYys5igeVfB3WFLjkCb44UuoqLV0cu7TknknwZWHXTD2UePVXD4orSxxEC8rNxyxNN/n
         +Ck60VdaF8aV0NEHFVw7d0/Vu3c0omHgS4nnbRsF5PtuMivM7iiNFmlZhhvvfM0SS1QH
         4Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drrxg0bait9D2hSu5Rb+lqByc8pviUXeN3/NBO2Mdw0=;
        b=4G0vi80WlRtCVgdGjyiqRoX234L8zluXYk+LMGWK9XJ8RUm3thuL0QAt7VMfXjMGmU
         V7M9vlriY/ss2ttnntQpJ8E2epqOUQNfDv4IjNsn2llMQY6UX9Iukh7Zf4G3nOUo+Efo
         oKh3VoAnIY7kDwsBP3xdG7NhSosH3k18GfC0ujCIsvJz3Nuxx+vMZqmp9MtJ1CvfOGRg
         HV6E2OC5gg9MmKPdBy9r4Q6X98QDdXvGrczywumMaIx2hdxn55fsiVVWKQvNMt/ZZ/fU
         u+s8NK18Epm707TdFAw1dBVOlp1+6boKF6q+jRO8tMKVtuh8fAIGhky0Ccxcjj8ro1Tm
         DVjw==
X-Gm-Message-State: AOAM530JfH9SY3Z+eJDxK9maqYEtz+Dr6wrbVakByrF8A+z3XWonRmpY
        NHt0yDZX6Uv8tTi/ZXiD7J3Z3fFrEdTd1zEYjOo=
X-Google-Smtp-Source: ABdhPJz4F3+J1gbdCBhQ0sBG5pFrqOoaVWVM1MOWWO5ipi7oqJGxkL204p7x7LR7PkF1BEm0c3jhfkDCgRf8F3yERwU=
X-Received: by 2002:a25:378c:: with SMTP id e134mr30130496yba.474.1637275549921;
 Thu, 18 Nov 2021 14:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20211118111314.GB1147@kili>
In-Reply-To: <20211118111314.GB1147@kili>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Fri, 19 Nov 2021 08:45:38 +1000
Message-ID: <CACAvsv5jiOo+4hvO-G1ojAvrwZDALX7VfAV8-SHnzYak-3mFDA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/acr: fix a couple NULL vs IS_ERR() checks
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 at 21:13, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The nvkm_acr_lsfw_add() function never returns NULL.  It returns error
> pointers on error.
>
> Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace "secure boot"")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c | 6 ++++--
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c
> index cdb1ead26d84..82b4c8e1457c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c
> @@ -207,11 +207,13 @@ int
>  gm200_acr_wpr_parse(struct nvkm_acr *acr)
>  {
>         const struct wpr_header *hdr = (void *)acr->wpr_fw->data;
> +       struct nvkm_acr_lsfw *lsfw;
>
>         while (hdr->falcon_id != WPR_HEADER_V0_FALCON_ID_INVALID) {
>                 wpr_header_dump(&acr->subdev, hdr);
> -               if (!nvkm_acr_lsfw_add(NULL, acr, NULL, (hdr++)->falcon_id))
> -                       return -ENOMEM;
> +               lsfw = nvkm_acr_lsfw_add(NULL, acr, NULL, (hdr++)->falcon_id);
> +               if (IS_ERR(lsfw))
> +                       return PTR_ERR(lsfw);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c
> index fb9132a39bb1..fd97a935a380 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c
> @@ -161,11 +161,13 @@ int
>  gp102_acr_wpr_parse(struct nvkm_acr *acr)
>  {
>         const struct wpr_header_v1 *hdr = (void *)acr->wpr_fw->data;
> +       struct nvkm_acr_lsfw *lsfw;
>
>         while (hdr->falcon_id != WPR_HEADER_V1_FALCON_ID_INVALID) {
>                 wpr_header_v1_dump(&acr->subdev, hdr);
> -               if (!nvkm_acr_lsfw_add(NULL, acr, NULL, (hdr++)->falcon_id))
> -                       return -ENOMEM;
> +               lsfw = nvkm_acr_lsfw_add(NULL, acr, NULL, (hdr++)->falcon_id);
> +               if (IS_ERR(lsfw))
> +                       return PTR_ERR(lsfw);
>         }
>
>         return 0;
> --
> 2.20.1
>
