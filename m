Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F154A3B7409
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhF2OQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhF2OQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:16:23 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97194C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:13:55 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 11so18247117oid.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9S74JOYKz4LXepAVSvI+OSnTg73GPaPI8C818Hw5YPk=;
        b=ShXSPy8YMVhdt22psjM2H/xzDJHwTrwFTtKnFd5gNVvcP1+y/mFrTJKiMCoAsCEB+z
         C0nKQBL+gsQTXwKtGcYYS5ZmaFpeUyctoGMgmQCoW+fgTnGyAs2uxcpCwfeG1aqm4HpE
         fObBt7t0faOt9criSYFEiYmXwA4kkSEFCCH2aYI/bxkSMpvNwBNTWqhekgqfD/zkPK+F
         XrlUsrmDUVI3CHHthYm9Bs/qtX9C6Tnk3AUlq8JJDfKL23rmTT5+ryArU8hqTMFrfnLY
         NVE/WrjBduyEErUfWLnUGF8EiMnTsIEVwNic93YNwhRmUGrRTQ4WVavJqucxhq9zxoCY
         AJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9S74JOYKz4LXepAVSvI+OSnTg73GPaPI8C818Hw5YPk=;
        b=AtTeU/jZHhkjrkMLSLGOchuscR9pHlTeciuMvJYAMatTVLLS14zXJiY+kMEXkNABs7
         Gl4VdLV8suGibBYa1yMa90BBQpUTfNuY1FPBwlfMxp96XCzeWYGtyREAlmshzZp5chUJ
         hdsr6EyZWODCwjk4b0FowYn7KGgjCJmwlLrDmzW9AfDmMGqLtjfzZ5x2CFECCATzMT63
         AbphP82lOHmfiF3IIbcyfqLTEWFLlT/wjjOkD5+7+BCzVjt8mY0gi6Kk/po5g/NIS83l
         gX6wnznmUH246EPCHy1cBWWJEuwBfg3HtzDR8IbTER22OmShr8oiFUoPJZuY0JkIq0wg
         xzIQ==
X-Gm-Message-State: AOAM531eczofDGgWxKaK+XfCLOZ3nPT5LaD04oC6E7iNsK5vbPPOAVbP
        6JWYA2sQmmCKDjCTS0DLm6fo6mZZiwItjf6IUHI=
X-Google-Smtp-Source: ABdhPJzCdYX0N4mTrzK7aUZy7qMqiG6PLxkKbsaTfO7H+HsBUvBayQ0BzLqCi+DthYsgFHsoYAjTiFDKGiob8LBFffo=
X-Received: by 2002:aca:3446:: with SMTP id b67mr11009940oia.120.1624976035000;
 Tue, 29 Jun 2021 07:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210628105334.27559-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210628105334.27559-1-lukas.bulwahn@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Jun 2021 10:13:43 -0400
Message-ID: <CADnq5_Nqhr756=kzFSkDExyP-OQJopPmjz5Bnia1bbOWp2b7xg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: rectify line endings in umc v8_7_0 IP headers
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     John Clements <john.clements@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks.

Alex

