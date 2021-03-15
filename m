Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F142933AB34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCOFoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:44:39 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:26266 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229644AbhCOFoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:44:23 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F5d0jg000547;
        Sun, 14 Mar 2021 22:44:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=EdGvYZAWkjD80msijK9sXtAQ60/v/GOHG2F4Qi/CQmg=;
 b=QvrSh+tsG8Gbm/kUp3UZ1qO9qhkFSVJMZ2TiADjQOW5LCf9PBLaHfO5JVeG3w2wV9pmi
 bSbdfHYrMJ4o906eGIfUNNwyT1t4MX/O0VKIbNeXQf+VAujR/uHZ3feWAZLAJ5qvZl8Q
 lrW6HHY3f73n3B7lTEmTy7Mbl0rO3a+xqZOb7JSAEUmRW2asJvYw6ZMwJDg5Qc1hYO8u
 fwzdd+uGaRJtj0Ubx8sf1/S/qoHqOVztWy/Scd4Wa6Vw8xEH8LlIP240ywaLItshSNWx
 +Xf5eNoqMw1FZ2j06cdsTe9mWWjWPMG5TOVKniAjXHUOMP9ywrMTIH6anJtY9aCnQklb qQ== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2cumt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 22:44:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z75iZV+nCguhYLrg12MD4dpFfSy5PovnBb09ECesmkxuJ0T9wJk+nWEaNMh8u9Od58nkftuRQw5g39C+zYPzPw//+Q6frzYkCfXsI/QWSkxL6E+fEYtFn9yAO21q0FGxFYiyuNbChjD2wn2BXSUHPBZ3nInygWmrAiw++7XQ93wpE2P4tzKIsXOGLveS7XJEFb/Gt49dvoso+U/aD+WXl+8ZqzAL5AxZSWvtiT/efyB2SA2rcgrW+7exuLEYEau9T4VRdPvZnLUVdIcdgiOnlv/CS1rUeKNhREKUJqLftL2SN1yBtRVKu7fk4CHRYsFEwoMp7rqULO7ALOpI9XZaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdGvYZAWkjD80msijK9sXtAQ60/v/GOHG2F4Qi/CQmg=;
 b=ce0oOSCtzVhAHJtbHYnBN+3zaweB9QH2JANON5FCI0+7/iap2U4i66d+IXemStBMIYQFkiPNjou/dHD8p/5RDRqzEfeIHjLt5AGm7wLXXlG0qmk5KZA2aNFlYzy6H3MKWN/GNphWn+TMzQa5EwOqezeZQVkiuExDZl71iWeNZf+/vKgQppusJSzr9mbRYQptINL+VQDyV4i6MyL4BUl6e9y/pBQuF32woeHIH4Sp8WsTfOgsqq4ObmbXMRc+U023VKD5AxALnvmLVT9zLdb2yV09SMVvsCCteChoelcOaiQSLC8utj/K/qtliUsbUWQ1TZX58+Meb+MDNZgFmRG3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdGvYZAWkjD80msijK9sXtAQ60/v/GOHG2F4Qi/CQmg=;
 b=Yr53XmV2b5UAa1qq0vYOL8Nkd9iaf1MHIG4N7TDlne3vNmddky3efCmN4BXTv0d9VaSm+GfnqTcSDP6Iyqzwn2wUokWbIoOj4YhTRDhZz+oT7LRUF5SYgMo/58iOV9AmBW1vb2zN202cdoTRF35/hhU8642cOhN3r3R9luyuVmY=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by MN2PR07MB6400.namprd07.prod.outlook.com (2603:10b6:208:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 05:44:07 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 05:44:07 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v3 6/6] phy: cadence-torrent: Add support to drive refclk
 out
Thread-Topic: [PATCH v3 6/6] phy: cadence-torrent: Add support to drive refclk
 out
Thread-Index: AQHXFaYs7WEgRRFHHkyCqf5z5Sn98Kp+4pag
Date:   Mon, 15 Mar 2021 05:44:07 +0000
Message-ID: <MN2PR07MB61600E34E02DFF458338CE5EC56C9@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210310120840.16447-1-kishon@ti.com>
 <20210310120840.16447-7-kishon@ti.com>
