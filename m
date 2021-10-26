Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF32843B5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhJZPnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhJZPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:42:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9BC061226
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:40:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q16so16762191ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dI3e2yWb/uU+1tnC1/zWVYk4uFqXhgsB4McGikM5lUw=;
        b=dgqlsNw0H5kyGA5TWB1RzuH7MVg+T2iViWLbbis+jByI8r2y+xQU9cOFSvOLU6ZKwi
         3KaZDMBvsBp9nlr86Zou84ys64kzpuoVHsSfDA+rfEa1mWlAKvlOGensxU02agst4UAp
         R2Bj+LwW6QR9ZH1Ddy4MdqlbOvhXCoAc0tNFsCvO6wmlRaw0Qy9E5Cd73l1U9ES991qN
         /guby18kM499xkdc0KXbPb+WKOaWUd/ZOpVfhP3tyk2Fjt59n4oeM15mwPnvzIVraLp/
         /wecRv/8zpr5bLyYtG6dvKo/f9h/K4ASKz9BDARltki9+DmNrBIzyxORfk7DPWFZCKng
         UIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dI3e2yWb/uU+1tnC1/zWVYk4uFqXhgsB4McGikM5lUw=;
        b=4RdoM6px1IXwC7m1Yo9TImrpcSySmbACfRyTX2t0wGNPxMQhF4YJxBKlY67+V/YQp7
         ER62mO3zzkeDWaiqHLprsMkRIiO6YPN3buyKqXgHf3vMvSoqDiCHS8Yj5hE9+uno0+jU
         u9Fl5GJ90GNfFfRM77qmVJIfBD3XVfoF8uGgclCV9J481Cs6bRtchHZXuelYUmujzLV1
         u0/AqUPWLSAG2yAhQdsl0dPQGFv0jVfbC4YTnhYVIKD8/DPZRwaa2P29mehXrgEh7FlH
         eyh8eWcoUBi/yS7DOFF9fgYw5Z2ppwMi33Fp+mtrw9pfttlcMOC9RaG9W98uNcNsGfkY
         7sDg==
X-Gm-Message-State: AOAM532MIEbrMp44ehu2VZwZnwLcUwVGwLLyhRGsz/7563G3f+9JLDyJ
        Zp+1NtJIrliz58iRZJkmwXZmLxrv5vDmuCkZSs9L0Q==
X-Google-Smtp-Source: ABdhPJxjK+2RgtinaImTk9WZkEHEmETy0+4aTjX4JMJv4txyCEICQCRa7hvJGpINMvqMR/q9t/VdpFVs6tZRpTs+f24=
X-Received: by 2002:a2e:b550:: with SMTP id a16mr27647108ljn.229.1635262832943;
 Tue, 26 Oct 2021 08:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211021071333.32485-1-clin@suse.com>
In-Reply-To: <20211021071333.32485-1-clin@suse.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Oct 2021 17:39:55 +0200
Message-ID: <CAPDyKFrfUmisEO=OXZAi7U9N5gsfZHLWX7gPTHwt_AAsv78NpA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add SDHCI driver support for NXP S32G2
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        s32@nxp.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 09:13, Chester Lin <clin@suse.com> wrote:
>
> Hello,
>
> This is a patch series for initial sdhci support on NXP S32G2 platforms.
> In the previous work[1], only basic DTs and serial ports are supported for
> minimum hardware booting. Here we want to add a mmc-host node and add
> support in the sdhci-esdhc-imx driver so that S32G2 can also mount file
> system from SDCard but not just ramdisk. As the first step, we choose fixed
> clocks to fulfill the requirements the mmc host driver needs, and they will
> be replaced by ARM SCMI clock protocol (0x14) once the SCMI feature are
> added into S32G2 DT later.
>
> This patchset has been verified with NXP downstream firmware blobs [ver:
> bsp27/28/29/30], such as TF-A[2] and U-Boot[3] (BL33) on CodeAurora.
>
> Thanks,
> Chester
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/freescale/s32g2.dtsi
> [2]: https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware/
> [3]: https://source.codeaurora.org/external/autobsps32/u-boot/
>
> Chester Lin (3):
>   dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G2 support
>   mmc: sdhci-esdhc-imx: add NXP S32G2 support
>   arm64: dts: s32g2: add USDHC support
>
>  .../bindings/mmc/fsl-imx-esdhc.yaml           |  1 +
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      | 32 +++++++++++++++++++
>  .../arm64/boot/dts/freescale/s32g274a-evb.dts |  4 +++
>  .../boot/dts/freescale/s32g274a-rdb2.dts      |  4 +++
>  drivers/mmc/host/sdhci-esdhc-imx.c            | 17 ++++++++--
>  5 files changed, 56 insertions(+), 2 deletions(-)
>

Patch 1 and 2, applied for next, thanks!

Kind regards
Uffe
