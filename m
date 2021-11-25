Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4145D412
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 06:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhKYFSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 00:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239517AbhKYFQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 00:16:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26ED6610A7;
        Thu, 25 Nov 2021 05:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637817184;
        bh=IUTVms87b2Lwm37fHSCFddJ6zRnvFeWWfi2unK+Tsio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCbHkPG1HoHB/wSP+Nq4KXjyftpSv9Q0RgKOZUinmBILkvv0qIme5tYXyzVACBSB0
         kfvdA81nzPxCqpIaQrhXIC4am+hIMl2PYTgBkTjpDjoht37Iyhvoo4mSo/DXjvzVgp
         G5NmmAQZk4GhOCQj/VVIT6fJbPGSiKHRl0SHH1MY5L2kCy01Yjn78X8jPlhZuHPWAJ
         I+C8uXoZ8whL74YNBShZi3grwal4AcMFOd2wc7FtDVGoIK8bOJu1lmMqfubQD4neEJ
         qLX7Hf0javowjyd1LPRz0G1OSWzEkylDN0g4gZ3tRoVlQAFmqkpITfdw0oLyLPE4/B
         zJaQMKjJb+g4w==
Date:   Thu, 25 Nov 2021 10:42:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yz Wu <yz.wu@mediatek.com>
Subject: Re: [PATCH 5/6] phy: phy-mtk-tphy: add support efuse setting
Message-ID: <YZ8bW+bAkxcg2G/U@matsya>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
 <20211107075646.4366-5-chunfeng.yun@mediatek.com>
 <YZuAab3j+flr1xXj@matsya>
 <1e51d7bf0e77ddb4d558f0a4407dec5cdc1bc35e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e51d7bf0e77ddb4d558f0a4407dec5cdc1bc35e.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-11-21, 14:54, Chunfeng Yun wrote:
