Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1080833AB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhCOFyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:54:52 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:36524 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229929AbhCOFyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:54:20 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F5mstA018370;
        Sun, 14 Mar 2021 22:54:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=NgHrTtgRAlb8m3SyMTtxT073qkRlyQTzFB4hLpFUMXg=;
 b=fadl+N4HSdNon+4zlegt1lCdvWiyBpV9vWByi4p/ycTpgwRODJNyzORaBbZWTWWO5fSc
 PKzTismojbN7TEDqKUbUhrDfcRhKEqhH2Day+IsCKjG/pzaAY+AMVtUWRr4fNZ0XN/P0
 ZYzTyEhvT/Rh1OjHTjBkxWAOGiTyMNYlLh0J7LpkHTMIMi7Pg9v3Os6CgzmzSUOhRcZX
 NAZgg9U26fu2+Pz4p/g3C3/CzJCXqZpWwzToTghqbqjI08dL3CPpBA2TwvGY3QPtMGQP
 bTQ5z6OGcEkIGqYdtGxqn/yaj9gmy2C/tcvZJeEh7NAiGKm1MCQNxx4ixWm06LJGiIa0 cw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2cv9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 22:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnAEkoxSp3Ft/guZjk3uKdaF1pat1bhUV63vyvylFVObVBpw7244NK97HMtl9HGDWaOQL33JlWdmuZhBhdJA1osXM64SILOKQzqnmxfJUh6Tc/hjSiSVGkQm9UsvTmcUObOZevy+Jl5iwihj440tHgJP2JH40l8tbHCDW+vclTtKLeDmXfKCsO2wCHBY+ehc0KYpr0G3toggVDC3/M+jn0zZ4AxYIzO3Owde4tRzaH+dO2Qfza5mhhhdlkKzXN4tjk0TxvE8qErjPSByIgv4nTCkbF9bKb6siKRfu60Au8Ft5qI80e13ZGpZ8wRRqY9g4TEsMQs2/5BxI6XEWa3g0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgHrTtgRAlb8m3SyMTtxT073qkRlyQTzFB4hLpFUMXg=;
 b=Scd6N31hDrsCcOtOQfTMDCC4PwQj5feGF9Y9P10n14qcgOIbHGUdegRTFUh/bldWI50HDJgyZQR6idmAFZO8rGiAZm4PLprL9ztYuk4gvTG9z/KNks9uVcik+S0UkXWtt8C3Qkm4kvV2GY/KGyzjMT+yi5iUYL+ShIMOcCWGlHw5w87mop8gZrwK1YQc5TYlj3hRZcHEBANsq9fZhXPTVvy/y+YGG9ninIydfLXJZLaAB2iHpQTUwHgaklGRUaaZAu/YQnzubWVUQmGQicT0ucDMu+76Z3EKycC976rSrz8+PPTenqafg3lK85iBz5VgyQHvThfal0GU7WkoZxyzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgHrTtgRAlb8m3SyMTtxT073qkRlyQTzFB4hLpFUMXg=;
 b=z1edzLpIyr+cRajZKgry2LfUc8YH5CRcNnaxgn6b57q0C1/rZFaCdACc8BYke7fjySg5681RCkpajNX6EplrFi7PrRgtRDYiVtU+SuWL4/wwA/q171Ta+iMVKps5+NdfR6st62BJTCV6cz+irgdWsWr7maND4ayg4U90m1E75o4=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by MN2PR07MB5822.namprd07.prod.outlook.com (2603:10b6:208:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 05:54:12 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 05:54:12 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v6 13/13] phy: cadence: sierra: Enable pll_cmnlc and
 pll_cmnlc1 clocks
Thread-Topic: [PATCH v6 13/13] phy: cadence: sierra: Enable pll_cmnlc and
 pll_cmnlc1 clocks
