Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086AA376DEF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 02:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhEHAvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 20:51:07 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:44678
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhEHAvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 20:51:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTbZcS6WchxrUFClJqU1M86mZE1pOoK4UD8mpjJGPkuQteXFnI42z/BSI0xQlXgypboWswDOzazvMtjUnjbGH2PeglYlXsly6mLQ+Pz/f4j4gXwUPuQd1YvYVmZ25nPRJM/2DsU8lqNO2LZJKuOLg7Tt8AnI3TVjvAke6xDFNuZIYrGuOqNufrRVADfk3wXtODjq7j95YZCSp/ymIA7OQWUPwfhY7LYQFqh9wff++mM+OnmhhK4Asnw6kdvBbGicpV4gxFCjAm14W44H7GeD7ewxG0iqlYiIyPO6ujQY+2c6R7QK1G7ebPHit4KNzOcYPAd0XAYyHrGFtncwbI773Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P4C9sJoSsff8TNspKYDze5lGn7XEtGKwp0f7fY4X10=;
 b=dGk2ZU5Lm24ExyLMp7DQQz8No9NyTa5pPW4/QIXGpCM6nlI/e5QDha9J5lQztcv+Vft08ZMobhflGp/rfqBTNBL+CqiEz0fI/3lnWSpyvjT0cD9mq0ezuNCHqQE7VdKDIVrS6O9nmq6ad1GpISzQZBJwLY7uPxH6QAhqhddakC49gD1RiJOwbG1iZLbI26zpeG06kj2nCzWWvkFm/2x81SiNYuehFwB+6PXDYPGDEF3Ui8H24rS21HRQ5ipNViHlAhKcPM2ZLHEzVbBXp1XjUexQzkbrhn7dFk8MA/+ICg5+kdJvqY797svqwsg0uALDMw9phbLk/1rvz4Z5VnRAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P4C9sJoSsff8TNspKYDze5lGn7XEtGKwp0f7fY4X10=;
 b=V1zXS+MUM8eUc+6rYvSuxT9ZL6cbc45FgMVlYEs9MEjXfxhE547UJMDCqzVBt+1GVhziS4iTKuJIaQnr+BjBMVpKSYa3xnF60PWjgddar4anLcvLAnL+HfFn7yp4FJjdMKPiHNw27zju9R0Yzf5NHWeySou1EyTlvjd6o5lKNuA=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4940.eurprd04.prod.outlook.com (2603:10a6:10:22::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 00:50:02 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.030; Sat, 8 May 2021
 00:50:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
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
        "aford173@gmail.com" <aford173@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V2 08/13] dt-bindings: imx: gpcv2: add support for
 optional resets
Thread-Topic: [PATCH V2 08/13] dt-bindings: imx: gpcv2: add support for
 optional resets
Thread-Index: AQHXQg9lFCKMAT3qeEKae/xO7yR0fqrWAhGAgAKGQoCAADuM0A==
Date:   Sat, 8 May 2021 00:50:01 +0000
Message-ID: <DB6PR0402MB2760B7FDE5AEC56C782CC59A88569@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
 <20210506010440.7016-9-peng.fan@oss.nxp.com>
 <a6554ae1-75d4-e471-6371-d9ad2246599f@kontron.de>
 <20210507211619.GA2899069@robh.at.kernel.org>
