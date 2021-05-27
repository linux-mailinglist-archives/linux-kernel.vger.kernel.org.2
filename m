Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F2392594
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhE0DvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhE0DvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:51:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7776CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:49:36 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j75so3786183oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DX5LZ59j/U95L+mNk2w46JLq9y9MxosdgzOg6i0ZZ6E=;
        b=u8DB9ze/Jw3EU/Y4+kWrZQ6Cw2+PcWjxFCoDTqyt4TeM+BZFS+KrGfLZhaEBSCoXpl
         dbTbZeMaDXuKOHyGSU0lPjSHx2ndTerJYw44ctn2yUTQaIfyXZB5TJwBjJth9OqkAEV6
         x83RO7YGxNxPM/MaGdoq2HGnCY7nfNSzu9g1OahvUbuq5DRf4t1PJ6pebrxZ8TzsIms5
         qKG9MaTmsOH59Nsk07lS+oksXQZ+1tdCjsbJoz63DHEUGIvQ2XXrTu2wor6Z3rjKLhL2
         Twidj3FMOFJDlN43g/in2ikXjQo8WuW0AqC3nRnZ9OfrD9xn8oUMtfr19h62A7pbta5S
         hHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DX5LZ59j/U95L+mNk2w46JLq9y9MxosdgzOg6i0ZZ6E=;
        b=E/BX8ccg3pmzIt0lIw1XmAs/+Y/Q5oZW5xr1PzwbpKMqalNHSUruaJai3DOmR9M3xn
         4SmLU9LfwljuO2XKzAltJHFkNf5ArH8KjPdoTVoQ5lIFh4AjxEFW8+Ube/dWWA/7g3KA
         1Ny0BhArqkJbXwNLP3LjAGiGAMCSdnrGIiyMaB9IJEWph4yzIBNce4pCDTIiVT9xqc0m
         Y1qh9bbFMEzkIFq3RnLDezoGDXaQH3EExENZ+SaIlRJUNrJy7rEMLV5ItJ09zZ8VA4xb
         Qd8Hh2Rr85L2H3WC0YOK4ai62ggHYkuvezdfv39UoBh/haFWpf5lSMJksTzADxtLmI2/
         BDug==
X-Gm-Message-State: AOAM533EARNjT4OjZfCXTf8lCQMFN/sSBiFbtiH/8bb8U7/MeooLBPsS
        GbuzkGQkwESPoxbeYQuADaIRFMmknbhY5ICJ78w=
X-Google-Smtp-Source: ABdhPJw0QDyylvjNLg3lab3rvIBcqi4+H2nhMuvkGY8U8GQq5XqOtT75RF0uJDw4uQ0NCdsuXqZO/VBBrP1e7C1e4Yk=
X-Received: by 2002:a05:6808:249:: with SMTP id m9mr1011124oie.120.1622087375887;
 Wed, 26 May 2021 20:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-3-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-3-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:49:25 -0400
Message-ID: <CADnq5_OFMz2tCCCwXbQ-sj+zOyp2GGNLDCkVADXaRo=GJ1wOTg@mail.gmail.com>
Subject: Re: [PATCH 02/34] drm/amd/pm/swsmu/smu13/aldebaran_ppt: Remove unused
 variable 'ret'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be checked.  Will send out a patch momentarily.

Thanks,

Alex

On Wed, May 26, 2021 at 4:47 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c: In functio=
n =E2=80=98aldebaran_is_dpm_running=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c:1260:6: war=
ning: variable =E2=80=98ret=E2=80=99 set but not used [-Wunused-but-set-var=
iable]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index d6ce665baaf3b..d077e211017a9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1368,10 +1368,9 @@ static int aldebaran_usr_edit_dpm_table(struct smu=
_context *smu, enum PP_OD_DPM_
>
>  static bool aldebaran_is_dpm_running(struct smu_context *smu)
>  {
> -       int ret =3D 0;
>         uint32_t feature_mask[2];
>         unsigned long feature_enabled;
> -       ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> +       smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>         feature_enabled =3D (unsigned long)((uint64_t)feature_mask[0] |
>                                           ((uint64_t)feature_mask[1] << 3=
2));
>         return !!(feature_enabled & SMC_DPM_FEATURE);
> --
> 2.31.1
>
