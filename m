Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10163D2042
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhGVISG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231288AbhGVISC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:18:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BADE76138C;
        Thu, 22 Jul 2021 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626944317;
        bh=5+Ds4MASIrWRq99HNYMoMBFeXjK14QuDwTvs3AcKaRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HafYTP8ZiVw5V5Hkj03a5d00l6UZsBR8huXdlff2hbxNqNk29wjIL/YTjf3xiM1SJ
         PfzbZhi9vrxFqH0puM8PbnH/Xt5FZxACyBXPaketVObl2mDlcR0bHW+c3tHthswCC4
         8RxHOJU3ZME5XKnZ4r0v8iZBDAXYyML5md/eElDnN3jg+Z1Kjmn7wAZBsIp51wXLsG
         IMMXeU/tEUL+vA9PAhZMfda1SFYKDBdG8S9zAwBstCLKCEVHtJO72dXkHz4x+d4VME
         L0Ovff6IbIUDQWo0wcwToFzPCShQ85AwWaidGjGhqne2NAGbUwYCaLwRLUu1IufnFx
         aIf7Ckeq/jvog==
Date:   Thu, 22 Jul 2021 14:28:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v3 3/3] phy: phy-mtk-tphy: add support mt8195
Message-ID: <YPkzOWY0G4MFk7Nu@matsya>
References: <1626331702-27825-1-git-send-email-chunfeng.yun@mediatek.com>
 <1626331702-27825-3-git-send-email-chunfeng.yun@mediatek.com>
 <YPaIYI70823rK68w@matsya>
 <1626837468.4247.3.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626837468.4247.3.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-21, 11:17, Chunfeng Yun wrote:
> On Tue, 2021-07-20 at 13:55 +0530, Vinod Koul wrote:
> > On 15-07-21, 14:48, Chunfeng Yun wrote:
> > > The controller is designed to use use PLL integer mode, but
> > > in fact used fractional mode for some ones on mt8195, this
> > > causes signal degradation (e.g. eye diagram test fail), fix
> > > it by switching PLL to 26Mhz from default 48Mhz to improve
> > > signal quality.
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > > v2~3: no changes
> > > ---
> > >  drivers/phy/mediatek/phy-mtk-tphy.c | 52 +++++++++++++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > > 
> > > diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > index 42a1174da6cc..c3dc1763a7eb 100644
> > > --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> > > +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > @@ -41,6 +41,8 @@
> > >  
> > >  #define U3P_USBPHYACR0		0x000
> > >  #define PA0_RG_U2PLL_FORCE_ON		BIT(15)
> > > +#define PA0_USB20_PLL_PREDIV		GENMASK(7, 6)
> > > +#define PA0_USB20_PLL_PREDIV_VAL(x)	((0x3 & (x)) << 6)
> > >  #define PA0_RG_USB20_INTR_EN		BIT(5)
> > >  
> > >  #define U3P_USBPHYACR1		0x004
> > > @@ -52,6 +54,8 @@
> > >  #define PA1_RG_TERM_SEL_VAL(x)	((0x7 & (x)) << 8)
> > >  
> > >  #define U3P_USBPHYACR2		0x008
> > > +#define PA2_RG_U2PLL_BW			GENMASK(21, 19)
> > > +#define PA2_RG_U2PLL_BW_VAL(x)		((0x7 & (x)) << 19)
> > >  #define PA2_RG_SIF_U2PLL_FORCE_EN	BIT(18)
> > >  
> > >  #define U3P_USBPHYACR5		0x014
> > > @@ -73,6 +77,14 @@
> > >  #define P2C_USB20_GPIO_MODE		BIT(8)
> > >  #define P2C_U2_GPIO_CTR_MSK	(P2C_RG_USB20_GPIO_CTL | P2C_USB20_GPIO_MODE)
> > >  
> > > +#define U3P_U2PHYA_RESV		0x030
> > > +#define P2R_RG_U2PLL_FBDIV_26M		0x1bb13b
> > > +#define P2R_RG_U2PLL_FBDIV_48M		0x3c0000
> > > +
> > > +#define U3P_U2PHYA_RESV1	0x044
> > > +#define P2R_RG_U2PLL_REFCLK_SEL	BIT(5)
> > > +#define P2R_RG_U2PLL_FRA_EN		BIT(3)
> > > +
> > >  #define U3D_U2PHYDCR0		0x060
> > >  #define P2C_RG_SIF_U2PLL_FORCE_ON	BIT(24)
> > >  
> > > @@ -277,6 +289,12 @@ enum mtk_phy_version {
> > >  struct mtk_phy_pdata {
> > >  	/* avoid RX sensitivity level degradation only for mt8173 */
> > >  	bool avoid_rx_sen_degradation;
> > > +	/*
> > > +	 * u2phy should use integer mode instead of fractional mode of
> > > +	 * 48M PLL, fix it by switching PLL to 26M from default 48M
> > > +	 * for mt8195
> > > +	 */
> > > +	bool sw_pll_48m_to_26m;
> > >  	enum mtk_phy_version version;
> > >  };
> > >  
> > > @@ -456,6 +474,33 @@ static void u3_phy_instance_init(struct mtk_tphy *tphy,
> > >  	dev_dbg(tphy->dev, "%s(%d)\n", __func__, instance->index);
> > >  }
> > >  
> > > +static void u2_phy_pll_26m_set(struct mtk_tphy *tphy,
> > > +	struct mtk_phy_instance *instance)
> > > +{
> > > +	struct u2phy_banks *u2_banks = &instance->u2_banks;
> > > +	void __iomem *com = u2_banks->com;
> > > +	u32 tmp;
> > > +
> > > +	if (!tphy->pdata->sw_pll_48m_to_26m)
> > > +		return;
> > > +
> > > +	tmp = readl(com + U3P_USBPHYACR0);
> > > +	tmp &= ~PA0_USB20_PLL_PREDIV;
> > > +	tmp |= PA0_USB20_PLL_PREDIV_VAL(0);
> > > +	writel(tmp, com + U3P_USBPHYACR0);
> > > +
> > > +	tmp = readl(com + U3P_USBPHYACR2);
> > > +	tmp &= ~PA2_RG_U2PLL_BW;
> > > +	tmp |= PA2_RG_U2PLL_BW_VAL(3);
> > > +	writel(tmp, com + U3P_USBPHYACR2);
> > > +
> > > +	writel(P2R_RG_U2PLL_FBDIV_26M, com + U3P_U2PHYA_RESV);
> > > +
> > > +	tmp = readl(com + U3P_U2PHYA_RESV1);
> > > +	tmp |= P2R_RG_U2PLL_FRA_EN | P2R_RG_U2PLL_REFCLK_SEL;
> > > +	writel(tmp, com + U3P_U2PHYA_RESV1);
> > > +}
> > > +
> > >  static void u2_phy_instance_init(struct mtk_tphy *tphy,
> > >  	struct mtk_phy_instance *instance)
> > >  {
> > > @@ -941,6 +986,7 @@ static int mtk_phy_init(struct phy *phy)
> > >  
> > >  	switch (instance->type) {
> > >  	case PHY_TYPE_USB2:
> > > +		u2_phy_pll_26m_set(tphy, instance);
> > 
> > should this not be set only for MTK_PHY_V3?
> Workaround only for mt8195, HW will fix it for others (V3)

Pls document that in comments here

-- 
~Vinod
