Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6098E44BE93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhKJKaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:30:09 -0500
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:63848
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229831AbhKJKaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:30:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8ovYyPmxKZcS7M3OwsSVTH8+lt5mBjsQzJWaVPPS63OP/BCUjUDz2SQz0UWr9DOlWH9r8+A3RCDKYmm85o+oeXuLyI8k6jujU2LUWMoMT+GFLqT3XSnHD/Xkw6apEOFz8ahTguX7LnGlnwXqgYomtE0RjErwQG74uwnkgHr2qbBm1h59Nmh5HpkQtw1Bt5cbwOP8fHrsxomzQYWt6i++gmYYBaSk2TJck2Jf5Xu7nmZK5Z8/PAJWKvS6LXKwH6rcbe/SoyhMENXWgpM9QFRI6cCXLugLVcNEaJLJkGUAoqy9A+4ZjaO2mguJlnGMdzOwj8/o0eQbgCVWS8nnvGeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Se7Fcf9kycjGAha0cvwyPuC/A5oxyuxOoRNT+EV/cY=;
 b=Bf/9DsJ1voDmWcaifGBRc7sOjlUXfD80qpjQuNdEe7wa+QvbH8SP2Imz63/upHAOsFCCYqgZYSfm1cvll69IYE+N7CfijabqX5PMM2AAN+HWjMW5CruMgngXpYBfaBy4ktGj7Bo+Fp08p3pZebYwmfB5rchC4R/D8al6+7O1kZohlhnU1MSrh4p4LPuHuQCNnI5blc8in8CWq75DT8IWr9jua7sYsTU/KpVZ/clZhqg2GyDx3+2HAsDl+KuyscpPPRvVkecVA0+xVDEm+NimMW7jIh5uI4nFz4KDyI0E/SdF2HxEzqVeEtiqW4RWHpght8x/6yAn/L+dHZ104+4bCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Se7Fcf9kycjGAha0cvwyPuC/A5oxyuxOoRNT+EV/cY=;
 b=api5PZqGrARNUrpDnpWVDC3OOlRroNxvW7LkEuBK65SyXBwTR3tqXk5/gsTTWd+Aqgh+n7Ht31z0eBBE0QZGMy4tmCehXv0CnBX8k+6l0NDCvdBbzUIL1qUDjiWvwgdXy8Bf6RD5iiSppxAkQ9t2/TFHvFYLHR8djwxSI8AqaWuVYNxIzpKEhlV9+Eg1sZ8Q51Tf8xpkR+5xyVFALnYeWJwXKZqJOOvSO+gp+MG3KzPP2MoVKhJsGuNdekL4nGds/AVYUMij9ev6nBuDlVqeWdYO8S+CgeVISQTK8+KNtN1idYfqi9lNimQ25oEzZkEGhUKNaNP/nLUyD4cllwYgZw==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 10 Nov
 2021 10:27:18 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::f846:3ab1:9cc3:ee1]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::f846:3ab1:9cc3:ee1%7]) with mapi id 15.20.4690.015; Wed, 10 Nov 2021
 10:27:18 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Mark Gross <markgross@kernel.org>,
        Michael Shych <michaelsh@nvidia.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] platform/mellanox: mlxreg-lc: fix error code in
 mlxreg_lc_create_static_devices()
Thread-Topic: [PATCH] platform/mellanox: mlxreg-lc: fix error code in
 mlxreg_lc_create_static_devices()
