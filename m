Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948B136AA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 04:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhDZCBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 22:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhDZCBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 22:01:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C043B611BD;
        Mon, 26 Apr 2021 02:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619402458;
        bh=PBSZMZjXTRgQdMRY26riL1Zlj5dFth8iLcEaBII3B6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNhgDcVUKQV/MFAnK1G6q23GOj5edc5p7Mzuf2LEiWKMZCMgpHSolQEaz1DadrSIB
         2GIT0uB6kHZRXaYFfEFpIbAzyvUarmXsMwAit7hVjxt0wBmdHe7BE4d7JEu3xTH5Fy
         xSwme9kTUfhS6/8gg+1X/xd/WZGiF+dtyg/Yt/yb03wLODalkFlU7HgkI7uJZDMWmb
         hV4dV9k1nD0thVjEgmHnS8kryLJzVkpN8D7REuT7PJGg1b2LAQeFvWaNctJzdxKRUX
         la0LS0H/+x2rg4o2iMzKengW0DYnYGFBJZCTcqWmbg+rwd96Anl3ZDgdMBFb0zZGCf
         P9CTF3zV3tdpw==
Date:   Mon, 26 Apr 2021 10:00:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to
 power up pcie phy
Message-ID: <20210426020053.GE27585@dragon>
References: <VI1PR04MB5853CB1B4E6C07C2DC3BC8D88C429@VI1PR04MB5853.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5853CB1B4E6C07C2DC3BC8D88C429@VI1PR04MB5853.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 01:28:34AM +0000, Richard Zhu wrote:
> > -----Original Message-----
> <snipped>
> > Subject: Re: [PATCH] arm64: dts: imx8mq-evk: add one regulator used
> > to power up pcie phy
> > On Mon, Mar 29, 2021 at 04:06:03PM +0800, Richard Zhu wrote:
> > > Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> > > In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> > > sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> > > the VREG_BYPASS bits of GPR registers should be cleared from default
> > > value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> > > turned on.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > index 85b045253a0e..4d2035e3dd7c 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > @@ -318,6 +318,7 @@
> > >                <&clk IMX8MQ_CLK_PCIE1_PHY>,
> > >                <&pcie0_refclk>;
> > >       clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> > > +     vph-supply = <&vgen5_reg>;
> > 
> > Hmm, I do not see this in the bindings doc.
> [Richard Zhu] Hi Shawn:
> The binding document changes are going to PCI tree by the following patch.
> 
> https://patchwork.kernel.org/project/linux-pci/patch/1617091701-6444-2-git-send-email-hongxing.zhu@nxp.com/

Ah, okay, ping me when the series is applied to PCI tree.

Shawn
