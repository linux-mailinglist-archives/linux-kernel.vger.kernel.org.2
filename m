Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF85143C477
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhJ0IAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:00:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50220 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbhJ0H75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:59:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 22D991F43DAD
Subject: Re: [PATCH v12 15/16] drm/mediatek: add MERGE support for
 mediatek-drm
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        hsinyi@chromium.org, fshao@chromium.org, moudy.ho@mediatek.com,
        roy-cw.yeh@mediatek.com, Fabien Parent <fparent@baylibre.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        nancy.lin@mediatek.com, singo.chang@mediatek.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211026155911.17651-1-jason-jh.lin@mediatek.com>
 <20211026155911.17651-16-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <7a077be9-10a3-f076-2a3a-f57aacd6d876@collabora.com>
Date:   Wed, 27 Oct 2021 09:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026155911.17651-16-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/10/21 17:59, jason-jh.lin ha scritto:
> Add MERGE engine file:
> MERGE module is used to merge two slice-per-line inputs
> into one side-by-side output.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> rebase on series [1]
> 
> [1] drm/mediatek: add support for mediatek SOC MT8192
> - https://patchwork.kernel.org/project/linux-mediatek/list/?series=529489
> ---
>   drivers/gpu/drm/mediatek/Makefile           |   1 +
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   8 +
>   drivers/gpu/drm/mediatek/mtk_disp_merge.c   | 246 ++++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  16 ++
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   4 +-
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>   7 files changed, 276 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_merge.c
> 
