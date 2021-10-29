Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2633243F44B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhJ2BOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 21:14:23 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:23686
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231269AbhJ2BOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 21:14:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3z1A+9T5JU5xKQY41trPQUBCTEe9bDY11mz6voXFrKqWOCz/dh5Ah8MibG9+hpQc6z3HlsYsSM9eRlS7ho9zYRRHiqqXNL8anCzjpQY2eQ728EsWYBsfzbFPGWHraK5dAeF9PVOsjFP7X9gZPqEaap1oeXnWw1HUFZ8P+yJgmOQ7byPGXlWwgK9Sd2owp6ICPibwJ7y/sY7KkwlBj3AChFyh03sUkHcVlOIG0XQwklcuf7AbC/kBckWqCJLNmKZ+UEMqukguyvyrigT2WEOmwwwhHU7UjV2BEes90BEef+YoQqPJgcZ6pYBKPYbxXVcrf5Xsmz9O1j6xYulbEKCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD+WXHejMNG+Dl0fmKvpGR26i9ErKPSocSN/gsj9TiM=;
 b=Ue+85idRAs4+EUuVWa8Mlv21N7oL+0Lpd5pJvPzDZf2zAqkwC7w4smiDwzTwnDQwtlXPx9VZaFzpPR5CKx62DUDRlaVTDHHir6gPaFFT/kUL9B6iMFInIR3dg0oc2XJH24FhLGz3k+VmuMM9Q4VZ9wuFqDWQGVHo2eKCyN/+wAa+eGUIA/S7VY/l7zZp8owHw476jBsecIb+h0jMZHAJYeA5HtbxNRAs7dALN4HZ3PTdntls0n2b/sEjbOA6xl3pjXbC5+Bo9mF1xtWBFZ7FzK5pio7sYb6bTO4geJRE9v0PNy1diN/iO8oMqwYMth/TOtwWRQ9Nnq6AiHUmTQ2DoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD+WXHejMNG+Dl0fmKvpGR26i9ErKPSocSN/gsj9TiM=;
 b=aosuj8TkF1bGJUe4xuKZXtcEhOxLjXz78r+qHkfzenYRf44Bq6L2Z/Dpt/3sp60hY/gtcV/GXT3h4IMaepllMNGKPc+NdBdQKH6iEmuvcrvG54oVOXdFv0nmh+UXTjs9QPIHfBlG2+KDvkMEtq0Up8e0a0WWRLmAvNim/apX3oo=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 01:11:52 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 01:11:51 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: RE: [PATCH v4 0/8] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v4 0/8] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHXzCgRaIzl2FakPkKByTDo2MY056vpK0/Q
