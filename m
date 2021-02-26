Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA5325B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBZCUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:20:08 -0500
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:17760
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229498AbhBZCUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:20:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZeZQfHAmpClhivF8ErJ82fk+H0eUe8wCxoKLNpM1EV+IjoCSiFuHhUH/gx7t0i5AnWmJtwPSrfXmd/6KaQZHx7f8TkLlLqW3gzmjnFfxYq3q9+DckzQYCEj0GzzoiJnabhB64msn+Xvhr2srbBLa0k+ASq5yoe+jtjTDoIHMqTGPN7HqogF389kcgSPJ0ywigheR9kLuEV8amCmGYXdKNcII9hPxOCuYEfbbNOR2bH66deX7FwWPAJzySR+3IXQGNsfGjYKIXRObboJNTYgn8yFvxaldv7blkqAsFP4tzgMAKa166aMKqPz7dOYWsVklsHYTCWhIXTNkrRn/R2PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEDsMZURRw6iWH7C+wPgPUqXu5TH/H6Kr/7iz2Mdp9U=;
 b=QtknCxkKmMkR3Gvea6YN7JzKBatX2DRaTh6ZoCDKXgEFP3locz4e9rR7cxRZIqoT5TewQngXqO8UQUdy7EQYse6yl7zCth0OY8Vt9RD7TLc8EdPyQoqfB4NJYuV85XjykNB/K5jQBCVJvjhDQMq0NEYTZMfdnwt8h9+nEkEtgiqzeBA5hYmI/lXsIFNWPKaI0CRtrz1D+3ouOkd6BO4BUBK1iJKL3kgSwAxghtRBeUEPagm+ZNiyjKnmon/vleaOzQHp0UIHORrocgZeuWtUsn5m5gzTlh3StJ8+ZU8vqxj6j25YHiSHIn10CmOTNc3eLwLL6QH5sCfQOTVwiBAj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEDsMZURRw6iWH7C+wPgPUqXu5TH/H6Kr/7iz2Mdp9U=;
 b=H8d8t6lBv0lx1xB9RUyKc0+tuHu+qPA+oRrPl6/2LuBXfSGihbBMYy5ZgBnwrlAHftJe/6M75lhDGAH9HQhbWDqWSz3/1czjLerNgDZ6LObqXTI5mHUtWd3OxUqxY3SzYgiWwt8mQxBJ7RnB+noB1hmZBZBZSZEVTOc76B15lMI=
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Fri, 26 Feb
 2021 02:19:18 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b%4]) with mapi id 15.20.3846.047; Fri, 26 Feb 2021
 02:19:18 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: RE: [PATCH] driver: regmap: set debugfs_name to NULL after it is
 freed
Thread-Topic: [PATCH] driver: regmap: set debugfs_name to NULL after it is
 freed
