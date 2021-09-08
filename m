Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A3403635
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbhIHIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348087AbhIHIjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:39:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E0DC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 01:38:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so908425wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ILfedyfA7TPHqyBNZ/TjjapMKjWfHALaRNb6+vus4M=;
        b=Rq63Ukeo3zhZYJb8DfVPuJ+ZlafG0bW4jpUJ1nH3k2einUu+O2DnOkh+2CfpepE9J6
         XwQkWvMFO7wVfanY7uSCHAm5kgetmsk4r6nnx3ddUx5lWpBhVFBRn4od9nLyt9ECjaq2
         IEsndYP4HmZpynv/GMLu58l4z4j4pTKXwU5VblnNl4nF1tSFe80p215ojNzp0+lDLfyg
         p418iVjoASz1D43D2gmR2MIVpTFRyspYOLLrlMJrHNwlb61kWKxcL1L3Do4h/NOyH0ZW
         9viKhye+u9e4BuQdJMZsD1O+4NgOtmX3SDD2YVR/pjISSYrhrgpczfFW8KRjeM9lM9lI
         al+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ILfedyfA7TPHqyBNZ/TjjapMKjWfHALaRNb6+vus4M=;
        b=UN4nUsRFILrlBYuijoQmDbqp1/++r7tfz3haIiBmmJGsC8s+jSEDTKepJIdRdB0ezY
         PF0+JobydvfxOh+OsqS07+L5IuX0Jy7UuBTFENZFs/W1wszYv62BkCdDiMqOyxi4jnrc
         XFbl1ibPbWo/VjB+zTNZJUQ/cBHhtxIATVrDsLom9AxjpDH0wU+jEdyN3RswCNVMMidR
         fx0p05Z5gVEQXaNnFbPy/nzl1aSN2x+7vqng9fHX77caZQTS4/s3GYSWweJS4hGhBHDw
         klf7OwGoGKoPJlFm2Y9ZmufiZo0rCPHNFJCrsbt82VdK/xFdSC0A+L8kWWuK5IJ0XRuT
         JHVw==
X-Gm-Message-State: AOAM5317hwd1OK5pTbpJEEVgGbbirERRT6FcIXKjqTuyaE7eHGSjp2zZ
        Zf1VFZIrmdEHfqInwzQvefToDTn117y/2ton4mCDjnW40tE=
X-Google-Smtp-Source: ABdhPJwTLSIAXa5bFuTiTTMynzBXUStSpSK/LG8Y7aRLbOSUVFSSUxJSmAev5mr9BMod3NxrEem3HLc3DORSEKl0b4g=
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr2288363wmh.137.1631090289364;
 Wed, 08 Sep 2021 01:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210726112511.78350-1-xypron.glpk@gmx.de>
In-Reply-To: <20210726112511.78350-1-xypron.glpk@gmx.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 8 Sep 2021 14:07:57 +0530
Message-ID: <CAAhSdy2qXrb9pJENgq-iXpHJmHqn9gzSrfyZoVGN=zaK2DhsLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: defconfig: enable BLK_DEV_NVME
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 4:55 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> NVMe is a non-volatile storage media attached via PCIe.
> As NVMe has much higher throughput than other block devices like
> SATA it is a must have for RISC-V. Enable CONFIG_BLK_DEV_NVME.
>
> The HiFive Unmatched is a board providing M.2 slots for NVMe drives.
> Enable CONFIG_PCIE_FU740.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 1f2be234b11c..393bf3843e5c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -39,10 +39,12 @@ CONFIG_PCI=y
>  CONFIG_PCIEPORTBUS=y
>  CONFIG_PCI_HOST_GENERIC=y
>  CONFIG_PCIE_XILINX=y
> +CONFIG_PCIE_FU740=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_VIRTIO_BLK=y
> +CONFIG_BLK_DEV_NVME=m
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_BLK_DEV_SR=y
>  CONFIG_SCSI_VIRTIO=y
> --
> 2.30.2
>
