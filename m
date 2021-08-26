Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CCF3F82A9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbhHZGrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239956AbhHZGrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:47:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32AF2610CA;
        Thu, 26 Aug 2021 06:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629960379;
        bh=kTVS/WtvrGjhxqbtkL+V2pmqqGVGwaWjAVewc84Uhws=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VLeV6zGehZDEZvgb2AgWXx7NNsi5q3mFLh/Ef6WSVeY6OKIlJ8SSkMb0gd0E6aKif
         By1S24HtDKoKE1CcjkjUgeZXh3ehogX8nV6wCtTrS9JHWR+Ak38nqcAuFNf2YRfvuz
         9yOe120t210IUhRDf7ZpK3B331yxls0RvYtG1iMM5IIfK8itycXsb8gM4QYe0xADMY
         yFC6QP0pLCsCH0GFKY7UJSUfxaMaQBUeMtYAxS4dqyO02bz2ULgXxDCBYgOpRWwzVm
         hpfkP7Pc/xlVkHOJ2mkeyBMT4kURzJOtJDcd066JfmMaF3Kb6RgARjXP/ot68xnu+k
         DiHSBOcI2fxCQ==
Subject: Re: [PATCH v16 4/7] arm64: defconfig: Explicitly enable
 USB_XHCI_PLATFORM
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nishanth Menon <nm@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210813195228.2003500-1-mka@chromium.org>
 <20210813125146.v16.4.Id45138610b749ff775186ac10b3d01c504ddf4f3@changeid>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <dcea8257-f2f5-58f1-618c-a61545c5f9e7@kernel.org>
Date:   Thu, 26 Aug 2021 09:46:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210813125146.v16.4.Id45138610b749ff775186ac10b3d01c504ddf4f3@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2021 22:52, Matthias Kaehlcke wrote:
> The dependency of USB_DWC3 on USB_XHCI_PLATFORM is being changed
> from 'select' to 'depends on' by another patch. The defconfig selects
> USB_DWC3 and implicitly USB_DWC3_DUAL_ROLE, to keep this unchanged
> USB_XHCI_PLATFORM now needs to be selected explicitly.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

cheers,
-roger
> ---
> 
> Changes in v16:
> - none
> 
> Changes in v15:
> - none
> 
> Changes in v14:
> - rebased on v5.14-rc1 (with the rest of the series)
> - added 'Reviewed-by' tag from Doug
> 
> Changes in v13:
> - patch added to the series
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f423d08b9a71..b243bd11a4ed 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -802,6 +802,7 @@ CONFIG_USB_OTG=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_PCI=m
>  CONFIG_USB_XHCI_PCI_RENESAS=m
> +CONFIG_USB_XHCI_PLATFORM=y
>  CONFIG_USB_XHCI_TEGRA=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_EXYNOS=y
> 
