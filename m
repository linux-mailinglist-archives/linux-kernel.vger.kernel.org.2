Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577C83B86B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhF3QDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:03:03 -0400
Received: from mail-eopbgr660120.outbound.protection.outlook.com ([40.107.66.120]:49501
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235862AbhF3QDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X24EavcIYWQJW9tKc9g5eVDJ7jhwWqzgYOLyuDjgIKcKJ1UnoJ1sxUVxoZnYSsH+loRYW35mKuOA/3fJV6dZRiU9RJFz5UDSMBIEQZTIuOJ1uIH79yvNj0umd+zeP8f68fiCV063knHUCCHKn7tAjjYzJjnTq7MO+UpVK9Ed3PnXZH5Us4TqVWYcnI6I9e3xpVLvkCoPFLIhOveEyxwkR1gpFlDf3hSo5yVq4KIYfXQBR+rODR0rpcWhlFQN15KLTJbk3aKmhm8xCVjb7b3SCk1phDnN2dTnxQ8wQuxWhRDgAaO2fgH0VmAX/IOIGfeJwwhbDRtKz1+KnAMBHu1W3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OohReHPGazhP98s9Zh14BtB7iW6MtsXo5eBbgt23ILI=;
 b=lXpfCaGt3MYCqZONedLoLCvUfBzJAuRu0pr6ei5RwusgtaSK8JZrGze4/BB2h9UuYgCFg0/INAiVQTH7l84O2Gkys/YqROX+mPku5joM7NlGz+bcPrl+j3Nkrm+ChKKORJRt98Dujq9leW9cUtmNOaqO2N5CHxJ5mXIrFzl0pdZGciqF0sRFIIoxPVhq0cuPtn4R9UeBvmeimiccyiH/MU++zy21pOyHzCd2Exb1A6YrCUVCYBrGmR2z8+tCYm8QrYwP14aF1NFkFoCJ7OM2BEko4Fygadsr9UgfcAaR+VcIqIVqc+qcLzixRqOQTahdz13fsNEsegB+SwRUdJPdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiphos.com; dmarc=pass action=none header.from=xiphos.com;
 dkim=pass header.d=xiphos.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiphos.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OohReHPGazhP98s9Zh14BtB7iW6MtsXo5eBbgt23ILI=;
 b=SChLP9/4Wbyye5GcE/vQZTyDaEJIZ8IauWjPtXc4gXwhF/wX/4t+UUPMQk9Qzg+WyvJ16h3pomaw9wzCYpWe4lHsvlxOfk0XuY5S4WlKzrE9hzR8IRHD49h7eD2+fUzOKZ7/YBBa0ujSYMJgKss9qEwoB+ph1savPhpmeyr8R9k=
Received: from YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:d::20)
 by YQXPR0101MB1735.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Wed, 30 Jun
 2021 16:00:29 +0000
