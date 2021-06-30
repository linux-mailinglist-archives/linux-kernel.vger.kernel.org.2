Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4286B3B86BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 18:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhF3QFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:05:36 -0400
Received: from mail-eopbgr670132.outbound.protection.outlook.com ([40.107.67.132]:8928
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235822AbhF3QFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS9YRLzLx8tsQ73ajcyc0DbDDbaZ6X2aj8u7isjxi9ijj6S6FtY8CTrO1bRqSXziYvEsBTr3sNYkFq0sL6j95ZZhCekm1QYdUqrjUO3qkdSw++3WOtxK+RRKbn7dPuQdTe7k78t+OEfRJvDf23K1QGKEDXyb00nGxb12qt5F4Nw1w39VaTqfSd/W8iq/In1y/qkjtuNg4OAjtEMvTqtVpEfZeW0tyM4ksG2BTgJi+1T6j0rBS4NsFY2VmXR+kY0TYcoKJ+fKWr4BOM77QvhrhKDCdPkEh2ZGkaYHQ3EG9F9c+W9uq2JfhJWJqJLrYxOuxVzkWO1Sw+I2WFroAoBWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tid2M+HoBue2PXAmwcldf1YDuPrKRsEdw5UScPX1dAM=;
 b=dfWzdoDBp6dJZ7cgEEcDKWLqmq71EKqO7ChJPIEFjMAObg7rUxewLrw8NHCLzynpG7oqaPAE9OSp29us1k+3EoBboNuq90ZEdYDo0pOStLicvlh11+4cKQ0ZZhuVWObmSEwpzlg+IE9YjZtLc0WtwxMi64rQ4YkmWX5Qgx1FUimega5TuaNkJUh1Tgv5P5XAo4lAyRqNAcN01ndEBzetxqLFPZgOTqri/g91NLp1huZ9WP/JaBVL8vxBiTzqQ9hdi0cnwlrgEYNEi3eS/MitOJXiqIbqjDvU2bwM9eXfj5ohDkJsR/K998dDqVvSwMiyfFR/HIHs4BAcJxsz+QId1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiphos.com; dmarc=pass action=none header.from=xiphos.com;
 dkim=pass header.d=xiphos.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiphos.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tid2M+HoBue2PXAmwcldf1YDuPrKRsEdw5UScPX1dAM=;
 b=Kml5GfPXYPMd4PV2JNRRBJSC22VNV8nWPDldWVTxW2G22cM/jyJZhE5vwtHD1K0C4M/hlZfE/Jy8/6fXGm1DzhY0s4GW2I0deVMc00Jq/3Q1I9JobFLfHEsdCz6PTi4uHgrp6G96TAU/TmTW3hqYXb9/T0fgviW/xAe/LlSg1xE=
Received: from YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:d::20)
 by YQXPR01MB4691.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 16:03:03 +0000
Received: from YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::74e7:26e3:2b35:6c2d]) by YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::74e7:26e3:2b35:6c2d%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 16:03:02 +0000
From:   Liam Beguin <lvb@xiphos.com>
To:     Wang Hai <wanghai38@huawei.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] clk: lmk04832: fix return value check in
 lmk04832_probe()
Thread-Topic: [PATCH -next] clk: lmk04832: fix return value check in
 lmk04832_probe()
