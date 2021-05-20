Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D338B733
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhETTTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbhETTTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:19:31 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5102C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:18:04 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so4042119ood.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=inhHSx4VVdd6VlmWYA1Oc6IjDKgdb7a8vsKxGCF5N0I=;
        b=XCOGtUJUvbDS2LdLMD6oXtSH4CFhzjRz6VqPhCJZs+ccNHknMTPnl1WQOdtBkMofoO
         HP4e8tFBFuyMt7E6B4x4it1C3Zdzy9wMtVfHX7DawfZMYE46Ok1sa5XVvgcIikk/SpSd
         HAh2SogLnOZ9BLXlKj00Y7ocS93RyXZInitiyCQ+YBiFNfrpb6EYJw6Motp5n7Zf3+N3
         05I6EqhujA09IzhZVSp5w5jvO8KUyXhxhfjrSdJqeaWGsnRFxg5vgl1TqVJKX/R4u8xD
         2OPrwRTagsl4gN6C1tWMjGQQ+RSVeCglioCmQiA+GONXMC25aFCi0gOL11WYlQeJbxsP
         GKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=inhHSx4VVdd6VlmWYA1Oc6IjDKgdb7a8vsKxGCF5N0I=;
        b=YIdtv/QJ1vMDwyMXYs5pTmydykZTzXBHq8dqQTtkiKvZE5fEyQ8F/xAvY34fvKm2Wb
         PQNwqLjiQk7n4mhpHC1Wws1udeYSYP8gc5vhfwjt94wGYYGXxJ8jeUXRl94GBM57w97/
         8mOD95t5QfUcUMV8GVVMRD5VOkNhTBd51tACmrNKj9gnQJyXdjfnlS3L7HxyUygYnq3j
         6mqZJoqYgrvu5D3gegjgtPgAmFe8YWnTRHRBf//DCBvbhOMdJAvRfiDT+KoQKBCxaqA1
         YYLPPOgYPApKCGAkxGXMG/20Dm6ynb16aBAmbkZyknX7wkr19bmFcmjyRHMBDllmxPsq
         uh+A==
X-Gm-Message-State: AOAM530uNhtGemW/pYZUmATKICh80g5FRNwe+TTXLYBb1Rf6JKPkAqPf
        mlL1vYcFuUk+qqAAfSGKjOl9Xru+JGEAfFQUUH4=
X-Google-Smtp-Source: ABdhPJzh6BsciXjhKaLIHK8DE7cvwKOEYyYVAA+r2OS+xmgokC8Ab+vei2Pi46Wk1Ws9U1NNJoG21+doLDQ+3RwRenQ=
X-Received: by 2002:a4a:d543:: with SMTP id q3mr4937571oos.72.1621538282712;
 Thu, 20 May 2021 12:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org> <20210520120248.3464013-22-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-22-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 May 2021 15:17:51 -0400
Message-ID: <CADnq5_Mk9WkJP4m+mn175H+2btAnrXqhioGM07Ow+x9VtwQKaQ@mail.gmail.com>
Subject: Re: [PATCH 21/38] drm/amd/include/aldebaran_ip_offset: Mark top-level
 IP_BASE as __maybe_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, May 20, 2021 at 8:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:259:29: warn=
ing: =E2=80=98XGMI2_BASE=E2=80=99 defined but not used [-Wunused-const-vari=
able=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:252:29: warn=
ing: =E2=80=98XGMI1_BASE=E2=80=99 defined but not used [-Wunused-const-vari=
able=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:245:29: warn=
ing: =E2=80=98XGMI0_BASE=E2=80=99 defined but not used [-Wunused-const-vari=
able=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:238:29: warn=
ing: =E2=80=98WAFL1_BASE=E2=80=99 defined but not used [-Wunused-const-vari=
able=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:231:29: warn=
ing: =E2=80=98WAFL0_BASE=E2=80=99 defined but not used [-Wunused-const-vari=
able=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:161:29: warn=
ing: =E2=80=98PCIE0_BASE=E2=80=99 defined but not used [-Wunused-const-vari=
able=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:119:29: warn=
ing: =E2=80=98L2IMU0_BASE=E2=80=99 defined but not used [-Wunused-const-var=
iable=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:112:29: warn=
ing: =E2=80=98L1IMUPCIE0_BASE=E2=80=99 defined but not used [-Wunused-const=
-variable=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:105:29: warn=
ing: =E2=80=98L1IMUIOAGR0_BASE=E2=80=99 defined but not used [-Wunused-cons=
t-variable=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:98:29: warni=
ng: =E2=80=98IOHC0_BASE=E2=80=99 defined but not used [-Wunused-const-varia=
ble=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:91:29: warni=
ng: =E2=80=98IOAPIC0_BASE=E2=80=99 defined but not used [-Wunused-const-var=
iable=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:84:29: warni=
ng: =E2=80=98IOAGR0_BASE=E2=80=99 defined but not used [-Wunused-const-vari=
able=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:63:29: warni=
ng: =E2=80=98FUSE_BASE=E2=80=99 defined but not used [-Wunused-const-variab=
le=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:49:29: warni=
ng: =E2=80=98DBGU_IO0_BASE=E2=80=99 defined but not used [-Wunused-const-va=
riable=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/aldebaran_ip_offset.h:42:29: warni=
ng: =E2=80=98CLK_BASE=E2=80=99 defined but not used [-Wunused-const-variabl=
e=3D]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/include/aldebaran_ip_offset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h b/drivers/=
gpu/drm/amd/include/aldebaran_ip_offset.h
> index 644ffec2b0ce8..cdd426b41c20e 100644
> --- a/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h
> @@ -30,7 +30,7 @@ struct IP_BASE_INSTANCE {
>
>  struct IP_BASE {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>  static const struct IP_BASE ATHUB_BASE =3D { { { { 0x00000C20, 0x02408C0=
0, 0, 0, 0, 0 } },
>                                          { { 0, 0, 0, 0, 0, 0 } },
> --
> 2.31.1
>