Date:   Fri, 29 Oct 2021 01:11:51 +0000
Message-ID: <AS8PR04MB8676CCEF26C6176EDAD47EE98C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU3mmv=-19U39dKovAV1zWVPHWZxweDAvhEkW_wSQH1ikA@mail.gmail.com>
In-Reply-To: <CAJ+vNU3mmv=-19U39dKovAV1zWVPHWZxweDAvhEkW_wSQH1ikA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b9dbc6-9a48-44a0-f976-08d99a791725
x-ms-traffictypediagnostic: AS8PR04MB8564:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB8564167C427C20EA273AE56C8C879@AS8PR04MB8564.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gzCWI1gqIckClKuoVcEpKo2tBurAMpd0Nqr8WQsmDb3MTt+HPO1+VmJLTXvZ/qlKbJ10mCKKs8HejOYWCyP+4t4puL/iPIbmTTAEhoYfPgWflIrH0NEbjWZKydzhBaa5zgxAD4TJxt1OjDmEfn5b/LprdMCCWRwes1zo45d9hWlvsEeYaGOdh34j1/cMZ8NbsQsMzl9BcooBNfNgSc4RzpG3zmaA+GdCMTBr75qsRsmxuy07ZSq4+nbhsH2vOjVjnSJrjq6rIU8Ebk2oNZcqC1F84a+foJdEZ/p273BVUXyuyQ2IPOeP43CKg+RiTBcRE7oKxbN88EV6VU04spsCs9ru4Pp+HQxqSvDDLmUuBlSql6mCdmuxi1PKU15DRTbUwM8NFprrCqMsVVhyNjTru9HQqmTC7qy+K1PTQ+85m6GtRDNqHkSx9kU07nPLXdwZi5cXiQXfRcSgHxAE+LGp6UUGrW7pZojy23MXLgQWH9vngbvrRKwwRCryq3sjRViUxEZf4z0LPPyWAsSF9xI5Nl7dI8Dwy6n7H19ulTTRfJs/C9y6UL27mnUD1YkYwcB6JvHApHKaBB3+BASoNF0AKQPU26SfuqYyJ4aYrIg5EBEBsckKbGImT6MEHBaEE6Y3FptQ2Y0+NtB6zwsd7MPmCo3fQOFBdXzcGcZORI3tDBEHcVIIyPs2vJswN5AtGy0LUcaGSULGVI9HA2hOIHwU+vsIhRl/0d5NAZAt4LhMWDp2631fLKRz227EPcmOWRBUfovdTYUbrJ4nSpGIelto3ObaLDdZFE2r06qHvmHmTRqyAB3KEemT4MriyDzRcgM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(45080400002)(26005)(7416002)(186003)(38070700005)(122000001)(76116006)(9686003)(64756008)(83380400001)(966005)(5660300002)(33656002)(66556008)(52536014)(6916009)(66446008)(54906003)(71200400001)(6506007)(66946007)(86362001)(66476007)(53546011)(4326008)(8676002)(55016002)(8936002)(316002)(2906002)(38100700002)(7696005)(508600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?12arY2/t04P/4IaUuR4x3W6vXe06Z6ww7RrE2VD4SGExOShd8EAJpz0qQjuC?=
 =?us-ascii?Q?bXoe8TJgfvotHeMYwUnKIKCA3Cve62Ee2652ngPxvx76GzE8qbbwthlXveJ5?=
 =?us-ascii?Q?hmlgW92samkV9GEIBYo0WkpKvjPaeGPTfjpUnq6S2JatYWorjtgruVdLBZzc?=
 =?us-ascii?Q?Am9ZEvijPaXLKNGBWg432YfncxJqq2r2qZAvkmauWsuNJ5Y9VcohU46RDF+1?=
 =?us-ascii?Q?3RCRUunUCNrhpB+zDceBcj74otemQRhHlXVKqYVFA2YTEO8B92KK+89V8r5d?=
 =?us-ascii?Q?TVd/6SpUOFcZYbKJygNV2kSrnyoaBO82AbgxVcpf04+OKH8Zl2c61LBGZins?=
 =?us-ascii?Q?41+i4BcVr1Vbvfti9RWGXEcGPTMIvbVsq5ST9/ejAEdBXCdrKaufLuw4zREC?=
 =?us-ascii?Q?Xtuo/AcjP6skpGSIda7ApL2HhXB8NuL3JSyeZhSviX0/a+T57sgleG9CE758?=
 =?us-ascii?Q?tVNkGQiat92+tffpr+Ti59pIAGgWJqOGTo8fq/NpYz2YuISV5cmefSAdKifc?=
 =?us-ascii?Q?hvU8x9Dbj5Fz8wt4GUDt/CfCrwfZXus38gvHYWlYA07j05vCD0EJ8NUkD83+?=
 =?us-ascii?Q?7MyK0yTb6WIDIDYs17PENr6yAAdmiMm/g3p3GOLTP0hV6d43R2ELI7+rcqBJ?=
 =?us-ascii?Q?r8Q8AP9QEKb/F4Tpibl0rWZze6MvdKDobOVRqApA9ZMOKEiq8r2cWSOGrKRT?=
 =?us-ascii?Q?64ph1B9EuFEqQvb00NmtuW4LXdNj9scD6ZiBJOMh1AcXXU4kiqCHQzZeD14U?=
 =?us-ascii?Q?4URjOwwXvK9mMs9I/wo4p+V13GidhwtYZh8MbiPAspDRjrody4mnsHB6ITXn?=
 =?us-ascii?Q?Krh2gKkfjMyv5Fxrax9VxSfHAkF2wyss5DWe3pUh63WGcFMZvoeZSgRUskyf?=
 =?us-ascii?Q?eCvoa2R2jZKMkB/wXQxirSe1k6oViKxbIMOhc3YJ78/OutEbYiOkx4UPEM6n?=
 =?us-ascii?Q?aykoLgL0ASMANlwTvWchTmqPviTzcNXGyCN5ZLnRD8E+wwavaYGEa55kkmgN?=
 =?us-ascii?Q?SLeXTMtlWUi/1CIptkaf8OgX6iczXdJppcC23H56qs39ykhQaTyqsJaNmis/?=
 =?us-ascii?Q?ZDj/Nzm5VZsp3k2TftOAu02ROsG7EsERBUWSvBV+/TZ5zlFAJMaYiMjVF/io?=
 =?us-ascii?Q?1qP+ja500vIXIaeRmNZM0r2VnGT5dck/9NOyni4NfDcLNoGjynYHRURNxeR/?=
 =?us-ascii?Q?6M9RIhc8x0Z3gQ5Td3l2wF28bzRzb5Qp8/+KkP89sNIhv6eca1r/KGHLxWu8?=
 =?us-ascii?Q?C+ttrvO4FZozGdUNP19WojtgdHzGGouOqXIxx48rM8uaZUdz+jCx41KyE2/X?=
 =?us-ascii?Q?IyVYIAqzzznIHxqsDVsPnjLa98opcXka5m5ndjCVSU7NojuKumkm+ArzPYtD?=
 =?us-ascii?Q?lYFdL8QEUAnbfrvRbcP4WuqcVUHkQ87ad6nLZelbeZFSsv4WVRZfwWZPaT7h?=
 =?us-ascii?Q?U48V4CoHsG5cMGBcnsXXaJRI+W3d7HJsutbpp7+bvXBsgFq/LumQCj7dHlXD?=
 =?us-ascii?Q?W+heJ62KW3fTe7drTQiO/cvAt91JqWr61gaNNZSTlqf4nOrIZqRWm6IpLwnl?=
 =?us-ascii?Q?FTXIa6KeDJtGIlGxlfzlRsG/eQhaIYa/3b5MWWuoHjQ6hwyZ3AbZKSKfGwmx?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b9dbc6-9a48-44a0-f976-08d99a791725
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 01:11:51.8794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aTa6JB+dOSi5KUR3w2wk7/zmFlHEtYWuqVO3rBd6HGkbyGpTkmNxTA/KCG/DHCurhX2z97MK7tfyxCl0ZvbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tim Harvey <tharvey@gateworks.com>
> Sent: Friday, October 29, 2021 2:17 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>; Marcel Ziswiler
> <marcel.ziswiler@toradex.com>; Kishon Vijay Abraham I
> <kishon@ti.com>; vkoul@kernel.org; Rob Herring <robh@kernel.org>;
> galak@kernel.crashing.org; Shawn Guo <shawnguo@kernel.org>;
> linux-phy@lists.infradead.org; Device Tree Mailing List
> <devicetree@vger.kernel.org>; Linux ARM Mailing List
> <linux-arm-kernel@lists.infradead.org>; open list
> <linux-kernel@vger.kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v4 0/8] add the imx8m pcie phy driver and imx8mm
> pcie support
>=20
> On Thu, Oct 28, 2021 at 12:52 AM Richard Zhu <hongxing.zhu@nxp.com>
> wrote:
> >
> > Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> > one standalone PCIe PHY driver should be seperated from i.MX PCIe
> > driver when enable i.MX8MM PCIe support.
> >
> > This patch-set adds the standalone PCIe PHY driver suport[1-5], and
> > i.MX8MM PCIe support[6-8] to have whole view to review this
> patch-set.
> >
> > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> driver
> > [2] and this patch-set.
> >
> > [1]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tc
> >
> hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.
> 929120
> >
> -3-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu
> %40nxp.c
> >
> om%7C90b27fd98a4d47a5a68c08d99a3f32e3%7C686ea1d3bc2b4c6fa92
> cd99c5c3016
> >
> 35%7C0%7C0%7C637710418493785262%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&
> amp;sdata=3D
> >
> K%2B5UzVRndlp9qJT9RlkQp2qzKAx%2B76xwMd51xHLEZKI%3D&amp;re
> served=3D0
> > [2]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tc
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F20210910
> 202640
> > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chon
> gxing.zhu%
> >
> 40nxp.com%7C90b27fd98a4d47a5a68c08d99a3f32e3%7C686ea1d3bc2b
> 4c6fa92cd99
> >
> c5c301635%7C0%7C0%7C637710418493795238%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjo
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp
> > ;sdata=3DkKpDrUNfZy0qR3QlJxW7tUgmVl8PS0WwUb4O694bOkA%3D&a
> mp;reserved=3D0
> >
> > Main changes v3 --> v4:
> > - Update the yaml to fix syntax error, add maxitems and drop
> > description of phy
> > - Correct the clock name in PHY DT node.
> > - Squash the EVK board relalted dts changes into one patch, and drop
> the
> >   useless dummy clock and gpio suffix in DT nodes.
> > - Add board specific de-emphasis parameters as DT properties. Thus
> each board
> >   can specify its actual de-emphasis values.
> > - Update the commit log of PHY driver.
> > - Remove the useless codes from PCIe driver, since they are moved to
> > PHY driver
> > - After the discussion and verification of the CLKREQ# configurations
> with Tim,
> >   agree to add an optional boolean property "fsl,clkreq-unsupported",
> indicates
> >   the CLKREQ# signal is hooked or not in HW designs.
> > - Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>" tag,
> since
> >   Marcel help to test the v3 patch-set.
> >
> > Main changes v2 --> v3:
> > - Regarding Lucas' comments.
> >  - to have a whole view to review the patches, send out the i.MX8MM
> PCIe support too.
> >  - move the PHY related bits manipulations of the GPR/SRC to
> standalone PHY driver.
> >  - split the dts changes to SOC and board DT, and use the enum instead
> of raw value.
> >  - update the license of the dt-binding header file.
> >
> > Changes v1 --> v2:
> > - Update the license of the dt-binding header file to make the license
> >   compatible with dts files.
> > - Fix the dt_binding_check errors.
> >
> > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6
> +++
> > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  95
> +++++++++++++++++++++++++++++++++
> > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |
> 55 +++++++++++++++++++
> > arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |
> 46 +++++++++++++++-
> > drivers/pci/controller/dwc/pci-imx6.c                        |
> 73 ++++++++++++++++++++++---
> > drivers/phy/freescale/Kconfig                                |
> 9 ++++
> > drivers/phy/freescale/Makefile                               |
> 1 +
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   |
> 234
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +++++++++++++++++++++
> > include/dt-bindings/phy/phy-imx8-pcie.h                      |
> 14 +++++
> > 9 files changed, 525 insertions(+), 8 deletions(-)
> >
> > [PATCH v4 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> > [PATCH v4 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
> > [PATCH v4 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
> > [PATCH v4 4/8] arm64: dts: imx8mm: Add the pcie phy support [PATCH
> v4
> > 5/8] phy: freescale: pcie: Initialize the imx8 pcie [PATCH v4 6/8]
> > arm64: dts: imx8mm: Add the pcie support [PATCH v4 7/8] arm64: dts:
> > imx8mm-evk: Add the pcie support on imx8mm [PATCH v4 8/8] PCI:
> imx:
> > Add the imx8mm pcie support
>=20
> Richard,
>=20
> For your v4 series:
>=20
> Reviewed-By: Tim Harvey <tharvey@gateworks.com>
> Tested-By: Tim Harvey <tharvey@gateworks.com>
>=20
> I tested this on imx8mm-venice* boards with no CLKREQ# support as well
> as an imx8mm-evk board.
>=20
[Richard Zhu] Thanks a lot.

Best Regards
Richard Zhu

> Thanks again for your effort on this series!
>=20
> Best regards,
>=20
> Tim
