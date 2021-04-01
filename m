Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED035215F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhDAVMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhDAVMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:12:14 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDACC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:12:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so3301116oty.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3/tEWKm2WNngayfE+mn8rCJF6DRzknNbizlXk5hWAQ=;
        b=quWAVivmqSnYqJErkZGmKg9qwlpZD3NQ8AWJiUrOuHYpbkMvu/Jndmq0HqRPwlxsz4
         Rt5IOu51LuPwwabACYkOb07TK/5OGUtYknO4J7ASyFgdWUwRbJOcbTjfR/Tjam+fg51V
         ftj5p6/qb9ztnkL0HTnkOa6dG3lKOa4BtQmgPW6OW0C1elEFHh827ChEOCIAZmAg8zqb
         2L+Ee7xKZzvK4dHH8EQj5nuaUKzUBRhQYXmoDTdztd442mUBJ+KEfW1s16zQ8Kzo/Tbi
         JrYuOAv2X/vJuBBPS77iArRHAybNK+hRRZlvbW0fHhlApStKbUqEI51I5K6Xj0RdzX/N
         y4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3/tEWKm2WNngayfE+mn8rCJF6DRzknNbizlXk5hWAQ=;
        b=m7tHCIy3Z6HEp2BieUtFTEAfrP55G95/QvgON9aEaFp8ulh1ZAtwCf2agE+ncFf6bt
         oEbedoPXTtKWhPxPrSIC9uwIDWBH9diFB5X5unbv8obyhGA6TlxU9BemNMD+vBzh5VmO
         xhr/L1f+BgZn6Ag0yYY6SO7BBvqtxOwkUaNr7PTLRtfDwj89z5i+yoGfMhFd8vgBMctG
         WH2kPOs8Tw7bYGwMyOvbKkD8x2qhVB6l86hf++yKu2kA/sElEKQsq15sdOQnNI4tsQ99
         9rZ84ZcUhGaw/4EZi/xQ7AzvPJx2mPsGkbmnOorwRsFVN2du+kdYpI1hbM0DdDZ0kDsr
         hWvg==
X-Gm-Message-State: AOAM531n2xBOpFJaD5VFLs3tBnxbLhETU018NCi7npIXZHOGQOqzrqXU
        /hfCGXXXzp6/yxoc09qvL3KENYCIEx5W1e4ghdk=
X-Google-Smtp-Source: ABdhPJwPQCH1cqO+Ky2uLyFBpFc2K35zocKbr6hWOWDYO5+4rEGoObsafNjofT3lm8rxgqts5uaXkx5PaX2npc5iF/Y=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr8496383ots.23.1617311533912;
 Thu, 01 Apr 2021 14:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210331131143.60652-1-bernard@vivo.com>
In-Reply-To: <20210331131143.60652-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Apr 2021 17:12:02 -0400
Message-ID: <CADnq5_Pc0iDmmuH5oTa0_T23EJGfhqf+zzedXL2n_QME5MrjQw@mail.gmail.com>
Subject: Re: [PATCH] amd/amdgpu: code refactoring to clean code style a bit
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Evan Quan <evan.quan@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code has been dropped.

Alex

