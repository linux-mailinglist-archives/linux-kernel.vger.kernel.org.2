Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF8A313E1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhBHSx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:53:58 -0500
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:10561
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234690AbhBHRIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:08:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUtpdgjKkvda46eoywPysIHusQk+u99oWBROIJ9huyYfVQxL8FjOX4B8J47t5ftFeagJg2xJ2A+UEkU+pbriON2QNqBG3ba9LVl0WdnM6ieu+uio8X/qcg+GRcOj0ePPLJ3ebWKjtQmytOkEDD86SjKyGUVU+lKsUfvleNVYEidlZoXL9XvtSEejJ93qrlSAJORHcsoGzM6ssWOpEuflfCNtjRu0NwMF1dvmz4G7z+8SShheaq2wmchwfwLd+n9DkwZeOZSwsTyayIW2mxR3tyzINr+wkNX56nOhUZzNy8u/IiUwlttSUKGO6A7i8NFt8Vbv70ZydGwjiPMTbD0JKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS4Q5rdvEukPYTCd4Z4P0flzuffQQySWXUqkWg6H/Mo=;
 b=DZrO61rvqUNPdwLVaIYDhkt1W7HCc2bQebsWYQXIffFcs8puqyRK78aT985jZUSS35Qangvxknf5pwZLv2v7tWvkIYo5UP/ZvInkZSwdtsXUSGCAsOPOs3jiUNX8yW68RV1ohm5JfOYuuoYyJjmN4t2lrUxMBJPrb98AyP4g9Vfg+YTKtN2LMxIRoKa3Pf6uvB1TsyEoIqdthYc1LOdcquajvX3Eur7Zo5gw3zgxIff+8EFMJlG9zSOfx0we7zmB9bH75jc2h0Tj6d8x7o/X6ZBD5BZZp99P3GmEuzGDbCzCoV3EUf1r0wa9/+HxSkNFjdE923/vd8C+HA6HQgUu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS4Q5rdvEukPYTCd4Z4P0flzuffQQySWXUqkWg6H/Mo=;
 b=omTMkKfBouBH9cWHCS1KU3iZKLcApqT5YfZzsqncaBId0xAcnR8OFkJnatt9/DOYT0zyJygvCRlrTIkBUDIkV8fP8d+ZjEWyWe9qnsbaMZXWUtzNUyzZvAQEbiPvzF/8VbmmcQ9I7qEUBmA3MQjBvpb88WrMcAsiOa1fPQJjxK0=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VI1PR04MB5232.eurprd04.prod.outlook.com (2603:10a6:803:54::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Mon, 8 Feb
 2021 17:07:15 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::e9ab:4d78:5b38:aa3c]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::e9ab:4d78:5b38:aa3c%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 17:07:15 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding to
 yaml schema
Thread-Topic: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding to
 yaml schema
Thread-Index: AQHW/Bm8UY6CU+x3WEaNMLW7u/2hiqpOfi0AgAAAXqA=
Date:   Mon, 8 Feb 2021 17:07:14 +0000
Message-ID: <VE1PR04MB6687E8BF45496B8505A6EC118F8F9@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
 <20210205234734.3397-4-leoyang.li@nxp.com>
 <1612803322.544738.1522086.nullmailer@robh.at.kernel.org>
