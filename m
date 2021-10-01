Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7135C41E71E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 07:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351721AbhJAF0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 01:26:10 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:4230
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230488AbhJAF0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 01:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO/ECA+3ul9TVS6JlmbqkBMRxJHMbL6fC4OfpGHqKKMd6Eun88N0c9v4NTja3jHv5CPsY90OO5imc5/CFJxUvCKUCgI4CoNbVLYPgfs8dU5uHzSJW2xSeKr+MIO1dCBij2YSvoUq7ok77YYi6L5ETD4iuR87SxdIlsPbb5iZHg711cTIlqJw7Sd7sLTsyvd8u1x0dUGuQEJ4nugWrsCx9I+UgE1lz8cuyl0AOloU2EmxoE7CBsHTlQdioGECX7WxBf6zNTgOFkA73hpvJJwsXyde7a+UCXPnqTeZzX4zj9HlQT1Kr7E77gvtIGnBvJ8lQGNVuVvP7FD4shh3Com6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUtYX/7Gv5kT5I0275X2nkaB3EHWgCCI8mhCtrptLWw=;
 b=crt5unGICHvQeu3bJvwcrSS0HccM9JUhn6eKRZopKuEmRnJTU10NjDhpp+RVBXZmBj3Le6EhFQ7kVStQ9TrTV2adlwIE83Mg4mtNFBikQpC8NqZlGWLRqs0YnUAtivYVsh4TkVVRfFSDx+5EP+DNh4qtSS/NAIk0/wP8F5y5vUdkSQEALiRW96w5yO098OOdkS3JJHwiQazXvmFQoRgRq+VChB16ydIV3WCay24YF2VV8h1pGc3cfpHZBgQVeexaeb4kiUXaC7ECwNd2zP7Hj2eP7y1GbIknvXPvptaoyvBniZwg0IkUnSnYXbItsDPdI5wE6jY8johD2ft9msXP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUtYX/7Gv5kT5I0275X2nkaB3EHWgCCI8mhCtrptLWw=;
 b=sdJncjvQBdAIBvQ3kCCD5Q/MkPm6mUjygvHP4solbRa4XEc7OhFk8PEF6iTXdNl2DeFWRymKTrx/UfMnD3dKKjb+pjEdmnVuTPWIJGgo++CPpT4jJ9cjWrPuqe5JviXYON6ZRq0nQSh64U/TJYdIbPqUiGLVUY6BDtcqX0BP02Y=
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9)
 by AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 1 Oct
 2021 05:24:21 +0000
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::d4f7:fe6:3e65:3c55]) by AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::d4f7:fe6:3e65:3c55%7]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 05:24:21 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] [PATCH v2 04/16] ARM: dts: ls1021a-qds: Add node for QSPI
 flash
Thread-Topic: [EXT] [PATCH v2 04/16] ARM: dts: ls1021a-qds: Add node for QSPI
 flash
Thread-Index: AQHXtlfopRpWy+oE2kOXPz/B4PLFIqu9mgdg
Date:   Fri, 1 Oct 2021 05:24:20 +0000
Message-ID: <AS8PR04MB86734729E9E08F70FF7E5AEEE0AB9@AS8PR04MB8673.eurprd04.prod.outlook.com>
References: <20211001000417.15334-1-leoyang.li@nxp.com>
 <20211001000417.15334-5-leoyang.li@nxp.com>
