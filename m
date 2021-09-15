Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B4140BF46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhIOFW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:22:29 -0400
Received: from mail-eopbgr30054.outbound.protection.outlook.com ([40.107.3.54]:36483
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230225AbhIOFW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:22:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpEUlbVDDv+LWc+6HqDcnKYTtcP1ijfwV4WpQbm/lpRdagBXkgsmwGFzpounl6HB4Br5gmZi34QF5KXbq5ebi8CAb1u1Lb3+eFXMi7sSXlXsUSrkCV4T9Qlb/wM3IYrNsXsY6Ai2NY+AhRddTy015t1wk/goGHli6hJYJEG+Bsr8W2HMh/jqID2Ex3+FUYny2UEBkFrlskEmAmGc7+ErBUieG9MLlCNWm3eM+AbyE5mM3w5Qi0jh9412YEguMSCOXsMdNkOj/8k8VluZMcUVZrmRBPDSwzYdPZX9D2VBg879i+IT41CUeJbd4CeVR8/CBl3+2UUWJcnxWM2YHqIF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ifmbhq3n1IWRRH/HYEHEzf7mQzObQKvpGdmK92Oc+S8=;
 b=EvdPVjmmUv0DbImJOr7MKcRcROqPhphu36xZeApIwyzWHFY8U8eTbbceU1pZTo0UaxNGOUSwPISJkX9EGxuaE6cl3Yq4biEjZXbORbDPB5f0dEDcCmvp8m2ymuH8knGU4z9isG1d7j5VUIggbnklFRygwni/ePX2mZqP+BIV/3FsxFAnEXXevfRlwP/MsQMSz8bGG/NTpAY7+M7snO9SDzo4Y5g5Ozhns4K4AFWD9C+kJi5XfK5XdfdizA9fNrD27zC1d5A49c5TO57sAY2JTz5NZiWi79wuUzEmwLZHKA9bmEWCo12qDdVTcsvG1QwjxmzIZHjtnjQC8n5fQhHtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifmbhq3n1IWRRH/HYEHEzf7mQzObQKvpGdmK92Oc+S8=;
 b=s1xMmT4NR4eveYYSWFGPCs1Ts41ehLvkNt3rQqHtdDcRrqdZ6OHR1FteeYJNNSnrPjgo/DldBMKbYnApDDoO5GZ0XIV+ukRtzlA5V4evHiiJwQVesXdBrzogi+PZITWgMEMdv+M2G45wMzrnTQIpqLGi5oVfVuOi6W3wmpbTlsg=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB6510.eurprd04.prod.outlook.com (2603:10a6:803:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 05:21:02 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::f8b3:2cb9:4c85:9bef]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::f8b3:2cb9:4c85:9bef%5]) with mapi id 15.20.4457.025; Wed, 15 Sep 2021
 05:21:02 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 3/3] arm64: dts: imx8mq: fix the schema check errors
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8mq: fix the schema check errors
Thread-Index: AQHXmxHl1DHVdMJxpE68lZvkVMwylaukrLww
Date:   Wed, 15 Sep 2021 05:21:02 +0000
Message-ID: <VI1PR04MB5853FBDEE8FCF5B30111409D8CDB9@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
 <1630046580-19282-4-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1630046580-19282-4-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5561d6d0-3180-4514-1ac9-08d978089c05
