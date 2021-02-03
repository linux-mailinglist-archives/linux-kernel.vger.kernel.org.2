Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C772330DD16
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhBCOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:41:43 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48272 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233328AbhBCOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:40:56 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113EWCNq003057;
        Wed, 3 Feb 2021 06:40:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=AoOxzeYV/gXZcWrqNomzlLdlERIwxgnCRDvn2G+hIAU=;
 b=BoCk9tp2i82Il1A2Wgq9d3ZwL8xUni1c6Sg9X1VfuaC7n/OgPnErhMmM3BDxKP71yKaA
 xXI1ta8p6w6MM0m2D1hIZpYNgY+rzEAAYip8s3x13fxk0Z0QyAyyclM0BvkEW4i0+WmW
 wn59tQ4Ced3HXtt27ucer1szaa2H4v8hNqWRz3fW4HXAlWLUWIG/GIyINLppK1wHY4cX
 P2f5FV9HXjZc8ltOWNsUHGY7DFHKxoT/tmEy/hr/dF03WSl2f8ACKkw2GL1M9OJHDfoz
 SlX2ctlOFYrwEE/a8HcqsmhqLjwyqYhosIt1hFsNIdz31EUvwoIBt6pzNO58MtneQatu PQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3g13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 06:40:01 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 06:40:00 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 06:39:59 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 06:39:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+ZWNcyvy9duKUGy9fXcJaEZJX6iTvCvH9uMYBLNloOQIHQKs/LMTPxXlfQZPE4l8ubsFpvEzAGJtEPZXdi4TZlGzsOFf/tCc30pGItCEJ3z9Ibaj0Sna5csGet0Ivq8Ocfe/CeWwc2rgpIICal6k4uYZ2U5AumnFT8j6tiCjp9lxYSRWuNPf8Ozt9iZ4Ht/Sy5Wr6FWJndGPk1sMCFfij93mnrAzYGHeHsmazys2BSGTQtt0oWceUiTFUa081QyiARQ19vDu+qVfc77MiWYu63PLtokM3N0v9PpuznBSMu//xRlybMNjMsy8EUdGbRS10VLcfM0MjLgN56IV68YIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoOxzeYV/gXZcWrqNomzlLdlERIwxgnCRDvn2G+hIAU=;
 b=KYL+OUeYh7ONrm2vAP/tEfSsOTikqDWbT4JLVdudP5oCLWv32XTf8m1AAF/WM7PRoNzZj7Sq4RoXBblHBvVtB9Bn67NkZU3qYRS/r9z+aGhdzw7uoy01n+zqJEGx71qw9ODGicOmJR4E7J7rV3aBLhjUDuyx9yP25kOAVlmYTGlkFJLx9mMRJYoTXGVZVSvsXglvqJqLMFdpXO4P3kyzTSQkIP0CZOoOLyVZyQsai1YHBXhsJV2mA9knsXGH7MAG/jY/tamJ7kkPjhEN4P1cL5bg31xOHWcC20Ga7cpjMUSkWo7UIt8fnAbb10k7lEjJ+HpyN9n9rvoGHRfk/BI5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoOxzeYV/gXZcWrqNomzlLdlERIwxgnCRDvn2G+hIAU=;
 b=KNHRGITyYQnoLF5kgqFcvhK0mT1qgZNcgOgDkWZwmRzV2x+KT6oYsf6TpFtXuTpM6HSZa0oktyDPRYDBb4kPaS8ZItmEA2b2mVMOLr/lcN3EVCTuqRscbWiPNUlGzmVHwND8jwhgeT/DNocktXpc2EghIbpYaPGh8CGbOyRTEpk=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR18MB1642.namprd18.prod.outlook.com (2603:10b6:3:14c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16; Wed, 3 Feb 2021 14:39:57 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 14:39:57 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Baruch Siach <baruch@tkos.co.il>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Nadav Haklai <nadavh@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Stefan Chulski" <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "Ben Peled" <bpeled@marvell.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 03/11] dts: mvebu: Add pin control definitions
 for SDIO interafce
Thread-Topic: [EXT] Re: [PATCH 03/11] dts: mvebu: Add pin control definitions
 for SDIO interafce
Thread-Index: AQHW+jEKQCswtMtvs0m9H80l6I30SKpGdXyAgAAKzWA=
Date:   Wed, 3 Feb 2021 14:39:57 +0000
Message-ID: <DM5PR18MB1452ABE0F98B38A86DCEE406CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-4-kostap@marvell.com> <87eehxcku8.fsf@tarshish>
In-Reply-To: <87eehxcku8.fsf@tarshish>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: tkos.co.il; dkim=none (message not signed)
 header.d=none;tkos.co.il; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7efce761-e4c1-44e6-7cbd-08d8c851941d
x-ms-traffictypediagnostic: DM5PR18MB1642:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR18MB1642E403B46A504CAA19F7D0CAB49@DM5PR18MB1642.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tcW8cTU5tDKMOihcd/ienFWPEKrytFCbcem4Uw2YBx2twNzbHxJH/0TMvv741eNd/qkP5TMl8Dxl2ZUEbP5XomvCZiAlaASO25Z4XnYSpCgn0G61EWg4D9x2ezT/z+gcBI46qLmEMAPPpym0md13RaNA8rAvKkeqI3yXJgmmD/kH9DwOY9ATYEW0DlImDV3di6M+hXcGqf7oN5N5Xtvk6po4EeOAUTLfNofHeTMltoXKnSmEcLGU30LRCU86fHHsYqyEJpUWfncbnWfSDBOQ9QTg1OZ4NYlA9XtDIRtLL5+vvySwVvXvSSssmA3/bMY98rIz5K5WYV7EV2C574hKLdOYj/3k6Ql9iEuECXchE+zZ7EXtYcEiEF6sPfGfkpmdPFsaOXFwB+fE4ugrshB73bDUQmBOr819GepUQRjTxtw6+uCy0xHjep125DZrla8oi7794JpegjoDeXeJcfKOnWDebrEwN/wKVCoO1AusZnoM0baDZv0agw0Wilguo5naVnbHl7YTLKqcLQ9KHTyMdEmSQJmm/FxvAwNZ87ZsqduK+yTUfMY/7cJXrVH7HLs8J+8NcajXWfG6jrzSqUBcYWZUGnaLywwc0g6YRrGwAEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(7696005)(6506007)(9686003)(83380400001)(52536014)(19627235002)(186003)(2906002)(7416002)(53546011)(86362001)(6916009)(4326008)(26005)(71200400001)(478600001)(33656002)(66446008)(8676002)(66556008)(76116006)(64756008)(66946007)(66476007)(8936002)(966005)(54906003)(55016002)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x2JoyFCfWOUaEWoSwerCWf6VgZ5yUI74B/afNa6N1SZ6Uk+qYL6xq0Ik+QJb?=
 =?us-ascii?Q?o9FkTsiiSz7H9P7SN/Lp3BXY6izMn2rO3Xx/vlTJjdEbYqPHT5RcbVgHUQtg?=
 =?us-ascii?Q?TXrpq+xIJ4Y/dSCTPvlsQFfTh0e7ZrDT2EJGBo7j2KtBrJ+hczN0Ac8gMtUD?=
 =?us-ascii?Q?ESp9O32+J1rnlv1HMn67XLeYwvq6jmSk+2+z1GWBNQYFgkR7R+C3RQf3A97J?=
 =?us-ascii?Q?iOF46QqAE/dOZyb1YBQ5vj9RPEP6VzynWhVSMenioLro9WN1O36f4gHbiHAH?=
 =?us-ascii?Q?ii/y7yc2Q6PnLu3btbLlhGq96xLZkaRIg+7WLsqekBzzB8tb8RYk1IBa7yAS?=
 =?us-ascii?Q?OyWbciFXeGfp8bkyJ3C+WebtCB1PhLD7kyE2Fpo1FYfybmiUvL8X1k9gOc6M?=
 =?us-ascii?Q?SewfiRyEKh6IpRyVCqMdZrdOwhWNN9hI/iqBbvFYVFID43bCLD+AFUqkBIbG?=
 =?us-ascii?Q?XE/G2B7vc6gviKsHoif/Ah5cl7CuhqvUNVwaXmiQH1PFGWkoYD+oUd1SKLgM?=
 =?us-ascii?Q?Kg2OWORYHBxQKhdUrEbHb6HRwA+K/RswAkIdZxZw42EutQnQXADvdzseokcx?=
 =?us-ascii?Q?z/XTtcWsVVC+bwBefKHvrLFV0yCu6S+zt6Y/tX1W3LOUZJPPYTPlTL3UZS1T?=
 =?us-ascii?Q?0Rs1dK89pU623SmWnlCJItawk4ysnB6TpHx5jyP8c66jzk9gAecSFV9bk/C3?=
 =?us-ascii?Q?CMZ/1ggbMI8ICBBHh/CODYn4f6mI77MOBaU22u+WbwiJQRC4h+VV+1dUIKUp?=
 =?us-ascii?Q?sBZsRUd7u4b29MVVIZQ0IfCsxs/awjfq4JvVavo0EeY3jfcpdRfgabgQWRxY?=
 =?us-ascii?Q?gsZ+el3ncSJJMCVYWagr2Z+hrkc1AhR6E0dmsqWlWo76y9nlzKLGNWAzCaMC?=
 =?us-ascii?Q?MNthSC/Kb5cZYoMVoMD62aGyXkCpw1b9s6biC3Ec96oK8OJGSjpSocOs+UdS?=
 =?us-ascii?Q?vARoa2GaktA04iXBmgtum3tO2+cI/5D/8CT5hjiGelxO91h9i77VbWEUgazE?=
 =?us-ascii?Q?zbdI46z1EWjkyjMMyYphV8+xw1wv8ThsfqH1tdiBypF9GIHWJUlKWaN42qud?=
 =?us-ascii?Q?m8/2Z5gx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efce761-e4c1-44e6-7cbd-08d8c851941d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 14:39:57.4562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08BXVpNBRl1bcdWytnFYIyNuqWeT8QGy9muC7z/fZYa/CRsm+7lTPO3+C+yGHg8dUjDVVr4afKkvRukYYt19RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1642
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_05:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Baruch Siach <baruch@tkos.co.il>
> Sent: Wednesday, February 3, 2021 16:01
> To: Kostya Porotchkin <kostap@marvell.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> andrew@lunn.ch; jaz@semihalf.com; gregory.clement@bootlin.com;
> linux@armlinux.org.uk; Nadav Haklai <nadavh@marvell.com>;
> robh+dt@kernel.org; Stefan Chulski <stefanc@marvell.com>;
> mw@semihalf.com; Ben Peled <bpeled@marvell.com>;
> sebastian.hesselbarth@gmail.com; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH 03/11] dts: mvebu: Add pin control definitions =
for
> SDIO interafce
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Hi Konstantin,
>=20
> On Wed, Feb 03 2021, kostap@marvell.com wrote:
> > From: Konstantin Porotchkin <kostap@marvell.com>
> >
> > Add SDIO mode pin control configration for CP0 on A8K DB.
>=20
> This patch does not touch the A8K DB device-tree file.
>=20
[KP] Right, it changes the SoC DTSI. I missed it when ported the patch.
Will fix in the next version

