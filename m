Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273BC42A2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhJLKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236018AbhJLKvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:51:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FCDE60240;
        Tue, 12 Oct 2021 10:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634035762;
        bh=7RxK5vIYZ8w49aIatScu2gUFdQZO076SRJYJxhOzvA8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fP71SMj5YBbMdMJxE8D1GwSY76B6TNy33EE8QCmDhj1NexRkrJsc5STht2r8HB62g
         3MKcjvvqizeXhLKn+4ktBQDg5keb/b+65i8WxM4cBCvtM0bJyNtESYKgFFwuhyN1qP
         yJ3Kk/pNm+35DsM15Abvd/RHXoCcD3ea0YB8NfJSGXnfGtUlgAZX/kpQpGDJougfqi
         6yzGwZ7z1sGAfBVtOzQ1SiNRXod7mtJbLfgehskoLAosmJ8d5cmEcj4FNkBZT2w1aL
         P6uXPBIGXT2e8ayHUONtMHfPmzXp5ns5wxe8FTYEJAkxlB28vZxwr+S2Dg/t6g5S5N
         pN7srbLnYapaA==
Message-ID: <5fd543da-fd49-23c5-f4ba-531aaf8cb377@kernel.org>
Date:   Tue, 12 Oct 2021 13:49:12 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: defconfig: Enable SC7180 interconnect driver
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, bjorn.andersson@linaro.org
Cc:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        krzk@kernel.org, geert+renesas@glider.be, vkoul@kernel.org,
        jagan@amarulasolutions.com, agx@sigxcpu.org,
        biju.das.jz@bp.renesas.com, enric.balletbo@collabora.com,
        aford173@gmail.com, nm@ti.com,
        andrey.zhizhikin@leica-geosystems.com, saravanak@google.com,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org
References: <20211011154003.904355-1-angelogioacchino.delregno@collabora.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20211011154003.904355-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.21 18:40, AngeloGioacchino Del Regno wrote:
> On SC7180 device trees, almost all of the nodes are declaring
> interconnect properties, including the QUP nodes: at least on
> some machines, leaving this configuration option disabled, or
> as a module, the kernel appears to hang while initializing the
> QUP node containing the UART device.
> 
> To solve this issue, enable the interconnect driver for this
> SoC as built-in.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index fc40ae9e9bdb..171848ace3ac 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1172,6 +1172,7 @@ CONFIG_INTERCONNECT_IMX8MQ=m
>   CONFIG_INTERCONNECT_QCOM=y
>   CONFIG_INTERCONNECT_QCOM_MSM8916=m
>   CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> +CONFIG_INTERCONNECT_QCOM_SC7180=y
>   CONFIG_INTERCONNECT_QCOM_SDM845=y
>   CONFIG_INTERCONNECT_QCOM_SM8150=m
>   CONFIG_INTERCONNECT_QCOM_SM8250=m
> 

