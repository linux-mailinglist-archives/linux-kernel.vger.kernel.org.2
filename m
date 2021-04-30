Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB636F5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 08:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhD3GU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 02:20:26 -0400
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:29188
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbhD3GUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 02:20:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCYjb+eYluc7Pi+pNxfbVoCM9X4m78svq0irKJH6TW/g1ZkcjycwSZhzM8zYNDxQCFqtO9zq+EF3RP8UEEqkw1RJEmfA+giW/YdRAWLu8ngIjkWdANA/W6qn/Wgb0pAD3/4g7I/xH7LMLB+PoLC04ZqpZ72hjxoj+zx7cLlUZnn/58INLLlScL7dXzgKdkav6/IFnE5LLFvDoqHtZ96bbvo9VLzCRiMkLilP9qPiiNSF6p1O32hJInhlpvWd7cIipofr8Vm7M4eXtYMBMz7nxOoMTp8NPadpxTEEXEQYSY20KpP99m+g28mSv/rkcZiwwMBs7kGpVWjjyrKkS2od4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEi4Dbc4qxtDNzwwXSEouWPIRDZldGQC0nK2vaXb1w0=;
 b=BGPocxtI4QmpYUZeW8+W3RydM+1e/qzvxbB3BWLV/VyODU37qJAHel4S8eT5qXBSrXZlQhSyCBRb6SZqi11Kjz/cOYrHPRazeWmJwHJtmYeqQe1UJPsShXSkJXxvMGyZW7Z2yfzoIiC3JNf2gS/4lw/VNMYSl22e2hfdHdXP4DmZZ/GWrkoNQzAt3oGWvTPP31CuiFPbflKSIDWpryHSn17/r0DO+txqlSymvH3PUThFUoMcQewCuRY1MI4G2///y7os4M3AJRltCasQwa6hv0pDaUp2IGgEDRi/WC9/XzHl6DAwQdNl5/n7p5ihwz+f1ovBUI7JwD0GdO2cXrPOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEi4Dbc4qxtDNzwwXSEouWPIRDZldGQC0nK2vaXb1w0=;
 b=T8yjaSjmMpWLcVXVrpL2U3f7K73KLNhtgAYRs28ygPMQhHtywAzyk1p46od0yorGpK8+hp3PHOHeFJ4bKSJakqaACkkTIaK4cBebX5Y5sZM9xKFeD6fcO4TgMOawD+Hw7wyKEOCrORi7j7ICJGVowKScG9KWXeYj//71AZDQEgE=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5083.eurprd04.prod.outlook.com (2603:10a6:10:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 30 Apr
 2021 06:19:25 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 06:19:25 +0000
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
Subject: RE: [PATCH V2 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Topic: [PATCH V2 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Index: AQHXPX0Pt+hR2bpNakyVCHD5bDfClarMlosg
Date:   Fri, 30 Apr 2021 06:19:25 +0000
Message-ID: <DB6PR0402MB27605E6DAECE069C12391FDD885E9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210430052746.10815-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c120d9d6-14b2-4317-1037-08d90b9fe719
x-ms-traffictypediagnostic: DB7PR04MB5083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5083FCE6C309E1546803223D885E9@DB7PR04MB5083.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7vPrhSiPEq4UIiNGDgTr1BgtWDwwX1tsZDxRFk1PU3zgzS8qqrdePsx3ixV6YVGnNNYRFIfmW6YAZbUAeKmuO3K369Zd+Dt+6svEPs5Sqnlx8HkUOxJ5Z6YQ+86zQuza+5tv8BqFnrJgUJI7YzrDnb5V8sDhDmFNd683FPMYDXqrpDQKX6cvQtcmzOsmmBemzOnlWQ4jRiqzPWZM9JQHqVwT+CntEtOVgkumi8HHx8gw6yhO6SagwdGYjIi/s0SR5yY/wgKu789RBa1rieXylfJ2Ikg55t80J+bmbi9JqvjisYFjPHMe/bn2ytyymQl6/7JhqYjbr0sCqLvZ2Lkm9lqzAftSrsCTgGHDXo9iLRWnVaXXjRfOOvPfLvIFJfpsjzp1pzYh+wDTi7KwaMjWtesEsobmIRsWRKgq7SsTxcYxn+PxpAoz6CtY2wxvioSJX9cD0VcUfwUT9xVLqytcUaZHubQI8hKNW+UBUD4tPzpf+NCdMfvt1kcjln1efwcr88cj72nl0LCwRx0rNyI2Q4aMU4p18cZomLtyTjkYvjCn6HnSXay86x/nD63P3n/37VHSXEUaxePOaEOdd1I0cIt0DqgDPO0CRICnNcpBv8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39850400004)(7696005)(122000001)(86362001)(38100700002)(316002)(6506007)(4326008)(478600001)(54906003)(33656002)(8676002)(66476007)(52536014)(66446008)(7416002)(26005)(55016002)(110136005)(5660300002)(66946007)(44832011)(8936002)(66556008)(2906002)(83380400001)(186003)(64756008)(71200400001)(9686003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jvGYkq8lSVDfS7QX49GMDA7ayZ66lmf+uI2tPBV5QukHXK+DGTjGQyVp8g8u?=
 =?us-ascii?Q?Dwjuo9kDiJ1Lt7KNairN1ziL6GGjFpN25QBK0/KLoFlb+p/g7xf8E+s3CtDX?=
 =?us-ascii?Q?4a0nhF4FI9iKg9qAh5IvO6T26Ijl4kbgV94tcdxV0sPzs6BKJC8VSZ2PefuI?=
 =?us-ascii?Q?b25+WwPHmsm/VmhzFepUHRVegBU8j/vkDzHIM/K1gxze40C1Z0Ccs2WPN9zD?=
 =?us-ascii?Q?1hAJjsb57CKzwlWipArCRRdZc8nIEKkhA0ysctsakIHie6ynRT7MVT5FJxyH?=
 =?us-ascii?Q?eN4/uUB4KjAs1jXl4LGQVNnolmaqYfvbUUASoxHxCk6SUSziVpWfXb/6feix?=
 =?us-ascii?Q?DeX504CsWYEgrTXsXfrnerCWFVUjrLoFrErKIkWwHmg26Xi02R8PuP1iWbRU?=
 =?us-ascii?Q?75+wOJlk7LFF5M5vgSeN6Oo7ePsq/Mla6MVZDhCUpGXh8dVysBuujD3EqXc5?=
 =?us-ascii?Q?Uyhbnw9aG1InSe5dXuwRp3ZKucLN9pZBiPNSMOifD8GGsRZqTimP/XmK1J2P?=
 =?us-ascii?Q?QDAyt7G1zctOGOaWvXGhUwvfont38ADDgJHxP2NTj1/ljPwH8+P1tYR+Str3?=
 =?us-ascii?Q?+itHpMCkY/MfK+64nMXLSYldja8F8tAhIL7SGenNfcO95IxZMJE44GEXcYLP?=
 =?us-ascii?Q?2D6UZObbSc/PmtaoQzgyPF605s1QF5Knig0BhNh8tCVZ2MKnGMYT3wS6KwkK?=
 =?us-ascii?Q?hIg+tb65e8/9CU6hi6FiaLVzQxlfqsT2s43ZUdt6bBCxWJtNO5HhmnIe6C55?=
 =?us-ascii?Q?fuPoId3mlFHoLAg3BY76QNHJUOpYGcIrWxKJ5UVHmz5DGf6p5NJpu9UUaQv4?=
 =?us-ascii?Q?QPiXSwkVQlcAZ09ChgiysiXC0+iqNFXVHcdVo4ix6kAXRx2Cgbpevf/8Mjzt?=
 =?us-ascii?Q?DWwpRUGjfINCNFRxf1KrA2mbNX4BjcX54jgv1GvJoHjqfauar+0cyVJNgT6d?=
 =?us-ascii?Q?KeKDxbPHELtbO/uiU1WuNqxnfgQCqmIr/TzlmZEmyXBv3qL4aKi2/DclsBIW?=
 =?us-ascii?Q?L9ZU5GfP8Ri8NBHMJYarf6zbCaSbb8WrA7G9J18ULw7u/v+l1Us7bEvPgqZ8?=
 =?us-ascii?Q?Mo9iMuvUZ8prZnRi6SyJ9P7/6cebtYadmP0rAFA9o20JAK8CBojL+plJN8iR?=
 =?us-ascii?Q?6pvOlnDNq/b45rQFGj4rhQsk2J0reG+VFazq8p5F0f997wU85lLy28mSPVHU?=
 =?us-ascii?Q?VfS9DdLEzqnhRd8QPyz8fjzVa1MGzHsinzY9YGomS9FD8nr9KqroG9UAGo6n?=
 =?us-ascii?Q?AB3Ce1qZxfFcNAOOMeKQZ4IuajeLPeo9+6Gn+VMaVVEfEo5n2quoJIngT74k?=
 =?us-ascii?Q?sXZjVvZRJi7IExh3hHM7qoV5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c120d9d6-14b2-4317-1037-08d90b9fe719
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 06:19:25.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EB7ipAPnsHTh0J2w/OhxQ5bO1RalfbY/dWkwZ654Myl0nnCJgj/z+1SZGXznz0Ss/0qnUaYUlh2pfnqZJxXLYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V2 0/4] soc: imx: add i.MX BLK-CTL support
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V2:
>  Fix yaml check failure

Forget the address Jacky's comments on patch 3,4 in V1.
Will send V3 to add fix.

Thanks,
Peng.

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
> Peng Fan (4):
>   dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
>   Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
>   soc: imx: Add generic blk-ctl driver
>   soc: imx: Add blk-ctl driver for i.MX8MM
>=20
>  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  73 +++++
>  drivers/soc/imx/Makefile                      |   2 +-
>  drivers/soc/imx/blk-ctl-imx8mm.c              | 138 ++++++++
>  drivers/soc/imx/blk-ctl.c                     | 303
> ++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h                     |  76 +++++
>  include/dt-bindings/power/imx8mm-power.h      |  11 +
>  6 files changed, 602 insertions(+), 1 deletion(-)  create mode 100644
> Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
>  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c  create mode
> 100644 drivers/soc/imx/blk-ctl.c  create mode 100644
> drivers/soc/imx/blk-ctl.h
>=20
> --
> 2.30.0