On Mon, Jun 28, 2021 at 6:53 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 6b36fa6143f6 ("drm/amdgpu: add umc v8_7_0 IP headers") adds the new
> file ./drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h with
> DOS line endings, which is very uncommon for the kernel repository.
>
> Rectify the line endings in this file with dos2unix.
>
> Identified by a checkpatch evaluation on the whole kernel repository and
> spot-checking for really unexpected checkpatch rule violations.
>
> Reported-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  .../include/asic_reg/umc/umc_8_7_0_sh_mask.h  | 158 +++++++++---------
>  1 file changed, 79 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
> index 4c5097fa0c09..d5ef91d3c391 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
> @@ -1,79 +1,79 @@
> -#ifndef _umc_8_7_0_SH_MASK_HEADER
> -#define _umc_8_7_0_SH_MASK_HEADER
> -
> -//UMCCH0_0_GeccErrCntSel
> -#define UMCCH0_0_GeccErrCntSel__GeccErrCntCsSel__SHIFT                                                        0x0
> -#define UMCCH0_0_GeccErrCntSel__GeccErrInt__SHIFT                                                             0xc
> -#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn__SHIFT                                                           0xf
> -#define UMCCH0_0_GeccErrCntSel__PoisonCntEn__SHIFT                                                            0x10
> -#define UMCCH0_0_GeccErrCntSel__GeccErrCntCsSel_MASK                                                          0x0000000FL
> -#define UMCCH0_0_GeccErrCntSel__GeccErrInt_MASK                                                               0x00003000L
> -#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn_MASK                                                             0x00008000L
> -#define UMCCH0_0_GeccErrCntSel__PoisonCntEn_MASK                                                              0x00030000L
> -//UMCCH0_0_GeccErrCnt
> -#define UMCCH0_0_GeccErrCnt__GeccErrCnt__SHIFT                                                                0x0
> -#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt__SHIFT                                                          0x10
> -#define UMCCH0_0_GeccErrCnt__GeccErrCnt_MASK                                                                  0x0000FFFFL
> -#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt_MASK                                                            0xFFFF0000L
> -//MCA_UMC_UMC0_MCUMC_STATUST0
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode__SHIFT                                                         0x0
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt__SHIFT                                                      0x10
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22__SHIFT                                                          0x16
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb__SHIFT                                                           0x18
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30__SHIFT                                                          0x1e
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId__SHIFT                                                         0x20
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38__SHIFT                                                          0x26
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub__SHIFT                                                             0x28
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41__SHIFT                                                          0x29
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison__SHIFT                                                            0x2b
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred__SHIFT                                                          0x2c
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC__SHIFT                                                              0x2d
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC__SHIFT                                                              0x2e
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47__SHIFT                                                          0x2f
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent__SHIFT                                                       0x34
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV__SHIFT                                                             0x35
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54__SHIFT                                                          0x36
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC__SHIFT                                                               0x37
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal__SHIFT                                                      0x38
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC__SHIFT                                                               0x39
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV__SHIFT                                                             0x3a
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV__SHIFT                                                             0x3b
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__En__SHIFT                                                                0x3c
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__UC__SHIFT                                                                0x3d
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow__SHIFT                                                          0x3e
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Val__SHIFT                                                               0x3f
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode_MASK                                                           0x000000000000FFFFL
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt_MASK                                                        0x00000000003F0000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22_MASK                                                            0x0000000000C00000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb_MASK                                                             0x000000003F000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30_MASK                                                            0x00000000C0000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId_MASK                                                           0x0000003F00000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38_MASK                                                            0x000000C000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub_MASK                                                               0x0000010000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41_MASK                                                            0x0000060000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison_MASK                                                              0x0000080000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred_MASK                                                            0x0000100000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC_MASK                                                                0x0000200000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC_MASK                                                                0x0000400000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47_MASK                                                            0x000F800000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent_MASK                                                         0x0010000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV_MASK                                                               0x0020000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54_MASK                                                            0x0040000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC_MASK                                                                 0x0080000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal_MASK                                                        0x0100000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC_MASK                                                                 0x0200000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV_MASK                                                               0x0400000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV_MASK                                                               0x0800000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__En_MASK                                                                  0x1000000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__UC_MASK                                                                  0x2000000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow_MASK                                                            0x4000000000000000L
> -#define MCA_UMC_UMC0_MCUMC_STATUST0__Val_MASK                                                                 0x8000000000000000L
> -//MCA_UMC_UMC0_MCUMC_ADDRT0
> -#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr__SHIFT                                                           0x0
> -#define MCA_UMC_UMC0_MCUMC_ADDRT0__LSB__SHIFT                                                                 0x38
> -#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved__SHIFT                                                            0x3e
> -#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr_MASK                                                             0x00FFFFFFFFFFFFFFL
> -#define MCA_UMC_UMC0_MCUMC_ADDRT0__LSB_MASK                                                                   0x3F00000000000000L
> -#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved_MASK                                                              0xC000000000000000L
> -
> -#endif
> +#ifndef _umc_8_7_0_SH_MASK_HEADER
> +#define _umc_8_7_0_SH_MASK_HEADER
> +
> +//UMCCH0_0_GeccErrCntSel
> +#define UMCCH0_0_GeccErrCntSel__GeccErrCntCsSel__SHIFT                                                        0x0
> +#define UMCCH0_0_GeccErrCntSel__GeccErrInt__SHIFT                                                             0xc
> +#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn__SHIFT                                                           0xf
> +#define UMCCH0_0_GeccErrCntSel__PoisonCntEn__SHIFT                                                            0x10
> +#define UMCCH0_0_GeccErrCntSel__GeccErrCntCsSel_MASK                                                          0x0000000FL
> +#define UMCCH0_0_GeccErrCntSel__GeccErrInt_MASK                                                               0x00003000L
> +#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn_MASK                                                             0x00008000L
> +#define UMCCH0_0_GeccErrCntSel__PoisonCntEn_MASK                                                              0x00030000L
> +//UMCCH0_0_GeccErrCnt
> +#define UMCCH0_0_GeccErrCnt__GeccErrCnt__SHIFT                                                                0x0
> +#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt__SHIFT                                                          0x10
> +#define UMCCH0_0_GeccErrCnt__GeccErrCnt_MASK                                                                  0x0000FFFFL
> +#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt_MASK                                                            0xFFFF0000L
> +//MCA_UMC_UMC0_MCUMC_STATUST0
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode__SHIFT                                                         0x0
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt__SHIFT                                                      0x10
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22__SHIFT                                                          0x16
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb__SHIFT                                                           0x18
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30__SHIFT                                                          0x1e
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId__SHIFT                                                         0x20
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38__SHIFT                                                          0x26
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub__SHIFT                                                             0x28
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41__SHIFT                                                          0x29
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison__SHIFT                                                            0x2b
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred__SHIFT                                                          0x2c
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC__SHIFT                                                              0x2d
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC__SHIFT                                                              0x2e
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47__SHIFT                                                          0x2f
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent__SHIFT                                                       0x34
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV__SHIFT                                                             0x35
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54__SHIFT                                                          0x36
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC__SHIFT                                                               0x37
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal__SHIFT                                                      0x38
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC__SHIFT                                                               0x39
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV__SHIFT                                                             0x3a
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV__SHIFT                                                             0x3b
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__En__SHIFT                                                                0x3c
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__UC__SHIFT                                                                0x3d
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow__SHIFT                                                          0x3e
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Val__SHIFT                                                               0x3f
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode_MASK                                                           0x000000000000FFFFL
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt_MASK                                                        0x00000000003F0000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22_MASK                                                            0x0000000000C00000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb_MASK                                                             0x000000003F000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30_MASK                                                            0x00000000C0000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId_MASK                                                           0x0000003F00000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38_MASK                                                            0x000000C000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub_MASK                                                               0x0000010000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41_MASK                                                            0x0000060000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison_MASK                                                              0x0000080000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred_MASK                                                            0x0000100000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC_MASK                                                                0x0000200000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC_MASK                                                                0x0000400000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47_MASK                                                            0x000F800000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent_MASK                                                         0x0010000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV_MASK                                                               0x0020000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54_MASK                                                            0x0040000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC_MASK                                                                 0x0080000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal_MASK                                                        0x0100000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC_MASK                                                                 0x0200000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV_MASK                                                               0x0400000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV_MASK                                                               0x0800000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__En_MASK                                                                  0x1000000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__UC_MASK                                                                  0x2000000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow_MASK                                                            0x4000000000000000L
> +#define MCA_UMC_UMC0_MCUMC_STATUST0__Val_MASK                                                                 0x8000000000000000L
> +//MCA_UMC_UMC0_MCUMC_ADDRT0
> +#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr__SHIFT                                                           0x0
> +#define MCA_UMC_UMC0_MCUMC_ADDRT0__LSB__SHIFT                                                                 0x38
> +#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved__SHIFT                                                            0x3e
> +#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr_MASK                                                             0x00FFFFFFFFFFFFFFL
> +#define MCA_UMC_UMC0_MCUMC_ADDRT0__LSB_MASK                                                                   0x3F00000000000000L
> +#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved_MASK                                                              0xC000000000000000L
> +
> +#endif
> --
> 2.17.1
>
