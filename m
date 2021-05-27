Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF5392589
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhE0Doj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhE0Doh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:44:37 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D72C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:43:05 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id n3-20020a9d74030000b029035e65d0a0b8so3129368otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jfHExiAwx1yhDJ7z9SPOraFBPqMXoh5n46J3TLD6IxI=;
        b=qCrx8FvXM97lUfDQtGc7hqeqQ944hYWWSoZujRCyYfzaH2s5JMDv2t2lz5CDYr8a4Y
         RdafEpU06bBsenrmamIC2itw/iiggx/c8Rzq+H6/Z6je69wxAOlgrSenGLJhTxZ1f8vU
         3VegTt+cwG8QpP0YCRg2HEaApzeqy9m2YmRI1GFSSsxZnaxrLm+nLUHCvamNrv1LmqwX
         JnvuRQEKuANxoS7lJlLC7H2mQnaoiPzkcrDVygrPJ2JXOQmmI7UzucPCas1t778Umb5k
         0d6kKCIh6v0DwJcdZgXB9P9jQlmnX9K/Z7G6DP6U2uQi+Nb/gqn2TWQxSJjaWKxJU2Ji
         FUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jfHExiAwx1yhDJ7z9SPOraFBPqMXoh5n46J3TLD6IxI=;
        b=TSDEYyJtPQcI3wWG91ObNXBtZuvmIp3Af3hrnsrtcm5zggwEtEi7Cc4JHxeEHR8z1Z
         1t7FDQA7zy8Zjt7jMiRQ4UeNmgxYIVQ8QOzSNIHnwPf1hDwwV/YCTV7snV9k8DFR9pvV
         88+4QFqpe6U/yigJqZ/2oGRB31ZMVFx94AilGZNtGqb+QJP8Qxp0N0Kn3v5NiSH/Ti4Y
         JVamCzbHqiAWwtQ140kqJ2tqEj09a5UQ46uQw22uZVytmO6O7FqSV9BqMefCKab292xF
         uiAxfH/3pl2XEA2irH7zZ0Aa4K6hgzAX/tYdezHOveTU3kt/23BlufkXGNsOhHNSZEKU
         fQag==
X-Gm-Message-State: AOAM530y/gSyqlSeFI5KIkydur6lmQfz5KciU2ZKHlqi9owMqazNcC7C
        aapYQRHDg/An7gD32EhBUX7ZPyD1DdzhbGgsB94=
X-Google-Smtp-Source: ABdhPJyZnqxxgDnJ6PHbltuqV9e7YpgMP1k4fxHJNb1XSn7Xny5N88vOTGA/oxzG3Dqra1oAamTpwHWFw2t+Zsk06wA=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1174607otl.311.1622086984587;
 Wed, 26 May 2021 20:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-2-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:42:53 -0400
Message-ID: <CADnq5_PhozjNvOjvoMQRr-oqNz_vOjHtuW45wCK80jHKYscV7A@mail.gmail.com>
Subject: Re: [PATCH 01/34] drm/amd/pm/inc/smu_v13_0: Move table into the only
 source file that uses it
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Kevin Wang <kevin1.wang@amd.com>,
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

Applied.  Thanks!

On Wed, May 26, 2021 at 4:47 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/inc/smu_v13_0.h:54:43: warning: =E2=80=
=98smu13_thermal_policy=E2=80=99 defined but not used [-Wunused-const-varia=
ble=3D]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Kevin Wang <kevin1.wang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v13_0.h             | 6 ------
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd=
/pm/inc/smu_v13_0.h
> index 1687709507b3d..6119a36b2cba0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> @@ -51,12 +51,6 @@
>  #define CTF_OFFSET_HOTSPOT             5
>  #define CTF_OFFSET_MEM                 5
>
> -static const struct smu_temperature_range smu13_thermal_policy[] =3D
> -{
> -       {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 9=
9000},
> -       { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,=
 120000},
> -};
> -
>  struct smu_13_0_max_sustainable_clocks {
>         uint32_t display_clock;
>         uint32_t phy_clock;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index d62cc6bb1a305..d6ce665baaf3b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -78,6 +78,12 @@
>
>  #define smnPCIE_ESM_CTRL                       0x111003D0
>
> +static const struct smu_temperature_range smu13_thermal_policy[] =3D
> +{
> +       {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 9=
9000},
> +       { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,=
 120000},
> +};
> +
>  static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_M=
AX_COUNT] =3D {
>         MSG_MAP(TestMessage,                         PPSMC_MSG_TestMessag=
e,                     0),
>         MSG_MAP(GetSmuVersion,                       PPSMC_MSG_GetSmuVers=
ion,                   1),
> --
> 2.31.1
>
