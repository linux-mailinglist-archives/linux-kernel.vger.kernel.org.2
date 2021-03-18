Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA29E33FFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhCRGqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:46:32 -0400
Received: from mail-bn8nam08on2080.outbound.protection.outlook.com ([40.107.100.80]:1697
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229586AbhCRGqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhInEj5SEnOXPJg1Uq/SOhJgNhSDqd2kxSqpO97hMJnw88FaEti4sh037phXaT88trip8Q/lzXfNh52dVCaJ0YqnNCrr8vkcPsX4pYJKn7GsQbSj35+gNB4jNtNqP7yVibmWo9Z1HFgTp/3dbxycNzN8ALhrJRZ/9TV1R8Tsyb0p2repi3X52MF4ErNPcrvn561OI+Vyk0wwySwgFuVzF1w6bCjFaYTXJftvBZEsPKYskMChF3DVIBJpuyCnfLfjqdMzavPScfLU3wOE4JP/BInBzIGXiIS9LWnb0DrSzChevLOIaJB8vSc/SWA2gaVnjNl60Y114H4BGxyjMKtccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsqW0JGsLJU3okf2PJtuxgNZhXkHsGjQWFX9alFt6Lg=;
 b=dcyX1NJMVq79cknGedSqHLDteylmF9mFI9NWHlFILq4nfvSkhyCbU/MlrSSkcZMY4yjsKLJCLRliRLg7lTze6NcChgKN7e0mIkrLHBnXwydpPsqRVS74HrvE++Q3HavyACbx0MZD6lJuyyE2vJGBUm7GiLP/CTKdCmGcTXja7WTSkdneU5WRJSdsa/ku/qzIDLzPEi6UgrQ6VWWpYBfEx1ZGQgvp7U5+oADoFlkmM4VgnNf+8LxM/lkbqjYhHtSO+ZHxN7Ag2248C6TvP1orU9fNeMfQ31h2zNkdaUpaM1MV974cm7erUKIB5PWPnIqTUS+oMKyBuTCIu0Ux0o5Stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsqW0JGsLJU3okf2PJtuxgNZhXkHsGjQWFX9alFt6Lg=;
 b=X4eycP+nhlx8aUotdaDnF3Y5Biwu/59c3cepBAmJbu4g2s5liMbOeBUPdvQQJsab4UYhTlrSFYiu0lBrTsFmXaGpi5SZWQFYY3tleLjCPKNlN+760rjK69kgumPICSnwAydOPImquhwI9db2NbT10sz/o2yNKbJ/a+6RnfpUqk8=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB4277.namprd02.prod.outlook.com (2603:10b6:a03:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 06:46:21 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c4f1:e969:f8d2:20b4]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c4f1:e969:f8d2:20b4%3]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 06:46:11 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v2] phy: zynqmp: Handle the clock enable/disable properly
