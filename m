Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8255133AB44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCOFwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:52:46 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:24930 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230020AbhCOFwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:52:15 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F5mvc1018552;
        Sun, 14 Mar 2021 22:52:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9/erBhSOS5T9vHUWP/OH/wCS3lnxSssYyfDhxbyeADw=;
 b=qFkfoJcYHiL2yKLRFjfY47c8cKuLR0TLKbkFjY2ghDZR5Nwkoz32Adk7MB55TpWxg4e2
 Nrs0znKbKN7/xw/DL6g6ZxACpkiYr7G+3eso7r3XE4ofhTWvEIkJa1mQccDoqgOf7s27
 yidOYNW6Uj2KdOcX3yKL5eN9wCfwEQLce8URdrrscJDBSF437nEyzzBQJHSs2wfjHdZ0
 CyjaVl8vjgPkSRso1xMxhManiiu4qLbH/M1hhKUvJnYaAdGpuApEfhJK9JPQ3QEo9JnC
 azf9aZJ4Bea1yzfDS7GSWkAC8sQKZyuT+VVuXs8jBPTZfk8OJohWrwAdTHsg4R3v8csr Wg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2cv4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 22:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEF/0dqMNhraUD6Was/5d4gW1FQuXa904DAJcmVNEQqOYcPMOhxAJkBId0+iOhqnWODB55TaXt1k/Pl6jh/8d9lOULDOF7r7IwJBkw+Mg0QQxv81c2cXmW7Ep38sEZ68fZPqhCW300VZRq1tROibnaZNfNPZ5h/1KvJMh1hb8Krgj4efOCbJ47vgN8FBovW/7D1iSASQBZOKVetRUPzwFTRNJ1GKRlkq09DN9PxaedlvWVqbAA7fmMVXMkZFvhh8nHEi/NAK6gzVgiyzoRTvgWQ39nUQJ0IEVyqApEnwEQLzE/VELalrvy47JVDLXxUKWemTP6aWNLDWmEf8vuqwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/erBhSOS5T9vHUWP/OH/wCS3lnxSssYyfDhxbyeADw=;
 b=YYHF7aY58BDN8D0gtEfv0jjn+pbZgOsMsQ8KjS86R2R4RrBFLIeifl+ZlMTCbgOCoOpCoEjKm294DMRYdKvG9dEZErky4fcarI5f8X/5yZCyL9qhZaoBYl6b/xu9Ufgi9Svb1wSqNWn9yDQTd91FZi2dwjyZnvbkCeig1gXVoXAUgEct/oIuLM5Ze+wqVISs+VcG2D3pZdSLrtGMo4Z5rrOwCPPhfcr0r/ugDZaG5CJ88FaeEP1ossIr0lNyfbzzEOmhgM/TLmIgL7UwEfwgPkfPKvIfAZpPuME9bRgoT6arzcEZilqpMd2mKj2kmSqn379VT7jwEQcGglDMO08bCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/erBhSOS5T9vHUWP/OH/wCS3lnxSssYyfDhxbyeADw=;
 b=Q31s0ztzvMPF4ABpEWGqz7aXe0aGpZN/3rZWAx3jvswUmb4Jgkj2VqzCnMgRf5qYNcnzYCO/aiv0diGWQ6QUpNuo/1frMX/7SDpQ8MqBw+Ml5s0jJB0/n/2FD7PUvPMxsV/nXyudpaQN7YwT6A9+Uv3hf6NbAA0X0w8U/MjdNr0=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by MN2PR07MB5822.namprd07.prod.outlook.com (2603:10b6:208:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 05:52:07 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 05:52:07 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v6 09/13] phy: cadence: cadence-sierra: Add array of input
 clocks in "struct cdns_sierra_phy"
Thread-Topic: [PATCH v6 09/13] phy: cadence: cadence-sierra: Add array of
 input clocks in "struct cdns_sierra_phy"
Thread-Index: AQHXFcSOoIXfsbUbMUOlezsxRPUbbqqAC2SQ
Date:   Mon, 15 Mar 2021 05:52:07 +0000
Message-ID: <MN2PR07MB61603587C654E52BC47FFA0AC56C9@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210310154558.32078-1-kishon@ti.com>
 <20210310154558.32078-10-kishon@ti.com>
