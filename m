Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8294358FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 05:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhJUDei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 23:34:38 -0400
Received: from mail-db8eur05on2079.outbound.protection.outlook.com ([40.107.20.79]:54025
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229817AbhJUDeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 23:34:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfrqXbTPc95VgSEpdHLb8ZCDhmmbINvVGodVKgTolwajAPJt8n2V+o0c44dI6MfWusQDpePjQfNxL6hOPlHoWwHOJqchg2EOfhLPtR/AMJ9QrmZs2/fZqI2ngKfotpbvfxIEtiZtbhep4flk/KIzRyKcLsdfT4+wW7Vh4r6MD32P4D+6x830+R0iEzcSkaI93Vii+6ByezH8C8RZLoXRcAsV7fUOv/XNkTDjHTfsvZqwJHgko1k6gPVv4+QxbO3/GVqoANFXEJTVJV7AgfkvTWoQvttOmSfUyJFg2CWHvpkenKfgaze3I9IoTj3lmvhKmrWHfZteqJC+62HeP/lP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgkDTEIPsL0+u4WoEyOQcYThL+HbairCdZD74W0v63o=;
 b=k9i7CRwH6Na0M8ISwQlKCDnU8QEim/cyfAXW9oN1n9j1II6xAAyQTQsogyWGYCD3yXaYXer6MoPjdTthqcme//GL+yzHzK5hrw5OMD7OrmMHEhvptXInvZQwaob3noEf8jWfmNvrmaQNSn3+qv5yMh1cHQXBU6EyEsoDI7lIswEc4zOu5wWeQMzB+3OOzKHp4659A0zsIL4FGzNS0S8NyEOpuHH3U8G/CvUoAshDtcGMtIYdRT+qlSk/t3ffRJcZKoRSMUb6HD/LPWshDgK4GxJXGkALX9A+6s74WAxi2ZJqpWssVvIpOg+gwmQmdmV0V33ECOMR/6BQe4ofmpgpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgkDTEIPsL0+u4WoEyOQcYThL+HbairCdZD74W0v63o=;
 b=gBWNDvZWZyD70s8WRMBRP2QVyxW8Q63JkTwBhFX3jVWSiXVSvmE+zpqTmmgddAY5bcMF6LPoyrlp5IczIpbFZGsw/vSvA9evrQFGG75jck/eGMitEpw4VqTzkbevcZDYa2cCYjhXaOUOgnqVv5JaJl2E4o9P/goI+Y3tfBoZrqs=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 03:32:19 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 03:32:19 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHXwf8T9WRZIWT4CUunBVSnJ63L4qvZhp6ggAD4IYCAAKk/cIABRTmAgABCoVA=
Date:   Thu, 21 Oct 2021 03:32:18 +0000
Message-ID: <AS8PR04MB867624A8A5B6AE27D6A9160F8CBF9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU2b-=T_gTsRBvdF7SRUZopEFOU_Np8mEJn8bOpn5b5FaA@mail.gmail.com>
 <AS8PR04MB8676B2AC24E2769D47A1ED478CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2AitmxCyam5FArmxAD41QUU=5CF_0JZhm+uzdkRbr7kw@mail.gmail.com>
 <AS8PR04MB8676840D7EDD56D10F9471288CBE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2GU5=mM5+2Yg9gAuU0RSdJHWEU_+ykmz-qUWfsOnRJ8g@mail.gmail.com>
In-Reply-To: <CAJ+vNU2GU5=mM5+2Yg9gAuU0RSdJHWEU_+ykmz-qUWfsOnRJ8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a7abf5c-6f83-4fb5-152f-08d9944362e5
x-ms-traffictypediagnostic: AS8PR04MB8627:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB8627ADAE3636496FAA30C6038CBF9@AS8PR04MB8627.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTl24nfmPMefDXSF/GHjiv0WrYWbsp+H2T/ymKp+ydW+HMq6YlaFDkrH0/Xms2QbOioEoe5vBS8e3Hu57ehobeIYolA9jLrYhTUKLZWKZxM9KVPEXXiAOVYpEficA3sgvUoQX9diEqBWFL8E+o6mzEjIkDr1UfNKUicLWqYmLnkdl6A6lAXTQVg1OuCzuRJ4qhVqN88+mWiroK7q+PBxqyGaGpXTg1+CpPltHU9BjI/EDAN8N3DWNIEx46sjUv6QIodVgm3lXtZuSz/atizrzdM+ItE4ibpy8Y9zZkbjNngI2gRTNOEXWvhWPHikAB+8FLsg7oNIFUZYUtZTupCWvGhG+SbGv1aYBh5shNbHCmnjfHbR2ubu1fKy0rWAXZ51BiwrCjCXDe/0Hwt3CWCbrPjM1iEdksOpCZprdTuYQ12E9ZyNA6HbxPnR9JJ0QiZ3qdC2zKOWHbCqG1biqBHVgE1ZjCyEU++zN/uGCZmTLfG6SX3MQV/dtNi2/DT8DNh8J7Y1jrBHKI2aCoDRJJTdXJIh/32wcvvhob+o0HhjyLfa3H1Oz/mT99apo1LC7pMDA0ZgfEQ1pApMyd8IP9s3WoO8RhsG725OsOmhRJffV1bAkjpgP/zUTZImXL+f0MWHHRTN7nxH4rsHQPnWrVcLYQWEynTSnHVrNsYQ/r6KxSbJjwFjwoxOk1g1kZKyVA6UGYnDjdqL048hIeVyq/E3Ix02T6nxCqOsqNfBKALTm7k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(55016002)(6506007)(2906002)(86362001)(66556008)(66476007)(7696005)(8936002)(64756008)(71200400001)(8676002)(66446008)(38070700005)(508600001)(76116006)(52536014)(5660300002)(66946007)(26005)(6916009)(122000001)(38100700002)(4326008)(186003)(33656002)(54906003)(316002)(83380400001)(7416002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ofyhu+gWEm69fPGIwjLeW7IWwD661JgbFVZVTPTFvPeUeaeUTGt2VDb2xaCF?=
 =?us-ascii?Q?muqQO9OOg55Mjo97CP9LbI7/wrj/Ms7XGwoRMMjbSW7ANTG8DUn7j+F3P+5d?=
 =?us-ascii?Q?o3lwKfR4Q+iJ0epEk8C0VVIw3aRgLVb8xkGsbh22FLDd8kbeCItyjIHwhGgB?=
 =?us-ascii?Q?L3a2QC8QERGa/MUH4J7T3srjKnS/yUTHUHVqGy0AC+TDfkhVa1Rc8MZxDTUO?=
 =?us-ascii?Q?IRXiqD+m8uMdeLSge7zUGc/y/wpGoRtrQz8Lv4NY6IiyPmI7ozSljhGjR8nS?=
 =?us-ascii?Q?Vam3xl71QGk/oravi/yNhGg8RWQGFepNPPvV9FrKrWY3CjhEMeYOnEn1PCFa?=
 =?us-ascii?Q?DdVlGCf84CFwv6zWgpyx3E9LZ/nwtPkWPyZtjgdIGecbAwZ6V6PWFnbJiPum?=
 =?us-ascii?Q?vpHmO9kJAnOpW0XLtlQveNlUM7LYdL1ULtfF3aHHuJ/rtx4oTIrO8//mLuA4?=
 =?us-ascii?Q?8DFSt1BhFUhT4IQ6646RqHhKjFl6qG0DJ4oO+oONZF4lRJkilEb6RuY576eL?=
 =?us-ascii?Q?X/lTGMoMRXZbo3DMio9cm/EzP7uIMh7GJlg7b9IROKNyotJAg+kN9QUYHP/j?=
 =?us-ascii?Q?LffkNT3ipMcg/DIy3jF943JrDY95EIbPWj58OdpDESJPm/B+HGMpRoQDLxtQ?=
 =?us-ascii?Q?DFtDZZp6GKDFwSKZL1QRyyaYWsOJF4CfzSW4XSeYZzqj+Ye5Cx9Dfzh5HO2l?=
 =?us-ascii?Q?vESMFyuwJC+qDettjwh+tyjbv2uZtV1pXvNlhqYo3s+XawXQ215G5QhrchW5?=
 =?us-ascii?Q?1F5UK00bVaUi3TBvmb/lR4Us2QcgdYvFUZ2uvjwQjBpLgdUi1Jq0YCv0wIPY?=
 =?us-ascii?Q?3RpA0tnYrEQSGPJL43YNxzrIm7lhR1Xaqi9eCrh4gw0urfqoZswh9JI3dZaa?=
 =?us-ascii?Q?BtXlnGo8D/vIJ55xTCPzSEzS1hSgTYWdBQtszIuqsN0nX07ZNF8KlOqa4CJ/?=
 =?us-ascii?Q?h/xbU6hPbOTAwsNqE+MJhR4pSSBvOU7sDVwkonqaq9ClkzH7ZUBm0rk1SCYk?=
 =?us-ascii?Q?j/fJ980ZQvpsJrLDJTdtXxsXcy/AGJEzYEF8B1vd0ISsv2NaR22oxSxJoO+P?=
 =?us-ascii?Q?Rw07AdVRDkTQBdDs/AX4RAEWw/f3kyYEnLwpm8y/ShCZ/1KY2LUSUSlEdLa0?=
 =?us-ascii?Q?ZKFSi8IrQSRCPDETlfZ1cCSEMwDRK9b46flUirPE7g9HzsaoKSDr5rIyQ0Jl?=
 =?us-ascii?Q?XSMTVmzRLflKFpQcWiZx1zC5siyvcVgeco9Oufb9M8Xa4pkvRIgcWnCOni5F?=
 =?us-ascii?Q?rg6rUqTzCHBgkLChutwqM4c+cSW3hx/po2NNAkYkaoVLl34lv08fGIM+DFsg?=
 =?us-ascii?Q?sAXDkibzP/dZcaK7Pp5Ckf8fQfcZCm+wgbpi98IAdgcxm1CBPhWhVif59Sem?=
 =?us-ascii?Q?FCjH0UQ0JqqtY4UY6C9XspRwJ8NAO6lTjgxSlf3/U1T+kfGWNyZyZCv+EzXf?=
 =?us-ascii?Q?H1jbPe5WcuU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7abf5c-6f83-4fb5-152f-08d9944362e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 03:32:19.1639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hongxing.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snipped...>
>=20
> Richard,
>=20
> What is this 'invalid resource' about? I see that with my downstream
> IMX8MM PCIe driver as well and have been asked about it.
>=20
[Richard Zhu] Hi Tim:
This complain is caused by the following codes in pcie-designware.c driver.
I'm not sure that why there is only size assignment after the res valid che=
ck, and do nothing if the res is invalid.
It seems that it is an expected design logic refer to the later codes.
                if (!pci->atu_base) {
                        struct resource *res =3D
                                platform_get_resource_byname(pdev, IORESOUR=
CE_MEM, "atu");
                        if (res)
                                pci->atu_size =3D resource_size(res);
                        pci->atu_base =3D devm_ioremap_resource(dev, res);
                        if (IS_ERR(pci->atu_base))
                                pci->atu_base =3D pci->dbi_base + DEFAULT_D=
BI_ATU_OFFSET;
                }

Since the default offset is used on i.MX8MM, the "atu" is not specified in =
i.MX8MM PCIe DT node, so there is no real res at all.
Then, devm_ioremap_resource() would complain the invalid resource.

> > [    1.316305] imx6q-pcie 33800000.pcie: iATU unroll: enabled
> > [    1.321799] imx6q-pcie 33800000.pcie: Detected iATU regions: 4
> outbound, 4 inbound
> > [    1.429803] imx6q-pcie 33800000.pcie: Link up
> > [    1.534497] imx6q-pcie 33800000.pcie: Link up
> > [    1.538870] imx6q-pcie 33800000.pcie: Link up, Gen2
> > [    1.550364] imx6q-pcie 33800000.pcie: Link up
> > [    1.550487] imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> > [    1.565545] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    1.573834] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > [    1.580055] pci_bus 0000:00: root bus resource [mem
> 0x18000000-0x1fefffff]
> > [    1.586968] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> > [    1.592997] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> > [    1.599282] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff
> pref]
> > [    1.606033] pci 0000:00:00.0: supports D1
> > [    1.610053] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> D3cold
> > [    1.618206] pci 0000:01:00.0: [15b7:5002] type 00 class 0x010802
> > [    1.624293] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff
> 64bit]
> > [    1.631177] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000000ff
> 64bit]
> > [    1.638409] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth,
> limited by 5.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 31.504 Gb/s =
with
> 8.0 GT/s PCIe x4 link)
> > [    1.664931] pci 0000:00:00.0: BAR 0: assigned [mem
> 0x18000000-0x180fffff]
> > [    1.671745] pci 0000:00:00.0: BAR 14: assigned [mem
> 0x18100000-0x181fffff]
> > [    1.678634] pci 0000:00:00.0: BAR 6: assigned [mem
> 0x18200000-0x1820ffff pref]
> > [    1.685873] pci 0000:01:00.0: BAR 0: assigned [mem
> 0x18100000-0x18103fff 64bit]
> > [    1.693222] pci 0000:01:00.0: BAR 4: assigned [mem
> 0x18104000-0x181040ff 64bit]
> > [    1.700577] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > [    1.705814] pci 0000:00:00.0:   bridge window [mem
> 0x18100000-0x181fffff]
> > [    1.712972] pcieport 0000:00:00.0: PME: Signaling with IRQ 216
> > "
> > Regarding the log you pasted, it seems that the clock is not feed to PH=
Y
> properly.
> >
> > Anyway, let's waiting for the v4 series, then make a try. Thanks for yo=
ur
> great help to make the double tests.
> >
>=20
> My boards do not use CLKREQ# so I do not have that defined in pinmux and =
I
> found that if I add MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B PCIe
> works on my board but this isn't a solution just a work-around (I have bo=
ards
> that use the only two possible pins for CLKREQ as other features).
>=20
> Similarly you will find on the imx8mm-evk if you comment out the CLKREQ
> (which isn't required) the imx8mmevk will end up hanging like my boards:
[Richard Zhu] Hi Tim:
Regarding the SPEC, the CLKREQ# is mandatory required, and should be config=
ured as an open drain, active low signal.
And this signal should be driven low by the PCIe M.2 device to request the =
REF clock be available(active low).
So, there is such kind of CLKREQ# pin definition on i.MX8MM EVK board.

Anyway, I think the external OSC circuit should be always running if there =
is no CLKREQ# on your HW board design.

> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 5ce43daa0c8b..f0023b48f475 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -448,7 +448,9 @@
>=20
>         pinctrl_pcie0: pcie0grp {
>                 fsl,pins =3D <
> +/*
>=20
> MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B    0x61
> +*/
>                         MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21
> 0x41
>                 >;
>         };
>=20
> I have PCIe working with a driver that I ported from NXP's kernel which d=
iffers
> from your driver in that the PCIe PHY is not abstracted to its own driver=
 so I
> think this has something to do with the order in which the phy is reset o=
r
> initialized? The configuration of gpr14 bits looks correct to me.
[Richard Zhu] The CLKREQ# PIN definition shouldn't be masked.
In the NXP's local BSP kernel, I just force CLKREQ# low to level up the HW =
compatibility.
That's might the reason why the PCIe works on your HW board although the CL=
KREQ# PIN is not defined.
This method is a little rude and violate the SPEC, and not recommended alth=
ough it levels up the HW compatibility.
So I drop this method in this series.

BR
Richard
>=20
> Best regards,
>=20
> Tim
