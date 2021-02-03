Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C413A30DD05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhBCOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:39:25 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:26236 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233093AbhBCOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:38:22 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113EUjc0002029;
        Wed, 3 Feb 2021 06:37:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=M+agLqqQ+Jx9HqvZ2sHpXPXy0N7Kw5fgSXltd9BhkEE=;
 b=iGKWtYmb1ZXSUWtT/dLSfq1gvCnpxZgkI7VkyNmvaBiPa8EYcPebFNSyyY2V5vLhKBew
 oweqmIkLQiWMGr9HCxJvPutmyH6fQ1FWe2aSZChB2Us/GEatCr+FPHt/+juY58riefv1
 VRJYgKO2aQlsws5pVzFUPr6Q5rZNLxC9hlt6GS1K499S+n+AVTKw77nLrXaZi0a1eyDf
 J8oDCM5SpLGIAiEMuMPLUfcQgqpwIH02QOKBReLnffKOCt7J7zTrETPZgpJj9LreJGro
 3wbNLZl0es8rIWN6WfhGlvBp4uHIaR8EpJvivQEQq0/rgWKhdHvMOblTFgpT329qs9I3 /w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3fnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 06:37:26 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 06:37:24 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 06:37:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 06:37:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQZntJIKzitFcHniagqm/qxLSw16R55FeyhGtFrDCmytNdZo8L8bumRJYv9LmS3tdxntYIUsKl+IUWRSsCL/wSJ8oQHh1m44gRPr9QEPkdo1EYz6I8EtLbwBMr4We/wSGwPr0yDOLhYS7srzSb1erY/AWTOJxEMlRr3HRxBGFtmNOtRMtcgXC9NMTmCNK0p5uPXAwrfC1wNxdr4SpxuGx9tKaBHwrbIqll5ZTVkuBND3vsdnljXTm5r4QJT2Qu1Oj0P107VI5poa5/PthMJ10/Fi5xWWE05QcsU+XKgd0p8dGVnQ+C0aBMnwmkr/0kKWWrgpH3NA+mbH7PgiP9WoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+agLqqQ+Jx9HqvZ2sHpXPXy0N7Kw5fgSXltd9BhkEE=;
 b=HqKamSn/xIj0xq+gY1+/UhLpDtM+7w2E0cHdpqT+EuTrxKjjlnDKJzAeGbjc1jv7kOSAOH6aRR2dm2w76VLGnamAjGWd4zVsg9Y11fg25Wn8v8mNvGCZw6kuUcTXMv87n1JjpbcXVpV68dLp+nM0jsGoO3cYOJ3SKhncYY3+6nA0T403CbxrWYMUNQCq4Vabz+mF9eIvNg0Iq3mauHVYzBfry33iyI52RJZhF5wVLynQ6/+d/US+ThhjCFE0r+H361oif4wmN8iX9jZ32q0vs5hS0MhOIAgTXCk7bgpOER+wVsgtzwgiQ7KJr8vWdpOWAMWCkmtp1huReS0XrFr1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+agLqqQ+Jx9HqvZ2sHpXPXy0N7Kw5fgSXltd9BhkEE=;
 b=Nu5vf9a3d3PsZfI+VpJE3BQ81tLXb9okKND3ZCSyjazFUaxZD4Mzm3X+1bpRP5T1TIylcIjdZBdwXy/3MiaQncDrFHlqqlWH2F9pxk1IS2Ek4Dfx9P7+u7z/lr4ffhLBJzbh6uRe49HboUi+ELwvWwhuXLn/0CvrOZdagpqUD40=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR1801MB1994.namprd18.prod.outlook.com (2603:10b6:4:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Wed, 3 Feb 2021 14:37:22 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 14:37:22 +0000
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
Subject: RE: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
 settings
Thread-Topic: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
 settings
Thread-Index: AQHW+jD04fJzej2FY0aIGyOLdCg1f6pGdPSAgAAJqBA=
Date:   Wed, 3 Feb 2021 14:37:22 +0000
Message-ID: <DM5PR18MB14529A28A31785A574A4DEF5CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-3-kostap@marvell.com> <87h7mtckxe.fsf@tarshish>
In-Reply-To: <87h7mtckxe.fsf@tarshish>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: tkos.co.il; dkim=none (message not signed)
 header.d=none;tkos.co.il; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9162d52e-ac66-43cc-8268-08d8c8513792
x-ms-traffictypediagnostic: DM5PR1801MB1994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1801MB1994908CC298CBC9F68A74EFCAB49@DM5PR1801MB1994.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhjDJgtLasgPEqNx/Besk2RZD8YAPYYHCmnjdl6Wsjwzhq43V2cQ4XSbDeQ5JiyIqbT16SEmWqgqbhe2VCCYnHqOIACS5c4cvMBl7j9sLa9KNwmbH8Jq08FosbHNmktbpnVjrxKLAdfcVS11ixPuyDDJL1bqjq791sE1WGJRB3xz1uXXC5DLbsYMgevdrTbk5YzRJxFuCdwp9avip64o3OyztIp9F3lEL3o8P2mQNa0yp4mKaB4f14FtG3aSsMLlvoYoblFPCOVlZerKykOCGrYA1G2+qzXjS6PRGiaqL9gVwOoDTCY/uXFub5iNkDbs7W+ATfHuKCB/N8khvPAHkYLtnA0W/YXhuxHU8eLQsCT6IPK9fjD/DMtuPv0uRrdJ81QeoqszTX4LVyPaWWoOaTWBxgVqYP+cRZFfkGFGqjbjdFuOOzsIMIZBOatBF6/OPFS9QRdm99EzxcXiBIuZ2SXlmre4Jk4aTW6+6mjQ4hYLbBLjkMdp9LnkBHfb7dwtESOH64fDM12TzovjD3fxYwe3Hx5WDNCpOZQSXU4XR3kEmrnkU0mpcjT8n+jw0p+253wu0RFGWx80XDPMeyTShd3kWP06D32LnNQJoRou+Xw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(26005)(6506007)(7696005)(52536014)(86362001)(8936002)(5660300002)(54906003)(316002)(66946007)(15650500001)(71200400001)(33656002)(8676002)(53546011)(2906002)(9686003)(66476007)(64756008)(66446008)(966005)(19627235002)(55016002)(66556008)(186003)(7416002)(83380400001)(76116006)(4326008)(478600001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zFXU8RqT2tVxb8H+zd0fZK5AvUXRLVjnFQUDzH8K07Z/7TwpIpVqynZWvObN?=
 =?us-ascii?Q?TciIVvxo9YrKpFowyoIJtP6BlZ1vbGZH46pjFzb9IGygLf0l/ZRzQJuaOrUl?=
 =?us-ascii?Q?2q71u2Lls1+t/hOdem5a/mJOBic6oScVDmO3cLwxGKM0xxApiCIRn7+vlxqw?=
 =?us-ascii?Q?mMfIeGUPccWJR7s/adiMpWOTfRoftTHrt/IPw7txSLWJ1BXIIaAvk/FCPJ+Z?=
 =?us-ascii?Q?R4voZb2Zmfpz7Nu/DixL+vNOe9rfnO+WunmOqt2ZW1OyRmVfhJBSribsZAAF?=
 =?us-ascii?Q?m0TBIQL9cJdC6aIorHoWZctr5xtoBHVOjTnmfm2TzfqokgfVvnY4nfxPbsgn?=
 =?us-ascii?Q?8zyU2pMJvugh1iTOaSu17vcfr0fwCfrCb7CvDixsXvqRDbdGPlUY03rCv7MW?=
 =?us-ascii?Q?5qXaSW54Ec+OykjH4+4izMHi/AaI+HUlBtOVQNN+3EHfbdjEMIBwqKtFWr2f?=
 =?us-ascii?Q?x7PYJh+qZpM6geDBSGCNoF0f3JqSIKs7QSFTYu6l8goN/lzzUnIUkp7gYcKn?=
 =?us-ascii?Q?oY/tIvbqqZ+l/02Fh27Z+kcxHkCOzjjXyazpOauEqK2IYvK7YZ7H3hkfgzaT?=
 =?us-ascii?Q?fK+4+sE/8+zfcFD9VvWZW+BVxJJoltKmQjSm0txphlmnswulXSDziPzMCk2b?=
 =?us-ascii?Q?/eZGGfyV6yexle2zFCdeUN9by8K3TANGj+privhcMNAoZPw4uuxIEHpIO8WU?=
 =?us-ascii?Q?owvMxPoBvK+cME6VvCjUKA+t8NoscrXBTze4SKJ4LmzKa+tDTcwYKAvV5CzR?=
 =?us-ascii?Q?tz3Rq58Xc+WE63m1ybHEMmT4x9n0iYKjXGS2Gf/ylZdI1xjmFYwjYdYqKuRs?=
 =?us-ascii?Q?uDEF6MGTmHzXF371i5ZQZ0VOxkdrt+Ybak5ZXjKi6gqOVVS/JGbr1N5Hzacd?=
 =?us-ascii?Q?OQ06+AJ/68O/oaTtzlZLqztJEcxDOL7DF33u4h6XVUMIq+NFMcI694K+0Stt?=
 =?us-ascii?Q?kNREROEKOYtAj2/riANFLAWE3cZhwMtYJGUzHBZDbjLNqcO9j2jiLLF66hRc?=
 =?us-ascii?Q?CvVE8YOF2LPQoxked6vLxNeC0ZVpTO6nzCsWAu5q1bObh8DDG7WauQ2JEMX7?=
 =?us-ascii?Q?ZibM7r+c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9162d52e-ac66-43cc-8268-08d8c8513792
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 14:37:22.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIhi3dRWx/pyLa+XOPBWdIB+Ns6CGEpCDN4ZHHCPiVPoQIlt5jhM74qKLp4bEyTS/6RxEWq4iUuoq8WzZKHvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1801MB1994
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_05:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Baruch,

> -----Original Message-----
> From: Baruch Siach <baruch@tkos.co.il>
> Sent: Wednesday, February 3, 2021 15:59
> To: Kostya Porotchkin <kostap@marvell.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> andrew@lunn.ch; jaz@semihalf.com; gregory.clement@bootlin.com;
> linux@armlinux.org.uk; Nadav Haklai <nadavh@marvell.com>;
> robh+dt@kernel.org; Stefan Chulski <stefanc@marvell.com>;
> mw@semihalf.com; Ben Peled <bpeled@marvell.com>;
> sebastian.hesselbarth@gmail.com; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
> settings
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Hi Konstantin,
>=20
> On Wed, Feb 03 2021, kostap@marvell.com wrote:
> > From: Konstantin Porotchkin <kostap@marvell.com>
> >
> > Update the settings for AP806 SDHCI interface according to latest
> > Xenon drivers changes.
> > - no need to select the PHY slow mode anymore
>=20
> Why? Has anything changed since the introduction of marvell,xenon-phy-slo=
w-
> mode?
[KP] AP806 B0, AP807 and later do not need the "slow mode" set by the defau=
lt.
The HWE-7296210 errata is not applicable to these components and they are a=
ble=20
to run  AP SDHCI in HS400 8-bit mode.

Kosta
>=20
> baruch
>=20
> > -	 * Not stable in HS modes - phy needs "more calibration", so add
> > -	 * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
> > -	 */
> > -	marvell,xenon-phy-slow-mode;
> >  	no-1-8-v;
> >  	no-sd;
> >  	no-sdio;
> > diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> > b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> > index 12e477f1aeb9..edd6131a0587 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> > @@ -257,7 +257,6 @@
> >  				clock-names =3D "core";
> >  				clocks =3D <&ap_clk 4>;
> >  				dma-coherent;
> > -				marvell,xenon-phy-slow-mode;
> >  				status =3D "disabled";
> >  			};
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
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3DF567knLB6kbyr-
> BZRqLFLJgXHENu41578OHxsKQQ-
> sw&s=3DeXEBLtBC3CwWIF9XFbHrgSgASz4aMgHi5W1uuXTgdQ4&e=3D  -
