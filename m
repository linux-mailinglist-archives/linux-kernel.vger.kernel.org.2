Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B2320FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 04:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhBVDq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 22:46:27 -0500
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:21846
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229952AbhBVDqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 22:46:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcS1kdxGuNgo6P5lc0rdOtX1zfQWV7U0NeI0o12Zy67RB0XsLG6dtqZ4sUyGvMsAuygExbYV/Q5x+4xNXHXsS+HgYp2ld2+muZrsXmrvr8WePBKq3yfuevuRYZhfE0XIfBkXe+ipPtljXa6PCflTaWC4ctIFAYoIwsdHKU+KBS4Qn8PxTre6NXlL5euV7dTQ4d4HXSfHfQ7KWpQ9ce7gdCRUwdcAvp1gbIkJQGV7ut56BMgs7VLIpI1aOJ1QHfsRjtE3E0WafzKxJMZUSsxPZ6dAIMX74oqgqdrtTlZ7iKoHG3ZHJ1GsCQ0nUtC4t4KVA14vk/9rjm6mB2ibN6cyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jZESbKXyOCo3kcSAUkd/3+d+8BNIQI/ICpzRO3lUYg=;
 b=Vm+JMsQaDrkqPSWEmBUJM00GClTgvV7qyqddPAAR6BS2LdM3FT0Z7AbiLIxTtudXXod11X4ceOK50SxFHO3rMCpOZOsXhuEyPbsxNQ5gOu8Dan0G6F97GkwQ7eJPf+1UgRfyTMhQewX+R+nWEVoBSxd8o2Es77Jh2GyYW7b9mgfLnZl6SyHhiO+HpE8onTvVoMGsKAZjT0EsviAcZ6DOnhGYpOM/ZnNImyBR3JEmZrdCQima4f7dGy6IIyak2U0hRL2kz0JYnauB3T042Q3LjyrgOJChUW0SgoNIx+ruq92Zr9wT67H1c+7AUypdR3kdBCNLa4PjObfbKL2OoX0FOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jZESbKXyOCo3kcSAUkd/3+d+8BNIQI/ICpzRO3lUYg=;
 b=MHtsNSrNJs9G1Q2QIF39UJ+AYhXi/hmIodS5wxW3700sYr9lroQeq7ugKW0vYSiRp8l9pffHlafH3L7/s42/cqR4/NWdpzLiv8o47TGM+Y0LJ3vgccMe37WBxESqYqNzAv8C5GdWZwlUbvRadd2uAbwnNaIB9bg2M8ONpZLuzIc=
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MWHPR1101MB2317.namprd11.prod.outlook.com (2603:10b6:301:5b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 03:45:13 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b%4]) with mapi id 15.20.3846.038; Mon, 22 Feb 2021
 03:45:13 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: RE: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Thread-Topic: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Thread-Index: AQHW6uDlVrPMRNLctkuz9Bvou6uZzqpjw5uQ
