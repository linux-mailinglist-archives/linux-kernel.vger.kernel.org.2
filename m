Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A28C340289
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCRJ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:56:19 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34038 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhCRJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:56:12 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I9gwvZ025724;
        Thu, 18 Mar 2021 02:55:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=0tQAs/MLk851oqxaIADCckHst7p96Z4I2yzdjEcKoM0=;
 b=TPJpo5KUFMMocXfcW7dPgoDFHbTs7jSeLRh+OPi5ZE6lle14Ss2jTsQmBX0MrXh1jLsW
 f/Y4bqtlVP7iVhMbbVeXtxaGcBXl5eyXUcP32ZxCN1NGk60mctUcIyapY9iibV8KqTCq
 HBcrQ76xrxrxZz5F4dB3nvoCUC1KYqAkYnqVl36YksSr85pQzgtI3JROak9w/XPMO5tW
 j3mMlhyM+Nb2PUTZeVnzO/9iZx1RllgLVnaNMRbcPQoxjBsLt3RKzOOLq7Jc2m66HfFH
 qlG83WXs/H/NJV1zAL2yzRC1AKsxKF1HIEDcFKecuvzbgj9W3S17uXp35DgUxcCRnc6F ig== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 378tu28jud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 02:55:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6wGvzXTjor/JmLsbhYTAKYY5ACBuWSfkC/MLWUy5RJbglNVvh5cLTw6rL69/hzJgNWl5YeDljA6i7WQgNa0245xP3WDCCbOLvz1P2U4yHiDWwf6kje5RkcWuYTpDNuuOtjKbpYKIdQ060sHA+Niqz/y1nGOgYLdng4GfLB+KJKpz2LTPUTr68qf0TkqasBul8sUVcsSrSd/89wymJjkCMdfgkfcprPBgU8s9lFKuEiXkqFcp1fifycE2StsFjZsxAO6jzCJ+AYDNqAwSxsSCuLjpsShuyCLdrDiEPAcjyQARXwCYbJRy74fic5WCFPFDxp3W6JFZaY789I4QSYeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tQAs/MLk851oqxaIADCckHst7p96Z4I2yzdjEcKoM0=;
 b=OXFQDB4Jegs3tSovEcQHyAH8S8cD3B+PXDhFFp24WX9Ul4fGAGdeuRTPezPAVwjZVj9pqSrFb60pOiuTiXDD9kq4MEDD2gF4vnyI5pjeya4iL8JXmTY3wFjitVnpzRbCkeEoHIEoL+SnCNl8SZPBMvWrKUEwUZkkt+f/Ji9KMR4NbunLhdzWgfO3pdib4buapHnipEPbdRw6Y2t4pwU7wAbdQtOODl+B+Pimd9iJzW6h1Gk6nrevDPHUvuiIuIYvINrBBarMvSzcro4eFlUVTqv6G1S8wmZs5U0ky6qxJ/C4U1DkkbqEuoxi5M3mwOCc6XD5Bxp20kVIRuRG3aohbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tQAs/MLk851oqxaIADCckHst7p96Z4I2yzdjEcKoM0=;
 b=cnJSZE6p/JLkmLHnr3YV6HNIIlRA1d+j6QKJG3BVmO0VtU4qVXwAJovdVYoCnN4B6aDjQHH16a3IBFBpNXwRYvE4S31ZUEekItJjt2vxBblS2JlZ0DzBMCHziQju4GAPB0CD1KkGqstO0T8xwH7cMwwcQmFwOd+RIabF0SNcg20=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by BLAPR07MB8308.namprd07.prod.outlook.com (2603:10b6:208:330::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 09:55:48 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::31af:9129:7ae4:1fb7]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::31af:9129:7ae4:1fb7%5]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 09:55:48 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: RE: [PATCH 3/4] phy: cadence-torrent: Do not configure SERDES if it's
 already configured
Thread-Topic: [PATCH 3/4] phy: cadence-torrent: Do not configure SERDES if
 it's already configured
Thread-Index: AQHXFcXDXhvlnInh4kas5cMWKRp1eqqJjBRw
Date:   Thu, 18 Mar 2021 09:55:47 +0000
Message-ID: <MN2PR07MB61607501847D2DD1C62A84F0C5699@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210310155445.534-1-kishon@ti.com>
 <20210310155445.534-4-kishon@ti.com>
