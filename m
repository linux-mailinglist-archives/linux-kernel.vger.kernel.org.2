Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5996040DD39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhIPOvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:51:00 -0400
Received: from mail-eopbgr1410095.outbound.protection.outlook.com ([40.107.141.95]:29338
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230429AbhIPOu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:50:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDbGho3DnZPM/RMqsvWcRyTjTvo4IrhwDwopBzNjA4EtxSkmJGJRt+Gmo0HfAhlxPwQbeFZdWRWwAb3h/T76ZslqPFObBgPfpY6rHTmZowA9ecXkav6sKYe0v0vKDmZsm9EHoaNomN/SctlD5U3FGs0IhgaYTrDjXmg0BeWgWib/4pHSSnMSs33hONjhf9JRCQhETTXxPU9l+mQ0QPmSdqiVkau9HVszxw7DIsvrTQnLdKRj1Fic9aeqQ6tYHceB8iBB34HrLCWnMLv0nD4hdyzBCyQSNGIipAIW4dCI/4niLM0MZXCcElqOuPwuGNJB506og7clWahgTOz8qUtjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dSx5WleECMERMXrY2+XW78trYzyTadB7uj411jAJd/U=;
 b=Pb/34c8LlznHFXMylQQFgyNVISuIiLHmtFehvMf/mGmZc8gjVwhc/HqZD6+Io8mycK5XNcmOGaOolOT6BMDQbu+zS31EnZLYNV6MCmrPUn8a2ojI7n6SOI4EZ2XZ/YltX1WY4sPZI3Wn0C+5cVNtD2dtMz5IMedPwckvfmHAQPSXBbccGRfea7jQsjqAm9+40YMVO7NpS17jXbub5nLvicmO+ZYJG9dIAvjDVO9E7/1QRPoINVyOoDiRxd/NaPf+W7XDJSC4K/jbfp6i/zy59AA9PXwYiwkKRK8SsVYUfiHZjFalZz+4l1nwnHEaeqS7e1L2C0X2N6/2UmxEvkUcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSx5WleECMERMXrY2+XW78trYzyTadB7uj411jAJd/U=;
 b=PXYO3JG3rsHwACpYaeyMvNwIninokQHxrfNXFb0lS37UWSZo/YVfRhddXn8oe3vZIF/Uu6aYKH996uf09nBZ+n/bfRh1SzupjKLPYVWHzc568KKkxvZATkhMBritYmTUGF1F9sUDeL2JI9tVbgnRladB26ZaMV3oS4nHl3PxlRE=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSBPR01MB5240.jpnprd01.prod.outlook.com (2603:1096:604:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 14:49:37 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 14:49:37 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.or" <lee.jones@linaro.or>
Subject: RE: [PATCH misc v2 1/2] mfd: rsmu: Resolve naming conflict between
 idt8a340_reg.h and idt82p33_reg.h
Thread-Topic: [PATCH misc v2 1/2] mfd: rsmu: Resolve naming conflict between
 idt8a340_reg.h and idt82p33_reg.h
Thread-Index: AQHXqmIoVaAOOYULMUeRd8QIb2UsYqumIXqAgACcxRA=
Date:   Thu, 16 Sep 2021 14:49:37 +0000
Message-ID: <OS3PR01MB6593170DE2F869539E6EDB04BADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1631731629-20862-1-git-send-email-min.li.xe@renesas.com>
 <YULVDcZ6xfZnPYXd@kroah.com>
In-Reply-To: <YULVDcZ6xfZnPYXd@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 926194ea-216c-42a4-c274-08d9792134be
x-ms-traffictypediagnostic: OSBPR01MB5240:
x-microsoft-antispam-prvs: <OSBPR01MB5240647168F8E093DA46998EBADC9@OSBPR01MB5240.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vmcB1x4SkBvxIDhSNuqAkQaOGQ8fdgyFNRMOU0OGWCKGVam1CYyI8xvwmOT7uYxNc0b/ZRXM4CQiPsYqERO8WRsKtcqeXL7yBtvWvyzcEgNxBxX7T8hJdM82j1WsgEecTGHs0toJoB/YptBEcgpdzwb9+Qx68Yrh8V6r/KFY8SJeCOJvP7VG5c3NTTX3HD9rqoeG0ztlg0SZxsEszYIuzEYfedddfzlgl0/E6IPyRzfkIq3rrhttfpe5tJ7iIGKGo/C+6lb58+IWwBro7rdFrrjL1hDAMjPPu6GG49qQZCCKpmtJaox38ItZk/dYvDldWcKZ/8kkwVGQgJtdtzEgndOimEezRtZtXmWl+Mk5MTgIMPiFrQ1A5tCYYqjhtf7FypBeaboB8HQ6mIZbQwSYZ1N5wt8rt8EjKfP0pPUquGeKWrfkFocvqKeb7quZKVbCFf61b69cYnhemQIVKoFdbiNCLQEJ4YwDK3AV5b8RxrodvsfC2u1O7+S4YwF2DxgH9jSAlpwg82JnG+7Hfwba2bgiC4+fvuQtf73uIMNWlhFSwag4d9LuyLbAYJAM5htu/1j9gwKWNY9gNHlZNA35c3J9NZ6uCjKBOu2Jdb52VoZZyY3Uy091U9vl91E0GPrv/fRnZY4h5yQforZ/3eqf3YKjWSUSV7JpcD0lu34Ir4A97BcfS+1KzoZaEOvy1hkETNPGDfREUsxeGxeuZXjMKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(122000001)(9686003)(55016002)(83380400001)(33656002)(6506007)(508600001)(4744005)(5660300002)(8676002)(7696005)(52536014)(38070700005)(66446008)(66476007)(186003)(66556008)(6916009)(8936002)(316002)(64756008)(66946007)(86362001)(4326008)(26005)(71200400001)(2906002)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5WM3nj8QFcvNsyXgqk8bnKtKz4lUrs0M1v0/pqZB/s8HBjtkImPrJWgyuKX?=
 =?us-ascii?Q?AK7H38NT2R8EtGPIpNAu9cC+865cUsd3IVmcysrWQlcjoqlgsVZJfsiFB57X?=
 =?us-ascii?Q?Fd9Rt8J00dTm32clN6U8/6oWB1nOmUuYZ6mLQwhFnSbtQJ8vS4/HTycYp+jU?=
 =?us-ascii?Q?orP1W1qSYcF/CoqvqstvHpcCp+U1lNmNTloBVjLesjU+wHSYOiNfDpHoR39z?=
 =?us-ascii?Q?oxRuT+i+NU9r4Fu9IkDjbiGMAayEqrfTBTzLBaw7QNHx9+G10pLNIm8VDTso?=
 =?us-ascii?Q?NKx5+1rlTLZbg3HqHylJ+4BOL6J1RGdQeji/amwdXjXtpHnMOeZ6FsZKLpKp?=
 =?us-ascii?Q?frujAqkf76yCDDdvtbPuphh5UEuuH8HNtcHRZJngk+Zt+olnhMMKBrxgRmxd?=
 =?us-ascii?Q?y60LZS8/ofNVryRF/gfcq0IG3r6u9IEEQ7zHPJrO1I2txlDCAlfdXo+WB/sP?=
 =?us-ascii?Q?8HlvADVOtRZU8jzP1fO7pNvpTbycKP04wr3anj48L9dY2W1IB9bv+fCzPsf6?=
 =?us-ascii?Q?pm3P+yRRkFAh/OYysQv5uz80moUHrPtyRpd6LKufmuylJphG65PA/ku64uzU?=
 =?us-ascii?Q?DozLndsioSnlty5K1j5VaH/hSyO1BrhWk1W4OC/v5S6FrudGVHWNrj/Weqe4?=
 =?us-ascii?Q?gqUCpcG2EwkyCCj53PqoHdyFNib0MbZUgzH/o/50Mfm6sL1OOBV5N1GjjNQ9?=
 =?us-ascii?Q?JWHAxLnM7MPkMx/kVTh+q5tAwJYlQHvZSKpft12AbfmmRakHZyFXNG9aG47L?=
 =?us-ascii?Q?psc+ndP0+BDuIhynmhRcA68K2vAJU95ajwulGY0HJxZAMys2W0XxWjy52SJ1?=
 =?us-ascii?Q?yaf1sKW/AVTpeEzjtRQ6bsLOJn/9poAHACfdtjgvnmK1gpYGpuVYr1avFmkk?=
 =?us-ascii?Q?ZTLLwcnwdpXSe0RTHsgSLebz4pNtaK1fcTFOAhVTrMYS8c3souU8icufxc04?=
 =?us-ascii?Q?vhYnueRNNvGWuvui+vPY0FotL79mXlpwKe5dYuvxNKFIKqd6uQbh34Y8OfVX?=
 =?us-ascii?Q?7zUoENYsnKdIJOMf1bqdBnpmCHdWPB46gWfjfxC7NfsuadZmcpsBt4vEpQrL?=
 =?us-ascii?Q?AgoUhswUXwCJHgxYQQ9oMw7OiwROpyw0Cp707aNopI7UUMVjyyvsmTjbF4U9?=
 =?us-ascii?Q?LiumijSV/9m5+4r8cr4gohh6nkB7p15KTOfmkGxXET4gqLlJQadtd7mDkogt?=
 =?us-ascii?Q?v96rz14q9WTRmkY4N9KlWe/xnQ+bDqt3oLpUX5d2g2eSnzhpu5tOjoex9ZrF?=
 =?us-ascii?Q?xS4Occ8KKxRt3xDJ2nSQQofNh/ZbbHiJj5/VVYvW/vZEUmG1dPjHkduIg2Zg?=
 =?us-ascii?Q?P94fDP9iXd8D37wep6rJsWFI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926194ea-216c-42a4-c274-08d9792134be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 14:49:37.3911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xkj/+DhUD6xx30MCLfEn0Y9cRj/ffu/hDwZLypsXlUNSddKMhlYGDrc463Qywp4/KtGnUy/YT4C34kiS/rSz0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
>=20
> Wait, how can this patch on its own not break things?  Are there no
> in-kernel users of these symbols today?  If not, why is this file in
> here?
>=20
> confused,
>=20
> greg k-h

Yes, it is standalone now but it would be used by this driver and another P=
HC driver that I will submit later.

This file provides register definitions and belongs to the MFD change I sub=
mitted before. The MFD driver will spawn 2 devices

1) ptp hardware clock device
2) This RSMU misc device

The plan is=20

1) submit mfd change
2) submit misc change
3) submit phc change

Min