Thread-Index: AQHX1gbAkay6IdGhH0ON/eZP4PZjX6v8juLw
Date:   Wed, 10 Nov 2021 10:27:18 +0000
Message-ID: <BN9PR12MB538173B0C85C0080732A0721AF939@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20211110074346.GB5176@kili>
In-Reply-To: <20211110074346.GB5176@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b45bb06d-bdc5-427b-fd05-08d9a434ac43
x-ms-traffictypediagnostic: BN9PR12MB5130:
x-microsoft-antispam-prvs: <BN9PR12MB513084214253E19F9BF70081AF939@BN9PR12MB5130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KFOvSMf8Gco0izNeCJYlOW1zmM2aplVNofKdrxJXB67B9zulh9gGgDY45wzKJSeDP53uhEmN7amEK6DsDzeD2/LrEKKr+Y/NB4DQBWfYXTd9au1G6pOQ2pss259dFV9ZOix0N6LSS9qjicSOUChuDyCrVle7Ek45tkhAvi3+jRC+vIklbUoYEBKsmAwSsLdrXmi3j2yOSIL+K3++NCKxWHoU/RzoOe7BrynSOYtGuXznjC3N1Eb0RCACBVeY2QUJV+YnKbl2PbIv69HW4eqivfPkRPpasf5CiBvRHHQbVj9c6g04fkIjvORzeQoZgss8EYfuS+uxJW2+ZAscGqfbn/bBOoZuV2lEKdVwcdmywSPTV8B6+BsgzK6hosD680wpJLBTvUjQGe/Ao9+1CnTb7C8nHubb6fyNjyQ3nw5g7MByyx+k689OagT8Dzk3tyw9EnY25mIchfpnZfa6Kfl9HuIoPb/FwUlfLRd7AMK6imshuiU5n1avWqLKbu04bpG35CnvAYCmqCRi2IMWme+FO8d3YhHok+QUH0XTxze/eZYBJ6H94mPStZ7UeAQjWRxPUYS87cMVqz4oM+vqKWNldlEs3c0LThwzRYBjMkCv7jeVsL4cwv/Ige+bE5BICGC66JuSizHuA9CXKL3rCFDRCX09jcLiZOMuQs5PVIcFCUmfoSvHntDxAuvp4Ese4XO6jLlzLbjvx/LjuWQr0jYKfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(8676002)(26005)(7696005)(38070700005)(316002)(5660300002)(66946007)(186003)(66476007)(508600001)(76116006)(66556008)(64756008)(54906003)(33656002)(38100700002)(83380400001)(122000001)(86362001)(53546011)(55016002)(4326008)(6506007)(8936002)(66446008)(110136005)(71200400001)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BZUJI/I/F8En8W/6a6IPA5rQKusJtBpgQ6kl4IOSvM5kMWlOr54qHgEXl4WA?=
 =?us-ascii?Q?bBtXQ0Xhfp1c2dUX9kH5LvfIvXpXcZD0QNwd45tStvmYvnXdxuVP1TFujKMW?=
 =?us-ascii?Q?QXIkMjZgLp8L7I8RYh8GCxiNBlfQ93sQdWMukW+56U30OnJh1Msd3GoIKSIN?=
 =?us-ascii?Q?g1vl0j27t7ffxO0SSatQYzYdjd/YAXXmdNE9dzPXazXEDIH3DdCDKZ64QvRB?=
 =?us-ascii?Q?qRjhYWmcnNOEfImr5dqb6BOlv2nExN1Dp4J/QjNvR07Lyvz/IZKYGaKafPik?=
 =?us-ascii?Q?jX2juxnuVlWYVE1mvvr5yGAf9ApNJIbB+1oDANgvdECgWP5zUkGaoCBtvwup?=
 =?us-ascii?Q?nhSazfEGnKa3aQ5aieWFLa8Fqa1CQp4N0TPtjV5Q+G7GJusu2+g178tOflSA?=
 =?us-ascii?Q?ZPjS+SNDl2gs7s5D5vI04MOW9AowgOJw5HMOmNi6bWBfwzSse4p3DfStCjkD?=
 =?us-ascii?Q?gYpFadZORHTCUhBBfCF0bwBU4sQKZiD3Ru4Lw4HIjUgotP0h8Kn1vl4nZMGJ?=
 =?us-ascii?Q?Zoi61lYWwUZggYrgUyiDYDKBO4LCZk6eQ2UC2DH1g2S4GZ++B/QrLqVxL5YP?=
 =?us-ascii?Q?DKBQ/4mQq2KnlnTKAVy0MZgqBrge3lqCKDeX0hPAlXz3KT005WlLDJ6VW0cX?=
 =?us-ascii?Q?LBdGQxIR70KOTm6q2vGTNscddPa+sghM0qcW5ACVFJUGiA3CXpcYQagEJnpc?=
 =?us-ascii?Q?M5kspp4jYZwfsorbLjC3ZdhJFNwNbJMmMOr1+6qf9GfMgujvPq1jTS0A57De?=
 =?us-ascii?Q?lyTWpNtAQuvGWZ2LizO+XAY2y32kzq39V8i9NnXhiY03hgPAyyjtcC1w4S24?=
 =?us-ascii?Q?c49z1qgDjkUVtbO0oJKAdk+ReyWi5d+uHvhV8feEFp25drIM6mOjJZaeYc1v?=
 =?us-ascii?Q?kmgjsUIfgzGzM3Z+zJp5GFpXsJ+ap5KQNnq2sA9Y2YJtfZbkLVpwgSGG9GMl?=
 =?us-ascii?Q?gtObcTmHqq/3xqSYMORQsapdaL9iwvCc/DHrtcgDM27zKHQAaDlIzlMcPTxR?=
 =?us-ascii?Q?1Eyc4cpEbBeWyQhY1oxVUzBpLylLVmWZ/AAhtpaqsiDEj8ZAhMMhJJM8K2gV?=
 =?us-ascii?Q?NdSU5H9DxdzoS8OiUIqkqr/trVDacHkO6n0PVNlF9I8hz5m4ME4t/JKRZAYO?=
 =?us-ascii?Q?7mszf9Vwufdis1RbPANjklthqFrhBNzSFPid/UYTo2oIlAgBbC8VOa6Tohsp?=
 =?us-ascii?Q?BsDTfZt3hsrEAhwCEyLznpnGCodV5OL3tzKaGbwx2ay8ebs4twfltDeRH1zn?=
 =?us-ascii?Q?swmbUH/PdLikI9bBCO3+IJ1Trvtnn4bshH9nn5pTEETlHHCmoFsh9EBVGnqo?=
 =?us-ascii?Q?NMrMyjBvLX63kDwUl2WEfGGorLW0ZfKP6uYToh6G80txyDBPVPOxSAmQorL4?=
 =?us-ascii?Q?ctRYDI1XiF91jC5v0d3tCzvnoVOciZh3gCeeSgy1DvZw8Hc+ZjCQkc/1ahfQ?=
 =?us-ascii?Q?umBfcjbFhltZjxaBti0nmq6JFzTqeaA4+G3wKFT8hmYssmsI62FCUwyo7onW?=
 =?us-ascii?Q?4+ev4qpjP6s1ADF/y0ecuZTVB5U5xWxqNaw1EXux2Jwmgk/RMyxrHiP5aq/j?=
 =?us-ascii?Q?DZ6H7aI4MQxqy4Mmr1/Wtj+CHL9YaKP9nyyYqodJik2qT76gzHOAccydfEVF?=
 =?us-ascii?Q?jTEdh/MUmkbxKuz/mXi/b4g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45bb06d-bdc5-427b-fd05-08d9a434ac43
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 10:27:18.4001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZ3eWyHMt7eGhNCP36uQ+n1I5D/7Gy+p7Hrz8vO6bZ+F/t8mxBNUjmKIZd813Tyf2w4DnVvdFmmDKuT0yTKsCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Wednesday, November 10, 2021 9:44 AM
> To: Hans de Goede <hdegoede@redhat.com>; Vadim Pasternak
> <vadimp@nvidia.com>
> Cc: Mark Gross <markgross@kernel.org>; Michael Shych
> <michaelsh@nvidia.com>; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] platform/mellanox: mlxreg-lc: fix error code in
> mlxreg_lc_create_static_devices()
>=20
> This code should be using PTR_ERR() instead of IS_ERR().  And because it'=
s
> using the wrong "dev->client" pointer, the IS_ERR() check will be false,
> meaning the function returns success.
>=20
> Fixes: 62f9529b8d5c ("platform/mellanox: mlxreg-lc: Add initial support f=
or
> Nvidia line card devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Vadim Pasternak <vadimp@nvidia.com>

> ---
>  drivers/platform/mellanox/mlxreg-lc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/mellanox/mlxreg-lc.c
> b/drivers/platform/mellanox/mlxreg-lc.c
> index 0b7f58feb701..c897a2f15840 100644
> --- a/drivers/platform/mellanox/mlxreg-lc.c
> +++ b/drivers/platform/mellanox/mlxreg-lc.c
> @@ -413,7 +413,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc
> *mlxreg_lc, struct mlxreg_hotpl
>  				int size)
>  {
>  	struct mlxreg_hotplug_device *dev =3D devs;
> -	int i;
> +	int i, ret;
>=20
>  	/* Create static I2C device feeding by auxiliary or main power. */
>  	for (i =3D 0; i < size; i++, dev++) {
> @@ -423,6 +423,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc
> *mlxreg_lc, struct mlxreg_hotpl
>  				dev->brdinfo->type, dev->nr, dev->brdinfo-
> >addr);
>=20
>  			dev->adapter =3D NULL;
> +			ret =3D PTR_ERR(dev->client);
>  			goto fail_create_static_devices;
>  		}
>  	}
> @@ -435,7 +436,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc
> *mlxreg_lc, struct mlxreg_hotpl
>  		i2c_unregister_device(dev->client);
>  		dev->client =3D NULL;
>  	}
> -	return IS_ERR(dev->client);
> +	return ret;
>  }
>=20
>  static void
> --
> 2.20.1

