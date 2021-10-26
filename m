Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46543ABCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 07:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhJZFoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 01:44:10 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:39037
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234463AbhJZFoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 01:44:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/GVPxaXHxUP7qA+ZEE82mY6NKWTucfCmm9unDG25TqJu//Qx6BOVzTM4sUVFaS109weuRQAVOlwGKavFhviarCsq0ZXpB7lYyeJaobfX7VvcvhSZ8mdq6uzqdNLabmDzJ/vnBo8xoATkO2ZQmEDk0p6Jee2p+BifWYQIsAT/XLHuqnfdZQh650wNy+Fr45XCbfnIFqPeajnApsSAps1aI1oLraVxZ+TbMnLxCV5M97iVM5+SjP1fdYWDucP5aMfrX85hL3vYPvntiVJPg++wJ8R9naX1Hnz+J7uGIVsB2Re4nsSyQsldalIXk89S6/GbxxXlvpxaVM12hjpdll/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFyoN64I8zuU6ejr5AoZ5chw1Q2EyVU+N3fdp9IV8IQ=;
 b=R1IyZPDRweqokmXq5CIVKh0ZkGEyTu/rYyr3PpTLOt/BUmeo1dEPmDLi69FC2EZTWqTyCYL8KP6AV6EFqrfCrrZHJaVcV8080kZM9lMfD6Zg3MbLH2sWLSLz9cD/oDufy50t472uJyZL8w78huFXYeHZr6MDVqrQR1dkWZGSyTbqUG+ZUwKAD8QOdYZofu2DCtzEVakgZWosnXKRHd6MsMVItdO4zs0kY/Ci/wtro7Q9sLwfDzriKZFTmw0EZ8K3+XIswXYdxHbAQ+aD0b6/t0fEhqJK5Tn924ZvAPr27WEagNTf+bMx9sTYV5s18JzXTmwKAXxkYJ9yj7C1ciouDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFyoN64I8zuU6ejr5AoZ5chw1Q2EyVU+N3fdp9IV8IQ=;
 b=gwRme/9uwY0JmizbIeOhMBe//sik72sZC1fXXfpCOTD+V15JjM5xDMeV8i6Vz6QjiM0VxzIo3kD/PdnSU53Rr2iHmbUzPMHfxHeXvXdj3LdMk4mBcYnQy3lJOeS+UR2fF+aJIenguWRzfcDuq/b1A1kV8XWM/LPXT8t3GlFVoig=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8756.eurprd04.prod.outlook.com (2603:10a6:20b:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 05:41:43 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 05:41:42 +0000
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
Thread-Index: AQHXwf8T9WRZIWT4CUunBVSnJ63L4qvZhp6ggAD4IYCAAKk/cIABRTmAgABCoVCAAPyvgIAAhMLwgAEGQACAAA+SAIADuD4QgABZ2ZCAAKpdAIAAx5Nw
Date:   Tue, 26 Oct 2021 05:41:42 +0000
Message-ID: <AS8PR04MB86767EED0FB08363A80D86508C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU2b-=T_gTsRBvdF7SRUZopEFOU_Np8mEJn8bOpn5b5FaA@mail.gmail.com>
 <AS8PR04MB8676B2AC24E2769D47A1ED478CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2AitmxCyam5FArmxAD41QUU=5CF_0JZhm+uzdkRbr7kw@mail.gmail.com>
 <AS8PR04MB8676840D7EDD56D10F9471288CBE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2GU5=mM5+2Yg9gAuU0RSdJHWEU_+ykmz-qUWfsOnRJ8g@mail.gmail.com>
 <AS8PR04MB867624A8A5B6AE27D6A9160F8CBF9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU1Si_bv0_2j5AU-v_1QtUGqwU_4u=NksAVFFXXkkNC1Sw@mail.gmail.com>
 <AS8PR04MB8676D9FFB6506A09D104E32A8C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU0cLd7oex5uUyJenqs229gsgZe_Vpu3uyKGw1=B+Uu5YQ@mail.gmail.com>
 <CAJ+vNU0wcQtrKh5W7UZknEiV2o7MKLV90CCrJqGGw=x_VYwMGg@mail.gmail.com>
 <AS8PR04MB867697878533A37B72D7E4AA8C839@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB867620E1A1E940275CD38B528C839@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU1nTYSHPZ1Twmy4k4pKuH7xQy95gTOJXx+mcTMZRfj-TA@mail.gmail.com>
