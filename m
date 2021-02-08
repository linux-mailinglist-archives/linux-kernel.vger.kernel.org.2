Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31A03143B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhBHX0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBHX0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:26:04 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEEBC061786;
        Mon,  8 Feb 2021 15:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf/fBgM8TrlxrU4CPKzBQngsr4otjm4CT3rkmdRRfSLjV2IrRdL1vbZSfa4gWQ5V+NBaoV+lBdF7h5qgAzVRiEyMICP64jRHD4vmzo1p9jO+bLLJKS9H2Aex+Ir+HA4J1Udo0dNK9TJT287VI2m7uWb/tPE76vt1ImM5LUu6dsOHXfbj+GmevDQP7AOV7Bse8O7L+lDp1SVLQUylpoK24TqRhO9KiT5gRmNsbNCXPVqnfCeD0UvB7F3AUd8AzftnJTsFPagUdvFelVm5CnVntJBcTkCxoQgXD44SEzh2F2TYp8CXJjx+OaXzGfO+ABYE9V3rLwByw2KiVoiTdQaeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fZ/+2a9pMSs20BnQry00J0hjEQxc4tG41Y9hH9SXdA=;
 b=l2GEWHhBYFNUckhzPbyc8nEcyTm/MJImvef0WlzLxMxJfgf2n3YlxEaOJQ1Tza2JS5skZ2fK7dpVAmlumNEYp7pj8pYFNInDubAkqSIeEnVljxdh+TlKIXh6lsXj6i8YKDaMLbfSsF3l+ksifmRHcWSAgRkiceuHyUrdVTuKYcHzEooRmNsPyFBLe2Kb4AALEosrGuEs+2VuqEMUCZ7gyzfJSQOI9W4ez4UdO8jitetcpft/otpT84WTdxE3mxjDI62YL51Y9s9P8dII0PNvldY4C1h8oxN3dnFpNIvbzDAiD2nTSj8kuYx8g0F4e9MFiyzhMqOX6Ctsv0cuy+Xzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fZ/+2a9pMSs20BnQry00J0hjEQxc4tG41Y9hH9SXdA=;
 b=G4BwCQHDyZL+d3CSiWsmwRFrQpumGgttKT0SJgaB6hdSvAyJjUWGI1MYnKbo99g+5t9Fc5R6AvOVfoIQf2gGbn2YblPLZUmFvCgfbM6hwDok7E07p5Dx2YvwUHhrauxZWlURHjnMmYA+rrG4IGGFxMT5jskYTHurampiqgbxbHI=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VI1PR04MB6158.eurprd04.prod.outlook.com (2603:10a6:803:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Mon, 8 Feb
 2021 23:25:01 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::e9ab:4d78:5b38:aa3c]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::e9ab:4d78:5b38:aa3c%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 23:25:00 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding to
 yaml schema
Thread-Topic: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding to
 yaml schema
Thread-Index: AQHW/Bm8UY6CU+x3WEaNMLW7u/2hiqpOfi0AgAAAXqCAABeegIAAT3VQ
Date:   Mon, 8 Feb 2021 23:25:00 +0000
Message-ID: <VE1PR04MB66875D9229AD58D8341B8BE88F8F9@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
 <20210205234734.3397-4-leoyang.li@nxp.com>
 <1612803322.544738.1522086.nullmailer@robh.at.kernel.org>
 <VE1PR04MB6687E8BF45496B8505A6EC118F8F9@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <20210208182113.GA1648694@robh.at.kernel.org>
