Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B180340291
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhCRJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:57:20 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:5272 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhCRJ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:57:11 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I9v0AQ016428;
        Thu, 18 Mar 2021 02:57:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Xxi/sRvY17cjo0YNVXBGdrZpUztQx4OeCxq/re2Gfz8=;
 b=CbcaIGN5T6DpJYgXYM40ddblV+UnWwGCSoaPrg5uF1q4A5CUVJDHZuEUJbg6M/GCzZvu
 24m3X8MkgELKR826szqE5y5foLmdtDtKOxq8WUUCJJntl1bg7CxK5HBj6xBdokjsN5ZU
 +ad6LBX2+4OeKGShsV6oJcNK5pW3JK/5+dfHS+Vrm2Nj0I6yg9Hr2ELL1EVMmxlI5Bu4
 kmYZhDQw0L19ghZ1KqTlwWOhEWoN0JH/+G+nyEHGVHjjBQkfwq2EHZ958WbOMzxW2vas
 LQoNgh0TuXBvOs7cBct9v0hBhQDtJNG4nkEvE66c5uGhFPdSJEhfJ9G/Emyb4KH6oEZb +w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-0014ca01.pphosted.com with ESMTP id 378tu28jwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 02:57:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQxlU9In5RU4DaLcYHj5bUnOXyFR6R4oqU0OS0g5dV1oCfenwdCYdBrvUOKaDmlhzu/ZNSyRo3hhRjHW8STjRleL8TqfFeg06MUbCKax0ymYAE6O6Qc1e1ANYvfl8WXaoRM4s/Ai0QnNIbcqXoTYCNYhTjZ8ijDB1GUyImH0od5WFty8WnkQpD8vurN6udFHmb6p5jaQ8m5fhKivWTPq+DvzYuvdUht2jTHn/THBaIYOptyMPK1l7B+GqUx1del4pf1k6XkkEvWzA7gW66nK/SiXBuEq5DMxeXvdmvXC4TBRbO1DQH847nrlu1eCbyDaTnW+KJe9cFbqQkuBlKiL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxi/sRvY17cjo0YNVXBGdrZpUztQx4OeCxq/re2Gfz8=;
 b=knPzAblgr6f5ZpEBFx2IgdWBPv+e9QKFWovWUTZGaDn4z6/Zl5shT6ViKrG9m6FnZOUVhsobLJuHvRjniwIJ6khpGNLbE1pW03pz1AWjkxqdT00Y33wJkLu8XRTCXWOi9WBb8I04oGTj0u+oMu6ue7y48UgucCzR8BgRonej5YNzDbL8h9ytOUgsv8sI0vdnsN19mt+7bfz5382zWxkn/PS45pIffoTAz+QdLSRDPjHFkC+feNq3bPVOSYuQJuj/HvDVKRKulyjFu8bvl3TiotAP5PK+2fdOSE+oVqLk80vilV+gbdBVLwS2iQQMNSLwY1f9Y/MeZuUtmcCAoK09HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxi/sRvY17cjo0YNVXBGdrZpUztQx4OeCxq/re2Gfz8=;
 b=oKcnzmS83GjSn0XT7VbF/4HSfaJwiBsfkESfvGR88Bfj8H84bB/tq58xYg5scxHcVquWVhIaq5EwygDk6qfJq4R/SOV1L6WloSrB9dLIdC0bhdqm6URSgUn6o0BpZgdIuduL+jCqdxGDUP3XUTk9DexBoBC9NPZTul1JeupoUHM=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by BLAPR07MB8308.namprd07.prod.outlook.com (2603:10b6:208:330::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 09:56:53 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::31af:9129:7ae4:1fb7]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::31af:9129:7ae4:1fb7%5]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 09:56:53 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: RE: [PATCH 2/4] phy: cadence-torrent: Group reset APIs and clock APIs
Thread-Topic: [PATCH 2/4] phy: cadence-torrent: Group reset APIs and clock
 APIs
