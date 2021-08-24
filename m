Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF503F57E1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhHXGFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:05:10 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:16262
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhHXGFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:05:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsY8CsufNYoXrQv76CtFamuwJQmI50C4nunrGhEFHn4ZnB8UnsN+u7S8I1FWCHWRF6Dctu1UQu940A0SsM4mzvNmP47lJ7nBkX0EOVL1JZhgfcAFIlC+u3VkYMDJPs/Y0OvlpelrQsqygDhL1sHo/nG7IlH0WeFlres5Xl/2MYYlrWolc3ZJHnGeLdcnhdls5uTXczRbR+uiBkhZt3Dm9nEtFAdSxSMFrD/lyKoMjpgpEwoG1S+u8MvaneuHd5QoJQGa8N2Os/wPudIr1NGAVYUzhKOm2Tya4xkUQJjj7WYwzC5Q+Qe1/jUp+ChXMlOGNIS8LFCqzsP3e6/Gbs0QDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Aqv+PK6It9RiNPYC4S6AOXXM6NtRRuwQTwOQV4ZSek=;
 b=aAbV/B+Xi61ubzmOQEiNWn7/ExeJTrKWQeVMbUaU+SEKz6ccuSW7vf5Pj9tg7ylLjHlGWNN+RumKLVF477jvgfo34PfACzaVAErKQcKXKqLvWK3TCfTuA+H8wWiCX2joRx7rP+owmShLoDTm/kAAK5igB1NeErzBZy9h4umLukvHU1oRUIy6OKPSv2Kyyzi6d93HSdSI770P+4tcVlg0AvSSBVaVkn1shfEnasDKEdBOgo2woE+zUw6b9GJIdIXm2Rub+BbseFNSg7VdcbV0N+DCRozeRHuzp5i8v/AY89OFtKytEnJi3K53daMxje4MIFSUuETAYRPBIa4vs6lpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Aqv+PK6It9RiNPYC4S6AOXXM6NtRRuwQTwOQV4ZSek=;
 b=deVDQIhcQOWOZgTp/+oJDjuqGx8SIhgEk59Nv/FuRwsU3w63OL1YtTX9rx6m1ByGddsB8KlZ/+t9CLwCGfjheohms6NcxiBN3n9pEsmfQxoSN5gUIP9Kcg0LvIqsiHtBwGs25YJeYjrvPnSpUtkpWp9xfoAYNlnuoIs9LJAnPwU=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB6271.eurprd04.prod.outlook.com (2603:10a6:803:f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 06:04:20 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 06:04:19 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v1 1/3] dt-bindings: PCI: imx6: convert the imx pcie
 controller to dtschema
Thread-Topic: [PATCH v1 1/3] dt-bindings: PCI: imx6: convert the imx pcie
 controller to dtschema
Thread-Index: AQHXlMnuy8K3W50lzUyakIXMe7rdaquBcVYAgAB/KDA=
Date:   Tue, 24 Aug 2021 06:04:19 +0000
Message-ID: <VI1PR04MB5853D9B0E217390C52E40FFE8CC59@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
 <20210819071408.3856475-2-hongxing.zhu@nxp.com>
 <YSPqIEmngxjCCn+v@robh.at.kernel.org>
