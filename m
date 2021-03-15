Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5C33AB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCOFvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:51:07 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:1998 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229987AbhCOFu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:50:59 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F5mT11022550;
        Sun, 14 Mar 2021 22:50:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=vd/8NMGk9mfm+Xde7LNIIshikn3yMBCUk22vhUhNVco=;
 b=EvJ98Rekqp9R00plx9Z1W29PR3cQQYF6c2URMVZgKjKOSqUN58b/p4e/kGlU1jnLiw3p
 xspXyBU4aIM02BbCvef7J3osxy0UhoBJ8kVKDMV7YOFXn6m7yx2fSyltit3EXX9quM1m
 jrDbEIQbCLX9GmTvOr20q+0XLcEINExqQXApOkXp72ENG3762hAkT1VcWfXrFnId/V8X
 DQeiykicMpKbGrLXD51OJKzkd0BV7WXBAZFzI24Dx5ylDl/7k1aEj7f41DAxpALqSzF8
 fCZ2zEKiFllranV2UkGQUmmdIGF8iqH6Xe78B2bwy0d/eWE1obdzVMREgLfEJe+tG+jD fA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 378tu1ve91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 22:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRe08NuD47ttOVQl8YzXUuK57ycmBHUboEOGQsX0JW+WLqGNss7yCHOJMg29xLeNkr1TnvtjThaTMKeoj+jmSutxZM5/eb8LBzT2Wuqm8h5Q+FYEoRzafvjQbvxcPlQ7sAXuOpE4d8mdYLc7qEqEltrIIu3OZHQgKNfLRsk+wjN4K/3uWocIc8FimNimFKs5PXT5cb+Q6zO9PDcTDXVeluPwEpNP+DclhWE/5MY/qT0Oq5wm/5Ndfq6W7Oktd/yvFXypQRgIgdHQ+qULonOsiw2zeitS49rZtKfoAkltvBQEHJnAFr/QywNJOmGuaPmhK6ftOsMWjBW9fKneBWbIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd/8NMGk9mfm+Xde7LNIIshikn3yMBCUk22vhUhNVco=;
 b=hYHECYlDgRYprXpzDT7d+7mkkS4XNFYd54D3foJdTsi94i8Cx7qO5gpohMGe8bpPgPFX9Z32ETDzfve5R7m/nKQCikna5LUAAi3Nqs2fXQwCycgoXKD8J9JL/f7ftRMnpLtWrU7GXIwpxIBTrT3+1DXKdPhw1c+937Y+mAUnqQ8NdMdT4TX/Dp4xC+dclytFk2D8ujorslUeWhnJbIVRIcbN/mBsN3AZzKXBDq4AL9p9fK/8JGXz+A0MYeMh1j0ZxlKk+B66TULPlBG7EmgI0eLn2Ue1hBvJixR9gMIZY6cY0VO2ucJlHD1HK8gk84or8pO6kyqI2JE/htoZ7IkQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd/8NMGk9mfm+Xde7LNIIshikn3yMBCUk22vhUhNVco=;
 b=rcloUWhEvkEB4E+kPn5LaEt853bimq8iVR3HQtle49JvFozehJzvbMO2ZHIgrhCqzubkCoIFYMLTtHQ/bR9wF6T+hAN/M5F6/KlhdpNzvfleDpd33ERKhl4QCDad0XKUXrrM3sLFtSyaNW9lFFSlNEKBTzU1f0dWtGCE+6cOQJ8=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by BLAPR07MB8258.namprd07.prod.outlook.com (2603:10b6:208:323::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 05:50:53 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 05:50:52 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v6 05/13] phy: cadence: cadence-sierra: Move all
 clk_get_*() to a separate function
Thread-Topic: [PATCH v6 05/13] phy: cadence: cadence-sierra: Move all
 clk_get_*() to a separate function
Thread-Index: AQHXFcSHaRA9XWOht0aMzEyF1fUB8KqAB6IA
Date:   Mon, 15 Mar 2021 05:50:52 +0000
Message-ID: <MN2PR07MB61602C0EB3273C0C51995994C56C9@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210310154558.32078-1-kishon@ti.com>
 <20210310154558.32078-6-kishon@ti.com>
