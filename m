Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B2D31C69C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 07:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBPGp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 01:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhBPGpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 01:45:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A72C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 22:44:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s11so10827285edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 22:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=48W9PPwDT7qNo2BI9hgweydmutdBVYuB+eG3wiusPHM=;
        b=dKf02EAeoUczIIJyWbhyidTEeSgVhdR3xEqnypt33xVMFGlSVqzIvbIx8Gy7LELvvy
         NkcpJKhvodub7fKkebXowi+2BldQevYdWr8mNyBwOtW8RV3YzO3Ww2TmTaXf8MaNAqlp
         9fHihFFoJwhXpSIXl9iCDDju0yFKbulZ95cJOsj+NA1nutFza6vzWA5Cf/lNAsMbsk9m
         Fd2iW51nCikjzTymBfWrpwUCGJ4xVxuyk7eKh1PUTNWHxg7lrsT3o/2Mye+9GtJeUUTb
         ewMW73znjvet/0c4dLD255lwdWflzT9tLObigVPGrCAG83+FOBIOMDYsYIuGU5PUpF+2
         agfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=48W9PPwDT7qNo2BI9hgweydmutdBVYuB+eG3wiusPHM=;
        b=URWpysbAZUEp+48yXprem/zyEDwiMX5CTszenKlh5ztk3e1iCR6dMOSUqZoMGShrRU
         ys/J+ONXqt0cYKlThiTFcnjnGJrQxE3gEp3pRTVUepUNKDcNElmDFD2Tj/ra73Z49bDz
         BD3ePnZyQRDRETTE2iGdeFIlMD+8Cbsy7nH1CAoa7D3fyJJ22v572OtD/5XmzOK592lM
         fCF4If8jZViceqs1tzR/wkGtpJebzKRru86CvUnDf+b+hMYGaCQilkgAQ1pbMHD5sLcR
         MonzKy1afvECpSnolR1Y731jVAQcv8G6qX2M4Q/+E8oZp5zHlR4oBlzfDevjlkeOvuKb
         e9Vw==
X-Gm-Message-State: AOAM530yQaEFLlEURUxM6zSFa/RGP2kbS9DxlaUnQZbLki0dONsQwUUa
        eRAjsIND8zKzzrHFshMGsI0QwjMYPHkyfXBIwwpMUDkk9Ro=
X-Google-Smtp-Source: ABdhPJzVRpEHdfhWd3rahxm+UmGMzS80naaxtJBhjXraCX1dKGfB6QQ2HEzZbB8cG+1QKn+vghD0Yrsp52yJHLLKvOI=
X-Received: by 2002:aa7:d98e:: with SMTP id u14mr4610127eds.88.1613457868461;
 Mon, 15 Feb 2021 22:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20210213011624.251838-1-robh@kernel.org>
In-Reply-To: <20210213011624.251838-1-robh@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 16 Feb 2021 07:44:17 +0100
Message-ID: <CAHTX3dJfQffgPt5odNrCnJ2MFd=GVK+NcGsdjbGA_ED_LAwWuw@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Fix built-in DTB alignment to be 8-byte aligned
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so 13. 2. 2021 v 2:16 odes=C3=ADlatel Rob Herring <robh@kernel.org> napsal:
>
> Commit 79edff12060f ("scripts/dtc: Update to upstream version
> v1.6.0-51-g183df9e9c2b9") broke booting on Microblaze systems depending o=
n
> the build. The problem is libfdt gained an 8-byte starting alignment chec=
k,
> but the Microblaze built-in DTB area is only 4-byte aligned. This affecte=
d
> not just built-in DTBs as bootloader passed DTBs are copied into the
> built-in DTB region.
>
> Other arches using built-in DTBs use a common linker macro which has
> sufficient alignment.
>
> Fixes: 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g=
183df9e9c2b9")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> As the commit is in my tree, I'll take this via the DT tree.
>
>  arch/microblaze/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kerne=
l/vmlinux.lds.S
> index df07b3d06cd6..fb31747ec092 100644
> --- a/arch/microblaze/kernel/vmlinux.lds.S
> +++ b/arch/microblaze/kernel/vmlinux.lds.S
> @@ -45,7 +45,7 @@ SECTIONS {
>                 _etext =3D . ;
>         }
>
> -       . =3D ALIGN (4) ;
> +       . =3D ALIGN (8) ;
>         __fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
>                 _fdt_start =3D . ;                /* place for fdt blob *=
/
>                 *(__fdt_blob) ;                 /* Any link-placed DTB */
> --
> 2.27.0
>

Applied.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