In-Reply-To: <YSPqIEmngxjCCn+v@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca9d9182-2810-43e2-05c8-08d966c50335
x-ms-traffictypediagnostic: VI1PR04MB6271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB62712E02137B989EC3B271548CC59@VI1PR04MB6271.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3vhSCgzZQScdY/J235P4CaO32u0X8ACWKg2ZmmX1uaqhqJp5B5itLpmgbBL3SrtwAp9BY0KmY6BytBl1m4/rsNXKCSzjB241MVUJtcPYWlLuCaN/wKNeSL62Y1q23/zew7L1i3DnQKQCgScs0F4WpUgLywY9pjwM7sAvFTQ+OmES/v6BoA1sToqNogAztW/DfioPfpRpTjPOOl3Lv56XnrvkySgR8Ol3CDKCYQ1VwThF7fDmWP8i+nBTPwREBkJVTaZqbaVAHetenGykoIwk8hZbL2w3nJfNLrDccBZkhfzUoaS0YMDDOELiD4xhvpveG6hgjY6tcZMeZ0wpnk8Sr8kkAqRSPt8Wv/O+e6oCn1aC5a+OEARlryoE0W0RqfenbEX1AGbSzaffS0JWp/Jf+mb7ojMm8EMwmWWgsq19GK2V/XvAjr8IYUVBn0rwBAf9MfrOGre8CtETKq33kJQWU5O8L/eiV2mCscIQ4yEz9xqC5bjMYRdE334/1Bpxp0nidLeSpDyGow/69/7gCMvZLysXaCKwRlM1WAoTY7Mg+qYk4yEdGneWLYjJIJHK25/Zl3MZu22656EUIGQ3XlhCKTuezReQrbuL+w4OzI7ZLlVsVOpnNfM9wF27Is1dFAUdsaJ6FmJtF/AUN6SjXylG7rs/QpaLfOXyxLvOZg08ez4EXy3vDbz8IYF9sADHu8PNJHs68D5dYJVEOFIcdJpP7p/cnifjtMlC+bGelMACkyYJieKj6X7PbTgUqZvB7eXyHO/CY0abNrCw5QYaAiai5CK5uBIRHdv80Z9EDemc7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(71200400001)(5660300002)(45080400002)(122000001)(9686003)(83380400001)(66556008)(38100700002)(30864003)(33656002)(66446008)(8676002)(66476007)(64756008)(4326008)(66946007)(26005)(316002)(2906002)(186003)(7696005)(55016002)(38070700005)(478600001)(6916009)(54906003)(8936002)(76116006)(53546011)(6506007)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LqqXFAmqE/q+1TduvqZ37vkykgZ11p93wEE4wX7248dEaPh98cp1rQTFX2qT?=
 =?us-ascii?Q?Ho/kdq8EMEprKUOtnEHX2S7E1nbyLDrMUY5QY5WSlsZLGaF1GQheOcmOPPaR?=
 =?us-ascii?Q?iQT2f2ZsguvXrAIKY+bWEI3QlVjd7LDivy0gP1nkDsZu2qckYafcDUyHEmlI?=
 =?us-ascii?Q?lqYOlIzZPOLn8Wm2gJnrpZ79wUvuiPOa5loZt3714P2pmT0E2dSLblFavazN?=
 =?us-ascii?Q?J/fw1yp4ZAOMhT5ypYEnQqp6sfPym4bB7SDeiVfM1z57ziQFeDqWj1zUcNAT?=
 =?us-ascii?Q?y845pOQvLriViTenicGPxRO82EXsXyVL4fUO7PsbBcXyRQhPwDR8OjkRpb+w?=
 =?us-ascii?Q?yVO0fq7B90dvGRgfxm4kYTXp6ERx863LM2IP9Sz3gyv/oRqy2/w1t8fcz/zW?=
 =?us-ascii?Q?wOF63BDQblIDlElftpkORnyatD7ghF2PVW0IVLFpKHl0gysNqBygGZf96wlQ?=
 =?us-ascii?Q?0+emRY/cuipgqxart54h7Bi8baGZwS2cOh6QV4U1GGXYMzUfGcgx39p/mM1Z?=
 =?us-ascii?Q?ZNGXWpTpwhCrAssw3MeWdjcHOlnlY13BF3+BiI1bor3FuVSbvVIAVDb8cLff?=
 =?us-ascii?Q?NeEenimBUEFvSs+1vSYQSKpRnICxp3anhAhvTtCjxT1DCsAqfHo7unI+0yZd?=
 =?us-ascii?Q?3LDGR4hqX4gtZzBUwB5SlP0xkkj/S76Zjwy08r6kmCSN4RogRuW/qZSPhwhM?=
 =?us-ascii?Q?bfqNB7HQDEX2UWxBh4o/r/Hompijlbh7CmSScaT+pRW1ThTTTaycydrDK24m?=
 =?us-ascii?Q?ESoU4JWHpTLpIYt/iQHiE4QE/adRnbNGdhPhasQwCk2z+RCI0Exrt7AbLB2g?=
 =?us-ascii?Q?1H9mtHbl+WrhUH2lH/Jq01EMlwgFSra780JbbeRMwzd2AfxXgAvQeSOnH5/K?=
 =?us-ascii?Q?2k1HTJx3xKdAd9CWg6MrtfaRyyIX0dRQGrtQ50iO5j5QMBZijpXkXNcU72Le?=
 =?us-ascii?Q?+bAVYENP7k7lJDr/UZ2W6ITeIVDzWxLrFL2Wmh2MH2BQdW7UMLwx6XaNcJr8?=
 =?us-ascii?Q?s3O8b3mp9GrX6JCN8F+9ABLSkZMlSbgnT5iRbzau9ebAO8SYd/DKx45VEtYe?=
 =?us-ascii?Q?jYpoPzOeG+nWYnyNXFKn60sAFtbXhkMUlwGY0uzY4JfDtxOPCsO+Dq1UA09M?=
 =?us-ascii?Q?KGDdB0Hlai0uPHkw0jWo3dH614WkXN7BnLlBPr1aMV74crEfFlTk2ymxWmoA?=
 =?us-ascii?Q?PPefSnjXiD3r3nRLk777pipkfT8aAhglqoeMuwcBP/JDYYKRRuOqjxjZ5CTE?=
 =?us-ascii?Q?oZ9SLRqMcXXodBc8dtge/WbYJ8V1MvMZ9WjLAXPwDf1yw2ZHVeFO87d1Kf5/?=
 =?us-ascii?Q?SOdha89/sxQt91I8RF1dLKzy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9d9182-2810-43e2-05c8-08d966c50335
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 06:04:19.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ggywmACCd813ckEosrZiUrt2Ghb4MxlVQhbsUKj+5YX/R2qql36YSXidIC6JilpNrFakV5BuaNZnjdQi21Xvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6271
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, August 24, 2021 2:34 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; galak@kernel.crashing.org;
> shawnguo@kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de
> Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: imx6: convert the imx pcie
> controller to dtschema
>=20
> On Thu, Aug 19, 2021 at 03:14:06PM +0800, Richard Zhu wrote:
> > Convert the fsl,imx6q-pcie.txt into a schema.
> > - the ranges should be aligned to $ref: /schemas/pci/pci-bus.yaml#
> > - only one propert is allowed in the compatible string, remove
> >   "snps,dw-pcie".
>=20
> Didn't I already see a v1?
[Richard Zhu] I assume that the RFC version as the v0, not formal v1.
Would pay attention to that.