In-Reply-To: <20210208182113.GA1648694@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.1.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36d5e4e7-65db-48a8-dfef-08d8cc88c1aa
x-ms-traffictypediagnostic: VI1PR04MB6158:
x-microsoft-antispam-prvs: <VI1PR04MB6158564D0AC4D46E9D8D8DB98F8F9@VI1PR04MB6158.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EdeZS4GlkMO1R2rabD71mWgAkUxg811D+M6dpO91UPeEr74kacvSLfFeRwMCjtdTjA3yN8i3zxoagQGe6SReNL5XVCSJESorfiWMCn+zP8PHRi4pg+g+xOIuDhaS8VxO4Kxp8moDHmwR20CDYfMx/OsYrmWONhmJaGqVkwb1z+Jn6GAUdTTUP+xTrttlX5G0fpkkRCXOTGXS3ohf6+Ggmt257wMH2UwgAO4MV8jDR+UEsNxep4H6VzWGam320VXfeOv5WBGPnXXpP91B32l+RcdTGccLGd3nbWzUkDEv/onxdmsXPGmmz8DTMbundExfG/MFwjIy8jOZ3ZyMxhwYnJB9liLr+Jm32Yy2L0qB0hIWhVYbgU2aYijtyWN++gEpTHlJA3Th7Mbmr2nUheEzxeWKeBJh3UPYX58obuL8qhXdcZ6Nm9ILDAazlD2+Bl2VAXQf70TfGbVaXFV+SoNJOOZYsMuUbzcN69ZoY/CwQ26ODVr5CsLWLD7zlaBGvEkKCNcxqj8iXPbxVXH1nRxSGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(366004)(376002)(396003)(5660300002)(33656002)(83380400001)(54906003)(316002)(86362001)(53546011)(8676002)(6916009)(6506007)(4326008)(8936002)(55016002)(9686003)(478600001)(66556008)(66476007)(66946007)(26005)(64756008)(66446008)(2906002)(186003)(7696005)(71200400001)(76116006)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U/xPKDF9Bm1hO7XlP2hGTg5My9SAF/7ecofLrC0+7CYeLczWLlemRA1J9uv3?=
 =?us-ascii?Q?QKgJMDi6eOx409mxYKwXZi2kaWihphJ/nNtAzgrjfdcUNf8GVDl2DMOQed4a?=
 =?us-ascii?Q?/BEkv1p8tajOcqjte4X9sSfgIhgR6KXe1AsYX2A/BuBp7cM1gUfq08VcNwmx?=
 =?us-ascii?Q?pGQuf8OAJLOQsG+oUlPMNyYV7xYvxKwDGC+Vbd5o11Wvqk6Y2dGaTpXujOPm?=
 =?us-ascii?Q?wPmPTkvTkOkYfcp4cyZSWtGwFXgQlshzEQnetW5lYMhnhTFelArLJzMYmncw?=
 =?us-ascii?Q?UwjB58gc/qgrtxSkGKUfPryjRXuju/FKm8YZQQbvW6G1yxq6i13S9SInziJv?=
 =?us-ascii?Q?QE9xHhr9hwVhmNuEYiOWD0StC03pOLMSzxIHXbhtgqM8FEXLtWaVHmQzK1Rv?=
 =?us-ascii?Q?FjnFUrvezFmVexkj48FATPIpdxJRC1JJrje6AB57cbPyxqn0RetMzLf7YekC?=
 =?us-ascii?Q?6hzBCXpRcrYqubKUR1f4ot3JoPaYhtdd5iF4bl5fYO+PhfnmzoiMcYzWPZ+H?=
 =?us-ascii?Q?GXQ4ztXdCHB+APR3lRNvv5GP2al7cggut0oDBohsUvKQadTme2gq9EqRQWnT?=
 =?us-ascii?Q?ZAwG691iECJdlSu3TjQn2t4b1mNCBAh2u/lzekbt+nE5UZHr/PyX/4T9pxCa?=
 =?us-ascii?Q?12U2qSDfP1ZPP3cYnOH08WdhB0VogOG+c3Ncl3A/RBzY9FawltbVq3t5kHKE?=
 =?us-ascii?Q?KWxIXWuGaWH92CK3T18Cvp7Clk1ZbFf4VYxIZP+PwVjrY+uBtnffRK6xXAQ/?=
 =?us-ascii?Q?iQ+GiCLtr8j/o3b43tJ7TVSiHC51TH5W5D96eNrIxktzSs5EfqHk/ydbWBYY?=
 =?us-ascii?Q?Q/D4vB7MDpU57yi29v0thueSJhUhm5Y8x1vQY22+VoG/ycCntVMhCkm2ylbr?=
 =?us-ascii?Q?OJ3IdbyyDC+f8pRNPgO6Pd/cxfYxLz03gb3rCzAQiU7fW+UuFshVRwyt7z8y?=
 =?us-ascii?Q?VSfnqQM6O2usCdWFVwxRRe/FHbOaNhPmkZZT2pfF1m3s9WrifMldoUvE3xIq?=
 =?us-ascii?Q?U7xcM2ldniNaI9er1PBoGrANSZSmfXftGV71bgSAwveB9lTfaA9us8fCINgS?=
 =?us-ascii?Q?roQM+6L3GDuHix1riwq+zFwUo7EJqTpqox27oCo2nT26XQE+oxaxYWXYRA/L?=
 =?us-ascii?Q?GaTATFmsdFlqn/1/g9AsfYHEpURIY2fsivmZilIZ40a0ru9yVtYcSMuedLnQ?=
 =?us-ascii?Q?8plcsdTzq7RZM2G9yNnwKfUHksSFe8CDzI4x4QOe9fBsY1T8iM5G7WEixrxw?=
 =?us-ascii?Q?xphXr9aTDy086/CqscozE/T9xxQWFjc0rfFy+fXgUb8tvt1C4T3H0qpH25Gv?=
 =?us-ascii?Q?Ru8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d5e4e7-65db-48a8-dfef-08d8cc88c1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 23:25:00.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIBg7dia1Lf5UHNf2iIHEWf4AY2U0IGsUrv6vqx9A3K/SODmq5k/DzIxkB3WyBaKjn+nr2msyu1S1950PFPsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, February 8, 2021 12:21 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; Oleksij Rempel <linux@rempel-
