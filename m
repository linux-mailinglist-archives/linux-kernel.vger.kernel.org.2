Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC23B41E711
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351971AbhJAFQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 01:16:39 -0400
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:50908
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230397AbhJAFQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 01:16:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC/FLhdVdge3gyhJLAwx15/96aKVWm5Fow23N9a/G84YomLBsR7zA/GaneFwKTiuoLG3pRJi51bQYjrheRTvZumudtCDtgcZq8MpArrvfmPwImG2CUFYmtLADFhErT8CoVhZZhdoMIlRq3n2ozhUlxhFXSGeb1hPQxY7xEb9vzfAjXot1yPJ0HGSLtZMkn2bg0gkN5l41yN+NWKhqpMUqFhH3I+TDimz9+xI9nVxEogVpbrDIbFfmJltvzKz6LewoBYGu2CiBkbCk+UiCdEeD3Wrc9p4MXPkELgvg+wmaSXc/n6wzHV78h6nIfD7PRu3utrhv1jKkEH2w0xDlgtCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58uZ3e26ZuyVJLfP64TR525brGKVYf1h1EjATxuJp/o=;
 b=UAYfi/Z+VpftXQdxZOiTPHZCb+FPz1J1gBK1HlOEPpF30Ztkbj1XIbBxAQLIXr1plKRVM7Tdrv9SYXRToI6no+fZs02b84D1bhGeYRYM+Z6DcjV7Efpd0341B517VzUApcAkiMZs2LXnf7+FN1xjicVqEDiZJzEr1nc8mAwqowwnfiu3HUUy2tEayJ8crq8p8tgIXo3mGoXa9KdIoMWytZt92ihUB0hOFvCyIk3zySI1rqNGlSwdwQ/xqFGtru13th/afo4wX4xxQmwsztPp/fLDNCXMzh8W4lRYSwDnMSkb3ZfjqUD+anq2J3lIfTLW0vVcHBSV/v2Clyupm3IaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58uZ3e26ZuyVJLfP64TR525brGKVYf1h1EjATxuJp/o=;
 b=D2hLR7sOrEyii9ZUcS8k613yDGGURjvO64XP8ghsPReGsrq8BMJKsOsFCjsZi0AUYinChkrF5DoW76gk9NZRkjdIP6SIcFVTDNng1AOE4reNRfV3VKoH88UoD7qqK9dwTe2bsy51ahICLejyJ4tWo2ueN4M7rnraxhQKXm+PrIg=
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 05:14:52 +0000
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::d4f7:fe6:3e65:3c55]) by AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::d4f7:fe6:3e65:3c55%7]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 05:14:52 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] [PATCH v2 16/16] ARM: dts: ls1021a-tsn: use generic
 "jedec,spi-nor" compatible for flash
Thread-Topic: [EXT] [PATCH v2 16/16] ARM: dts: ls1021a-tsn: use generic
 "jedec,spi-nor" compatible for flash
Thread-Index: AQHXtlfucauvEqx52Uqd8cxq3OuIqau9mKrA
Date:   Fri, 1 Oct 2021 05:14:52 +0000
Message-ID: <AS8PR04MB8673DB448952E9E36C323555E0AB9@AS8PR04MB8673.eurprd04.prod.outlook.com>
References: <20211001000417.15334-1-leoyang.li@nxp.com>
 <20211001000417.15334-17-leoyang.li@nxp.com>
