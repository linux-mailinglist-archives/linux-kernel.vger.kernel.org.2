Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F344D7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhKKN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:59:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45218 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhKKN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:59:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8FEFE1F45C72
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636638982; bh=KL910SP64J7G4Wb7kjnHDqpyVus2MRcEbakn+kqdIos=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U8XhgZf2aG7UA6FkTnLmxTDwrgfC2Tz/rnIRee255WLCLeL3/pCWUYD8a6clcyhhc
         0JfDUkVdl3PrpypTjoPk+wJxJO+FHvb9iOY16HBynUhzC7HUspx4IzAAK/097BcW7F
         ZssPgbrv6V5XNf1IfE3z8FI9FvBb91mFb1YI7wFFHy0qBfPTskRALq1uUHmo+C0zkt
         +fLKPWj0QIK3SuARD1n4+W+joLWjGLBDjxnhFZxtncAkcqp/qm88NF6AEthYZtGykR
         f4EJxAve32QAjlXtMwCNqrzgN2+oHml+wDlgpvC/jf9qXNzx31FLnjnkX1AqH5jwzK
         W2ybNjaMFjeMA==
Subject: Re: [RFC PATCH] soc: mediatek: Add support always on flag
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211102072058.4107-1-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <e6ebf764-b94a-7b77-df17-1cb8e4b14635@collabora.com>
Date:   Thu, 11 Nov 2021 14:56:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102072058.4107-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/11/21 08:20, Chunfeng Yun ha scritto:
> There is a t-phy shared by PCIe and USB3 on mt8195, if the t-phy is
> used by PCIe, when power off its mtcmos, need software reset it
> (workaround way, usually hardware do it, but has an issue on mt8195),
> but it has side effect to USB2 phy(works with USB3 phy to support
> USB3.2 Gen1), so add support GENPD_FLAG_ALWAYS_ON flag, and make its
> power always on;
> Another reason is that USB3.2 Gen1/2 need keep power always on when
> support runtime-pm due to hardware limitation until now;
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   drivers/soc/mediatek/mt8195-pm-domains.h | 2 +-
>   drivers/soc/mediatek/mtk-pm-domains.c    | 2 ++
>   drivers/soc/mediatek/mtk-pm-domains.h    | 1 +
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 

Hello Chunfeng,
what are are the side effects on the USB2 PHY? Can you please expand?

Also, wouldn't it be possible to also reset the USB2 PHY when resetting the t-phy
in order to get it back up and running?

Moreover, as for the USB3.2 hardware limitation... I would say that this is more
like something that has to be accounted for in the USB driver, instead of the PM
domains driver... unless there's some reason that stops you from doing that?

Thanks,
- Angelo
