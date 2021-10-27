Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663C943C47D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbhJ0IAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240685AbhJ0IAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:00:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A2C061745;
        Wed, 27 Oct 2021 00:57:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 54B171F43DC5
Subject: Re: [PATCH v12 10/16] soc: mediatek: add mtk-mutex support for mt8195
 vdosys0
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
 <20211026155911.17651-11-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <7906cfbc-4eee-4821-3bd8-002a9bfb2766@collabora.com>
Date:   Wed, 27 Oct 2021 09:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026155911.17651-11-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/10/21 17:59, jason-jh.lin ha scritto:
> Add mtk-mutex support for mt8195 vdosys0.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> This patch is base on [1]
> 
> [1] soc: mediatek: add mtk mutex support for MT8192
> - https://patchwork.kernel.org/project/linux-mediatek/patch/1628647802-5127-5-git-send-email-yongqiang.niu@mediatek.com/
> ---
>   drivers/soc/mediatek/mtk-mutex.c | 95 +++++++++++++++++++++++++++++++-
>   1 file changed, 92 insertions(+), 3 deletions(-)
> 
