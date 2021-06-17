Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835753AA96F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 05:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFQDQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 23:16:17 -0400
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:30943
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230052AbhFQDQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 23:16:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMetSDoscQZctRq7IX1G0VwWgacRNzqiqaHlqYwd/r+oNaKtgUwaJDI9nqejBQMg/TLUg4YLqLpjAASiTtNY64GqJgOtENbys/q5p8LMq4FYEO9+0FLJBIlPMej9XIdWZT5XMzya6qHazRt1/EitQxDG3kLPKAMra+I13r1Ro/9ktjzJ8DSsKlJKxMZVQc9NPI2JqmakITmj6bDhFk1y+W2HW0UgE3akHe3b1zJMjqiqaJX73OKXqmeqtc+odBmsQh4i2kcecnI7eJs1rSvnPeG0vUcpwcH2d/8RKaZlIGlj7OACzeSqgqcrRK2jVQSENXTL7RSo6tkRjOc+URjbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLCH2LWdCf827SkgFy/SAaOXvgMgCx7lKVXOFmTGLcM=;
 b=W5CgvF+adpEL0RwZmyEkx1IStSotzTn4pP4DWsxqEO2apE433doioOV/LuVx8pJb2Vt1WR0D2aTE83ba4E8UkBU3BZH4cdkss4Sb5NbaNdVKbkS5pZY51wdQaAmrjTbGaKnzq4mIdwUIiETQq9pzOqMLqhfMz6kzWLzOjuyy0DMjD0Ou4fmkZ8ZFx/HJAD6HbpXkV6Uf4omxB2FOsJlviKdy+SvoR4x5sCivHnEwz/4kGOumX749Hs7fddgD1gI/kqDQh2haTNswOJLGSp5cPIkI2rM09nSRLHNV64zi17lleITHqHTsBz+WrkLae8woeN8OHdIG1CS259nK8e27rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLCH2LWdCf827SkgFy/SAaOXvgMgCx7lKVXOFmTGLcM=;
 b=lgZbmyjkCzHhgNL16zrdjj+r7gV75k9BQWIAceO28Lmy12nMjjNcC1KuEg6kvFOmPG/fT5rFPBFLJNwqXVM14TGP5r4AtjvSCBa0gVqGPoPVu6KlKVufE21g+zEcce9Tukt0rcCu9LVrMuq4n2ir7IiVltJN8dNXbme797VW3jU=