In-Reply-To: <CAJ+vNU1nTYSHPZ1Twmy4k4pKuH7xQy95gTOJXx+mcTMZRfj-TA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f9c28c5-5204-4a7d-17fb-08d998434a80
x-ms-traffictypediagnostic: AS8PR04MB8756:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB8756A01883C46D1489BB09A78C849@AS8PR04MB8756.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2pddq2yPHIspHifpsrSO8iSTqn+afxOc4QcA2dVhgBB1tjo9fSvQw0pdnCclsqKj4P5nBGVJEcmmBXo4JvT1RotzXNWMqn7WmIBeaiOo9SdT977I0y6Epj20wOOUEcEtB/G+cyHQ+Ye7rk/j9XLiaZml0gcG1glDMu2eIV9+TPcHMLA5sad5f3F9TuzttDm+NDAoZvUXBnCfnYELkt95S4Fzxp0dtR82shl8GYOw+Eb/ba0Me+8Y9GoPoNFOmHdL34O6ckwxgqmT0d1tWgQmPRKfzsyFeW6GC+m42CwiK/HTQMwnkealku53yPDRiZO3Tp/1b3iCv7OYNEB8XFiF3SEtXhsfXzwLnH/73OHfvwmIA0KEItdBL8BK2lUZC4k0CVUpMUiSMtrrFR3uRjddArI2d4ED7v1WQTFCra+DCLDcxFfsnqwao+nNvlUDQsPsafTX/ikFxBHWzBDFxAEryLTTXB4+ZfzsYjwG8Z9+ZkpFmCE3Xm+al2nmUoteIoDpT7sXGGtF2ZmiZkR4Gr+PYZnZ9f+9Sp8B/Rv0sBSz/CPgqJ6LYPP4rA+lncK8zqPMZU2QwILkKTtbI8edn53knqb0E8zfhEcGvaY4ELtyIP0xv+mq240MutczWHmq5s6VeYj40G5vo0H9d626H4JUBHQ+y5gadWU1+7d1wnP67mTHijfUwQsNyACazCZe47c+ince4KQcQ/eBztFxMZl3DAvIxXPYys2aeIP7G3AX6Rqxpq2Vfvd6oE7FBenXUSMGims2ySCVlcvFYV2Mg6e6H3wKn+aTH1HFblykqeNdTvTW7hVZoTO0yD3vxYg4wl4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(53546011)(7696005)(45080400002)(8676002)(966005)(7416002)(508600001)(186003)(5660300002)(52536014)(2906002)(38100700002)(4326008)(30864003)(6506007)(38070700005)(66446008)(26005)(122000001)(55016002)(9686003)(71200400001)(316002)(64756008)(66556008)(66946007)(54906003)(8936002)(33656002)(66476007)(6916009)(83380400001)(76116006)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JAXeArZD27laT2WWqdx71WbU4i7mQtW9TVFaCKgxhYZY3oDhWewilJPM7dry?=
 =?us-ascii?Q?8GLDsriDRZzIDCkmM1UUPWXN08k3yE2SG76gWM3pLoiNQ0qTFnF63Ev06wFX?=
 =?us-ascii?Q?8O+07w+Q7EvH4nSr3cdZwNDQ3dkO68gj3ZLGaxcoCsyzBN3/wNvr1KKcILh9?=
 =?us-ascii?Q?P0GCiJnO/FiqYCGpQVM6hM0wlFS/vusAsEN1sSKKdDeBgXUQAXmN+H9fJy08?=
 =?us-ascii?Q?h63N3LdONsxHVkJqkeYDroAUQbohLuN/znP8nfmb9NwLtp7qESX7alvJtg3S?=
 =?us-ascii?Q?7wVVGRjxsmULsxLyjpVKphukYs/tHGIi33Vq8wf2lHwKTPacuedSHFN5F0Z5?=
 =?us-ascii?Q?wNTw0cQWai//CdAFB5XJ8SHG1Lhf7PvFj4CmAwQmTLD1FOtvZdXM1xzylE75?=
 =?us-ascii?Q?g4fo2DOc1eNktd//VdRtdZxfWFDx/ep6vy90sjCWi7KNFHIOF7ORqV4aPAeh?=
 =?us-ascii?Q?jZCDTpipm3t2XGddozv05g3H0wCHn1iPvvdpIYTHXKjLGcmgsutH//tjZMj9?=
 =?us-ascii?Q?SBPzp76843sqz6a3jvCmfgtppPQEOHqIG5x4DZVR9OaD3WxuiMhXVHx4p6/7?=
 =?us-ascii?Q?LVvdVecf97mbSUxG/x8uvTD2vmdeynn6cbX+h91CDbBVwIAAgcF0mInxOBhN?=
 =?us-ascii?Q?XayO3jVSogtxGl/h/BlbU6eJJ3wsYsLx+ws3k+Hy3EUk4tlWZSrmhCUn5hI/?=
 =?us-ascii?Q?5KkwVcnmIe7avo7dwvJTp5AXx74Rsb7BS+mCrFjewMBOY7UxRTfrTL6mXfP9?=
 =?us-ascii?Q?WR4Qkw1dw1g1gQSBejwln/id2di3iJY/rU+YPXXcvpxmDpq6HHi/6BWZD2hD?=
 =?us-ascii?Q?PSxYe/i5xNi9wzVORzwcK8DDEOs8IszMm7YNXtjmyNBEfgvjpRUH+g+oF1p0?=
 =?us-ascii?Q?y/rE68xOnG4veQAOl79h3PcLl2SRhpjv/rwtVTJIYzbjxkqYM08bHLRSBaqV?=
 =?us-ascii?Q?zin/st3cEyU+jZ052IH0fhBfaOEB6AAqNkAwjYDWjsxIfMAxc9USMsWwnVNU?=
 =?us-ascii?Q?ozPaUUdHgQYmTlQnWyrV8D6L4/zn1qNIj1AilftMS7BreVDciu3D2f2P4RpN?=
 =?us-ascii?Q?MwsFnipG44RFdHQkWVdVGGii3AxaPHlEyFYnQhw1TdaBs8JLyW0GLvMktJ+c?=
 =?us-ascii?Q?z45luK+ojxXsSHyvvhpIk61VrTkyjtbkMSoyZlOecUNVXdS6OgvM2SRaiRb+?=
 =?us-ascii?Q?sImZZmOjiOtNopfYNz2QC7nlnzN894P2VnkPCMAnVUNbtF/doO9Dz478hh24?=
 =?us-ascii?Q?tYHwyBfv4xUxGj4izvQu+vOHXbD43jGxDu1Rcr9foVCTfStSWRLoBIka4S9B?=
 =?us-ascii?Q?g/KYVbxgfZ1OqzUJDrId4VZ4upnKQHKVy5mWMEApWo+fKklY8VCttZDmEiif?=
 =?us-ascii?Q?PMUYfr4h53bbl9fiG5tLZHxp0Su1ZbLgO4r9ZC1/0BqM8F7pEhcxyi25YNxz?=
 =?us-ascii?Q?TZKQivXmlXzgGhqUNvGrTCanHvDnimmLus3r/qjYyoDzw6QBS/efvBRaXjmO?=
 =?us-ascii?Q?QES31zYR8TsAFJGOQQXxvYG26UsRo7OWfHaAWcd6/Y8ZUF6cRkKcso0TlYPx?=
 =?us-ascii?Q?sXQbCmK/iyFSdAjPzc94kIMs8PeR/171NDv9uNFF1xfoUqiIijugWSBfSIiB?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9c28c5-5204-4a7d-17fb-08d998434a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 05:41:42.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1gMbQYuO4DcJJv1GTSTTO4t3gq8PCQtlZT0CFTISwNOkhUmOuh+TQ94pFO+R6bGgs9IY0alSaBJ0zxPb2IVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8756
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tim Harvey <tharvey@gateworks.com>
> Sent: Tuesday, October 26, 2021 1:15 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>; Kishon Vijay Abraham I
> <kishon@ti.com>; vkoul@kernel.org; Rob Herring <robh@kernel.org>;
> galak@kernel.crashing.org; Shawn Guo <shawnguo@kernel.org>;
> linux-phy@lists.infradead.org; Device Tree Mailing List
> <devicetree@vger.kernel.org>; Linux ARM Mailing List
> <linux-arm-kernel@lists.infradead.org>; open list
> <linux-kernel@vger.kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
> support
>=20
> On Mon, Oct 25, 2021 at 12:23 AM Richard Zhu <hongxing.zhu@nxp.com>
> wrote:
> >
> > Snipped...
> >
> > > > > > > > > My boards do not use CLKREQ# so I do not have that
> > > > > > > > > defined in pinmux and I found that if I add
> > > > > > > > > MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B
> > > > > > > PCIe
> > > > > > > > > works on my board but this isn't a solution just a
> > > > > > > > > work-around (I have boards that use the only two
> > > > > > > > > possible pins for CLKREQ as other
> > > > > > > features).
> > > > > > > > >
> > > > > > > > > Similarly you will find on the imx8mm-evk if you comment
> > > > > > > > > out the CLKREQ (which isn't required) the imx8mmevk will
> > > > > > > > > end up hanging like my
> > > > > > > boards:
> > > > > > > > [Richard Zhu] Hi Tim:
> > > > > > > > Regarding the SPEC, the CLKREQ# is mandatory required, and
> > > > > > > > should be
> > > > > > > configured as an open drain, active low signal.
> > > > > > > > And this signal should be driven low by the PCIe M.2
> > > > > > > > device to request the
> > > > > > > REF clock be available(active low).
> > > > > > > > So, there is such kind of CLKREQ# pin definition on
> > > > > > > > i.MX8MM EVK
> > > > board.
> > > > > > > >
> > > > > > > > Anyway, I think the external OSC circuit should be always
> > > > > > > > running if there is
> > > > > > > no CLKREQ# on your HW board design.
> > > > > > > >
> > > > > > >
> > > > > > > The way I understand it is CLKREQ# allows the host to
> > > > > > > disable the REFCLK when not needed for power savings so it
> > > > > > > would seem optional to implement that and if not implemented
> > > > > > > should be left unconnected on
> > > > the card.
> > > > > > >
> > > > > > [Richard Zhu] No, not that way. Regarding the SPEC, this
> > > > > > signal is
> > > > mandatory required.
> > > > > > Especially for the L1ss usages. This signal would be OD(open
> > > > > > drain), bi-directional, and might be driven low/high by RC or
> > > > > > EP automatically if
> > > > L1ss modes are enabled.
> > > > > > You can make reference to the
> > > > > > "ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a", or
> the
> > > > chapter 5.5 L1 PM Substates of "PCI Express Base Specification, Rev=
.
> > > > 4.0 Version 1.0".
> > > > > >
> > > > >
> > > > > CLKREQ is only mandatory if you wish to support clock power
> > > > > management. Many boards with a PCI host controller do not
> > > > > support this.
> > > [Richard Zhu] Okay, understood.
> > >
> > > > >
> > > > > > > > > diff --git
> > > > > > > > > a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > > index 5ce43daa0c8b..f0023b48f475 100644
> > > > > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > > @@ -448,7 +448,9 @@
> > > > > > > > >
> > > > > > > > >         pinctrl_pcie0: pcie0grp {
> > > > > > > > >                 fsl,pins =3D <
> > > > > > > > > +/*
> > > > > > > > >
> > > > > > > > > MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B    0x61
> > > > > > > > > +*/
> > > > > > > > >
> > > > > > > MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21
> > > > > > > > > 0x41
> > > > > > > > >                 >;
> > > > > > > > >         };
> > > > > > > > >
> > > > > > > > > I have PCIe working with a driver that I ported from
> > > > > > > > > NXP's kernel which differs from your driver in that the
> > > > > > > > > PCIe PHY is not abstracted to its own driver so I think
> > > > > > > > > this has something to do with the order in which the phy
> > > > > > > > > is reset or
> > > initialized?
> > > > > > > > > The configuration of
> > > > > > > gpr14 bits looks correct to me.
> > > > > > > > [Richard Zhu] The CLKREQ# PIN definition shouldn't be maske=
d.
> > > > > > > > In the NXP's local BSP kernel, I just force CLKREQ# low to
> > > > > > > > level up the HW
> > > > > > > compatibility.
> > > > > > > > That's might the reason why the PCIe works on your HW
> > > > > > > > board although the
> > > > > > > CLKREQ# PIN is not defined.
> > > > > > > > This method is a little rude and violate the SPEC, and not
> > > > > > > > recommended
> > > > > > > although it levels up the HW compatibility.
> > > > > > > > So I drop this method in this series.
> > > > > > > >
> > > > > > >
> > > > > > > Sorry, I don't understand what you are saying here. Is there
> > > > > > > a change you are going to make to v4 that will make this
> > > > > > > work for the evk and my boards? What is that change exactly?
> > > > > > [Richard Zhu] No. What I said above is that the CLKREQ# is
> > > > > > forced to be low in NXP local BSP kernel. I guess this might
> > > > > > be the reason why your
> > > > board works.
> > > > > >
> > > > > > BIT11 and BIT10 of IOMUXC_GPR14 can be used to force the
> > > > > > CLKREQ# to
> > > > be low.
> > > > > > Set CLKREQ_OVERRIDE_EN(bit10) 1b1, then write one zero to
> > > > CLKREQ_OVERRIDE(bit11).
> > > > > >
> > > > >
> > > > > Ok, that makes sense. Those bits are not explained well in the
> > > > > IMX8MMRM. As my board's external REFCLK is always enabled that
> > > > > must gate the clock internally to the host controller block.
> > > > >
> > > > > I can confirm that asserting those GPR14 bits does resolve my iss=
ue:
> > > > >
> > > > > #define IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_VAL    BIT(11)
> > > > > #define IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_EN     BIT(10)
> > > > >
> > > > >        /*
> > > > >         * for boards that do not connect CLKREQ#,
> > > > >         * override CLKREQ# and drive it low internally
> > > > >         */
> > > > >        regmap_update_bits(imx8_phy->iomuxc_gpr,
> IOMUXC_GPR14,
> > > > >
> > > > IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_VAL, 0);
> > > > >        regmap_update_bits(imx8_phy->iomuxc_gpr,
> IOMUXC_GPR14,
> > > > >
> > > > IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_EN, 1);
> > > [Richard Zhu] regmap bits operations should manipulate according bits=
.
> > > The BIT(10) and BIT(11) should be touched actually.
> > >
> > > > >
> > > > > Should this be added as a 'fsl,clkreq-unsupported' flag that
> > > > > needs to be set true to implement the above code?
> > > > >
> > > >
> > > > Richard,
> > > >
> > > > Sorry - spoke too soon. My test was flawed as I still was
> > > > pinmuxing CLKREQ in my dt to work around the issue and after
> > > > removed the above did not resolve my issue. The setting of
> > > > OVERRIDE_EN was wrong above (should not be set to '1' but BIT(10)
> > > > instead) but this code already exists in imx6_pcie_enable_ref_clk
> > > > and is used for IMX8MM per your patch so this is not the issue.
> > > >
> > > > What makes my board work is to clear GPR14 bit9 (like the NXP
> > > > kernel
> > > > does) so I don't think this bit does what we think it does (select
> > > > between internal and ext clk). I think setting it enables clock
> > > > gating via
> > > CLKREQ#.
> > > >
> > > > This also points out that perhaps the CLKREQ_OVERRIDE logic should
> > > > be moved to the new phy driver for IMX8MM.
> > > [Richard Zhu] It sounds reasonable to consider to force the CLKREQ#
> > > to be low.
> > > I will think about that and add this in later v5 patch-set if nobody
> > > has different concerns.
> > > Thanks.
> > [Richard Zhu] Hi Tim:
> > As you mentioned above, the CLKREQ# GPIO PIN is not used for PCIe on
> your board, right?
> > " (I have boards that use the only two possible pins for CLKREQ as othe=
r
> features)"
> >
> > Did the override configuration of the clkreq# will bring unexpected res=
ults
> for other features on your board?
> >
>=20
> What I mean is that imx8mm-venice-gw7901.dts uses both I2C4 and UART4
> and because I2C4_SCL and UART4_RXD are the only two pads that could be
> pinmuxed for CLKREQ# I can't use the workaround of pin muxing it.
>=20
> Currently your driver only works on my imx8mm-venice-* boards if I add on=
e
> of the following on boards that don't connect those pads (or if I clear
> IMX8MM_GPR_PCIE_REF_USE_PAD):
> MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B
> MX8MM_IOMUXC_UART4_RXD_PCIE1_CLKREQ_B
>=20
> Note your 'PCI: imx: add the imx8mm pcie support' patch [1] does enable t=
his
> code already in the imx6_pcie_enable_ref_clk function to override REF_CLK
> and drive it low:
>=20
> offset =3D imx6_pcie_grp_offset(imx6_pcie);
> /*
> * Set the over ride low and enabled
> * make sure that REF_CLK is turned on.
> */
> regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
>    IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
>    0);
> regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
>    IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
>    IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
>=20
> So this is already being run and yet my boards still do not work unless I=
 clr
