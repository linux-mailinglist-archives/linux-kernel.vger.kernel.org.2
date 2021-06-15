Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18353A7AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhFOJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:37:20 -0400
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:26976
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231287AbhFOJhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6A2X8V2nNpQ0GWvj7vuXEClizCRxkOKHF6xk8E3cY174fLV4DvV1jpYxFKMDx4h0eiqOZRRU+6+5P4rhWO/veWMJsfA3qcLOmtIC2ZeV1A8Yt7mj89VuA96wy/IYXTKzeR780aAtNJFZeozxIh8SUEtw0iYIWGrS1souvV9Bm5efA9JUr0r65OcGfQD5LyVmqLEeXPuaEunYcTTsuEt39qqhwqddIHhctOAp+GsmbS66/dxc8zWQ51o75cuHUVymeRVlTyWMDWIr1j9rwX0jL2eQlToLGqUp5yz6WVmlG6ASFKMIaS8qL7a/HxjGN3ZZKq6NwesztZN+AW/ynLlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42vGWpRxQSlhwqGpAyszTh6zF8IEIJXbVyZ6gA0PP58=;
 b=ZqH91ORexptJfTx6RQma7MoGmsFrC7HZJRHBpHRgK9mOHX8D5OvG4acEVua4UGbaaSK6LjpdoFxGUCWVIKH5t25g2KTZoGr4gOmFLxvKsYokZSmmCDIZp2CKTdYwbVp7KPoJ8u7LEGTMXJA0xYTnGWhyqxJT57GxG58vMXpn7OOOymQLctzYLzd40XjgxsnMsQHykRsektNrqRfdpBC2FxR7uyEXxv08gY/ktyn2XrW+aEa3VxMLXW5m2jzgExOYLcOtvSnKL9bdmSNThSQs8fv9wPrD4FOoWHzwFsoWoZnFqLlH9LzhWhKqEePWxLV+IclXUoV7Mh4r/7nPcx+m6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42vGWpRxQSlhwqGpAyszTh6zF8IEIJXbVyZ6gA0PP58=;
 b=A7oCjjC4zdl4+ffV42JHKaj4nNOajUUzS6WPdPDcthJbJTORYqlUlDbb2xMgYiLfeTWv8Fk4lvws2Mhkj9d1NBxo0gVQnFWLXLPPFP91dCBlYNY+f4F6U46+A4n3ckI5fTjOzvhff5m+JYEzaeFhQ8a9uXKzM4vn2zQaApdBHp8=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0402MB3343.eurprd04.prod.outlook.com (2603:10a6:803:8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 09:35:10 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2%6]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 09:35:10 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Alice Guo <alice.guo@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] arm64: dts: imx8mx: move soc device into ocotp
Thread-Topic: [PATCH v1] arm64: dts: imx8mx: move soc device into ocotp
Thread-Index: AQHXW4JL4xzRoUO/70qi7gWRJU6CiKsQCz6AgATOdwA=
Date:   Tue, 15 Jun 2021 09:35:10 +0000
Message-ID: <VE1PR04MB66886DD55CFB71F2E50205F589309@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1623089112-27069-1-git-send-email-yibin.gong@nxp.com>
 <20210612080120.GA29138@dragon>
