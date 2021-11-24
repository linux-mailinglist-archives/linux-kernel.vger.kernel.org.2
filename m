Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058EA45B791
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhKXJiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:38:01 -0500
Received: from mail-vi1eur05on2066.outbound.protection.outlook.com ([40.107.21.66]:36736
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229675AbhKXJh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:37:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3evuh+seEe/T+Xx7UyN0fyir5Vqm1qqn+44Rm9/0ev3M3+vc4zjsVtiavpsAaYMyCi05PBPvEJIKIzZUarlJciUFrg9B4pVc5SbD/9YQjzlqsz3NsUDn9E1C7N++g2ima4MABDdBWnMj2aIIEB4chOnXZnIvsFh3EL4572UgTQkO6jkkmhf7RgzTkMANE2KJ1FyUKiK1Wto3c9iLvtrPRcvAM17sgqOQmiop5zwfUXKSNCe3KEtxtpbk53hYYlTLDlIlxGeCzi7+pfhn4n51ExGH0oyDwRnsaEt8lPhGy+ZLyLhlo2DHW+/CVX9sg+arzbYvf6GuPVDN4YyO04m2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUL6XQrsYxqlQMvOqOelLVF7X51bdGzfe9a8mv5ov0U=;
 b=fpdFTLuey+0cPaD3oUpApjDQLfU3QCz5OATWE2yO8SLsdrMdq49B3IgP8Jmjh+CcH3e2Pwb4dEPbOs5evR9ieW99ohP/PAxvxEMM/B+U0drlRbF55omqZ1HkC+MADW/o391woIJzNk7atH6iyLxGzUk4zFTMMEhPVGEf20wvBSuvuTgfYpRooqC8z7nL41QXpOrGUN2SytyR2q+3UZq40Xa9mvDn2RAc63NN8Erz+39Al+2SMA7XmZeBZ/mZc+cSf4fCt8tGqdYXgaqFjJmzpsana5C2J1eHg8W+Qzr7hCmO45qMKm51LlkhU3FgMCEl4lKy0vSfclh03uzapDrreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUL6XQrsYxqlQMvOqOelLVF7X51bdGzfe9a8mv5ov0U=;
 b=t2CIVIPd3lZi2l4wtmKN/cN8Xy++74CpsI2O5A9Jyr5paF3RYItaGUegNPJXspNLPHUzL2puTGY/h3aYPn2/xq7f7sqrIvExBVD4us7bVuR0xpyC+tewPkrkgz3aL6aH2GN4FB9lTGcApECfFLV5m+1D5qFuCxaZ+uauoSv3M+Y=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR1001MB1125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:63::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 09:34:42 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.020; Wed, 24 Nov 2021
 09:34:42 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.riedmueller@phytec.de" <s.riedmueller@phytec.de>
Subject: RE: [PATCH 2/2] mfd: da9063: Make vbcore registers volatile
Thread-Topic: [PATCH 2/2] mfd: da9063: Make vbcore registers volatile
Thread-Index: AQHX4QDrJvqufsfstUeKlqESd2v2MKwSakiA
Date:   Wed, 24 Nov 2021 09:34:42 +0000
Message-ID: <DB9PR10MB4652A195CDB7E237A0D87F6180619@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211124070001.2516750-1-andrej.picej@norik.com>
 <20211124070001.2516750-2-andrej.picej@norik.com>
In-Reply-To: <20211124070001.2516750-2-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5dee093-2881-4ea1-31d4-08d9af2da52e
x-ms-traffictypediagnostic: DB6PR1001MB1125:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR1001MB112518C05CE204D9B9BBC4A7A7619@DB6PR1001MB1125.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0W9XvR9rd6Ie/AjAJ5SMZKv4oVzi637MU2SAyneH182uxvGckXFjey1W0t3j+Sf62buFe1llVFabZXNDuRA20fHUoGXVB1L9XOUtheOjbLN5k/gmHiAmkA3RFlEqfGd+cl2p/hWvqvH53nu1ENftnId5KrLn7pvLfVPI7ZBf0+irhVfi/0HuvmKp2WgwTCvnW3CGQ8y/jXVfZ8tUNOp3gwsZ3XuXiaTp5pSHzeCj3utsQs02Wly+GJv5IySEU629l/P6HDO1eabN7aI6/PcO1wodD7shJwIzA0pvVdAIpehCtjroSi5UEKDYA4kDpMYJOmS7XQm9Eu55pSLIuXy0HlA45cYh3P7Duo9oBu+Pm4l7maowr1xflevUSgdpTHYxwkgHsI/crf4cPTdR3t8pKkpRGA+GZjLsm2QIC6Rx2S06LZiAriDaMXjtGeO4fviJmauVRde9ZSnjXmaOF7X8DeTWCJT95F4Ey6Ay8wXAWhV3rCTJXYK6f93xSxupuJzmPeowWDT5T7f3dxA0Pro26FtcwBGrTTxIo36R7EUI0KNV+6T6fmd7PsD+dgenCsamwim0duhzIXFcsaWBNHVHoLoZk3QJU5aMzCVjba3v4c3VLQwtTC/3SDOvTb9yyctQ4pa5rlROXG5hcBqs7ipvOZcVKXCEEprMWzvkG4HKu8IG9DO/wCBWo5vNyWzwxTcpU7DL6rocJDHh2Oiwse2BKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(4326008)(110136005)(38070700005)(53546011)(26005)(86362001)(66556008)(54906003)(508600001)(66476007)(38100700002)(33656002)(66446008)(64756008)(66946007)(8676002)(8936002)(2906002)(55236004)(52536014)(6506007)(71200400001)(76116006)(316002)(7696005)(55016003)(5660300002)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WKCruyI18ERHqF0RpGokO1r5rW0x0GpCHErnXipMn47g0l3z60/zdX/Ft2xH?=
 =?us-ascii?Q?HTFhh94s/0/rSgxv89P7xkvdOrJQdC6XMDNhFrmmYKO61RISRn1rB4y5xcVY?=
 =?us-ascii?Q?9USMltjVmfWRGsM+4PEKbtdo7RyO3FStkWFsgI7ze5YqEKKUJ6TpZNfA7LiI?=
 =?us-ascii?Q?eyFZhxfyc9EsuCI0cSQUELNcQLFaVurDwB4rs0NBFOMDFDBRvISp4N2ARRXR?=
 =?us-ascii?Q?LH0eT1wFfiW/ifPgmDkKonjJlFwzsItLUZFXKp5gMXx/LuxBO1rHo6d9afMI?=
 =?us-ascii?Q?M118mU35Umk3sAuUceWbc14uRNpACkOtw8j6EG5GeS168+JpIIvinQ5kAwjn?=
 =?us-ascii?Q?9qeSx9bYGX8DKX8KZBftB8dfyWcQlQi9RWGHAlRTJiNAqP0r3i9gYMnXwfAk?=
 =?us-ascii?Q?TL7A7NWdvWJLtApGbLEsTS1RwIa1kS74cHqsX31n3gBK5o/mUq4q8J05reUa?=
 =?us-ascii?Q?eCdeEiLaBtpTGrtizyL2NkMo+fLGuye58vmjO0JXE3gUpUtOIVL3SdPjqmHF?=
 =?us-ascii?Q?b83JfOzpPtg84alCzy1OTWTRikq6lc+inXEFJRZtOJ9/zkSerPNKxfrNoJAR?=
 =?us-ascii?Q?H6j8ooT1hNJTpyReXKe2dfJZCgUP9bs1zsUKZV+wbD1upnYj/McS5C8UkJY8?=
 =?us-ascii?Q?3wsxd6Jmfs80j1/nJnFq6r25lnMz875w83rrRB4BUlOI7UxsIBD52dkou5AK?=
 =?us-ascii?Q?olM5/Pv3201Hx+/Hq/BBKw2D1c8ban0dPhwnXvRezdGLz0yTqlGLY9zCzI3x?=
 =?us-ascii?Q?nXfE8DxF7CfK92oWRIptuyHn+C7Vdnrrr5Cp2nQ03qEdUo0LrGiYyp7lJNFc?=
 =?us-ascii?Q?Qq5PhVoQcY7ciXDZHTDa4sxGGlYd+vl/AJsRbfWs3aXSG36p2U0f1gMID4vr?=
 =?us-ascii?Q?tioxJKS/P9mzXzZqE1prxm1XBpLpyI+lcWaIE+sXh2hiTH3MTqnX8aCZMWW9?=
 =?us-ascii?Q?WoZ7jUUOLMBjBBGHxtG25KLXGD6V4iUeFKawZbEK1KLKjrodwffHuFtvjz0p?=
 =?us-ascii?Q?3pmZpq+c3511H6D2oQguWYHh1WMB6tuL6ozxKbg+QtkZKcEjEuQl0CXWJ0bU?=
 =?us-ascii?Q?CNBSNIFJataciAvjpWUwO1lmY1WJZi/hkPoUvofpb7HQRRJOgAMPuoH5DTry?=
 =?us-ascii?Q?PiJUdxicGdPN/rvojMug8Xzi0Ab+3nu14b15kxRWHCcIMeV4ViKEs3CxTHhF?=
 =?us-ascii?Q?m3iJlIGNNQ5Jq0zAkt/lfkjQItOXHs92xEiQQKOIQDSxVytmqI4T8gOdFxdP?=
 =?us-ascii?Q?wPRwmW3LA5uEY4ypCOuvWuvSALCttDZ1JRU6B6Z1AfsZDB6Nf5+G2ikeMNYH?=
 =?us-ascii?Q?ciTCJPSV4lymXH1I4iGrilF+7TyTEqBC5UygHGLf8/Vz5FQb6/LIEqI5ZTxD?=
 =?us-ascii?Q?jHfP0QLIkWjQ3UJnvPEJDa4vgl+6DJFiTb57RHccxG+k511dLprQrHcaN69w?=
 =?us-ascii?Q?UYqgVEfH4ue0t+hzBG9gFiSdsXrNy2VRhIRhJfW9Mk2qaiS7+AMJ3ywQZ2SZ?=
 =?us-ascii?Q?acm2VohnvaC9ZUT9VpAO3FtyoJSfauL4zSj3W2vpYUbi/ABbZ30YA3SE84Eb?=
 =?us-ascii?Q?CBT4MtO/8UzriBwnuZD7SKyMNORamsYmbiJ2vx+rdJsB7zsuR5qDthjgv0J8?=
 =?us-ascii?Q?eKAcoQTBNUy0/NFQRkGCIsA6bVaUp/uPu089XI3vgDD0CZsDVRALiBNsHpuJ?=
 =?us-ascii?Q?mrgvGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dee093-2881-4ea1-31d4-08d9af2da52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 09:34:42.8615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ftsdS/GHDVUhhO3dfek8icrHTH/IMXu3Xlm4CoL+n0dOSLYS6olvcBaotCwSYoUJYLhYyTp9Q74wXdsAQ/AqHYzX3IG3TUc5qSx4fPhOeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 November 2021 07:00, Andrej Picej wrote:

> From: Stefan Riedmueller <s.riedmueller@phytec.de>
>=20
> The VBCORE1_A and VBCORE2_A registers are used to set the desired output
> voltage of the BCORE 1 and 2 buck regulators. These values can be critica=
l
> if used as input for core voltages. Thus make them volatile so they do no=
t
> get cached.

I don't understand the need for this change. What is this fixing? As I
understand it the registers in question aren't volatile so should persist.

> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>  drivers/mfd/da9063-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 343ed6e96d87..8a3629c30382 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -161,6 +161,7 @@ static const struct regmap_range
> da9063_ad_volatile_ranges[] =3D {
>  	regmap_reg_range(DA9063_REG_ADC_RES_L,
> DA9063_AD_REG_SECOND_D),
>  	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
>  	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
> +	regmap_reg_range(DA9063_REG_VBCORE2_A,
> DA9063_REG_VBCORE2_A),
>  	regmap_reg_range(DA9063_AD_REG_MON_REG_5,
> DA9063_AD_REG_MON_REG_6),
>  };
>=20
> @@ -206,6 +207,7 @@ static const struct regmap_range
> da9063_bb_da_volatile_ranges[] =3D {
>  	regmap_reg_range(DA9063_REG_ADC_RES_L,
> DA9063_BB_REG_SECOND_D),
>  	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
>  	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
> +	regmap_reg_range(DA9063_REG_VBCORE2_A,
> DA9063_REG_VBCORE2_A),
>  	regmap_reg_range(DA9063_BB_REG_MON_REG_5,
> DA9063_BB_REG_MON_REG_6),
>  };
>=20
> --
> 2.25.1

