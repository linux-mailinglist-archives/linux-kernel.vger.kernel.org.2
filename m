Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0733709E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhCKKzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:55:33 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:45210 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232326AbhCKKzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:55:14 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BAkMPm012678;
        Thu, 11 Mar 2021 11:55:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=mW8V1YE0tgkTyDkUVctY/4mgkq8WcINvrVzVfkpMieI=;
 b=BRbi55kLrgzuUpEiGJEIllDyTwJ8KtS01zIRgW5BJaCCjpa+7lpRBtfn2DAYH0kkA4mN
 ziDd7jNHN0jGTGWkMFmr6NtvJ2gaYxBSKibrbD68H5UDH4OAkKhniDo49hooDGlHDV6c
 w5aV9zzvaYISOv4GjVPFsjnEixfqiarrUuT2DF35NX+Pn9Q/KCzoAtira25V4BokSFQE
 VbWZfY28Bf3R0PVvBlSDsNbHz7mWy7+89hsR/67AtFgLEWIuz5SNtePjUxn2Qs9xO5kW
 +e6GSnBnpxnHa0BSBQWd5mZe/RdVKPbRcSJaf47vsCebSBeAKiMPwNT1JFYOB/qLpqAT 0g== 
Received: from eur03-db5-obe.outbound.protection.outlook.com (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55])
        by mx07-00178001.pphosted.com with ESMTP id 3741y75n62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 11:55:05 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE5ZPoYDLdI7Qs7UYNs+/147xNv6UiDGZiIGx5FXE6qwclNNR8UxyqBg7jepr+j1aYdHnwygnvSorBbCJNm6FI61sqwlyPxuix/TjEEVwnUeberoUS8LMvLW7+s+Z+Vb6eAGZWXjBrNnDVPWSNJY3j1moGHvkXVEPQNir0QynBS4/0AB2pT4ACGhaU1mRAlOxKkXcSZRZvXSvc9PNnbLf6deZfn/WMIGMq8j8mhp4SsJpgcce0ikcsgs9C9LDb+Ri4GAv0K815Ai3Fwo8rbD8j6XzmyzZDOvMz6Pmjoy86Dh7odHwzJ2aJdOIWD7cvPX4IwTp4vLfR5do1ilEkh7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW8V1YE0tgkTyDkUVctY/4mgkq8WcINvrVzVfkpMieI=;
 b=QGKdoR1YGtLsL6TWMCubIbDD5gMGL/okL3TxX3glr9PejJ1REVTf8qNcno5KxQptGsy82iPe57UOmGggQwIkU/SEfv+vLMU6tx7uBZNC6eSR0kQ9AEgYqhqf+f9GXRCjATOd8T+7wBd8LV8PhUaQqzyyI7+f1Jgf75YA/6qzmnWCJ1QDm9pdK/fEb25sM/YE5pgrkM9uRgnetJ0fdvIc3sS4+aSyXgeX3KWY52WLTbnHmSxJbhqL/uRVNcFCI59MxdK4RTfjCTgb83mQgJvgBPLOO+PVU4/IYqjb44SExupIKbfD8d+qa+o5wUVRmVlfTLc/SBoNAbJkWpzN7Pcl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:31d::16)
 by AM6PR10MB3365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 10:55:04 +0000
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e96b:5d97:d0a0:4aac]) by AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e96b:5d97:d0a0:4aac%4]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 10:55:04 +0000
From:   Alexandre TORGUE <alexandre.torgue@st.com>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amarula@amarulasolutions.com" 
        <linux-amarula@amarulasolutions.com>
Subject: RE: [PATCH v3 00/10] ARM: dts: stm32: Add Engicam STM32MP1 SoM
Thread-Topic: [PATCH v3 00/10] ARM: dts: stm32: Add Engicam STM32MP1 SoM
Thread-Index: AQHXDeiB/jNnr1iex0S//SVX9K6UV6p+re0w
Date:   Thu, 11 Mar 2021 10:55:04 +0000
Message-ID: <AS8PR10MB4712FA30DFDD31C536A519E8EE909@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amarulasolutions.com; dkim=none (message not signed)
 header.d=none;amarulasolutions.com; dmarc=none action=none
 header.from=st.com;