Thread-Topic: [PATCH v2] phy: zynqmp: Handle the clock enable/disable properly
Thread-Index: AQHXFNXb37xOX0K7zEeEA5AD8pvy5qqJWuzQ
Date:   Thu, 18 Mar 2021 06:46:11 +0000
Message-ID: <BYAPR02MB58961A37E62AF1ECC62E6A47C1699@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1615288664-45034-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1615288664-45034-1-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 246d41a6-9f54-4c8b-db5d-08d8e9d98497
x-ms-traffictypediagnostic: BYAPR02MB4277:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4277226A034C07B28933B84FC1699@BYAPR02MB4277.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jSKoeM4cE85I3d7F7lVZTWdryYVQrmO4MPfdoY9J5+5Q5kvm0AYVZ3oby+XHtlqqGq9czdKyaom/R3BD2JJ2JVJ2kNwlzZb1m0uQAGDJeqoUnV0/Q39W7y9AmhYO3JmB9fqwTrn1pM2Wq3QSqi4aTIJBH2x1TTqGUyUk+bSInlc5gzp+eRoQbfbD92A+vBFIWD81WVLRzU/zJVhmKfFdzz33dtbQwT6VDCIk/ckmbVYNqIumQXXWVzfe7NYZDWto+3MP23vEwAB1l9UYFZYqUakDQ1PD9LqGyBa2O9AyqCf1JDasyuu5aS/p+iOy+CAAM3CntfJCWtk6yWKMaHA2ffVekyYcDW/1u1he/V4S8opTvEuDzpfPNc2GD1pz1u0j0G00wRvpGwBbPLTlaTGLiTLi5hsopk1a9e8Lwc3qIByB094REcx/oyiiQGJizpntjUu45heN9/8x2nBdT7Qxm4pKHL8ZHoVSq9QCXIq7wDWLJ8ojysK+GlT6MfyIzOz0k2X3yzLH2+UUXE+6C5NXseFMUsy/gq3z9yd3OR1JZLT2VJp3F9hU0sO7NKyjaN86vgZA7fEsEhocti4T0LSGJhxOTJ6vGd7DWhl6jkEcbP4GDp3MOafN+7T1ZW6MvTf2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(110136005)(4326008)(54906003)(38100700001)(33656002)(26005)(186003)(52536014)(44832011)(5660300002)(2906002)(6636002)(53546011)(6506007)(9686003)(107886003)(76116006)(83380400001)(66446008)(66476007)(66556008)(64756008)(7696005)(66946007)(55016002)(71200400001)(8676002)(8936002)(478600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JranMBFRabTRp1WlwdiUUSw2pO2mOWstSkOTsogoVK48cfVUv5XkTHLeo5M8?=
 =?us-ascii?Q?Elzu6x/DfAx+pBJzJGZeB4E+YeW7d6wRrtaYIJsWQ+t7g4fyUl0i1GkMX+N9?=
 =?us-ascii?Q?7obR1TM0xstbFXm+9brJNsMQ8Ef1u3oX8ahn9ANmz4+hwr4rmLU6eddcaq12?=
 =?us-ascii?Q?vlStnh1JbCHc+k5FQixEWucfeq4Yrv8fNATswdBLN2Hoj8OuJTQz7pzcytwg?=
 =?us-ascii?Q?Ws2RPfj3jDdaVoQ4CzEucrZnxK46mz8h87ztRo4gCUQ92+nMDhVq6RIvhDgC?=
 =?us-ascii?Q?wZ8Y6OvImxhQ7cxrTajSdKCRu2A30droPW5VNesbRw+jzSxi2ynwWbOqhTdi?=
 =?us-ascii?Q?NccPQ6BMBKtb9W4VALcl69zNQyVqn2RhTFQo6oxhMPe7726cvONFNbA9Nzm6?=
 =?us-ascii?Q?lu/khikjMMs0EX67YmADijtelZVTHmMDrx3abQwJyEyCi2O1WaMlCjH6gUdT?=
 =?us-ascii?Q?7cbDoJEppy/sv0u+An/rCbneuZ9PNsFEhC3629c+cj6wvAArcQRj18GGu/fL?=
 =?us-ascii?Q?zRVy8Fugfw1cM9kzvmlbFEW+qAmSukc97ds3wYmrtnvr1VXhX6NIGXqQU36+?=
 =?us-ascii?Q?Z/djqhoDj966FIp9ogZZtdKtS0o8OMF95kNEAsq/56WgwNDZG3hjPjnCdzra?=
 =?us-ascii?Q?Kc8WAblB/Xjc/SwcwAGmk7JFG2RipdqX6VGp7F/SiZrn5AT2gFSHPrg+SIxx?=
 =?us-ascii?Q?aFsHZ7lmu9c5T4Jvx0LR0YOSzVAJdzoTGASYrLTkj46XvsAb2YupKbbmE3bF?=
 =?us-ascii?Q?czKqMv1bezk7eV1EfVnoesctaXALQWf+oY5j2j0OkRj30vgd2612PxvUf5uB?=
 =?us-ascii?Q?jnUWGm11AMf2I01zy16LiZickAY2pgNgdFBQHJOpSF/U6N+w/OWfqY+cy4iV?=
 =?us-ascii?Q?Vf3V0pTWDjvsgzB7T087PworCGWr29v17t0R7nBRoXTsMlH2NIcFDl9qijMD?=
 =?us-ascii?Q?g+8ID5fgSxw5eA546gkI4/U/0MnS7Rk/gwSdWXedze8rrGwQiBj0ol/7cTTv?=
 =?us-ascii?Q?0NabRVyxS/2S8RqGq3nB6jHSUveyM15HOsIcshnd98TDKAfQkHgjWF1whYTZ?=
 =?us-ascii?Q?0SwUMRigzU70fFJsnJjsKfDcUNopP5QLYRNnN15dg8cFCGseyni75cm2Iylo?=
 =?us-ascii?Q?ozpCTJxI2J+f5S4LJQA8BAK28fijYKm8QuHS+hZTNkZKE6PBvfg06JOkfxG3?=
 =?us-ascii?Q?moLBzZJKCB8OmuNi6YhvuSay/j5lbaWL+MeW2F+EkNHOOyICSna6c6G782Y7?=
 =?us-ascii?Q?n7RxSUlSHNR8iZXY+sGszPfNQZXuB9jW/Oyx1hdA99ysAT3f5RF2bVg6eaWT?=
 =?us-ascii?Q?T99SVyirkQ+e0yUGb668S8hi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246d41a6-9f54-4c8b-db5d-08d8e9d98497
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 06:46:11.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bs4Sc6fEvJRd2GtzbzKa/BWdZUtYs89HLWgeLuWWHaKfk6C+Hc2uCZuwXXCdfHqbpVl3d3col9mGmZCGcWmjQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4277
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping!

> -----Original Message-----
> From: Manish Narani <manish.narani@xilinx.com>
> Sent: Tuesday, March 9, 2021 4:48 PM
> To: laurent.pinchart@ideasonboard.com; kishon@ti.com; vkoul@kernel.org;
> Michal Simek <michals@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; g=
it
> <git@xilinx.com>; Manish Narani <MNARANI@xilinx.com>
> Subject: [PATCH v2] phy: zynqmp: Handle the clock enable/disable properly
>=20
> The current driver is not handling the clock enable/disable operations
> properly. The clocks need to be handled correctly by enabling or
> disabling at appropriate places. This patch adds code to handle the
> same.
>=20
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 57
> ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-
> zynqmp.c
> index 2b65f84..37fcecf 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -219,6 +219,7 @@ struct xpsgtr_dev {
>  	struct mutex gtr_mutex; /* mutex for locking */
>  	struct xpsgtr_phy phys[NUM_LANES];
>  	const struct xpsgtr_ssc *refclk_sscs[NUM_LANES];
> +	struct clk *clk[NUM_LANES];
>  	bool tx_term_fix;
>  	unsigned int saved_icm_cfg0;
>  	unsigned int saved_icm_cfg1;
> @@ -818,11 +819,15 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>  static int __maybe_unused xpsgtr_suspend(struct device *dev)
>  {
>  	struct xpsgtr_dev *gtr_dev =3D dev_get_drvdata(dev);
> +	unsigned int i;
>=20
>  	/* Save the snapshot ICM_CFG registers. */
>  	gtr_dev->saved_icm_cfg0 =3D xpsgtr_read(gtr_dev, ICM_CFG0);
>  	gtr_dev->saved_icm_cfg1 =3D xpsgtr_read(gtr_dev, ICM_CFG1);
>=20
> +	for (i =3D 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> +		clk_disable_unprepare(gtr_dev->clk[i]);
> +
>  	return 0;
>  }
>=20
> @@ -832,6 +837,13 @@ static int __maybe_unused xpsgtr_resume(struct
> device *dev)
>  	unsigned int icm_cfg0, icm_cfg1;
>  	unsigned int i;
>  	bool skip_phy_init;
> +	int err;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(gtr_dev->clk); i++) {
> +		err =3D clk_prepare_enable(gtr_dev->clk[i]);
> +		if (err)
> +			goto err_clk_put;
> +	}
>=20
>  	icm_cfg0 =3D xpsgtr_read(gtr_dev, ICM_CFG0);
>  	icm_cfg1 =3D xpsgtr_read(gtr_dev, ICM_CFG1);
> @@ -852,6 +864,12 @@ static int __maybe_unused xpsgtr_resume(struct
> device *dev)
>  		gtr_dev->phys[i].skip_phy_init =3D skip_phy_init;
>=20
>  	return 0;
> +
> +err_clk_put:
> +	for (i =3D 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> +		clk_disable_unprepare(gtr_dev->clk[i]);
> +
> +	return err;
>  }
>=20
>  static const struct dev_pm_ops xpsgtr_pm_ops =3D {
> @@ -865,6 +883,7 @@ static const struct dev_pm_ops xpsgtr_pm_ops =3D {
>  static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  {
>  	unsigned int refclk;
> +	int ret;
>=20
>  	for (refclk =3D 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk)=
 {
>  		unsigned long rate;
> @@ -874,14 +893,22 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev
> *gtr_dev)
>=20
>  		snprintf(name, sizeof(name), "ref%u", refclk);
>  		clk =3D devm_clk_get_optional(gtr_dev->dev, name);
> -		if (IS_ERR(clk))
> -			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> -					     "Failed to get reference clock
> %u\n",
> -					     refclk);
> +		if (IS_ERR(clk)) {
> +			ret =3D dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> +					    "Failed to get reference clock
> %u\n",
> +					    refclk);
> +			goto err_clk_put;
> +		}
>=20
>  		if (!clk)
>  			continue;
>=20
> +		gtr_dev->clk[refclk] =3D clk;
> +
> +		ret =3D clk_prepare_enable(gtr_dev->clk[refclk]);
> +		if (ret)
> +			goto err_clk_put;
> +
>  		/*
>  		 * Get the spread spectrum (SSC) settings for the reference
>  		 * clock rate.
> @@ -899,11 +926,18 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev
> *gtr_dev)
>  			dev_err(gtr_dev->dev,
>  				"Invalid rate %lu for reference clock %u\n",
>  				rate, refclk);
> -			return -EINVAL;
> +			ret =3D -EINVAL;
> +			goto err_clk_put;
>  		}
>  	}
>=20
>  	return 0;
> +
> +err_clk_put:
> +	for (refclk =3D 0; refclk < ARRAY_SIZE(gtr_dev->clk); refclk++)
> +		clk_disable_unprepare(gtr_dev->clk[refclk]);
> +
> +	return ret;
>  }
>=20
>  static int xpsgtr_probe(struct platform_device *pdev)
> @@ -912,6 +946,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  	struct xpsgtr_dev *gtr_dev;
>  	struct phy_provider *provider;
>  	unsigned int port;
> +	unsigned int i;
>  	int ret;
>=20
>  	gtr_dev =3D devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
> @@ -951,7 +986,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  		phy =3D devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
>  		if (IS_ERR(phy)) {
>  			dev_err(&pdev->dev, "failed to create PHY\n");
> -			return PTR_ERR(phy);
> +			ret =3D PTR_ERR(phy);
> +			goto err_clk_put;
>  		}
>=20
>  		gtr_phy->phy =3D phy;
> @@ -962,9 +998,16 @@ static int xpsgtr_probe(struct platform_device
> *pdev)
>  	provider =3D devm_of_phy_provider_register(&pdev->dev,
> xpsgtr_xlate);
>  	if (IS_ERR(provider)) {
>  		dev_err(&pdev->dev, "registering provider failed\n");
> -		return PTR_ERR(provider);
> +		ret =3D PTR_ERR(provider);
> +		goto err_clk_put;
>  	}
>  	return 0;
> +
> +err_clk_put:
> +	for (i =3D 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> +		clk_disable_unprepare(gtr_dev->clk[i]);
> +
> +	return ret;
>  }
>=20
>  static const struct of_device_id xpsgtr_of_match[] =3D {
> --
> 2.1.1

