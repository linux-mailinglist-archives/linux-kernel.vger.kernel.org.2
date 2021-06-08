Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B152839F7D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhFHNak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:30:40 -0400
Received: from mail-am6eur05on2055.outbound.protection.outlook.com ([40.107.22.55]:47840
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232790AbhFHNaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:30:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFAzgF6ibKGe5F+9XGnBvvIfEPLunROrmsc8JOuUaIBaLV9tv/Jyq0ZTGrXmBfIeVOWk1qHZbIKfQlrpSPeBDM9PwQGLZvrrqxuA1wlvMeesFCaGBWj2IHK9P5I0AqJRCbqeV392qlbWANu4hx1RVey+c+pYATDXcNaOy3Ld+cLGAXGT4Ah+B14u3K4lfWtN2IX+ZdpaeWzJeZ6BoMady+m0EPaMCae8agYBrQPwjvbO/XnBbOGQHqIotC7empSizsIdgyS17/jkTgRy4nHdUetNveHkFnYNiV97BTTeApTdfPthDKQyd9DwnynVuAJo+BWUR+sUh3I0onmcZAmiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNMfqQSb3a7V7ScBTkgBJmgdiZPqQfvOEnO5Epe+E7w=;
 b=g7kUcRpon1hWubePfy72895towFIUQhSD4pN3HQbef1QOpEmGBZUpYSnJuWS+2z1w8q21kI70onMoRU1tZa6Nd38Ctkdi7X1v/ovOPdOlOv9MRsM8HR5nlnm1RoERTjPLCyPKcRB1tP2eV2RCNgzhnCUvdpRgnw6mOI+ksuWRs0PvBEg/5BYT7l7K6qzBdWiwbYjTEAYrz7vnYU/rHs3+mstz3Cn+08o9niL0C9vOqp3smxqUEpjj9q7kTp+okYDcmrZZql/gc1aUdJATkWT7JWwfDNxcU5ETOsbLBvJ9XEWNGqgy8nmLpycsJx5k+Givng0S0RnHFZft5ixnSHp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNMfqQSb3a7V7ScBTkgBJmgdiZPqQfvOEnO5Epe+E7w=;
 b=kynVBghK49CnNlGrqecfpJiFRSee/seJRjmugaNvb6jxWhGcZTnpxkNRb0IiR+3g7x9mwsFUN+xgWyZKy4QObtvG4TZ235EEWYdnrtuxd802boW3mCQOXJWp4Jzwpnzxa0QtSRz0pKULSUBgqJCDSCSjGR9sJ/I3ZlZUKM6nU9o=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB3644.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 8 Jun
 2021 13:28:41 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2077:6ae:22c9:ed0d]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2077:6ae:22c9:ed0d%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 13:28:41 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] mfd: da9055: Use DEFINE_RES_IRQ_NAMED() to simplify
 code
Thread-Topic: [PATCH 1/1] mfd: da9055: Use DEFINE_RES_IRQ_NAMED() to simplify
 code