In-Reply-To: <1612803322.544738.1522086.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.1.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0488f109-fbe3-4428-44a8-08d8cc53fbc9
x-ms-traffictypediagnostic: VI1PR04MB5232:
x-microsoft-antispam-prvs: <VI1PR04MB5232E22715C7B94FB54F98508F8F9@VI1PR04MB5232.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3gPyQI1RE28amcrcqi97qhUsxpPIThszm/JX6/ZzG47BPkRKcPaJdLD0OHUQXVbOImg4SueJkJ6tM2JlIOVUZ8lGHh2VLCla1idwbZBy5QHpJLzkeQc8/XpPPV6gCthVUGaucTsVS7nZ2aJyLPXC1PuuCfIiASSrtZ+1rFQqxMv/AMzU5ZcYRCPxIoRCqGyqWbB3a+n4dAHfFlWqGe6XjM876E5mW0v1MFqYY2rr4mcbcEq6dJLX2kruq8cS86NTI5mvUySIaun0HN5kQtFiu1wKvchT+1Z3uMCj+TlkWO33kWo/foALrouN/eV0ARsOdwJjYvUBMB4n65BSyWJMsRWsHOLjqcN7YpLM9IU8Y7qSFwPu2XT9DoMr9MSkk0Gui+tOlQ7nmUOrr5Mu66Evsg6zZdaEi8VGgSiQ/3pMQO1rKl/aNHednBV8SzGgods18VKczvNFJoxClprbYZ4rkCiUm0Sy67T2MyA6pBwsRJHVBTJSKaD7a+fIrjL/Frz07HCVC5xeThp4616c5wjNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(71200400001)(186003)(6916009)(83380400001)(86362001)(2906002)(76116006)(6506007)(8936002)(478600001)(53546011)(54906003)(26005)(316002)(33656002)(66556008)(64756008)(66476007)(66946007)(5660300002)(66446008)(52536014)(8676002)(55016002)(9686003)(7696005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4gvEKiwi2jWFNGisRogbm3r5uCxHOVtZb9enHIrc79KPYywfnjxi7r3bCtx9?=
 =?us-ascii?Q?gw0GeruOdRNnbTvZkWlyGxDREDdBGmh3G7lvrvJfqg4+gdiG1XRTuSl7SCWZ?=
 =?us-ascii?Q?ZdFaucbHXWlUmbOOgTWDrFmLC32jmSeumtOHVODY5jjjpfkb+wHRibbIJ8Ea?=
 =?us-ascii?Q?R9NdOZxJ3MhpeviZubiY9jr0cCYVPLD6k5wpYxd3DvX79GCz6nXsOiQuf5/W?=
 =?us-ascii?Q?JD3d7W0qpcfbiTgMSp36mb62O5tVZP9Y+FMV5qV6dgh1MbX7fKgPUWQ0MIxf?=
 =?us-ascii?Q?kpD+U0Ql7mmKYKWIw7L2OM/dJHmGFGnkCifus5FxjLpBFpuVskmxZKFXo6PY?=
 =?us-ascii?Q?leGrfegEkAVsTTIQ2EdAsscyqI/QFOMceJ36xXsTQ6VE2cw5gOMyixK2vR7A?=
 =?us-ascii?Q?VUZZ72HvA6suow4wsCsSrXgJiEQPYUhrcgzLkM/ZNaZcSGNR2hyX89gRxfM9?=
 =?us-ascii?Q?0pVzKtOUk7eSjlD028EA8sRsZ04En/UkbZZPCRkOInLYvBU+4NkdETQjtz6R?=
 =?us-ascii?Q?22o66gKaxL+znd5Psgks8xIgIOD1+ZEEJ5hx8VLj9l51Mkxof0qlPzvuW51D?=
 =?us-ascii?Q?glrT+erlj8AvWkaXAY44rjM1rLti9p1vdDAFdJlLaEI6XZhigM3QkRjZCoXF?=
 =?us-ascii?Q?4YHF22GdPo7+C0qli8tKCwIKjgf+b4VYuZMT9U8bCjRNfpeRNIM2uPtmJKuf?=
 =?us-ascii?Q?DIFxtdh8eDyZMdFdenfNitwEF7VNe/Aq3P3+tKktw/BNc22nAADYL2LK33Qt?=
 =?us-ascii?Q?0qoRgK4iaW+YM1e7WIgUB5nLdPJOxF0wyHHmapbPIyR3HaSYXz8ucWMJo566?=
 =?us-ascii?Q?fvQZXMRNtLG71tf0vsJQtfHpjpitRTqzGNoHqFWZRCdika820BduHhyd4Kke?=
 =?us-ascii?Q?wzYz0oAj0DReuMDTKhjJ1OfOJYt3YXoAmUBV8rQ+eZ52MU9T3JTXaFh+enus?=
 =?us-ascii?Q?BLu34Rol2x6Xmj2Fuw1cAvYp5uESQWe7f4XENot4HMR+CvI779FomyI5IO5C?=
 =?us-ascii?Q?UevGDFkPCqi7nB1nzfwoFU4IN08SHzbT5Sj+Kx/CJ+vq/K5nbg4JjzuW05QE?=
 =?us-ascii?Q?c31nXJl6h1T/IDYNmNkeRrB59f1WY9mv9jKXiXTv/LttFAOXPLTl/s7QXiE6?=
 =?us-ascii?Q?aHmCQuzMhiqEoU+a9UqVgG7THGVm222CWEYdM/jhynhjDWfAGiiqtIU/r6/Q?=
 =?us-ascii?Q?7JY7rR23clQE74enzoeMKqwfTgvBijS522Hz05zDXBkO54ZNKjNvX7wk/t3A?=
 =?us-ascii?Q?7CcXmgrN39VhIyFv15HooNHUPDKNhJNSFG2GIjEkZjZYsPGYye5n2KQkXE9k?=
 =?us-ascii?Q?5+Q=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0488f109-fbe3-4428-44a8-08d8cc53fbc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 17:07:14.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2E+JtC8Fg8hQXLE7MGwPXiBA/urgRL6asCEtbWmnSti1GnEuVobYjMuONj0FdHG0eWcH7Kz8RamqyzNdD1g0Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5232
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, February 8, 2021 10:55 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; Oleksij Rempel <linux@rempel-
> privat.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzk@kernel.org>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Shawn Guo <shawnguo@kernel.org>
> Subject: Re: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding =
to
> yaml schema
>=20
> On Fri, 05 Feb 2021 17:47:22 -0600, Li Yang wrote:
> > Convert the txt binding to yaml format and add description.  Also
> > updated the recommended node name to ifc-bus to align with the
> > simple-bus node name requirements.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  .../bindings/memory-controllers/fsl/ifc.txt   |  82 ----------
> >  .../bindings/memory-controllers/fsl/ifc.yaml  | 140
> > ++++++++++++++++++
> >  2 files changed, 140 insertions(+), 82 deletions(-)  delete mode
> > 100644
> > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/memory-
> controllers/fsl/ifc.example.dts:36.27-49.19: Warning (simple_bus_reg):
> /example-0/soc/ifc-bus@ffe1e000/flash@0,0: simple-bus unit address
> format error, expected "0"
> Documentation/devicetree/bindings/memory-
> controllers/fsl/ifc.example.dts:51.27-64.19: Warning (simple_bus_reg):
> /example-0/soc/ifc-bus@ffe1e000/flash@1,0: simple-bus unit address
> format error, expected "100000000"
> Documentation/devicetree/bindings/memory-
> controllers/fsl/ifc.example.dts:66.26-71.19: Warning (simple_bus_reg):
> /example-0/soc/ifc-bus@ffe1e000/cpld@3,0: simple-bus unit address format
> error, expected "300000000"

Hi Rob,

I saw these warnings, but cannot find a good solution to it.  The first cel=
l in the address is the Chip select, while the second cell in the address i=
s the address offset within the chip select.  It would confusing to combine=
 the two cells of different purposes into a single address as suggested by =
the warning.  Can we allow the multi-cell address in the node name?

Regards,
Leo=20
