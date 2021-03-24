Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D1347870
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhCXMYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:24:50 -0400
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:56320
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231794AbhCXMYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:24:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iin7FGj738+Cn66ImlylyYfl378C49g1LU1rLLR0Q1ZAmBEA9k++4Q2SPGMdX0f5ZHibIDtqldCwG2rct5COW6qkiEzzRlcdXQUDx/vyZ7TQiUqeBeBxTemGYVyewQhjDe93RUdzi2B9WglCqJL2X25SKnQ82+Ors7+tbPbum8aMjF6AgETe2zMFlRMVSNZ6KguC+1zPEh30pDAHK1wtHi1itAJX0HcB5YHb8PefnJmppT7vVbYX4rEt8lAY++fN75BZKNuk8jPC7fxzMhvvOpH/yzMA484l/9yOqfrIgnszk3ZC+lvvI9+HHODrE69fSIx8FyVm+sCqIm0sbFzzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u0SSamO07H5mtR7QxslR5zBIv48GlNPPXdE0/WzdRQ=;
 b=VOalKwWQRLprTpjvDuC6897yoyPXNWTyh1+gEJH28IoZvdrE6P+DSK5elZkPKGJSF2WV044IW0u519gbnxJY7lrCR9opoXhkeFtWbDIPAPvUrXm8U0oR+nKs3v+oF7MBazQPGzMpC+024Go814W25Ru00JObtLXbRQEpAOuWYf/oX2o0ld1j4fjcU8LOnxd92p9Hr0eIBEU6pPc7qcQvWJ0YzlUwyz78cH0s4wMjofkeJJ1eYkpUW1pgV53VhIashEPkdM5j+nzleLB4DYqbDTWS9PYDoupqIp4gY8Vrbk7/UP+RRNxB1ORj6a/He03hZa9vi+MV0JteccbUiJTODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u0SSamO07H5mtR7QxslR5zBIv48GlNPPXdE0/WzdRQ=;
 b=gHN0kPkn6nBTsSFwCEB0Ds4BwJL6yR+VKe9xA/QfJdJnh0Q2JXVEuXWO+0r9x/ZD5j/jKj7mBwH4ppBe9EXzYYezTBYwf/lW7nAVek+g6wEpA+Hr7RY/gBARm2tAfFzfMKcb+AHX/RlbE3y62mlg+KdyKt4PgkArLY2CLS2r5GI=
