Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3A31358F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBHOsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhBHOg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:36:59 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E50C061221;
        Mon,  8 Feb 2021 06:18:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDIhhGpLxzjpe/PquveG06Hbji+z0R6RpM077Kx8TT53RpzTlbNiFxAy5IUQvuj/ybx/4nyFGO31niRBHUiWaSqfBmAMW2OWtGi2lFKfOeuHO0NhrCxyGcKf30YOr6NUcbXegzt8I4mgC6nG2atHyP3HWuLyUpS6KwKa4/AZ9JkzsNG2Tif1Wm+KiOpCydZI9dssp9iNkCrvniFJdyXbDoek9q9GvKmOF2fpDOVQ74gYc7+TDhQacjz2eiU7HQnZ+qjmBa6yIxzy56igUuQtBXmcjbOnHdkWyOFB5o72tzvAhl44XPLvNEJ3J4lM2wjmFkgjjCMwDYXFplQjWKZA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm2mrlLcmGetzERIQAD4298pZE9n2sgn32ti9yazeJU=;
 b=IKUIWssOGnimyGAQkbnQGmTVt1w41iQcoSELYZMBr1U5CYNwPQpVU66Rz9MncBpGmnQ0WH5scfV88QHnZqnDi7wSqwtPldDveBqyOlMDtXf9u7aACOhlWq8jTMbnt3qw7Ecb5UjAZ1S1mMOE8vgXSxbIemLC2Xb4E4CM/dWc2wyeZ06S1R8PPj1MGW4dptrI5ep/lUFMcegQkCCgWw8urU3v98tlA6xCw/t1oLyaW+MRUB9VRz+PFjPg3LqI3e7eIUoamncfWpqy9H8Nx+aGkRfWAOpXyfvmj/KrSEd3WTNn20QljHoMR2PguAlrnio3COPRid1XSvlGd9+ZOep+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm2mrlLcmGetzERIQAD4298pZE9n2sgn32ti9yazeJU=;
 b=TUOPa6PLZIGt6W4xrnjfkrJCeEKNIzaHLIVTdwOlh18ggYE0747NwNf+uEN4K+xzP/6LzwEj2XcxFb9uFfOSXVXqHCiLz/sLiK1tsqhZ5u+SGwu8DE4c1Bzc9Don74iiQYvk6zvFSEDjd0IIaS1/lD3lrZIA7uJ2dtfMB9eGBUI=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR0402MB3741.eurprd04.prod.outlook.com
 (2603:10a6:803:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Mon, 8 Feb
 2021 14:18:04 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::b0d0:3a81:c999:e88]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::b0d0:3a81:c999:e88%3]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 14:18:04 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] bus: fsl-mc: Fix test for end of loop