In-Reply-To: <20210310120840.16447-7-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03MjVmN2ZhMi04NTUxLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcNzI1ZjdmYTMtODU1MS0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIxMTQwOCIgdD0iMTMyNjAyNjA2NDMzMzk2MTkzIiBoPSJoNHlmdG5tY0c0Z3E4THN0MkxWMUwvSEdYZWc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3545cca6-cbe0-4bf1-de09-08d8e77559a4
x-ms-traffictypediagnostic: MN2PR07MB6400:
x-microsoft-antispam-prvs: <MN2PR07MB640026B629A278D7E87464FEC56C9@MN2PR07MB6400.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V15f6bTROCZtx1PjXIMrB/hSbXnN6RiixQHYcDnxlykv3t33c+bJxDNiKVmOU6zWNMbqD4RjO9Y6/lbuwmknJ95ctjOj1CGETb1ZBYEVmIiObN5keOUBrm7PZjC6iZgz451cls4usw7K02oQMyEdzJzQt4DshxE2xPZo0peoB6j8rwDDJb5lFqK1jMH5JwLaLXzScKcS68PWMLAZt+KEaoe5tRuRw63plO3rqoL8k47bQ5Rv1igdqQlHHQALKrPuO1o0mSP9P4vIoHe0DGm/6qwd5YwljNb896vuP/0mX+wgT+n+QdJa209gWPxBPUCZmJza6ASf93Nw8whRafLsGrVSrXhm9c4xX+kPXsiVVLKdauR9AZ2C5bfLjae2B5i9ULj7S89atPJBOfm5SIm3ADi5sSHLNgIg6pQo2smCMbZVACg/QKmjvHn4zXHqJ81UZ7C4pWwlE27CngbNg30tUsBhB7XKO0i9HfDH+VmaxnQ6/PD4Ah1qSlUbfLjqNof96WqbNwfzyPRwJEW2zfcqFl0ok8mx9p1Dr8jp1MXGaDjOatYZceEoYJhpNPdwhOydOkSjRnuSwutbGWheTi/NeyDm2vvVUs7Da4i8KymcVVviqzYm70PxzCnNdRLBglWz4MD6grj5kg8XDTMK7IH47Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(36092001)(26005)(9686003)(55016002)(186003)(8936002)(86362001)(2906002)(33656002)(83380400001)(478600001)(8676002)(54906003)(52536014)(4326008)(71200400001)(316002)(66476007)(110136005)(76116006)(66446008)(30864003)(5660300002)(6506007)(53546011)(64756008)(66556008)(7696005)(66946007)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XJOfWIsAolUdDuNtUCTRs+m7FvPIEj3ME8KHMRYGPEOQW/McgXsd9NG/obXW?=
 =?us-ascii?Q?Kptt/vTsL8T1E6H09wzI1WDvNJkduuqESmQ+wvhgiTJGm3IxtQdkHXpEJ6gT?=
 =?us-ascii?Q?TisNk+ApNWLCwjCcPmI+ZDoFqMxZyht4wo8w0e7JUqoi6P/tuh8//l9jos8r?=
 =?us-ascii?Q?P5w94bvdF0t77IGan1rRdtBX4mziHZBt3uRVRTD946dOAd0aMC1RMegQQK0Z?=
 =?us-ascii?Q?RQd9+qxLabqMzqvgrm2dv4VZKaz5Qq2YG84/xsoVzFZIjo01p3tQ9jmeuT9F?=
 =?us-ascii?Q?dR/pI9AhmVySuPwrM6q7Rg+ZKrVSIPrxMl80nxb9oHl7+qTI6XK1sHrj3HDB?=
 =?us-ascii?Q?oncE8reegMsvtVFB2hVAFZbiJ0O3naTMXEvESBK52V8Arobkh6tI7MfADbzL?=
 =?us-ascii?Q?C/xFPlYLo9YnH7lELzp3W0TOcAWdn0SHOYOjFm0mWTaKXaojbA5IrpT3m33R?=
 =?us-ascii?Q?OpHCfeXOJf6OJiZ8Haqj1hfe3563K3GfGfsMvVy8Obu+3sHph3RRgudZBNbA?=
 =?us-ascii?Q?q+k8FYRdhfciANPfnv3Ee7mah2fYuxVnJo26YGtiO8QpX+K3rA5j+2xjMCys?=
 =?us-ascii?Q?PW9Nht1N69GhmBGw+lgHBFsNfUewR6NMqGvDafU9m9UO4W9FD6DSo+6pK+y2?=
 =?us-ascii?Q?V3QUqFIzuffheW19S9aiT9j1fH1wyfP31B8mk1Rm05175AOloChyGASpE/v2?=
 =?us-ascii?Q?jvkWKUGX6eGjCF1Yf45B2bGtT9PuJ45aSx1Y/FbNRSZC+tnXyKmyYNAmKurr?=
 =?us-ascii?Q?/1/Ds1gOcrMN21GSFoViQ5U92OxY7O7y0H2ha1Hrt8WnoaCXaVaEWEVAo7+7?=
 =?us-ascii?Q?kGZLi1AEOmr3A20Bw+jXSBvzWZI6G7+RrslYGCCMhvRqeaIiqUjcQ7/Bfl2Q?=
 =?us-ascii?Q?MKKqSH9b9RgB2hIJW5XIqp6wF1BVHYeNU5eewthdMxZEvqW12X0m1J08LaD6?=
 =?us-ascii?Q?2bXQCdKUj//trrfYDsj56ENykX/Los4llqjzAUu9kQpBbY1j/ElBs/t6UN6T?=
 =?us-ascii?Q?raWy6/wp0WMpKfT78mQNkbu2LrY3vsRd07H/h2X3e5ap++puJms/CP7OI4Z1?=
 =?us-ascii?Q?H8xyEjcXaae4X1nn8xRecOAd9/oAI7pnLCehGqastFJaJiF8CA27bhvroTcs?=
 =?us-ascii?Q?zMeyYNSLOe5aMkookiAiN8Bh/qnzs0jsSEAGxqypf5JmWyuijM1SSWrFfe3w?=
 =?us-ascii?Q?XJr1snIlcHF3tCNPx8Dw4UbWJowq5f12fdEiDzmYAbD66/khE2bN+Tno52KV?=
 =?us-ascii?Q?p3v682E0mra2br+cCpLvOV5P+BP3chgPor/Qh/xnfV90kyXJnaFyj2jiltwL?=
 =?us-ascii?Q?hpF4HMBueierKCZG0R8Sx7vA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3545cca6-cbe0-4bf1-de09-08d8e77559a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 05:44:07.3402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOK1+DWln4ggbaFZM2K0RIWaHB3jIpUD5FRfcn7e6KAH5KjVzF00F2jIahmfonuWDKkPVkzDxkgJ76baO6QwlgRA3yzxO9i7+bApncbNWY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6400
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: Wednesday, March 10, 2021 5:39 PM
> To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul
> <vkoul@kernel.org>; Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> Cc: linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; Lokesh
> Vutla <lokeshvutla@ti.com>
> Subject: [PATCH v3 6/6] phy: cadence-torrent: Add support to drive refclk=
 out
