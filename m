Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F403B3FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFYJAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:00:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53972 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYJAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:00:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 41BA21F44479
Subject: Re: [RESEND PATCH v2 4/4] soc: mediatek: pm-domains: Remove unused
 macro
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210616000659.28347-1-chun-jie.chen@mediatek.com>
 <20210616000659.28347-5-chun-jie.chen@mediatek.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cdae8ee3-80ac-e29c-692d-9362db9451a5@collabora.com>
Date:   Fri, 25 Jun 2021 10:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616000659.28347-5-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie Chen,

Thank you for your patch.

On 16/6/21 2:06, Chun-Jie Chen wrote:
> Due to clk resource data will be allocated dynamically by
> searching parent count of clk in power domain node, so remove
> the unused marco MAX_SUBSYS_CLKS for static allocation.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/soc/mediatek/mtk-pm-domains.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index caaa38100093..1b8967b9829e 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -72,8 +72,6 @@ struct scpsys_bus_prot_data {
>  	bool ignore_clr_ack;
>  };
>  
> -#define MAX_SUBSYS_CLKS 10
> -
>  /**
>   * struct scpsys_domain_data - scp domain data for power on/off flow
>   * @name: The name of the power domain.
> 
