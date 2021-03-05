Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF1E32F439
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCETrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:47:55 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:50292 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229768AbhCETrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:47:47 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125JhgHC027743;
        Fri, 5 Mar 2021 11:47:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Mxb1mybLlGRWWwV0RZa8krBq/6ln371ugOOtyAdDOs4=;
 b=JxEFq3mYdOztNoQlbs2/lpMsh9gXthOrf3ZESJyVuO7pF2XlLC21OKwPWLyT/3SnE6GH
 bmCt5TmjApy372uORffMXODDQabyPCumzO8+Bz6mqHNqrA0baeEygYGNWbWD1hzikosL
 SavXAcXEGQ4GN/0RadsaJZEUM+fqrktlN15mPWsym7QxtAYyb1DgurFax7slbJ2Xjy/8
 /AOA7eklefdA0+sBlCZqR3b2lsmuGkb2fjuGwvYUfVExvSm9XzXlbL6uv+9lke5euGmj
 xeNEuCqfDh8r2swYb9onxlC40lvDH05dhBvySQ5x+azg2clJ0GPOEt5jGlBY1Uhn616Y pQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-0014ca01.pphosted.com with ESMTP id 36yjj2xupn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 11:47:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEHrXGR9YpUazmIFRklq3W93Wh5ey9g8uLqP1s2oQfCvtHGXeCcJbptrwDCMTZA9ZDZ64XHZokOgv3ta1npZ9QZomZBbc4x+IcGQV/wmEkYdPirVyQiZmq1k3EHx/UTjCgWMM/MqI06qhL9bhmX7JaLXMzsPDAcMuqhouq7dymwJjxJDgJg+Cthqb/dTdYLKT5WMljG+1ungDm6v8uTWBoYJK/RFR0cpd7CrvlyCj6E0YQNDTtev01thmPNVfmd51N7XNzJkw1kP+Up9pxuWsdco1AnwWKc7GSYl+Pd74bH/F6RmZVlwYIr5hiYgebMm3h9MbhxS8vPZSbql34xoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxb1mybLlGRWWwV0RZa8krBq/6ln371ugOOtyAdDOs4=;
 b=ZQd58p/nu7qoIaEc3g5hImWvc8vTEQIZ+1iuXU59ZaDGPWvGkD0arOoJePJ40XOvkljJDuPnFl3SIMAf9lisbqhKMzkLINWgt8RewZ2iTNjA9ROoPqYi6HHZctH3p/6e2Dtvk72sBTAgnhfgllHg0TwgePHL453I1uBlr0oWXCICA9mr6+CNrq/Jse7fWTI7dpjQGiOQKOBeWoEMWk+RKdWlFbfWXxEX2ZpJ9OS7uFgkB/SHUe4anaEWcP0H7NLjOS0aKsFabj9I+JsyXwKlZejQSb8NzHtjdo52qkcrVXAOBqk8uccCLioLadZ6HOMKD0VK5j8FxVA+e+puEqo0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxb1mybLlGRWWwV0RZa8krBq/6ln371ugOOtyAdDOs4=;
 b=urIyVGXi9qD5VgeaSalkhz9LOV2L/pYRKWa3ga6fws73GQBuYcZRMdjzNOHgyHDWihhzzrz5bxmE0SUdf63rboGsnUQU08kOsRC1/YvjQSsQnKnRLuRSVSSgW70mOw72lDG3bQk/Dh4DdtOA4OVgwDWhi/iYbHzyL7CH6cgbdEw=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by MN2PR07MB6029.namprd07.prod.outlook.com (2603:10b6:208:10a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Fri, 5 Mar
 2021 19:47:29 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39%4]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 19:47:28 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v4 12/13] phy: cadence: phy-cadence-sierra: Model
 PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)
Thread-Topic: [PATCH v4 12/13] phy: cadence: phy-cadence-sierra: Model
 PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)
Thread-Index: AQHXELDAgSDasGYCVEGaoml16B7bY6p1wCDw
Date:   Fri, 5 Mar 2021 19:47:28 +0000
Message-ID: <MN2PR07MB6160AC152A97773F1428ED62C5969@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210304044122.15166-1-kishon@ti.com>
 <20210304044122.15166-13-kishon@ti.com>