>=20
> EXTERNAL MAIL
>=20
>=20
> cmn_refclk_<p/m> lines in Torrent SERDES is used for connecting external
> reference clock. cmn_refclk_<p/m> can also be configured to output the
> reference clock. Model this derived reference clock as a "clock" so that
> platforms like AM642 EVM can enable it.
>=20
> This is used by PCIe to use the same refclk both in local SERDES
> and remote device. Add support here to drive refclk out.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/Kconfig               |   1 +
>  drivers/phy/cadence/phy-cadence-torrent.c | 188 +++++++++++++++++++++-
>  2 files changed, 186 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>

Thanks & regards,
Swapnil

> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> index 432832bdbd16..27e9d6c377e5 100644
> --- a/drivers/phy/cadence/Kconfig
> +++ b/drivers/phy/cadence/Kconfig
> @@ -7,6 +7,7 @@ config PHY_CADENCE_TORRENT
>  	tristate "Cadence Torrent PHY driver"
>  	depends on OF
>  	depends on HAS_IOMEM
> +	depends on COMMON_CLK
>  	select GENERIC_PHY
>  	help
>  	  Support for Cadence Torrent PHY.
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> b/drivers/phy/cadence/phy-cadence-torrent.c
> index 591a15834b48..c6fee7f75f57 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -7,7 +7,9 @@
>   */
>=20
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-cadence-torrent.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -84,6 +86,8 @@
>  #define CMN_PLLSM1_PLLLOCK_TMR		0x0034U
>  #define CMN_CDIAG_CDB_PWRI_OVRD		0x0041U
>  #define CMN_CDIAG_XCVRC_PWRI_OVRD	0x0047U
> +#define CMN_CDIAG_REFCLK_OVRD		0x004CU
> +#define CMN_CDIAG_REFCLK_DRV0_CTRL	0x0050U
>  #define CMN_BGCAL_INIT_TMR		0x0064U
>  #define CMN_BGCAL_ITER_TMR		0x0065U
>  #define CMN_IBCAL_INIT_TMR		0x0074U
> @@ -206,6 +210,7 @@
>  #define RX_DIAG_ACYA			0x01FFU
>=20
>  /* PHY PCS common registers */
> +#define PHY_PIPE_CMN_CTRL1		0x0000U
>  #define PHY_PLL_CFG			0x000EU
>  #define PHY_PIPE_USB3_GEN2_PRE_CFG0	0x0020U
>  #define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
> @@ -216,6 +221,10 @@
>  #define PHY_PMA_CMN_CTRL2		0x0001U
>  #define PHY_PMA_PLL_RAW_CTRL		0x0003U
>=20
> +static const char * const clk_names[] =3D {
> +	[CDNS_TORRENT_REFCLK_DRIVER] =3D "refclk-driver",
> +};
> +
>  static const struct reg_field phy_pll_cfg =3D
>  				REG_FIELD(PHY_PLL_CFG, 0, 1);
>=20
> @@ -231,6 +240,26 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
=3D
>  static const struct reg_field phy_reset_ctrl =3D
>  				REG_FIELD(PHY_RESET, 8, 8);
>=20
> +static const struct reg_field phy_pipe_cmn_ctrl1_0 =3D
> REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0);
> +
> +#define REFCLK_OUT_NUM_CMN_CONFIG	5
> +
> +enum cdns_torrent_refclk_out_cmn {
> +	CMN_CDIAG_REFCLK_OVRD_4,
> +	CMN_CDIAG_REFCLK_DRV0_CTRL_1,
> +	CMN_CDIAG_REFCLK_DRV0_CTRL_4,
> +	CMN_CDIAG_REFCLK_DRV0_CTRL_5,
> +	CMN_CDIAG_REFCLK_DRV0_CTRL_6,
> +};
> +
> +static const struct reg_field refclk_out_cmn_cfg[] =3D {
> +	[CMN_CDIAG_REFCLK_OVRD_4]	=3D
> REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4),
> +	[CMN_CDIAG_REFCLK_DRV0_CTRL_1]	=3D
> REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 1, 1),
> +	[CMN_CDIAG_REFCLK_DRV0_CTRL_4]	=3D
> REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 4, 4),
> +	[CMN_CDIAG_REFCLK_DRV0_CTRL_5]  =3D
> REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 5, 5),
> +	[CMN_CDIAG_REFCLK_DRV0_CTRL_6]	=3D
> REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 6, 6),
> +};
> +
>  enum cdns_torrent_phy_type {
>  	TYPE_NONE,
>  	TYPE_DP,
> @@ -279,6 +308,8 @@ struct cdns_torrent_phy {
>  	struct regmap_field *phy_pma_cmn_ctrl_2;
>  	struct regmap_field *phy_pma_pll_raw_ctrl;
>  	struct regmap_field *phy_reset_ctrl;
> +	struct clk *clks[CDNS_TORRENT_REFCLK_DRIVER + 1];
> +	struct clk_onecell_data clk_data;
>  };
>=20
>  enum phy_powerstate {
> @@ -288,6 +319,16 @@ enum phy_powerstate {
>  	POWERSTATE_A3 =3D 3,
>  };
>=20
> +struct cdns_torrent_derived_refclk {
> +	struct clk_hw		hw;
> +	struct regmap_field	*phy_pipe_cmn_ctrl1_0;
> +	struct regmap_field
> 	*cmn_fields[REFCLK_OUT_NUM_CMN_CONFIG];
> +	struct clk_init_data	clk_data;
> +};
> +
> +#define to_cdns_torrent_derived_refclk(_hw)	\
> +			container_of(_hw, struct
> cdns_torrent_derived_refclk, hw)
> +
>  static int cdns_torrent_phy_init(struct phy *phy);
>  static int cdns_torrent_dp_init(struct phy *phy);
>  static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
> @@ -1604,6 +1645,108 @@ static int cdns_torrent_dp_run(struct
> cdns_torrent_phy *cdns_phy, u32 num_lanes)
>  	return ret;
>  }
>=20
> +static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
> +{
> +	struct cdns_torrent_derived_refclk *derived_refclk =3D
> to_cdns_torrent_derived_refclk(hw);
> +
> +	regmap_field_write(derived_refclk-
> >cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_6], 0);
> +	regmap_field_write(derived_refclk-
> >cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
> +	regmap_field_write(derived_refclk-
> >cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_5], 1);
> +	regmap_field_write(derived_refclk-
> >cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 0);
> +	regmap_field_write(derived_refclk-
> >cmn_fields[CMN_CDIAG_REFCLK_OVRD_4], 1);
> +	regmap_field_write(derived_refclk->phy_pipe_cmn_ctrl1_0, 1);
> +
> +	return 0;
> +}
> +
> +static void cdns_torrent_derived_refclk_disable(struct clk_hw *hw)
> +{
> +	struct cdns_torrent_derived_refclk *derived_refclk =3D
> to_cdns_torrent_derived_refclk(hw);
> +
> +	regmap_field_write(derived_refclk->phy_pipe_cmn_ctrl1_0, 0);
> +}
> +
> +static int cdns_torrent_derived_refclk_is_enabled(struct clk_hw *hw)
> +{
> +	struct cdns_torrent_derived_refclk *derived_refclk =3D
> to_cdns_torrent_derived_refclk(hw);
> +	int val;
> +
> +	regmap_field_read(derived_refclk->phy_pipe_cmn_ctrl1_0, &val);
> +
> +	return !!val;
> +}
> +
> +static const struct clk_ops cdns_torrent_derived_refclk_ops =3D {
> +	.enable =3D cdns_torrent_derived_refclk_enable,
> +	.disable =3D cdns_torrent_derived_refclk_disable,
> +	.is_enabled =3D cdns_torrent_derived_refclk_is_enabled,
> +};
> +
> +static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy
> *cdns_phy)
> +{
> +	struct cdns_torrent_derived_refclk *derived_refclk;
> +	struct device *dev =3D cdns_phy->dev;
> +	struct regmap_field *field;
> +	struct clk_init_data *init;
> +	const char *parent_name;
> +	struct regmap *regmap;
> +	char clk_name[100];
> +	struct clk *clk;
> +	int i;
> +
> +	derived_refclk =3D devm_kzalloc(dev, sizeof(*derived_refclk),
> GFP_KERNEL);
> +	if (!derived_refclk)
> +		return -ENOMEM;
> +
> +	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
> +		 clk_names[CDNS_TORRENT_REFCLK_DRIVER]);
> +
> +	clk =3D devm_clk_get_optional(dev, "phy_en_refclk");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "No parent clock for derived_refclk\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	init =3D &derived_refclk->clk_data;
> +
> +	if (clk) {
> +		parent_name =3D __clk_get_name(clk);
> +		init->parent_names =3D &parent_name;
> +		init->num_parents =3D 1;
> +	}
> +	init->ops =3D &cdns_torrent_derived_refclk_ops;
> +	init->flags =3D 0;
> +	init->name =3D clk_name;
> +
> +	regmap =3D cdns_phy->regmap_phy_pcs_common_cdb;
> +	field =3D devm_regmap_field_alloc(dev, regmap,
> phy_pipe_cmn_ctrl1_0);
> +	if (IS_ERR(field)) {
> +		dev_err(dev, "phy_pipe_cmn_ctrl1_0 reg field init failed\n");
> +		return PTR_ERR(field);
> +	}
> +	derived_refclk->phy_pipe_cmn_ctrl1_0 =3D field;
> +
> +	regmap =3D cdns_phy->regmap_common_cdb;
> +	for (i =3D 0; i < REFCLK_OUT_NUM_CMN_CONFIG; i++) {
> +		field =3D devm_regmap_field_alloc(dev, regmap,
> refclk_out_cmn_cfg[i]);
> +		if (IS_ERR(field)) {
> +			dev_err(dev, "CMN reg field init failed\n");
> +			return PTR_ERR(field);
> +		}
> +		derived_refclk->cmn_fields[i] =3D field;
> +	}
> +
> +	derived_refclk->hw.init =3D init;
> +
> +	clk =3D devm_clk_register(dev, &derived_refclk->hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	cdns_phy->clks[CDNS_TORRENT_REFCLK_DRIVER] =3D clk;
> +
> +	return 0;
> +}
> +
>  static int cdns_torrent_phy_on(struct phy *phy)
>  {
>  	struct cdns_torrent_inst *inst =3D phy_get_drvdata(phy);
> @@ -2071,6 +2214,37 @@ int cdns_torrent_phy_configure_multilink(struct
> cdns_torrent_phy *cdns_phy)
>  	return 0;
>  }
>=20
> +static void cdns_torrent_clk_cleanup(struct cdns_torrent_phy *cdns_phy)
> +{
> +	struct device *dev =3D cdns_phy->dev;
> +
> +	of_clk_del_provider(dev->of_node);
> +}
> +
> +static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
> +{
> +	struct device *dev =3D cdns_phy->dev;
> +	struct device_node *node =3D dev->of_node;
> +	int ret;
> +
> +	ret =3D cdns_torrent_derived_refclk_register(cdns_phy);
> +	if (ret) {
> +		dev_err(dev, "failed to register derived refclk\n");
> +		return ret;
> +	}
> +
> +	cdns_phy->clk_data.clks =3D cdns_phy->clks;
> +	cdns_phy->clk_data.clk_num =3D CDNS_TORRENT_REFCLK_DRIVER + 1;
> +
> +	ret =3D of_clk_add_provider(node, of_clk_src_onecell_get, &cdns_phy-
> >clk_data);
> +	if (ret) {
> +		dev_err(dev, "Failed to add clock provider: %s\n", node-
> >name);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  {
>  	struct cdns_torrent_phy *cdns_phy;
> @@ -2134,17 +2308,21 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		return ret;
>=20
> +	ret =3D cdns_torrent_clk_register(cdns_phy);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D clk_prepare_enable(cdns_phy->clk);
>  	if (ret) {
>  		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
> -		return ret;
> +		goto clk_cleanup;
>  	}
>=20
>  	cdns_phy->ref_clk_rate =3D clk_get_rate(cdns_phy->clk);
>  	if (!(cdns_phy->ref_clk_rate)) {
>  		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
> -		clk_disable_unprepare(cdns_phy->clk);
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto clk_disable;
>  	}
>=20
>  	/* Enable APB */
> @@ -2323,7 +2501,10 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  		reset_control_put(cdns_phy->phys[i].lnk_rst);
>  	of_node_put(child);
>  	reset_control_assert(cdns_phy->apb_rst);
> +clk_disable:
>  	clk_disable_unprepare(cdns_phy->clk);
> +clk_cleanup:
> +	cdns_torrent_clk_cleanup(cdns_phy);
>  	return ret;
>  }
>=20
> @@ -2340,6 +2521,7 @@ static int cdns_torrent_phy_remove(struct
> platform_device *pdev)
>  	}
>=20
>  	clk_disable_unprepare(cdns_phy->clk);
> +	cdns_torrent_clk_cleanup(cdns_phy);
>=20
>  	return 0;
>  }
> --
> 2.17.1