Thread-Index: AQHXbVRCiolFjIE7Iki/bk8doP3i9asst/Vg
Date:   Wed, 30 Jun 2021 16:03:02 +0000
Message-ID: <YQBPR0101MB1811C2E16F1D6F2E9D474CAAD8019@YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM>
References: <20210630020322.2555946-1-wanghai38@huawei.com>
In-Reply-To: <20210630020322.2555946-1-wanghai38@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=xiphos.com;
x-originating-ip: [198.48.202.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6ca5726-8c3f-454d-2bc6-08d93be08a5d
x-ms-traffictypediagnostic: YQXPR01MB4691:
x-microsoft-antispam-prvs: <YQXPR01MB46912EE17AD6D1EAB54C8E01D8019@YQXPR01MB4691.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lSKQzlbc6greIlru60dTG7Xsf1ThFzk7YrtEuu46MR9y0EkBnNvKQ2iJqms1UwNqB8AoEfhm8lUEiAJltWDii48DhzEjv2G5PdHjujPotIgbQVQptIYPT3di3ms/63fenzVpipWZIS87upaogaTr7elLDeicCSNgFCONkvEsTmTAEf0/iFs+/EvR/hRa4/e+ptQjADaZQX36hUS/zYPMkbTmHz/RiA0x744FxTX/mYIUZdFCVaB4FG+y/C/XQrv3xrvh8esbK5byIYjtHFNlhWldKHuDERtD0lyPspMEPIpG9enYU6J+4VV8lBe5jg1xcLbNaheTg1skB96PaHaBHDCvwPL0yCJrpz7+6n0seSykxzavvm24uKHULyVj64N2HIgYk/Xrtb8Rj8Uy8ek7rbxXl12vf2EI5YrxHHZh3cEWw1h3SKVSxIuyjis+J56SAJQ3VHUlDVFZkbok6J860HMdjHLXm51Pxp1JXl2B1CoLs7mCMd77ZURd0qC8MHhcJJ/XvEMDt05Zv6dEGU+7UXaUS3fO+gpYntJiANAeTONv6W5ewxoPeIB+neYZC392vvp1faN6kxbm4mf7UHPTqzSdyPccDnGj+d/t/B3lZPbJ9PjC07q1iX+BDzQ6nnp7dqN7+qdTSuXpAiwECaVluA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39830400003)(136003)(396003)(64756008)(38100700002)(478600001)(316002)(66946007)(54906003)(33656002)(66446008)(66476007)(7696005)(83380400001)(66556008)(110136005)(122000001)(6506007)(53546011)(8936002)(52536014)(5660300002)(55016002)(4326008)(9686003)(2906002)(76116006)(86362001)(26005)(186003)(71200400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YqDpO/yYFziMOkrt8qfV032nCy2+UCgEbcYFP5Wssk5CVx3xxaihwbZfhOr5?=
 =?us-ascii?Q?gfxt/bYt9SjdNdurlganYLY6JV9D+bVGna+erO30nvmbh3wvc2iB9cPn0Bh2?=
 =?us-ascii?Q?pFBsa0Zq9GXG9pwyX3FkAwG6kRLlt1dwXwUU0YmttJe5PWagj8ZjeqBKsbIW?=
 =?us-ascii?Q?K3WBQDDFsAMOWPh+DLaHs/pPwGSYP709bc5x+9lPYRZiyp2b+7T4pJz/FCoU?=
 =?us-ascii?Q?OrzKyZCn5ZarfS6/cgcS5nq5zzEjOIcSH0hChgtXjrZkKAbwlmdboH0D/Aud?=
 =?us-ascii?Q?QwG1vPeSE/sPIJ6kyRBEgB3Ua20JmwfkHfVOZHtWGDARvl50AFWZEflvG1/A?=
 =?us-ascii?Q?545wsYd0kDIg2Tn8gNEaA5pSZPWpsRe3gUdm5N3DPfTQtH/yjJIXQPKlBpUw?=
 =?us-ascii?Q?+tqVr6bUv6XMtm9NIufsi7iiEFDdncNHo6j3EKh6EDLmZFi7MyiCtLke69u1?=
 =?us-ascii?Q?jcPb8plmLeIiiZzVHP+vpU3fKiZQpBqoPwg+ECbLcmb/KhsNh2hiPYtsV/uc?=
 =?us-ascii?Q?rW4Ri1p0jCR/BjrtM/fQqvtL1n+pSGmrBC9pkFzCSvuFtyKkeHoauqFilNyZ?=
 =?us-ascii?Q?GQ3HpCOydEOjIdZbVKvGIactU1PNmy2jAwVUfVVQO+hF7O+VqEmiO+NFjrUK?=
 =?us-ascii?Q?GvyCMfC/+AYtqUxj9F3z17jB2cZzYYksR9zaNQtwPBglmO7t4FEq+nK9GNi1?=
 =?us-ascii?Q?3m3t3vmodsnchKZvZVxEm5hizd46f0MPXzpexd5ZC8ueFL/KmqsH3xulgO92?=
 =?us-ascii?Q?lz7er2yIvyrKUm92UJrA8xFX0umj3SvLbecjTqgKPjQNhTFX+zK5Ooym5zf9?=
 =?us-ascii?Q?QRsUglpRRKdGhGUihIw+wB6VrEUVquC2hkXnlXDCBxfX2go/kE9pKoNT8ujf?=
 =?us-ascii?Q?om0g0jpbalfpw08CGYXHKrBYt6suUuG7DI6L3IRDVF+weDmz6gsH+AAT9FCa?=
 =?us-ascii?Q?nTvd2szlOnxebW0zaB27n7B4LSQ0h1FcFudTr6Wq0ZEylVw3j1J2iI/lk+QI?=
 =?us-ascii?Q?H6L6cZxcSzG6KOs7mshRx5JVQXx0c+bhFm5BBtS5d820QP9gln0YwiI2OhNq?=
 =?us-ascii?Q?yM/A7++Al/dJ/z/XhmsfKnEBxCkFmqPslZqUk0Z5oknpREHINTYqbvG/uiKf?=
 =?us-ascii?Q?HQCkMPqeaJczYARHyvVf+Rz+uto2QR8AliN2EvoJnvieZYK9phf7CyKlSoOY?=
 =?us-ascii?Q?2V47WfTLYLz3u2Jc7GPKZ5xi4U9lpNKjxbOlZ0zOijzHzDj7WeNITHVf92Q6?=
 =?us-ascii?Q?NV5KQbE/42uQ3ZV9PnvCNpceGHy9YfvnlE7Ae3wlpVgtvMOnXHoz2lQSzrNu?=
 =?us-ascii?Q?61fswl5NADyxymERK87bzTWb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xiphos.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ca5726-8c3f-454d-2bc6-08d93be08a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 16:03:02.8692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 11c32550-fdb1-48d9-8a3d-133e5b75b54f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LS5J5n87VP2zQJ9Ow9kCbw+HN6b+g/pQAv4mCqpzcsbR5R8QPxNWOjBlEEw85ja6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB4691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wang Hai <wanghai38@huawei.com>
> Sent: June 29, 2021 10:03 PM
> To: mturquette@baylibre.com; sboyd@kernel.org; Liam Beguin
> <lvb@xiphos.com>
> Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH -next] clk: lmk04832: fix return value check in
> lmk04832_probe()
>=20
> In case of error, the function devm_kzalloc() and devm_kcalloc() return
> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
>=20
> Fixes: 3bc61cfd6f4a ("clk: add support for the lmk04832")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Reviewed-by: Liam Beguin <lvb@xiphos.com>

> ---
>  drivers/clk/clk-lmk04832.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
> index 0cd76e626c3..66ad5cbe702 100644
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
> 2.17.1