In-Reply-To: <20211001000417.15334-5-leoyang.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 076a7b95-f807-49ba-fb68-08d9849bb925
x-ms-traffictypediagnostic: AS8PR04MB8833:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8833C5459CC17F0395576522E0AB9@AS8PR04MB8833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wi31sy5Fs9DWcrVYXQd9L17z2EK18UuMjTl600Lkd4FamtjTVq1eCGkAywHSVk0lpMwt3qCC5AHpI2Vhxt4GPBYwXkRcGeFLT8azj/S+4JstPux58CNoW+kaGrCcFYFX2om3v2yG+3kkcUJJ8st5JOqa5rDZA3LCxT6Sumj9VnZNo6ZPE5gK5tpsQsJ2gWjh4196Xn/mz8AQ34w08nD2e3G1ljF3eSbeSo76m2QZkAP4fuu2bhJaHT1bUz+EZUS5e8Wzt3lX0UcqFHh9qg7aJV1GhAl4CQSN4kxH/KhIRA7fmvb9AkmpHnh8b2+bAz2v+s7UQeXEs9gIUJ1bZS/b3hcfvOSutOJeE+qjUUHhKO769DEEbL2WzqYMv7gr6bL61ymPEVMJqDRHo7QVZ14bazFdn3i1Bb2K7byHbEdMOoovEetxpL3lJZvWgcyLUafh0FiLxEgCSbl/x5TS2cxajDEg6y8sV7Jh3UkXAHr4FagOwIVYkRWADgENp+vKH7VTBDBEXXHkzRMpJwhxqrj4+04fDmToITYOesVm4Ee8rOYY3AKamp1lEjKqw+avGB2UCM1fgvISi1QntkB/gVs60i8BfOdJ/CwgrhzTp3guz1DA6h8L5tdVDY+5mwRULJI/MavEVyyorcgKtG3Fdp2PaMiv/jQLELcqvVB5KtDWanE9wdsqGjEzCVfnXenf6knjk7OTn5lTWqV0IROTMK7f/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(83380400001)(86362001)(76116006)(66946007)(8676002)(66556008)(66476007)(64756008)(55016002)(2906002)(122000001)(38100700002)(6506007)(110136005)(9686003)(316002)(508600001)(66446008)(7696005)(53546011)(5660300002)(71200400001)(55236004)(186003)(44832011)(52536014)(26005)(33656002)(38070700005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Ef1mpy66/6FxZGKsXialk4Pxz7uDUHDNAKlzK/Ki8CwgDHUdJqSo8WWQL+t?=
 =?us-ascii?Q?bCpJsrYyRc8gzPQEEXaLhehZHIh5Kz9TpBKqupU4ao8i3ul7Z+F/8WVOiE/8?=
 =?us-ascii?Q?6fF8P/Gm83fpakHxVyf1cSXHjJZSpsm5zcRlSzgIopMFo6rxP6AbtWgGr1u+?=
 =?us-ascii?Q?ckEx9SUUYeCasC5DhHsWGhfJ/1vjwOmA4PEphRqoK5iFApp4Yfl3u260WkSO?=
 =?us-ascii?Q?53X09m541I+vWT+9uw5L3HG6D52CDtzbGPlm6r/rzdGtn3M5/6YImgy7wj3d?=
 =?us-ascii?Q?a7fiWgextNSfwjsB0HfLRuu0LEmhyoYL0EpD4cSXVDFCIsuBtE6KJO3YpvNx?=
 =?us-ascii?Q?FqLa2ghTYsa6emXIwgmVeL4ZltfaZhsUdcSkTbCXdftXB5ysr7oiSVWisLpg?=
 =?us-ascii?Q?1xqN6Xv4aLwbwo8r+ckVA/R0Pb20C1k5OQvKjt6lbHxQKInsLB2rVpjnl3AN?=
 =?us-ascii?Q?SfNvivebrQJGR0ft+CXKL363DFxiynwmhFIiwV+XdsGNTX4YgIm3UeZ4ItSx?=
 =?us-ascii?Q?phtAKxN427aaXEOqdRAgsQ81pdJZIDaJEja7u7fwxFcu0TDwGyJuxfWjcrbd?=
 =?us-ascii?Q?ltWn1TTw5oL/XWURH9uD+JXDpEIOXjq/YgEz3+0Vi1VBlkN+EVwg0ar62ShF?=
 =?us-ascii?Q?I8vNQw2WAu7HFW9Y7fSN/q7LYfuP3/cM8fZhd0K0vlY8WWrGcw+H3fUCwZvm?=
 =?us-ascii?Q?zr8j991bUo4UV8MaQbmynCLqeCpLgx+Nx6rTL/q7Jm8KtYMoHYNnxzyu72Qs?=
 =?us-ascii?Q?bvMv+2JbQ3NujKcI7AaX2i75z4o1NkHOd2/0AyfOZkS0YZrRS5bLTfjGKS/m?=
 =?us-ascii?Q?rfKpJfz1XOWnet8WyJ0Nbc0/enAAxXELOgVTZqptl7lWP7zqkVjg8ypNrzu4?=
 =?us-ascii?Q?DZwYJmLc213LVstFnIYClVz4o229374Wh0DDmeaNW+J33UyBJP9+jcFLFDhy?=
 =?us-ascii?Q?4MdrZyTXHSza31Q8Yufb7qLBZCj2pOW77L9BAQNxD3pf8XsVeHhRkGn228RU?=
 =?us-ascii?Q?0j3NE67LeFW+jTpAb4Mcb13Rl90hXHADN1MIbu1HbZb06DFC+M9x5HL2GlkJ?=
 =?us-ascii?Q?Am0wp14YshXFgH8WRmqG5ZuYmvSZEjCKaePcE7LOXBadRDGsGaIiffEQHdN8?=
 =?us-ascii?Q?WTHEg4c8ii7uUVoMpQFXCHTPpeYNJfMCs7w7H9IUlc8N5tS21kPUPz4Tsp4h?=
 =?us-ascii?Q?rDns0+Nxa3H+M5iUbXhPF/HMFvnrPFCTiJZbs7E/pzYjQ1Feihi9J9lUolX8?=
 =?us-ascii?Q?QfMxcGdsto3DXf/3LillIagTHDSOTtkauwotj3aiF0E9flj3BEOfVsgZgxlP?=
 =?us-ascii?Q?X8AuKqerhj2yBnknVVfJ4FyE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076a7b95-f807-49ba-fb68-08d9849bb925
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 05:24:20.9383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gT4D8XGNZSmjtuSjh4eXhQWN8xmvzoKKsRzxjBU3wnPHkYBF/XAQhkUnq5yArz0WMXFSRh36eYcQY/j0vFVxFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8833
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

> -----Original Message-----
> From: Li Yang <leoyang.li@nxp.com>
> Sent: Friday, October 1, 2021 5:34 AM
> To: Shawn Guo <shawnguo@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; devicetree@vger.kernel.org; Oleksij Rempel
> <linux@rempel-privat.de>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Cc: Leo Li <leoyang.li@nxp.com>
> Subject: [EXT] [PATCH v2 04/16] ARM: dts: ls1021a-qds: Add node for QSPI
> flash
>=20
> Caution: EXT Email
>=20
> Add the missing node for qspi flash.
>=20
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a-qds.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts
> b/arch/arm/boot/dts/ls1021a-qds.dts
> index e2aa569ff404..522e1dc51059 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -286,6 +286,21 @@ tbi0: tbi-phy@8 {
>         };
>  };
>=20
> +&qspi {
> +       num-cs =3D <2>;

Please drop "num-cs" property as it is not used by qspi driver.

> +       status =3D "okay";
> +
> +       qflash0: flash@0 {

Can we have flash chip name instead of qflash?
There is no hard requirement, it will help in aligning node properties with=
 other board properties such as LX2160A-RDB, LS1046A-RDB etc.

With above fixed,
Reviewed-by: Kuldeep Singh <kuldeep.singh@nxp.com>

> +               compatible =3D "jedec,spi-nor";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               spi-max-frequency =3D <20000000>;
> +               reg =3D <0>;
> +               spi-rx-bus-width =3D <4>;
> +               spi-tx-bus-width =3D <4>;
> +       };
> +};
> +
>  &sai2 {
>         status =3D "okay";
>  };
> --
> 2.25.1