Thread-Index: AQHXC+VQbKvf23UuvUqged6OHJOU66pps3pQ
Date:   Fri, 26 Feb 2021 02:19:18 +0000
Message-ID: <CO1PR11MB4849153C5E31137CADDD250FF19D9@CO1PR11MB4849.namprd11.prod.outlook.com>
References: <20210226021537.7530-1-Meng.Li@windriver.com>
In-Reply-To: <20210226021537.7530-1-Meng.Li@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3426c9ed-3c2a-4a53-8f96-08d8d9fcebbc
x-ms-traffictypediagnostic: MW3PR11MB4555:
x-microsoft-antispam-prvs: <MW3PR11MB4555996DCDA748EBA1F2044AF19D9@MW3PR11MB4555.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CthQBAGEMtRPhc1cgv20tAOp0rHLMSMN7EXQ1+WGfdoC7mVSIrhCAHfi9DorgY1QMT2yd0a9U0ZFB5OgGw5ZVGLTQM6mudSFvVLIRoCqePdhXjpLMZMuKORevASgSfQeqrxhobXoeFqIsPE5hhSC2bWbvpOzznlmDFa/e++WPudJx/mLHXuvKQJrGHUflzxEk8DQNkK73veWvdLKgrcB+mZn85FTW11jY5P99y0tofva1QMmEwN28gdaRGQgYNzVyRj403i9HaBLV372wJIacTpwWaCNGHifRTqTa8kHnP0oJoRRiCHpOlI11PhJFqkCsNp1Eo96r97c3d5MKUJzl6YjxP0NBgwMGz1uhJjDE+6JCqMXSrQNFZejSTYeOhFg4ZmBKw02PTHGSnnFB57D2iSt71+knuMkfCwNKmX6V/Pql4EEFXjkHBYd/OqeACygzWYmadmntV2cxCpuY3HYwsQpu9HznQQxc4MW8Os6e2+62sz/nZNCht9BvEMM85jZw31mqt1UczaDjwdITweKZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39850400004)(396003)(346002)(55016002)(2906002)(76116006)(26005)(53546011)(8676002)(86362001)(186003)(71200400001)(9686003)(478600001)(6506007)(5660300002)(83380400001)(316002)(110136005)(66556008)(66476007)(66946007)(64756008)(7696005)(33656002)(8936002)(52536014)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Z2aVKvf4U9x/frQA+A9Tx36kNMS8QkT2FkSwIGbMJkLQeSW78Yoe45cFO7D/?=
 =?us-ascii?Q?iRNdigD7EN8e1D8FU5kncZivdypNs3wtFEi+BoiHOsvdjGlDqTTufpoA3bsX?=
 =?us-ascii?Q?7VmR7upWyXAcZ5xLEMVScviI9oLb+d7g7S5HxkBdOrf9TX3WeqSySX96K3sj?=
 =?us-ascii?Q?xEosrdflhqxM0saZRG1OYtA3PPlWUnFfV1uamlnv8ozNdPQRHC7tpXIab4GW?=
 =?us-ascii?Q?cdg1MLD3tr6rGU2fts6n8IpNWPO03WpBoZiq+BydObYQBN69wYAxygyWnDGC?=
 =?us-ascii?Q?JZ2lSD771tUqdnDHGk3UxGnPKRXCaff+Mn0XS0RcsrhDBef9Z4MpPTfv39nP?=
 =?us-ascii?Q?Vd38JkAxLAfRfZ2Np2FzopAidvGm+e6QAooLLHmS7M3sWYkVIN5R5nl7f0BY?=
 =?us-ascii?Q?6UmPVz2AyM4ZgmBtuTWHVcVIA7vqvoJh1lDOM7bSnwQyRwfaM4mvI/UxOi4X?=
 =?us-ascii?Q?hNLZiM5YmSIskp181Ub+/1nN6yPDHKeBgtY+Jva9SLi+wc3OJSZ1Eeckp9V0?=
 =?us-ascii?Q?QrDBooOn1yT0GmzgR14VraUIQro5/QZo+fDKjb1gdgM3TUTXcOqpOSY6SV47?=
 =?us-ascii?Q?U555miZRIWzVlFNHGFSEiUL0w+xv7u0eGlOMvvWRrSQ4G/0mS8LmLQBjyR5O?=
 =?us-ascii?Q?s2V5figEeG3VjN+qE5/2oENRqUC4ruAa7PEcZ8UzNiNLdGMiRsogQqkLl72o?=
 =?us-ascii?Q?iqb2O644L9ZSXQECwqUGxDCSWokAVFepBSI6elnJmj4iA4EBXK8K8VDTPxym?=
 =?us-ascii?Q?24kIVWWn5suKF9f3m8SUuemx2k4ICqsblsaGHY02QlF6A9+x5IvACvHTTdR1?=
 =?us-ascii?Q?SII3TrUGwYp+Oig8qrQxQ3KlNDCirZm1ndiRo5aBh3GsvUMGUhn+d05UiilF?=
 =?us-ascii?Q?0BC6jEps94bkT4MGRZtYoSCTWSpK/waRrV6c9bWjr+v1TzxbbezG4L329Kwg?=
 =?us-ascii?Q?yr3FV8oRiN2c3z3kkcvU/xYIKI6zx7YY4AXZq71GQL2P2+72V1aBd9Cq4K1L?=
 =?us-ascii?Q?JA9VhkkEHkUB577kR/WCvv1I69wZaRvZTQsRFvQjHyoDSS2NeAOLQ4zs8Y02?=
 =?us-ascii?Q?6JhuYegZRzwdiTJO8m6PMWpQ1D/jGqJwLH/15PQKrkKwRvidZtUJOJDBZazB?=
 =?us-ascii?Q?gCi4Mfxp4+hgliR2C4HyV9k9FWJ4WYXY7BD3TGmBxf1wrP29WmuUBhGzX1Vh?=
 =?us-ascii?Q?WknTcJHGdwRjZwszGo10bG60SbNknPx+mBTCxjB6WvqaKI4dJpt7DJycCsbL?=
 =?us-ascii?Q?k5F3tfolrVhCj7K67ZuxuwtblAmiD1n3JCbZkjM1yLXvUUcEuOm3cltxB8Lc?=
 =?us-ascii?Q?TSdRTgvL0h67/F95RiAg3YE3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3426c9ed-3c2a-4a53-8f96-08d8d9fcebbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 02:19:18.1460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APPTRLch75dOzydTS8+7Gqs9Py2zIpo4bdSwXQsCTQsl4ygew9Fdn/h7AsSxqrw45iL5V9+gvlY/jLhEXKUHLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4555
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please discard this email. There is a wrong email address in TO list.
I have sent another one.

Thanks,
Limeng

> -----Original Message-----
> From: Li, Meng <Meng.Li@windriver.com>
> Sent: Friday, February 26, 2021 10:16 AM
> To: linux-kernel@vger.kernel.org; broonie@kernel.org;
> regkh@linuxfoundation.org; rafael@kernel.org
> Cc: Li, Meng <Meng.Li@windriver.com>
> Subject: [PATCH] driver: regmap: set debugfs_name to NULL after it is fre=
ed
>=20
> From: Meng Li <Meng.Li@windriver.com>
>=20
> There is a upstream commit cffa4b2122f5("regmap:debugfs:
> Fix a memory leak when calling regmap_attach_dev") that adds a if conditi=
on
> when create name for debugfs_name.
> With below function invoking logical, debugfs_name is freed in
> regmap_debugfs_exit(), but it is not created again because of the if
> condition introduced by above commit.
> regmap_reinit_cache()
> 	regmap_debugfs_exit()
> 	...
> 	regmap_debugfs_init()
> So, set debugfs_name to NULL after it is freed.
>=20
> Fixes: cffa4b2122f5("regmap: debugfs: Fix a memory leak when calling
> regmap_attach_dev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/base/regmap/regmap-debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/base/regmap/regmap-debugfs.c
> b/drivers/base/regmap/regmap-debugfs.c
> index 398991381e9a..4f2ff1b2b450 100644
> --- a/drivers/base/regmap/regmap-debugfs.c
> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -661,6 +661,7 @@ void regmap_debugfs_exit(struct regmap *map)
>  		regmap_debugfs_free_dump_cache(map);
>  		mutex_unlock(&map->cache_lock);
>  		kfree(map->debugfs_name);
> +		map->debugfs_name =3D NULL;
>  	} else {
>  		struct regmap_debugfs_node *node, *tmp;
>=20
> --
> 2.17.1