Received: from YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::74e7:26e3:2b35:6c2d]) by YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::74e7:26e3:2b35:6c2d%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 16:00:29 +0000
From:   Liam Beguin <lvb@xiphos.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] clk: lmk04832: fix checks for allocation failure
Thread-Topic: [PATCH] clk: lmk04832: fix checks for allocation failure
Thread-Index: AQHXbbciuIFon9n1bkCpXlwcqRycHKsstdiw
Date:   Wed, 30 Jun 2021 16:00:28 +0000
Message-ID: <YQBPR0101MB18115B033E3F961CDF45C199D8019@YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM>
References: <YNx2dyvB6MkVlsrl@mwanda>
In-Reply-To: <YNx2dyvB6MkVlsrl@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=xiphos.com;
x-originating-ip: [198.48.202.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92d2ab6e-f971-4937-6315-08d93be02eb6
x-ms-traffictypediagnostic: YQXPR0101MB1735:
x-microsoft-antispam-prvs: <YQXPR0101MB17354A790D4CDD849786DE08D8019@YQXPR0101MB1735.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RsRZHLvHHRq+ap2+aFqKcEUIVbZkIPJ8XIKs0AqfQD4OUpf3ks7t58HUStceq8p1Rr6v6Y9v9YeabS5o41KFpC2zejSc6olNoCRleHHMhvisBkT9l+Sk57TnhUXEVqqaum8aBNHGWAucYkGa4fg96CycUSAW/TnBxfqiV3xkJKKuut067SGosL7eK9gRsWZyxgYIQY1VWKsZ3doDHlHtm34b5WHUzb0NqFNJma0fNjRAlFf3CVwc2QqSi6mhclpSAzRk7EZmNn/4JpsO8qbBU5U/jFU9ohTAUMyIQp4mdWh0AkJLRzwCEcA4rfea5w7QaowKSior1OGUszl2k7MEggY86ShQDdYQhCkwxfqOlFSOfYWm2doGfqArKdAgiOJ5O/Y71OuHnW5x02gcYEb3bNfoHmjDMICjhQrjENqbXoBcyFDMIQIL/a0Le7JqAXYEbfkZ2L3ePDYn+UmEWUx+Ok7ecXYEBsWc4QmdkxaiTzBtDjXxTKiV7LPA9zmjkHHSnNWaFbLlv3H1u6n4E3hYHcrxE/j0L4oMUyqeYltcfqaQIM6QCfRWyFEdYDSKKDYlydKlcBP3woZOxkmxPkdtqEvJrd9t2d+ow++JpTTPtDXjti/FaMWVnMXPl3kK10JAUoI5IxStl1ohfqTuN8lnEwJjLMbuL+xVRi3UdtK/oZyyofSk80qK1nue4CAfu/BGrBntKJ4xnmc8CIZi+ad7Dwlpqzl9O7GA3rFmiBCFZVvKn1OkbhxLPoMKh1WgUWyv9F+7mRXDbM7UcKismlpkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39830400003)(396003)(366004)(136003)(376002)(4326008)(2906002)(7696005)(186003)(52536014)(9686003)(66946007)(66446008)(64756008)(66476007)(66556008)(55016002)(8676002)(5660300002)(122000001)(38100700002)(478600001)(71200400001)(83380400001)(966005)(76116006)(6506007)(33656002)(8936002)(53546011)(26005)(316002)(110136005)(54906003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nO3t3CjMywo3oCKuerYY3Ovs01baw/HM2uu81CGBiACUKhcBdIfM5S4FCkYK?=
 =?us-ascii?Q?KuE0kDgHciDF+3HzFsh7ZFT7QbzfiImtiF97/2sKXvcyPDunwmj0LmLNi/J7?=
 =?us-ascii?Q?UvDQ9UJp+4jNgr3m8Emv73fdw9gHJDcr/8A3ISkvUf9yM0c3FBhOokm2Yfkc?=
 =?us-ascii?Q?3W9xftydcsvuhFfxmBrg2lhUB0OArY3wzudgPTwKNptAmqFWBg3zbI611Eb8?=
 =?us-ascii?Q?ErWLDpyPOseZN7kjWKVn/1Ih4n97nUrq4+xHrlgkc9MmFa6cAw5bYsefHDHt?=
 =?us-ascii?Q?6vrTji5JihWSK7hXZcywt5d9rdyLUI8wSn/3uPcqA8IDDxLuV+cdZ8IGRZgr?=
 =?us-ascii?Q?BzcjGb+Sejz5PbT5e39zUdULctHj2aMi4or7u2qWmbEg60rN5/zl2Y0Laams?=
 =?us-ascii?Q?fdtlruvAnbzgcvt7R07xzK5ty6VkhJ9HvFSh4I8PsQz81RnphdMDHgXSaZpi?=
 =?us-ascii?Q?YP7qLlnjfHnYv5vGMrU7Tty8WMtS8igkMLt/bVOlvv2/9ChkoIrPnG1hsv2U?=
 =?us-ascii?Q?UVcNJizHTLMlCiQ8Wv/lpmpjTzTZjE9HzSfF9em4R3g45mrv2EOxnpK9FigE?=
 =?us-ascii?Q?7o1lTCCD0FsMT/Z+5JRgqxRwKxLgof+1XCvUXcA6ltUa3JmfJxpghnwWB0Fx?=
 =?us-ascii?Q?LLeH9q+RO3KtB3o3hmvOd+MQNa5CWXbGxo24DsEWU5RE/Yge+WC8kkwSh67u?=
 =?us-ascii?Q?n3X4hxU0CzXBvkD5euUE+mAhWzK2akCFRonp0i7aTG6m31VIxPvmP96awEU3?=
 =?us-ascii?Q?NvWwhuPFpOEjndbMrfrrxzqRCiRxpYS4aOGy526g84lLh5R9i1c2WpLvXrAU?=
 =?us-ascii?Q?m50z/V8V4sqxV97l9H3zHhZocHrs6B96nMbLUZ0NyWFzv+0zhPh5kByYzj1L?=
 =?us-ascii?Q?dNW5BPaCE6VZUFSxbi50cmsszuVbH8IEx4/ZEH/08PEiaMCpelk9UvOLQfUe?=
 =?us-ascii?Q?avNiJLbHpjVT+p7sWGCkGsTcFnXNSkSqYfcbggNyojNwB4K8Mw6FQhPucjne?=
 =?us-ascii?Q?78c8jotqJaQXVhbHrslNKymNK90+kMmo5dKRVCBQwyAtLQW8BaTiabnBB2Go?=
 =?us-ascii?Q?3ewkDhpVMgTMvIGzqIhv/GlND+1FTua44fWUXi77VQVl8mgNZSGXse+9dVEa?=
 =?us-ascii?Q?nUNFW1y31I5uwaN3Dy7doPeiQwzjRgy4eT07PF2Sp46oo0bFp7RQUHTBDOBW?=
 =?us-ascii?Q?f11VgxV6sL48rQLL3AVxVEeuv8IBh1AjkaGaN20lnwwBPmp6Gspici4isWPX?=
 =?us-ascii?Q?FLV3qFCo3/xOV1E5ANA+sA8M5UHUpmeWTqhonsNtEmDtNU0hmkpO+NiX3hBV?=
 =?us-ascii?Q?JJs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xiphos.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d2ab6e-f971-4937-6315-08d93be02eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 16:00:29.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 11c32550-fdb1-48d9-8a3d-133e5b75b54f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yz/bJN/uUNPqRH6V2QwUsW0+W7PNXPhOGa+uPv5V0I++V2bxTmDqJuLrRS0m2E4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1735
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: June 30, 2021 9:50 AM
> To: Michael Turquette <mturquette@baylibre.com>; Liam Beguin
> <lvb@xiphos.com>
> Cc: Stephen Boyd <sboyd@kernel.org>; linux-clk@vger.kernel.org; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] clk: lmk04832: fix checks for allocation failure
>=20
> The devm_kcalloc() function returns NULL on error, it never returns
> error pointers so these conditions need to be fixed.
>=20
> Fixes: 3bc61cfd6f4a ("clk: add support for the lmk04832")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