In-Reply-To: <20210612080120.GA29138@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9070ad78-be8f-47d0-1dc6-08d92fe0dee9
x-ms-traffictypediagnostic: VI1PR0402MB3343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB33436477E4F7BF5C947A7BA189309@VI1PR0402MB3343.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s/qHjEBxJov4+7YmPBNiSU1tw1+1NXXoDO6y5WfdPflspzYD/GA/zAqDzYTqVsDrwOqH/gIaPkoAFR4IhiTnKcSZ/pYIwDlyBBwr/94AgHbNcvujlH6fMn3vxRZkI+LH2sPMzXblNNog67rvp0iB876WubR0LE4nnW75E5t8vzGaCvGneZkO7okzHReNVIzw4iMbNaNpQG1gruFboEPwZP5izPRNPCzKl64ABlsbPiFvUEZLBtA8CItayLTu9hniDqt4XHgswm8vglbO/NJ3Qk/O083y+p4fUGFo8RWf/f5WRufkDy3T3bEjOJy2xjebOsCfYO9U+VoKryX4cCrMSOVH2r7ZhY+/GtZn8PMlNlZ7B8LpNGye12cb+YzYIxpuB050Weryeul2jxPgm1XyJf7SyNbY9TvZ5SmQYC8AB0tTvY2EPgyTQ0j+GyziaA1lFkWK/KGUbrGJcHKEixvaokgC82uuDsds+BFQkRpmfaGtbkREguSDlC/zZlmmJGtUlb3TzR9TsSPDXxt75IPD7IKTrPrmhcsA6x1GXo/w2vN2wpb/mUAnwkxpmpbxKT8ruwn3b1FGlK9zLxzI/mRx06/OP+UZzmUoRJ/tv8lJK/mfOW8+RQVk6mKTgbrU28KQ1FJ9qakIUQjNIjvTAWxCZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(7696005)(316002)(38100700002)(52536014)(53546011)(26005)(33656002)(6506007)(122000001)(83380400001)(66446008)(86362001)(4326008)(66946007)(64756008)(66476007)(5660300002)(71200400001)(9686003)(66556008)(186003)(8936002)(478600001)(2906002)(6916009)(76116006)(8676002)(55016002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HDqeglzYn7r5I1TxTTbhh/GNhy+XYmOzCIaWU+uAiPRRsMlfw3tEWs+ZKb6J?=
 =?us-ascii?Q?oVWAq5ugB+kMs2LwNGhVgNT137smxAeCi7S6hkC08S/EWI6rCTab3tzg/o4M?=
 =?us-ascii?Q?FezAX82wGcMQbPiAYjM4LfLKM412SVEsmeOUcn1ZLkj32hryNO8G49qYbHO2?=
 =?us-ascii?Q?2bpo3vmhLzQVos55FHOe7ON1Qm8rv3zQDAfTWaEuZ/CO/OytvQMXTfIWhte4?=
 =?us-ascii?Q?BOV+H30XVg68zWuCuVc5HH9XXPfmwxYu3duu3RzpCMtqVWZSbEP/YLF1aSTG?=
 =?us-ascii?Q?XBYcoR9FBldIc/Olgy4CJkVKg66aaTF0FCStVbcyoVsIPL6navIjKZTPEB8+?=
 =?us-ascii?Q?I8qMk/zrCXmNhWM3ME5IhEBl3N3PYLoNGILNLynasdPZTwLtRkQsPHHKpnTp?=
 =?us-ascii?Q?mchtiDFBvlnIMJzq0eQMisiIj37aYx6hjttdKd+4oUGrf5Zv396EKOnsmnbX?=
 =?us-ascii?Q?IfOwhxXiPm0BwzvjXeF2B5WDJzROBGlzSFVoxRrj2nu1Ua8bft88s/nG6c1O?=
 =?us-ascii?Q?wKmMOpmQtfZUY0jtjOdCc5VRz6W0bSNgagm3e2f70r7fjAspb06WJ3I6ZLLW?=
 =?us-ascii?Q?erdyey7ccQzmgqhGHBwcJxCbl0liTViEYrpQFHx920wcomynpp0hsV8orPNP?=
 =?us-ascii?Q?COoJFxyQY/GYM/fRLYBgRCv3YtbFx5xTdTToJBRcD7ZJA40jAc479qA5TlYs?=
 =?us-ascii?Q?uez3atDT4V6ez2veJwXIpJF63GyE9HHGZlePFTr/5kaTFqennG/kSMx24cfb?=
 =?us-ascii?Q?snW/03xDxHJjj5zw1EQqgivpsK5+JYWP0YJXGb6Ae2RtMrr+jwdCWTZZEKfT?=
 =?us-ascii?Q?GnJKPu9mGbg7NUebw8KxiC8OfbPDsvDzUioXeX4JSkSrLXFTJFkG18jsCofj?=
 =?us-ascii?Q?godm4+NSbXfPAKE+elBa9WMYMjHDE0f3jAPhrh0lrpqJh/tlNyEEVS12x3Y+?=
 =?us-ascii?Q?hf4WvXt52v/4WLPw3/GcaKnti6/CSGwsZjq5L72gPh66BLNT0RjvSHKl68tq?=
 =?us-ascii?Q?P9HJvBFe26xeGeGex3PXwY7nCO10q5/mDxmDb8WCV8C1EJqV+teoFh10jSee?=
 =?us-ascii?Q?Jqkh/2HqLpIOK0S9DR1wbyqOUMuFfx4YEvQN1Q4mNcwTfmPgrNgFufoZmUTE?=
 =?us-ascii?Q?SfTruqbPuGab9uRQuyrLUC++BuizIz7ytjgjzWy4fI65iE9gXwzcVqTRDA+R?=
 =?us-ascii?Q?jb0wG1QGPoSMXcKXM7+plkW3UgrhTYHkfLKpsXOHTBtbijVGZooB2BsTuHWA?=
 =?us-ascii?Q?Nhj6qlCyS9fYCXMy2BG5fnHIhg+SMXxRO5KzpnkY/SggLBLuWCv0M2CU+w99?=
 =?us-ascii?Q?aSJAyVFXpNPVYRuxTichJohe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9070ad78-be8f-47d0-1dc6-08d92fe0dee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 09:35:10.6996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3t1q4tl+RE5EBSow0tmjnEBt5ag98U5MNTd2qVhAkGBhCLEI/GPAPWBLQBkRoqfOSFKxulTtJVzCTGLhAcl8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3343
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/21 16:01 Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Jun 08, 2021 at 02:05:12AM +0800, Robin Gong wrote:
> > move soc device into ocotp device node instead of the parent device of
> > the all devices which located in 'soc@0', otherwise, all probed
> > children devices will be reorder to dmp_list again once 'imx8mx-soc'
> > device defered probed, which may break driver's suspend/resume
> > sequence, such as imx_spdif and fsl_spdif, hence the later would
> > suspended before the former as below and endless interrupt may never
> > be handled since clock has been disabled already in the later.
> >
> > [    1.930598] calling  fsl_spdif_driver_init+0x0/0x20 @ 1
> > [    1.955712] initcall fsl_spdif_driver_init+0x0/0x20 returned 0 after
> 24512 usecs
> > [    1.981963] calling  imx_spdif_driver_init+0x0/0x20 @ 1
> > [    1.986600] initcall imx_spdif_driver_init+0x0/0x20 returned 0 after
> 4509 usecs
> > [    2.901408]   #0: imx-spdif
> > [   21.151529] fsl-spdif-dai 30090000.spdif: calling
> platform_pm_suspend+0x0/0x70 @ 470, parent: 30000000.bus
> > [   21.161189] fsl-spdif-dai 30090000.spdif:
> platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
> > [   21.474311] imx-spdif sound-spdif: calling
> platform_pm_suspend+0x0/0x70 @ 470, parent: platform
> > [   21.483024] imx-spdif sound-spdif: platform_pm_suspend+0x0/0x70
> returned 0 after 9 usecs
>=20
> DT is written as a description of hardware, not for resolving Linux speci=
fic
> issue.
Yes. But this issue is brought by previous patch in dts as below which forc=
e all IP
devices in soc@0 to be children devices of 'imx8mx-soc' platform device. Ma=
ybe
I should split it into several patches to fix below per soc to make things =
clear.

commit ce58459d8c7f4174e7b8a8ea903dd949631334a3
Author: Alice Guo <alice.guo@nxp.com>
Date:   Mon Jan 4 17:15:42 2021 +0800

    arm64: dts: imx8m: add SoC ID compatible

    Add compatible string to .dtsi files for binding of imx8_soc_info and
    device.

>=20
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 12 ++++++++----
> > arch/arm64/boot/dts/freescale/imx8mn.dtsi | 13 +++++++++----
> > arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++----
> > arch/arm64/boot/dts/freescale/imx8mq.dtsi | 12 ++++++++----
> >  4 files changed, 34 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index e7648c3..9ef0554 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -257,13 +257,11 @@
> >  	};
> >
> >  	soc@0 {
> > -		compatible =3D "fsl,imx8mm-soc", "simple-bus";
> > +		compatible =3D "simple-bus";
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <1>;
> >  		ranges =3D <0x0 0x0 0x0 0x3e000000>;
> >  		dma-ranges =3D <0x40000000 0x0 0x40000000 0xc0000000>;
> > -		nvmem-cells =3D <&imx8mm_uid>;
> > -		nvmem-cell-names =3D "soc_unique_id";
> >
> >  		aips1: bus@30000000 {
> >  			compatible =3D "fsl,aips-bus", "simple-bus"; @@ -522,7 +520,7
> @@
> >  			};
> >
> >  			ocotp: efuse@30350000 {
> > -				compatible =3D "fsl,imx8mm-ocotp", "syscon";
> > +				compatible =3D "fsl,imx8mm-ocotp", "syscon", "simple-mfd";
> >  				reg =3D <0x30350000 0x10000>;
> >  				clocks =3D <&clk IMX8MM_CLK_OCOTP_ROOT>;
> >  				/* For nvmem subnodes */
> > @@ -540,6 +538,12 @@
> >  				fec_mac_address: mac-address@90 {
> >  					reg =3D <0x90 6>;
> >  				};
> > +
> > +				imx8mm_soc: imx8mm-soc {
> > +					compatible =3D "fsl,imx8mm-soc";
> > +					nvmem-cells =3D <&imx8mm_uid>;
> > +					nvmem-cell-names =3D "soc_unique_id";
> > +				};
> >  			};
> >
> >  			anatop: anatop@30360000 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > index d4231e0..f82905c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > @@ -241,13 +241,11 @@
> >  	};
> >
> >  	soc@0 {
> > -		compatible =3D "fsl,imx8mn-soc", "simple-bus";
> > +		compatible =3D "simple-bus";
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <1>;
> >  		ranges =3D <0x0 0x0 0x0 0x3e000000>;
> >  		dma-ranges =3D <0x40000000 0x0 0x40000000 0xc0000000>;
> > -		nvmem-cells =3D <&imx8mn_uid>;
> > -		nvmem-cell-names =3D "soc_unique_id";
> >
> >  		aips1: bus@30000000 {
> >  			compatible =3D "fsl,aips-bus", "simple-bus"; @@ -528,7 +526,8
> @@
> >  			};
> >
> >  			ocotp: efuse@30350000 {
> > -				compatible =3D "fsl,imx8mn-ocotp", "fsl,imx8mm-ocotp",
> "syscon";
> > +				compatible =3D "fsl,imx8mn-ocotp", "fsl,imx8mm-ocotp",
> "syscon",
> > +						"simple-mfd";
> >  				reg =3D <0x30350000 0x10000>;
> >  				clocks =3D <&clk IMX8MN_CLK_OCOTP_ROOT>;
> >  				#address-cells =3D <1>;
> > @@ -545,6 +544,12 @@
> >  				fec_mac_address: mac-address@90 {
> >  					reg =3D <0x90 6>;
> >  				};
> > +
> > +				imx8mn_soc: imx8mn-soc {
> > +					compatible =3D "fsl,imx8mn-soc";
> > +					nvmem-cells =3D <&imx8mn_uid>;
> > +					nvmem-cell-names =3D "soc_unique_id";
> > +				};
> >  			};
> >
> >  			anatop: anatop@30360000 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 9f7c7f5..d113691 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -220,12 +220,10 @@
> >  	};
> >
> >  	soc@0 {
> > -		compatible =3D "fsl,imx8mp-soc", "simple-bus";
> > +		compatible =3D "simple-bus";
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <1>;
> >  		ranges =3D <0x0 0x0 0x0 0x3e000000>;
> > -		nvmem-cells =3D <&imx8mp_uid>;
> > -		nvmem-cell-names =3D "soc_unique_id";
> >
> >  		aips1: bus@30000000 {
> >  			compatible =3D "fsl,aips-bus", "simple-bus"; @@ -341,7 +339,8
> @@
> >  			};
> >
> >  			ocotp: efuse@30350000 {
> > -				compatible =3D "fsl,imx8mp-ocotp", "fsl,imx8mm-ocotp",
> "syscon";
> > +				compatible =3D "fsl,imx8mp-ocotp", "fsl,imx8mm-ocotp",
> "syscon",
> > +						"simple-mfd";
> >  				reg =3D <0x30350000 0x10000>;
> >  				clocks =3D <&clk IMX8MP_CLK_OCOTP_ROOT>;
> >  				/* For nvmem subnodes */
> > @@ -359,6 +358,12 @@
> >  				eth_mac1: mac-address@90 {
> >  					reg =3D <0x90 6>;
> >  				};
> > +
> > +				imx8mp_soc: imx8mp-soc {
> > +					compatible =3D "fsl,imx8mp-soc";
> > +					nvmem-cells =3D <&imx8mp_uid>;
> > +					nvmem-cell-names =3D "soc_unique_id";
> > +				};
> >  			};
> >
> >  			anatop: anatop@30360000 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 91df9c5..8cfbc77 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -287,13 +287,11 @@
> >  	};
> >
> >  	soc@0 {
> > -		compatible =3D "fsl,imx8mq-soc", "simple-bus";
> > +		compatible =3D "simple-bus";
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <1>;
> >  		ranges =3D <0x0 0x0 0x0 0x3e000000>;
> >  		dma-ranges =3D <0x40000000 0x0 0x40000000 0xc0000000>;
> > -		nvmem-cells =3D <&imx8mq_uid>;
> > -		nvmem-cell-names =3D "soc_unique_id";
> >
> >  		bus@30000000 { /* AIPS1 */
> >  			compatible =3D "fsl,aips-bus", "simple-bus"; @@ -554,7 +552,7
> @@
> >  			};
> >
> >  			ocotp: efuse@30350000 {
> > -				compatible =3D "fsl,imx8mq-ocotp", "syscon";
> > +				compatible =3D "fsl,imx8mq-ocotp", "syscon", "simple-mfd";
> >  				reg =3D <0x30350000 0x10000>;
> >  				clocks =3D <&clk IMX8MQ_CLK_OCOTP_ROOT>;
> >  				#address-cells =3D <1>;
> > @@ -571,6 +569,12 @@
> >  				fec_mac_address: mac-address@90 {
> >  					reg =3D <0x90 6>;
> >  				};
> > +
> > +				imx8mq_soc: imx8mq-soc {
> > +					compatible =3D "fsl,imx8mq-soc";
> > +					nvmem-cells =3D <&imx8mq_uid>;
> > +					nvmem-cell-names =3D "soc_unique_id";
> > +				};
> >  			};
> >
> >  			anatop: syscon@30360000 {
> > --
> > 2.7.4
> >
