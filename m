Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA28344D764
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhKKNod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:44:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44924 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKKNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:44:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 21BC01F45C4A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636638099; bh=CHJDHhiAjdq3L1NauwCONE1XBN60xw/moDpKBFO9Dxw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L9UMZXx8zbtGS9X/Im0l2+D9XOOvuHBhzVk09tPpvbMkqdxtPy9WYwmxG7BuJ8REw
         b2MrW2a/IZ8B46fb5VSAlCQfyJ39MI5brGxWrc+CWU2vQzKjX2DHab5QOUL+tjeCVv
         lc51RaT7Bz79Q2eRgbaf80NkVtf4mZTbjs29lvfMWJuwVEmYz4iFkwFQSlHGhp76mk
         UWckffRvR1upBhOlt//dMvm1QV9ljDZke7uiDJCzKwTI/8fVe43xn0FV3OZKAkN7qn
         2vfVnIhcB0k/pyl+mOUGE4nlDleWUGpzNy80RBZBTBqt3qzo/HZF8i46SIjskD6Oto
         6YSkobhbxS+Xw==
Subject: Re: [PATCH v2] memory: mtk-smi: Fix a null dereference for the ostd
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com, Ikjoon Jang <ikjn@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20211108082429.15080-1-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1d72bac8-eb79-6f34-79ca-4c5c38d6d2bf@collabora.com>
Date:   Thu, 11 Nov 2021 14:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108082429.15080-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/11/21 09:24, Yong Wu ha scritto:
> We add the ostd setting for mt8195. It introduces a KE for the
> previous SoC which doesn't have ostd setting. This is the log:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000080
> ...
> pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> lr : mtk_smi_larb_resume+0x54/0x98
> ...
> Call trace:
>   mtk_smi_larb_config_port_gen2_general+0x64/0x130
>   pm_generic_runtime_resume+0x2c/0x48
>   __genpd_runtime_resume+0x30/0xa8
>   genpd_runtime_resume+0x94/0x2c8
>   __rpm_callback+0x44/0x150
>   rpm_callback+0x6c/0x78
>   rpm_resume+0x310/0x558
>   __pm_runtime_resume+0x3c/0x88
> 
> In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
> if "larb->larb_gen->ostd" is null, the "larbostd" is the offset(e.g.
> 0x80 above), it's also a valid value, then accessing "larbostd[i]" in the
> "for" loop will cause the KE above. To avoid this issue, initialize
> "larbostd" to NULL when the SoC doesn't have ostd setting.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> change note: Reword the commit message to show why it KE. and update the
> solution via initializing "larbostd" is NULL explicitly in the non-ostd
> case.
> ---
>   drivers/memory/mtk-smi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

This commit needs a Fixes tag. Please add the proper one.
