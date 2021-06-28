Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4663B5CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhF1LRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:17:04 -0400
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:18177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232767AbhF1LRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:17:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkV0X4BS+aHSGdkSG8/DArZBUWEXFFDcrkX/cYEXMyp/giWgKwPrTQaedLrtfebVY7H78pLcbZpK/Q8L0t1SaX7H7PDPI6mBhA117tqOlI7vNIRP/11N2h7j/2FS1H0EOofZ9XUB2Ixgiwpr0dSZiV5I092HEPnanDWqb/QWNgCVFGRRY5KbyHs7lRVQlWQ3Pbtkno2BQCOYpcGNUbIi6+fFOGqgiD+rXOJU6hVygz5it46HlYxYcr3wqe/zVmN6jKMCOUboMINDEt5i1xv/iKSqxANtQUNFqF1dU+BwuC4ijqoDVBkLyGPkan1+n7WVG0LxgESUBFus89mLePof9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j4UXBsYSBGojZXA4u14HCQDH/Cv25g8QpGJT1Fubic=;
 b=ghumuOavAi1D3Ib976xUDR3WW6R7tKLaFa+A/mzD2c+4MW7u9HiqetY2vFhtSHFotv0LRkoZoans4fBWfNFchLUyrOT38PPMmKw0IcjlzKGbtW1YTHSXGsGNKMFZGMkJFd7QNXGfjZbDMyXDHwWBPiAKIfRZz2YJbQfNHAy9rmlwxn4t3Zx5uCl08E4ksVavx55/YOsRRBUgo7C0NW3LWWU+vDnXueVR6zLtgKDkx8iXUp3n81uN8kr14iP3sK0UusCZza75Ucx04chD0/c1O2Ve+zqpZcnjM3mkGKuOiNx6iEBsjNo4YllI+9B5ley+L7yPYHOK3o63J7+2p1iagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j4UXBsYSBGojZXA4u14HCQDH/Cv25g8QpGJT1Fubic=;
 b=dTuLeidR1J6dc3SR9CEoa1bGGM29GHHCgdUKL+OsojlTSN+M5z2epkJ2/rEPs3Va3P/fOktwg8cbEA7+i6NrmssY5A4V215DfmneGgUYzgagsGv3Kk2UYvm4GAZ193QD6PDusSKL551pjBx6VDr2sDtH0O0wMpeuijtdoxkh6Xo=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 11:14:35 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 11:14:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Thread-Topic: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Thread-Index: AQHXX4q0hWf55kqEaUikJcAamP0XDqsT0TkAgBWJCYCAAAPQEA==
Date:   Mon, 28 Jun 2021 11:14:35 +0000
Message-ID: <DB6PR0402MB27603801C9017F05393DDFAB88039@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210612133134.2738-1-peng.fan@oss.nxp.com>
 <20210612133134.2738-5-peng.fan@oss.nxp.com>
 <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
 <2c39672b-780a-8e33-038e-0856e32ede7a@denx.de>
