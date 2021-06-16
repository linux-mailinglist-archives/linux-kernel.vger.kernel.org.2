Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4160F3A9855
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhFPLAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:00:30 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:52193
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231672AbhFPLA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:00:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRC0bakX71IFafNw52sUV0/EXcc13tqSJMWR2K76KI/zDpkx5lJYKGugmMQNu3nf3YV7GTjXwZVVNUSro6rexLUjzN9ixHLvpA3Vx+qFhveZHvHoxg5PWplQpC0GdPa1YCKNIa154Xa21Al8fFT781i7gepgIYA3j8XeYePf049cgxHO4BtlAZ/5drWwHjyGW5lDor7ph2XfCLFyGONOtaR/0YRETcGgD1elRN6V5IgVGjgOSRIOQWgbum3+PVHV/XaFjvKDWu31HLi4EBmIhbN83bXkAowlki2GsoR7L7Xlc1As3SpHMP1A6QLP9c7UvduaNNmYgeGMtz+TYT91kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jElLeDRWUxVyvoBeuPq8LdRZ09h6sQ35orCZbfqAGs=;
 b=GqLSd3KJyxiSP01lHZXNpVpVYbGTivds9kLofqhfQx1G1bm3JzIEnk967sq7bO9wCIE9+a3i3i/QMh64Rq/jasv7BVstM17kLl7V/efFZrzl4J7kmmCRGJz0Cw4LAmEJ8iMr8LSc0TaL6xFFf70OKhkj1rmJhV+o0Ax5P6tNT++7BcXQvwczODfUw77UB368FAzvOJ/YEm43CvvquV9/tjv342Wp0oQiXEUgyZuFyfY8lry/4htx0RVPYHbXmf1RfVLidNqaR2fAiaXFr953itSWkZy/5mHqv4syXQ0LXxXUoxUyuJxaQ132zyl8Ikm2ayRQP+PmgAgEGzBXOSdz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jElLeDRWUxVyvoBeuPq8LdRZ09h6sQ35orCZbfqAGs=;
 b=ViE0R+Ecst9nGbbzGCtfmCweghHuC47MmbNkk/o9vU6r8VmFXwBW5VgMZN5v8jw0+T8BEPK8kzjgqE+UmlbCWJ5Z+XzIcUISgxOi3LkqX8iq/7JguhrBjc+ZQHIRPNKyQeS31jmCg64AjSFJyZsR2VhoVmlL/bLoPmtvFupEEMM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2535.eurprd04.prod.outlook.com (2603:10a6:4:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 10:58:15 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Wed, 16 Jun 2021
 10:58:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     Adam Ford <aford173@gmail.com>,
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
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Thread-Topic: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Thread-Index: AQHXX4q0hWf55kqEaUikJcAamP0XDqsT0TkAgAAWxgCAAQWlAIABiZQAgAAGDoA=
Date:   Wed, 16 Jun 2021 10:58:15 +0000
Message-ID: <DB6PR0402MB27608C44199481EC6E53A9BF880F9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210612133134.2738-1-peng.fan@oss.nxp.com>
 <20210612133134.2738-5-peng.fan@oss.nxp.com>
 <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
 <CAHCN7xK86pdcx_BouriGTchnBdamNN1Cjjh-UuF-Oy=abq7rrw@mail.gmail.com>
 <7683ab0b-f905-dff1-aa4f-76ad638da568@oss.nxp.com>
 <CAHCN7xLZZSwbjrUTb6uBOqWYWJdS_+nSr+iPDnh+dNLFSQOuLQ@mail.gmail.com>
In-Reply-To: <CAHCN7xLZZSwbjrUTb6uBOqWYWJdS_+nSr+iPDnh+dNLFSQOuLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f73bb51-3894-4230-ed3d-08d930b5a487
x-ms-traffictypediagnostic: DB6PR0401MB2535:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB253552D9C2C3130A6CD51D1AC90F9@DB6PR0401MB2535.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FoAuPSfTx6zx6/xcwV5kmuUz92Wn9ck1gXZnab9rQyvdH80qDk1Y3MqQaskFQ/WFKD1Xx2F/dZ1IwYN8HnBRrK5NVmUp52gVhXQqCoJBGS0i9tfv1fk8i/g65wPlamQFsckt3Z4D433UhYWkzdfzdLLT/VuMNj/iiN245fAiuqM54Kre5+LuUSCDMT2TDFynDHkY7ONJERIaomp8KBWwsAtgmwtVhmsbbw0xKw9SwAKpbv7bzrtTAr8dJFaNoGwiydmM3m07l+MVmYPjyycyolyQp68QJ8u2SgsLdoq5Lve2hD06t9EjzhhIR3VKbEc7DCPOF2IZyUsnsyswh772ny09PlF97QV9g6x713rj9o+z4Wty+awBdP3BEdxkcgcrixlacQ5t0BLl3XbHEQtkrxv61W6z6MYnhYqGL3zI+NDhS4FYcy328cwbjtP7J5Hpia2M/RqXpU5HpLML/x4QwancVeRMRKcb9Ul4lAai88zsNrfWO7SZ3FiweTrIZRwDBNbMl9SoV68HZTKUITWmI0qDJCV0a/cr3phQ+lsUVQiHvyvBLxLO/NHog8JUWIqPW5Ih2jaRYRr2ifHivaLlkrIfqducj6u9+x0DpyO5a2BTURmzQSpcEnFhFp6/FYsF9PphATf2gFUA2ykl3XZKiiuyFj7sQPMRLLfBwj0obDFtAwa1qfLjtO8VvqENmTJyPZr79lvCMaEFmC6zDpsW2mb2XanyidleEwN0sa5+Tn3AG5YLAGSxa4zpT5mtmLInQkZv+kelJf2CS4mqz0QCPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39850400004)(346002)(396003)(45080400002)(7696005)(966005)(26005)(52536014)(4326008)(316002)(7416002)(30864003)(110136005)(186003)(8936002)(8676002)(86362001)(6506007)(53546011)(71200400001)(5660300002)(54906003)(478600001)(83380400001)(2906002)(64756008)(33656002)(55016002)(66946007)(76116006)(9686003)(38100700002)(122000001)(66556008)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+gXMBdIDo4zoqe/IFD2MUT+w6RrCtda4g79tgpRBYV8BEUuGOaLFQ2vDcZ?=
 =?iso-8859-1?Q?9L26g8Q96SqRpjaWjz3jlLu+L3B5qEz3RrD+ysIMlzMXDGn9Hd4CH3m4q6?=
 =?iso-8859-1?Q?JEbr7jPh3HYWspGMsXG9auxuE6H4T7vBqnl2j81/+kVJ1P+dRajBrRU0mS?=
 =?iso-8859-1?Q?9R4mhZKu4aA0JpX9nApFxNi/JZQTEJwLhm5qGncZb7jDmxWyoJ3vKnbOLs?=
 =?iso-8859-1?Q?Yxgyp78gMrU8+TNFxAuFOHxsrA8/0DznFwhZIYpGLojUYUGlpBD1RxH5Vd?=
 =?iso-8859-1?Q?dHMjgfELe65y7q0qOl8O0ie7KmWAVQJJFWzbpWvJoh+Iz25jvm+Yl41E2Q?=
 =?iso-8859-1?Q?a9HX1SV99z6q9ajgdENEWeTOacsXEuPsMGFzu+MxHeosAY0QSQhsdRn7XZ?=
 =?iso-8859-1?Q?Vd4m7IcOd7d9H0O8bP9FwYfxW/hwH4/YKkBt3sLFhHH5S9eUfPhkReIj6g?=
 =?iso-8859-1?Q?roYs0mPI6/AuJ5KxuBMEyI6JWrKmobC6bo9ltoDTA/2lVmokHI+lvyyCcw?=
 =?iso-8859-1?Q?BnpFdz3BXTwThIeS+EBC3Zv47kXuhsZboYcZYU1PU+rqGQVe5OWEW5HYKb?=
 =?iso-8859-1?Q?EOg1Ov3sH57VZKeJpquzJfQKG52dh6kD2kjEzmnAb0C3AR50qAsW/5WoL7?=
 =?iso-8859-1?Q?9HMd9L9Xkt8bTvZFDIfUOiK64je+HhzKSok/tMDz3mUH5BuGaDunM1OjMb?=
 =?iso-8859-1?Q?qIT/uYmiDLrEtg+fHvX3nC9fuSgrlkPlD0dKv/X40pv+24clDZzqsW4VlT?=
 =?iso-8859-1?Q?fZ9spL+wkM4IPv6my/PARFcuZUeOQJYwpTOG4BluyQsQtHXmhw+Zn+6AmM?=
 =?iso-8859-1?Q?SDJMMOyzSWO6qJDWYfFTTEw5uqbTekpmpO4sxZ7p8bAYzEe/J26Pcd/ADZ?=
 =?iso-8859-1?Q?Ee9UH4y/xIDoU6Ejdm6FUH16edH4eJy4IMMZOvz445t+REWj9D7ib+Slsy?=
 =?iso-8859-1?Q?7IClDMQIlt4sr/DS+WNHEXeQ2yHOl5OopMacDlT/RjFYsHu5775G5G7KIV?=
 =?iso-8859-1?Q?o8LHp7/g5AoTOEybUEJlWbqWp5+e1CQSDglAoh06gxKy6h5hgb3wnCO1e9?=
 =?iso-8859-1?Q?JoZj9nH8F6s05XXTvghXupMVoR1zs5GSUbhHnI1W7Lf8kpyGlv9ZfDuEqT?=
 =?iso-8859-1?Q?tph2+y83W+qKGVkuK3pWO3aiTLdGKriI0dSPFmjM5KHYAr4ghtozPHWMuL?=
 =?iso-8859-1?Q?oKoJc2k8/l4nzT6T8pyWyv0Z74upOez3e3M0fSS1OUdltouPiy+NPGUuUF?=
 =?iso-8859-1?Q?Vp0JnNwmM+ShAnRD4KvF6p8NE0PYVEknuhvsCoCUrbhmz1IlwIZ1+OVSvd?=
 =?iso-8859-1?Q?gHdxEf0NF6nIIuU1Lo8O8XU/OIv/zEuEyH+dgnyna4l0+bDX6wDZkMfJH3?=
 =?iso-8859-1?Q?UudumJxLq7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f73bb51-3894-4230-ed3d-08d930b5a487
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 10:58:15.5212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LX00lGkmkDaF3uoyMvelUPdChoJnKmebHvCzJSXsjXalq+4k8jlfItLtr0XWh6w7kTpVyQhOF8ccwvibHo8MjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2535
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
>=20
> On Tue, Jun 15, 2021 at 6:05 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> wrote:
> >
> >
> > On 2021/6/15 3:29, Adam Ford wrote:
> > > On Mon, Jun 14, 2021 at 1:07 PM Adam Ford <aford173@gmail.com>
> wrote:
> > >>
> > >> On Sat, Jun 12, 2021 at 7:58 AM Peng Fan (OSS) <peng.fan@oss.nxp.com=
>
> wrote:
> > >>>
> > >>> From: Peng Fan <peng.fan@nxp.com>
> > >>>
> > >>> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we
> add
> > >>> that support in this driver.
> > >>>
> > >>> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> > >>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >>
> > >> Maybe my TF-A is too old, but I am not able to wake the device from
> > >> suspend-to-ram with this series.  I used the device tree from [1]
> > >> to enable both the GPCv2 and the blk-ctl stuff.
> > >>
> > >> [1] -
> > >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
p
> > >>
> atchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20210604
> > >>
> 111005.6804-1-peng.fan%40oss.nxp.com%2F&amp;data=3D04%7C01%7Cpeng.
> fan
> > >> %40nxp.com%7C29fe5fa2af704121c2d508d930b25126%7C686ea1d3bc
> 2b4c6fa92
> > >>
> cd99c5c301635%7C0%7C0%7C637594364693096718%7CUnknown%7CTWF
> pbGZsb3d8
> > >>
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%
> > >>
> 7C1000&amp;sdata=3DowV810qvJWHnaoav%2BZDlpd%2FmjALiZkk0uWM44gqj
> jQ8%3D
> > >> &amp;reserved=3D0
> > >>
> > >> I based both off Shawn's for-next branch.
> > >
> > > I tried to enable USB with the GPCv2 stuff pulled into Shawn's
> > > for-next branch, and my board hangs when USB is loaded, but USB
> > > doesn't use blk-ctl, it just uses GPCv2.
> > >
> > > I looked at some of the changes with GPCv2, and I noticed a comment
> > > in the GPCv2 function called imx_pgc_power_up.  The comment reads:
> > >
> > > /*
> > > * ret =3D regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
> reg_val,
> > > *   (reg_val & domain->bits.hskack), 0,
> > > *   USEC_PER_MSEC);
> > > * Technically we need the commented code to wait handshake. But that
> > > needs
> > > * the BLK-CTL module BUS clk-en bit being set.
> > > *
> > > * There is a separate BLK-CTL module and we will have such a driver
> > > for it,
> > > * that driver will set the BUS clk-en bit and handshake will be
> > > triggered
> > > * automatically there. Just add a delay and suppose the handshake
> > > finish
> > > * after that.
> > > */
> > >
> > > I didn't see a delay here despite the comment saying we should add on=
e.
> > >
> > > With the blk-ctl enabled, I attempted to uncomment the above line of
> > > code without much success in preventing the board from hanging.
> > >
> > > If BUS clk-en bit needs to be set in order for the handshake to
> > > work, should all these power domains reference it to bring it up?
> > > If we decide against using the BUS clk-en bit, what should this delay=
 be?