x-ms-traffictypediagnostic: VE1PR04MB6510:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6510EFFC492FAAC430EDA7918CDB9@VE1PR04MB6510.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYX78swaE4oKbEMeRvn20jIhNlk40uJsCP1hxwJwECnPN7qBfAlEYOq5cAFmeN580P15TCfHwD5jsxRsKi9+LlHvlpCfrbVkpf6vHak93N/fDjKuQLy6zR5JQnHl26re/mG1bOi0QDI8eV0z4CEO1HfXkjgbb+kFD6BXI3qV7bJTvJI3g5EgPsqqNai384qUwdNviYROqJTUz8x/Q+IILWXskzuXuZ1RDaT9zkXrEIAKtqyRDm3Sc5BrxWrPLUGBmnPQzvvtnBaXpIfSewgYWAald8OcNMU4VHP4CBM6v+alZjPnEB4ymj4gZaTVv0Zr4y1FwiEnqqYkOlXJbacUrfHmkcVqsBcus1oNbdKjDBMva6rYKDkhnG+cmPp2u0uwsEwag9sgFESLy9c/Pt2VGdKhJ66WLp3q+WJYd+hoamRr3aD397WKhK+nrIKVJ7S7sVWuYklYIjnyGVri3pBt3xggkvV6eNvvKTAShT7kWAIW8mO1I6KJZ8gQcWMuOPOxL/PNtJwA57l4q4e/UgBcM5wgAMJkU5PBEjWqRWT879oxb//xnuO4CUN/xN12/BuvdGlgWP++21VLXuMDX18RWsVnqBYOjmMPX7EyPAf1sBC/MvOlP+nEq8STLjnMntt3fRlWqEiNJj+O26AY8zFZUGSbZrmrfB9j6TYjh0LXC6R6KFC79Eo/UoKXKKpRhsl3IgpOxC7B//fLH92/f1AHVfTqtNO768oKXrpaU8coAPS/1z95PpDXs8n2UWoP7BzbWrkTKYjboqidjayi64rkUYEXI5weWZczY5CxGhubN0SKZdET24YWgKvnSDmdhUDT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(84040400005)(38100700002)(33656002)(71200400001)(54906003)(8676002)(110136005)(316002)(86362001)(4326008)(122000001)(38070700005)(2906002)(966005)(478600001)(7696005)(9686003)(186003)(26005)(8936002)(55016002)(5660300002)(66946007)(76116006)(53546011)(6506007)(83380400001)(52536014)(66446008)(66556008)(64756008)(66476007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gc9RZ+6mAe1iuL4uSo/BOD8D9uTWfUXoumNGcjXuYYI4au7CtyjqODqJ0E4F?=
 =?us-ascii?Q?kfWQex5eSnnXgcX0YoF8Bsjh5hGK5Ak8t/sTjBmYnwyS1gnT6t2C+pBMi1OF?=
 =?us-ascii?Q?jG5+0G9HfKXLsi4cwMlwvx7HBO/ScU19KAI+vdTIicH7YP+9oXFpHPqbSegZ?=
 =?us-ascii?Q?sxiwKj3ulwOXdQjxVQwPESFa/z2EiibUCgSNIZpvlAM3N4Uc2zC8DvbAjcF5?=
 =?us-ascii?Q?rcBeah0RVRTt3jRTR3SgXMWrY78oFjePbmuzMtSu8pdiZHDbAZtCm38t++wm?=
 =?us-ascii?Q?/BzCgNEsnu/pmngjTiyICKl77tpbmraUxEm7CWicbnulEWqWoA4t6v9ouHLM?=
 =?us-ascii?Q?S30d9+dAICmYn6oqWW/Vr9C5dkQUwyaSObwtAkcfDhDLVS3tLwIVxgFptTOi?=
 =?us-ascii?Q?dVTKGym7/bKKItxe6IGad/gKRQZralPYwjygBA0qajNSG1DlVKw2NrN+j5j+?=
 =?us-ascii?Q?K5AgXD8DeY249FwU/mLq6tNCYRz1zNQtj5jPQhlEsXCPLg++kRinqSfSLw3Q?=
 =?us-ascii?Q?iXINqjgJJoXODGNC003ptHICu+LVQcqJ1oICAXDp38WST+z6fo53Bje6N8wO?=
 =?us-ascii?Q?ZX/g/xuh3i5+nAzSMP9Q2lxDLzRyApBi5Bul0sVg2eE+8OsNP11NlrTsj1v6?=
 =?us-ascii?Q?Ih59pYFHc6pe0Rr/BmNB6N+9sZdXaOaLwCs9pgKq6/TAnkuMoJfPRCODcchB?=
 =?us-ascii?Q?ogcb+bwWMXZqkXWZT7mb2eHd+TmNsyE+DRGgRJflPCCmz9tNKXhRGYcDLQdS?=
 =?us-ascii?Q?Y7BRPJoUZ1t+CUUDfZiyTZ3D9BtMEcvPNb05Ch+zhju1a1oPP4Bn52PfQ+gO?=
 =?us-ascii?Q?uYSy2q0vx8t5RFIJ9csj2ixYuPDapQ5asU/qtndW36MIjVA1WBB8grLg+Rn/?=
 =?us-ascii?Q?MpZCRmUAhvyWTNX9TtXC7A+lA8QAptkuy+VHei8KKxW2l0aAkLp+9kjQDMo6?=
 =?us-ascii?Q?F/Qri6/xvvds6XtTqtevWi58YU4dWUUm1xAQ61BpKx7G2e83XwIbEqcKiIK3?=
 =?us-ascii?Q?eeaoXggv3kXNJNERJUJ/gdTRqxhZwlEjpmCoccud8eJ9rm2cqzFxrL6G5rVh?=
 =?us-ascii?Q?t6gSCIFyGDqn6Ykbmyf1IQChKpwzKikkUbS4Xlo0FB4ehMXQys7vMPwqMWM9?=
 =?us-ascii?Q?LMyvLaxvVshNNpaO8aZHNu7EAr6huq89f/ggz7QrkaBgBdTNSYSdXlcZ/7Sx?=
 =?us-ascii?Q?CiCjaCAs4aGEQdlL0FG/k3QrMdroM8JsRbz72mogbfazSYFU+LKdhe5NFauJ?=
 =?us-ascii?Q?o4iagb+bFvlGLuotzn8gYnEOvvXZBIcLA+cJVVNg4Wsm/T+E9m2lVDuvDsZS?=
 =?us-ascii?Q?MTK3qUikOvM/vnCVAjtdWjL7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5561d6d0-3180-4514-1ac9-08d978089c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 05:21:02.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0X716lN9cvp4AMFm2Dcn27tdeAXaRRRiEG6AzMYNoBYKY8QxJd5DN0ZVAU/znRBUAOkWnOI2yVSEC4pG9x2uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6510
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn:
Can you help to merge the following patch?
Since the first one of this patch-set had been applied by Rob Herring.
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1630046580-1=
9282-2-git-send-email-hongxing.zhu@nxp.com/
Thanks in advanced.