>=20
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.txt           | 100 ---------
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 207
> ++++++++++++++++++
> >  MAINTAINERS                                   |   2 +-
> >  3 files changed, 208 insertions(+), 101 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > deleted file mode 100644
> > index d8971ab99274..000000000000
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +++ /dev/null
> > @@ -1,100 +0,0 @@
> > -* Freescale i.MX6 PCIe interface
> > -
> > -This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> > -and thus inherits all the common properties defined in designware-pcie=
.txt.
> > -
> > -Required properties:
> > -- compatible:
> > -	- "fsl,imx6q-pcie"
> > -	- "fsl,imx6sx-pcie",
> > -	- "fsl,imx6qp-pcie"
> > -	- "fsl,imx7d-pcie"
> > -	- "fsl,imx8mq-pcie"
> > -- reg: base address and length of the PCIe controller
> > -- interrupts: A list of interrupt outputs of the controller. Must
> > contain an
> > -  entry for each entry in the interrupt-names property.
> > -- interrupt-names: Must include the following entries:
> > -	- "msi": The interrupt that is asserted when an MSI is received
> > -- clock-names: Must include the following additional entries:
> > -	- "pcie_phy"
> > -
> > -Optional properties:
> > -- fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
> > -- fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default:
> > 0
> > -- fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
> > -- fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
> > -- fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
> > -- fsl,max-link-speed: Specify PCI gen for link capability. Must be
> > '2' for
> > -  gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock
> > outputs
> > -  do not meet gen2 jitter requirements and thus for gen2 capability a
> > gen2
> > -  compliant clock generator should be used and configured.
> > -- reset-gpio: Should specify the GPIO for controlling the PCI bus
> > device reset
> > -  signal. It's not polarity aware and defaults to active-low reset
> > sequence
> > -  (L=3Dreset state, H=3Doperation state).
> > -- reset-gpio-active-high: If present then the reset sequence using
> > the GPIO
> > -  specified in the "reset-gpio" property is reversed (H=3Dreset state,
> > -  L=3Doperation state).
> > -- vpcie-supply: Should specify the regulator in charge of PCIe port po=
wer.
> > -  The regulator will be enabled when initializing the PCIe host and
> > -  disabled either as part of the init process or when shutting down
> > the
> > -  host.
> > -- vph-supply: Should specify the regulator in charge of VPH one of
> > the three
> > -  PCIe PHY powers. This regulator can be supplied by both 1.8v and
> > 3.3v voltage
> > -  supplies.
> > -
> > -Additional required properties for imx6sx-pcie:
> > -- clock names: Must include the following additional entries:
> > -	- "pcie_inbound_axi"
> > -- power-domains: Must be set to phandles pointing to the DISPLAY and
> > -  PCIE_PHY power domains
> > -- power-domain-names: Must be "pcie", "pcie_phy"
> > -
> > -Additional required properties for imx7d-pcie and imx8mq-pcie:
> > -- power-domains: Must be set to a phandle pointing to PCIE_PHY power
> > domain
> > -- resets: Must contain phandles to PCIe-related reset lines exposed
> > by SRC
> > -  IP block
> > -- reset-names: Must contain the following entries:
> > -	       - "pciephy"
> > -	       - "apps"
> > -	       - "turnoff"
> > -- fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
> > -
> > -Additional required properties for imx8mq-pcie:
> > -- clock-names: Must include the following additional entries:
> > -	- "pcie_aux"
> > -
> > -Example:
> > -
> > -	pcie@01000000 {
> > -		compatible =3D "fsl,imx6q-pcie", "snps,dw-pcie";
> > -		reg =3D <0x01ffc000 0x04000>,
> > -		      <0x01f00000 0x80000>;
> > -		reg-names =3D "dbi", "config";
> > -		#address-cells =3D <3>;
> > -		#size-cells =3D <2>;
> > -		device_type =3D "pci";
> > -		ranges =3D <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000
> > -			  0x81000000 0 0          0x01f80000 0 0x00010000
> > -			  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
> > -		num-lanes =3D <1>;
> > -		interrupts =3D <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> > -		interrupt-names =3D "msi";
> > -		#interrupt-cells =3D <1>;
> > -		interrupt-map-mask =3D <0 0 0 0x7>;
> > -		interrupt-map =3D <0 0 0 1 &intc GIC_SPI 123
> IRQ_TYPE_LEVEL_HIGH>,
> > -		                <0 0 0 2 &intc GIC_SPI 122
> IRQ_TYPE_LEVEL_HIGH>,
> > -		                <0 0 0 3 &intc GIC_SPI 121
> IRQ_TYPE_LEVEL_HIGH>,
> > -		                <0 0 0 4 &intc GIC_SPI 120
> IRQ_TYPE_LEVEL_HIGH>;
> > -		clocks =3D <&clks 144>, <&clks 206>, <&clks 189>;
> > -		clock-names =3D "pcie", "pcie_bus", "pcie_phy";
> > -	};
> > -
> > -* Freescale i.MX7d PCIe PHY
> > -
> > -This is the PHY associated with the IMX7d PCIe controller.  It's used
> > by the -PCI-e controller via the fsl,imx7d-pcie-phy phandle.
> > -
> > -Required properties:
> > -- compatible:
> > -	- "fsl,imx7d-pcie-phy"
> > -- reg: base address and length of the PCIe PHY controller diff --git
> > a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > new file mode 100644
> > index 000000000000..3503ce3de05d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -0,0 +1,207 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Fpci%2Ffsl%2Cimx6q-pcie.yaml%23&amp;data=3D0
> 4%7C0
> >
> +1%7Chongxing.zhu%40nxp.com%7Ca0e50943284145edfdc808d966649a08
> %7C686ea
> >
> +1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637653404543147546%7C
> Unknown%7C
> >
> +TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJXV
> >
> +CI6Mn0%3D%7C3000&amp;sdata=3DmW%2FTR8dffuxQDk%2Fm1eiUd8IIRBjE
> mJMhkxQZPo
> > +GYfHM%3D&amp;reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cho
> ngxing.
> >
> +zhu%40nxp.com%7Ca0e50943284145edfdc808d966649a08%7C686ea1d3b
> c2b4c6fa9
> >
> +2cd99c5c301635%7C0%7C1%7C637653404543147546%7CUnknown%7CT
> WFpbGZsb3d8e
> >
> +yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3
> >
> +000&amp;sdata=3DGh1dUyXO80b2aKvWKe0Q2GIN4w%2BCit1oj06AvToamuE
> %3D&amp;re
> > +served=3D0
> > +
> > +title: Freescale i.MX6 PCIe host controller
> > +
> > +maintainers:
> > +  - Lucas Stach <l.stach@pengutronix.de>
> > +  - Richard Zhu <hongxing.zhu@nxp.com>
> > +
> > +description: |+
> > +  This PCIe host controller is based on the Synopsys DesignWare PCIe
> > +IP
> > +  and thus inherits all the common properties defined in
> snps,dw-pcie.yaml.
>=20
> Don't need a freeform text reference, but...
[Richard Zhu] This part is copied from the description of previous the bind=
ing document.
Should I remove them totally?

> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
>=20
> ...this needs to reference the snps,dw-pcie.yaml DWC schema.
>=20
[Richard Zhu] Got that, would be change in next version patch.

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx6q-pcie
> > +      - fsl,imx6sx-pcie
> > +      - fsl,imx6qp-pcie
> > +      - fsl,imx7d-pcie
> > +      - fsl,imx8mq-pcie
> > +
> > +  reg:
> > +    items:
> > +      - description: Data Bus Interface (DBI) registers.
> > +      - description: PCIe configuration space region.
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: config
> > +
> > +  interrupts:
> > +    minItems: 1
>=20
> Don't need 'minItems: 1' when there's only 1 possible item:
[Richard Zhu] Okay, would be removed.

>=20
> > +    items:
> > +      - description: builtin MSI controller.
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    items:
> > +      - const: msi
> > +
> > +  clocks:
> > +    minItems: 3
> > +    maxItems: 4
>=20
> Don't need maxItems here.
>=20
[Richard Zhu] Okay, would be removed.

> > +    items:
> > +      - description: PCIe bridge clock.
> > +      - description: PCIe bus clock.
> > +      - description: PCIe PHY clock.
> > +      - description: Additional required clock entry for imx6sx-pcie,
> > +          imx8mq-pcie.
> > +
> > +  clock-names:
> > +    minItems: 3
> > +    maxItems: 4
>=20
> And here.
>=20
[Richard Zhu] Okay, would be removed.

