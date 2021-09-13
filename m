Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7130F409A16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbhIMQzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbhIMQzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:55:20 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03192C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:54:05 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso14228506ots.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GPzHkZA+qOlSyT36DTpQf9mRfat2Hn9YzRuIIpxhPk=;
        b=QJcBP2YTK7N50SUPa1Ljm4GShk9dnSUtwSQPY6tGGiGD4R8/5aSYsRQDL8HE5lyBUG
         uEVuUOGkSNEAL2wFdPAiCXYj/vtyq3pEQHhTurDp4MYCzGVn5oyntInic3oxwLZV2AQZ
         gM9TsPkmYWSjR0EjRwo5YfVTbFZWtt1xLOq//UZ6o80a5FQ9pKQf0Wo3SblE4DSwLeZ6
         jU+oNCuRIBfA/WZElfEUd6IPpGPNYkPFFRFPHDkymuYP6+ASDMou9ElSwE8Mon1F/sPI
         RrSCTbsIsN3kb3rTCP3DmZJ+KV+BgnH+XxgdZd8qQzMpgh6kj0w51mhy5p2BMDNI/YkD
         6Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GPzHkZA+qOlSyT36DTpQf9mRfat2Hn9YzRuIIpxhPk=;
        b=IlPwJcwhefml7pBSGsleNZITq6nAaaxZZroM+ma+mCKPwViXVedawnu3uMYn+m8kNa
         5eE/jGqKA8a3oDY1Mci5eSrS7BJtIEaRHXmL1nZEc0QkKK0Yw/TC3wRY0vEoIJ6F1oiF
         Gby/BHpCQyPRFe5dCu6QCXviqzpXabMmee+aADMneliJzdYp0aJxUcguRLHX8pq9Wsqj
         b575zEj9VcALcIpmKLQkJa8CHam1wq/IhQ7Outv7W9vtb4GpJnsphNpkiApZTk1FNiPD
         fUoWZ1XJpsux2K7+o2Pxa4oohKwRj+cdlDTMfHj6QUncdOsVKatxttdVAG4b7cyt77hl
         2hHw==
X-Gm-Message-State: AOAM5319VKQJtN1KSs50b+u/C5aA/oBdaclF6uIBYQ8FJvyKVtS+kjwg
        tMnUq2ZpbW+T8vcbC6KLPsFCDXLwrWO5u0MstJw=
X-Google-Smtp-Source: ABdhPJwk5S0+em7NHoRvEFg67o03NoLil78mKcS+Rr4NM7fZFDsLOkEoddrFSAC/whvRpqZ9s2pQzRjuOUUQRpKlYRA=
X-Received: by 2002:a05:6830:25d3:: with SMTP id d19mr10955101otu.357.1631552044428;
 Mon, 13 Sep 2021 09:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210913083411.11215-1-pmenzel@molgen.mpg.de> <20210913083411.11215-2-pmenzel@molgen.mpg.de>
In-Reply-To: <20210913083411.11215-2-pmenzel@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Sep 2021 12:53:53 -0400
Message-ID: <CADnq5_Mgwtdtiqn11kcwsn5Q581i5FDZ1WKE-02Lg3BNBZ4TCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Demote TMZ unsupported log message from
 warning to info
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks.

Alex

On Mon, Sep 13, 2021 at 4:46 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> As the user cannot do anything about the unsupported Trusted Memory Zone
> (TMZ) feature, do not warn about it, but make it informational, so
> demote the log level from warning to info.
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c4c56c57b0c0..bfa0275ff5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -598,7 +598,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>                 break;
>         default:
>                 adev->gmc.tmz_enabled = false;
> -               dev_warn(adev->dev,
> +               dev_info(adev->dev,
>                          "Trusted Memory Zone (TMZ) feature not supported by hardware\n");
>                 break;
>         }
> --
> 2.33.0
>