In-Reply-To: <20210507211619.GA2899069@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c500acea-d790-4c87-6f89-08d911bb36a4
x-ms-traffictypediagnostic: DB7PR04MB4940:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB49409A8594878DA4E9F9B16A88569@DB7PR04MB4940.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJEcjNnqEBkezGgn5ibM8KrGJMyjDCTp9F3XsqAvfYvgS4NzCUUFLCPpYo3eQbLlavZEpybX2W4XUeUjI/+194/SCNaCmq3JaEViTvB4VNTh23rCeKCXR64blNlga8mUMF+DumDGfA5ZNO34G9e2q9e5xI/JUwKIWQF9HLu2gkN1CfIY7I//hhODaUufu2ccvGB0JFYHCOYg4RUMq/TnpmfZQrSlygpkInqZ89t6bSy5/HiL0iUh2OQTgIbf11qwT11tTy7SAtnGBsIyPCpsjbVa22FFMpeoHZgHFUCXuG1SPJRLDxfsDVHeqb9CzcaQ2WDO8YAH7wFj54c0YQiTUdjEBozmq4sJusYOMrX3vwNYFB3SULxTaL4gPwNF9/jkT+UIsgHzZ4Y2EwLfGq6nD5r1qbC12orM/Y2yTr4PUcP5Vr4G2AeVmZwXH28XqXxPUZtwUMkaw1BEQNyk/2C63Mgj1HSAWP+BJcipi7S+QlGKpydvl3cCAq4CDvui9H8bI8i7LfMQ4BaetdyeSfEFLigc+ZZlJPhw2lbyLymoiZPO+1BlU5SRKq0sJoFwgM6Gxa//p2K2EOvMLicbxJxgXBjYzLUlDVOa89L78ZZkvq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39850400004)(64756008)(66476007)(66446008)(66556008)(76116006)(66946007)(53546011)(6506007)(52536014)(83380400001)(26005)(316002)(38100700002)(110136005)(54906003)(4326008)(7416002)(186003)(86362001)(478600001)(55016002)(2906002)(5660300002)(7696005)(8936002)(8676002)(9686003)(33656002)(71200400001)(122000001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s5vpMz2M6bmgfeFmNbl36a8ZugoULodT1TaY4/PJrkLSv6+xXnmGwfBx+hrh?=
 =?us-ascii?Q?thor/tgZvNXwhEQDmox8WII8x1Knv3r9L0UDLPYgJrr53SXO4sZB+I5/0+hF?=
 =?us-ascii?Q?gp3/igRS3dEhYe0Vm773RW7nD/cXY+qYnwjK5AMf8dSv0JFPSH34i8jJAohu?=
 =?us-ascii?Q?Pm9IuKtquYlGxfxzXnEqOCz/Mq8Mj2qJf3Ao24IrIYi1M4MHmEOMJvyfmN2q?=
 =?us-ascii?Q?yImiMvNcqGAXnBF0INduv4VJm6L7kQ0mIdgF6qLAXtQME+RCCiT4rEE1kSL8?=
 =?us-ascii?Q?wz41ZXLiJ9bJ0tDh0TtW9P+v8O+lHGm8KmALYp6NtMkWHotz3g1bTwZs5Z/a?=
 =?us-ascii?Q?MiHNbzBKc5UcqvHx3rgpXGsRXYDZT1Dm723L922iLyiVXKVLKI6XdUU/BOPl?=
 =?us-ascii?Q?yNMFTM8tqYDOmPnYgMUTPOuL0pvQu1Sdu8sVVResusJUS8odUoj2RkW1q2S9?=
 =?us-ascii?Q?iVfw2w/A4pj40hwlRSidzmF14mS4HuSQyYUGJmkZTbA44OeTb2F7kWlYowHY?=
 =?us-ascii?Q?TFF2WAiOsdy9n9mcNz3EfUKjslEhLVM9yEWPpV7apj8AsZ2YkC8IQkIi7VTM?=
 =?us-ascii?Q?Lvnh+hSGRoSH0jOOWN5yI7YojAYPm2Lib/ip4Vjr1GH3TqLNMAIaPAcISWZK?=
 =?us-ascii?Q?tADO7QdCN837pi3SDXFT5VVDNUskc7fZdixx2pi9XzuvmJq0xckZsv4iq5Ct?=
 =?us-ascii?Q?ib1I02HEOq9VdR7gpPCy2Yf1MZ0t7I9RomSd76Tpt3KQJrQPX+j69RWi79Ek?=
 =?us-ascii?Q?cOlyzMf72HkcUf9wQuNV6tjMs0M2Y36nhi9UV+oiowatTVifiVQwtJfkksET?=
 =?us-ascii?Q?u1XSgy+/9XARwcVbLM9fSDDFYyl2AAJ3TvlsOIBNtDNHXayqPm3sE+AOA32w?=
 =?us-ascii?Q?FGyZwNwWnLW1oBGbFQFLZhrzQKhQHMQE9Rx6oOv/FgDxkxZAL5C4dIwV/sLY?=
 =?us-ascii?Q?ZAhmmBc5FxwV4sozPaqerhYGz9DiJVfbnqLm6XoNhVME0o5SfUU9cj4QgL5J?=
 =?us-ascii?Q?W4jgDUPVGRBaJF05oOQFriW2rURAT2zj8xxkr6JAYuVMxRZxPMfuvbVjvo/h?=
 =?us-ascii?Q?aDGz5vgpVC1GDBGLr2pNWfQqHc8CtcVI37glYpV1zuLiSHC+3+YdXXwCPDQ0?=
 =?us-ascii?Q?/XAwI2hVSKsjbFt5o0pIZQelfNn6EUEhUpAsuab/xh2oSqQcq4lNqHrPOiK7?=
 =?us-ascii?Q?CGouO5r2l+4adQ26PfHvZP3JtUW3fia2A0ry1rdwgBHbtULr9weam20+uskv?=
 =?us-ascii?Q?JS7D1r2guXfiaIYdIYIrtulpm9+wvDElMJdxZ+oJziblT3hdM6sLagUnUqxA?=
 =?us-ascii?Q?RqGos5xyixFFKOR9b325JC11?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c500acea-d790-4c87-6f89-08d911bb36a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 00:50:02.0649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uC5g+g6hR7iQc1tJuU+zSJM5t2k88Xqic2nYZSiFaoLfL9tcVu8KS/i3DumR1kE1smnGkXMZbM4rJBVe5/+Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4940
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 08/13] dt-bindings: imx: gpcv2: add support for
> optional resets
>=20
> On Thu, May 06, 2021 at 08:43:17AM +0200, Frieder Schrempf wrote:
> > On 06.05.21 03:04, Peng Fan (OSS) wrote:
> > > From: Lucas Stach <l.stach@pengutronix.de>
> > >
> > > For some domains the resets of the devices in the domain are not
> > > automatically triggered. Add an optional resets property to allow
> > > the GPC driver to trigger those resets explicitly.
> > >
> > > The resets belong to devices located inside the power domain, which
> > > need to be held in reset across the power-up sequence. So we have no
> > > means to specify what each reset is in a generic power-domain
> > > binding. Same situation as with the clocks in this binding actually.
> >
> > My understanding was that Rob wanted this explanation to be contained i=
n
> the binding docs itself and not only in the commit message, but I might b=
e
> wrong.
>=20
> Yes, that would be better.

Sure, I will include that in V3.

Thanks,
Peng.

>=20
> >
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 7
> > > +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> > > b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> > > index a96e6dbf1858..4330c73a2c30 100644
> > > --- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> > > +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> > > @@ -66,6 +66,13 @@ properties:
> > >
> > >            power-supply: true
> > >
> > > +          resets:
> > > +            description: |
> > > +              A number of phandles to resets that need to be
> asserted during
> > > +              power-up sequencing of the domain.
> > > +            minItems: 1
> > > +            maxItems: 4
> > > +
> > >          required:
> > >            - '#power-domain-cells'
> > >            - reg
> > >