> > +    items:
> > +      - const: pcie
> > +      - const: pcie_bus
> > +      - const: pcie_phy
> > +      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for
> > + imx8mq-pcie
> > +
> > +  num-lanes:
> > +    const: 1
> > +
> > +  num-viewport:
> > +    const: 4
>=20
> This is deprecated. The driver detects this now.
[Richard Zhu] Got that, thanks. Would delete this property.

>=20
> > +
> > +  fsl,imx7d-pcie-phy:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: A phandle to an fsl,imx7d-pcie-phy node. Additional
> > +      required properties for imx7d-pcie and imx8mq-pcie.
> > +
> > +  power-domains:
> > +    maxItems: 2
> > +    description: The first phandle pointing to the DISPLAY domain for
> > +      imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
> imx8mq-pcie.
> > +      The second phandle pointing to the PCIE_PHY power domains for
> imx6sx-pcie.
>=20
> Split the description:
>=20
> items:
>   - description: ...
>   - description: ...
>=20
[Richard Zhu] Got that, thanks.

> > +
> > +  power-domain-names:
> > +    maxItems: 2
>=20
> You have to define the names.
>=20
[Richard Zhu] Okay, would be added in next version patch.

> > +
> > +  resets:
> > +    maxItems: 3
> > +    description: Phandles to PCIe-related reset lines exposed by SRC
> > +      IP block. Additional required by imx7d-pcie and imx8mq-pcie.
> > +
> > +  reset-names:
> > +    items:
> > +      - const: pciephy
> > +      - const: apps
> > +      - const: turnoff
> > +
> > +  fsl,tx-deemph-gen1:
> > +    description: Gen1 De-emphasis value (optional required).
>=20
> optional or required?
[Richard Zhu] Yes, it's optional required by i.MX6Q/DL PCIe.
>=20
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0
> > +
> > +  fsl,tx-deemph-gen2-3p5db:
> > +    description: Gen2 (3.5db) De-emphasis value (optional required).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0
> > +
> > +  fsl,tx-deemph-gen2-6db:
> > +    description: Gen2 (6db) De-emphasis value (optional required).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 20
> > +
> > +  fsl,tx-swing-full:
> > +    description: Gen2 TX SWING FULL value (optional required).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 127
> > +
> > +  fsl,tx-swing-low:
> > +    description: TX launch amplitude swing_low value (optional require=
d).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 127
> > +
> > +  fsl,max-link-speed:
> > +    description: Specify PCI Gen for link capability (optional require=
d).
> > +      Note that the IMX6 LVDS clock outputs do not meet gen2 jitter
> > +      requirements and thus for gen2 capability a gen2 compliant clock
> > +      generator should be used and configured.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 3, 4]
> > +    default: 1
> > +
> > +  reset-gpio:
>=20
> Deprecated.
[Richard Zhu] The reset-gpio is designed to connect the PERST# signal on th=
e slot.
And it is derived from the previous binding document.

