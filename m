Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06E45E70A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 06:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhKZFMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 00:12:34 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:9072 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233784AbhKZFKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 00:10:32 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AQ50Km8011420;
        Fri, 26 Nov 2021 05:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=com20210415pp;
 bh=4fJJmtws9XA9A0nrV9I7X1DT4kVBVCOy6NQH9aiXN50=;
 b=WGr8wKOXTE2uAvpgh2oj46xIaUBW4YDm4dRJSAwYWmPx0z1OYvHVrnKTwwFnND7zle9G
 lTZgDecjARnANWg25fokKk2ck/GFAx4VPVoalAkXGGksIaQ79yShZIXZpvltNwEHEkaL
 cGZF4V7Y+PKgZ3bxC3PeznkAg8b8WU0Od0QCIBCn37Hg1SXHoNCqsZ8h7nzNxy/O6w80
 fOWT16E8LHkRR2OOqKvQFBR0ONVd32/JnQk+tMHL0ur/F/jqiSxEIKo5aGRO1mHUtIJa
 EG3sYMeVyrYzJLawcXOT7Yhibk8KOT5XuGkoGBoRB8P9Z+P8GNgLp4nGu1XA4/z1QR3U LQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3cj9nt8a4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 05:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir/7o15foW8YMLg8P3pFYMh0YBH0Lx6dDHKjjByt+t4BWXdzmeC48VMHSVDSXNEj7NkBwDqv7/Eh7W6ElpMjn+zwHqmMJxwsAZGxjsWWGa304JshEBSqqdJywnmbyKY2mJO6+VgXJli9SD63huZ+j2Xgz4y7/5v4Qu1wVwEaB8kO2nZN9/ZNrDFy2tZOXAU9X+XL+KydMKS0iaKsrnxzI80qEZy64y1gmfEYcF11MMrbeTISC78E0FCWmuVg6zpAixPEgqcMPhKKOw1cGkWTLAzXJGvJN4USp0erLT93Lw5pp4uG3hmhBstG/YZE15GIp0BuAChJhAyNGTdIzMtwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd/Wyes+sOYpCN9WtwLpP6QeTiVt91Z99ZeZtHtHY7g=;
 b=hkkH9jXwdQOEpVj2NNM9OlRbb+Uo6VYIKfWPWevObZskfoHFFx+ljA9GW/TZ+PLst+xzP+jEohBoXNVAMhnapA5r2R87S0263dz2bs2i1pj0cztMwx9wUQ/JTtasViht+jdm5ZjIH0OrGbZN/myD9VQlqHektP77tZwWrWQGoOFrlvmMdYNfgM2MQhJcvnFqRdHHub5B33TSs0zdGUKRYXmVNZhZk3r7zjEPB4e+nL4HeSpwRAKNjFWlGX/qCP5csyvwQEKdqUpx+PGrhqgE1iSgN2ZDLWKnBCdO6OkPsc1iSM/zoLesmtNs6qonIVuUA3/j1gesXjYD0Zc73/I3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd/Wyes+sOYpCN9WtwLpP6QeTiVt91Z99ZeZtHtHY7g=;
 b=STUwi9+Q/KVlbeFA2F+2r5pQ23kYYHRIG/ITmo1zIJ9iJP4OhbFrG8sDO40P6932LhVI9AV0XwIaIDuzztdUd5Nmja0OCQFuDegaUXwvo+dIzj+pP9v/sH7Tw0E18QEv+cXGv3+NLAzhMCFMJ3W0yAWB74eUKcjHMT+qS5lW/LM=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB3431.namprd19.prod.outlook.com (2603:10b6:610:3a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 26 Nov
 2021 05:06:51 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%4]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 05:06:51 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] Revert "phy: cadence-torrent: Do not configure SERDES if it's
 already configured"
Thread-Topic: [PATCH] Revert "phy: cadence-torrent: Do not configure SERDES if
 it's already configured"