Thread-Topic: [PATCH] bus: fsl-mc: Fix test for end of loop
Thread-Index: AQHW+JXWIedFA+IGmEmzK+UDvJ/0YKpOWUCA
Date:   Mon, 8 Feb 2021 14:18:04 +0000
Message-ID: <20210208141803.bqbnbgvprtlo3vs6@skbuf>
References: <YBf0Br9obNGZTcNI@mwanda>
In-Reply-To: <YBf0Br9obNGZTcNI@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [5.12.227.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5786758-0695-47ee-dad5-08d8cc3c599e
x-ms-traffictypediagnostic: VI1PR0402MB3741:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3741CA1F3E4D8B898464EF99E08F9@VI1PR0402MB3741.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1RkjDwAKxlpNKiiFGCluHBL9zfZCln2gY6EiS9xllPjfGcDr41ry4BW0c9tkKeER+IpWG4NwFvqOmRGrz9E2SREOL96FQlanc0yCZoqU/NtwtVMSMD7wARLaXJ8LtQ0dtrwWhsDeb/TM4dOrwdvnKveBmWvdYuev3ycWOkdusCcAOwmxq2s8hU2uelRo4D/A6eW7+DGjcmhG/5wDcFy56Pk3niGm7t8TsDA+QRDZZN05kuCu+lcHCIEYi8PPZQNsXEo/gNyqT/6ztsImaBhIojELK5S/UQqB0Xy3tpdeeMili/ds8NWS77AVrTURlXG54qUSmrwshRfGFNOAndZr7xBNzoQVNyal1zx/tLxOGLvI67ec8fxBBmB5FyN/ISxBSI0rNp1/gVWc0N9WSRsYk/97OOidNHA7IvaR8b/4c+x0wKF0aUmmXx3p2hE+5BuASegf/i7P6AJpX16i72HrUNeOPZVe4XKVuE3Ei+Ob4xFRt1twP37DszXLiO3ZYejTsG/9hH8yMM+lr0nosLwa0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(346002)(39860400002)(136003)(366004)(376002)(64756008)(66446008)(2906002)(66556008)(33716001)(66946007)(66476007)(76116006)(91956017)(54906003)(71200400001)(6512007)(44832011)(9686003)(4326008)(8936002)(6506007)(478600001)(316002)(83380400001)(86362001)(6486002)(6916009)(5660300002)(186003)(26005)(1076003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vEr8NMTFAkm2odSw8CR8KKbrhw1G8xwpzUjkOFdSIMDky0CpRLh/kPefbl3r?=
 =?us-ascii?Q?YAMjITakfk4zetGYndHH4YkWES7iGoLqN1kkuhDhenpCvWbS+4OJKP9p4dWO?=
 =?us-ascii?Q?755u9szb5wV8LqpHwRlhTEQPljpQVzfiDFqDA00EUi0wrW5T7tkEXCVMvNCR?=
 =?us-ascii?Q?lMokar4xTGCVDI4hfHO6rwFbueeSPHKxo7uoaDAw1jMQXMvuBvta14xVqTeT?=
 =?us-ascii?Q?CIWEZmYPjnkl6NIF2yJZbLGLVE2WuBFlZzbrYOzNqxylUmXFi7YBgn9M//3j?=
 =?us-ascii?Q?nMrp6UUIhAwiIL3ItAhrOm50AGd0DgrWRYL7WxmwRE3KWQFUPV2lS4V247KZ?=
 =?us-ascii?Q?I/0D4iRVCZNntabKMfHWFW8UMIdKIg5urwHTMGk1LpuJxITWjFjMpm3tlGz6?=
 =?us-ascii?Q?mhn1y6zW5gec6Ep4/Oc0tf0YP/18g6QCdjlxbZLBA6RiCe9dzy3/BU1FGX9y?=
 =?us-ascii?Q?laDT7vVegaFZ+f+SNprSP57aat2fdimMd+XaWv6osTa9l3leFFGGr7cnVYFg?=
 =?us-ascii?Q?5wYuUk8UD5BKGlYJQFXG8mbsYsfpSm+SgKPSjxhyHVAiN/EOo1hx9U0QxBOi?=
 =?us-ascii?Q?OQw53/H2akyjxMPYCZaXKEa0o6+ZkdASyK1cHl4UF9adaiszGyFg0jGRsLFB?=
 =?us-ascii?Q?CccZ0olHfxH9Tn+9g0pp/54upKjldm/tdqEjJacoDqKmBbIUc+8NF46vLYuJ?=
 =?us-ascii?Q?B3Vut8ysXJ5vy82KNT1G0/vRsblwLrjfu9Q34mCY4HAuAuthxkwCorKOI718?=
 =?us-ascii?Q?3juUaB3HpD3fJeyxwFz7lkwAtQCgWtTOGn3IF03NaPY6QBNqGmyK6uFgaL2i?=
 =?us-ascii?Q?h7VxQQjq63aX4LWwaAhP6qbVf3/M48O4za5mShT+d5k64SaO3TE4HmuIXI0R?=
 =?us-ascii?Q?Buv50Ub6WBW0UWKsInIhSvaylCKCwjI2bxnmDlVwa4q0MUUClJzQvnRQi92m?=
 =?us-ascii?Q?pC8AbJPj+1IFqWDcL23fY2AhBTVJvpXKubYf8c3gLJ3tA4Pto1Spu6qA4EPR?=
 =?us-ascii?Q?Yfb4Kra9oA3qRxgTmIyxNkoOOkr5DP4/AKjQAlpNrypGlFZO1Y4+4/9aFE0v?=
 =?us-ascii?Q?3NQH7oJbK69OnPQ9VhDfDDB4cK7V1iA+98AIVRwndqIKcyZvP+wfvv2Mg5lR?=
 =?us-ascii?Q?7uW82iQ0YZ7FGLDLNVWR2lcUqCTCAiONNbEWI4jQHahUAtixex30lxvKdkiC?=
 =?us-ascii?Q?wIbi+dEnG7Yi7cZYtd3PRwuKS8XKKw+4ZZAi0Br7ih/DIsGOL+nn+pg+7yzX?=
 =?us-ascii?Q?K1i/WxcbP6AVlneT/37MPvgacM7NRVly2UpMrceB2Cnx9T1k/pPzYz/xt2L4?=
 =?us-ascii?Q?o7vad9b77ctW6SaXODqzrfnT?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6F8F4BC3EF4A442A8258E31E89D3F44@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5786758-0695-47ee-dad5-08d8cc3c599e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 14:18:04.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8X3QC98TUCezuGimtTR3HZN+2hUogZja9wR0RwNfGtytEvdJU7tAaBuoIfqT6Nfjb92hd+ZjLxj54Fiy2PMcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3741
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 03:28:54PM +0300, Dan Carpenter wrote:
> The "desc" pointer can't possibly be NULL here.  If we can't find the
> correct "desc" then tt points to the last element of the
> fsl_mc_accepted_cmds[] array.  Fix this by testing if
> "i =3D=3D FSL_MC_NUM_ACCEPTED_CMDS" instead.
>=20
> Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Hi,

I just noticed that Greg wasn't copied on the initial email.

If you don't mind I will re-submit your patch along with other updates
to the fsl-mc bus so that you don't have to bother.

Ioana

> ---
>  drivers/bus/fsl-mc/fsl-mc-uapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc=
-uapi.c
> index eeb988c9f4bb..bdcd9d983a78 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
> @@ -338,7 +338,7 @@ static int fsl_mc_command_check(struct fsl_mc_device =
*mc_dev,
>  		if ((cmdid & desc->cmdid_mask) =3D=3D desc->cmdid_value)
>  			break;
>  	}
> -	if (!desc) {
> +	if (i =3D=3D FSL_MC_NUM_ACCEPTED_CMDS) {
>  		dev_err(&mc_dev->dev, "MC command 0x%04x: cmdid not accepted\n", cmdid=
);
>  		return -EACCES;
>  	}
> --=20
> 2.29.2
> =