In-Reply-To: <20210304044122.15166-13-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05YTY5ZDlkNy03ZGViLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcOWE2OWQ5ZDgtN2RlYi0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIxNDI4NiIgdD0iMTMyNTk0NDcyNDM3MTI0ODg0IiBoPSJDQXc0OEdhSzl5RjVIbHRkeXNaNFV2bG16U3c9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d16cdf88-578d-451b-66c2-08d8e00f8225
x-ms-traffictypediagnostic: MN2PR07MB6029:
x-microsoft-antispam-prvs: <MN2PR07MB6029822DF2AA037327A5E998C5969@MN2PR07MB6029.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:33;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dx+gHr/1VgjUyKv6CI1zTJvUQRudIS+ekj1jQnamVb1JapZkSri4bQRWyR/GfZ4VIh+87D7VRd2Y5U6Zm6sJbLs/RGtLi+ezjhg8r2hIVmKFPA/ZzAb0LUBNMquwucRsPbKexlXdD2PZStgqsYBUQkLgfXlpyLBbYfUch1yRwMFTtRDKhqgIqiC5zcv3jyUz4K2ksjgjCKxMkzGFQf6IJoM5n6/g8jJYUDf+GLm9zDE7lWC4qWflPx2iQgziWbcMb7uayznuRk6hfqa32zTfMDFwHCeMFHQMuDaV235n/rBupsi4P5axQ1jP8VZGYOHDKROXrb4rNHOmmg1dhl5QXJ7LubN0GcwxnCXVlEVg56dm3CF2NSdpOe40r1eAmU8h5vfE10hoP3XZadWWfweR1nHc4KDryBH+3q0+94rGaKA7V5/hoC0LIn3I0pM7w3MHPm2K0BKznHvX+hpXzDVKu4x1hRbsjEQSiWhQD6wh9qvqozL6c3NtReJc0AFxdNPzVAsyM9r2hP6OrLq9p7T29w6giGHuf/9f5EfH4Wrp7WtIGwzPWcGqEYoc4WjgELFo2PzWPOjvCnBMWjcBPROEuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(36092001)(71200400001)(8936002)(66476007)(55016002)(66946007)(9686003)(30864003)(8676002)(86362001)(5660300002)(316002)(66556008)(26005)(53546011)(52536014)(76116006)(66446008)(4326008)(83380400001)(54906003)(2906002)(110136005)(6506007)(64756008)(478600001)(186003)(7696005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/6ztuKk0Ft/E8aIIfs6JUW9D7zPUkc4MtkXoKAYdSPxjc2nghVRqXRXwahtK?=
 =?us-ascii?Q?MWJb7mxLZC16nhV7w4TIgRILsfsie2Wr7azk3AmMXeJ0Zyf4vztRc+/sMESK?=
 =?us-ascii?Q?36zrjQDQh11/gMmkATtzsa8tZtdPM0oCgK+b7WcmL1i7TWtfAx4YO1lFb3gP?=
 =?us-ascii?Q?QBF4QVg9NXL4pY9QkJEj9rxum3IIu5bs6Bk6A4BPfIEE4sPoWvE0TCEcXQ6O?=
 =?us-ascii?Q?FrtDz9sTrNR3oXIteEX5quCmxiPf5259vcbiGy1QPL4gmbGPeGOYlyh0s0L8?=
 =?us-ascii?Q?BcX1XmbuOPVWKjwqBRjQkAZ0LfILQ+jzwpkC4e6IVLEzuXqUYjxRJO0YlrVl?=
 =?us-ascii?Q?U5LuEzoXM6lrvF31tuKvwVvVSij/QTgAJq5BgK/ap6DO39B608Ny5t/Oo4Nf?=
 =?us-ascii?Q?azMKT+VTSjNtbJqkDA1NBdBw+tsLGYMfjIw2rcxDkFcROKMNdc3mKtncVP1V?=
 =?us-ascii?Q?9A601uIirplul22GTKFpHfGnap7yWlVVLBubmhKJfOcxbUFYIc1UiCWS3/2a?=
 =?us-ascii?Q?ZAte6R+6LdKmn9Cr5PwweI4sw3ZCY28YsNFyHDHleLwXVi/AkWv8/fFn2wii?=
 =?us-ascii?Q?srdDVPB1FHywy2Gqy1UPjDq96NNXZVevn5qTNLAE1SuPYaqWLqNLdH+SKtZE?=
 =?us-ascii?Q?RiVj4Qyj1ajyRgFCW+f/6D++3lAbhxPBS13EfsaRE6ujJH6oFPB9GmtfPQuA?=
 =?us-ascii?Q?Um392rNeV4ijk3b2AsB5JbJdthk7zDnXN0wF87X4E+tM8DLU/U/xxNOBABkF?=
 =?us-ascii?Q?e/7axz6a5P7x7LzB5O2xs61h3eU8Aqy30ytxI1E8vAXswvcp8vhYeNkRDWJR?=
 =?us-ascii?Q?ZtmpwJYyA4AuW81NPFSFYx8QfkdiRkyW+E8kmAh3Zad0+7pXfCumRtdOqSu0?=
 =?us-ascii?Q?i84YNxFScwB7Kmfjzcxt1OXn/wAhKbax4GQIr1wdAlhqMCa+XIg+GlyssEE/?=
 =?us-ascii?Q?/d4MNWgtJ4Nxl3E3YLhd0QCgaRnGSZ/TwoP6CpYDvxpdGq3f3dbuVpyVfAV3?=
 =?us-ascii?Q?jntNwOJS5t3QHR/TiuQL1jVr+Wuu6bu9Gyi9s21+hXEGAQHGZEtu6Ft5hAoZ?=
 =?us-ascii?Q?ZSNxJpvlJvwRUkYISS0GD6+9VK7nGhQh8ge0w7GBQX+T/8vTSNcpnMX7Y7IB?=
 =?us-ascii?Q?WgxY7HONSpHOdzy+b7LL/X2NFOGXe4BF92dKEUO7GiHJ7yd63bnZxjG9v3YF?=
 =?us-ascii?Q?D6b1OceEsMcfpr8Y/9GLYnUzMjq5PP4h/p09/M50/hDzT+Sk+9IisGwPDCAf?=
 =?us-ascii?Q?q6JVaUVVT/EQYbs154mvKjPPaLxECXcoUotHYSAYf63BUDNXT0PKdRgh2Z0K?=
 =?us-ascii?Q?3D6KgsafNUP48gUJDQo0rCo5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16cdf88-578d-451b-66c2-08d8e00f8225
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 19:47:28.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJ+QVU+orFGquPO1dCei/k4l6EZ481p5SyCJ2A2mGY19SpkgniPfOGAxkktMfR5OtwvsNhazmO7s6KpXyVLeW4EBRSQen+VSv8qLDs9SAYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6029
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_13:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050100
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
> Subject: [PATCH v4 12/13] phy: cadence: phy-cadence-sierra: Model
> PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)
>=20
> EXTERNAL MAIL
>=20
>=20
> Sierra has two PLLs, PLL_CMNLC and PLL_CMNLC1 and each of these PLLs has
> two inputs, plllc_refclk (input from pll0_refclk) and refrcv (input from
> pll1_refclk). Model PLL_CMNLC and PLL_CMNLC1 as clocks so that it's
> possible to select one of these two inputs from device tree.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/Kconfig              |   1 +
>  drivers/phy/cadence/phy-cadence-sierra.c | 267 ++++++++++++++++++++++-
>  2 files changed, 265 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> index 432832bdbd16..23d5382c34ed 100644
> --- a/drivers/phy/cadence/Kconfig
> +++ b/drivers/phy/cadence/Kconfig
> @@ -24,6 +24,7 @@ config PHY_CADENCE_DPHY
>  config PHY_CADENCE_SIERRA
>  	tristate "Cadence Sierra PHY Driver"
>  	depends on OF && HAS_IOMEM && RESET_CONTROLLER
> +	depends on COMMON_CLK
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the Cadence Sierra PHY driver
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> b/drivers/phy/cadence/phy-cadence-sierra.c
> index ac32b7b0289f..be2c91be4205 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -7,6 +7,7 @@
>   *
>   */
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -20,10 +21,12 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-cadence.h>
>=20
>  /* PHY register offsets */
>  #define SIERRA_COMMON_CDB_OFFSET			0x0
>  #define SIERRA_MACRO_ID_REG				0x0
> +#define SIERRA_CMN_PLLLC_GEN_PREG			0x42
>  #define SIERRA_CMN_PLLLC_MODE_PREG			0x48
>  #define SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG		0x49
>  #define SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG		0x4A
> @@ -31,6 +34,9 @@
>  #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
>  #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
>  #define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG	0x62
> +#define SIERRA_CMN_REFRCV_PREG				0x98
> +#define SIERRA_CMN_REFRCV1_PREG				0xB8
> +#define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
>=20
>  #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
>  				((0x4000 << (block_offset)) + \
> @@ -144,13 +150,19 @@
>  #define SIERRA_MAX_LANES				16
>  #define PLL_LOCK_TIME					100000
>=20
> -#define CDNS_SIERRA_INPUT_CLOCKS			3
> +#define CDNS_SIERRA_OUTPUT_CLOCKS			2
> +#define CDNS_SIERRA_INPUT_CLOCKS			5
>  enum cdns_sierra_clock_input {
>  	PHY_CLK,
>  	CMN_REFCLK_DIG_DIV,
>  	CMN_REFCLK1_DIG_DIV,
> +	PLL0_REFCLK,
> +	PLL1_REFCLK,
>  };
>=20
> +#define SIERRA_NUM_CMN_PLLC				2
> +#define SIERRA_NUM_CMN_PLLC_PARENTS			2
> +
>  static const struct reg_field macro_id_type =3D
>  				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
>  static const struct reg_field phy_pll_cfg_1 =3D
> @@ -158,6 +170,53 @@ static const struct reg_field phy_pll_cfg_1 =3D
>  static const struct reg_field pllctrl_lock =3D
>  				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0,
> 0);
>=20
> +static const char * const clk_names[] =3D {
> +	[CDNS_SIERRA_PLL_CMNLC] =3D "pll_cmnlc",
> +	[CDNS_SIERRA_PLL_CMNLC1] =3D "pll_cmnlc1",
> +};
> +
> +enum cdns_sierra_cmn_plllc {
> +	CMN_PLLLC,
> +	CMN_PLLLC1,
> +};
> +
> +struct cdns_sierra_pll_mux_reg_fields {
> +	struct reg_field	pfdclk_sel_preg;
> +	struct reg_field	plllc1en_field;
> +	struct reg_field	termen_field;
> +};
> +
> +static const struct cdns_sierra_pll_mux_reg_fields
> cmn_plllc_pfdclk1_sel_preg[] =3D {
> +	[CMN_PLLLC] =3D {
> +		.pfdclk_sel_preg =3D
> REG_FIELD(SIERRA_CMN_PLLLC_GEN_PREG, 1, 1),
> +		.plllc1en_field =3D REG_FIELD(SIERRA_CMN_REFRCV1_PREG, 8,
> 8),
> +		.termen_field =3D REG_FIELD(SIERRA_CMN_REFRCV1_PREG, 0,
> 0),
> +	},
> +	[CMN_PLLLC1] =3D {
> +		.pfdclk_sel_preg =3D
> REG_FIELD(SIERRA_CMN_PLLLC1_GEN_PREG, 1, 1),
> +		.plllc1en_field =3D REG_FIELD(SIERRA_CMN_REFRCV_PREG, 8,
> 8),
> +		.termen_field =3D REG_FIELD(SIERRA_CMN_REFRCV_PREG, 0, 0),
> +	},
> +};
> +
> +struct cdns_sierra_pll_mux {
> +	struct clk_hw		hw;
> +	struct regmap_field	*pfdclk_sel_preg;
> +	struct regmap_field	*plllc1en_field;
> +	struct regmap_field	*termen_field;
> +	struct clk_init_data	clk_data;
> +};
> +
> +#define to_cdns_sierra_pll_mux(_hw)	\
> +			container_of(_hw, struct cdns_sierra_pll_mux, hw)
> +
> +static const int pll_mux_parent_index[][SIERRA_NUM_CMN_PLLC_PARENTS]
> =3D {
> +	[CMN_PLLLC] =3D { PLL0_REFCLK, PLL1_REFCLK },
> +	[CMN_PLLLC1] =3D { PLL1_REFCLK, PLL0_REFCLK },
> +};
> +
> +static u32 cdns_sierra_pll_mux_table[] =3D { 0, 1 };
> +
>  struct cdns_sierra_inst {
>  	struct phy *phy;
>  	u32 phy_type;
> @@ -204,10 +263,15 @@ struct cdns_sierra_phy {
>  	struct regmap_field *macro_id_type;
>  	struct regmap_field *phy_pll_cfg_1;
>  	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
> +	struct regmap_field
> *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_CMN_PLLC];
> +	struct regmap_field
> *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_CMN_PLLC];
> +	struct regmap_field
> *cmn_plllc_pfdclk1_sel_preg[SIERRA_NUM_CMN_PLLC];
>  	struct clk *input_clks[CDNS_SIERRA_INPUT_CLOCKS];
>  	int nsubnodes;
>  	u32 num_lanes;
>  	bool autoconf;
> +	struct clk_onecell_data clk_data;
> +	struct clk *output_clks[CDNS_SIERRA_OUTPUT_CLOCKS];
>  };
>=20
>  static int cdns_regmap_write(void *context, unsigned int reg, unsigned i=
nt
> val)
> @@ -369,6 +433,153 @@ static const struct phy_ops ops =3D {
>  	.owner		=3D THIS_MODULE,
>  };
>=20
> +static u8 cdns_sierra_pll_mux_get_parent(struct clk_hw *hw)
> +{
> +	struct cdns_sierra_pll_mux *mux =3D to_cdns_sierra_pll_mux(hw);
> +	struct regmap_field *field =3D mux->pfdclk_sel_preg;
> +	unsigned int val;
> +
> +	regmap_field_read(field, &val);
> +	return clk_mux_val_to_index(hw, cdns_sierra_pll_mux_table, 0, val);
> +}
> +
> +static int cdns_sierra_pll_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct cdns_sierra_pll_mux *mux =3D to_cdns_sierra_pll_mux(hw);
> +	struct regmap_field *plllc1en_field =3D mux->plllc1en_field;
> +	struct regmap_field *termen_field =3D mux->termen_field;
> +	struct regmap_field *field =3D mux->pfdclk_sel_preg;
> +	int val, ret;
> +
> +	ret =3D regmap_field_write(plllc1en_field, 0);
> +	ret |=3D regmap_field_write(termen_field, 0);
> +	if (index =3D=3D 1) {
> +		ret |=3D regmap_field_write(plllc1en_field, 1);
> +		ret |=3D regmap_field_write(termen_field, 1);
> +	}
> +
> +	val =3D cdns_sierra_pll_mux_table[index];
> +	ret |=3D regmap_field_write(field, val);
> +
> +	return ret;
> +}
> +
> +static const struct clk_ops cdns_sierra_pll_mux_ops =3D {
> +	.set_parent =3D cdns_sierra_pll_mux_set_parent,
> +	.get_parent =3D cdns_sierra_pll_mux_get_parent,
> +};
> +
> +static int cdns_sierra_pll_mux_register(struct cdns_sierra_phy *sp,
> +					struct regmap_field
> *pfdclk1_sel_field,
> +					struct regmap_field *plllc1en_field,
> +					struct regmap_field *termen_field,
> +					int clk_index)
> +{
> +	struct cdns_sierra_pll_mux *mux;
> +	struct device *dev =3D sp->dev;
> +	struct clk_init_data *init;
> +	const char **parent_names;
> +	unsigned int num_parents;
> +	char clk_name[100];
> +	struct clk *clk;
> +	int i;
> +
> +	mux =3D devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
> +		return -ENOMEM;
> +
> +	num_parents =3D SIERRA_NUM_CMN_PLLC_PARENTS;
> +	parent_names =3D devm_kzalloc(dev, (sizeof(char *) * num_parents),
> GFP_KERNEL);
> +	if (!parent_names)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < num_parents; i++) {
> +		clk =3D sp->input_clks[pll_mux_parent_index[clk_index][i]];
> +		if (IS_ERR_OR_NULL(clk)) {
> +			dev_err(dev, "No parent clock for derived_refclk\n");
> +			return PTR_ERR(clk);
> +		}
> +		parent_names[i] =3D __clk_get_name(clk);
> +	}
> +
> +	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
> clk_names[clk_index]);
> +
> +	init =3D &mux->clk_data;
> +
> +	init->ops =3D &cdns_sierra_pll_mux_ops;
> +	init->flags =3D CLK_SET_RATE_NO_REPARENT;
> +	init->parent_names =3D parent_names;
> +	init->num_parents =3D num_parents;
> +	init->name =3D clk_name;
> +
> +	mux->pfdclk_sel_preg =3D pfdclk1_sel_field;
> +	mux->plllc1en_field =3D plllc1en_field;
> +	mux->termen_field =3D termen_field;
> +	mux->hw.init =3D init;
> +
> +	clk =3D devm_clk_register(dev, &mux->hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	sp->output_clks[clk_index] =3D clk;
> +
> +	return 0;
> +}
> +
> +static int cdns_sierra_phy_register_pll_mux(struct cdns_sierra_phy *sp)
> +{
> +	struct regmap_field *pfdclk1_sel_field;
> +	struct regmap_field *plllc1en_field;
> +	struct regmap_field *termen_field;
> +	struct device *dev =3D sp->dev;
> +	int ret =3D 0, i, clk_index;
> +
> +	clk_index =3D CDNS_SIERRA_PLL_CMNLC;
> +	for (i =3D 0; i < SIERRA_NUM_CMN_PLLC; i++, clk_index++) {
> +		pfdclk1_sel_field =3D sp->cmn_plllc_pfdclk1_sel_preg[i];
> +		plllc1en_field =3D sp->cmn_refrcv_refclk_plllc1en_preg[i];
> +		termen_field =3D sp->cmn_refrcv_refclk_termen_preg[i];
> +
> +		ret =3D cdns_sierra_pll_mux_register(sp, pfdclk1_sel_field,
> plllc1en_field,
> +						   termen_field, clk_index);
> +		if (ret) {
> +			dev_err(dev, "Fail to register cmn plllc mux\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void cdns_sierra_clk_unregister(struct cdns_sierra_phy *sp)
> +{
> +	struct device *dev =3D sp->dev;
> +	struct device_node *node =3D dev->of_node;
> +
> +	of_clk_del_provider(node);
> +}
> +
> +static int cdns_sierra_clk_register(struct cdns_sierra_phy *sp)
> +{
> +	struct device *dev =3D sp->dev;
> +	struct device_node *node =3D dev->of_node;
> +	int ret;
> +
> +	ret =3D cdns_sierra_phy_register_pll_mux(sp);
> +	if (ret) {
> +		dev_err(dev, "Failed to pll mux clocks\n");
> +		return ret;
> +	}
> +
> +	sp->clk_data.clks =3D sp->output_clks;
> +	sp->clk_data.clk_num =3D CDNS_SIERRA_OUTPUT_CLOCKS;
> +	ret =3D of_clk_add_provider(node, of_clk_src_onecell_get, &sp-
> >clk_data);
> +	if (ret)
> +		dev_err(dev, "Failed to add clock provider: %s\n", node-
> >name);
> +
> +	return ret;
> +}
> +
>  static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
>  				    struct device_node *child)
>  {
> @@ -407,6 +618,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy
> *sp)
>  {
>  	struct device *dev =3D sp->dev;
>  	struct regmap_field *field;
> +	struct reg_field reg_field;
>  	struct regmap *regmap;
>  	int i;
>=20
> @@ -418,6 +630,32 @@ static int cdns_regfield_init(struct cdns_sierra_phy
> *sp)
>  	}
>  	sp->macro_id_type =3D field;
>=20
> +	for (i =3D 0; i < SIERRA_NUM_CMN_PLLC; i++) {
> +		reg_field =3D cmn_plllc_pfdclk1_sel_preg[i].pfdclk_sel_preg;
> +		field =3D devm_regmap_field_alloc(dev, regmap, reg_field);
> +		if (IS_ERR(field)) {
> +			dev_err(dev, "PLLLC%d_PFDCLK1_SEL failed\n", i);
> +			return PTR_ERR(field);
> +		}
> +		sp->cmn_plllc_pfdclk1_sel_preg[i] =3D field;
> +
> +		reg_field =3D cmn_plllc_pfdclk1_sel_preg[i].plllc1en_field;
> +		field =3D devm_regmap_field_alloc(dev, regmap, reg_field);
> +		if (IS_ERR(field)) {
> +			dev_err(dev, "REFRCV%d_REFCLK_PLLLC1EN failed\n",
> i);
> +			return PTR_ERR(field);
> +		}
> +		sp->cmn_refrcv_refclk_plllc1en_preg[i] =3D field;
> +
> +		reg_field =3D cmn_plllc_pfdclk1_sel_preg[i].termen_field;
> +		field =3D devm_regmap_field_alloc(dev, regmap, reg_field);
> +		if (IS_ERR(field)) {
> +			dev_err(dev, "REFRCV%d_REFCLK_TERMEN failed\n",
> i);
> +			return PTR_ERR(field);
> +		}
> +		sp->cmn_refrcv_refclk_termen_preg[i] =3D field;
> +	}
> +
>  	regmap =3D sp->regmap_phy_config_ctrl;
>  	field =3D devm_regmap_field_alloc(dev, regmap, phy_pll_cfg_1);
>  	if (IS_ERR(field)) {
> @@ -511,6 +749,22 @@ static int cdns_sierra_phy_get_clocks(struct
> cdns_sierra_phy *sp,
>  	}
>  	sp->input_clks[CMN_REFCLK1_DIG_DIV] =3D clk;
>=20
> +	clk =3D devm_clk_get_optional(dev, "pll0_refclk");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "pll0_refclk clock not found\n");
> +		ret =3D PTR_ERR(clk);
> +		return ret;
> +	}
> +	sp->input_clks[PLL0_REFCLK] =3D clk;
> +
> +	clk =3D devm_clk_get_optional(dev, "pll1_refclk");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "pll1_refclk clock not found\n");
> +		ret =3D PTR_ERR(clk);
> +		return ret;
> +	}
> +	sp->input_clks[PLL1_REFCLK] =3D clk;
> +
>  	return 0;
>  }
>=20
> @@ -586,13 +840,17 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D cdns_sierra_phy_get_resets(sp, dev);
> +	ret =3D cdns_sierra_clk_register(sp);
>  	if (ret)
>  		return ret;
>=20
> +	ret =3D cdns_sierra_phy_get_resets(sp, dev);
> +	if (ret)
> +		goto unregister_clk;
> +
>  	ret =3D clk_prepare_enable(sp->input_clks[PHY_CLK]);
>  	if (ret)
> -		return ret;
> +		goto unregister_clk;
>=20
>  	/* Enable APB */
>  	reset_control_deassert(sp->apb_rst);
> @@ -669,6 +927,8 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  clk_disable:
>  	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
>  	reset_control_assert(sp->apb_rst);
> +unregister_clk:
> +	cdns_sierra_clk_register(sp);

Should be cdns_sierra_clk_unregister(sp) ?

>  	return ret;
>  }
>=20
> @@ -691,6 +951,7 @@ static int cdns_sierra_phy_remove(struct
> platform_device *pdev)
>  	}
>=20
>  	clk_disable_unprepare(phy->input_clks[PHY_CLK]);
> +	cdns_sierra_clk_unregister(phy);
>=20
>  	return 0;
>  }
> --
> 2.17.1

Thanks & regards,
Swapnil