Thread-Index: AQHXVrfGOuYCvLPDy0+c06KZSgaqzqsKJoGg
Date:   Tue, 8 Jun 2021 13:28:40 +0000
Message-ID: <DB9PR10MB4652946202263662E8F3DB4880379@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210601072830.10310-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210601072830.10310-1-thunder.leizhen@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.196.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 483430e3-d961-4f31-f5de-08d92a8154d5
x-ms-traffictypediagnostic: DB8PR10MB3644:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB364462A40701032CA186B41BA7379@DB8PR10MB3644.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7XIGIM0jbP3AIo14XQ8t3XUQKWiZkoyzHAD4hI/6xuZMzHITxNHBdROYLCsy8BhFfaD1K3nWP3Zj/C/ZwEFkemEgAY22CvLG7NLjoehwt0OGjofFWfEaJYtEAsKK3BtlvZSTP3VVpdyt9biCSigxe6wy9Z9NWoAhQNx+2Ho0bIaQ+TyHLSsHAgmLbtHYyuSDWgzfKFE0cxYWsInd9z5Ti3NiTvTBn/R3tEwny/MhFeK2iKz+XBRFS5dKvEKsQ6TZl0/KrlHpOAx2tqiSjvwGLb5KHgdPMS9Fol1ZCIcoaO2xrzeJeH03GdAi3HHJld9yhUQ1E9CbrdmLhh9hB4P742kXeGhRedXsr1sn8916HlBDbf0zdlgM8n1kbEfX0d0o9yfy9D+7G1G+XWyA0Bb0kzOmGwvAuBaaHefoSVK8BVbGOKM69ycLOvdhOFTExQLEMTnxJhfrlGZ/eKOFk+nZAMtBxrZ4ULKBocFO9g/x0jLZdu3zaSr/x6UMhsCIV8n04Z6s9b2aJBGA6VDHnyED3bxuJXhyCg/dBEuh+IjfEkFaZYMu5A1IpvMDn8DFOMFcwFwLXUbY4Lds1YISvP7pXtPVQsoogNBvOaWELrvk3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(55016002)(9686003)(26005)(53546011)(2906002)(8676002)(6506007)(110136005)(86362001)(33656002)(71200400001)(7696005)(5660300002)(498600001)(66556008)(122000001)(64756008)(66476007)(66946007)(66446008)(76116006)(83380400001)(55236004)(38100700002)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4K3eoN+sVtjAfe7Yoe15oyuFy32sXQu05URTsAp4m7BhclKxA16Hklnqi8nF?=
 =?us-ascii?Q?zemAdyn7aDgbuJPwWXx91GMFrdRslLE8Q8K3a6kehYBJkHC2hXZu27wZ63LX?=
 =?us-ascii?Q?AqK5CQEKRkmYIbzJ2fEaAz6q5xY4GyHHfRQEOwe8n7hUAMtkWdGWdm1OVPCx?=
 =?us-ascii?Q?Opr6LAe5m1oEEsWUG2Zy7AG85KicsFyjyovJ710Gtz56YO5D8aYg5Kq5GNa+?=
 =?us-ascii?Q?fH3KBLoUPrOF8z7wpyxhlhywQLtIfJQnCKsCpgltBw3hLAtg3S4DBSb2F4Wf?=
 =?us-ascii?Q?ARWfKBy86Wgn+z93B10PIkdfz1W0FyfAJ0pH+uu9Z5RjeahYc6VsNkrvR92H?=
 =?us-ascii?Q?iOsYCm767xghWuVh+m73KL3dZ3zHO9J9f6uXY5vyC4Quhk881j1bTsaMhudZ?=
 =?us-ascii?Q?zJv3ZjZFqkTdMDVZJGoa15I9sacfR9vWcMJF/Qle0oAhxllEm/XDGPwSKjkE?=
 =?us-ascii?Q?OSzZJDBP5riutCPXjyM3Lb6sva0/CONzJx44p+HvXjHxh4F8ZlLkvuUBNNf/?=
 =?us-ascii?Q?c7U8h6EySNLcqsNpYuXt/cvMmGxgXcMeh8paUlK78c7aAY0GrAcJ+j1Vyfzg?=
 =?us-ascii?Q?CC4Oecg+5s67kViagFm/5u6fVMrOoInIHiEqVuzJtWcRvqqidQLiE7CZn8X6?=
 =?us-ascii?Q?VPhrGIJxSZcDoATC5vCvsKNUbK/mC2DhYYsj124Oqv4QnP6G4UzJoRugkMnZ?=
 =?us-ascii?Q?F1vt16T3u0q7HDphhoMzTEbZChgQUMHPcsSzr9SiJ1rpoq9FajWqRmEgaZjL?=
 =?us-ascii?Q?mOUtXgb2aNHWwPIaVjXieOJMYEOFXRtkxROCzAxF1RwUhvNaU24NGnm2hI8m?=
 =?us-ascii?Q?XDPxU6hbMDUHro/Ri/0nvjIzJNtKvzTmFKObqTsjUW3K+mHFKer2IAsB0Xh4?=
 =?us-ascii?Q?MJgz48SItjEGq3oQz6Beb1AXSm/bArRr/Eyn7rUvYYBrx3SBDcwktLzNESDn?=
 =?us-ascii?Q?1AQAN82JPNP+oypf9M5VV5Ii2wVQLgLQzUK9GMH+WfPmLR3P751BbnJG1rR4?=
 =?us-ascii?Q?HLNoNFwMovQTut/kr+IHcvzPAs2RTsP56YVRKZszrfCTbzOJ7o0qUscutc5g?=
 =?us-ascii?Q?rD70UnvOR4UmGoyOrSOECLDd06+GW30ZXskh0OwiwHGQW+e0kemkOdEGS6wj?=
 =?us-ascii?Q?RR2k+Hg41aRnp9jQLvGihaJyreGqgBrN1AY7YloFcr7+12MC80HIq5SGLnSo?=
 =?us-ascii?Q?jvi4uiiRnOVc6qHYaunXUTvadrRqRgMH7yZ5d2wb/RixBFOtB76uJxtXxjao?=
 =?us-ascii?Q?BecJvxj+eiueMrkRLWlswcJKc9nXP8YzQvtz3ozY1hvapwtVoFBdB7bQe4Dr?=
 =?us-ascii?Q?+gma797mZvtVwaXYa5D7mTpK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 483430e3-d961-4f31-f5de-08d92a8154d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 13:28:41.0130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5df3dQYk+08+NtbbUfPflEbahH/mwCkR9HldaO2ZfVh/+Hoeq1Wmf3jhKWJ5VIcxDKq0fDb033mNq/vEFbWp0rykSyRXjRc9i2I5Rilda6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3644
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 June 2021 08:29, Zhen Lei wrote:

> No functional change.
>=20
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  drivers/mfd/da9055-core.c | 38 ++++++++------------------------------
>  1 file changed, 8 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
> index d074d213e66170b..c3bcbd8905c6cfa 100644
> --- a/drivers/mfd/da9055-core.c
> +++ b/drivers/mfd/da9055-core.c
> @@ -254,41 +254,19 @@ const struct regmap_config da9055_regmap_config =3D=
 {
>  };
>  EXPORT_SYMBOL_GPL(da9055_regmap_config);
>=20
> -static const struct resource da9055_onkey_resource =3D {
> -	.name =3D "ONKEY",
> -	.start =3D DA9055_IRQ_NONKEY,
> -	.end   =3D DA9055_IRQ_NONKEY,
> -	.flags =3D IORESOURCE_IRQ,
> -};
> +static const struct resource da9055_onkey_resource =3D
> +	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_NONKEY, "ONKEY");
>=20
>  static const struct resource da9055_rtc_resource[] =3D {
> -	{
> -		.name =3D "ALM",
> -		.start =3D DA9055_IRQ_ALARM,
> -		.end   =3D DA9055_IRQ_ALARM,
> -		.flags =3D IORESOURCE_IRQ,
> -	},
> -	{
> -		.name =3D "TICK",
> -		.start =3D DA9055_IRQ_TICK,
> -		.end   =3D DA9055_IRQ_TICK,
> -		.flags =3D IORESOURCE_IRQ,
> -	},
> +	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_ALARM, "ALM"),
> +	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_TICK, "TICK"),
>  };
>=20
> -static const struct resource da9055_hwmon_resource =3D {
> -	.name =3D "HWMON",
> -	.start =3D DA9055_IRQ_HWMON,
> -	.end   =3D DA9055_IRQ_HWMON,
> -	.flags =3D IORESOURCE_IRQ,
> -};
> +static const struct resource da9055_hwmon_resource =3D
> +	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_HWMON, "HWMON");
>=20
> -static const struct resource da9055_ld05_6_resource =3D {
> -	.name =3D "REGULATOR",
> -	.start =3D DA9055_IRQ_REGULATOR,
> -	.end   =3D DA9055_IRQ_REGULATOR,
> -	.flags =3D IORESOURCE_IRQ,
> -};
> +static const struct resource da9055_ld05_6_resource =3D
> +	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_REGULATOR, "REGULATOR");
>=20
>  static const struct mfd_cell da9055_devs[] =3D {
>  	{
> --
> 2.26.0.106.g9fadedd
>=20

