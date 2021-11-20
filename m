Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F405457DC3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 13:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbhKTMHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 07:07:38 -0500
Received: from mail-vi1eur05on2064.outbound.protection.outlook.com ([40.107.21.64]:12931
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230381AbhKTMHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 07:07:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLhZEbfJRoCMnixtz0YPyFk/+RBGlqjhOP2xyEo+93TNGMPuOE88mPxROW9orLxkdp0RAD3CTIJpNeHN7VeAgcN+5IWGTkNXBNAYikvrNFzVFJBMY4ESwlWbooIPtoq0ohzoIwdLotMSO7WsY0W6LAfrwDrzUtjVZRtE4/nSaMA2PS/9CcRgn2GRkCEOksQBa6mnGx89yRSfr4hivo64wpO1ZHz5jo2v4Omt15OAS2oUdN3ZQH0E/YpAcUau85IYgo1S44A0zgpVdRRV4vNMdmQ4Z5dAjn53Km56NISTF0hLNQie0pq56LFcvkQ9oTo6J6KMaMvoqkT2QEYX9kOPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjWF5BSgOSGyYHUj2a0nE3R0aFg4oulc1YAZMFJVU3o=;
 b=NqLDoN3neIj398Yk3lokuNWEUDgt2aWGoph4D7K36t0BO5rL/paXsBxGdTE3iDK9PM/aY/looJmRSeyguL9Ms4rGLQF2NX8QB+heHnCVHdu8i22No6RJeCcIXO8cP0BOXbquGAwEJhGVxNCvw5q5z8BRF2VxbH0qlqKcwnFZFXMRwbcGnsklD6PHMMkFRYRG8HM0ilppgE1+EdxDUEHiA0sFSyRwe69Qj+60699+kbmwceEKhr2QhhNl66jEUD11JbqbUQNbryFFNiIxdjVYI1WFZ8xyfpw2ZZoOz54G6llDCyU5R0oyN1NGXqE/SGOE9yZz6/TsD1q4XaaHazPO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjWF5BSgOSGyYHUj2a0nE3R0aFg4oulc1YAZMFJVU3o=;
 b=eFmkpOiya0VJDddaf1u0jv7Aqe9pg8UEg+GerD+9slCkO3oLRHkMya+o+064s2yrBsb2FOPZWtZ1QVZJupkAlZIwAba2gaNx9eC+WQ+oVvRCYBFQ4YR+Q7zN5WXVMulaaUQCV3DNfH42Wenj7bbYAcIQGWviZxGLqFu+ag57LbM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9082.eurprd04.prod.outlook.com (2603:10a6:10:2f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Sat, 20 Nov
 2021 12:04:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Sat, 20 Nov 2021
 12:04:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] clk: imx: imx8ulp: set suppress_bind_attrs to true
Thread-Topic: [PATCH V2] clk: imx: imx8ulp: set suppress_bind_attrs to true
Thread-Index: AQHXx0G/N2NOAnJdUU6tUzvkF73k2qwMfwVw
Date:   Sat, 20 Nov 2021 12:04:30 +0000
Message-ID: <DU0PR04MB9417315309391B3E19C3F1FF889D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211022131513.17381-1-peng.fan@oss.nxp.com>
In-Reply-To: <20211022131513.17381-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f7cb6e6-44f6-40e4-5b8c-08d9ac1de889
x-ms-traffictypediagnostic: DU2PR04MB9082:
x-microsoft-antispam-prvs: <DU2PR04MB90820FE8ACBFCA83A50DB9DB889D9@DU2PR04MB9082.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOLWolmihclB79hQfp0NrOzUWzy8fynBYGgk5501AZJ/Aj8gwfCyz/abASc6J22s5t0A2x1mG5n/BC/BqzgiTyraSzDx0PwW+ikdGOejJ7WriMzTClcNjFKibZoNkhZznfgkPg7FxyXgcC+A75HArTui92g2HGfm4R6px61fF0HENzOArzbpIh0z53uyEW9w/XZyE1qZ0g0d74a654OBjogoIl3JnJr2hgMk993Y9RtiPeSAtIv1CZLyxfbg1cS7tuuF+n4CeQ3G9Om24/x8XYYXF2BSe6BLBA0ciAM6NRZugr91FY+ROEqEpD44ee4sUCSqRYTGr7vbMbYyJogy5TmSCkdylaQiifpcfF0xwCqs8675SxWWAc8005bXD1YHzkGwXMm3Mfg6nSHmah8dnHOwz3TagI9+jLWTU+Lr//m7ItrhidOPqfY9pBS+GRaZOGAlTiTDbRIR9oNTJl4WBs9SycfrasphEadVQ+6LZyzyN0ab/0ss8nIa4siKS4eDJaq2Sj2HtK1TYirUDXwxB732GzzEVl6TO/Gw8T06UylNnihOx2w/MzJZqDg4Uc0YQ894nbNSyiQMF4WOhjib2xtQoXlOKKuyfuK6gx9tiiJ92d6mNt09N5E2rEO6SC5DmvdKWzxKiP22y+eKuoIjS04PtVI2LJH530OG6AN4o9DBWPltLmEyr/DaonbzvPEESrRkuJ/UofIt9EYuBD/m/1eryFD4M5TM4EnpNF4zxu4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(33656002)(26005)(9686003)(54906003)(316002)(71200400001)(186003)(122000001)(8676002)(38100700002)(508600001)(7696005)(64756008)(44832011)(38070700005)(66446008)(66476007)(83380400001)(5660300002)(4326008)(52536014)(86362001)(66946007)(76116006)(66556008)(8936002)(110136005)(55016002)(2906002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6xLWVi+O/PHzqI2to+H5MLOos7CcL0BuzFypAp9veZ0FlU3FGPURhIEQ71r0?=
 =?us-ascii?Q?v4T5ZMlO1/7KsVAHDXJ04VL5az/pZY2gHw64gfWhQ1Q7X2rwktCDgvJe+1yh?=
 =?us-ascii?Q?Zb43hQuUoWpFfp52NSjMx+v8JB6WGk9z04oC/k2wJJbh3s+lVtQyCD1SN0Jm?=
 =?us-ascii?Q?3kkInE9PwAiS+upQuiiM6A3Af9lDlk2m8awAAQ7axqzFTSrMb3dySUACq5tZ?=
 =?us-ascii?Q?27FPBpACT5B9HuNxd8sTs1uhdKCZqMobVNWL6pAVBssWohFL8N8rpcjtqRJC?=
 =?us-ascii?Q?45u+tKiz281rVbYlXETtJLEVclINFz7HwaVlGaDQVYeP7vHdT7QEznzoY+Zh?=
 =?us-ascii?Q?M2Nqmf3X7TgjfQW2jh4TAwUG9BoUSnazZs2RwrmA+CmCkdhABBB7frWBMaHF?=
 =?us-ascii?Q?T7MjbRi+PY/fF6cYyIUCK1sNt3ecftUl5w6zhYVte10at7oADEPHswjtCu/1?=
 =?us-ascii?Q?OEGR+Idp0jQcmUnkgGTPN9sHTyjiyWij0Av1nPUuM4EOwucJYXT0Y29HldKk?=
 =?us-ascii?Q?Rc4/YoGvJnEPzq7NpurCOiBL3XEPzLZV4mTBOy5Ffl05OMq4Rngx9qOIXptx?=
 =?us-ascii?Q?aDqLtBo04hBJY5WxdjSfz4twui8xLJn461sbOdALyt98ZUyXnUPAoRyviHHP?=
 =?us-ascii?Q?vCSRoLA+m/5CPQGuArDeJHP+C1pxSM2Msahbr0IYOvju2InrHR1v7Fsxzyd2?=
 =?us-ascii?Q?c5j9k94sg5Ir7LfrGnFChsOpsLZJyM7J5leCylg/mB5zRDn3I+vAFRR8WcBt?=
 =?us-ascii?Q?28w+X8UeMH/AQgUGBt+0cANIGe/stoN8uhQvKxBwo+h67rToLLnKj1cAzLWy?=
 =?us-ascii?Q?lXLtdVooztbtguL7ETG+fqn2BrSQ9nW1WCwfSf9gxNSJudlnKeWQPYidQdyz?=
 =?us-ascii?Q?+xck/2P+97NukM+Dg8vnqvJupT+xr8Vp2a0fltpB/FygF3DUyaGvKrHbpbwH?=
 =?us-ascii?Q?GPKeUosoEuhhxe+OZZZxxlX+PogpOM50Z2vG/i23EGZ7vMzve5KZ1tnfrmAY?=
 =?us-ascii?Q?iknY+jcbWzQCr6pa+qow6Xf0sAqcdQgjGBzKz+qbpggQxwyhX8ahDCbXQYgV?=
 =?us-ascii?Q?ir8d/dOrvrqoMUgTpbbK9dBCX6Ko7TZXQ1WKryWT+6nqCFgTWXEKM/7ijg/H?=
 =?us-ascii?Q?KZQ0JDtp8eGOmbt9D9utPTKbygLAYN1WiIW60teDCIyPoBS4O9BJWJXNwhsA?=
 =?us-ascii?Q?oe9MMzPSioMCji6PpS32RcHtRb3ud39z+JHCKESV8sRXVRwWKMWdYUYR/tGB?=
 =?us-ascii?Q?fr01BnP0AboVuQTZLegEVG1SieH4ZuaZ42GF5VCe4XPyyvd+NoVjytTLWQrZ?=
 =?us-ascii?Q?WUQMatNvKNUCKKMemig4k1tP5yEb2NmROFhzq4Ud+aHzMxW6EptCeV7wx3FX?=
 =?us-ascii?Q?vsCh+nzDzUM71IWkiw5kV/2jaowGZ6B5ElztBeIvfBKDr/bUI1QBkPVsIe/u?=
 =?us-ascii?Q?1fq5hB5mYtdvJTSgChYZShZsJ64F9amgV4bRoyp3jW9aKCFarVB9Fvtb5NtD?=
 =?us-ascii?Q?pfWrp1SNe7sQiRBMqqAOZI/HXhCaJOCG48A+u+TgyQqW9SKDV3t7P4fkuVfW?=
 =?us-ascii?Q?w4YzhZuYw00/7yt4zmY9Uv3dh+f3HMDUj+sMyz+5ymQ9OpuD0RabznVlEyny?=
 =?us-ascii?Q?g1TpEhibhfgWIQLDQZTxKGs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7cb6e6-44f6-40e4-5b8c-08d9ac1de889
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2021 12:04:30.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnn6xhPb+UHt0YEPfUR+uhYUp8IzgsQWseuUqWhsCkK1NSxWZ0usuut90En6uaNFU6N04D0bzaxloMolpCtLGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V2] clk: imx: imx8ulp: set suppress_bind_attrs to true

Ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The clock driver is registered as platform devices and it is possible to =
reloading
> the driver at runtime.
>=20
> But actually the clocks should never be removed to make system work,
> attempting to bind again would result in a crash, because almost all devi=
ces
> depends on clock to function well.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Update commit log to explain more
>=20
>  drivers/clk/imx/clk-imx8ulp.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.=
c
> index 6699437e17b8..8eb1af2d6429 100644
> --- a/drivers/clk/imx/clk-imx8ulp.c
> +++ b/drivers/clk/imx/clk-imx8ulp.c
> @@ -559,6 +559,7 @@ static struct platform_driver imx8ulp_clk_driver =3D =
{
>  	.probe	=3D imx8ulp_clk_probe,
>  	.driver =3D {
>  		.name		=3D KBUILD_MODNAME,
> +		.suppress_bind_attrs =3D true,
>  		.of_match_table	=3D imx8ulp_clk_dt_ids,
>  	},
>  };
> --
> 2.30.0