In-Reply-To: <20210310155445.534-4-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xYWYzM2NhZC04N2QwLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcMWFmMzNjYWUtODdkMC0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIzNTkzIiB0PSIxMzI2MDUzNDk0NTA0NTY1OTUiIGg9IjN2c2tpVG15YnJXazd2ZTIyaWZUSjh1TkFxQT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2db9d275-212f-4db2-0af3-08d8e9f40190
x-ms-traffictypediagnostic: BLAPR07MB8308:
x-microsoft-antispam-prvs: <BLAPR07MB83086F4793880E53EFDF94C1C5699@BLAPR07MB8308.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:409;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERddcAt6+6wlPRxf5BJA4MKtiaiqCj9VaWTXP3TtQ+giqcF8HlG8FnCse4ZiZPUMApseEpsec62UzG5fVHavLP3X1IFX8c7b5BMaXAxqww/Cjy/Lur2BysbJOdq7a9Cq1XXlJ8lSGVYuiVJON40WyMqHLp9ZZ9NcWZdaddmF9wwtJ/sfs9U00P+IO6tQp0eNmT+QXkGMwyHpUC4ex+al68ALIFyL66DbwOivGpK0nms3Kff1hF2sJzG68yXhLEPADe/Gw/qji/Mul0H1ymdKsX3hwyuaDdixFAWXK4xQOVqg9+KioS/3eC+rmrR1RfT7SzwUQbmQW5GxhkUjQxcVkakBMa1I8Z9B8EA2klkOgT20DXtycrTMr65n3jJ59L2A1jtCH068vTSTLi/dfqbDpcgDGRoRq3OhC4/H8GSrIB+Lte1x04qGSLT8PkEfLs7MaQCfnh6/62YGT6px69J6lNamRWJS+gNsBlyQORUPBVxWSZQolMexp+cu9pkW9Dae8wi6+Fv1aBVFsIbxkA5PsPAgYXFf2oFmi1KBuTgHQnb6XxC9VNmTvzqyU0jnXkl8HK4MUJxV737sDlr4tmpL+TMDfzdXExdJaxRHNmJekxVE01egnbrEEicduH9FllYZVuf6mEVg2epqQgJm+ePVHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(36092001)(5660300002)(316002)(6506007)(54906003)(4326008)(66446008)(2906002)(66556008)(33656002)(38100700001)(110136005)(71200400001)(186003)(86362001)(55016002)(83380400001)(64756008)(52536014)(8676002)(66476007)(7696005)(66946007)(26005)(9686003)(478600001)(8936002)(53546011)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?C/YiJa8XklZ/ZXhH1sLz1e8FaGsDkAuj6AlfyxNAR7Hmd9RSH9dXp13tvQKy?=
 =?us-ascii?Q?a8FExjJx0U+A/VVrMvvUoigVROgj1dwGGX3L0aZE8W456xbsre7Obvk58qJ/?=
 =?us-ascii?Q?CrLvYc062cb/8cmHgX7CpwsNZdtmvxxlQ37F/godpd0a0WKgajcGvohFctyD?=
 =?us-ascii?Q?zNb0OH/S5PAFHdpRiCQB5gMzzkdqVKMs4FHLRrIPXyjAJwUlg5RBQt/lFTKO?=
 =?us-ascii?Q?VXz4nK+A6rAbtOkLY42Tchdc0u5eIBKe7IxaDI346SN5hIfFWBYumlZlBI6m?=
 =?us-ascii?Q?MJd5ACJH8xevcMCuItpPSA6ESRMkseOJwilWOJJXNwINblnpaWgJCHfSqzBl?=
 =?us-ascii?Q?bBZV1eiR84L1NUeZ7tDpi6ebtkMIi/WydHUUYjgRNOsLT6Kcg//ccbLCYfrz?=
 =?us-ascii?Q?SUbw0hnFe/Rvuxz8J5V3xtGfcTDCUKzK36Kv6cr9FF4RuxWVv+nKB0H75JSQ?=
 =?us-ascii?Q?PO8LHCSObzfh11S1XY7fmFb7XjgpWqddsAGAd6HW6ARQtNz5d8DVTLpIPeKS?=
 =?us-ascii?Q?yDlxj6H9o/9cb2uy6Jm9xzpV5fOhIaYR2dMt/hPmwYxilR7Ph7YcSbtE1kGn?=
 =?us-ascii?Q?x70UNjIz7OmBjlxq+NH9R5PRgBn3GZwe15JzieIIMXDlndkogwPmlcks6hSJ?=
 =?us-ascii?Q?ts9PQcOLjn4PEKNbpd1rSIr4BkBGgycaLBqohLjqTE5DerPFdCgI6L1mJ6hy?=
 =?us-ascii?Q?vOjohFQ051rDwKcp9nMNJUfFGJm2ecj7PGV/MtKvxNiGDPO4L5nWi4ti7Tp1?=
 =?us-ascii?Q?Di4du4lOMHIvr+ZE8939rE0XeNu5tNnBrjIScr52I0i+JxW+KrbH8Thuamvc?=
 =?us-ascii?Q?rn62CfCjKdUgih+O5TlEiu1DGANLL/bikZIRtSrcAUmDToBoNAvnSZmG8wgA?=
 =?us-ascii?Q?qZT248r79Q2mVhyuKAGju3QyR765P4mcAX76P0OLWc3Cefz35QTNb+zV/h/s?=
 =?us-ascii?Q?KDGUE7qsniIQdIPgCRhXm0beYEtoMvDhUyXS/o1zj1M+WPUZyaZ+I7D1vcdk?=
 =?us-ascii?Q?oEpmR4xe8dL1BPDCnRTFK1VEmQR6up2Lc14yvMrmv4mECEzg/qevhXUZYjgM?=
 =?us-ascii?Q?3MB3a62bqAkBXWIe5HlxTfY/e3gpi246Wzjxz0E7gsnq7NF9ulu8NXyL2DcU?=
 =?us-ascii?Q?Q31qsvL252V824ouv+4FVrFD+wNx2hKadGy+HeL5ixuljV0/to/2SAbts/0e?=
 =?us-ascii?Q?oIaMZ+Wa+iWz8MZJIi+Kv+Cf/5IhGzS7ffqZBz7yh45lEWwFQyunrNeH8TTk?=
 =?us-ascii?Q?Vuejde8pqpXvDYNeTDAUGAOmKnndOXs+wmEmATPNSXBG2czQKdirfwSS4AaZ?=
 =?us-ascii?Q?FR78VCc1KDmO3pJr9WjDSu2T?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db9d275-212f-4db2-0af3-08d8e9f40190
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 09:55:47.9335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nh13Wn19y2q17WOoamgzhKXZ13mF+C1GhHfX6WCDL/86Qn90ie6W1yQwyjpJYQ0Ak6FaHg/BFNhqVNwbD+LXqT06dmWTDoN4MV8wkMw5z7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB8308
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_04:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: Wednesday, March 10, 2021 9:25 PM
> To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul
> <vkoul@kernel.org>; Rob Herring <robh+dt@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Lokesh Vutl=
a
> <lokeshvutla@ti.com>; linux-phy@lists.infradead.org
> Subject: [PATCH 3/4] phy: cadence-torrent: Do not configure SERDES if it'=
s
> already configured
>=20
> EXTERNAL MAIL
>=20
>=20
> Do not configure torrent SERDES if it's already configured.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 32 ++++++++++++++++-------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> b/drivers/phy/cadence/phy-cadence-torrent.c
> index ab51c4bf7b30..5ee1657f5a1c 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -371,6 +371,10 @@ static const struct phy_ops cdns_torrent_phy_ops =3D
> {
>  	.owner		=3D THIS_MODULE,
>  };
>=20
> +static const struct phy_ops noop_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +};
> +
>  struct cdns_reg_pairs {
>  	u32 val;
>  	u32 off;
> @@ -2306,6 +2310,7 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  	struct device_node *child;
>  	int ret, subnodes, node =3D 0, i;
>  	u32 total_num_lanes =3D 0;
> +	int already_configured;
>  	u8 init_dp_regmap =3D 0;
>  	u32 phy_type;
>=20
> @@ -2344,16 +2349,20 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D cdns_torrent_reset(cdns_phy);
> -	if (ret)
> -		goto clk_cleanup;
> +	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1,
> &already_configured);
>=20
> -	ret =3D cdns_torrent_clk(cdns_phy);
> -	if (ret)
> -		goto clk_cleanup;
> +	if (!already_configured) {
> +		ret =3D cdns_torrent_reset(cdns_phy);
> +		if (ret)
> +			goto clk_cleanup;
> +
> +		ret =3D cdns_torrent_clk(cdns_phy);
> +		if (ret)
> +			goto clk_cleanup;
>=20
Should if (!already_configured) be checked while calling clk_disable_unprep=
are()?
Otherwise,
Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>

Thanks & regards,
Swapnil

> -	/* Enable APB */
> -	reset_control_deassert(cdns_phy->apb_rst);
> +		/* Enable APB */
> +		reset_control_deassert(cdns_phy->apb_rst);
> +	}
>=20
>  	for_each_available_child_of_node(dev->of_node, child) {
>  		struct phy *gphy;
> @@ -2423,7 +2432,10 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  		of_property_read_u32(child, "cdns,ssc-mode",
>  				     &cdns_phy->phys[node].ssc_mode);
>=20
> -		gphy =3D devm_phy_create(dev, child,
> &cdns_torrent_phy_ops);
> +		if (!already_configured)
> +			gphy =3D devm_phy_create(dev, child,
> &cdns_torrent_phy_ops);
> +		else
> +			gphy =3D devm_phy_create(dev, child, &noop_ops);
>  		if (IS_ERR(gphy)) {
>  			ret =3D PTR_ERR(gphy);
>  			goto put_child;
> @@ -2507,7 +2519,7 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  		goto put_lnk_rst;
>  	}
>=20
> -	if (cdns_phy->nsubnodes > 1) {
> +	if (cdns_phy->nsubnodes > 1 && !already_configured) {
>  		ret =3D cdns_torrent_phy_configure_multilink(cdns_phy);
>  		if (ret)
>  			goto put_lnk_rst;
> --
> 2.17.1

