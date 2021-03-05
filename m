Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91B832F43B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhCETs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:48:59 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:24530 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229737AbhCETsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:48:37 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125JhChG020503;
        Fri, 5 Mar 2021 11:48:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ClwoIfsSdA1dV1qKKaaiCT5NG7gso2dNZolPNJTBEjw=;
 b=A0Fh+PXiDfab5HmN4RegPyV2pu2e4NOf9V6l/FcLFzo5zmBhN7Ik30j5PYFTIxeLNNa4
 kz0siP7WSp/Nq7WoSHCub7Ow54hiR6Rhxl43uUowKdTdiwUs7GN4tiDu+0YyQ5DSgPQa
 F24w98ViX2Fxw67hoNC0pZojlF9mCWGQMPHR4n3Ey/9LF8soqDi5HW2Y7ShvNoE/ctTL
 DSgI6513ZGgY7SRTS5s0dOcVZNHZTWJO6IqywSB28xk+/P9wDkOEIXXez6i2e+XSbdqI
 v5E1lVeUYnOUqKssHB+6xY+X6ydhEyMOjdf89LFcIVVCE8c0IUvKpdmsjUp8GqlxRvtg UQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0014ca01.pphosted.com with ESMTP id 372bvqs7fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 11:48:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWTymlE8NMZF516p202wZZwiTm8FE10LAMORmARryuMlSv+AqaFk38AQsmh9Txcj6ydLI1RvPE3T74vMeZ/FTqhn2Tig7vaDKYLnCNreyzdXZ2bDpN1llKyA0jHpBdSqPX7xvNYOOxSisr1ZVngcPqfBgysbVlX3kZdj5+500q9p4ZKFGEUX8j/pGumfeB6SUSEChnSWNViqy70sRApXq+dSbIrxTffwo0gnNfnd/6LCSdOsobj6HNfK7xRFeLGw5+kxWCE0Y8e5Zv5ixUjLlptgH5TGsHOcspfalTPA80/EKTVOOlhxeoIPbw7eFQJXYpkRFaPQpnuiOOr8/eoE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClwoIfsSdA1dV1qKKaaiCT5NG7gso2dNZolPNJTBEjw=;
 b=YdkWbyi+tS52XSB6HlqWq5K5TU3nZNW92DMO5w4MEufkEk1VJWzYvuMOmGkc90UvarSzE2vd0+k8CrHk4HgB2+gHFYpF9QSsfGnNsAHdVvnHEO6uUf1WMDxaCLGh+/H/Udv5TA8+GkwTDIVcRNwj+ScU502O0frbEsKugilEhnCQ8KGjXJKnOydDLCtGpfepN1LuAGSn2zKPQxk7JLc8torvG76g4u3U43MET8Fc/tTrLSQobMxCpQIjgZWru3OGkO4mqZOuHzp7D+o2JEJl4AFWudZsEqc8S89F/c5l9jC19+sdYvQ9CW/p5yaBvb9OASFwpTwPaJvCOjmin7/zvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClwoIfsSdA1dV1qKKaaiCT5NG7gso2dNZolPNJTBEjw=;
 b=ZYq1x3uoXL7ixC5thnvJ+gHbdygooqWUqW89rRrSKcUv/BDrekB5w/oojfYCqAkJpiYcXWoqTbkA9RvCp0YlF4uEO6+i3lkBwf8GMWViZix++VipHNMQ4GNYTWquDbeAKONtojG/eUN911xBaFm6IqeKAr9o1wEiqaR9ELb+8z8=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by MN2PR07MB5853.namprd07.prod.outlook.com (2603:10b6:208:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 19:48:23 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39%4]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 19:48:23 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v4 13/13] phy: cadence: phy-cadence-sierra: Enable
 pll_cmnlc and pll_cmnlc1 clocks
Thread-Topic: [PATCH v4 13/13] phy: cadence: phy-cadence-sierra: Enable
 pll_cmnlc and pll_cmnlc1 clocks
Thread-Index: AQHXELDCQxY8aZaYPkqeZi4z0Bh0jqp1ykfA
Date:   Fri, 5 Mar 2021 19:48:23 +0000
Message-ID: <MN2PR07MB6160A69CC43D6AF9D9C6F6FAC5969@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210304044122.15166-1-kishon@ti.com>
 <20210304044122.15166-14-kishon@ti.com>
