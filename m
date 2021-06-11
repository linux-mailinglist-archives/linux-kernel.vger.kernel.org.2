Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490C23A3E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhFKJHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:07:48 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:26857
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231303AbhFKJHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA/X9apsE/6NcnyAJos4kUBW2FT6tRvaqe1AmV/Ak7xZHP3kDKPH2eyENU4cGe3y5El5+LM2cmk3bt3l4ZQo4iM7jK6nVa9LC5t9wO4RoIH0dgxaO2DLMGGpxjaU7LKg7/SuluHju3tFWJ78lH8+H4HgjsSpkrn8RVuXehxQ6fs4seG1lBYJDk9Wvi/GQTZOAJ6LHISQT72TOxNxcA1+rneDlaBD4QT+6o+Zz1DYtDULHnuBZQFbDLCQP3LzyVRHtWrQQEFzAXX1k3ZjgvOMSsl2TN2KUhvcbMfgy3cjMe6axi2Q69gUH/JA4RCUW8bIS+HbbIUGQ5D9h2aJYUZAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2ER6DekUCGlJlHK20OikDcs9cUNczbUUMoIqtX/Zf4=;
 b=aR/ObMubnU7G2yt+CswfWTxWOi+MU4jVob7VNZ1P0Ske31d4ra1uNmU8ULLXTyaArJCLz/mycv7JoWW4fQBlMs3vaCSzSiSUj5TyVvDQHFKxW2fVqQbbFPsQKskGUtgGT7I4pmQ6oQzZNAxVVAAk+XtC/zB5BWPL8uRPTWSvX/gLP2ZJds6meb53K5+GNtnrTUfu/1ss2ysFfRFQKABdxwel6hi1HpzevXbUjTqqHbIZz3nizPxZpJgj9EjV28Og5IJQJY98vyXvNqrlvqToeQyti435fltF6NPocNkToWIzdTq4drYmd1GgGzi7rJ09BVM8K6Xk1xxG6BR3B/XA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2ER6DekUCGlJlHK20OikDcs9cUNczbUUMoIqtX/Zf4=;
 b=hjiaXwyh1WJ8Px2JSUoaMfb7bcAUV1hgE3nSu7QMa/6posQxc5V8OQsCKDy8GnvgFUUETDnmhnh80MH6v7WJZlaxgzGvIVIul4EjDidfAli3hROhnZyfC0JUo2na37KjKkccMkKmXpWnssStrCGfjCjtSLm27AnqBstX19cCZw4=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7416.eurprd04.prod.outlook.com (2603:10a6:10:1b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 09:05:47 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Fri, 11 Jun 2021
 09:05:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "marex@denx.de" <marex@denx.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V6 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Topic: [PATCH V6 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Index: AQHXTwvKZ2UCK6/vGEWua5VFNl60P6sOo6zA
Date:   Fri, 11 Jun 2021 09:05:46 +0000
Message-ID: <DB6PR0402MB2760E87D64285EB00CFD566188349@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210522134249.15322-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8f0e718-e054-4e8b-089a-08d92cb819e6
x-ms-traffictypediagnostic: DBAPR04MB7416:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB741627065F1512CAC05A296A88349@DBAPR04MB7416.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/jt+IJltAwAOa8CJ5NgwW9l+5mIlf+OepqoFTwixaYvAtGQS+8bXzJSzB/efY0Z7CcguvLS70GeyfwrEhQfOJAa0F4v5oG3jh1/DofOMtrvuSWp8jCPEWbKOpY3hYC1jZuNDEQRwd15MBLbDp/Z3QLiWc4Lya+F/+ZoK0rUbPOTsq1x61YgCiERLRY5nl7IXtRqMCkoUjsu3LeEhrWTDo4PfUuUvMMH+NXnePSutSuMErs7J1F5LQe8YmhLVvqfZ3iv3ae5sOBcBDQswv5l4npTxTe1CviTagFjaJc6YHzmCgZOgK3YCM48UBzI2UVZy8IngIGTNNHrsblVkk+U8S7twhRQAoRGrjBjfvOU9uJVoymg6klAtJO+MpcmIqzYd7M72q22kTQgS7NHujMaBwVf6oOFhVNwfULBoZgYJ9Uy9ySD4QV8lT9FRX1ibFhe/67adaAufDVG6CkUNkW7b5EKyYedXw9Ae1zfNViXr1a29WCuxIZ7kmKxmNWprZz8Xdof5pl9g7rYXEinXYRI5ZiQVAV99FvBbuOWz18Ts33aS+dZ20VdLyYkJuvaoS+Si7L3L5+HpXRbmvko2DAhvX13f3/lkUsofZiEOJaFLmMsOS+lsAc4sSPnNgxw0hObAK9n+toxGyH6bYNfYPqzQgwm3mMU94rJtiKO+HqxNtj34F6w42azmPsV/ox9HT4P19KSR2neXx5VQUJlvrfM+NkacVT7WrgDHJCSrBbBc5o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(966005)(55016002)(9686003)(7416002)(52536014)(316002)(66556008)(66446008)(2906002)(66476007)(38100700002)(26005)(86362001)(4326008)(6506007)(8676002)(66946007)(44832011)(71200400001)(478600001)(8936002)(186003)(5660300002)(54906003)(110136005)(33656002)(122000001)(7696005)(64756008)(83380400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hIkBUyLFyf1Ufor5+0ZZOd+ml8+VD3pKj2r0AcD4sDCXmeni+de8a6dnZtwh?=
 =?us-ascii?Q?+ta3DIcOScejwcRFo2njjj+VdSBVoQlY4FlxNRU2nVlPebYDlzKQrQcb+U8U?=
 =?us-ascii?Q?/mm3o2mtJqvIf1IcuXDigPJOdydXhMNKVh9grr/gFS9PeF2Dm1treL1nfl93?=
 =?us-ascii?Q?mvXdZPIvTajHxTs1lalXtlIqMPWqmu9gRP+O8h2Ip6WkSjjDRXc4omD/vT0S?=
 =?us-ascii?Q?CXJpa4MS+Ghbn+wMHz29Jzij8vVQn7oCtc7soYtQQBsWFz+79hH0hhCVUVHR?=
 =?us-ascii?Q?Cmr6Fmlsf7e/pIMhQ26h2UpNQ5ZVtwaRrDcf46vd3l7xOmpwLtBH5DP+cgpN?=
 =?us-ascii?Q?NK442tmQrXfaiQZnBMzrWvpUjOPVogZqS9tq0JzsMrQm197Q+M4BUPOYkQWX?=
 =?us-ascii?Q?skY5VBrJokdK88kumRZGVh/I2W3y9IV0r5vHkzGQ6HD8mDrhP5zZZCXn+PhS?=
 =?us-ascii?Q?6jJCMhF9pZBD/dgsK9xv7Qx4uGpI4zZs1dGGIx9AoqAz1vTczvpkFA18sAgJ?=
 =?us-ascii?Q?+piWA7OwoDSs3fz9mAC17EXQYCt9PTmvkW9IkPJCQ7rdAvn9bxVwIhWErikx?=
 =?us-ascii?Q?gHD/2buCsnIgW8CDmSfkoNODsLfT2/4lP7o7K3OQSlf6x4gO5k7n/M1fiFsz?=
 =?us-ascii?Q?c8RcvOnPr+VTZM+Yc2+gwcqSZsL8yoY8S1NnZ4Wuue6b2BP5e/uHoBi8GQuT?=
 =?us-ascii?Q?noZ8FPoPKu4wFz22Anrgn9sgWtgFDoJLBTqiBdOSjg37F5+N/LL7dpIjD1r2?=
 =?us-ascii?Q?igonLWDEWo2rdO0Yi1H6xIPdpd6fsx6OTh0LAStO63JvK7hzhLuQMsIjL9jM?=
 =?us-ascii?Q?7qSOvYFq8Hnx0YLSOZPXEMRplg81cSZeAyC6nRCqhtAxXZzTF027W6u//JIg?=
 =?us-ascii?Q?bHa+eT8gv/fxaAEn/kKnVsTdZby2WoC84Qzpd2Z3UJCFHM0QeXkJrlDUr2UJ?=
 =?us-ascii?Q?iQw8DAqsSFXP4lmQgNK6HzEcPgYBXGI3fmStn2p8c1Qx8+FST3xrXt75P0uw?=
 =?us-ascii?Q?1awDsa0Ev/yBZkX7G27O8wGnLdtsMflNy7SxqZK8NBxTEBUF5ESaZnKlfu2b?=
 =?us-ascii?Q?X0Fhp48JXdnpW9fdVEHWvBifVcsrgAIGvvQFQzjRT1ud253MFi7J9SENao5P?=
 =?us-ascii?Q?sfing6agRrm0ZzDHazpCXHZgR5H6sDTqrD0WW8QYUxE9n/lXf1kyiu1BWjjx?=
 =?us-ascii?Q?T1giH308gH7xRFnYkkuBm4IwTgk1AsPtygyW0Vh/9Ff5MS39fCsgNcsfiil/?=
 =?us-ascii?Q?tn0KWVDaksYyhT1Hdc2GPuzxeL12CQudlu1s/DtRW+QOCzfz03CZ/RLE5VMu?=
 =?us-ascii?Q?HrTnQCth7EOy6jOkeMdzzFxr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f0e718-e054-4e8b-089a-08d92cb819e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 09:05:46.8466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxhPvLiEH3ypOzXKoqHjjj1zfEPu0L9lXkazZYUkiZHuBf1QgHFz3EcALd689K3LxbtHQ/Wf46LeONCCJ2FRPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7416
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn:

> Subject: [PATCH V6 0/4] soc: imx: add i.MX BLK-CTL support

Gentle ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V6:
>  Thanks for Adam's report on V5.
>  Resolve the error message dump, it is the child device reuse  the parent
> device node and matches the parent driver.
>  Filled the remove function for child device.
>  A diff dts file for upstream:
>  https://gist.github.com/MrVan/d73888d8273c43ea4a3b28fa668ca1d0
>=20
> V5:
>  Rework the blk-ctl driver to let sub-PGC use blk-ctl as parent power
> domain to fix the potential handshake issue.
>  I still keep R-b/A-b tag for Patch 1,2,4, since very minor changes  I on=
ly drop
> R-b tag for Patch 3, since it has big change.
>  An example, the pgc_mipi not take pgc_dispmix as parent:
>=20
> 	pgc_dispmix: power-domain@10 {
> 		#power-domain-cells =3D <0>;
> 		reg =3D <IMX8MM_POWER_DOMAIN_DISPMIX>;
> 		clocks =3D <&clk IMX8MM_CLK_DISP_ROOT>,
> 			 <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> 			 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> 	};
>=20
> 	pgc_mipi: power-domain@11 {
> 		#power-domain-cells =3D <0>;
> 		reg =3D <IMX8MM_POWER_DOMAIN_MIPI>;
> 		power-domains =3D <&dispmix_blk_ctl
> IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
> 	};
>=20
> 	dispmix_blk_ctl: clock-controller@32e28000 {
> 		compatible =3D "fsl,imx8mm-dispmix-blk-ctl", "syscon";
> 		reg =3D <0x32e28000 0x100>;
> 		#power-domain-cells =3D <1>;
> 		power-domains =3D <&pgc_dispmix>, <&pgc_mipi>;
> 		power-domain-names =3D "dispmix", "mipi";
> 		clocks =3D <&clk IMX8MM_CLK_DISP_ROOT>, <&clk
> IMX8MM_CLK_DISP_AXI_ROOT>,
> 			 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> 	};
>=20
> V4:
>  Add R-b tag
>  Typo fix
>  Update the power domain macro names Per Abel and Frieder
>=20
> V3:
>  Add explaination for not listing items in patch 2 commit log Per Rob.
>  Addressed comments from Lucas and Frieder on patch [3,4].
>  A few comments from Jacky was ignored, because following gpcv2  coding
> style.
>=20
> V2:
>  Fix yaml check failure.
>=20
> Previously there is an effort from Abel that take BLK-CTL as clock provid=
er, but
> it turns out that there is A/B lock issue and we are not able resolve tha=
t.
>=20
> Per discuss with Lucas and Jacky, we made an agreement that take BLK-CTL
> as a power domain provider and use GPC's domain as parent, the consumer
> node take BLK-CTL as power domain input.
>=20
> This patchset has been tested on i.MX8MM EVK board, but one hack is not
> included in the patchset is that the DISPMIX BLK-CTL MIPI_M/S_RESET not
> implemented. Per Lucas, we will finally have a MIPI DPHY driver, so fine =
to
> leave it.
>=20
> Thanks for Lucas's suggestion, Frieder Schrempf for collecting all the pa=
tches,
> Abel's previous BLK-CTL work, Jacky Bai on help debug issues.
>=20
>=20
> Peng Fan (4):
>   dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
>   Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
>   soc: imx: Add generic blk-ctl driver
>   soc: imx: Add blk-ctl driver for i.MX8MM
>=20
>  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
>  drivers/soc/imx/Makefile                      |   2 +-
>  drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
>  drivers/soc/imx/blk-ctl.c                     | 334
> ++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h                     |  85 +++++
>  include/dt-bindings/power/imx8mm-power.h      |  13 +
>  6 files changed, 638 insertions(+), 1 deletion(-)  create mode 100644
> Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
>  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c  create mode
> 100644 drivers/soc/imx/blk-ctl.c  create mode 100644
> drivers/soc/imx/blk-ctl.h
>=20
> --
> 2.30.0