Best Regards
Richard Zhu

> -----Original Message-----
> From: Richard Zhu <hongxing.zhu@nxp.com>
> Sent: Friday, August 27, 2021 2:43 PM
> To: robh@kernel.org; l.stach@pengutronix.de; galak@kernel.crashing.org;
> shawnguo@kernel.org
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; Richard Zhu <hongxing.zhu@nxp.com>
> Subject: [PATCH v2 3/3] arm64: dts: imx8mq: fix the schema check errors
>=20
> No functional changes, but the ranges should be grouped by region.
> Otherwise, schema dtbs_check would report the following errors.
>=20
> "/linux-imx/arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml:
> pcie@33800000: ranges: 'oneOf' conditional failed, one must be fixed:
>         /linux-imx/arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml:
> pcie@33800000: ranges: 'oneOf' conditional failed, one must be fixed:
>                 [[2164260864, 0, 0, 536346624, 0, 65536, 2181038080, 0,
> 402653184, 402653184, 0, 133169152]] is not of type 'boolean'
>                 True was expected
>                 [[2164260864, 0, 0, 536346624, 0, 65536, 2181038080, 0,
> 402653184, 402653184, 0, 133169152]] is not of type 'null'
>         [2164260864, 0, 0, 536346624, 0, 65536, 2181038080, 0,
> 402653184, 402653184, 0, 133169152] is too long
>         From schema:
> //linux-imx/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml"
>=20
> Refer to commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows").
> The num-viewport is not required anymore, remove them totally.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 91df9c5350ae..c6dba9b92edd 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1364,10 +1364,9 @@ pcie0: pcie@33800000 {
>  			#size-cells =3D <2>;
>  			device_type =3D "pci";
>  			bus-range =3D <0x00 0xff>;
> -			ranges =3D <0x81000000 0 0x00000000 0x1ff80000 0
> 0x00010000 /* downstream I/O 64KB */
> -			          0x82000000 0 0x18000000 0x18000000 0
> 0x07f00000>; /* non-prefetchable memory */
> +			ranges =3D <0x81000000 0 0x00000000 0x1ff80000 0
> 0x00010000>, /* downstream I/O 64KB */
> +				 <0x82000000 0 0x18000000 0x18000000 0 0x07f00000>;
> /* non-prefetchable memory */
>  			num-lanes =3D <1>;
> -			num-viewport =3D <4>;
>  			interrupts =3D <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "msi";
>  			#interrupt-cells =3D <1>;
> @@ -1402,10 +1401,9 @@ pcie1: pcie@33c00000 {
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
>  			device_type =3D "pci";
> -			ranges =3D  <0x81000000 0 0x00000000 0x27f80000 0
> 0x00010000 /* downstream I/O 64KB */
> -				   0x82000000 0 0x20000000 0x20000000 0
> 0x07f00000>; /* non-prefetchable memory */
> +			ranges =3D  <0x81000000 0 0x00000000 0x27f80000 0
> 0x00010000>, /* downstream I/O 64KB */
> +				  <0x82000000 0 0x20000000 0x20000000 0
> 0x07f00000>; /* non-prefetchable memory */
>  			num-lanes =3D <1>;
> -			num-viewport =3D <4>;
>  			interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "msi";
>  			#interrupt-cells =3D <1>;
> --
> 2.25.1