In-Reply-To: <20210304044122.15166-14-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iZDBlZTA1MC03ZGViLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcYmQwZWUwNTEtN2RlYi0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIzOTA4IiB0PSIxMzI1OTQ0NzMwMTc5NTY0MzEiIGg9ImNGR3Awa0dGalplUGxEalAwaXpxQkhQNkVhUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c187ec5-0f1d-4263-c465-08d8e00fa321
x-ms-traffictypediagnostic: MN2PR07MB5853:
x-microsoft-antispam-prvs: <MN2PR07MB585382720982B9711B1511FDC5969@MN2PR07MB5853.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4RtfH4V2K8GLbIfPixGI7KPqQgEP6WhAP9eXff/HmnQmUfonuaT6kePqXtt0FkTCui5VKxFbSoGkeFsutDbVXvtM3avi6czJiL5gT/XBhuzQfxSIMW+KeJMdeAjGUbW18bVY9UUxxJJ09bxe0xu8jhwQ8rsYVtqPcQoBKhBR2w8kqPQquUChY3MIDeU1HXunZbrHQPoraUsmg40AUgTN+IWYSL2OmLEl49Ayxon3iYAtmfdoGWqiJe+p1mYMVZ3uT9DthPUvt5YAlC7M8KyutGJQDk/+DG7WOkoXinMgB3cSh629hEu3K9dvkMib/H47NKl2trGgaX3qN2sI4y0iu32kgSvGBRXOy5OCZt1YgPVvi8FCG7C7ti4UA9pf2rlagGFwQx4H8LuMyFpVIUwFO40tajjoZc7sj6gmXnW1X7bkykJw/YTSXxQmwv5wlm9iXjsX92vReZfyr64dbj7cDeaQJ13FkRKz7swTnpuC7RwE306vVmSkNLbHsjxNUMCE6EGvOQGD/c8Cu/xB3wyFoY9SYTvkL54AgBDEk1Akw3Gow6AGoeCoJXVzAdikQc8o4HQx4w3Nru07xUAssI1vQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(36092001)(2906002)(5660300002)(26005)(6506007)(316002)(86362001)(478600001)(33656002)(55016002)(53546011)(186003)(8936002)(110136005)(71200400001)(52536014)(54906003)(7696005)(9686003)(4326008)(76116006)(66556008)(66446008)(66476007)(66946007)(83380400001)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jIfXBubHmWKGp8HFnDMBDfdFJCXKpX5qf+3cRWllmUP29+YxuyudsLc4VIhb?=
 =?us-ascii?Q?cfLF2RMvEgcUvvFnNFklZj4JsB67fElpXh2VlswzpKpefUv77BZ5jxgM4zId?=
 =?us-ascii?Q?BbivVsXCjobgm4igH1x59J5ZyYGu2h4uX69EwDHrtAwedoYCZMyPsYd3yTwV?=
 =?us-ascii?Q?39U4KwvDovxZBnzrgt5TCjUeCxtVn8NKHXBV4ZqHixubvaiynaVNDKegRupW?=
 =?us-ascii?Q?XJN1qM27s8lt/ACgbKv3ziE7yjrihrQzBh3mOyNQ/aFX4Oha7FODlKjxgUmk?=
 =?us-ascii?Q?Q9fw1Y+pFlqV0l+uC+VqQ9GRfOdNthI/3PPDNo6HtejVqWlOF1ilUIa0fSXx?=
 =?us-ascii?Q?hyyVvjRLrnCBnbzwG3p+v/EjK7N2ZJLZne9CQOT2tjA6rIoncH/f5IKki378?=
 =?us-ascii?Q?xT1Jmlmg1fdt4rgklswj+tZsb6gksjzZVrK8ccvWL4rXAG8GFBSsvGfZawdh?=
 =?us-ascii?Q?A0RYx/NT6wg/zTpwhNR6nVQa7opfta6/Nq3cL7XwWGRX55SYtfNTHB9GSEOT?=
 =?us-ascii?Q?/d+8nmmqcWTC8PTylwCJiLMGJvQk7auyYcd+92g8e7gejgwwlLsReitzJ8m6?=
 =?us-ascii?Q?L8bNKN6BfFiYvi3Hpp/yffxYFBsoTRI7A0F4rAchQVI/2LEUYGrdOg0V2Fyc?=
 =?us-ascii?Q?F9HUb38QJkGjoR5vJUucrHNYxObiGul2QU31FUGV85BZE7LLGZR+vVd8G04a?=
 =?us-ascii?Q?ASPzTCskH0pRbGoHcXkpW/GhGcuQhfsJ9WPuGc2ADK4AE1hjhiyNB8W4fCgH?=
 =?us-ascii?Q?GlpN+t0Pe9DuZs1HD9xsrb+YO/jiP8YJXSNrV1Vy8fxJX+13smWoGyEtI/Q4?=
 =?us-ascii?Q?5ci+2H3scPzjk1brhqi4X4/+Z6BQGuob6GY1X+JcfGY6R6CDz0s684PkcoTl?=
 =?us-ascii?Q?P4cT2Za9YupvT/R4JjVO7CE5B8DpYljeNAl/JV7KhXh4hVVeohh9gpATV98d?=
 =?us-ascii?Q?c5fZPk4i/nscQpXUBHpWaEGI49v+r+j1hmYHwuWdKRJ9nPR0s1TtDfRvKn9v?=
 =?us-ascii?Q?AIXb+7RMv+njHRMD0vPvNpvOZ/R66vo8zD+b88XrQpMMZfRYKE72zDR5FxAS?=
 =?us-ascii?Q?Xp+huS7kIIHyWlEgymEV/zujs52Mh8fCjcq/XHKo+sWkC/fzVS/H/zU+P75m?=
 =?us-ascii?Q?euMTbaLgZZjZ685fjZxqPNoRXmDm1t2BopoI/WyM3m32sy6HHnOt1eKxo5XQ?=
 =?us-ascii?Q?M5jrv25IjbhyE2orTZON6A7Ll783RfX1i52Qh8eRKHs4CmldKnWAblUZCh9c?=
 =?us-ascii?Q?A0apfPt+bwoa5VuHN0AJrksxP9mqGIcMfKk6myTTliA9TLuFkPp/YqbVpjct?=
 =?us-ascii?Q?t6Tx7fM/QV+2z6FA6UISXvLE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c187ec5-0f1d-4263-c465-08d8e00fa321
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 19:48:23.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: il2R21kPnL+cnmxVna4YZeest0RbgL/DD4uQcxARpBFn9txeCKv9Kxb4Ya3RCPvmAd+oDnqjjlX7P+WT/EpY99GDil1eYBt0nGd5VKXvgHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5853
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_13:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: Thursday, March 4, 2021 10:11 AM
> To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul
> <vkoul@kernel.org>; Rob Herring <robh+dt@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Lokesh Vutl=
a
> <lokeshvutla@ti.com>
> Subject: [PATCH v4 13/13] phy: cadence: phy-cadence-sierra: Enable
> pll_cmnlc and pll_cmnlc1 clocks
>=20
> EXTERNAL MAIL
>=20
>=20
> Get pll_cmnlc and pll_cmnlc1 optional clocks and enable them.
> This will enable REFRCV/1 in case the pll_cmnlc/1 takes input
> from REFRCV/1 respectively.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 40 ++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> b/drivers/phy/cadence/phy-cadence-sierra.c
> index be2c91be4205..68d81f953f4f 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -768,6 +768,40 @@ static int cdns_sierra_phy_get_clocks(struct
> cdns_sierra_phy *sp,
>  	return 0;
>  }
>=20
> +static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
> +{
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(sp->input_clks[PLL0_REFCLK]);

Should be PHY_CLK instead of PLL0_REFCLK ?

> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(sp-
> >output_clks[CDNS_SIERRA_PLL_CMNLC]);
> +	if (ret)
> +		goto err_pll_cmnlc;
> +
> +	ret =3D clk_prepare_enable(sp-
> >output_clks[CDNS_SIERRA_PLL_CMNLC1]);
> +	if (ret)
> +		goto err_pll_cmnlc1;
> +
> +	return 0;
> +
> +err_pll_cmnlc:
> +	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
> +
> +err_pll_cmnlc1:
> +	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
> +

Error handling above looks incorrect.
Also should this error path return ret instead of 0 ?

> +	return 0;
> +}
> +
> +static void cdns_sierra_phy_disable_clocks(struct cdns_sierra_phy *sp)
> +{
> +	clk_disable_unprepare(sp-
> >output_clks[CDNS_SIERRA_PLL_CMNLC1]);
> +	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
> +	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
> +}
> +
>  static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
>  				      struct device *dev)
>  {
> @@ -848,7 +882,7 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		goto unregister_clk;
>=20
> -	ret =3D clk_prepare_enable(sp->input_clks[PHY_CLK]);
> +	ret =3D cdns_sierra_phy_enable_clocks(sp);
>  	if (ret)
>  		goto unregister_clk;
>=20
> @@ -925,7 +959,7 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  		reset_control_put(sp->phys[i].lnk_rst);
>  	of_node_put(child);
>  clk_disable:
> -	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
> +	cdns_sierra_phy_disable_clocks(sp);
>  	reset_control_assert(sp->apb_rst);
>  unregister_clk:
>  	cdns_sierra_clk_register(sp);
> @@ -941,6 +975,7 @@ static int cdns_sierra_phy_remove(struct
> platform_device *pdev)
>  	reset_control_assert(phy->apb_rst);
>  	pm_runtime_disable(&pdev->dev);
>=20
> +	cdns_sierra_phy_disable_clocks(phy);
>  	/*
>  	 * The device level resets will be put automatically.
>  	 * Need to put the subnode resets here though.
> @@ -950,7 +985,6 @@ static int cdns_sierra_phy_remove(struct
> platform_device *pdev)
>  		reset_control_put(phy->phys[i].lnk_rst);
>  	}
>=20
> -	clk_disable_unprepare(phy->input_clks[PHY_CLK]);
>  	cdns_sierra_clk_unregister(phy);
>=20
>  	return 0;
> --
> 2.17.1

Thanks & regards,
Swapnil