> >
> > It is only for power domain has mix and need delay for the handshake.
> > USB no need that handshake.
>=20
> Don't the OTG domains depend on hsiomix?

Sorry, I mean hsiomix has no blkctl. It no need handshake and no pu for hsi=
omix.

>=20
> >
> > Could you post a github branch, then I could give a look?
>=20
> No problem.

I'll give a try. Per my try, I tested VPU/DISP which are complicated cases,=
 for usb,
actually it has nothing to do with blk-ctl, it should be gpcv2 handling has=
 issue.

Thanks,
Peng.
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.
> com%2Faford173%2Flinux%2Ftree%2Ffor-next&amp;data=3D04%7C01%7Cpen
> g.fan%40nxp.com%7C29fe5fa2af704121c2d508d930b25126%7C686ea1d3bc
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C637594364693106714%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6tiEiL7TMioVeb88WKHTYxVPxE
> MT1pboN%2FSMxiKA1yM%3D&amp;reserved=3D0
>=20
> thanks
>=20
> adam
>=20
> >
> > Thanks,
> > Peng.
> >
> > >
> > > adam
> > >>
> > >> adam
> > >>
> > >>> ---
> > >>>   drivers/soc/imx/Makefile         |   2 +-
> > >>>   drivers/soc/imx/blk-ctl-imx8mm.c | 139
> +++++++++++++++++++++++++++++++
> > >>>   2 files changed, 140 insertions(+), 1 deletion(-)
> > >>>   create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
> > >>>
> > >>> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> > >>> index d3d2b49a386c..c260b962f495 100644
> > >>> --- a/drivers/soc/imx/Makefile
> > >>> +++ b/drivers/soc/imx/Makefile
> > >>> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) +=3D soc-imx.o
> > >>>   endif
> > >>>   obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
> > >>>   obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
> > >>> -obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o blk-ctl.o
> > >>> +obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o blk-ctl.o
> blk-ctl-imx8mm.o
> > >>> diff --git a/drivers/soc/imx/blk-ctl-imx8mm.c
> > >>> b/drivers/soc/imx/blk-ctl-imx8mm.c
> > >>> new file mode 100644
> > >>> index 000000000000..59443588f892
> > >>> --- /dev/null
> > >>> +++ b/drivers/soc/imx/blk-ctl-imx8mm.c
> > >>> @@ -0,0 +1,139 @@
> > >>> +// SPDX-License-Identifier: GPL-2.0
> > >>> +/*
> > >>> + * Copyright 2021 NXP
> > >>> + */
> > >>> +
> > >>> +#include <dt-bindings/clock/imx8mm-clock.h>
> > >>> +#include <dt-bindings/power/imx8mm-power.h>
> > >>> +#include <linux/clk.h>
> > >>> +#include <linux/err.h>
> > >>> +#include <linux/io.h>
> > >>> +#include <linux/module.h>
> > >>> +#include <linux/mutex.h>
> > >>> +#include <linux/of_address.h>
> > >>> +#include <linux/of_device.h>
> > >>> +#include <linux/platform_device.h> #include <linux/slab.h>
> > >>> +#include <linux/types.h> #include <linux/pm_domain.h> #include
> > >>> +<linux/regmap.h>
> > >>> +
> > >>> +#include "blk-ctl.h"
> > >>> +
> > >>> +#define MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN
> BIT(6)
> > >>> +#define MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN
> BIT(5)
> > >>> +#define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN
> BIT(4)
> > >>> +#define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN
> BIT(3)
> > >>> +#define MEDIA_BLK_CSI_BRIDGE_SFT_EN
> GENMASK(2, 0)
> > >>> +
> > >>> +#define MEDIA_BLK_BUS_PD_MASK
> BIT(12)
> > >>> +#define MEDIA_BLK_MIPI_CSI_PD_MASK
> GENMASK(11, 10)
> > >>> +#define MEDIA_BLK_MIPI_DSI_PD_MASK
> GENMASK(9, 8)
> > >>> +#define MEDIA_BLK_LCDIF_PD_MASK
> GENMASK(7, 6)
> > >>> +#define MEDIA_BLK_CSI_BRIDGE_PD_MASK
> GENMASK(5, 0)
> > >>> +
> > >>> +static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] =3D {
> > >>> +       IMX_BLK_CTL_PD("CSI_BRIDGE", NULL,
> IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE, 0x4,
> > >>> +                      MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0,
> MEDIA_BLK_CSI_BRIDGE_SFT_EN,
> > >>> +                      IMX_BLK_CTL_PD_RESET),
> > >>> +       IMX_BLK_CTL_PD("LCDIF", NULL,
> IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF, 0x4,
> > >>> +                      MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
> > >>> +       IMX_BLK_CTL_PD("MIPI_DSI", "mipi",
> IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
> > >>> +                      MEDIA_BLK_MIPI_DSI_PD_MASK, 0,
> MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
> > >>> +                      IMX_BLK_CTL_PD_RESET),
> > >>> +       IMX_BLK_CTL_PD("MIPI_CSI", "mipi",
> IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
> > >>> +                      MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
> > >>> +
> MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN |
> MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
> > >>> +                      IMX_BLK_CTL_PD_RESET),
> > >>> +       IMX_BLK_CTL_PD("DISPMIX_BUS", "dispmix",
> IMX8MM_BLK_CTL_PD_DISPMIX_BUS, 0x4,
> > >>> +                      MEDIA_BLK_BUS_PD_MASK, 0,
> MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
> > >>> +                      IMX_BLK_CTL_PD_HANDSHAKE |
> > >>> +IMX_BLK_CTL_PD_RESET) };
> > >>> +
> > >>> +static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] =3D {
> > >>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2",
> IMX8MM_BLK_CTL_PD_VPU_G2, 0x4,
> > >>> +                      BIT(0), 0, BIT(0),
> IMX_BLK_CTL_PD_RESET),
> > >>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1",
> IMX8MM_BLK_CTL_PD_VPU_G1, 0x4,
> > >>> +                      BIT(1), 0, BIT(1),
> IMX_BLK_CTL_PD_RESET),
> > >>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1",
> IMX8MM_BLK_CTL_PD_VPU_H1, 0x4,
> > >>> +                      BIT(2), 0, BIT(2),
> IMX_BLK_CTL_PD_RESET),
> > >>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_BUS", "vpumix",
> IMX8MM_BLK_CTL_PD_VPU_BUS, 0x4,
> > >>> +                      BIT(2), 0, BIT(2),
> IMX_BLK_CTL_PD_HANDSHAKE
> > >>> +| IMX_BLK_CTL_PD_RESET) };
> > >>> +
> > >>> +static const struct regmap_config imx8mm_blk_ctl_regmap_config =3D=
 {
> > >>> +       .reg_bits               =3D 32,
> > >>> +       .reg_stride             =3D 4,
> > >>> +       .val_bits               =3D 32,
> > >>> +       .max_register           =3D 0x30,
> > >>> +       .fast_io                =3D true,
> > >>> +};
> > >>> +
> > >>> +static const struct imx_blk_ctl_dev_data
> imx8mm_vpumix_blk_ctl_dev_data =3D {
> > >>> +       .pds =3D imx8mm_vpumix_blk_ctl_pds,
> > >>> +       .pds_num =3D ARRAY_SIZE(imx8mm_vpumix_blk_ctl_pds),
> > >>> +       .max_num =3D IMX8MM_BLK_CTL_PD_VPU_MAX,
> > >>> +       .hw_hsk =3D &imx8mm_vpumix_blk_ctl_pds[3],
> > >>> +       .config =3D imx8mm_blk_ctl_regmap_config,
> > >>> +       .name =3D "imx-vpumix-blk-ctl", };
> > >>> +
> > >>> +static const struct imx_blk_ctl_dev_data
> imx8mm_dispmix_blk_ctl_dev_data =3D {
> > >>> +       .pds =3D imx8mm_dispmix_blk_ctl_pds,
> > >>> +       .pds_num =3D ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
> > >>> +       .max_num =3D IMX8MM_BLK_CTL_PD_DISPMIX_MAX,
> > >>> +       .hw_hsk =3D &imx8mm_dispmix_blk_ctl_pds[4],
> > >>> +       .config =3D imx8mm_blk_ctl_regmap_config,
> > >>> +       .name =3D "imx-dispmix-blk-ctl", };
> > >>> +
> > >>> +static int imx8mm_blk_ctl_probe(struct platform_device *pdev) {
> > >>> +       struct device *dev =3D &pdev->dev;
> > >>> +       const struct imx_blk_ctl_dev_data *dev_data =3D
> of_device_get_match_data(dev);
> > >>> +       struct regmap *regmap;
> > >>> +       struct imx_blk_ctl *ctl;
> > >>> +       void __iomem *base;
> > >>> +
> > >>> +       ctl =3D devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
> > >>> +       if (!ctl)
> > >>> +               return -ENOMEM;
> > >>> +
> > >>> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> > >>> +       if (IS_ERR(base))
> > >>> +               return PTR_ERR(base);
> > >>> +
> > >>> +       regmap =3D devm_regmap_init_mmio(dev, base,
> &dev_data->config);
> > >>> +       if (IS_ERR(regmap))
> > >>> +               return PTR_ERR(regmap);
> > >>> +
> > >>> +       ctl->regmap =3D regmap;
> > >>> +       ctl->dev =3D dev;
> > >>> +       mutex_init(&ctl->lock);
> > >>> +
> > >>> +       ctl->num_clks =3D devm_clk_bulk_get_all(dev, &ctl->clks);
> > >>> +       if (ctl->num_clks < 0)
> > >>> +               return ctl->num_clks;
> > >>> +
> > >>> +       dev_set_drvdata(dev, ctl);
> > >>> +       ctl->dev_data =3D dev_data;
> > >>> +
> > >>> +       return imx_blk_ctl_register(dev); }
> > >>> +
> > >>> +static const struct of_device_id imx_blk_ctl_of_match[] =3D {
> > >>> +       { .compatible =3D "fsl,imx8mm-vpumix-blk-ctl", .data =3D
> &imx8mm_vpumix_blk_ctl_dev_data },
> > >>> +       { .compatible =3D "fsl,imx8mm-dispmix-blk-ctl", .data =3D
> &imx8mm_dispmix_blk_ctl_dev_data },
> > >>> +       { /* Sentinel */ }
> > >>> +};
> > >>> +MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
> > >>> +
> > >>> +static struct platform_driver imx_blk_ctl_driver =3D {
> > >>> +       .probe =3D imx8mm_blk_ctl_probe,
> > >>> +       .driver =3D {
> > >>> +               .name =3D "imx8mm-blk-ctl",
> > >>> +               .of_match_table =3D
> of_match_ptr(imx_blk_ctl_of_match),
> > >>> +               .pm =3D &imx_blk_ctl_pm_ops,
> > >>> +       },
> > >>> +};
> > >>> +module_platform_driver(imx_blk_ctl_driver);
> > >>> --
> > >>> 2.30.0
> > >>>
