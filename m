Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4F32ADBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359897AbhCBWFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1836075AbhCBThF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:37:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1B5D64F38;
        Tue,  2 Mar 2021 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614702746;
        bh=yumA0cahWTD9QKsYQGmd5EnWtZ0ZFFVwv1aA4Z0Bb98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJ19DVR55kPfbyXMcsrz/03FRzp0jmKIAnxQ9RGA4YhpkPNZpPaiu0Jai15qoliiD
         vTxy9f9LM2sDIOafwlRf+rfe4RhR4Xx5PRwVhnT/4SAci94zznNl8mN+17/UHYFVlh
         4gOFlMdTdx6wPcjh17NCIATGiswdGHvK2TKbOAqYpL4MPuf01zd+egP86vQX06jTDc
         zKmveU+OGTV1jOCJa71o35jBGe4liaYgTgNpFt3zUuwFFptOSKhOoS420onTPSnM1X
         nQMIK7czeNZJ2BiUHSHLmOyXurTqzHnFCide8lW9bLbOn+57Ad3eaHiYSvXTjMV0yp
         s1R7rrYcH2/+A==
Date:   Tue, 2 Mar 2021 22:02:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 9/9] phy/drivers/stm32: Use HZ macros
Message-ID: <YD5olWDZ50sLVn7w@vkoul-mobl>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
 <20210224144222.23762-9-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224144222.23762-9-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-21, 15:42, Daniel Lezcano wrote:
> HZ unit conversion macros are available in units.h, use them and
> remove the duplicate definition.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/phy/st/phy-stm32-usbphyc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
> index a54317e96c41..02dd12bb4692 100644
> --- a/drivers/phy/st/phy-stm32-usbphyc.c
> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/reset.h>
> +#include <linux/units.h>
>  
>  #define STM32_USBPHYC_PLL	0x0
>  #define STM32_USBPHYC_MISC	0x8
> @@ -48,7 +49,6 @@ static const char * const supplies_names[] = {
>  #define PLL_FVCO_MHZ		2880
>  #define PLL_INFF_MIN_RATE_HZ	19200000
>  #define PLL_INFF_MAX_RATE_HZ	38400000
> -#define HZ_PER_MHZ		1000000L

I dont see this in units.h, can you send this once it is merged upstream

-- 
~Vinod