Thread-Index: AQHXFcW+kQ1FWcsZHky5xoxJKAGDvqqJig0Q
Date:   Thu, 18 Mar 2021 09:56:53 +0000
Message-ID: <MN2PR07MB6160E3807488E50BFBECB3A0C5699@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210310155445.534-1-kishon@ti.com>
 <20210310155445.534-3-kishon@ti.com>
In-Reply-To: <20210310155445.534-3-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00MjI5MTMwNC04N2QwLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcNDIyOTEzMDUtODdkMC0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSI1MDcwIiB0PSIxMzI2MDUzNTAxMDgyNjkzNTciIGg9Ik90RlB4RmZFRGQrWUZaeUwzYUlPdlZaMWZhRT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ff40e6-f65a-4a2e-6291-08d8e9f4287e
x-ms-traffictypediagnostic: BLAPR07MB8308:
x-microsoft-antispam-prvs: <BLAPR07MB83083F453FB97FBC09CA3CFFC5699@BLAPR07MB8308.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NgETEb3gBfqf4vaELuC/vtJaJO2RcZzRwbfp+JVU3FPwXg8bZhLbuN770QG9mQSuzI6bCUJU+W5MJYVvbXHZWpdi86VZ+aLLdWHc9yK1Qn1Vktez7Ell1K+9LWhsl1s2DImEMnfF1LIHK6xGPTVh/GKYLATJQDpecPdVPOOrJmFcNmT9hOjizZaBCoBu1PbIqEMrksdUA4SRpPznl+nEsn71gIDraMg4d0xh0Cmlge87+dHV66rwsZ6TP9LpxUEnAbjtRlBx+oAlDVsXnKo7Reng1l5Kd6IvizB/XB5XRrDdlmhoDzWhvNpVxBvSiJQtw06G/8EiD3Fl3GK1FiX01IcgWynKtBIKUPFoX6Dt/3FIrr71phJ4trZ04ZXCurs2zGhrRhNFJ5abe47TDe9XhoZzzTZxUKeyRHGsipCW/o5dVsHoe6HrkzprKSlcNNNxv3+/+8ry1tOoUm9zUkE/kRqQIOWvt9kYt85Gzqo3YlynQp/zYPAC/v8/Oulg/s2g6cHjzF5Hlrlvmsd95VPkfAKIu/Z224SU/McPuhM8NPJO73OFT+GbX2aK1m2cR4fouCz3YDWJadHJGL3crwq42Ua8+F5jgvagmRWPJEHSETuU/F/QB3yCicTnVd6QKKy66Fxm26DdAKneZ3BSsXkBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(36092001)(5660300002)(316002)(6506007)(54906003)(4326008)(66446008)(2906002)(66556008)(33656002)(38100700001)(110136005)(71200400001)(186003)(86362001)(55016002)(83380400001)(64756008)(52536014)(8676002)(66476007)(7696005)(66946007)(26005)(9686003)(478600001)(8936002)(53546011)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Z3DQnKSfWHeo/LboLGGNv3VRKH/Sstkg+8Jq9Wd64EsBwtIZV1X93dYjEgjr?=
 =?us-ascii?Q?vLImuhGcTzUSgyQF8j2FP7+0mSRlTMbOXbkuBa/wwNFU7TDDfzyRXlqT3RRE?=
 =?us-ascii?Q?V36ue8AZgH4gvJXC8f4fHH7KPti+uMZSrdVio4dwlo9BXCH126sLV0v9W0SG?=
 =?us-ascii?Q?kC50T3TCe96hnQgFh10DUMGm+nPxlQD+BzG+nfEP3LgMfN1myEI8RnHU7noT?=
 =?us-ascii?Q?Y8erswrHpi/ol+RHMfh5MDvY5uCuDz89jcmyu4leQH0WbdLWxISqpzFhLGXz?=
 =?us-ascii?Q?z/3wXuPz4nrXHOUfrENRBgsXjcUtHDkcSTNtcDw3dOBtfEtGYBDQKZznCSp4?=
 =?us-ascii?Q?cDERimZHspI42LWZXiA6QG2mm0nMcUCB6Ieqq5+UzjJXbs+oE+3EKJggxFZ7?=
 =?us-ascii?Q?DFVSLfNe4pHcDelEhDQiyZ26ycevzMpsNF8FxZrP+9n+4DL6xu0krrh4qYrK?=
 =?us-ascii?Q?vVEOY/GFAjO6nM7OETj/NgM8WRhR19/AYSUc0chDmlrJXzz6pCj098KWqpTU?=
 =?us-ascii?Q?Csr4f+4u8d9plCdrMVcMAoXN4HmPcuWuXOit3CtAjIKlBTs5ePqIdU5JtggY?=
 =?us-ascii?Q?RY9IxbgcMl1nwt6JvQQC32LRli06kUolty+88xr2Aivod2NKs4sM28UbVl6u?=
 =?us-ascii?Q?m9yIVLlgDFzk25XU9Lr9YfVbxF4NBAzdueVRMV+Y/Th8Zne3QtFvHbIAwuzn?=
 =?us-ascii?Q?JMI26RwgZJqg1xRgSLhD6jEy8UJHwDVLSCDM91yqPiGrozCEyQeBsYuWDf9l?=
 =?us-ascii?Q?b2MdYuFUJiMWyRc/ZtTT3SoMlhjL4WGJ2ixjqB05Gtsfp6akeQJDxTi7xy/r?=
 =?us-ascii?Q?QC8YEKThfwbPg1FMEx8B6sQc+vskNmVs+mE15uAdrjeJFDS22aoyr9P5pfwi?=
 =?us-ascii?Q?PyoXEoZVDAMu2/SNd8iVso9M7EZdHsYrEXtX1afrr4NWvowJUzMz9nvXZh77?=
 =?us-ascii?Q?VfqhDG0ADjmhCgFAMAawAi7X0qlGVq5dtiVglXDs1REmzNVVhEeoVE84N/JC?=
 =?us-ascii?Q?AzcJ18afFXu20Qg7LCn0ym+ZoaCfINBw3sqYwEUmpmOQrDJPTp5/En95+b8U?=
 =?us-ascii?Q?/B494caxdFx+K3snNUE7S6p+GVzwCiyR19yLhE8Szx3bTs1LuedLvqd94HYI?=
 =?us-ascii?Q?R4IHZA2zpCE2gz6uQepmaHkge0JS5/VKEhsNyo/MPaa9HW+2Kxi4Hc9fvUBF?=
 =?us-ascii?Q?0YbyDpTwOEF+B6uwg/Rd0xZlr1I5MmXFiOQZUyGdDPrey5fKVvmqbGE5omq0?=
 =?us-ascii?Q?nefxA9cseT8JYAmJ9rc/pWul6ePJF4cs7jtsrcUlR8Le1EB0tK7LVKEIuH4Z?=
 =?us-ascii?Q?6ptNflz2u0Fj6HIuSlQ0QCw9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ff40e6-f65a-4a2e-6291-08d8e9f4287e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 09:56:53.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHQGfs0VW+xbCXw9Q1TV2b74nNmKGj2jEUNpUnxUxc6xE1Jy357Dn5R9Gm8NmY9H7FHPayOEXY2KWKBtzyi7gkTCx0j77wnt8N4aH0Vbzik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB8308
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_04:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180073
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
> Subject: [PATCH 2/4] phy: cadence-torrent: Group reset APIs and clock API=
s
>=20
> EXTERNAL MAIL
>=20
>=20
> No functional change intended. Group reset APIs and clock APIs in
> preparation for adding support to skip configuration if the SERDES
> is already configured by bootloader.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 84 ++++++++++++++---------
>  1 file changed, 53 insertions(+), 31 deletions(-)
>=20

Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>