> privat.de>; Krzysztof Kozlowski <krzk@kernel.org>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Shawn Guo
> <shawnguo@kernel.org>
> Subject: Re: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding =
to
> yaml schema
>=20
> On Mon, Feb 08, 2021 at 05:07:14PM +0000, Leo Li wrote:
> >
> >
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Monday, February 8, 2021 10:55 AM
> > > To: Leo Li <leoyang.li@nxp.com>
> > > Cc: linux-arm-kernel@lists.infradead.org; Oleksij Rempel
> > > <linux@rempel- privat.de>; Rob Herring <robh+dt@kernel.org>;
> > > Krzysztof Kozlowski <krzk@kernel.org>; devicetree@vger.kernel.org;
> > > linux- kernel@vger.kernel.org; Shawn Guo <shawnguo@kernel.org>
> > > Subject: Re: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc
> > > binding to yaml schema
> > >
> > > On Fri, 05 Feb 2021 17:47:22 -0600, Li Yang wrote:
> > > > Convert the txt binding to yaml format and add description.  Also
> > > > updated the recommended node name to ifc-bus to align with the
> > > > simple-bus node name requirements.
> > > >
> > > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > > ---
> > > >  .../bindings/memory-controllers/fsl/ifc.txt   |  82 ----------
> > > >  .../bindings/memory-controllers/fsl/ifc.yaml  | 140
> > > > ++++++++++++++++++
> > > >  2 files changed, 140 insertions(+), 82 deletions(-)  delete mode
> > > > 100644
> > > > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> > > >
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > Documentation/devicetree/bindings/memory-
> > > controllers/fsl/ifc.example.dts:36.27-49.19: Warning (simple_bus_reg)=
:
> > > /example-0/soc/ifc-bus@ffe1e000/flash@0,0: simple-bus unit address
> > > format error, expected "0"
> > > Documentation/devicetree/bindings/memory-
> > > controllers/fsl/ifc.example.dts:51.27-64.19: Warning (simple_bus_reg)=
:
> > > /example-0/soc/ifc-bus@ffe1e000/flash@1,0: simple-bus unit address
> > > format error, expected "100000000"
> > > Documentation/devicetree/bindings/memory-
> > > controllers/fsl/ifc.example.dts:66.26-71.19: Warning (simple_bus_reg)=
:
> > > /example-0/soc/ifc-bus@ffe1e000/cpld@3,0: simple-bus unit address
> > > format error, expected "300000000"
> >
> > Hi Rob,
> >
> > I saw these warnings, but cannot find a good solution to it.  The
> > first cell in the address is the Chip select, while the second cell in
> > the address is the address offset within the chip select.  It would
> > confusing to combine the two cells of different purposes into a single
> > address as suggested by the warning.  Can we allow the multi-cell
> > address in the node name?
>=20
> Drop 'simple-bus'. It's not a simple bus. You have registers that presuma=
bly
> have some configuration needed.

That's probably true for just using "simple-bus" as compatible along.  But =
I see many of the current bindings are defining a more specific compatible =
string in addition to the "simple-bus" compatible and have their own driver=
s.  I think this probably meet the statement in the device tree spec? "Bind=
ings may be defined as extensions of other each. For example a new bus type=
 could be defined as an extension of the
simple-bus binding."

Regards,
Leo
