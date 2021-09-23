Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA0415800
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhIWF6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 01:58:11 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:56547
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229645AbhIWF6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 01:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrThJ9akA22jJdlnUmoNxybqmOtrB1yt+oSudzYKGiovo9qIgWBoOZNTR2X8OfFVQzqLeuVUDWD4U47RvXVRm0k9+Z2cfas6ISBw7QUFVTCix7dvwY5Y7I4sz2Eg9YZENW5BFV5AzfQ0SQUb5v/n9cXVg2GVu/DeSFFreJYIQksQRXaUNxvidzoUgqpZBeN6lbw/RV3w1Bn0Pqgwd8CgYy2c7V/79U1+b6D9ssagTSq9T0bH8N8fmgOarqylU/hI9JL0SwWpQtfXhgH5WIr0oe5j5nNsoMWFIxggKtaih4PCchuk+seLWJ4rPfXqrfJBWE2sLq0HvEiiKBrTRY8XPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D1iXYUAb7uWkFiMM88A5DJyPfaKesjYQAtdfX81rumI=;
 b=nLEXquOuS9HuTrHJgCpJtzzfDo0ZV56ewUmGXhs4lsf/3ndr7dvtSVNx9+k7EU3hKKrP5yZRHFSJx7UvyiwX6ddhGwHi77gBilLoIbiv75xPpOj9HpvmfJlJaabLf1ArHCyzVOON2hDoASyAoZsWBjNXnx09g00EyFwAD9voNppyINK7k/wXB5lmBmnoWP5X8e16X+LkT8eee+vD9IS0wYsT96csQ+RGrKKC/zee26AbJLzYz6dAxtP9IK+t8xYOKQz0vQmte1QvGthBcKsiUE6MCGSBcTlEHP0OWgq6l7Lpf1c2YbGBqxGvHvEawuNPbSlFEcvU+Y1MPIsq5yIdVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1iXYUAb7uWkFiMM88A5DJyPfaKesjYQAtdfX81rumI=;
 b=HHk8N4azTVXIHR7juBY3AHfqo+m0q1ro/7xl4fKm+AT7qAR4w5xSixIJmdJncy/Fg3qZ42WxTejz5l/P0R4hHyVifsuZRKj6wHo8Pgd15o2jouGgYk4cu7EgJ0ovx2v0hFuhMH+72YxFvcDXjluOxVE9dWgoQjkdvs164qOMSRY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8594.eurprd04.prod.outlook.com (2603:10a6:20b:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 05:56:35 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c5ef:f538:c3e0:c4c2]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c5ef:f538:c3e0:c4c2%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 05:56:35 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the
 pad modes of imx8 pcie phy
