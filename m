Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251133339E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhCJKZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:25:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52310 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhCJKYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:24:45 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AAOVmB127513;
        Wed, 10 Mar 2021 04:24:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615371871;
        bh=i09rXQy/RppMIEWjXFpnoKgIX92U98VUciWg+IgQCcY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Dow2EYJaRA2Rl8750jd7BObGVy3xIjKkJ6szsmnmPRlHSXguG6kjUkduGa+Vks4jm
         Mw66qzJjIs/L76LJhnZhKsaZPy4397ICBMeyf2ZUKpHAteyKVqOQIZkYtxRFT/O+WJ
         582jgrIkOJtV2Oi3Y3a5fW51Udfd8L7gehMDANG4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AAOV07013901
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 04:24:31 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 04:24:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 04:24:30 -0600
Received: from [10.250.234.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AAOR52115402;
        Wed, 10 Mar 2021 04:24:28 -0600
Subject: Re: [PATCH v2 9/9] phy: cadence-torrent: Add support to drive refclk
 out
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
References: <20210222112314.10772-1-kishon@ti.com>
 <20210222112314.10772-10-kishon@ti.com>
 <MN2PR07MB616036AE3164A0BB929BE0D8C5929@MN2PR07MB6160.namprd07.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a04dcf6a-1152-8ef4-7ea4-00e67172c4b2@ti.com>
Date:   Wed, 10 Mar 2021 15:54:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MN2PR07MB616036AE3164A0BB929BE0D8C5929@MN2PR07MB6160.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 09/03/21 7:51 pm, Swapnil Kashinath Jakhade wrote:
> Hi Kishon,
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>> Sent: Monday, February 22, 2021 4:53 PM
>> To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul
>> <vkoul@kernel.org>; Rob Herring <robh+dt@kernel.org>; Peter Rosin
>> <peda@axentia.se>; Swapnil Kashinath Jakhade <sjakhade@cadence.com>
>> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> phy@lists.infradead.org
>> Subject: [PATCH v2 9/9] phy: cadence-torrent: Add support to drive refclk out
>>
>> EXTERNAL MAIL
>>
>>
>> cmn_refclk_<p/m> lines in Torrent SERDES is used for connecting external
>> reference clock. cmn_refclk_<p/m> can also be configured to output the
>> reference clock. Model this derived reference clock as a "clock" so that
>> platforms like AM642 EVM can enable it.
>>
>> This is used by PCIe to use the same refclk both in local SERDES
>> and remote device. Add support here to drive refclk out.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/phy/cadence/phy-cadence-torrent.c | 202 +++++++++++++++++++++-
>>  1 file changed, 199 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
>> b/drivers/phy/cadence/phy-cadence-torrent.c
>> index f310e15d94cb..07eebdd90d4b 100644
>> --- a/drivers/phy/cadence/phy-cadence-torrent.c
>> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
>> @@ -7,7 +7,9 @@
>>   */
>>
>>  #include <dt-bindings/phy/phy.h>
>> +#include <dt-bindings/phy/phy-cadence-torrent.h>
>>  #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>>  #include <linux/delay.h>
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>> @@ -76,6 +78,8 @@
>>   * register offsets from SD0801 PHY register block base (i.e MHDP
>>   * register base + 0x500000)
>>   */
>> +#define CMN_CDIAG_REFCLK_OVRD		0x004CU
>> +#define CMN_CDIAG_REFCLK_DRV0_CTRL	0x0050U
> 
> Nitpick, this can be added sequentially.
> 
>>  #define CMN_SSM_BANDGAP_TMR		0x0021U
>>  #define CMN_SSM_BIAS_TMR		0x0022U
>>  #define CMN_PLLSM0_PLLPRE_TMR		0x002AU
>> @@ -206,6 +210,8 @@
>>  #define RX_DIAG_ACYA			0x01FFU
>>
>>  /* PHY PCS common registers */
>> +#define PHY_PIPE_CMN_CTRL1		0x0000U
>> +#define PHY_ISO_CMN_CTRL		0x0008U
>>  #define PHY_PLL_CFG			0x000EU
>>  #define PHY_PIPE_USB3_GEN2_PRE_CFG0	0x0020U
>>  #define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
>> @@ -216,6 +222,10 @@
>>  #define PHY_PMA_CMN_CTRL2		0x0001U
>>  #define PHY_PMA_PLL_RAW_CTRL		0x0003U
>>
>> +static const char * const clk_names[] = {
>> +	[CDNS_TORRENT_REFCLK_DRIVER] = "refclk-driver",
>> +};
>> +
>>  static const struct reg_field phy_pll_cfg =
>>  				REG_FIELD(PHY_PLL_CFG, 0, 1);
>>
>> @@ -231,6 +241,36 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
>>  static const struct reg_field phy_reset_ctrl =
>>  				REG_FIELD(PHY_RESET, 8, 8);
>>
>> +#define REFCLK_OUT_NUM_CONFIGURATIONS_PCS_CONFIG	2
> 
> This could be reduced just to REFCLK_OUT_NUM_PCS_CONFIG, but up to you.
> Same below.
> 
>> +
>> +enum cdns_torrent_refclk_out_pcs {
>> +	PHY_ISO_CMN_CTRL_8,
>> +	PHY_PIPE_CMN_CTRL1_0,
>> +};
>> +
>> +#define REFCLK_OUT_NUM_CONFIGURATIONS_CMN_CONFIG	5
>> +
>> +enum cdns_torrent_refclk_out_cmn {
>> +	CMN_CDIAG_REFCLK_OVRD_4,
>> +	CMN_CDIAG_REFCLK_DRV0_CTRL_1,
>> +	CMN_CDIAG_REFCLK_DRV0_CTRL_4,
>> +	CMN_CDIAG_REFCLK_DRV0_CTRL_5,
>> +	CMN_CDIAG_REFCLK_DRV0_CTRL_6,
>> +};
>> +
>> +static const struct reg_field refclk_out_pcs_cfg[] = {
>> +	[PHY_ISO_CMN_CTRL_8]	= REG_FIELD(PHY_ISO_CMN_CTRL, 8,
>> 8),
>> +	[PHY_PIPE_CMN_CTRL1_0]	= REG_FIELD(PHY_PIPE_CMN_CTRL1,
>> 0, 0),
>> +};
>> +
>> +static const struct reg_field refclk_out_cmn_cfg[] = {
>> +	[CMN_CDIAG_REFCLK_OVRD_4]	=
>> REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4),
>> +	[CMN_CDIAG_REFCLK_DRV0_CTRL_1]	=
>> REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 1, 1),
>> +	[CMN_CDIAG_REFCLK_DRV0_CTRL_4]	=
>> REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 4, 4),
>> +	[CMN_CDIAG_REFCLK_DRV0_CTRL_5]  =
>> REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 5, 5),
>> +	[CMN_CDIAG_REFCLK_DRV0_CTRL_6]	=
>> REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 6, 6),
>> +};
>> +
>>  enum cdns_torrent_phy_type {
>>  	TYPE_NONE,
>>  	TYPE_DP,
>> @@ -279,6 +319,8 @@ struct cdns_torrent_phy {
>>  	struct regmap_field *phy_pma_cmn_ctrl_2;
>>  	struct regmap_field *phy_pma_pll_raw_ctrl;
>>  	struct regmap_field *phy_reset_ctrl;
>> +	struct clk *clks[CDNS_TORRENT_REFCLK_DRIVER + 1];
>> +	struct clk_onecell_data clk_data;
>>  };
>>
>>  enum phy_powerstate {
>> @@ -288,6 +330,16 @@ enum phy_powerstate {
>>  	POWERSTATE_A3 = 3,
>>  };
>>
>> +struct cdns_torrent_derived_refclk {
>> +	struct clk_hw		hw;
>> +	struct regmap_field
>> 	*pcs_fields[REFCLK_OUT_NUM_CONFIGURATIONS_PCS_CONFIG];
>> +	struct regmap_field
>> 	*cmn_fields[REFCLK_OUT_NUM_CONFIGURATIONS_CMN_CONFIG];
>> +	struct clk_init_data	clk_data;
>> +};
>> +
>> +#define to_cdns_torrent_derived_refclk(_hw)	\
>> +			container_of(_hw, struct
>> cdns_torrent_derived_refclk, hw)
>> +
>>  static int cdns_torrent_phy_init(struct phy *phy);
>>  static int cdns_torrent_dp_init(struct phy *phy);
>>  static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
>> @@ -1604,6 +1656,111 @@ static int cdns_torrent_dp_run(struct
>> cdns_torrent_phy *cdns_phy, u32 num_lanes)
>>  	return ret;
>>  }
>>
>> +static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
>> +{
>> +	struct cdns_torrent_derived_refclk *derived_refclk =
>> to_cdns_torrent_derived_refclk(hw);
>> +
>> +	regmap_field_write(derived_refclk-
>>> cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_6], 0);
>> +	regmap_field_write(derived_refclk-
>>> cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
>> +	regmap_field_write(derived_refclk-
>>> cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_5], 1);
>> +	regmap_field_write(derived_refclk-
>>> cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 0);
>> +	regmap_field_write(derived_refclk-
>>> cmn_fields[CMN_CDIAG_REFCLK_OVRD_4], 1);
>> +	regmap_field_write(derived_refclk-
>>> pcs_fields[PHY_PIPE_CMN_CTRL1_0], 1);
>> +	regmap_field_write(derived_refclk-
>>> pcs_fields[PHY_ISO_CMN_CTRL_8], 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static void cdns_torrent_derived_refclk_disable(struct clk_hw *hw)
>> +{
>> +	struct cdns_torrent_derived_refclk *derived_refclk =
>> to_cdns_torrent_derived_refclk(hw);
>> +
>> +	regmap_field_write(derived_refclk-
>>> pcs_fields[PHY_ISO_CMN_CTRL_8], 0);
>> +}
>> +
> 
> PHY_ISO_CMN_CTRL is a PHY isolation register. Not sure, but is this correct
> to control phy_en_refclk to enable/disable refclk output from here?

hmm.. I see this is used to drive phy_en_refclk when in ISOLATION mode.
Given that we are not selecting to operate in isolation mode, this
shouldn't be required.

This was present in the sequence given by HW team but maybe it's enabled
for some debugging.

I've also verified PCIe works without this configuration. I'll repost
without this configuration and also check with HW team on why it was added.

Thanks
Kishon
