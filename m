Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB6455228
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbhKRB01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:26:27 -0500
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:16005
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232650AbhKRB00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:26:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7mofh7VSvTD1llotaZ+1FsQJJWbc5Unf10t9wxv2yf5sPjmE9Crtf9cOoL405qYzy+uo+OeRNrwcKozrzUQi0MDmbOh08OM/W3N/CXijNlwvfb6fw4PD4JR3cDZ6ZrgskcP4Qy4Wge3RyPrHyQcw0cHrpavALyVsVSoatY2tzKeK6+PsxRO4ZZmljxlyYGP2xdGL8AmR3hylJ7GmwqZl1K2ejDyzMJW+zuNR8N1P7USj3OTfzW5qFFLsEB8bLZF7Sip1yOd0rKQAjIYeYyT6vfqrJF0fFG+mSeTqQcxvO2YqfYA/DJw/NBaUGG3DC5AOMsge3AGYsqSN0/9LeWY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bWKOiIP9WQ1OYwtkod37bZmZqdijVkqondZhW4mtmE=;
 b=dqJLADxXsZE0QhKay+cRXWeCJQA74pUO3awHQcuPwcTjZYA2e2ez04QpeFysy9Ma9adE+fS7K+iJgEDmN39a9oLlZfux8oda8lPqMtR8apCemIilK+zKH/3L9F0uzCGKQGk8Xf14stRbO+9tzjPEZvrkCwhGmJ9DKG4JkahqX7VHi0GphsAxp3eV07uWn8Bo1LP20qr03cFHpRZcX2BoBtvTYM1DD4WFsWlLRRF924rQHRThUtj6Khw3PCITU6u1CINdVjlXWejdb8nDb3nBt5G+7SD9JWXDBd7zqfIHFCq8ziqI6fcKvRMp9R75P/AgXS331uJEMiXQPHjU0dqM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bWKOiIP9WQ1OYwtkod37bZmZqdijVkqondZhW4mtmE=;
 b=S/zIB08HnLZFj+ejnIWvG1t7su1jAMEL2H29gorECiI8HOznXWwocz1ILemO71hFcHUtnBx8oUp/kaTgnVqCV3IMOTkSxwnisNYA08r/+jcoS2bXpwg1Jy97F1F1OIjTZdYuQDVYcAv5y9EJNJUOc6HZzd6qEiWzfiuU1wcsA9I=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 01:23:24 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 01:23:24 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
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
Subject: RE: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHX2nQKnAA55lO24Eigwg7jrckmc6wFXtVggAGcAoCAAQrmgIAAejNA
Date:   Thu, 18 Nov 2021 01:23:23 +0000
Message-ID: <AS8PR04MB867612CF34A07B55172D6AAA8C9B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU3r0aC8GrTQ2z5BqsCFCAXP+BWt2ntqsNy8DBd--nxdvQ@mail.gmail.com>
 <AS8PR04MB86760660BD24E4C2BD98F6318C999@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB867632F01C9B0524BE994A5F8C9A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU0VZ1S7RoJuT-9KD7+V_s_qpvZzawR9cVejVjmnQkxBQA@mail.gmail.com>