Date:   Mon, 22 Feb 2021 03:45:12 +0000
Message-ID: <CO1PR11MB48497CB7B11EDA65A3941FDCF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
References: <20210115015050.26657-1-meng.li@windriver.com>
In-Reply-To: <20210115015050.26657-1-meng.li@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a37080c-58cb-474f-7227-08d8d6e4428a
x-ms-traffictypediagnostic: MWHPR1101MB2317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2317B8F5E93E4E6DB14A0BEFF1819@MWHPR1101MB2317.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7Eia1+36HYoF7A//WIOd+6r4jHHRGm4dTikdORnddguWXaSnqABhfosXlJOZhRALwUY68Ftd5xZt6VWzu2bnTmohg/oWBDm9JpHkyKcvWYjCwfsFl56x/+ThW8lf69sxQOLZyM96IuM5AccWWACG8t+7C474zgdJ1LET3pbUN8s5NoGfaNA4Z7z7wzaQxrh6l5kyJsx36lBaN5e52LcJfUMPigsXxnT8ceqA6FdHBLzVShacnLNS7abzFgWcxHJP5IAQg63SobR4d0MWxuHVD5daW5SCkREoWr05ZVoONHqQyVuBFfSAF+0smo8H5sN7cveVHyiUGjAzwl1dG//Mvg2T4dTBAmTc7AkF3K08a02m5TfdG6pIdHezd3+BA4Q5ZI/XfWeOPquR7sjbgkaThWGSKVaw/jGqxoq2eTXU+TejOCrMePWgT1s9DI+OaMKQKgswqaNc1Ehw3StIzfUBmHc+EknlVvqGGQLpG7+TGJ7oZ0U2S7dAO858PUYk1gaxYimg8dyCheShV09HGiBpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(7696005)(8676002)(33656002)(83380400001)(55016002)(26005)(2906002)(478600001)(53546011)(5660300002)(8936002)(71200400001)(6916009)(52536014)(54906003)(186003)(6506007)(86362001)(107886003)(76116006)(66946007)(316002)(66476007)(66446008)(64756008)(4326008)(66556008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CjJDzMwTU4aF3blRy4GVrA4ioQoJIXw4XaaP2G9aGhQwTNTZE1/vQSd7xoJ8?=
 =?us-ascii?Q?Uvu/lm+lmYOqPoj/OtgLdIUDPi3oSwlYBwLtUWXsqTZd7XYmDKCEzCW3Zcb8?=
 =?us-ascii?Q?4pIInQNuZXT8ST5BvMAsMJAreiE0akG/CZ4XUYShFgXdFWai5U5gEvHFxGJ6?=
 =?us-ascii?Q?x+FysdLLLTOiM/FIfpVm7nqgtLJJlzV43HWj2yGUwdW4vaKcj+SFO7ORdh/t?=
 =?us-ascii?Q?UbpCbCsCiadjeaizwmL95aBij5X9qaF0+jqE1NeIMTbldMjMfkxI51T1JwPv?=
 =?us-ascii?Q?T7vCLIzdAacZFo1Ttf2uYlBVDKNlanhrAjVesujUNjQ31tHhtBiQZXlSDcFg?=
 =?us-ascii?Q?sOHz18KqjGaQYJIDWezjJ7MzYfPvre1W0tVfRoierefAK/Gv6w+Mgjsjg+qF?=
 =?us-ascii?Q?cX9vAIcM8bwMm24NBLBynPzrA3CG4ywXD9daWxyshsr53131ALeORhcP0hI3?=
 =?us-ascii?Q?aH5Q0JArDW+jNUBkNHZfo5ScfchtqpYXFdqcMSSEaNRPsMRl1AYrC4NiBEit?=
 =?us-ascii?Q?NylshhQSo8KDE8Qi3mQ1RcOjOXzYiGxXEs4hvViPpvr5/wSPeoh1PYZQheHU?=
 =?us-ascii?Q?Ha2CpjkS6/cQ5xAHBgh0HMyQeocEFS5eGNId3cChX2nY8Rbe054nsLV+8Eem?=
 =?us-ascii?Q?c1uYtTKtvCBZxt4LJDZGDdLy6vkSLnlTBA04NqWwZbKFeuGUhtn+W3Cu5Gug?=
 =?us-ascii?Q?819w5CeIGxvm0CwC3w8n+iYsAYFmTwtGO9HEO9mXq71uLg54zGcyYwxQs0uF?=
 =?us-ascii?Q?tBKb5LHVDzePC4o+V4xqSmfMz62U2wROMpVnzxII5R79TKQuHOmo7Od/EjKN?=
 =?us-ascii?Q?qlHrKu5OUltz0ion20EkC2lZyIAOOP7Q6Zli4p+Ze2eABFFAEWoMlvqAuodf?=
 =?us-ascii?Q?ybkVchST6ajF09zepj54JoNtPnY+vzGuWTm03Vjbb3jTm2DRRowXiD4gGq1p?=
 =?us-ascii?Q?Cl0P+qYS6fV+Glu2FnpoD/Lq1N0nEemePufmHd53h7vREue7HLHKNOcXanc+?=
 =?us-ascii?Q?mzi29G4WI9ms09JjhyPDr1r4PyPcO7fnIlLdlzpbecWWBYVsyotL6Kuw/OYm?=
 =?us-ascii?Q?vVQyovggrvTWMKRTolPPe92qqisG6rIoEeKy1gwlCImlAdsHDyBmvayx+7df?=
 =?us-ascii?Q?ui4rPBWzjr+EL7hxfMQN/lsIK3C1lMxx/JZInS2h11IFit6vjSWNQzhZnFvb?=
 =?us-ascii?Q?fI6iW/XUU+F1Fh3DYfhhaWYhK9jg0P8yDyMXp60NnfowzpeczEsQPtSnkJP4?=
 =?us-ascii?Q?hJ4e1y8ETSfwEuMzerFVoblK7wQ0Xm1B0TFL1VJ0sB+fZ9e7Uijn0Sl92or+?=
 =?us-ascii?Q?1mXpYD490ELbVyJV9yjkTIUa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a37080c-58cb-474f-7227-08d8d6e4428a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 03:45:12.9375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03hep9ExO62+UkbOrJnBBr7SFfd19ajD3t4xJZoPFHP1/dOQ2dYvOg4NAmA2dnh59nzpICSvIRqui52AiV1fGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2317
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc&Lee,