Kosta

> baruch
>=20
> >
> > Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-70x0.dtsi | 6 ++++++
> > arch/arm64/boot/dts/marvell/armada-80x0.dtsi | 6 ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> > b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> > index 293403a1a333..179218774ba9 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> > @@ -47,6 +47,12 @@
> >  	cp0_pinctrl: pinctrl {
> >  		compatible =3D "marvell,armada-7k-pinctrl";
> >
> > +		sdhci_pins: sdhi-pins {
> > +			marvell,pins =3D "mpp56", "mpp57", "mpp58",
> > +				       "mpp59", "mpp60", "mpp61", "mpp62";
> > +			marvell,function =3D "sdio";
> > +		};
> > +
> >  		nand_pins: nand-pins {
> >  			marvell,pins =3D
> >  			"mpp15", "mpp16", "mpp17", "mpp18", diff --git
> > a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> > b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> > index ee67c70bf02e..64100ae204da 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> > @@ -70,6 +70,12 @@
> >  &cp0_syscon0 {
> >  	cp0_pinctrl: pinctrl {
> >  		compatible =3D "marvell,armada-8k-cpm-pinctrl";
> > +
> > +		sdhci_pins: sdhi-pins {
> > +			marvell,pins =3D "mpp56", "mpp57", "mpp58",
> > +				       "mpp59", "mpp60", "mpp61", "mpp62";
> > +			marvell,function =3D "sdio";
> > +		};
> >  	};
> >  };
>=20
>=20
> --
>                                                      ~. .~   Tk Open Syst=
ems
> =3D}------------------------------------------------ooO--U--Ooo----------=
--{=3D
>    - baruch@tkos.co.il - tel: +972.52.368.4656,
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__www.tkos.co.il&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D-
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3D8Kz0ddezxxG41
> 9tiQOva_I9GUi6QZw9Pa6tRxYugqQw&s=3DKy8dBlut-daLt2-
> 0j3BIwiBEBAVzKi8e9oJetRIzuPA&e=3D  -