Thread-Index: AQHXFcSVq1m5vZ+OQ0aPYw9mcJB/eKqADp0Q
Date:   Mon, 15 Mar 2021 05:54:11 +0000
Message-ID: <MN2PR07MB6160488C3F8A38E7FBCF98FDC56C9@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210310154558.32078-1-kishon@ti.com>
 <20210310154558.32078-14-kishon@ti.com>
In-Reply-To: <20210310154558.32078-14-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kYjQ4MGFlZS04NTUyLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcZGI0ODBhZWYtODU1Mi0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIzNzg4IiB0PSIxMzI2MDI2MTI0ODgwMDY0NDkiIGg9Ikp0REs0N3B4cFFlcWdzVW5RZnlUaGZmbHFZND0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ef4c32d-d58f-4758-8541-08d8e776c213
x-ms-traffictypediagnostic: MN2PR07MB5822:
x-microsoft-antispam-prvs: <MN2PR07MB5822389A77497419C7DE704FC56C9@MN2PR07MB5822.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3TN64nyRHrVHZcUTToexUeaHsKU0QEYsa/tLnU1ide2I6Y84YAqfXi12v4kGboE4hz0ug/PHB7Wo8xaKe5iRHs1KuqAN/wh9i6o8ioa9XopIA/iosc4D4/e5Kl8l7nooOo6ldsSl2why1irkHkhB6bIS9YY//thD0l9lIDNe6MbTfaUfHF8LsG8hIwtjvK9x0+Pj/gHs+DujBt/14hAwegb1xb/WOcXESwNlbZ8xFiEmRSSGNrbHw88A1hHu2Gn08/T6gc1HjvGz3lU2UsFDWZ9Uoq1D/n0U+gaAo6wtyisVxk/PODrzgY0ZChaYE68b1CaY3FknYfFDYlmHdCQkwM9VWF31nU4vEb8KhWmX18Jrdwl5S2QsQEKC7J+aiv9v0hpbWmNVV35Ha0D+6yuFlstkTJS4n/5yDoF8+/ElxfsPDbVGMi85BZD21Q5/yaAkyjN9Yq6QwFWuZooXFbqMkSiNYXYHhYGGuPQdTr8/0mhwsVAXfypECiKQi8OUpQdLPjGvdYmU+3dskXAn0VCfgHCp+coFeEM8yAiWHMWIfClmDzSKlmtVkqGkinnncEGVE/k3AFrQY02BzNjgZDSuW8S3jDe5nzRu9P4eH3mNxWE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(36092001)(26005)(9686003)(53546011)(33656002)(54906003)(186003)(8936002)(66556008)(55016002)(478600001)(66946007)(76116006)(110136005)(66476007)(64756008)(86362001)(66446008)(7696005)(6506007)(52536014)(83380400001)(316002)(5660300002)(8676002)(4326008)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hfbycIu6Mf+pXQEyM+lUnT/LjYT54sjKPIPrtjlyZYH/ZINcEiJLakvwsFej?=
 =?us-ascii?Q?SPRb9Uv6O8pI5PZnGOlg6wUR10zBHPbePkRZ9Xn+WezO/MB/ap7VMM8lWtd8?=
 =?us-ascii?Q?P65R/fDX2fr+SUSkO2vgn87qOFNjYkcdV+nI4FsJlyj4b+z9yIZ0deuCEkg7?=
 =?us-ascii?Q?vg+39HpTwcwAJvstAMrTnzbAsiwX382NZ/y4aZwNYBIqzIUDeFutTBq9cARm?=
 =?us-ascii?Q?DAjO2yM4fjY/RYW8IeVaRdJTuj5iDGRUFybGeb1V/8d360AgZn8ffVvM4aMH?=
 =?us-ascii?Q?HDaDYn19GTbHJmozcD+sjPwmg+SPEBvcDb4Ve1t8Pfuxptif44/U7PnK6IWF?=
 =?us-ascii?Q?BiXHP69qyOcmr5MI0BrDGcHLr9PvM5uLmOwwiTEtigg5Tb9xtgeXHf397E2J?=
 =?us-ascii?Q?MWUZNi6FAmYkoQlSASmM6MpzRd/Jsu5aFq/u4S1nlq6QEGTtBT+K/IWqIcqR?=
 =?us-ascii?Q?In4LBWJpoUPrOIq/i36al9u92+mvn+WH/jHJAUYvuVLORRjCIG8+xhgaOZwD?=
 =?us-ascii?Q?G2VQFm1acf7EIeJl4Ao7xmmtAFE1uxhr6LYyFLb6eP3+IWu4Kxu5WwGiGf79?=
 =?us-ascii?Q?Vy1lQotUxANwkFR6dZzeyNj4wk7O/46jYBox6O1SVa9OrsrD77+zQ+q5a60N?=
 =?us-ascii?Q?l5KMc9Ler2psnP4sjVAfX38l/pBE801SezWODPMXsGSMycrUzr0W32/NzI6g?=
 =?us-ascii?Q?NuB1VsKgwYsOkVjyAywCGakCqqEDd9nlrV2y2VSYPm+2gviNwPrw70BK5EZH?=
 =?us-ascii?Q?ImHiMUOhj64EDLLatqfgri1hstutFun2eRdOt5RCyKggovEVGZo76DWn+V09?=
 =?us-ascii?Q?m4anHdhbLUSJFZIp6HkYIInCIRA/qqp3z/TVQURS08r2t+6/EtoYelsIv0V2?=
 =?us-ascii?Q?6R3fT8J4QnM4XO3ipo59B6aHRY+k8ZSBHuy86A/DPLqU6V+euzSh6UxVbnmb?=
 =?us-ascii?Q?6fRz8M5816TMhke3pNNg9Yjm1e4g72+PcebSnMkNrtzlu8kPnmx+z+6i6nLM?=
 =?us-ascii?Q?PpkJlXx0aPXg5EAaRLgCXV7AoSke1h9n+Cmib3xKdbbYnf8YY1y+k0lsrRpz?=
 =?us-ascii?Q?7+DAXVqPNbJZI/x2dUZlu4+Z17Ly54Xik7f77xf8ToL5EytZk5HGFQjIIO/G?=
 =?us-ascii?Q?hV2aMsuo2uBJomNQGGId3oJ4UfbvaqDAcS8oQpvoTbK8r8IHfGnDa9LqkOqv?=
 =?us-ascii?Q?Q8pOz9BvBHmq4iPSZodgaCyD6iEGfM7eOCpRsgzQo9VWqYLY7DCCF2zMJE5D?=
 =?us-ascii?Q?q8UB3ReGAgPsMKf+D5FWojSyhCnctHdmU7NW510OiNKSdBsSAMrI1XYv8b/Q?=
 =?us-ascii?Q?vJEVu2t9NbpiP0fjvQ5YOxpf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef4c32d-d58f-4758-8541-08d8e776c213
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 05:54:11.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MfkpqUs265gR0IcnY7DupN0U8hu2Z8CCNAUHgBtBdTk6/a+GKauk5C2zEsWy49nWZwcJTE+iz9mbyGXFLE0JRuPpP9lf8rQZi5t6o57Htw=
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
> Subject: [PATCH v6 13/13] phy: cadence: sierra: Enable pll_cmnlc and
> pll_cmnlc1 clocks
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

Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>

Thanks & regards,
Swapnil

> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> b/drivers/phy/cadence/phy-cadence-sierra.c
> index 039ca10db59d..5c68e31c5939 100644
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
> +	ret =3D clk_prepare_enable(sp->input_clks[PHY_CLK]);
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
> +err_pll_cmnlc1:
> +	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
> +
> +err_pll_cmnlc:
> +	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
> +
> +	return ret;
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
>  	cdns_sierra_clk_unregister(sp);
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

