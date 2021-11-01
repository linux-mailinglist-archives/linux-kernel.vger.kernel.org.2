Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B4C4418F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhKAJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:53:53 -0400
Received: from mail.zeus.flokli.de ([88.198.15.28]:55402 "EHLO zeus.flokli.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232514AbhKAJtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:49:17 -0400
Received: from localhost (dslb-094-221-236-183.094.221.pools.vodafone-ip.de [94.221.236.183])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 34FFE11E59DA;
        Mon,  1 Nov 2021 09:46:42 +0000 (UTC)
Date:   Mon, 1 Nov 2021 10:46:41 +0100
From:   Florian Klink <flokli@flokli.de>
To:     Dennis Gilmore <dgilmore@redhat.com>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: helios64: add variables for pcie
 completion
Message-ID: <20211101094641.cseo7fvrzyzh2pkl@tp>
References: <20211029005323.144652-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211029005323.144652-1-dgilmore@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-By: Florian Klink <flokli@flokli.de>

On 21-10-28 19:53:19, Dennis Gilmore wrote:
>without ep-gpios defined u-boot does not initialise PCIe
>rockchip_pcie pcie@f8000000: failed to find ep-gpios property
>
>additionally set max-link-speed and pinctrl-names for completeness
>
>with this patch and the ones from Florian Klink applied to the dts
>file in u-boot sata drives show up in both u-boot and linux
>
>Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
>---
> arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
>index 9c2b45012daa..1e4042a7fdc3 100644
>--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
>+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
>@@ -534,7 +534,10 @@ &pcie_phy {
> };
>
> &pcie0 {
>+	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
>+	max-link-speed = <2>;
> 	num-lanes = <2>;
>+	pinctrl-names = "default";
> 	status = "okay";
>
> 	vpcie12v-supply = <&vcc12v_dcin>;
>-- 
>2.32.0

-- 
Florian Klink