>=20
> > +    description: Should specify the GPIO for controlling the PCI bus d=
evice
> > +      reset signal. It's not polarity aware and defaults to active-low=
 reset
> > +      sequence (L=3Dreset state, H=3Doperation state) (optional requir=
ed).
> > +
> > +  reset-gpio-active-high:
>=20
> Deprecated. This should only be used on older compatibles I hope...
[Richard Zhu] Because that the polarity of the PERST-active is reversed on =
some i.MX6 customer's
hardware board designs.
This property is derived from the previous binding document, and only be us=
ed
on older compatibles. So, this is optional required.

>=20
> > +    description: If present then the reset sequence using the GPIO
> > +      specified in the "reset-gpio" property is reversed (H=3Dreset st=
ate,
> > +      L=3Doperation state) (optional required).
> > +
> > +  vpcie-supply:
> > +    description: Should specify the regulator in charge of PCIe port p=
ower.
> > +      The regulator will be enabled when initializing the PCIe host an=
d
> > +      disabled either as part of the init process or when shutting dow=
n
> > +      the host (optional required).
> > +
> > +  vph-supply:
> > +    description: Should specify the regulator in charge of VPH one of
> > +      the three PCIe PHY powers. This regulator can be supplied by bot=
h
> > +      1.8v and 3.3v voltage supplies (optional required).
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - device_type
> > +  - bus-range
> > +  - ranges
> > +  - num-lanes
> > +  - num-viewport
> > +  - interrupts
> > +  - interrupt-names
> > +  - "#interrupt-cells"
> > +  - interrupt-map-mask
> > +  - interrupt-map
> > +  - clocks
> > +  - clock-names
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx6qdl-clock.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    pcie: pcie@1ffc000 {
> > +        compatible =3D "fsl,imx6q-pcie";
> > +        reg =3D <0x01ffc000 0x04000>,
> > +              <0x01f00000 0x80000>;
> > +        reg-names =3D "dbi", "config";
> > +        #address-cells =3D <3>;
> > +        #size-cells =3D <2>;
> > +        device_type =3D "pci";
> > +        bus-range =3D <0x00 0xff>;
> > +        ranges =3D <0x81000000 0 0          0x01f80000 0
> 0x00010000>,
> > +                 <0x82000000 0 0x01000000 0x01000000 0
> 0x00f00000>;
> > +        num-lanes =3D <1>;
> > +        num-viewport =3D <4>;
> > +        interrupts =3D <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-names =3D "msi";
> > +        #interrupt-cells =3D <1>;
> > +        interrupt-map-mask =3D <0 0 0 0x7>;
> > +        interrupt-map =3D <0 0 0 1 &gpc GIC_SPI 123
> IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0 0 0 2 &gpc GIC_SPI 122
> IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0 0 0 3 &gpc GIC_SPI 121
> IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0 0 0 4 &gpc GIC_SPI 120
> IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clks IMX6QDL_CLK_PCIE_AXI>,
> > +                <&clks IMX6QDL_CLK_LVDS1_GATE>,
> > +                <&clks IMX6QDL_CLK_PCIE_REF_125M>;
> > +        clock-names =3D "pcie", "pcie_bus", "pcie_phy";
> > +        status =3D "disabled";
>=20
> Why are you disabling your example?
[Richard Zhu] Would remove the disable later. Thanks.

>=20
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > f73fef615702..a1e2cc0be9e8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14187,7 +14187,7 @@ M:	Lucas Stach <l.stach@pengutronix.de>
> >  L:	linux-pci@vger.kernel.org
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for
> non-subscribers)
> >  S:	Maintained
> > -F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >  F:	drivers/pci/controller/dwc/*imx6*
> >
> >  PCI DRIVER FOR FU740
> > --
> > 2.25.1
> >
> >