Received: from AM5PR0402MB2756.eurprd04.prod.outlook.com
 (2603:10a6:203:99::22) by AM5PR04MB3204.eurprd04.prod.outlook.com
 (2603:10a6:206:4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 03:14:05 +0000
Received: from AM5PR0402MB2756.eurprd04.prod.outlook.com
 ([fe80::60a1:5e04:4be9:9f29]) by AM5PR0402MB2756.eurprd04.prod.outlook.com
 ([fe80::60a1:5e04:4be9:9f29%6]) with mapi id 15.20.4219.024; Thu, 17 Jun 2021
 03:14:05 +0000
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
Thread-Index: AQHXX4q0hWf55kqEaUikJcAamP0XDqsT0TkAgAAWxgCAAQWlAIABiZQAgAEVUaA=
Date:   Thu, 17 Jun 2021 03:14:05 +0000
Message-ID: <AM5PR0402MB2756584781B774A75378D28F880E9@AM5PR0402MB2756.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: fef587e7-5410-414d-3815-08d9313df717
x-ms-traffictypediagnostic: AM5PR04MB3204:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB320414F1386C4B7C7FCD6D8AC90E9@AM5PR04MB3204.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5Xmj6znthd5iJMQaiW53s4YDM+zHA8c86O0p50wmMta11rBCn+41zB3PeCaMvNCVLkIQYsHhFqPY7KSCSqG6WvDsleK7n6Fs1VAOIlF5q2IPGP7n3aN6lKZEbeJ6MbzC8zXfmv4VZ2X/eTBxuzY8VgpMDuT9jqcqsrzq2in9l0T3O4Zc/y11uE1tSgv8fbfJ/Po8SCYTKQDR2YXbdvq1N9et1flV4ONFiO8WB0SCfnsB9SEiUosdmpJhi5LHQowkb1Fla4x5MGehNkDOr52oOs5OCeM3CmD/b5M7J/CgCWoIN1FrOjQt8lRNN8tHupbqp4YB9KOvkWd0nPoBMK7KLQzQVDTaKcjPCKy6DJKU63DPdm9rXPngdhnvawvuLlQbnBFOm8QgtXVXgP6XpCbnXN1n+Cf6GYzV+Y9nUl6rcc/WLlpiU0e9BjPJB4OHvj2QnqEOu4ZXHwV4JlslNtGqKePA5Ok5xf1N6ab1YMlWyDxBqNAMGsCPTBUGGNI9ei4b+hiiwYd4mqMBkz5OkH6CZDcE9RoHjqI/5vnq/m6cQfwsv09FYSNaDWoc0Ln2DhwWBKzo/mTclCJsppIYkYFhO4k+jtBEsQISx6AVOedfQVzC1VkxfbLy5YzycvmaHEiYTtBkuw9yL86n6RK0B1qOIGX279LdHx62me4TCl+5Cchy9ROGfrYuhlmC/Ij6W8ySi1BoUtDDduD1RDVhWi5aV+jpCYO4KUZnOvW2M8CBHK+eaR58ZIjztwUnm+ogNmTEQ2hv/QmgezoLUT1AP6Mmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0402MB2756.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(7696005)(478600001)(86362001)(71200400001)(26005)(30864003)(966005)(45080400002)(6506007)(110136005)(122000001)(54906003)(186003)(33656002)(38100700002)(8936002)(4326008)(316002)(64756008)(2906002)(76116006)(5660300002)(52536014)(8676002)(9686003)(66476007)(66946007)(66556008)(7416002)(83380400001)(53546011)(66446008)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BeaQoeXp5aRqvbbdv1wxU6U8eMjRcY8V0gZuirACHWjLRWFWzOu0EeFwov?=
 =?iso-8859-1?Q?Lgeo0FfTD1wLuWSqsFH+R6TG7vviUa90AxKTbAYVI6ANqgoui4dZ8GGtBT?=
 =?iso-8859-1?Q?qtxvSq7GbBWQ0K+yTkofdOfDRhlVyAX/L2mn2UGwYBmNKUQm/M7+rA1gFh?=
 =?iso-8859-1?Q?vc9Ub6wUY1YFXPLzf8VrKCUc/pr+Lok+IviKkv1Jk6L38gw0zWP1CSXs9p?=
 =?iso-8859-1?Q?ZxxJKC7c2DZHcw0kS3gNZY1QZLBAoWWdNcoGBfgEKevFW2nbtm4w/w19Sv?=
 =?iso-8859-1?Q?epKpSHst0PDU3nVEiKu6coIBA1zzrV7E7Dbi0l/12epdZYEBsOU28i16Jl?=
 =?iso-8859-1?Q?3vFFB8h2SifZJ/mAA7JBT+6vnGgGtBB1yxSXngMDCM1k1lLfECYbHktPie?=
 =?iso-8859-1?Q?FtQfTTmm6MxSS46MfSlXuPTP0LLSTAJYNiYOEf2UpMg1KSIlIup+bv7Fp+?=
 =?iso-8859-1?Q?FB4/k5Nkpv1pfFTZ66RXPpXPz1krXULvRp0AKRayai3/IFmQWkCMvMQmEt?=
 =?iso-8859-1?Q?MJZkndUJ/Kn9Rhn1LzOfOUO8zcsf34tpVf1KjDymYQHmn6+1fANB+cZFca?=
 =?iso-8859-1?Q?S5n4+ZEVl/73vNsK/yFzFm7HX+GMyXJQTGLj2S4NaXrF2sGfTjHHoQpO8O?=
 =?iso-8859-1?Q?dKzSpk0q0MgTgzHNKJJZnY/oiNQ7UgRmucue7eT5QKw1h9sUH60Avl42qa?=
 =?iso-8859-1?Q?cSSpIYA4Iz8RUdXSzfEvLOpPUOa/6YSQAyFPsQAlN05Fwq4r4vt4RtDbHP?=
 =?iso-8859-1?Q?he9lWH2ntNhxxTTUBysDiiE5s3UHC1Drlv4Uc51XmHUF8F1x/8PUG4RlAf?=
 =?iso-8859-1?Q?nVfoqXPortyxD9DiD8QR7hfi24mWhhboaeEAeuGVKNAoWa9W7WtHiRg3YR?=
 =?iso-8859-1?Q?8Ev8POcfvDppGuHb0sR5I8LmEcAZGt79NRs0v0RSh/YNVB75kLtEHhGjoy?=
 =?iso-8859-1?Q?xVmv+R+5MCuaLztY6LJhwKRckR3ThBOgcvAY3Pwh1UONexW7DnpZWRCSCU?=
 =?iso-8859-1?Q?Jy9N6570O0XKvfUpss4LR0pnuu69XOlPW2oL/0A2zWcVFIo3vpJF4m4MIY?=
 =?iso-8859-1?Q?iax0ItLe145UtXXsU/D4SAHTKl9jPg7ilMmQPvtIlAdGboEK/kwJArO7kc?=
 =?iso-8859-1?Q?h5WPBFaKoaElVDWiNW/gzwOR8692dtNkr9e0xotfkd+VF/Zhs27S7+t8s7?=
 =?iso-8859-1?Q?4xW++d9a3WqNt1yC3SyGuqzEGjort1eyawbO1VN9A95DHBIKToGTImQ7ie?=
 =?iso-8859-1?Q?aCIaHVA5RGf6l/7NoZ1B3QAUNLp1NsUbG6WnQgl355DRLwPPzMROa7Z939?=
 =?iso-8859-1?Q?qE7gMgvwv23haPdVBGHMytbf+97NfECApP+6C2OUVoQEZCOg2lclPk4f47?=
 =?iso-8859-1?Q?fkrRekLF+F?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0402MB2756.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef587e7-5410-414d-3815-08d9313df717
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 03:14:05.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tCssBTJGlvJg5O7TrJHK+eqTAsBxXRSBMJU2nmnWbM+xALfnC16u0ZvLbUQu+438ps84mdeJ3Lx2dlMNBr/QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3204
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


It works well with this change in dtsi.
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mm.dtsi
index 0e01ff649956..e930ae3122ec 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1087,6 +1087,7 @@ usbotg1: usb@32e40000 {
                                assigned-clock-parents =3D <&clk IMX8MM_SYS=
_PLL2_500M>;
                                fsl,usbphy =3D <&usbphynop1>;
                                fsl,usbmisc =3D <&usbmisc1 0>;
+                               power-domains =3D <&pgc_otg1>;
                                status =3D "disabled";
                        };

@@ -1106,6 +1107,7 @@ usbotg2: usb@32e50000 {
                                assigned-clock-parents =3D <&clk IMX8MM_SYS=
_PLL2_500M>;
                                fsl,usbphy =3D <&usbphynop2>;
                                fsl,usbmisc =3D <&usbmisc2 0>;
+                               power-domains =3D <&pgc_otg2>;
                                status =3D "disabled";
                        };


Regards,
Peng.

>=20
> >
> > Could you post a github branch, then I could give a look?
>=20
> No problem.
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