In-Reply-To: <CAJ+vNU0VZ1S7RoJuT-9KD7+V_s_qpvZzawR9cVejVjmnQkxBQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d59d522-f369-4a60-895f-08d9aa320401
x-ms-traffictypediagnostic: AS1PR04MB9479:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS1PR04MB9479FF90E6CEEA48BA1EA2168C9B9@AS1PR04MB9479.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyhOMyzxqZef5joFZyQMxBqmUNvyN4m612eRXkRw+qcANPtNl7FFrY9bQ+qo9rCWFNv9e6occ/fh3wpKaXSorUtMlrBWRzTQnmS+3xe0ePfElYIILsObUdnApJVFUiOsNdFVXFrdrNR5ZvA7oIKgDWciF61JqoFIZkNM3yuckW0em/RV3xpWhHSNg5Qj3FJe95Qn3AatK0sKONenTp9peM0N0JU9HYYjnrT8HE6q+Q/N73L+ynDPbFGb2NeAjX4VYm5fdvBKcRggWZAkNwTUIufdK4IHAkN81LM/RgQl0g+OIFUsjvDy+/X/LcV4scuuNmwpcHadwy9vDedp7nKfS+zfjbuqx39Ea3ENDrLobWzqtlSfB9bd6cOPjXR0R2F+gU+CKLk3W2URiAxT2LsPxQTY4V9ZzUm15zRrkw1HlJGQv4kZBLyd14OVMYlEkJujqqwRKQURzsPuSWDS4Z5Yg1esZ3q28mdwkwxTVzkVM5CDnsvRJ8iBgiyvQqGdVDRZNg9teSGRp8dzbQDFiCzYE8WQgxBL4bIrPPZoxb54YuBuaghhvN6MWDTz95qoBU3gaWM2ctcdEtVxId3ZNcQKvoZ+cyZXKdASvVXLqg6ey/repbcVVyPv50X+uv95L6I8lUlgNWmE0DJWkbWIIHVsPrU6FES8dczCVUNkdnh+ibExAKpa0HwloodqlCw2JCRYQHJBjmiZha7dXO783W5tYMBbgAWCdr27fvARHjVvFmH0WvEfMyV1tbEYS46YrXznwkW2Rs/O4VtOstohPyPvUru4sUlJ9b1axCidBGZc/m7ikvtvB4dVG1kZWq/YWa21
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(53546011)(5660300002)(66476007)(54906003)(4326008)(8936002)(9686003)(71200400001)(508600001)(966005)(7416002)(44832011)(55016002)(45080400002)(86362001)(52536014)(66556008)(6916009)(64756008)(38070700005)(26005)(186003)(33656002)(38100700002)(8676002)(66446008)(66946007)(122000001)(76116006)(2906002)(316002)(83380400001)(7696005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MTb5dPzIN2lQCI9wFc4xkLAJKFsorK/reuKjzZOq8eEHJ8VXEH2hiWddo/2b?=
 =?us-ascii?Q?K+fgyIxE7PxVMr5eHj67X/ZMIJLIsVacBpDnvtDYHc5lV+TkC3D2w02qtQTg?=
 =?us-ascii?Q?KlNBpr1jFwnZu6MsA1v4IG2FU4WnAuNlYlehdliZ7/yu3M2LkvKO13XDlVpC?=
 =?us-ascii?Q?KceZxZ6S35ho61gZH4HmRtS77IGghVM4USya9w/mfmgmGueo+zcAqhAXWYen?=
 =?us-ascii?Q?iNYq98pGdi5RG0swGShZsOpK8o6xs+b0J66TlvJawOJTayKdu9++QiJjbmdV?=
 =?us-ascii?Q?9b77ak5vAqNk2rLL8LgdJkNv+o8kRqp5Hulx5QxPhmJ/PNP7czMDitZwNzI0?=
 =?us-ascii?Q?qfhyz/bPT2tV2gccWY0QwrdV7SFtpNmZyQz1n43pyRzacdwFhzc4PMqDsWp7?=
 =?us-ascii?Q?sfSPtwh4/K2duVJAQDOdgjdLXnE2xW40wrpBLXJBjurTKc7c4s0f83DlhxgZ?=
 =?us-ascii?Q?GSpr0JsJTpsw+jKmqvxsAsqCE1wVEsV7B20sZX4tDuh1wMu/x2YZzZtg3tTx?=
 =?us-ascii?Q?7ILlWMDVCO+5NCSKD7FYRmaVvmv67jJsr/le20inqQJwbe7M2sI3wFymqTvU?=
 =?us-ascii?Q?3a2jKKFBBssjZMCINOdZoQ+oTVpOW4HqkN3E6/kCm/zhqYrOZ/4q+ouJmoc4?=
 =?us-ascii?Q?u2i5jbSHZiTTPYr9mQT2zxGp4A29xDCmwpKD/VY/t+Yf99uQXxxccePtRLOL?=
 =?us-ascii?Q?sEBa9CwnthMezowoQTs9DcwyMc6/kDl1gISwZcHia//9iYSk85iU9o9toSqN?=
 =?us-ascii?Q?6VvA10YRiZpDAVBIGRxzOVd0w3qrj8vq/4BRbk3mi/Pj/Xp1FChgo7QZCAVb?=
 =?us-ascii?Q?sKEOUCyg7A7dkCIV4iWn9wDz9XhyR0dpa1iDGy7WGlXOgjjMjMOki+PjuHC5?=
 =?us-ascii?Q?CiTFNseUU6wSzZ2iemUEICGM+Ohn/fAw8nnNlZ1SfIuw0R8kx3oU1jzDYUbJ?=
 =?us-ascii?Q?heUiBpGW8hp1b8QcTTjevf2q2HuByqj+ws1ReRzgWvb+pcpqwpyby3iWQbQM?=
 =?us-ascii?Q?6EFGEhZZWErmkW7qzLf7Gi/iynl3dbKTi9CExI+8Y+F1k0aCDGEiY1Q/YJ6Y?=
 =?us-ascii?Q?zzIHcPqqD1Z48XnW5bmiS/nQ0+Q3YNxiNqOynMa9SSimUTudlXvqmMfmy4Dj?=
 =?us-ascii?Q?5mG4hMYPIRDNMGPPTyVUPspf1Viza4qnVUpADYVMrbQHT9Oz0nkUXXuZmW0m?=
 =?us-ascii?Q?mJFWCehnAQPrCwio0+6bpELtzzo/fXxSXLlllaSYt0wMCB9KKl9+eF2y08Zl?=
 =?us-ascii?Q?RP4ir1d1RQgxMWqIV67Uo/opypzQriZExQmnMWbq/sfi3eQTCMLPUaayPB/8?=
 =?us-ascii?Q?DVOzs36M1jpZ3vzA2TkWWoSiqSH6JDeA6v8+pmydaB+YNvqjTWJeKarpVWNd?=
 =?us-ascii?Q?0XD/6/ajs4eVP1mo6ab2f8VUpWYtOBgcSfk5vGA8ZZYrHqbaNTdNlLtSA1xJ?=
 =?us-ascii?Q?mweY4/QTLYUXFjFjNUcRBTtHGhtATQTOGk53tHq48OfDhh3kvGc7QIpcZ3gC?=
 =?us-ascii?Q?MOADL7S6C+3mWhk8K3AsAg3MKcTl3/BJC1RD/zWO9+tQIxc/tOGMtyuWLbS5?=
 =?us-ascii?Q?sVYiIxo6xqf60CI9ALpCXIKV/C3cynEiXHjJ5UlbqLf74iOwlV8kJKdwhY44?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d59d522-f369-4a60-895f-08d9aa320401
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 01:23:23.9174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0k0RvzM13PfGeV2BOAt+cnFcnypAImLrMRKmXP8nKz4+zZj4PhzqjI7Az9+mvqkXzuOCEQN8N+5m9Vegc3/y+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tim Harvey <tharvey@gateworks.com>
> Sent: Thursday, November 18, 2021 2:03 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>; Marcel Ziswiler
> <marcel.ziswiler@toradex.com>; Kishon Vijay Abraham I
> <kishon@ti.com>; vkoul@kernel.org; Rob Herring <robh@kernel.org>;
> galak@kernel.crashing.org; Shawn Guo <shawnguo@kernel.org>;
> linux-phy@lists.infradead.org; Device Tree Mailing List
> <devicetree@vger.kernel.org>; Linux ARM Mailing List
> <linux-arm-kernel@lists.infradead.org>; open list
> <linux-kernel@vger.kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm
> pcie support
>=20
> On Tue, Nov 16, 2021 at 7:38 PM Hongxing Zhu <hongxing.zhu@nxp.com>
> wrote:
> >
> > <snipped...>
> > > > Subject: Re: [PATCH v5 0/8] Add the imx8m pcie phy driver and
> > > > imx8mm pcie support
> > > >
> > > > On Mon, Nov 1, 2021 at 7:58 PM Richard Zhu
> <hongxing.zhu@nxp.com>
> > > > wrote:
> > > > >
> > > > > Refer to the discussion [1] when try to enable i.MX8MM PCIe
> > > > > support, one standalone PCIe PHY driver should be seperated from
> > > > > i.MX PCIe driver when enable i.MX8MM PCIe support.
> > > > >
> > > > > This patch-set adds the standalone PCIe PHY driver suport[1-5],
> > > > > and i.MX8MM PCIe support[6-8] to have whole view to review
> this
> > > > patch-set.
> > > > >
> > > > > The PCIe works on i.MX8MM EVK board based the the blkctrl
> power
> > > > driver
> > > > > [2] and this patch-set. And tested by Tim and Marcel on the
> > > > > different reference clock modes boards.
> > > > >
> > > > > [1]
> > > > >
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > > tc
> > > > >
> > > >
> > >
> hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.
> > > > 929120
> > > > >
> > > >
> > >
> -3-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu
> > > > %40nxp.c
> > > > >
> > > >
> > >
> om%7C489971db9c0f4308600208d9a88b2b05%7C686ea1d3bc2b4c6fa9
> > > > 2cd99c5c3016
> > > > >
> > > >
> > >
> 35%7C0%7C0%7C637726137953234928%7CUnknown%7CTWFpbGZsb3d
> > > > 8eyJWIjoiMC4wLj
> > > > >
> > > >
> > >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> > > > amp;sdata=3D
> > > > >
> > > >
> > >
> ltuNZqIAsEH6%2B1KE4cqNOiUul3Ex%2BWmYcyqD%2BFJuUrs%3D&amp;
> > > > reserved=3D0
> > > > > [2]
> > > > >
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > > tc
> > > > >
> > > >
> > >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F20210910
> > > > 202640
> > > > > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7
> Ch
> > > on
> > > > gxing.zhu%
> > > > >
> > > >
> > >
> 40nxp.com%7C489971db9c0f4308600208d9a88b2b05%7C686ea1d3bc2
> > > > b4c6fa92cd99
> > > > >
> > > >
> > >
> c5c301635%7C0%7C0%7C637726137953234928%7CUnknown%7CTWFp
> > > > bGZsb3d8eyJWIjo
> > > > >
> > > >
> > >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > > > 7C3000&amp
> > > > > ;sdata=3DMrT3Re3YttE9AoqmGHksTqt4jF4vitRPz5lkgpZqSZ4%3D&a
> mp;r
> > > es
> > > > erved=3D0
> > > > >
> > > > > Main changes v4 --> v5:
> > > > > - Set the AUX_EN always 1b'1, thus it can fix the regression
> > > > > introduced
> > > > in v4
> > > > >   series on Marcel's board.
> > > > > - Use the lower-case letter in the devicetreee refer to Marcel's
> > > > comments.
> > > > > - Since the default value of the deemphasis parameters are zero,
> > > > > only
> > > > set
> > > > >   the deemphasis registers when the input paramters are none
> zero.
> > > > >
> > > > > Main changes v3 --> v4:
> > > > > - Update the yaml to fix syntax error, add maxitems and drop
> > > > > description of phy
> > > > > - Correct the clock name in PHY DT node.
> > > > > - Squash the EVK board relalted dts changes into one patch, and
> > > > > drop
> > > > the
> > > > >   useless dummy clock and gpio suffix in DT nodes.
> > > > > - Add board specific de-emphasis parameters as DT properties.
> > > > > Thus
> > > > each board
> > > > >   can specify its actual de-emphasis values.
> > > > > - Update the commit log of PHY driver.
> > > > > - Remove the useless codes from PCIe driver, since they are
> > > > > moved to PHY driver
> > > > > - After the discussion and verification of the CLKREQ#
> > > > > configurations
> > > > with Tim,
> > > > >   agree to add an optional boolean property
> > > > > "fsl,clkreq-unsupported",
> > > > indicates
> > > > >   the CLKREQ# signal is hooked or not in HW designs.
> > > > > - Add "Tested-by: Marcel Ziswiler
> <marcel.ziswiler@toradex.com>"
> > > > > tag,
> > > > since
> > > > >   Marcel help to test the v3 patch-set.
> > > > >
> > > > > Main changes v2 --> v3:
> > > > > - Regarding Lucas' comments.
> > > > >  - to have a whole view to review the patches, send out the
> > > i.MX8MM
> > > > PCIe support too.
> > > > >  - move the PHY related bits manipulations of the GPR/SRC to
> > > > standalone PHY driver.
> > > > >  - split the dts changes to SOC and board DT, and use the enum
> > > > > instead
> > > > of raw value.
> > > > >  - update the license of the dt-binding header file.
> > > > >
> > > > > Changes v1 --> v2:
> > > > > - Update the license of the dt-binding header file to make the
> license
> > > > >   compatible with dts files.
> > > > > - Fix the dt_binding_check errors.
> > > > >
> > > > > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |
> > > 6
> > > > +++
> > > > > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |
> > > 95
> > > > ++++++++++++++++++++++++++++++++
> > > > > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > |
> > > > 55 +++++++++++++++++++
> > > > > arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > |
> > > > 46 +++++++++++++++-
> > > > > drivers/pci/controller/dwc/pci-imx6.c
> |
> > > > 73 ++++++++++++++++++++++---
> > > > > drivers/phy/freescale/Kconfig
> > > |
> > > > 9 ++++
> > > > > drivers/phy/freescale/Makefile
> > > |
> > > > 1 +
> > > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> |
> > > > 237
> > > >
> > >
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > +++++++++++++++++++++
> > > > > include/dt-bindings/phy/phy-imx8-pcie.h
> |
> > > > 14 +++++
> > > > > 9 files changed, 528 insertions(+), 8 deletions(-)
> > > > >
> > > > > [PATCH v5 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for
> > > > > the [PATCH v5 2/8] dt-bindings: phy: Add imx8 pcie phy driver
> > > > > support [PATCH v5 3/8] dt-bindings: imx6q-pcie: Add PHY phandles
> > > > > and name [PATCH v5 4/8] arm64: dts: imx8mm: Add the pcie phy
> > > > > support
> > > [PATCH
> > > > v5
> > > > > 5/8] phy: freescale: pcie: Initialize the imx8 pcie [PATCH v5
> > > > > 6/8]
> > > > > arm64: dts: imx8mm: Add the pcie support [PATCH v5 7/8] arm64:
> > > dts:
> > > > > imx8mm-evk: Add the pcie support on imx8mm [PATCH v5 8/8]
> PCI:
> > > > imx:
> > > > > Add the imx8mm pcie support
> > > >
> > > > Richard,
> > > >
> > > > Are you posting a v6 of this series or have we already missed the
> > > > window for 5.16?
> > > [Richard Zhu] Hi Tim:
> > > Thanks for your kindly reminder.
> > > In my original plan, I prefer to merge the codes refine firstly,
> > > then issue the v6 patch-set after the rebase.
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > >
> tchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F1635747
> 47&
> > >
> amp;data=3D04%7C01%7Chongxing.zhu%40nxp.com%7Cb61cadb6304c4fc
> 5b2b308d9
> > >
> a9f47d58%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6377
> 2768981662
> > >
> 4369%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJ
> > >
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Dl2aYIxQgqabNiB
> ZcPTpszCG
> > > ikSErSr2Wm41bbhr6nBU%3D&amp;reserved=3D0
> > > 8-25562-1-git-send-email-hongxing.zhu@nxp.com/
> > > Unfortunately, I don't get ack from Lucas for other four patches.
> > > Anyway, I would post the v6 patch-set immediately after merge Rob's
> > > comments.
> > >
> > > Best Regards
> > > Richard Zhu
> > > >
> > > > Best regards,
> > > >
> > [Richard Zhu] Hi Tim:
> > The V6 patch-set listed below had been issued.
> > "
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tchwork.kernel.org%2Fproject%2Flinux-phy%2Fcover%2F1637028976-92
> 01-1-git-send-email-hongxing.zhu%40nxp.com%2F&amp;data=3D04%7C01
> %7Chongxing.zhu%40nxp.com%7Cb61cadb6304c4fc5b2b308d9a9f47d58
> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C63772768981
> 6624369%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D9
> 9%2FYacu3kbEIgQoRihQKTPx6bZ5P9EIL2c7YIoARoK0%3D&amp;reserved
> =3D0"
> > GENERIC PHY FRAMEWORK maintainer Kishon and Vinod had been
> contained
> > in the  mail-loop.
> > Do you know who I can ping to pick up the PHY part of this patch-set?
> >
>=20
> Richard,
>=20
> Thanks for posting the v6 series. Hopefully you can get Rob's ACK on the
> last dt-binding patch. I'm not sure who would pick up patches in
> drivers/phy - I don't see a maintainer for that dir. Perhaps Lucas knows?
>=20
> I noticed you did not send your v5 or v6 patchset to
> linux-pci@vger.kernel.org so its missing from
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tchwork.kernel.org%2Fproject%2Flinux-pci%2Flist%2F&amp;data=3D04%7C
> 01%7Chongxing.zhu%40nxp.com%7Cb61cadb6304c4fc5b2b308d9a9f47d
> 58%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637727689
> 816634320%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata
> =3DOXqC48KlbI%2FW2YegPy5ERLWD3nPU4Jbw03AaizH%2B6P8%3D&amp;
> reserved=3D0 and maybe that's why you haven't gotten ack's yet?
>=20
[Richard Zhu] Ooh... It's my fault.
When Lucas want to have a whole view with the PHY part driver
 and PCIe controller driver changes.
I forget include the Linux-pci@vger.kernel.org into the mail loop.
I'll resend the v6 patch after include the Linux-pci@vger.kernel.org.
Thanks for your reminder.

Best Regards
Richard Zhu

> Best regards,
>=20
> Tim
>=20
>=20
> Tim
