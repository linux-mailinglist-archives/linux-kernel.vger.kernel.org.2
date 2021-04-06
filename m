Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE52C354D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbhDFGwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:52:02 -0400
Received: from mx.socionext.com ([202.248.49.38]:17148 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhDFGwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:52:01 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Apr 2021 15:51:52 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 3F7A1205902A;
        Tue,  6 Apr 2021 15:51:53 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 6 Apr 2021 15:51:53 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id E740FB1D49;
        Tue,  6 Apr 2021 15:51:52 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id C161FE85F8;
        Tue,  6 Apr 2021 15:51:52 +0900 (JST)
Date:   Tue, 06 Apr 2021 15:51:52 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] ARM: dts: uniphier: Change phy-mode to RGMII-ID to enable delay pins for RTL8211E
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <1615250236-11349-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1615250236-11349-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <20210406155152.FB36.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping.
Are there any comments about these two patches?

Thank you,

On Tue, 9 Mar 2021 09:37:15 +0900
Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:

> After applying the commit bbc4d71d6354
> ("net: phy: realtek: fix rtl8211e rx/tx delay config"), the configuration
> register for TXDLY and RXDLY is set correctly.
> 
> Although PXs2 boards have RTL8211E for gigabit network PHY, it turrned out
> that the phy-mode should be RGMII-ID mode. This changes 'phy-mode' property
> to 'rgmii-id' as default.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> index 4d9f69a..5ba831e 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -583,7 +583,7 @@
>  			clocks = <&sys_clk 6>;
>  			reset-names = "ether";
>  			resets = <&sys_rst 6>;
> -			phy-mode = "rgmii";
> +			phy-mode = "rgmii-id";
>  			local-mac-address = [00 00 00 00 00 00];
>  			socionext,syscon-phy-mode = <&soc_glue 0>;
>  
> -- 
> 2.7.4

---
Best Regards,
Kunihiko Hayashi