> IMX8MM_GPR_PCIE_REF_USE_PAD like this which is what the NXP
> downstream driver does:
> regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> IMX8MM_GPR_PCIE_REF_USE_PAD, 0);
>=20
> This is why I'm not sure that bit does what you think it does... I feel l=
ike that
> bit enables 'Use CLKREQ# to enable CLK'.
>=20
> You tell me the descriptions for GPR14 are wrong in the reference manual.
> Please provide correct descriptions for us so we can sort this out.
>=20
[Richard Zhu] Hi Tim:
The BIT9 of GPR14 is used as "GPR_PCIE1_PHY_I_AUX_EN_OVERRIDE_EN"
and BIT19 is used as "GPR_PCIE1_PHY_FUNC_I_AUX_EN" on i.MX8MM.
I think the two bits descriptions are used to describe the BIT19 and BIT9 t=
ogether refer to my guess.
{GPR_PCIE1_PHY_I_AUX_EN_OVERRIDE_EN(BIT9), GPR_PCIE1_PHY_FUNC_I_AUX_EN(BIT1=
9) }
2'b00: External Reference Clock I/O (for PLL) Disable
2'b01: External Reference Clock I/O (for PLL) Enable
2'b10: External Reference Clock I/O (for PLL) Disable
2'b11: External Reference Clock I/O (for PLL) output is controlled by CLKRE=
Q#

The option1&3 should be forbidden, since the external REF CLK I/O should be=
 enabled on your board and EVK board.
In the option2&4, the BIT19 should be set to be 1'b1.

So, regarding my understand, if the CLKREQ# is not pinmuxed in your use cas=
e, the IMX8MM_GPR_PCIE_REF_USE_PAD (BIT9) should be 1'b0.

BR
Richard
> Best regards,
>=20
> Tim
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F1634028078-23
> 87-10-git-send-email-hongxing.zhu%40nxp.com%2F&amp;data=3D04%7C01%7
> Chongxing.zhu%40nxp.com%7Cb796532d98124790154a08d997daf1e4%7C6
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637707788885954739%
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DNRK9mIMkYsgcXzBsL
> I7GE62hy64Bumxr8WdCD1oh59w%3D&amp;reserved=3D0