Thanks & regards,
Swapnil

> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> b/drivers/phy/cadence/phy-cadence-torrent.c
> index 3fdab0d288c4..ab51c4bf7b30 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -2249,6 +2249,54 @@ static int cdns_torrent_clk_register(struct
> cdns_torrent_phy *cdns_phy)
>  	return 0;
>  }
>=20
> +static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
> +{
> +	struct device *dev =3D cdns_phy->dev;
> +
> +	cdns_phy->phy_rst =3D
> devm_reset_control_get_exclusive_by_index(dev, 0);
> +	if (IS_ERR(cdns_phy->phy_rst)) {
> +		dev_err(dev, "%s: failed to get reset\n",
> +			dev->of_node->full_name);
> +		return PTR_ERR(cdns_phy->phy_rst);
> +	}
> +
> +	cdns_phy->apb_rst =3D devm_reset_control_get_optional(dev,
> "torrent_apb");
> +	if (IS_ERR(cdns_phy->apb_rst)) {
> +		dev_err(dev, "%s: failed to get apb reset\n",
> +			dev->of_node->full_name);
> +		return PTR_ERR(cdns_phy->apb_rst);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
> +{
> +	struct device *dev =3D cdns_phy->dev;
> +	int ret;
> +
> +	cdns_phy->clk =3D devm_clk_get(dev, "refclk");
> +	if (IS_ERR(cdns_phy->clk)) {
> +		dev_err(dev, "phy ref clock not found\n");
> +		return PTR_ERR(cdns_phy->clk);
> +	}
> +
> +	ret =3D clk_prepare_enable(cdns_phy->clk);
> +	if (ret) {
> +		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
> +		return ret;
> +	}
> +
> +	cdns_phy->ref_clk_rate =3D clk_get_rate(cdns_phy->clk);
> +	if (!(cdns_phy->ref_clk_rate)) {
> +		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
> +		clk_disable_unprepare(cdns_phy->clk);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  {
>  	struct cdns_torrent_phy *cdns_phy;
> @@ -2274,26 +2322,6 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  	cdns_phy->dev =3D dev;
>  	cdns_phy->init_data =3D data;
>=20
> -	cdns_phy->phy_rst =3D
> devm_reset_control_get_exclusive_by_index(dev, 0);
> -	if (IS_ERR(cdns_phy->phy_rst)) {
> -		dev_err(dev, "%s: failed to get reset\n",
> -			dev->of_node->full_name);
> -		return PTR_ERR(cdns_phy->phy_rst);
> -	}
> -
> -	cdns_phy->apb_rst =3D devm_reset_control_get_optional(dev,
> "torrent_apb");
> -	if (IS_ERR(cdns_phy->apb_rst)) {
> -		dev_err(dev, "%s: failed to get apb reset\n",
> -			dev->of_node->full_name);
> -		return PTR_ERR(cdns_phy->apb_rst);
> -	}
> -
> -	cdns_phy->clk =3D devm_clk_get(dev, "refclk");
> -	if (IS_ERR(cdns_phy->clk)) {
> -		dev_err(dev, "phy ref clock not found\n");
> -		return PTR_ERR(cdns_phy->clk);
> -	}
> -
>  	cdns_phy->sd_base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(cdns_phy->sd_base))
>  		return PTR_ERR(cdns_phy->sd_base);
> @@ -2316,18 +2344,13 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D clk_prepare_enable(cdns_phy->clk);
> -	if (ret) {
> -		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
> +	ret =3D cdns_torrent_reset(cdns_phy);
> +	if (ret)
>  		goto clk_cleanup;
> -	}
>=20
> -	cdns_phy->ref_clk_rate =3D clk_get_rate(cdns_phy->clk);
> -	if (!(cdns_phy->ref_clk_rate)) {
> -		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
> -		ret =3D -EINVAL;
> -		goto clk_disable;
> -	}
> +	ret =3D cdns_torrent_clk(cdns_phy);
> +	if (ret)
> +		goto clk_cleanup;
>=20
>  	/* Enable APB */
>  	reset_control_deassert(cdns_phy->apb_rst);
> @@ -2505,7 +2528,6 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  		reset_control_put(cdns_phy->phys[i].lnk_rst);
>  	of_node_put(child);
>  	reset_control_assert(cdns_phy->apb_rst);
> -clk_disable:
>  	clk_disable_unprepare(cdns_phy->clk);
>  clk_cleanup:
>  	cdns_torrent_clk_cleanup(cdns_phy);
> --
> 2.17.1

