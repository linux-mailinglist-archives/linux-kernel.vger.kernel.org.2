Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C364042EB18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbhJOIKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:10:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59056 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbhJOIKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:10:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A37FE1F45056
Subject: Re: [PATCH v6 02/16] dt-bindings: mediatek: add vdosys1 MERGE
 property for mt8195
To:     "Nancy.Lin" <nancy.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com
References: <20211004062140.29803-1-nancy.lin@mediatek.com>
 <20211004062140.29803-3-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <47958696-b3bc-8b80-4b7a-3f5d0df939e3@collabora.com>
Date:   Fri, 15 Oct 2021 10:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004062140.29803-3-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> MT8195 vdosys1 merge1 to merge4 have HW mute function.
> Add MERGE additional mute property description.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,merge.yaml  | 4 ++++
>   1 file changed, 4 insertions(+)
> 
Acked-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