Thread-Topic: [PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the
 pad modes of imx8 pcie phy
Thread-Index: AQHXq29U8Xq0ppHtP0iI4eEm7KofLauweGAAgACtOQA=
Date:   Thu, 23 Sep 2021 05:56:35 +0000
Message-ID: <AS8PR04MB86766122EB2D851844FC7D7C8CA39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com>
 <1631845863-24249-2-git-send-email-hongxing.zhu@nxp.com>
 <YUuDMjBGWfNsMf2n@robh.at.kernel.org>
In-Reply-To: <YUuDMjBGWfNsMf2n@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcf2442a-8214-4e58-007e-08d97e56e701
x-ms-traffictypediagnostic: AS8PR04MB8594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8594D21BBE89A331C6DC9A2F8CA39@AS8PR04MB8594.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FgF+hce7XjbYraQuV/lI+LjpyVvOEv6JLmtBmcuavmxsY/OGYqCIagf4bIr8L1pUmEXdK3c6WAS/CHLoHAIjziX3p1uMKm1daBAJ00zacNYzuY3AXO9P7o67tdLnDdNr/cJ7NBVZLKhWybOtrayVSKnZwkxxi7HhLvU3gUS+8pRysMG+cxRH2P0dCM6L9Xh0tSCZBmp6jJU21Ngnq/T6Kd37MJ/45B+zECibNTolFUBy8NeLlxpooGAP2pJYRgo4L+/HS94QA+szZH0grKPhz13uP/SRqqyp5n52lrUUJapxMEWBIZi5zdcsoRTo56GFfhz0uTcOHVkiEVIVA04kr5vCkDuYoptwlP6cvQksaGFaBxijyQOI4aljNTw0ZuVoow+cwUB4QwhlLa63xdx49vNL2u+BZicJqIQImQGKOyPYn8URSEFzOzw5nSg72D9eE2hIH1r3/r2INODiDbwX6hiF9Ymq3M5R74iS6RieVR/GWXDEd5dWFL9jCmFsXFliCTozfZ62aZqid+rkCH8RGrrj+FnSqH3xgyYv4/OrQTeVSmSsCmrBUAYGSNIfEu6lim0LgzMro724RHvaqb9lMuWtiBT5f7zNJfgALQsVtRf/nQPRZvxFNWIkW+u1x7ShAY0qntqAEMq2+OR/QGCFwTjezxx1s9cReUDgnpC+JCpMmzOMvkEqmJG0xmhh6pFfwpjvNqjofIEJ0Z3HITbFew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(66476007)(64756008)(7416002)(4326008)(38070700005)(54906003)(66556008)(83380400001)(66946007)(71200400001)(33656002)(38100700002)(122000001)(55016002)(86362001)(9686003)(508600001)(5660300002)(2906002)(8936002)(316002)(6506007)(7696005)(53546011)(6916009)(52536014)(66446008)(8676002)(76116006)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r+8WyD1iFdUg8eMoPdzBHZQc3v3CcKSv25FvxpUBLgQnV4AIyjiPwSJ+1v2C?=
 =?us-ascii?Q?O4k+Ri/uwqXBIr6olCb4htXWUyr0FaS6k6+o+QiGWMJXXslgncAHFfM4l98u?=
 =?us-ascii?Q?wbhS+1lhXHHeMDgK4JWdP7DoRAjYHGWF6SJ2Uzj3sBHwWtJ6rav+FMdLU/xY?=
 =?us-ascii?Q?2+wJS3DKuqJR/+1wqjAucs5XxjGZa6tej+YVHH0fSlwtIPqW/13YK817D41D?=
 =?us-ascii?Q?3WD6s10d4GkUzTNWCgiHCPc37GUeY0BvC1Oxp+eoMZm/Lt8QA9zqDqhI7dSg?=
 =?us-ascii?Q?wmKTHPZx32e37Q1+SQsjURNU62dQkEm4X1t30A5t+3Q2UKNO/k6wVCUcfLW8?=
 =?us-ascii?Q?i/9dZ8sikj8OhQCgvvRxw9yrDYYFaHufQiRhv3M4/PsK0/EBcYaX9lp8JZfU?=
 =?us-ascii?Q?SoWZr5Z3Yj+r5ZnJKg2dTj+Q9u7CvrgdhjYsEUAyiL6kzvd/fICtptfrKbKV?=
 =?us-ascii?Q?YRVbnslocR7E5Touq/qt+3W4IEEfa0M8GTyELA8wzMycWzlZSGvl/y94lror?=
 =?us-ascii?Q?OpzqckfnrFr/4XA+pghyGnCVhWvJmyC4Ets6XxeOiSQ/lczWmKvVLjJyNUgq?=
 =?us-ascii?Q?oHnXgwAs+NaL7GRsAzQvVqBMkhfF9+Q60HQYgKATbyLGsBZt/RjCCCp4/avb?=
 =?us-ascii?Q?y+KnRuCQrNdnf2D82U1uJ2cHPN9NAWuy30p4V6CgeFxxk2j+bLC7YBxTrEG/?=
 =?us-ascii?Q?r+nkiXrQ3SnbdMjl5qjm4I9aQC9PInFmS1pgeBXoZeuM2Eklik8om+dS+ZYX?=
 =?us-ascii?Q?boRuiP2XfAgndNIMX8yYJqJ/XmCw4sMmEDWe70WLhPB81Ii3AF6b4texF+V0?=
 =?us-ascii?Q?01mlV16sNyZjS0HdbvmR9QDcQiCBXDNMx7UZ/fYMxA+FrJzmj1QSWhyJcD3G?=
 =?us-ascii?Q?IE/TwrZNzIb1nkKj12K2iE19mK0F28moEVqErKTopbPAdnfuYY5H6gNfLBHe?=
 =?us-ascii?Q?qTaRlUqEtZS2Wkzf3G7XYzo4onXOVbpb5WD6FwoivdwRJd4tNmhP/Zy1upDs?=
 =?us-ascii?Q?ve3dAvqzEVbswGuNHlYJoVmXgMZt//wyh8HW3ExEi5WQyOywtzX9bk3r8Czc?=
 =?us-ascii?Q?35FAOmQogL9albGkVBFEKC9Ljyww3D0jVchf6BFGvJlzPW2HFPcdkbxLw5G2?=
 =?us-ascii?Q?gUsThymjVGVltY7OZSvr41XwagBVKodnnfJXrll97apU3/WlQjnmyNcoWo79?=
 =?us-ascii?Q?GA076ACzT4d6lxhOqMfhTKGyP6guXL/PwFICOiHyECAzWAdP694Afw5WepkO?=
 =?us-ascii?Q?y0/GRLIlobW9o+EawKtV7neY934iNIYVdSVaw+EOw+pTUrjiR2gQJl4wSRkV?=
 =?us-ascii?Q?Pk6rUEMdDjLSxkr9Wf7WL4fC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf2442a-8214-4e58-007e-08d97e56e701
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 05:56:35.7047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlDBA3DSME5blbo+x7xMkBJ4GR1qccswOT9upGxr4CLnbHXu0daxC7GKyoCq7B7ylpiO84BBe33h+MUZOzQ1xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8594
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, September 23, 2021 3:26 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; kishon@ti.com; vkoul@kernel.org;
> galak@kernel.crashing.org; shawnguo@kernel.org;
> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for=
 the
> pad modes of imx8 pcie phy
>=20
> On Fri, Sep 17, 2021 at 10:31:00AM +0800, Richard Zhu wrote:
> > Add binding for reference clock PAD modes of the i.MX8 PCIe PHY.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  include/dt-bindings/phy/phy-imx8-pcie.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644 include/dt-bindings/phy/phy-imx8-pcie.h
> >
> > diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h
> b/include/dt-bindings/phy/phy-imx8-pcie.h
> > new file mode 100644
> > index 000000000000..fe198a0cc12c
> > --- /dev/null
> > +++ b/include/dt-bindings/phy/phy-imx8-pcie.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>=20
> Perhaps this should match the dts files license...
>=20
Hi Rob:=20
What's the means of the "dts files license"?
I'm not clear understand that.
I found that there are almost similar "/* SPDX-License-Identifier: GPL-2.0 =
*/" license contained in the files of the /include/dt-bindings/phy folder.

Best Regards
Richard Zhu
> > +/*
> > + * This header provides constants for i.MX8 PCIe.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_IMX8_PCIE_H
> > +#define _DT_BINDINGS_IMX8_PCIE_H
> > +
> > +/* Reference clock PAD mode */
> > +#define IMX8_PCIE_REFCLK_PAD_NO_USED	0
> > +#define IMX8_PCIE_REFCLK_PAD_INPUT	1
> > +#define IMX8_PCIE_REFCLK_PAD_OUTPUT	2
> > +
> > +#endif /* _DT_BINDINGS_IMX8_PCIE_H */
> > --
> > 2.25.1
> >
> >