In-Reply-To: <20211001000417.15334-17-leoyang.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f44c516-c0b7-4800-cd68-08d9849a6645
x-ms-traffictypediagnostic: AS8PR04MB8820:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB88206F66C50E7EF92896585BE0AB9@AS8PR04MB8820.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/nqMAY87ZZttrxD8xfeFSwoi0aM+m376WbSUM/A33Br9cnXKQRPMLW/Q0Os6yuWxaM5zE3Ioi7HO1YzG7ASiEghL4Q8Cmw8BdmP8tS6viY1SdPm6E3LYoGNgCHtgdydLySzbALNTg+LF95ofXCJbmKLhd3VOIu1gyewe0v840oQ251emXwj1TMFaOUQ12ZA+wEasz30bWIrY78KzNff+Bjau+h2AN053DmLfEcy0byqwVb2Y8lSH4Ruva1MiLW3a4sUYlulxpKbhNQu+QnLxYE+f6LJshme99W+Gc6XKbeQxO8bmgLvk+VmFqjHC6LD/7Gt3RcEEsdBbzXLQFYpWHpO0ZcGgceG3erl1PdvhxpJHP0+UlaTta6dITMklefGholFYz26RFCJ+mCAN4C3WhmS0/VmSnlEtDom5YuciJ4WCIbf3o2k0Bhl92ljrS5KV+TsNca1iq8h+3YwKktUFJixf4MrSUOq8EU/JQER8p33PLBnmlVVw4SHw/lU4dxGmZeJ+3bN5hw3yRw1v51++MRwJseak7AG1RAHUZbuSDcRjUkUIkMpkSdtmCQ4O3cbg+H6oEKuCEcsOPVqrP9r7eSzBm4WmmbeFDTAbTtMcjl4HHzK9TO9c50lO55TFi1/G8FQzsoYnJH5BjvtYcM5oPFg5gCwCpv2rQxEju1VggggIhmiRC6O3lpnTKurqkmf2tP1FvIrbOw2upMCRUEaZX0OKTd7fH+5fwfdkaM0d+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(122000001)(33656002)(83380400001)(55236004)(26005)(53546011)(6506007)(2906002)(7696005)(38100700002)(9686003)(55016002)(44832011)(8936002)(5660300002)(508600001)(38070700005)(8676002)(86362001)(110136005)(71200400001)(316002)(52536014)(66946007)(66476007)(64756008)(66556008)(66446008)(76116006)(4326008)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UVw+NK0uWqezsU7XQe5TPI+5Kopwumvwp7hayQ/6fKP+xUt+GX6sb3Rp94ec?=
 =?us-ascii?Q?lbF+gGlHwfGCSatsrNVewoeBu9Ro9VoM0dvrJUlyLHJrHpE5M37eZkMCAadT?=
 =?us-ascii?Q?siJuahePE7hfc+WjszSDyJdrqzs2Ku5fqJrAd0eGFox/U5xwjgslpqzq7Yvp?=
 =?us-ascii?Q?RwVWfkHNUEniWfUfAmZRqYlcesxtiKDCtwbqR5ldt/PLqLS3BVOFvesUF0YL?=
 =?us-ascii?Q?9ORqIc+B9eYQPUMPBd84QdfvZe0AE8Gam1a0cuEnQdpq9M1nsFj+1TZTvZAe?=
 =?us-ascii?Q?zORvsC6FGXFAeTHTxug2+/cBslaCZtvL6czQyp5LUJqTK5vxPx5WhGHwYQWd?=
 =?us-ascii?Q?T7DGwmugqASVcs0c9kh5w+y/KubH7VGInSE6r7IDlEewgE8taKZ9V3MKbQyX?=
 =?us-ascii?Q?VzGQs2UPW19vSJgZoaojWSoe4Na3RuheeI09nNilO2vveDcCcJdEE7BNVka4?=
 =?us-ascii?Q?8TN3/xnisHo9v3eaEWuUq2PlOx6igRkEn/AdwrGgLLH2xD62tKXui90pEtnP?=
 =?us-ascii?Q?6kMQ6LfmEsbmcKDoGBh6mOTt5nnVSLU5g9VUJtqvX5liy2VMyUxqdVooM/ea?=
 =?us-ascii?Q?j3J0WswiMkjLFtly+rpGbyUL602zvrTxTX1EI5oJPbZrmbJ+WAdqiJGpRlH6?=
 =?us-ascii?Q?di/TlIQIOw224NNC9Sc2duRhNnNjzhzh4kLn9+Hy8wa3vT8KK15JNayCqbrN?=
 =?us-ascii?Q?m/Nz08CanJBxkT7Cj2sc3GEiuCk9xVNT3BABKN/MEIdwTko6gLmuw5R8EFFl?=
 =?us-ascii?Q?D0cciPtcOxM6MgPcZUglaetlYzuDKb+dAC05bvkazb/pNP56HnObPJWsRv/J?=
 =?us-ascii?Q?/aekdbWJ49GyDyaRYYc3IfZ4XaDPYTTYoLZd7ITR7m4rnEWDHCnvvqO9DQo4?=
 =?us-ascii?Q?7tJYmbwCIQVWTITPd/km3hjFJGHHxWQAJy+4CiByiIK73SCPXGHVnVliTMHW?=
 =?us-ascii?Q?LDjw06WcwJAp5CvPuYmOrQ2W2LvX8s1ZBbJDfkhQMX6Njri4SEXG+2X9gyP7?=
 =?us-ascii?Q?arPqLeihReyJcRy2GdBWC3MnFyjrSX3muWrpxQV1O7y878yhFRaW9hw9uYlv?=
 =?us-ascii?Q?uzqM5JwVjvM0md4bbIsh/wIlkwNvQuVyFB0ZHjMDkcbFWIj7W+K2DnX/1Vli?=
 =?us-ascii?Q?7qQEX9tvHwZq7mmeklvfyuq59H6znYfgVM3IWKDiuv9LBluiyDcvqJbfB2zp?=
 =?us-ascii?Q?YckrJyaUac+CnmBZTEs1PNuuA3NuBVM1KLsZcxpkkKPtW6hCQzjRijF6uYbO?=
 =?us-ascii?Q?iSYdpMyzH7Ox6IONp1zYz1IxvLvZI2uwm/mRNuk64uG70avw7K+Ud0H3ZT0A?=
 =?us-ascii?Q?XXE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f44c516-c0b7-4800-cd68-08d9849a6645
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 05:14:52.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mx+NeL10EXEkpjIHi1USAEQqhA1GgMtVjcoPmLKPbhSWXJ9P5Z+QbFHz8R/4Rhek94279ov9wjjxpve7wvrSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Li Yang <leoyang.li@nxp.com>
> Sent: Friday, October 1, 2021 5:34 AM
> To: Shawn Guo <shawnguo@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; devicetree@vger.kernel.org; Oleksij Rempel
> <linux@rempel-privat.de>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Cc: Leo Li <leoyang.li@nxp.com>
> Subject: [EXT] [PATCH v2 16/16] ARM: dts: ls1021a-tsn: use generic
> "jedec,spi-nor" compatible for flash
>=20
> Caution: EXT Email
>=20
> We cannot list all the possible chips used in different board revisions, =
just
> use the generic "jedec,spi-nor" compatible instead.  This also fixes
> dtbs_check error:
> ['s25fl256s1', 's25fl512s', 'jedec,spi-nor'] is too long
>=20
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Reviewed-by: Kuldeep Singh <kuldeep.singh@nxp.com>

> ---
>  arch/arm/boot/dts/ls1021a-tsn.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/ls1021a-tsn.dts b/arch/arm/boot/dts/ls1021=
a-
> tsn.dts
> index 8005efc5c812..ff0ffb22768b 100644
> --- a/arch/arm/boot/dts/ls1021a-tsn.dts
> +++ b/arch/arm/boot/dts/ls1021a-tsn.dts
> @@ -251,7 +251,7 @@ &qspi {
>=20
>         flash@0 {
>                 /* Rev. A uses 64MB flash, Rev. B & C use 32MB flash */
> -               compatible =3D "jedec,spi-nor", "s25fl256s1", "s25fl512s"=
;
> +               compatible =3D "jedec,spi-nor";
>                 spi-max-frequency =3D <20000000>;
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
> --
> 2.25.1

