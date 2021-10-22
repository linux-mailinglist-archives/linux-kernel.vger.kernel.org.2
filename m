Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA412436FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhJVCHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:07:02 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:19365
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230190AbhJVCHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:07:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCDDkq+zdxjTQqnf69GZzZ/4Jd6/ozxh6Ea7yHD0w9zADnkywz0yQhvoScGVmgbG64aaF/aVlWGJfoBiT/ODoOTofMuwfs00SvtPW5MxkG7igtrWu4rlfvfVyu+WSViaERhm6wT3BTQQ4wTywZWFAFPZnc4tNjiFdOGkShfI81Mqzq4Vy+61OVPi2fWb4aNQRCNoFYZEayAIVmDW+lWsdjrf/HXZKUj4mmCSH5lhof9Rxog564OPzZ8WEichZIDqvCcqCkCTiMwGmwlD18UT+qI/npPhfjSnQ/NA6J4NczfeFZLdjN+9kT50TVIkr+qKNyVuw7TM9lYiJ52sb5j0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zcr7RGY1TiVgE3uY8s6UAm/m5UYH98NbHqDXHa0WhMc=;
 b=iMiBoYmwxD0Sm2qCGmUJs/iY79zBhKLzNzNv/LNgqWT6XCF/Bb0xhKkoolSOgJeHf5OvQaa23vULX6ayneTZecDnM49ryKKLWV0a6wls1yIdRKAFb1grgeHP55mmfiZGO8VI0jgPNZB8zMub4j11IkQO1wF3gUsjRBipeSZ8jMGMcSmufPQhL72UFrOW5/gqJFaHBZ6Uzx7bNUAQEdS8OZyU9c4D2Zy2OTgkIByh5tjVeXcJ+Hui+UX0GwyjyhPp0ZiT6WGzMLJPbv1yXjusPlR2RM00Rg9hzIqZ10CxfB20qaWXTeF3d0zPHJIkxgB1+X11Lz9HZf/Qks8pUpm1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcr7RGY1TiVgE3uY8s6UAm/m5UYH98NbHqDXHa0WhMc=;
 b=Vao3Zjdx3/FajK1HT9z7UFZvn4D97X3vMIcUUeb2tGOIf0htZoXnzL044N0OqJG9vzED3GbOldsyqaSx7g+9ltRZfmE9XGz2dKe1rsz1uMA9pXsPJKD/hAyqNsyq3ghJv510/vrOb/hfQJaoa0Cda+Z9VmS0P/JYxeT/+ZMtmcA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8772.eurprd04.prod.outlook.com (2603:10a6:20b:42f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Fri, 22 Oct
 2021 02:04:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 02:04:41 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
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
Subject: RE: [PATCH v3 6/9] dt-bindings: imx6q-pcie: Add PHY phandles and name
 properties
Thread-Topic: [PATCH v3 6/9] dt-bindings: imx6q-pcie: Add PHY phandles and
 name properties
Thread-Index: AQHXv0hoWJtA986VIUqwmsPQQoGZiavZKzoAgAUnENA=
Date:   Fri, 22 Oct 2021 02:04:41 +0000
Message-ID: <AS8PR04MB8676F8987117D03875869B868C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <1634028078-2387-7-git-send-email-hongxing.zhu@nxp.com>
 <YW3IdoS+zHa4x70Z@robh.at.kernel.org>
In-Reply-To: <YW3IdoS+zHa4x70Z@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a61d1355-28d6-4dc2-3fb4-08d995004fa2
x-ms-traffictypediagnostic: AS8PR04MB8772:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB8772E8D1F5B9C0BC278481A78C809@AS8PR04MB8772.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3khISUDhMPbqdmWY87tTLt1/NExYxzP441mfGCnzdM9pSOsaMOh0gLXrlN3NjMFCfh1T9Q1EsCMbmR4ppq/5k6Hr0aeJtdoifih90E/txh0VNIX1e1SOVgRkUQumtHO653xolfV4REyShBGiDHDNvJqwsnw6ijUa95C8qPCSkwnGTHe0MM/OF7m19JynjN77pBVq8c0rwZqYDvXUUluhtgLmyFerWC4sWriL57kTy/Kqfvfa5+E78FPbx32VM7P77/iEbquTlZfLjkr/sM81tjuuXU4d2/11EES/v+Oc7E25f9OfShZO3npvXx0hqR7G7GnnBbos2JlxK/YNkZb4YIs5dLk/flnGucnb/zIh/Pyyz9oUIRW1hea0FhNzevGtR5Dt/b2ddts2qJExGzn9t/75Ot7BtFO+C34hMSHxqWh1hztg7c8sEsJ5lV/PUZD5IkoQ/HNe1JZYX8OOwBDyGWgiu11z2m836dDjt4CCCsbCrZiMiAi/4U/xSR2ugd7lmwuWQn0eh3zgUhggEthAbBsJwq4tAZLgHwPYakiff3aXs8o7LgwgzH3K0W3nvRStUa2UoCzsHEwNazYxu8OueCpgjvTW/WLvjP9mzDZnnhuGl1yFWfP7+Pv/NJpp8GSwakWCFiY7v+uvlQ9DvwGlY4aDJcbrW+8rJDB4D2vl//k737AmXlPv+a4ey+Hx+SrtIRaTueXwTrDyPC+9JLB67mjoGJk7eoydWr3mgrEAtM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(55016002)(38070700005)(9686003)(186003)(54906003)(26005)(7696005)(508600001)(5660300002)(8676002)(53546011)(33656002)(2906002)(6506007)(122000001)(6916009)(52536014)(8936002)(86362001)(64756008)(66476007)(66946007)(38100700002)(66556008)(83380400001)(7416002)(4326008)(76116006)(66446008)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GUKDjCqdhcMXuLzmH/JnqYg6pS3mSqMZVe5b8VyVAkf+5JNGXlFX8IyAxEPN?=
 =?us-ascii?Q?mEP068D78VmI4757J1WGOtRVSSiUMc5bHUQhG7zbjOBF4Ck61Vf4+zveWxyq?=
 =?us-ascii?Q?/6/HP0F0o+thQ6TXIam7UH2BrKATHALIZYuq5D4AoS5ydUUrPa2RFE7wyOtV?=
 =?us-ascii?Q?g0/YCocpPCoziMKNs0fgzbRbaTxpe69KvCsSojmeAczsGxP/6r0F1wNYYlz6?=
 =?us-ascii?Q?TP1ywy+jbHtHhK9qIm4IptgQ+NYpHEXP9QN+bQh4m7yXR/nLo95zo801Ydvn?=
 =?us-ascii?Q?1/sGAYQWT9LqyllmXIoiLA0JuuOHKjYomjfGZ3+MBvqoUahSS62NsgZwxrvV?=
 =?us-ascii?Q?leZl/lNG1WZ+fw8zk3Qz2kQdzxQ472VD7WoJxPvBknIKLHP4yxY0PnnmmFl4?=
 =?us-ascii?Q?Ud/20W/+kAwWOGXCeKfay76RxPnEKf38l8Pdc8JuQjMIFCp59sc11sUbWCk7?=
 =?us-ascii?Q?HOeYDXl9N5cR+cb57S5AM04/Tn2z607Cr055Uvgz/663zyNhGML81wvxEH9Q?=
 =?us-ascii?Q?NX7V7K6OWylrChs3TCEo2XCQBNLkOobxwvfhyOnx5jzAf2WEoeq97D68Kh5m?=
 =?us-ascii?Q?lHms2QuOrjw+7ia4gb2bh5SWQhhKXX/26kMP5cpBBGU3WX+yGpdtTqEBWRyW?=
 =?us-ascii?Q?BgNurIZV2UmZ9pzCgok3mbjNUB50aaaBjdC+FRN/DZiSQJ5NJiM+7szoaeVl?=
 =?us-ascii?Q?XKvfq42s+Y5t//KIqYQuDDw4k3l0NnWvm4avTPnHZI58FET5wsjLvdRwYZ2M?=
 =?us-ascii?Q?bDVtxko7TpUtOBHvOm9sbiRU+ihReCLrQGh+MJAPYtaJXNIc44+YrDYRgU67?=
 =?us-ascii?Q?HAZHt8yRzzPvhnlDdEQ4bYbq9Cteh2Xu94KOxniuxQjkBfIMAYaMbXW5Pdnw?=
 =?us-ascii?Q?Y7ZsfmuU3uaGnRdNL4AkBskoBTMP1E/DpCbTHcsX+ThG8xxNh9Pkk/vUDZqy?=
 =?us-ascii?Q?HPfDqrYbq+KeQsxHVGe123gW4H37BHqlHG6xwji5v2MdNsAA8YazIK034hV4?=
 =?us-ascii?Q?BLFIx7Ui6uD4TRwtIG82/KF9aSPr8Jn+mdrLyxRrPvSuP500rpdgWm8rwE4M?=
 =?us-ascii?Q?FyrTE0e5DTDlVIeb7uNe5eNTbCkxALqf0ZfKPSKBpGzdX5Xg2Hbt0xhAr7ro?=
 =?us-ascii?Q?l9zoZvEgFikUMV9Iuhq50Q6eyhEzcW0Cq6/j5U4gSwjEiW9Hj7pqWocktWdj?=
 =?us-ascii?Q?HQFshH4lP+aUHNcLsBrArV9UA5JLw/aWIxy4Bgry7u4JNEwZi/qCZv50CbQN?=
 =?us-ascii?Q?lOfPSW6UMan+PtwO8dE0aQuMF1DwhnwRYTv6blGtQnKrGIp8Rm+XlkT8Vtbt?=
 =?us-ascii?Q?u+gbk3BSzO8VBWR9s2tnzrvXrX7d2Xy4cSBkZ/eBNhcviXC156VqtaRDttIB?=
 =?us-ascii?Q?fsHh+iWxoGDRRSKiZ1A4tWsvp464/msB5If8Gi9kE2JDR8JcorLC5s/TvK5n?=
 =?us-ascii?Q?lMNt/WLcasw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61d1355-28d6-4dc2-3fb4-08d995004fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 02:04:41.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hongxing.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8772
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, October 19, 2021 3:18 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; tharvey@gateworks.com; kishon@ti.com;
> vkoul@kernel.org; galak@kernel.crashing.org; shawnguo@kernel.org;
> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v3 6/9] dt-bindings: imx6q-pcie: Add PHY phandles and
> name properties
>=20
> On Tue, Oct 12, 2021 at 04:41:15PM +0800, Richard Zhu wrote:
> > i.MX8MM PCIe has the PHY. Add a PHY phandle and name properties in the
> > binding document.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index 2911e565b260..99d9863a69cd 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -128,6 +128,12 @@ properties:
> >      enum: [1, 2, 3, 4]
> >      default: 1
> >
> > +  phys:
> > +    description: Phandle of the Generic PHY to the PCIe PHY.
>=20
> maxItems: 1
>=20
> And drop 'description'
[Richard Zhu] Hi Rob:=20
Do you mean to remove all the description, and just like this?
  phys:
    maxItems: 1
Ok, got that, would be changed as this one in v4 series later.
Thanks.

Best Regards
Richard Zhu

>=20
> > +
> > +  phy-names:
> > +    const: pcie-phy
> > +
> >    reset-gpio:
> >      description: Should specify the GPIO for controlling the PCI bus
> device
> >        reset signal. It's not polarity aware and defaults to
> > active-low reset
> > --
> > 2.25.1
> >
> >