Is there any comment on this patch?
Could you please help to review this patch so that I can improve it if it s=
till has weakness?

Thanks,
Limeng

> -----Original Message-----
> From: Li, Meng <Meng.Li@windriver.com>
> Sent: Friday, January 15, 2021 9:51 AM
> To: linux-kernel@vger.kernel.org
> Cc: maz@kernel.org; lee.jones@linaro.org; arnd@arndb.de; Hao, Kexin
> <Kexin.Hao@windriver.com>; Li, Meng <Meng.Li@windriver.com>
> Subject: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
> regmap_config"
>=20
> From: Limeng <Meng.Li@windriver.com>
>=20
> This reverts commit 529a1101212a785c5df92c314b0e718287150c3b.
>=20
> The reverted patch moves the memory free to error path, but introduce a
> memory leak. There is another commit 94cc89eb8fa5("regmap: debugfs:
> Fix handling of name string for debugfs init delays") fixing this debugfs=
 init
> issue from root cause. With this fixing, the name field in struct
> regmap_debugfs_node is removed. When initialize debugfs for syscon driver=
,
> the name field of struct regmap_config is not used anymore. So, revert th=
is
> patch directly to avoid memory leak.
>=20
> v2:
> Notify the author of the reverted commit by adding Cc:
>=20
> Fixes: 529a1101212a("mfd: syscon: Don't free allocated name for
> regmap_config")
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c index
> ca465794ea9c..df5cebb372a5 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -108,6 +108,7 @@ static struct syscon *of_syscon_register(struct
> device_node *np, bool check_clk)
>  	syscon_config.max_register =3D resource_size(&res) - reg_io_width;
>=20
>  	regmap =3D regmap_init_mmio(NULL, base, &syscon_config);
> +	kfree(syscon_config.name);
>  	if (IS_ERR(regmap)) {
>  		pr_err("regmap init failed\n");
>  		ret =3D PTR_ERR(regmap);
> @@ -144,7 +145,6 @@ static struct syscon *of_syscon_register(struct
> device_node *np, bool check_clk)
>  	regmap_exit(regmap);
>  err_regmap:
>  	iounmap(base);
> -	kfree(syscon_config.name);
>  err_map:
>  	kfree(syscon);
>  	return ERR_PTR(ret);
> --
> 2.17.1