x-originating-ip: [165.225.76.169]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dddf5866-db5d-447a-fb36-08d8e47c205e
x-ms-traffictypediagnostic: AM6PR10MB3365:
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB336540EA605B0523323FB042EE909@AM6PR10MB3365.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AuWxbsW/726TvITy0jttou0qTLCIKmxnHLFtLhk9zRC/Mtmrm4kGYuXN2RpbSUyTWzFg/XS2C07YS0vAfNQ0Hx6Z0LNNoq0qHV8AaBu/tllSvg1VwhZ/co+LAcABU70UB3ZB8YNMt9eCdjxxAyP4aX0qh1HCowfEKTESkljJylhaTFNPeuBXmTvjii1OYRI4k5mWuxvrJzaURogbw296dkh3WC/AKDhrtVuHSSA65K+lwk+dXfyc58Z99njqXLGm/txxAnM+Dc5iWDk/VRYAuEO4i8dg9hDTP75mMhoy0difO+Ah2RKhiAOljylAjFN4TYfWJl6tTZJZiFVPsoBwBquYkKKhVdu2ZTgzJJalXmyVqiErkLOH6MgA+lAuPWtXmmPIkVvJzeg3x3ML2Q3kOf7JbPY37/w7bjkEmKVCVTUKozHQWyojxPzkSDt4aMtLh/OPM4aCX85tBJUIsKMeHIU2YrRrgiYCWP50xcxMM5SVx679Rhspjn+IiU6T0Uw50mHn92E6MU3Oh6+gKwQFDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(66556008)(55016002)(66476007)(64756008)(186003)(33656002)(7696005)(66574015)(66446008)(66946007)(55236004)(52536014)(316002)(83380400001)(6506007)(5660300002)(8676002)(9686003)(110136005)(53546011)(54906003)(8936002)(2906002)(86362001)(71200400001)(4326008)(478600001)(26005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?AQz7j+N48vWEv6y2ZXMg3O9+vBwhDFZ41Okn8bjdNf3xLF82jh5TmosXKi?=
 =?iso-8859-1?Q?WCI2M+L5ziK+1mo6PRDKwgvokr+1BfxAwxOnBJ5qhDKfOQsVtRaPQLuE4a?=
 =?iso-8859-1?Q?MgrLLL4/kYdR1J21KLSFKrao4i2xBOlesZjDHpwY5wOomboW7EeXvEN9U5?=
 =?iso-8859-1?Q?Wrgjh4+DxjTo24eUiaoaXOWResOLCJoBE36lcv3BzmuinR2F+HEtAGrT/E?=
 =?iso-8859-1?Q?XwDEgKHAr3pz7koLaJgDRDZj2N28xV3xRv0ohYXESnOwbwelGQ/N1iHvoM?=
 =?iso-8859-1?Q?Vs/tIisksom3reVWwQNakzbqKtAOSjvdC7tVZ6vmHlRanE/IaDsEAmnX0c?=
 =?iso-8859-1?Q?40K++HRX6PS2ZlzBd27vfRvP/U/94+5N6s02sAWu/0kAwsL4Ba0rmFO3zC?=
 =?iso-8859-1?Q?PJHwCCxiEdioT7r3Xfezj2dTDFHaWxWfEwPNx+UWs/iud01d59C1nCxd3a?=
 =?iso-8859-1?Q?7GBFnM5jnojYMKL5fA0pOnAqawwhTOvX61pC5Vr701jx8aD0vb2y9+iusU?=
 =?iso-8859-1?Q?YeTRjy3in3SulMa8Cq1Yxi1T2xt93zlsFgbINryX6MlRws44ANGFv+vI6g?=
 =?iso-8859-1?Q?bsBDFr4au5zLzljog7Vi6ZclNnWWTFofL5F4LZw+zGbL9FvHbpJoszpavr?=
 =?iso-8859-1?Q?D7TUfJzn9SfvUlwCbwkcEnlNCPoOde0FASkTlR1cKsrdO1gqMp9/pPEzrY?=
 =?iso-8859-1?Q?aDkszF8F13KFi+X4v6pjgNrjW/62KIHPxf0YvQerhjsuJ/IHENRSpzu0IY?=
 =?iso-8859-1?Q?EGKBWtKTvGVxNV4cazmnN4o1XF73sADbriSc/2Lz4rTeE3KxvzWDfVPG6V?=
 =?iso-8859-1?Q?9BSnoMKJpK5kcGq8PqwIJ7uV3Vrq3TiiB99bL6v2AOoAYELneou5wEmRpT?=
 =?iso-8859-1?Q?mfmD7ayG30NXVA8pUrAEdpbEbh95xwDPvf19Q0JO2c69B9FVFXDHEbR2dp?=
 =?iso-8859-1?Q?qb4iSvZj2mNEiQjREpjApO7xodfQod/oQ/JGXL3jbIh7ChZvUwK73YmXrn?=
 =?iso-8859-1?Q?2pwEg7LCnaSR/9CmuOwtIDbpRCTf6+QNDbDYw1QCV3Z1vu/1XEe/IAB8mJ?=
 =?iso-8859-1?Q?yOQN5fFSkU4AfvrSB+Btd9dzKtC7EebcmUVEUoOTw98J+tsDYUu61iZw48?=
 =?iso-8859-1?Q?Qdy8ptCnNPvOzhIR++XIPuWvPnQCe35wU5qT1d3rNNhh5L555qqDxO8MAH?=
 =?iso-8859-1?Q?1hQinGReWvup3XEcmNwQDOf1wTXzCY6xwXXDPoMIAO36nej3oEHAOJ5/R+?=
 =?iso-8859-1?Q?00dgASxUvP6Ke2s36ercO78s9i9iNMKrlpT9cZyCxck+iPxzFS0EEwdzJb?=
 =?iso-8859-1?Q?XlGmdgdHosZBvHfvnlUBYAJAh4l/v480FUU/VsBslxyKNsTtu3IF2gNOwy?=
 =?iso-8859-1?Q?z0Az8Wii7t?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dddf5866-db5d-447a-fb36-08d8e47c205e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 10:55:04.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNbTGBLSbnYRAOg6Rg2UzyLW2dXrLz1mo4J16S0+DSU+N0I32xqzGxevg+82yr+MfKAjcntEQmIyM1yTKiAsbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3365
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_04:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=852 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan

> -----Original Message-----
> From: Jagan Teki <jagan@amarulasolutions.com>
> Sent: dimanche 28 f=E9vrier 2021 16:43
> To: Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>; Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-amarula@amarulasolutions.com; Jagan Teki
> <jagan@amarulasolutions.com>
> Subject: [PATCH v3 00/10] ARM: dts: stm32: Add Engicam STM32MP1 SoM
>=20
> This is the initial series to support Engicam MicroGEA STM32MP1 and i.Cor=
e
> STM32MP1 SoM and it's associated carrier board dts(i) support.
>=20

Series applied on stm32-next.

Thanks
Alex

> Changes for v3:
> - fixed v2 comments
> - updated commit messages
> Changes for v2:
> - fixed v1 comments
> - add i.Core STM32MP1 SoM
>=20
> Any inputs?
> Jagan.
>=20
> Jagan Teki (10):
>   dt-bindings: arm: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0
>   ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 SoM
>   ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 board
>   dt-bindings: arm: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 7"
> OF
>   ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 7" OF
>   dt-bindings: arm: stm32: Add Engicam i.Core STM32MP1 C.TOUCH 2.0
>   ARM: dts: stm32: Add Engicam i.Core STM32MP1 SoM
>   ARM: dts: stm32: Add Engicam i.Core STM32MP1 C.TOUCH 2.0
>   dt-bindings: arm: stm32: Add Engicam i.Core STM32MP1 EDIMM2.2 Starter
> Kit
>   ARM: dts: stm32: Add Engicam i.Core STM32MP1 EDIMM2.2 Starter Kit
>=20
>  .../devicetree/bindings/arm/stm32/stm32.yaml  |  17 ++
>  arch/arm/boot/dts/Makefile                    |   4 +
>  .../stm32mp157a-icore-stm32mp1-ctouch2.dts    |  47 +++++
>  .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  47 +++++
>  .../boot/dts/stm32mp157a-icore-stm32mp1.dtsi  | 196
> ++++++++++++++++++  ...157a-microgea-stm32mp1-microdev2.0-of7.dts |
> 154 ++++++++++++++  ...32mp157a-microgea-stm32mp1-microdev2.0.dts |
> 55 +++++
>  .../dts/stm32mp157a-microgea-stm32mp1.dtsi    | 148 +++++++++++++
>  8 files changed, 668 insertions(+)
>  create mode 100644 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-
> ctouch2.dts
>  create mode 100644 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-
> edimm2.2.dts
>  create mode 100644 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1.dtsi
>  create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-
> stm32mp1-microdev2.0-of7.dts
>  create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-
> stm32mp1-microdev2.0.dts
>  create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-
> stm32mp1.dtsi
>=20
> --
> 2.25.1