> On Mon, 2021-11-22 at 17:05 +0530, Vinod Koul wrote:
> > On 07-11-21, 15:56, Chunfeng Yun wrote:
> > > Due to some SoCs have a bit shift issue that will drop a bit for
> > > usb3
> > > phy or pcie phy, fix it by adding software efuse reading and
> > > setting,
> > > but only support it optionally for versoin 2/3.
> > 
> > s/versoin/version
> Ok
> > 
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  drivers/phy/mediatek/phy-mtk-tphy.c | 162
> > > ++++++++++++++++++++++++++++
> > >  1 file changed, 162 insertions(+)
> > > 
> > > diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> > > b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > index cdcef865fe9e..3b5b1c266595 100644
> > > --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> > > +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/iopoll.h>
> > >  #include <linux/mfd/syscon.h>
> > >  #include <linux/module.h>
> > > +#include <linux/nvmem-consumer.h>
> > >  #include <linux/of_address.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/phy/phy.h>
> > > @@ -41,6 +42,9 @@
> > >  #define SSUSB_SIFSLV_V2_U3PHYD		0x200
> > >  #define SSUSB_SIFSLV_V2_U3PHYA		0x400
> > >  
> > > +#define U3P_MISC_REG1		0x04
> > > +#define MR1_EFUSE_AUTO_LOAD_DIS		BIT(6)
> > > +
> > >  #define U3P_USBPHYACR0		0x000
> > >  #define PA0_RG_U2PLL_FORCE_ON		BIT(15)
> > >  #define PA0_USB20_PLL_PREDIV		GENMASK(7, 6)
> > > @@ -133,6 +137,8 @@
> > >  #define P3C_RG_SWRST_U3_PHYD_FORCE_EN	BIT(24)
> > >  
> > >  #define U3P_U3_PHYA_REG0	0x000
> > > +#define P3A_RG_IEXT_INTR		GENMASK(15, 10)
> > > +#define P3A_RG_IEXT_INTR_VAL(x)		((0x3f & (x)) << 10)
> > >  #define P3A_RG_CLKDRV_OFF		GENMASK(3, 2)
> > >  #define P3A_RG_CLKDRV_OFF_VAL(x)	((0x3 & (x)) << 2)
> > >  
> > > @@ -187,6 +193,19 @@
> > >  #define P3D_RG_FWAKE_TH		GENMASK(21, 16)
> > >  #define P3D_RG_FWAKE_TH_VAL(x)	((0x3f & (x)) << 16)
> > >  
> > > +#define U3P_U3_PHYD_IMPCAL0		0x010
> > > +#define P3D_RG_FORCE_TX_IMPEL		BIT(31)
> > > +#define P3D_RG_TX_IMPEL			GENMASK(28, 24)
> > > +#define P3D_RG_TX_IMPEL_VAL(x)		((0x1f & (x)) << 24)
> > > +
> > > +#define U3P_U3_PHYD_IMPCAL1		0x014
> > > +#define P3D_RG_FORCE_RX_IMPEL		BIT(31)
> > > +#define P3D_RG_RX_IMPEL			GENMASK(28, 24)
> > > +#define P3D_RG_RX_IMPEL_VAL(x)		((0x1f & (x)) << 24)
> > > +
> > > +#define U3P_U3_PHYD_RSV			0x054
> > > +#define P3D_RG_EFUSE_AUTO_LOAD_DIS	BIT(12)
> > > +
> > >  #define U3P_U3_PHYD_CDR1		0x05c
> > >  #define P3D_RG_CDR_BIR_LTD1		GENMASK(28, 24)
> > >  #define P3D_RG_CDR_BIR_LTD1_VAL(x)	((0x1f & (x)) << 24)
> > > @@ -307,6 +326,11 @@ struct mtk_phy_pdata {
> > >  	 * 48M PLL, fix it by switching PLL to 26M from default 48M
> > >  	 */
> > >  	bool sw_pll_48m_to_26m;
> > > +	/*
> > > +	 * Some SoCs (e.g. mt8195) drop a bit when use auto load efuse,
> > > +	 * support sw way, also support it for v2/v3 optionally.
> > > +	 */
> > > +	bool sw_efuse_supported;
> > >  	enum mtk_phy_version version;
> > >  };
> > >  
> > > @@ -336,6 +360,10 @@ struct mtk_phy_instance {
> > >  	struct regmap *type_sw;
> > >  	u32 type_sw_reg;
> > >  	u32 type_sw_index;
> > > +	u32 efuse_sw_en;
> > > +	u32 efuse_intr;
> > > +	u32 efuse_tx_imp;
> > > +	u32 efuse_rx_imp;
> > >  	int eye_src;
> > >  	int eye_vrt;
> > >  	int eye_term;
> > > @@ -1040,6 +1068,130 @@ static int phy_type_set(struct
> > > mtk_phy_instance *instance)
> > >  	return 0;
> > >  }
> > >  
> > > +static int phy_efuse_get(struct mtk_tphy *tphy, struct
> > > mtk_phy_instance *instance)
> > > +{
> > > +	struct device *dev = &instance->phy->dev;
> > > +	int ret = 0;
> > > +
> > > +	/* tphy v1 doesn't support sw efuse, skip it */
> > > +	if (!tphy->pdata->sw_efuse_supported) {
> > > +		instance->efuse_sw_en = 0;
> > > +		return 0;
> > > +	}
> > > +
> > > +	/* software efuse is optional */
> > > +	instance->efuse_sw_en = device_property_read_bool(dev, "nvmem-
> > > cells");
> > > +	if (!instance->efuse_sw_en)
> > > +		return 0;
> > > +
> > > +	switch (instance->type) {
> > > +	case PHY_TYPE_USB2:
> > > +		ret = nvmem_cell_read_variable_le_u32(dev, "intr",
> > > &instance->efuse_intr);
> > > +		if (ret) {
> > > +			dev_err(dev, "fail to get u2 intr efuse, %d\n",
> > > ret);
> > > +			break;
> > > +		}
> > > +
> > > +		/* no efuse, ignore it */
> > > +		if (!instance->efuse_intr) {
> > > +			dev_warn(dev, "no u2 intr efuse, but dts enable
> > > it\n");
> > > +			instance->efuse_sw_en = 0;
> > > +			break;
> > > +		}
> > 
> > What does this check do...? so a zero value is not valid..?
> Yes, because it's also zero for SoC without efuse, prefer to use
> default value instead.
> 
> > 
> > > +
> > > +		dev_info(dev, "u2 efuse - intr %x\n", instance-
> > > >efuse_intr);
> > 
> > dev_dbg()?
> We usually use HW auto load way, print this log can help to point out
> that it's specific SoC.

You can enable this print thru dynamic debug or enable debug prints when
debugging, let us not spam message log

> 
> > 
> > > +		break;
> > 
> > empty line after break improves readability, pls add
> Ok
> > 
> > > +	case PHY_TYPE_USB3:
> > > +	case PHY_TYPE_PCIE:
> > > +		ret = nvmem_cell_read_variable_le_u32(dev, "intr",
> > > &instance->efuse_intr);
> > > +		if (ret) {
> > > +			dev_err(dev, "fail to get u3 intr efuse, %d\n",
> > > ret);
> > > +			break;
> > > +		}
> > 
> > This seems to be common, why not read this before switch?
> It's not used for SGMII or SATA, but not applied until now
> 
> > 
> > > +
> > > +		ret = nvmem_cell_read_variable_le_u32(dev, "rx_imp",
> > > &instance->efuse_rx_imp);
> > > +		if (ret) {
> > > +			dev_err(dev, "fail to get u3 rx_imp efuse,
> > > %d\n", ret);
> > > +			break;
> > > +		}
> > > +
> > > +		ret = nvmem_cell_read_variable_le_u32(dev, "tx_imp",
> > > &instance->efuse_tx_imp);
> > > +		if (ret) {
> > > +			dev_err(dev, "fail to get u3 tx_imp efuse,
> > > %d\n", ret);
> > > +			break;
> > > +		}
> > > +
> > > +		/* no efuse, ignore it */
> > > +		if (!instance->efuse_intr &&
> > > +		    !instance->efuse_rx_imp &&
> > > +		    !instance->efuse_rx_imp) {
> > > +			dev_warn(dev, "no u3 intr efuse, but dts enable
> > > it\n");
> > > +			instance->efuse_sw_en = 0;
> > > +			break;
> > > +		}
> > 
> > again, zero values are not valid?
> It's also zero for SoC without efuse, treat it as invalid value
> 
> > 
> > > +
> > > +		dev_info(dev, "u3 efuse - intr %x, rx_imp %x, tx_imp
> > > %x\n",
> > > +			 instance->efuse_intr, instance->efuse_rx_imp,
> > > +			 instance->efuse_tx_imp);
> > 
> > dbg pls
> Ok
> > 
> > > +		break;
> > > +	default:
> > > +		dev_err(dev, "no sw efuse for type %d\n", instance-
> > > >type);
> > > +		ret = -EINVAL;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void phy_efuse_set(struct mtk_phy_instance *instance)
> > > +{
> > > +	struct device *dev = &instance->phy->dev;
> > > +	struct u2phy_banks *u2_banks = &instance->u2_banks;
> > > +	struct u3phy_banks *u3_banks = &instance->u3_banks;
> > > +	u32 tmp;
> > > +
> > > +	if (!instance->efuse_sw_en)
> > > +		return;
> > > +
> > > +	switch (instance->type) {
> > > +	case PHY_TYPE_USB2:
> > > +		tmp = readl(u2_banks->misc + U3P_MISC_REG1);
> > > +		tmp |= MR1_EFUSE_AUTO_LOAD_DIS;
> > > +		writel(tmp, u2_banks->misc + U3P_MISC_REG1);
> > > +
> > > +		tmp = readl(u2_banks->com + U3P_USBPHYACR1);
> > > +		tmp &= ~PA1_RG_INTR_CAL;
> > > +		tmp |= PA1_RG_INTR_CAL_VAL(instance->efuse_intr);
> > > +		writel(tmp, u2_banks->com + U3P_USBPHYACR1);
> > > +		break;
> > > +	case PHY_TYPE_USB3:
> > > +	case PHY_TYPE_PCIE:
> > > +		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RSV);
> > > +		tmp |= P3D_RG_EFUSE_AUTO_LOAD_DIS;
> > > +		writel(tmp, u3_banks->phyd + U3P_U3_PHYD_RSV);
> > 
> > add a updatel() macro and use this here and other places?
> You mean add macro to set/clear bits?
> If so, I need prepare another patch for this purpose

Sure, that would be nice

-- 
~Vinod