In-Reply-To: <2c39672b-780a-8e33-038e-0856e32ede7a@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1359334b-96bc-4ac3-1afd-08d93a25e99d
x-ms-traffictypediagnostic: DBBPR04MB7659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB7659D2471CF8DF5AEBA68EB388039@DBBPR04MB7659.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7PMLnOXukUDuH3aekkRJb+DHg6347S+v5+DptLxldSTTkv2hmLWYqGUaPS+L/lYYTvva6GslFJX4HFzLhLvxn4Dvnu5ziIy9WB4ivPszuT/B1C3UqmlP1e6pPld8FOAs6uKrZEQsKG74l2yeGGGCA/qYW36DsJjwL0s2c1YOeoNqgXMbw608L9fdsSS8un0Hv8xiiIvl29gF+1Fuop2rhm+tPRSFSqPbn6ssuwGH8exyHJGTxO1lHcO6tak0JR1nB1Dsk+Z2VebewBwisQdYNpBLaGu9fhpNVIVfvrdob32uE/7vN1nD+6a0x1kfuMe49WOKpMyYuUJatCWrjYKvDRI53/d7Ju09F4Lxgj8tmLrQWfZQ3E/0LaUO6DoTYgCF4SyOM/TVtc7AXWAQSEEZ5z+0xZSwvcqYW7MS1DZuHMJe4MQlcApLS8Yned7Ipy216VYspzD3P9YRufI8e9/ur1FdYvH9q2myJf4PRevPirzx15MkdvU9xWoAhVIRkHQe0dz44B72/8lQgppGhFkhGXMi2XKjF8rZYal5SAGsTqyyawsMUSXjMKUawowTtaBrnKUDB73vKJk3OB4cJDb7A0vQsX0sq4jxqJjVV1R3CLrf/BsAtcZI3DhsT/LsHTlfDSuFA7n5PSC5XkatFHeKxJev8lewMCm8R2/hLIJR1oRWCfRCTOZTZZSE16ZPqZBIZQJFJaKOHFcjjbrKm6o1EMsoz3Ex8klFbPgJllt3F33nLMeJTLTE2Ckouoynbx6wujPQtq4nMLx0NiArRiDMoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(186003)(8676002)(83380400001)(86362001)(54906003)(9686003)(5660300002)(44832011)(53546011)(66476007)(52536014)(33656002)(71200400001)(55016002)(6506007)(66446008)(64756008)(66556008)(110136005)(26005)(7416002)(66946007)(8936002)(45080400002)(966005)(478600001)(4326008)(2906002)(122000001)(7696005)(76116006)(38100700002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?skoTdTVG1Fm2Hz+FwvpBQphA+jTEeIJrTh5DkKHOflszk9Dz510K/edH4m?=
 =?iso-8859-1?Q?e4gaa7u9HXOeLJ93DHCEtDc5LuXMZc1MI+1PHatchdCQejbX4vtVWZytuN?=
 =?iso-8859-1?Q?OgSr4CiSGcxXuNaH+6XwQRCwIRITI2VbHrg2strhU32H1OUYlwsl5BP4mO?=
 =?iso-8859-1?Q?O9WRA6GiS9OK5LtJ6GaXyd18x2yd7ZIJoT7FFvaVyXyrjD/by8hrm62U8b?=
 =?iso-8859-1?Q?QlSW4KEtdTPYYa6NxyHSNhruiVwRG4rlQ6YqzUGBKgxHUjn5WqvToKLazz?=
 =?iso-8859-1?Q?ZsUJRSuyO7Q5NiDsMSYURaR1yKGlgplZvV48fPb1M7BTB6lL0ooS7eiOh+?=
 =?iso-8859-1?Q?2WwIWI1pEthCVG8OC4S/C32opiEYrVWQv7hoiq3/BS81R7RHVFow5rbgvE?=
 =?iso-8859-1?Q?gGuNo64VrMjVSh4hq4qRLPX3QALaE0aQMWTFvJ7nylv0hE7fth9P5oVLmM?=
 =?iso-8859-1?Q?DkvUkTU0oFdOdNNEChTtYoygQcSCOb3lXf5UoruTDno5HBKXtd7/WGWzkz?=
 =?iso-8859-1?Q?RkaQ99zPHDxMo7BXylA4HHQMpT99itKBoLXxbG1ye4Dbut1ICUwqtGsi5E?=
 =?iso-8859-1?Q?jXpSfFrDZlKCbtLy2FF+M9rGB66rFke5cD2VP9ZrjMkhP1u0u6LgpTj1qK?=
 =?iso-8859-1?Q?DGZWPs+wTpScz3RQ9L7UmmuM1lq/eLF3aA10mEQmKcaOGZfbhY5vms3OzC?=
 =?iso-8859-1?Q?xCGWnU476yv9VZwmswinPuxlA2YEgxZuIqLzgdVegHC5SKBb5teNRq2kPP?=
 =?iso-8859-1?Q?tHJncsezEsbY71e0zYXB3Ah46MWskJgFJhEkmgZ+Bxur5QxLIPjPZLQ/FS?=
 =?iso-8859-1?Q?vAgrB05/0gA/pAf+//ZkWbuJW9+Ni3qoUDOqGAKcF1DUaFUuebL0aBg9sY?=
 =?iso-8859-1?Q?7KbqLWL/Q3fv9tAexmJIGrWltfgy0sBrlR4JbPWmzJqmMLlFVBii5NNInX?=
 =?iso-8859-1?Q?Wlp79JCVLrrhCjgonPiLC+z3bu9J+7Q1I/sR3/MVmn7oEt27HDcH9Y5PNj?=
 =?iso-8859-1?Q?K13kETmfFxxpli44aICgTgu5ZmPE/IzhYWDtxm6Ool59FIu9J1dqbx3/Rj?=
 =?iso-8859-1?Q?/aE5d/3DLTtJgl1CkYrIpv3w3jLcJwrvWVjXOhH7jyQ5dHx6ppuIB423pD?=
 =?iso-8859-1?Q?CKJazTSVy7x6nB8lupxccnxclMcUnTee6wYylKBs3lTmyDz0oSoxoT99TD?=
 =?iso-8859-1?Q?Xin+bUJJkuSx7UuXVmTp13KO1dPU0lhq4smg5fWw68cKqFMPTs4KxsVM1r?=
 =?iso-8859-1?Q?BKM24tXMDH85gLHa0X5U4EVeZVRqIPUWkphjiXVLA94wtKrrM9zgNna6gR?=
 =?iso-8859-1?Q?tTKlcEYJxKcwM2qQ4R/ZoDGCVTRTgZlhpt/3UmAm/0lIeE8fTe0Ecehh8/?=
 =?iso-8859-1?Q?dxP1z2FioS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1359334b-96bc-4ac3-1afd-08d93a25e99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 11:14:35.6214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diijVgggp72D/YrinLld9NFbVkiMf6Y6k7MRZQg9jIwv3KyUrJsb4PC9vi7XqNqIfCMX/iUnoCXOy6OCf1nm3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
>=20
> On 6/14/21 8:07 PM, Adam Ford wrote:
> > On Sat, Jun 12, 2021 at 7:58 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> wrote:
> >>
> >> From: Peng Fan <peng.fan@nxp.com>
> >>
> >> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
> >> that support in this driver.
> >>
> >> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >
> > Maybe my TF-A is too old, but I am not able to wake the device from
> > suspend-to-ram with this series.  I used the device tree from [1] to
> > enable both the GPCv2 and the blk-ctl stuff.
> >
> > [1] -
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20210604111
> 005
> > .6804-1-peng.fan%40oss.nxp.com%2F&amp;data=3D04%7C01%7Cpeng.fan%4
> 0nxp.co
> >
> m%7Ca4c06cfdf6314633c7c708d93a23cff0%7C686ea1d3bc2b4c6fa92cd99c
> 5c30163
> >
> 5%7C0%7C0%7C637604747755701757%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjA
> >
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s
> data=3D0
> > pDwVtfizZ7mZh9pSfy0bSbffOxP90AnaQrZ8i8cNv0%3D&amp;reserved=3D0
> >
> > I based both off Shawn's for-next branch.
>=20
> I also ran into issues with this, although it could also be related to GP=
Cv2. On
> MX8MM , the system sometimes hangs when bringing up the GPCv2 power
> domain 6 (VPUMIX). It seems that the GPCv2 driver sets
> GPC_PU_PGC_SW_PUP_REQ register to 0x100 to bring up the VPUMIX and
> the bit never self-clears. After that, it seems the entire GPC locks up.
> Have you ever seen that kind of behavior ?

Do you have clk enabled for vpumix? Is this issue happends every time? Or h=
ard
to reproduce?

Thanks,
Peng.

