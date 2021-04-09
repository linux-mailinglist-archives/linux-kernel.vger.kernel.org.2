Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99A35A385
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhDIQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:38:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBC6C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7vUNmalk2R8kDO1H1F3sed0Lw4MXaia2rqm7pCWfaMk=; b=j+MyKb1MKd2IZ7OGpKe1+ohXZ4
        ZmJ+HM1m+V/ukIijWCIpcIsVTjBFflFlaKgjpv67B+GqPOE0uUZX44S3KohWs0zlYjKpcIKOq0n2k
        /LW7AHLuD0lNlv1iNFLquBMWF5Bh4LBHf9VE7RVe4is1fIqyf4i+UamOY1VjTy4OpLqrbs85obl52
        P3AwWnm8Az8l23yHnbyNCV0rfW3lgbk5UoGnIR/1bIpalCmpzslRJ1VYwMDTCT2k4Yvanp76oNr39
        EIF+u7Th2FONKvGSjaGI0M85TgEGoO4NVNY9ioqquw8e6ShxIBAe9QuK9tl0Tfc+n4yRzHKPEwjJ0
        fvVLlgow==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUu8n-001876-Hu; Fri, 09 Apr 2021 16:37:53 +0000
Subject: Re: [PATCH v2] drm/bridge/sii8620: fix dependency on extcon
To:     Robert Foss <robert.foss@linaro.org>, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kernel test robot <lkp@intel.com>
References: <20210408130746.175358-1-robert.foss@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f1d5f9d4-cb98-cc1c-83ef-74e7e8005b1f@infradead.org>
Date:   Fri, 9 Apr 2021 09:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210408130746.175358-1-robert.foss@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 6:07 AM, Robert Foss wrote:
> The DRM_SIL_SII8620 kconfig has a weak `imply` dependency
> on EXTCON, which causes issues when sii8620 is built
> as a builtin and EXTCON is built as a module.
> 
> The symptoms are 'undefined reference' errors caused
> by the symbols in EXTCON not being available
> to the sii8620 driver.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> 
> Changes since v1:
>  - Fix typo on comment
> 
>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 22a467abd3e9..2289b44613af 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -169,7 +169,7 @@ config DRM_SIL_SII8620
>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>  	depends on OF
>  	select DRM_KMS_HELPER
> -	imply EXTCON
> +	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
>  	depends on RC_CORE || !RC_CORE
>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
> 

That gives me: (on linux-next 20210409)

drivers/gpu/drm/Kconfig:77:error: recursive dependency detected!
drivers/gpu/drm/Kconfig:77:	symbol DRM_KMS_HELPER is selected by DRM_SIL_SII8620
drivers/gpu/drm/bridge/Kconfig:168:	symbol DRM_SIL_SII8620 depends on EXTCON
drivers/extcon/Kconfig:2:	symbol EXTCON is selected by CHARGER_MANAGER
drivers/power/supply/Kconfig:499:	symbol CHARGER_MANAGER depends on POWER_SUPPLY
drivers/power/supply/Kconfig:2:	symbol POWER_SUPPLY is selected by OLPC_XO1_SCI
arch/x86/Kconfig:2757:	symbol OLPC_XO1_SCI depends on GPIO_CS5535
drivers/gpio/Kconfig:1156:	symbol GPIO_CS5535 depends on GPIOLIB
drivers/gpio/Kconfig:14:	symbol GPIOLIB is selected by I2C_MUX_LTC4306
drivers/i2c/muxes/Kconfig:47:	symbol I2C_MUX_LTC4306 depends on I2C
drivers/i2c/Kconfig:8:	symbol I2C is selected by FB_DDC
drivers/video/fbdev/Kconfig:63:	symbol FB_DDC depends on FB
drivers/video/fbdev/Kconfig:12:	symbol FB is selected by DRM_KMS_FB_HELPER
drivers/gpu/drm/Kconfig:83:	symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
For a resolution refer to Documentation/kbuild/kconfig-language.rst
subsection "Kconfig recursive dependency limitations"


-- 
~Randy

