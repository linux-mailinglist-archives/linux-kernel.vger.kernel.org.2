Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4122836AABD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 04:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhDZCmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 22:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231700AbhDZCms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 22:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A276761107;
        Mon, 26 Apr 2021 02:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619404928;
        bh=7+Fqg0IT+8ZOMQZtO2ypYlYAB+7yIbD8Q7oU3KiEamc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Is6+hyKIQlyZMBJ38jK24zG/MnIuWzHYq1SqMGKCQEYV42jgedGXF7/xfMJ2w1xhH
         bouERckSvxvxReIecRuBOSYjg+q14ctuP0ATjWw7zO4ImixRYmwwuZtVOl8xnGEMmt
         eWJTUAkwQ2hVRtffJpK5NuHa3p2EYRl46E8FOF8Cg4pBnE6CnPWQAclh+LWGNSDLZB
         sYiRnZ5Rxxnno5q7kd2sTAZrFEalVfpEE1FpTJFudbItC56eNYyDs6PhquU0LoxthD
         VT/bfgKcetcj9HGUWM69/wPLC1Oj3e2fjV+NYpnB4JmBUOAM2u2Pheh35O+9qnXoKH
         IxZaH9hDPcGdg==
Date:   Mon, 26 Apr 2021 10:42:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: imx: add imx8mm gw7901 support
Message-ID: <20210426024202.GH27585@dragon>
References: <20210330151944.7368-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330151944.7368-1-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 08:19:43AM -0700, Tim Harvey wrote:
> The Gateworks GW7901 is an ARM based single board computer (SBC)
> featuring:
>  - i.MX8M Mini SoC
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - SPI FRAM
>  - Gateworks System Controller (GSC)
>  - Atmel ATECC Crypto Authentication
>  - USB 2.0
>  - Microchip GbE Switch
>  - Multiple multi-protocol RS232/RS485/RS422 Serial ports
>  - onboard 802.11ac WiFi / BT
>  - microSD socket
>  - miniPCIe socket with PCIe, USB 2.0 and dual SIM sockets
>  - Wide range DC power input
>  - 802.3at PoE
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied both, thanks.