In-Reply-To: <20210310154558.32078-6-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02NTEzZTk2NS04NTUyLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcNjUxM2U5NjYtODU1Mi0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIzODQ2IiB0PSIxMzI2MDI2MTA1MDQ4NjY5OTYiIGg9Ill3S3dmN3FRYXVqWHlla3dtUmQ4Y01xbmpSUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22b4adf9-cec4-4e75-6696-08d8e7764b61
x-ms-traffictypediagnostic: BLAPR07MB8258:
x-microsoft-antispam-prvs: <BLAPR07MB8258105F1CF71CE14F9CBAE8C56C9@BLAPR07MB8258.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:294;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2g/B0jlBT2Zn+YALDECjnugyX8OZf9eDTLeGWMap/dhcDhO5x0P5rwTrbgP602j0mhfEWrCtKPEY2VT7J/0R4ls8Cq8hmlDfxjTf5XiHi02paWqVwMr2tXB3Pz0tomlbIyw47gQ1FY5O7jIGeYzaZc4IOMUt4cZhAQLdXEaKhwgcQgMthLRDoSdJPLRjFpdNP4wWO08zR0lOYyBnb+ykixFVEOqZA5Nurs9AGpBMA7oqMbVgsSGgghMwiggMCySFjCOj+gP/Efc2rA/7igvdwUP9BMnkCXKOb5/n+J9jjhUgs7CsJeaWdt3ditiUuYikDFQZ22pZZjP6UPfPQqvrEW3FlmOg1Z2/DTXUX24bDePiE2K5/Hqj7u/S38KeIo0BnqWNUaaYg/e4doJLwskFjbbC8/1ZZHWwn0g5tsr2z4iVY5OKelhzzSP0SfJYr7P3iLAlbrmysLJiXsKq++3SQeLfAvY5NO+k85qmQwQfdnsHG5IrpSJG7PrhNl+zaZ9bvRHmghEYrlL19TwAyn4I7Ozb4WyYhZcCEo1V2SL9aLQ9z0y86bMWpPzW11WjxZEH/31XsqRFPsUwm8axlHJareHLmHs5qQI7FmJOUc03un6w1vVCtH3MrDN4jnob9s8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(36092001)(66946007)(64756008)(66446008)(66556008)(66476007)(26005)(53546011)(33656002)(186003)(52536014)(71200400001)(5660300002)(6506007)(316002)(76116006)(8676002)(7696005)(8936002)(4326008)(478600001)(9686003)(55016002)(86362001)(54906003)(83380400001)(2906002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nhht1pKCCXv2NdDgRGGjovAJHsHUoDCltsaU48WKsPjDaRjt3N5QCwRhENEv?=
 =?us-ascii?Q?kEDIEwBWTXuYs3LkAVTu2dMAhMjX1xUqIQo6MSqm5oq5fIodsXXHBfju6clF?=
 =?us-ascii?Q?Dj17hvQfKvfg4pdZEUEWhhvDgGGl3tDMftqHd4JoG2RGTE83qzI2b0M2iDww?=
 =?us-ascii?Q?PkuT0SRTUw8vqr2eRTDRpHAoJ5qnNJt6x0VXFreTz41cJgTEq1eMbtGrYPPH?=
 =?us-ascii?Q?LugvSLfy3yYTDMJ4z93iaiRtgFNEN8xVopEhhmd5RL8GMVs1YBBrIHliJSZY?=
 =?us-ascii?Q?mpiQ0IsT91iN9YJ8khnHPxbvmhS4GZkET7+aI3PJrVvgp3zsOw4tvJArQwTT?=
 =?us-ascii?Q?KUR79z+i63Vy9BEjvbtvIQ+doFVRg5RBCVT1LtAev2Ru8aMBJ0UJTYABZ44+?=
 =?us-ascii?Q?rnFQg7PTazy1Vsi0jP9o/BlqIha3BaLmvvyzlemSQFUL99/oC0RX1gAHfuGj?=
 =?us-ascii?Q?/G1XwejkgbSE0QO5ESSTS9rbVTNVhaUCCgdG4BeKD5DUz2bkR/j1VYKnnQh2?=
 =?us-ascii?Q?e/BwdXNX13G5l/RW+/gjsZsXRX80Hu26odeVXujb/NGHmyitn9o7YiM68okC?=
 =?us-ascii?Q?rbY/1NECN0+LqzG5CRfRtWgrkebhT9GGdatot7h3MC+VSZ8sZlXllFfklIhx?=
 =?us-ascii?Q?pxxDWP1LM0rYSRJ1XgPX1uFkt0x15+zs0w7/wkqtq4PWS+xc7fO0AwM4Svlz?=
 =?us-ascii?Q?ohRWp41YNk2BNXIbqvEssNrbE29UnQmVKH5HZH7Y0PeSgT3ONeViVCEnpAhR?=
 =?us-ascii?Q?pK4BP1jNkcRBGoh+ezxBrHEdk0A7muT9zix24HRYphiKBAahbx41HBJS1DHm?=
 =?us-ascii?Q?LvXrBKVvXG6tmIYwf40vbvosv4eo/69EC3YV+BJjp2vCtzrqRvxkCdiXUksp?=
 =?us-ascii?Q?R36FMOYk5BHuJ5FxIZoxagIGD5RolHPVNnFgHEh1gzfXH+wWPTCIQ4VEfoE3?=
 =?us-ascii?Q?Br9c3qgoWR7nvAAKC+S01CUeKTkGQ6GroLB81XBA4l8Z7BWYNlGf3KBnmF/9?=
 =?us-ascii?Q?VhooBgJIyVpRPCf1vlUGz0kWm7HsFz0oi/XRA8smenEn0x/SI2JrvPGmGWam?=
 =?us-ascii?Q?tW86WueN7qCQULRUoUAu/DKU2skckgsqBc5CQVjgkGbQM2s5txXtklu/PBYc?=
 =?us-ascii?Q?E/0vEEHq2IQ28d0A8p1d9FONzbfwynzPhNuEDBBUt1UmMjMmSrOc2zSNowkD?=
 =?us-ascii?Q?gtayfa2EhB8uw7SXBXe4G7VuuxaOTdvlkw0bZNdkafkE/1kJOns4m0EK7iD9?=
 =?us-ascii?Q?KdilzL3pnsM3X6tk9/seTf9miJpH3NZeNTH/iSvKlvOQWSulAXIvwBFEKsbN?=
 =?us-ascii?Q?6L0FwS7K5BIZjRjbzV8UFqFR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b4adf9-cec4-4e75-6696-08d8e7764b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 05:50:52.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EB3iGo5v674OlkSZQNat6cRA2ViMgfTVyvPS2MB8jFeykR9M+ftli3unKD/zZwF1XsRDzulGN9XsGMvJvNeMjLEoggs0yzP9o9SuPRK28jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB8258
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: Wednesday, March 10, 2021 9:16 PM
> To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul
> <vkoul@kernel.org>; Rob Herring <robh+dt@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Lokesh Vutl=
a
> <lokeshvutla@ti.com>
> Subject: [PATCH v6 05/13] phy: cadence: cadence-sierra: Move all clk_get_=
*()
> to a separate function
>=20
> EXTERNAL MAIL
>=20
>=20
> No functional change. Group all devm_clk_get_optional() to a separate
> function.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 57 +++++++++++++++---------
>  1 file changed, 35 insertions(+), 22 deletions(-)
>=20

Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>

Thanks & regards,
Swapnil

> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> b/drivers/phy/cadence/phy-cadence-sierra.c
> index f7ba0ed416bc..7bf1b4c7774a 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -477,6 +477,38 @@ static int cdns_regmap_init_blocks(struct
> cdns_sierra_phy *sp,
>  	return 0;
>  }
>=20
> +static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
> +				      struct device *dev)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	clk =3D devm_clk_get_optional(dev, "phy_clk");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "failed to get clock phy_clk\n");
> +		return PTR_ERR(clk);
> +	}
> +	sp->clk =3D clk;
> +
> +	clk =3D devm_clk_get_optional(dev, "cmn_refclk_dig_div");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "cmn_refclk_dig_div clock not found\n");
> +		ret =3D PTR_ERR(clk);
> +		return ret;
> +	}
> +	sp->cmn_refclk_dig_div =3D clk;
> +
> +	clk =3D devm_clk_get_optional(dev, "cmn_refclk1_dig_div");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "cmn_refclk1_dig_div clock not found\n");
> +		ret =3D PTR_ERR(clk);
> +		return ret;
> +	}
> +	sp->cmn_refclk1_dig_div =3D clk;
> +
> +	return 0;
> +}
> +
>  static int cdns_sierra_phy_probe(struct platform_device *pdev)  {
>  	struct cdns_sierra_phy *sp;
> @@ -487,7 +519,6 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  	unsigned int id_value;
>  	int i, ret, node =3D 0;
>  	void __iomem *base;
> -	struct clk *clk;
>  	struct device_node *dn =3D dev->of_node, *child;
>=20
>  	if (of_get_child_count(dn) =3D=3D 0)
> @@ -524,11 +555,9 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>=20
>  	platform_set_drvdata(pdev, sp);
>=20
> -	sp->clk =3D devm_clk_get_optional(dev, "phy_clk");
> -	if (IS_ERR(sp->clk)) {
> -		dev_err(dev, "failed to get clock phy_clk\n");
> -		return PTR_ERR(sp->clk);
> -	}
> +	ret =3D cdns_sierra_phy_get_clocks(sp, dev);
> +	if (ret)
> +		return ret;
>=20
>  	sp->phy_rst =3D devm_reset_control_get(dev, "sierra_reset");
>  	if (IS_ERR(sp->phy_rst)) {
> @@ -542,22 +571,6 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  		return PTR_ERR(sp->apb_rst);
>  	}
>=20
> -	clk =3D devm_clk_get_optional(dev, "cmn_refclk_dig_div");
> -	if (IS_ERR(clk)) {
> -		dev_err(dev, "cmn_refclk_dig_div clock not found\n");
> -		ret =3D PTR_ERR(clk);
> -		return ret;
> -	}
> -	sp->cmn_refclk_dig_div =3D clk;
> -
> -	clk =3D devm_clk_get_optional(dev, "cmn_refclk1_dig_div");
> -	if (IS_ERR(clk)) {
> -		dev_err(dev, "cmn_refclk1_dig_div clock not found\n");
> -		ret =3D PTR_ERR(clk);
> -		return ret;
> -	}
> -	sp->cmn_refclk1_dig_div =3D clk;
> -
>  	ret =3D clk_prepare_enable(sp->clk);
>  	if (ret)
>  		return ret;
> --
> 2.17.1