In-Reply-To: <20210310154558.32078-10-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05MTllMzgzYS04NTUyLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcOTE5ZTM4M2ItODU1Mi0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSI0MzAyIiB0PSIxMzI2MDI2MTEyNTIxMjkwNzciIGg9IjBVa0hLQ0JmNThLNituTU5rRzJES1l6akI1WT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 532f5e26-117e-4745-2716-08d8e77677ea
x-ms-traffictypediagnostic: MN2PR07MB5822:
x-microsoft-antispam-prvs: <MN2PR07MB58223E978452B49B695B5ABCC56C9@MN2PR07MB5822.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5tCsfn6W7p4rCcq2CWt2N2UASdblmUY4VXfwRD72zdQ+yijCsbIt3D10pAkjg65dskepQWf0s2aD+8hbEHlbVQWmVndNUyOXsvoKn+2azFXKMx/Q8a8dN5mO8kfnf0YOLqRuOTHb4r6pXAgdE+wlXwiPk49gh+YSmjqzyD2mf9IvXWZ6dF+yp8x5rT4Su3w8G0gAl5uXOKnocvsRPjvENyoQU1NptFgeDHwm/R+1M6qcVpwlL89WRb2pqLzuidUZHfkKUWqatGz8ZTkJI0PwEOQ+aKxmF6EQkgHvVS2n4eyjrUD9BaHinbT3mdelNMOeqHpc+CN84T5z1V3oDEl4FTh3pOa9dqsmURU1TvgHlyW7xirv7Y6vJznGWY+EoV6cPcy/UdCONn2PxfrUfvRhJbNF9b6Q5l1H1szLHaWvPSmuyk/9M1rlebIdgPTi4PchSsR47mlMHLpyVkATcI3V0mF53FOREHs0YsbPhaYoIxFLe6DRd3+Kx81WxCGIl2hyn21FtnoYNer3yX45UIaFV9iABTwpxh61IE/iDfj373TWdKqbXd0r2PtPKj+JZfYglA7+u83pzPQWj+iPYZCalRjQHB1N582ykHlvTQg4otgkI//70Up1Arj+HcFuNYE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(36092001)(26005)(9686003)(53546011)(33656002)(54906003)(186003)(8936002)(66556008)(55016002)(478600001)(66946007)(76116006)(110136005)(66476007)(64756008)(86362001)(66446008)(7696005)(6506007)(52536014)(83380400001)(316002)(5660300002)(8676002)(4326008)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MAgEKbM1ZRlHt4e5t6Q8jVsnkMZ1MSRsT3GUIcdl4wSm0FrnGJA3TXC2cNjn?=
 =?us-ascii?Q?uMt4lWHrMDDC3a8cnsnCzrzdBSbD/fkbHx79Ff6uyiGSGLt9/huuvbYxpA+o?=
 =?us-ascii?Q?JOvKxv6nESL3gAZm9VRrvLqFvBDNFsR2T7gvWyN0LqEDR/KpTRUkYG9CLqBh?=
 =?us-ascii?Q?M4YsuyvFeYZskfvWHHCDkS7zl0/gFu+Jr4xqXZvnbAzS280xFCIRaA8HludH?=
 =?us-ascii?Q?MW2irvLFL2S9f9pTfAMdJGif7ojkZHxWDQV+cLbvUNIvRjSBDd78Ll3Eim2h?=
 =?us-ascii?Q?WVVldAC9Qo2iKMgdDotf9Jucdkyvmxn6KpCbtwpqvbFS+3Aq6HjG+SnCyUH9?=
 =?us-ascii?Q?KSTsYotsez2pudLHx/SXqKqjoZOWdhgkI8MI36FyqPpEDTU/GQzIIULConbJ?=
 =?us-ascii?Q?f5AkIurnkwyY6N31FjKYv0r446wEVUnr7t1aQgMTy9zmJSlgwioT1Jf07pkD?=
 =?us-ascii?Q?35TgnpJ9N68xTJ5Yh03PwdnY1g9jmJnM/HefTgZA+K60NIfero60VGUTC7CR?=
 =?us-ascii?Q?hi97X8Ook39H0ycHErvfMk5KI/6tB6hpWMGwVrmkdgsyw0BUZNyLi7XNJZW4?=
 =?us-ascii?Q?uVKuggepfj9He2ZaY0Opxb33UkT8dXbCFAIJK4drw9zStVLnr5GGhneFXD+H?=
 =?us-ascii?Q?BxuPb2ND7T9dKkleZjYhbFG1KnoDks8C4tEsqO0K0y0jJ0Cgj14g5X2HLqVX?=
 =?us-ascii?Q?o/mNMzsvRTR4EWeF6Pt7EmTCylS4GJjYBLzT8DTbVzvndo1OtoUNSGPmViNw?=
 =?us-ascii?Q?H13zKrg8zwmw3FjJ6Cxzz2Rwk89cGs4XYqe96dpLv6HVeD9R3VAwR0GyPafT?=
 =?us-ascii?Q?zF5HxfbnsMu5Sv4/K8+YDCiHXCC5XwZrfC9JGTliT3T/vk7o+QKZe1kkZxlo?=
 =?us-ascii?Q?wiOJwoDwnR5ngDbsTosuG2tvUONYtStSV01t6BYFNRD+01X6iHO2V/4Hokt+?=
 =?us-ascii?Q?Pmh5NC2uItxFg1NiJ1n1wCp3RFHny5iM87t876d/u13m651KEMYPJfbr0bw1?=
 =?us-ascii?Q?MQH6ekTbMXsK+btkqeR4kM751fkrGiLN588SIVX+CYX64vLu6IZU+mf7iPP2?=
 =?us-ascii?Q?0S4CzXXk8ciZWvsfoljWGBq55yjcg/9hEZo0sreNDcUwX1DDSeESXCDeMFfx?=
 =?us-ascii?Q?iDhn4yGthgIgigl7F08C1LVPkj9SD8X/Wx5/78w/QXXXezy1vAn3AEMvTJc0?=
 =?us-ascii?Q?RKAIb4FStluOmCW1qUHhrMj38I0wDk1dkrBUIAGcNfe35xIKbO0oB6w4MLsv?=
 =?us-ascii?Q?ChuDoIt13JU2a7cMuzIuKYXnRCbN5e4bvOCJORbtJgL8MfsBB4vvJVmixnK7?=
 =?us-ascii?Q?JFB3BOlT3bYAWKft/VZSMKnw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532f5e26-117e-4745-2716-08d8e77677ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 05:52:07.5757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLS91qkhtz7aXQ2sQ/NHnMEnUPwwxzh4GxarzfbdRN1rnZvhH+ckHRPedwj6rh1LbBFcQSmk4N2fNMUB1Vg1nkT20PZXoko9BuNAv5spyl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5822
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150040
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
> Subject: [PATCH v6 09/13] phy: cadence: cadence-sierra: Add array of inpu=
t
> clocks in "struct cdns_sierra_phy"
>=20
> EXTERNAL MAIL
>=20
>=20
> Instead of having separate structure members for each input clock, add
> an array for the input clocks within "struct cdns_sierra_phy". This is
> in preparation for adding more input clocks required for supporting
> additional clock combination.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 25 ++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>