On Wed, Mar 31, 2021 at 9:36 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Fix checkpatch.pl warning:
> Too many leading tabs - consider code refactoring
> WARNING: Too many leading tabs - consider code refactoring
> +                                               for (j = 0; j < profile->ucLeakageBinNum; j++) {
>
> WARNING: Too many leading tabs - consider code refactoring
> +                                                       if (vbios_voltage_id <= leakage_bin[j]) {
>
> WARNING: Too many leading tabs - consider code refactoring
> +                                               for (j = 0; j < profile->ucLeakageBinNum; j++) {
>
> WARNING: Too many leading tabs - consider code refactoring
> +                                                       if (vbios_voltage_id <= leakage_bin[j]) {
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 84 ++++++++------------
>  1 file changed, 35 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 86add0f4ea4d..9968ff8ddc9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1283,65 +1283,51 @@ int amdgpu_atombios_get_leakage_vddc_based_on_leakage_params(struct amdgpu_devic
>         profile = (ATOM_ASIC_PROFILING_INFO_V2_1 *)
>                 (adev->mode_info.atom_context->bios + data_offset);
>
> -       switch (frev) {
> -       case 1:
> +       if ((frev != 2) || (crev != 1)) {
> +               DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
>                 return -EINVAL;
> -       case 2:
> -               switch (crev) {
> -               case 1:
> -                       if (size < sizeof(ATOM_ASIC_PROFILING_INFO_V2_1))
> -                               return -EINVAL;
> -                       leakage_bin = (u16 *)
> -                               (adev->mode_info.atom_context->bios + data_offset +
> -                                le16_to_cpu(profile->usLeakageBinArrayOffset));
> -                       vddc_id_buf = (u16 *)
> -                               (adev->mode_info.atom_context->bios + data_offset +
> -                                le16_to_cpu(profile->usElbVDDC_IdArrayOffset));
> -                       vddc_buf = (u16 *)
> -                               (adev->mode_info.atom_context->bios + data_offset +
> -                                le16_to_cpu(profile->usElbVDDC_LevelArrayOffset));
> -                       vddci_id_buf = (u16 *)
> -                               (adev->mode_info.atom_context->bios + data_offset +
> -                                le16_to_cpu(profile->usElbVDDCI_IdArrayOffset));
> -                       vddci_buf = (u16 *)
> -                               (adev->mode_info.atom_context->bios + data_offset +
> -                                le16_to_cpu(profile->usElbVDDCI_LevelArrayOffset));
> -
> -                       if (profile->ucElbVDDC_Num > 0) {
> -                               for (i = 0; i < profile->ucElbVDDC_Num; i++) {
> -                                       if (vddc_id_buf[i] == virtual_voltage_id) {
> -                                               for (j = 0; j < profile->ucLeakageBinNum; j++) {
> -                                                       if (vbios_voltage_id <= leakage_bin[j]) {
> -                                                               *vddc = vddc_buf[j * profile->ucElbVDDC_Num + i];
> -                                                               break;
> -                                                       }
> -                                               }
> +       }
> +
> +       if (size < sizeof(ATOM_ASIC_PROFILING_INFO_V2_1))
> +               return -EINVAL;
> +
> +       leakage_bin = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
> +                le16_to_cpu(profile->usLeakageBinArrayOffset));
> +       vddc_id_buf = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
> +                le16_to_cpu(profile->usElbVDDC_IdArrayOffset));
> +       vddc_buf = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
> +                le16_to_cpu(profile->usElbVDDC_LevelArrayOffset));
> +       vddci_id_buf = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
> +                le16_to_cpu(profile->usElbVDDCI_IdArrayOffset));
> +       vddci_buf = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
> +                le16_to_cpu(profile->usElbVDDCI_LevelArrayOffset));
> +
> +       if (profile->ucElbVDDC_Num > 0) {
> +               for (i = 0; i < profile->ucElbVDDC_Num; i++) {
> +                       if (vddc_id_buf[i] == virtual_voltage_id) {
> +                               for (j = 0; j < profile->ucLeakageBinNum; j++) {
> +                                       if (vbios_voltage_id <= leakage_bin[j]) {
> +                                               *vddc = vddc_buf[j * profile->ucElbVDDC_Num + i];
>                                                 break;
>                                         }
>                                 }
> +                               break;
>                         }
> -                       if (profile->ucElbVDDCI_Num > 0) {
> -                               for (i = 0; i < profile->ucElbVDDCI_Num; i++) {
> -                                       if (vddci_id_buf[i] == virtual_voltage_id) {
> -                                               for (j = 0; j < profile->ucLeakageBinNum; j++) {
> -                                                       if (vbios_voltage_id <= leakage_bin[j]) {
> -                                                               *vddci = vddci_buf[j * profile->ucElbVDDCI_Num + i];
> -                                                               break;
> -                                                       }
> -                                               }
> +               }
> +       }
> +
> +       if (profile->ucElbVDDCI_Num > 0) {
> +               for (i = 0; i < profile->ucElbVDDCI_Num; i++) {
> +                       if (vddci_id_buf[i] == virtual_voltage_id) {
> +                               for (j = 0; j < profile->ucLeakageBinNum; j++) {
> +                                       if (vbios_voltage_id <= leakage_bin[j]) {
> +                                               *vddci = vddci_buf[j * profile->ucElbVDDCI_Num + i];
>                                                 break;
>                                         }
>                                 }
> +                               break;
>                         }
> -                       break;
> -               default:
> -                       DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
> -                       return -EINVAL;
>                 }
> -               break;
> -       default:
> -               DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
> -               return -EINVAL;
>         }
>
>         return 0;
> --
> 2.31.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