A similar patch was posted earlier yesterday. See [1]=20

[1] https://patchwork.kernel.org/project/linux-clk/patch/20210630020322.255=
5946-1-wanghai38@huawei.com/

Liam

> ---
>  drivers/clk/clk-lmk04832.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
> index 0cd76e626c3d..66ad5cbe7029 100644
> --- a/drivers/clk/clk-lmk04832.c
> +++ b/drivers/clk/clk-lmk04832.c
> @@ -1425,23 +1425,23 @@ static int lmk04832_probe(struct spi_device
> *spi)
>=20
>  	lmk->dclk =3D devm_kcalloc(lmk->dev, info->num_channels >> 1,
>  				 sizeof(struct lmk_dclk), GFP_KERNEL);
> -	if (IS_ERR(lmk->dclk)) {
> -		ret =3D PTR_ERR(lmk->dclk);
> +	if (!lmk->dclk) {
> +		ret =3D -ENOMEM;
>  		goto err_disable_oscin;
>  	}
>=20
>  	lmk->clkout =3D devm_kcalloc(lmk->dev, info->num_channels,
>  				   sizeof(*lmk->clkout), GFP_KERNEL);
> -	if (IS_ERR(lmk->clkout)) {
> -		ret =3D PTR_ERR(lmk->clkout);
> +	if (!lmk->clkout) {
> +		ret =3D -ENOMEM;
>  		goto err_disable_oscin;
>  	}
>=20
>  	lmk->clk_data =3D devm_kzalloc(lmk->dev, struct_size(lmk->clk_data,
> hws,
>  							   info-
> >num_channels),
>  				     GFP_KERNEL);
> -	if (IS_ERR(lmk->clk_data)) {
> -		ret =3D PTR_ERR(lmk->clk_data);
> +	if (!lmk->clk_data) {
> +		ret =3D -ENOMEM;
>  		goto err_disable_oscin;
>  	}
>=20
> --
> 2.30.2