Thanks & regards,
Swapnil

> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> b/drivers/phy/cadence/phy-cadence-sierra.c
> index 44c52a0842dc..a45278c30948 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -144,6 +144,13 @@
>  #define SIERRA_MAX_LANES				16
>  #define PLL_LOCK_TIME					100000
>=20
> +#define CDNS_SIERRA_INPUT_CLOCKS			3
> +enum cdns_sierra_clock_input {
> +	PHY_CLK,
> +	CMN_REFCLK_DIG_DIV,
> +	CMN_REFCLK1_DIG_DIV,
> +};
> +
>  static const struct reg_field macro_id_type =3D
>  				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
>  static const struct reg_field phy_pll_cfg_1 =3D
> @@ -197,9 +204,7 @@ struct cdns_sierra_phy {
>  	struct regmap_field *macro_id_type;
>  	struct regmap_field *phy_pll_cfg_1;
>  	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
> -	struct clk *clk;
> -	struct clk *cmn_refclk_dig_div;
> -	struct clk *cmn_refclk1_dig_div;
> +	struct clk *input_clks[CDNS_SIERRA_INPUT_CLOCKS];
>  	int nsubnodes;
>  	u32 num_lanes;
>  	bool autoconf;
> @@ -281,8 +286,8 @@ static int cdns_sierra_phy_init(struct phy *gphy)
>  	if (phy->autoconf)
>  		return 0;
>=20
> -	clk_set_rate(phy->cmn_refclk_dig_div, 25000000);
> -	clk_set_rate(phy->cmn_refclk1_dig_div, 25000000);
> +	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
> +	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
>  	if (ins->phy_type =3D=3D PHY_TYPE_PCIE) {
>  		num_cmn_regs =3D phy->init_data->pcie_cmn_regs;
>  		num_ln_regs =3D phy->init_data->pcie_ln_regs;
> @@ -488,7 +493,7 @@ static int cdns_sierra_phy_get_clocks(struct
> cdns_sierra_phy *sp,
>  		dev_err(dev, "failed to get clock phy_clk\n");
>  		return PTR_ERR(clk);
>  	}
> -	sp->clk =3D clk;
> +	sp->input_clks[PHY_CLK] =3D clk;
>=20
>  	clk =3D devm_clk_get_optional(dev, "cmn_refclk_dig_div");
>  	if (IS_ERR(clk)) {
> @@ -496,7 +501,7 @@ static int cdns_sierra_phy_get_clocks(struct
> cdns_sierra_phy *sp,
>  		ret =3D PTR_ERR(clk);
>  		return ret;
>  	}
> -	sp->cmn_refclk_dig_div =3D clk;
> +	sp->input_clks[CMN_REFCLK_DIG_DIV] =3D clk;
>=20
>  	clk =3D devm_clk_get_optional(dev, "cmn_refclk1_dig_div");
>  	if (IS_ERR(clk)) {
> @@ -504,7 +509,7 @@ static int cdns_sierra_phy_get_clocks(struct
> cdns_sierra_phy *sp,
>  		ret =3D PTR_ERR(clk);
>  		return ret;
>  	}
> -	sp->cmn_refclk1_dig_div =3D clk;
> +	sp->input_clks[CMN_REFCLK1_DIG_DIV] =3D clk;
>=20
>  	return 0;
>  }
> @@ -585,7 +590,7 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D clk_prepare_enable(sp->clk);
> +	ret =3D clk_prepare_enable(sp->input_clks[PHY_CLK]);
>  	if (ret)
>  		return ret;
>=20
> @@ -662,7 +667,7 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  		reset_control_put(sp->phys[i].lnk_rst);
>  	of_node_put(child);
>  clk_disable:
> -	clk_disable_unprepare(sp->clk);
> +	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
>  	reset_control_assert(sp->apb_rst);
>  	return ret;
>  }
> --
> 2.17.1

