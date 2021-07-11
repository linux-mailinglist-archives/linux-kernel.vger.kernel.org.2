Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5FD3C39C7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 03:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhGKB11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 21:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhGKB1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 21:27:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DCF06135E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625966680;
        bh=aIP2rlDtTS95T8nU3RpDMo/i3IGTjw9lAhxt99Ve+t4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aehw4Ww2zJPJDh2kaIPxE80Co270FEMDET0Acek5TQh13xsNVh561M2xT++vfYzAE
         GDWY6JH+DQJooHuscpBRD/nlbV02w+t+BoKwUAujiUiSuochhFm1Yot8Lau4UxZTCc
         WrdVfG1xL7Eizcop2AJ17RstOFCqZqb/zsr8bG1W028mB05f+4P07C9DG4lwKrzOuj
         bG/XYsr7bFyTK0iwiDKDsVRYmEfcpbnhoMOCPFtgR0HvrGYezZcIQ9dq+HgjXuern2
         NEY1N/7EVGcw6Lxt0nALOn3CaDfj+/6Nw0BdsIkfAMtyoZnQg4U23qkAJYAzln2erw
         +YvId/DzB/zgA==
Received: by mail-ej1-f45.google.com with SMTP id v20so25081664eji.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 18:24:39 -0700 (PDT)
X-Gm-Message-State: AOAM532MPNFG7Z4umFQ6K/PhgzSY6B4AFatocRAHP8G+Byk5yYWtAspN
        LCTse9I7082Nfw0rsQkhyWfYaG55ng+yIJvhtQ==
X-Google-Smtp-Source: ABdhPJzOB3OuozcAvCO20qScosy+mz5YpXjiMYn8K2UdgrwIS1/Jxx9i8zT/7TyLVmk2TgpB4VxmTEd5nCx53LCPzaQ=
X-Received: by 2002:a17:906:7e4f:: with SMTP id z15mr42435846ejr.194.1625966678643;
 Sat, 10 Jul 2021 18:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210710113819.5170-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20210710113819.5170-1-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 11 Jul 2021 09:24:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9wvVJ6zZDmOt-8zJK2BkLtEO-h6QQRVkbc8q5QXtns3g@mail.gmail.com>
Message-ID: <CAAOTY_9wvVJ6zZDmOt-8zJK2BkLtEO-h6QQRVkbc8q5QXtns3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Add MediaTek SoC DRM (vdosys0) support for mt8195
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        fshao@google.com, Nancy Lin <nancy.lin@mediatek.com>,
        singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=
0=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=887:38=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> The hardware path of vdosys0 with eDP panel output need to go through
> by several modules, such as, OVL, RDMA, COLOR, CCORR, AAL, GAMMA,
> DITHER, DSC and MERGE.

You should add the difference in each version. [1] is an example for this.

[1] https://patchwork.kernel.org/project/linux-mediatek/cover/2021070902232=
4.1607884-1-eizan@chromium.org/

Regards,
Chun-Kuang.

>
> Add DRM and these modules support by the patches below:
>
> jason-jh.lin (9):
>   dt-bindings: mediatek: add definition for mt8195 display
>   dt-bindings: mediatek: add DSC definition for mt8195
>   dt-bindings: arm: mediatek: add definition for mt8195 mmsys
>   arm64: dts: mt8195: add display node for vdosys0
>   soc: mediatek: add mtk-mmsys support for mt8195 vdosys0
>   soc: mediatek: add mtk-mutex support for mt8195 vdosys0
>   drm/mediatek: add mediatek-drm of vdosys0 support for MT8195
>   drm/mediatek: add DSC support for MT8195
>   drm/mediatek: add MERGE support for MT8195
>
>  .../bindings/arm/mediatek/mediatek,mmsys.txt  |  15 +
>  .../display/mediatek/mediatek,disp.txt        |   9 +-
>  .../display/mediatek/mediatek,dsc.yaml        |  57 ++
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 111 ++++
>  drivers/gpu/drm/mediatek/Makefile             |   2 +
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  16 +
>  drivers/gpu/drm/mediatek/mtk_disp_dsc.c       | 205 +++++++
>  drivers/gpu/drm/mediatek/mtk_disp_merge.c     | 525 ++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |   6 +
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h       |  14 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |  29 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |   2 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  32 ++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +
>  drivers/soc/mediatek/mt8195-mmsys.h           | 191 +++++++
>  drivers/soc/mediatek/mtk-mmsys.c              |  11 +
>  drivers/soc/mediatek/mtk-mutex.c              | 107 +++-
>  include/linux/soc/mediatek/mtk-mmsys.h        |  10 +
>  18 files changed, 1337 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,dsc.yaml
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_dsc.c
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_merge.c
>  create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
>
> --
> 2.18.0
>
