Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF940274C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbhIGKkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhIGKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:40:32 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E9C061575;
        Tue,  7 Sep 2021 03:39:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id i28so15749447ljm.7;
        Tue, 07 Sep 2021 03:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y80WS7pFMqN4bYjumzSdzxNpiylpWl/BzFoVajY+R58=;
        b=USgUVxF2cllMA+jyzKSAbSVaKtoX+UtlBVJRw7osdamKAo7UZprPMd/6ZA4EcmZ4RK
         oFS+TFvcynsNImFe/t+UGz477rc7BvDJGbO/328VmOFGD31tjMLqtSTGHiERLkK3pMGg
         QRoiUHlwpcUhMgDq5Lu9WrlYwHnPdPr+p7O37dgN2HIWMf9Xrk3wck8ct+901KbKsL63
         5EcrINIYFNDtKyIUpWOw2OwT+4QbQzzjh2fmvizWHZp/4y0x8RbCb5lPG/8DDXVLUTs3
         8vTbjQMJtbRiFBPPk1dPcTxoawSh0/jCkaw06Y6U+15U4F5gzl7T1lRjUptS4YSVrzh/
         b5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y80WS7pFMqN4bYjumzSdzxNpiylpWl/BzFoVajY+R58=;
        b=YmpMUAIndV0ScOPGkihWg81vDdmUkeMc94pnArhg836V0Sy9NtydkETBMHoc1ENL42
         Ab936idPiBnjkKpO1ET3OrOQU8jnU/GNXO12gy0urjRWBOB41t1pzz93xW9tovKmzP8A
         yDR+VFDJuC9NnVsYBIEl+u1jN/PtyrvseUspfRhJ/cnGDHnDoWZ9mLordalWpqWeNbIc
         pkji8SZ6By+2FuRJnCSMBEWdxyhoiafC3Eq8kspSNQa7Ek0HUCUeBZowpSoLyONaox48
         MOOmTNgXpzIDQcFF9NHysfctQuFnJel7dv40Aa5F3fWLMJiL2mTbbRla3fdXOyWQtbwu
         YLcQ==
X-Gm-Message-State: AOAM532icx8991GyPmI9ZFFJ8NIEGA1Ops/IPK66ixcjUGe1Aap0GYKR
        jxbtn53JhAlv6na+IgxvpLeAPTH8aW8=
X-Google-Smtp-Source: ABdhPJzEueb3IckakZL0aUGh86hi9RXAhg51RbyxkzfFwoh4lwy3w2fvb6V6s47JY32uuSV9U1zR6A==
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr13877141ljp.312.1631011164375;
        Tue, 07 Sep 2021 03:39:24 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id q11sm1375802ljp.91.2021.09.07.03.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 03:39:23 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] ARM: multi_v7_defconfig: Add support for Airoha
 EN7523 SoC
To:     Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Olivier Moysan <olivier.moysan@st.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lionel Debieve <lionel.debieve@st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210907102722.47543-1-bert@biot.com>
 <20210907102722.47543-6-bert@biot.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <93abbefa-1ee6-7913-a41e-3e587e9a747a@gmail.com>
Date:   Tue, 7 Sep 2021 13:39:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210907102722.47543-6-bert@biot.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.09.2021 13:27, Bert Vermeulen пишет:
> From: John Crispin <john@phrozen.org>
> 
> This enables basic bootup support for the Airoha EN7523 SoC.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index d9abaae118dd..a9370a95dc38 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -31,6 +31,7 @@ CONFIG_MACH_BERLIN_BG2=y
>  CONFIG_MACH_BERLIN_BG2CD=y
>  CONFIG_MACH_BERLIN_BG2Q=y
>  CONFIG_ARCH_DIGICOLOR=y
> +CONFIG_ARCH_AIROHA=y
>  CONFIG_ARCH_EXYNOS=y
>  CONFIG_ARCH_HIGHBANK=y
>  CONFIG_ARCH_HISI=y
> @@ -983,6 +984,7 @@ CONFIG_STAGING_BOARD=y
>  CONFIG_MFD_CROS_EC_DEV=m
>  CONFIG_CROS_EC_I2C=m
>  CONFIG_CROS_EC_SPI=m
> +CONFIG_COMMON_CLK_EN7523=y

If SoC doesn't work without clk support, then this option should be
auto-selected by the arch option.

It also doesn't look like upstream kernel has COMMON_CLK_EN7523 at all.
