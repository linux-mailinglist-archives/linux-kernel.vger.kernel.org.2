Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637B93196A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhBKX3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhBKX3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:29:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D55F664DD8;
        Thu, 11 Feb 2021 23:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613086125;
        bh=MZAWePskn2HEdxy+HD42A1K7WAT50DQT5epDnHayuP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPLRMqpQbwGDlvlcvKfv3OxlN2Qo6J6OpexYxz2q5SXR7ymCTFQfJnDEzpMyj8DyB
         vt1zxrKbbmGpcx+JD7gi66kDvzf+UhX0dHaZbcaBaDHO4b3GTcpyIQsLmTHAMpBiO2
         a6yH3uLJ7A4BX9vA4G2ZXhCCg8MgU0axjHlKnWPJlAU66bhqJj1Gf4ZamKgWuhyQYp
         TKc3gFOaYGxNt7AQy85hy00gEhu9cyxEZjORuWOlKOxeNvyQqBUgvP0UjF+pMNp/o/
         Hnfdhbz6Kr4D/JSI1TeWQLtfuGbpa6UezwbabYCVAzK+aO5wZDXNCP1Ge7skFOU7L/
         QD/GRm3y7+9Bg==
Received: by pali.im (Postfix)
        id 7B912A80; Fri, 12 Feb 2021 00:28:42 +0100 (CET)
Date:   Fri, 12 Feb 2021 00:28:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     kostap@marvell.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, mw@semihalf.com,
        jaz@semihalf.com, nadavh@marvell.com, stefanc@marvell.com,
        bpeled@marvell.com
Subject: Re: [PATCH v2 06/12] arm64: dts: marvell: armada-3270-espressobin:
 add comphy references
Message-ID: <20210211232842.no4jhvdwh4634cyt@pali>
References: <20210210140949.32515-1-kostap@marvell.com>
 <20210210140949.32515-7-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210140949.32515-7-kostap@marvell.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 February 2021 16:09:43 kostap@marvell.com wrote:
> From: Grzegorz Jaszczyk <jaz@semihalf.com>
> 
> Add "phys" entries pointing to COMPHYs to PCIe and USB3 nodes
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>

Hello! This patch is not needed and now does nothing.

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index daffe136c523..bbd955909813 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -59,6 +59,8 @@
>  /* J9 */
>  &pcie0 {
>  	status = "okay";
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&comphy1 0>;

In mainline kernel is PCIe PHY already provided in armada-37xx.dtsi:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/marvell/armada-37xx.dtsi#n497

>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
>  	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
> @@ -139,6 +141,9 @@
>  /* J7 */
>  &usb3 {
>  	status = "okay";
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&comphy0 0>;
> +	phy-names = "usb";

In mainline kernel is USB 3.0 PHY already provided in armada-37xx.dtsi:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/marvell/armada-37xx.dtsi#n359

>  };
>  
>  /* J8 */
> -- 
> 2.17.1
> 

So final binary espressobin DTB files are same with and without this
patch.