Received: from BLAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:32b::14)
 by SJ0PR02MB7712.namprd02.prod.outlook.com (2603:10b6:a03:32c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 12:24:38 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32b:cafe::4d) by BLAPR03CA0009.outlook.office365.com
 (2603:10b6:208:32b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend
 Transport; Wed, 24 Mar 2021 12:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 12:24:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 05:24:36 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Wed, 24 Mar 2021 05:24:36 -0700
Envelope-to: git@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 vkoul@kernel.org,
 kishon@ti.com,
 laurent.pinchart@ideasonboard.com
Received: from [172.30.17.109] (port=58302)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lP2Yt-0000wQ-2c; Wed, 24 Mar 2021 05:24:35 -0700
Subject: Re: [PATCH v4] phy: zynqmp: Handle the clock enable/disable properly
To:     Manish Narani <manish.narani@xilinx.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
References: <1616588325-95602-1-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <828d11f9-ab72-2438-06fe-4f56fa1a56ed@xilinx.com>
Date:   Wed, 24 Mar 2021 13:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616588325-95602-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07078d71-1046-46c4-d5bf-08d8eebfca79
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7712:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7712A7AE5B6CB94725A77B50C6639@SJ0PR02MB7712.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/CM/dhtq88cydKk8ZSXD/uSS/5O5vRfMphfr/mJ0+O0JZlytfuQllLGBT+J1vb8/xqds57q98mAqBvzho5Zxy3Kmoyo4qww//v68nK4l867FwkKZIZAZQEOdqpcRDPXYo6PkuNbnJY2DHA94QCc094NAtVQKZIYz8P1X9MB/593qOt+TkPh3hcdqoBBs9g1VIXhDp2EACt8XiToLCo3WFlHyzII4IHQE+LgicYfbtT4k67biFzF3uw6uOcKiqbx48QWIbjpIpo7byFouRvJxp6eY6qyNmtwA3eL5Qo7+pCisJKJi89cl8Eb4mAgUidD8Yppynmi5G7T44hKf3NesSIt4KFgs4SAj1W2yVr2+LRAJZOvHzd746vM33qOEOheRfp1hVFYLWvtuPnLitgLClat38a1KXiMzKakDWYcf9KMQCk1quYe104hr62phLqv4c1hqjWIUgVDDY9nswIqSj55U+qSG04ypk7E/jKzyXSVnAq25vVvjjtAzBklonAKUs8eBkoUphINP5XykJcib8LMonF5tiwdvaGA19VvPy+2c73/5bcmBIZpEY/qS06wekzpx3VlUlDPwk3+34+LaHLfkQqKGsyIBQDzbL5qYN8C4ES0G9BQqrOoHkfI+7CyyNYjYfb8gMjiIZoltCGG8sTIEJgNMiLnZetd/BxcIhUay5zURhNthdzpMOtb+xiZmJUx2a2PyoM3rXVbFynW+g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(47076005)(8676002)(336012)(186003)(26005)(7636003)(36756003)(31686004)(53546011)(426003)(82740400003)(44832011)(356005)(9786002)(316002)(110136005)(54906003)(70586007)(31696002)(5660300002)(70206006)(36860700001)(2906002)(83380400001)(2616005)(8936002)(36906005)(82310400003)(6666004)(4326008)(478600001)(107886003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 12:24:37.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07078d71-1046-46c4-d5bf-08d8eebfca79
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7712
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/21 1:18 PM, Manish Narani wrote:
> The current driver is not handling the clock enable/disable operations
> properly. The clocks need to be handled correctly by enabling or
> disabling at appropriate places. This patch adds code to handle the
> same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 58 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 2b65f84..3565215 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -208,6 +208,7 @@ struct xpsgtr_phy {
>   * @gtr_mutex: mutex for locking
>   * @phys: PHY lanes
>   * @refclk_sscs: spread spectrum settings for the reference clocks
> + * @clk: reference clocks
>   * @tx_term_fix: fix for GT issue
>   * @saved_icm_cfg0: stored value of ICM CFG0 register
>   * @saved_icm_cfg1: stored value of ICM CFG1 register
> @@ -219,6 +220,7 @@ struct xpsgtr_dev {
>  	struct mutex gtr_mutex; /* mutex for locking */
>  	struct xpsgtr_phy phys[NUM_LANES];
>  	const struct xpsgtr_ssc *refclk_sscs[NUM_LANES];
> +	struct clk *clk[NUM_LANES];
>  	bool tx_term_fix;
>  	unsigned int saved_icm_cfg0;
>  	unsigned int saved_icm_cfg1;
> @@ -818,11 +820,15 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>  static int __maybe_unused xpsgtr_suspend(struct device *dev)
>  {
>  	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
> +	unsigned int i;
>  
>  	/* Save the snapshot ICM_CFG registers. */
>  	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
>  
> +	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> +		clk_disable_unprepare(gtr_dev->clk[i]);
> +
>  	return 0;
>  }
>  
> @@ -832,6 +838,13 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
>  	unsigned int icm_cfg0, icm_cfg1;
>  	unsigned int i;
>  	bool skip_phy_init;
> +	int err;
> +
> +	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++) {
> +		err = clk_prepare_enable(gtr_dev->clk[i]);
> +		if (err)
> +			goto err_clk_put;
> +	}
>  
>  	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
> @@ -852,6 +865,12 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
>  		gtr_dev->phys[i].skip_phy_init = skip_phy_init;
>  
>  	return 0;
> +
> +err_clk_put:
> +	while (i--)
> +		clk_disable_unprepare(gtr_dev->clk[i]);
> +
> +	return err;
>  }
>  
>  static const struct dev_pm_ops xpsgtr_pm_ops = {
> @@ -865,6 +884,7 @@ static const struct dev_pm_ops xpsgtr_pm_ops = {
>  static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  {
>  	unsigned int refclk;
> +	int ret;
>  
>  	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
>  		unsigned long rate;
> @@ -874,14 +894,22 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  
>  		snprintf(name, sizeof(name), "ref%u", refclk);
>  		clk = devm_clk_get_optional(gtr_dev->dev, name);
> -		if (IS_ERR(clk))
> -			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> -					     "Failed to get reference clock %u\n",
> -					     refclk);
> +		if (IS_ERR(clk)) {
> +			ret = dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> +					    "Failed to get reference clock %u\n",
> +					    refclk);
> +			goto err_clk_put;
> +		}
>  
>  		if (!clk)
>  			continue;
>  
> +		ret = clk_prepare_enable(clk);
> +		if (ret)
> +			goto err_clk_put;
> +
> +		gtr_dev->clk[refclk] = clk;
> +
>  		/*
>  		 * Get the spread spectrum (SSC) settings for the reference
>  		 * clock rate.
> @@ -899,11 +927,18 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  			dev_err(gtr_dev->dev,
>  				"Invalid rate %lu for reference clock %u\n",
>  				rate, refclk);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_clk_put;
>  		}
>  	}
>  
>  	return 0;
> +
> +err_clk_put:
> +	while (refclk--)
> +		clk_disable_unprepare(gtr_dev->clk[refclk]);
> +
> +	return ret;
>  }
>  
>  static int xpsgtr_probe(struct platform_device *pdev)
> @@ -912,6 +947,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  	struct xpsgtr_dev *gtr_dev;
>  	struct phy_provider *provider;
>  	unsigned int port;
> +	unsigned int i;
>  	int ret;
>  
>  	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
> @@ -951,7 +987,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
>  		if (IS_ERR(phy)) {
>  			dev_err(&pdev->dev, "failed to create PHY\n");
> -			return PTR_ERR(phy);
> +			ret = PTR_ERR(phy);
> +			goto err_clk_put;
>  		}
>  
>  		gtr_phy->phy = phy;
> @@ -962,9 +999,16 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  	provider = devm_of_phy_provider_register(&pdev->dev, xpsgtr_xlate);
>  	if (IS_ERR(provider)) {
>  		dev_err(&pdev->dev, "registering provider failed\n");
> -		return PTR_ERR(provider);
> +		ret = PTR_ERR(provider);
> +		goto err_clk_put;
>  	}
>  	return 0;
> +
> +err_clk_put:
> +	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> +		clk_disable_unprepare(gtr_dev->clk[i]);
> +
> +	return ret;
>  }
>  
>  static const struct of_device_id xpsgtr_of_match[] = {
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
