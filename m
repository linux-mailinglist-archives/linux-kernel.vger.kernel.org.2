Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4088433882
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhJSOkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJSOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:40:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F152EC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:38:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CA94A1F43B5F
Subject: Re: [PATCH] arm64: defconfig: enable regulator to fix mt8173
 regression
To:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, "kernelci.org bot" <bot@kernelci.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
References: <20211011125301.3440033-1-adrian.ratiu@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <bd29b949-0ec1-704f-73de-c36b5120b445@collabora.com>
Date:   Tue, 19 Oct 2021 16:38:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011125301.3440033-1-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/10/21 14:53, Adrian Ratiu ha scritto:
> A regression was introduced on some mediatek boards starting with
> v5.15-rc1 in commit 109fd20601e2b ("arm64: dts: mediatek: mt8173:
> Add domain supply for mfg_async") which effectively changed the
> regulator from the always-on dummy to DA9211 without explicitely
> enabling it, causing failures like the these caught by KernelCI
> on Hana Chromebooks [1]:
> 
> mtk-power-controller 10006000.syscon:power-controller: supply domain not found, using dummy regulator
> mtu3 11271000.usb: supply vbus not found, using dummy regulator
> xhci-mtk 11270000.usb: supply vbus not found, using dummy regulator
> 
> There might be another bug linking these power domains in the
> mediatek PM driver, but that is a separate issue wich needs
> addressing, for now just fix the obvious regression due to the
> new regulator requirement.
> 
> [1] https://github.com/kernelci/kernelci-project/issues/66
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Cc: Guillaume Tucker <guillaume.tucker@collabora.com>
> Suggested-by: Enric Balletbo Serra <eballetbo@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 156d96afbbfc..4901cc1213bb 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -616,6 +616,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
>   CONFIG_REGULATOR_AXP20X=y
>   CONFIG_REGULATOR_BD718XX=y
>   CONFIG_REGULATOR_BD9571MWV=y
> +CONFIG_REGULATOR_DA9211=y
>   CONFIG_REGULATOR_FAN53555=y
>   CONFIG_REGULATOR_GPIO=y
>   CONFIG_REGULATOR_HI6421V530=y
> 

Hello,

I've been able to get a working Hana boot, with USB probed as early as possible, as
well solving that KernelCI failure (as now also the usb network works fine again).

My proposal here, for which I have a patch that's almost ready, would be to enable
this regulator driver as a module instead (since Hana is the only device that's
using it), avoiding to increase the kernel image size for everyone.


Before pointing out my solution, let's first point out what's going on:

In mt8173.dtsi, we have a power-controller node (mediatek,mt8173-power-controller),
under which all of the SoC's power domain nodes are defined. In this node, we have
both SCPD_DOMAIN_SUPPLY domains and "regular" ones.

The difference between SCPD domains and the others is that the first ones require a
parent regulator, while the latter don't (power is supplied from some .. internal
supply? - either way, no parent vreg necessary/declared).
As a note, for now, the only two MediaTek SoCs that have a SCPD supply are MT8173
and MT8183... and nothing else, as the others, including the newer ones seem to
have no such supplies (the only newer one upstream is MT8192 and has none).


My solution was to split the power-controller node in two:
1. spm: power-controller@0 - contains all of the non-SCPD power domains
2. spm_scpd: power-controller@1 - contains the SCPD power domains.

This made me able to get a full boot without usb/usb-eth issues while enabling this
regulator as a module; this also requires us to change the
mediatek,power-controller.yaml binding to allow multiple instances of that driver,
which is anyway already permitted by the mtk-pm-domains driver itself.


Hence, this question comes up: how should we proceed? should we...
a. enable this regulator driver as module and split the power-controller in two; or
b. keep this commit enabling this driver built-in and still split the
    power-controller nodes; or
c. just enable this driver as built-in and not care about declaring two power
    controller nodes?

Can you please give us an advice?

Thank you,
- Angelo