Thread-Index: Adfigy5UG7A+JRfzRGOjQFvgL0E/Bw==
Date:   Fri, 26 Nov 2021 05:06:51 +0000
Message-ID: <CH2PR19MB4024BE31FB249744412071F6A0639@CH2PR19MB4024.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f516aff-2183-43af-f396-08d9b09a8eb4
x-ms-traffictypediagnostic: CH2PR19MB3431:
x-microsoft-antispam-prvs: <CH2PR19MB343114105529D86148261FDEA0639@CH2PR19MB3431.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:57;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZN/MuUplEDolrBfbgBgZTHJ1qhs85ZfgkzyXSs2cdZl5/TqrUOD1Kq653EglKUyhkYpdtRfu/r5ur6W73BWNSvsvZXjKmbvp9ZOwXH8ecbgPNR5++5r6nZvTulmzdWsLHeB2LVZaakYijrTKGe/d4PUOcYoCcWxugRkjfBvJhdK2fsNR6JrxVpJhhTriNNTLBfQUIc+kN4PnCEQAj60S3kt1Efm3vlmQA6DpAPaK8q8OIHdvlPjib27/Gc8w8dBIt4Otyv312tn5E50izn+ymg60ymtW+iAbBlFtPPumHNo4cmaAIAaNCinv6V8UdUX6gZrsfeh9uZLm5Ba/Ydc4/9PVKxzyGsYwLJGwZEtpAeHSoFMLnSWbMYag3pHi3BaM5w1nq7NZ413a5LjD8/5ImI3R0CYfoTgb9pJiB+DdgvT7oOC7V5qkSb5Ib0bHWP9KLYD2HoXvNhlxcO+obBnQ4SgbsSkXFURyiL0ZVFOCz/97ZZ2bXtxbAOSgpMIYex/4j3xE+FnKxGJManoPOca4wFF4IQRdD8k2G3b3tb9vI+0FYgeWa5Prx/UHo6gg3kBqQAUL17toK58vVqQoleHDowyvqThEdtNveGsm0a08jhc74hi13uUoD+U1X4hJK9mCcrAfJDr4HW8Tx4sp56TtBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(64756008)(66446008)(6506007)(316002)(88996005)(8676002)(55016003)(66476007)(66556008)(7696005)(66946007)(122000001)(86362001)(26005)(508600001)(4326008)(52536014)(8936002)(38100700002)(186003)(2906002)(9686003)(71200400001)(110136005)(5660300002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0AYJ+IYQP6ld8VTiigM78Joib2Zo+QlBYVkmOlyjTkKxTh59VATQViXobc7C?=
 =?us-ascii?Q?0vWBHK8m7Ulo1Y/SMxR38X1YiJFn+cUDj7U2xUb/0rftRlc5fFDyKjdrFwSt?=
 =?us-ascii?Q?n/m7RFAWlR1Z7Jg4u08Y0NdMK3FPygvSnVtAnj/XIPjtbGrp0/0PrwhxbGcV?=
 =?us-ascii?Q?Gv1fKjWeWJ5FuzNDxw3GWm2pRe4nho3Nl7vDExl23OxmjYrsaJUVVMjT3pSz?=
 =?us-ascii?Q?QWzqnbxw6WGZk7C094TmRyNjzF4zzkKx5TG2cfWzawIrUDRWaEtcGZU+S3Ll?=
 =?us-ascii?Q?fSFLwh4j4KKJVupIk4IY7EGVx//UThhgtX+oBfXQQ/ayGV5lKbYBX/abWpgo?=
 =?us-ascii?Q?AqcGoGabShBGQf3XJoWLpQRPIUZr27a8s3+h0hWSsKx5pdHzHDKqAw5YGXbA?=
 =?us-ascii?Q?F+tL2G5YYcYB3BAE5EnpOJd2CDo/Fsk8R65aVxSGT6grBVaqAhb+CLIKXSoT?=
 =?us-ascii?Q?7jZfAqNFf3Rbw50riyl0xl47EReoyFOlbj1U7dJoMLtgZBUz7OdOJA1lUdYp?=
 =?us-ascii?Q?TvHrHe+NiysMgSjnPsIPAaPzdg8Crz1M8aU7pM0SveMEOPegsEQM/7TFDo19?=
 =?us-ascii?Q?unJVyKumcLcI1tOyHxcTOwCWZz8tN/COVnGE8kUhnBTmWGc71X/HcKDWVugz?=
 =?us-ascii?Q?qbK6vI36Yr3q50ELV0dHcTZzEarSRHVjSwomSTdXwV58sxGmQQttWfvHKVUV?=
 =?us-ascii?Q?0Ea8AgYRRskxsnLwFEg1kG9qz67ndJp7ldZu0BtVza30KPJAodSwntCeH09D?=
 =?us-ascii?Q?cfyjBzAn2xTXJA/H5G7smcVwBmaeCOhd7ce0c3aQCJfvJFY6k14ec2mauGlg?=
 =?us-ascii?Q?+JUFno4SX9+0bwiI+LpHnLKaMkapK7LR0cgvspvsqyk51yzw5C/uJeyfI0TX?=
 =?us-ascii?Q?25avWm47Q7gKlzdoS6QmkkWhtHLTMdMD6Mu6sKJc6Iep7bVp/xvYBOclx4mO?=
 =?us-ascii?Q?noHKMr4YKk3BGU6zKpPglN5tLgPgZtne2l06PFPUc6rsq2tGUXOMHQscfaaJ?=
 =?us-ascii?Q?8OHLeP0SYss30xtbJnPfjTjbagk/8A5RbWIMj6roxrS75J+xKJ6/YgJ/6ETe?=
 =?us-ascii?Q?uaG7NpuRB1adYd21P59nkj3YwJkUKIUus/q9CD6hfj9ZYF4iQm4AE2NYraaw?=
 =?us-ascii?Q?jIRagHqRxdFN2R7K0qh9mnB8iEeYW5MXEEgXNzThzqywMPlUjiRyvwShjJ6q?=
 =?us-ascii?Q?lVVidaeEkEepUP/n2XwldwaszKD8aC0h4c8HDqiodEbHe4UwWalOmJT/RDFB?=
 =?us-ascii?Q?5yLp6jrIeXKHOWqRhItVf2s4RjE+n0xajdCvp/xzD5+/8BAwGm0U7HqRaljE?=
 =?us-ascii?Q?WhQJfeKICWzWaLDWCHTvvbJ0XMBWAEDYJOgGpyHXPaQ8BuP5bmYLO8LSO6UW?=
 =?us-ascii?Q?fIHw8GH8G3G6xzb4/DHLD5u8KUPZknj7DALxo0l7bgqLuQuDgkcqda3nQXPn?=
 =?us-ascii?Q?fCEu6m9qMdfEY+fnr9hk6TXr2VQRlBqQAyWVy/3HKrHdbxLXiKyiQZXuBq5P?=
 =?us-ascii?Q?jPi5C9VWU4VRoZ4x6G2zsbz6wcmX+fpmq7tX+SjEtToKD59a6/F3y3iwb5SB?=
 =?us-ascii?Q?0pQWdWLF6U712/iyJ+eA2un6JtxUVxV72Lm6amsHJYMSvRKsqAlvzS8jntd7?=
 =?us-ascii?Q?SjXvO3Dpc5hU0F11F5Ur+GI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f516aff-2183-43af-f396-08d9b09a8eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 05:06:51.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3rogJiEwMvdyDBv5YlZWzSrvSkkwGUYVdPrETU3YJuVz6RWdmFR8Sn12JBcFKy8gf2d4Re1aX8OyyrRPkn1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3431
X-Proofpoint-GUID: lRM3idvApzWdXl546VcAohBeg_ykNd1x
X-Proofpoint-ORIG-GUID: lRM3idvApzWdXl546VcAohBeg_ykNd1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_01,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111260028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit
b69d39f68419("phy: cadence-torrent: Do not configure SERDES if it's already=
 configured")

our soc will hang on any regmap field read before reset.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 31 +++++++----------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadenc=
e/phy-cadence-torrent.c
index 415ace64adc5c..e57e0b1523aff 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2031,11 +2031,6 @@ static int cdns_torrent_noop_phy_on(struct phy *phy)
 	return 0;
 }
=20
-static const struct phy_ops noop_ops =3D {
-	.power_on	=3D cdns_torrent_noop_phy_on,
-	.owner		=3D THIS_MODULE,
-};
-
 static
 int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 {
@@ -2282,7 +2277,6 @@ static int cdns_torrent_phy_probe(struct platform_dev=
ice *pdev)
 	struct device_node *child;
 	int ret, subnodes, node =3D 0, i;
 	u32 total_num_lanes =3D 0;
-	int already_configured;
 	u8 init_dp_regmap =3D 0;
 	u32 phy_type;
=20
@@ -2321,20 +2315,16 @@ static int cdns_torrent_phy_probe(struct platform_d=
evice *pdev)
 	if (ret)
 		return ret;
=20
-	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1, &already_configured);
-
-	if (!already_configured) {
-		ret =3D cdns_torrent_reset(cdns_phy);
-		if (ret)
-			goto clk_cleanup;
+	ret =3D cdns_torrent_reset(cdns_phy);
+	if (ret)
+		goto clk_cleanup;
=20
-		ret =3D cdns_torrent_clk(cdns_phy);
-		if (ret)
-			goto clk_cleanup;
+	ret =3D cdns_torrent_clk(cdns_phy);
+	if (ret)
+		goto clk_cleanup;
=20
 		/* Enable APB */
-		reset_control_deassert(cdns_phy->apb_rst);
-	}
+	reset_control_deassert(cdns_phy->apb_rst);
=20
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct phy *gphy;
@@ -2404,10 +2394,7 @@ static int cdns_torrent_phy_probe(struct platform_de=
vice *pdev)
 		of_property_read_u32(child, "cdns,ssc-mode",
 				     &cdns_phy->phys[node].ssc_mode);
=20
-		if (!already_configured)
-			gphy =3D devm_phy_create(dev, child, &cdns_torrent_phy_ops);
-		else
-			gphy =3D devm_phy_create(dev, child, &noop_ops);
+		gphy =3D devm_phy_create(dev, child, &cdns_torrent_phy_ops);
 		if (IS_ERR(gphy)) {
 			ret =3D PTR_ERR(gphy);
 			goto put_child;
@@ -2490,7 +2477,7 @@ static int cdns_torrent_phy_probe(struct platform_dev=
ice *pdev)
 		goto put_lnk_rst;
 	}
=20
-	if (cdns_phy->nsubnodes > 1 && !already_configured) {
+	if (cdns_phy->nsubnodes > 1) {
 		ret =3D cdns_torrent_phy_configure_multilink(cdns_phy);
 		if (ret)
 			goto put_lnk_rst;
--=20
2.33.1
=20

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
