Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37743DB7FD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbhG3LpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhG3LpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:45:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1CEC061765;
        Fri, 30 Jul 2021 04:45:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 005DA1F41D20
Subject: Re: [PATCH v5 0/6] Add Mediatek Soc DRM (vdosys0) support for mt8195
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, fshao@chromium.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        hsinyi@chromium.org, Yongqiang Niu <yongqiang.niu@mediatek.com>,
        nancy.lin@mediatek.com, singo.chang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20210729170737.21424-1-jason-jh.lin@mediatek.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a8ce9da7-21c2-f9ef-161a-647d3f8748f3@collabora.com>
Date:   Fri, 30 Jul 2021 13:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729170737.21424-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thank you for your patch.

On 29/7/21 19:07, jason-jh.lin wrote:
> The hardware path of vdosys0 with eDP panel output need to go through
> by several modules, such as, OVL, RDMA, COLOR, CCORR, AAL, GAMMA,
> DITHER, DSC and MERGE.
> 


You said in other discussions that vdosys0 has eDP panel output and vdosys1 has
DP output. Is it possible to switch the outputs? What I am wondering is if this
configuration is hardware specific or board specific, i.e it'll be possible to
have another board that has DP output on vdosys0 and eDP output for vdosys1?

Thanks,
  Enric


> Change in v5:
> - add power-domain property into vdosys0 and vdosys1 dts node.
> - add MT8195 prifix and remove unused VDO1 define in mt8195-mmsys.h
> 
> Change in v4:
> - extract dt-binding patches to another patch series
>   https://patchwork.kernel.org/project/linux-mediatek/list/?series=519597
> - squash DSC module into mtk_drm_ddp_comp.c
> - add coment and simplify MERGE config function
> 
> Change in v3:
> - change mmsys and display dt-bindings document from txt to yaml
> - add MERGE additional description in display dt-bindings document
> - fix mboxes-cells number of vdosys0 node in dts
> - drop mutex eof convert define
> - remove pm_runtime apis in DSC and MERGE
> - change DSC and MERGE enum to alphabetic order
> 
> Change in v2:
> - add DSC yaml file
> - add mt8195 drm driver porting parts in to one patch
> - remove useless define, variable, structure member and function
> - simplify DSC and MERGE file and switch threre order
> 
> jason-jh.lin (6):
>   arm64: dts: mt8195: add display node for vdosys0
>   soc: mediatek: add mtk-mmsys support for mt8195 vdosys0
>   soc: mediatek: add mtk-mutex support for mt8195 vdosys0
>   drm/mediatek: add mediatek-drm of vdosys0 support for mt8195
>   drm/mediatek: add DSC support for mt8195
>   drm/mediatek: add MERGE support for mt8195
> 
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 112 ++++++++
>  drivers/gpu/drm/mediatek/Makefile           |   1 +
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   8 +
>  drivers/gpu/drm/mediatek/mtk_disp_merge.c   | 277 ++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   6 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  62 +++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   2 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  32 ++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  drivers/soc/mediatek/mt8195-mmsys.h         |  96 +++++++
>  drivers/soc/mediatek/mtk-mmsys.c            |  11 +
>  drivers/soc/mediatek/mtk-mutex.c            |  93 ++++++-
>  include/linux/soc/mediatek/mtk-mmsys.h      |   9 +
>  13 files changed, 706 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_merge.c
>  create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
> 
