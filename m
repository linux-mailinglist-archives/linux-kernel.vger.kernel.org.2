Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2543357516
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355682AbhDGTn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:43:59 -0400
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:18242
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355674AbhDGTn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:43:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VccXXVGS6ViFKon+wTnllIQjyAYs3TDjnL4Sw9eCGbrkH2HzbSnE4yAYJA1/esapunGHlSuBZ2cwxFUimnzWzOgmQQr2V0i22Le2Zr2s+yKsy3wedbavP97YirQR0EMXZ1jzdcgUDmF4hpbPLUSJz7SyRIusAby6My1dUIeroXvpd+3x0nlc9Er4HKfX+oVvyMeJ+DIt94Hw3wDZkA3eYBPlQPs7YwK8Cke3tPwdn6FynCj9DY+aITUeznS4DbnW4NWYLV0wwmJwPsSmmPscyoDLI7ogqNU59bIyTlG88lHbqe0G+1RD0yg9vvDPEhhul9ztDGfXZ7ppw/BkONEozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfKiu9Y0lzo3rdRCeSSckjrw65k22/cc9PZDmwfMfxQ=;
 b=RPkV21sOnu0AVC05lTwO6tE5dZ1oqV/4k4fmIUQgSReClsnwJDTui3pWN98hFPMUB5F3VNYhSOofOna7xvtVMpeqD+HWAZm3CJO8g0+R1w65jTS9HxpPZ8lVOiWRoyMUVtZbpNuPX8b85AjhLseWrOPipTWZc9sWqtLgVwRZ6ooIOusXmZs7JONwXXc173j9c9mwRUkppKB7FpUkZTKQndrWhR3ZXEk9fybhrpd+EgA3nHnniOULZaaSiDGr12M/fAEbTzP3CoFGNeKRMxqcNNtHd9LCzim7Lhaq88nYQgmwkMtn7uWGSCTk2JLFwz2tf+A1bxWbwtMSNhaK+JvKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfKiu9Y0lzo3rdRCeSSckjrw65k22/cc9PZDmwfMfxQ=;
 b=H8r0BjTIiU9vTgAE8cTR1/AiFRx7c4xIBCkwnrZgDFMHHCeAxtsNRIj+AODvRmw4OomcRRBx7OsqLApOXlU2EwfyGq337d9fJOvT/3afvB+hoicap7oRF9RjYc9J+WdnRvo79vOOOGW/ZmpRJat+1BStGQ7hVPil6b50rEdJdOA=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSBPR01MB3095.jpnprd01.prod.outlook.com (2603:1096:604:1d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 7 Apr
 2021 19:43:45 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 19:43:45 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXK9TmRDzfnJqVl0Sq9GK4xidseaqpU/GAgAAY4uA=
Date:   Wed, 7 Apr 2021 19:43:44 +0000
Message-ID: <OSBPR01MB47733C009A6B6F2F697E12ACBA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
 <YG3vu9XQ94w5dlbp@kroah.com>
In-Reply-To: <YG3vu9XQ94w5dlbp@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d0448ec-74a0-4408-8f80-08d8f9fd74a2
x-ms-traffictypediagnostic: OSBPR01MB3095:
x-microsoft-antispam-prvs: <OSBPR01MB309511ACF8B270A96E76196DBA759@OSBPR01MB3095.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4GLPIrG/fz4W/BrvXX2MWyRwYoMK+PS1u6uf9C0gM4yNHCoK8TE2kg1P5/b3L3om2GbhC56MeZzqPf7VtpqU3Kz0V+97N5+YZ0qNiincj7UAZ6L28lu5qkoAONh2tYtZgS7XeNRu1GfOjvTdF3Iw+PvO7Sp51m3eQAcA8dkOfXSE6Ty7dG4agqpIjtl3nNgcdN2Vrb25JfdjkUrd8M6j9+Hz4b4SH8XKM2tDlKGIxadsOlySzXsWzlTgHcORxtuQ2T0wHwpkTZJNjMOinp4x+omx/5/ZvrOwCWw72XDWWNdtmS6tKOzhxHtb7rx3SlQ5/EM6iy4b9ayT9fmrVYWqmB8wc/S2YC1TEH/NbbXhMvsiSDPkyq3fEYrVN/gS06Yp9AuFrwmPE8+Xlbq4hANaTEnqjq2URj22Vsu5c5dBBcB/trtC0BtzHKBkgQ7C9oU83TrVE4m2MMJaVM7Z7bPggZkLCZphYWA29G7R5m1i4eC6aePHcWEOeO1vKu9PxLf3pf4nFi48ZKxtki8rk1Hz0BKF17e+Nexsm3/SLVZwDSUv2ztj4MEBhdkwKXzMyMR8S6YR7m5x7j+6Aa0CfLhTAjiL945W5qHYHU/bDgXgRNcD1nlUouIknuFtXBWf2KclsOOWuZypoPVbk95g1ss8Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(186003)(316002)(26005)(6506007)(2906002)(7696005)(9686003)(54906003)(55016002)(8676002)(52536014)(71200400001)(8936002)(66446008)(76116006)(478600001)(66556008)(66476007)(66946007)(64756008)(6916009)(4326008)(5660300002)(4744005)(83380400001)(33656002)(38100700001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fkfJtsfeccNk+4kJJXssxuGEBMfONtId3q7qfSrVGDPs3Tzg32U/B1SITGCQ?=
 =?us-ascii?Q?a5orQwEogFoJh8J3r9vwjD9P0Lx7ziJiF8ruOFViKx0aIa0YpdQlYHvKpTwH?=
 =?us-ascii?Q?6jq5t/YWA6ejvfFgbLZiblPusSDN6I25BHAFwRyW/NDnnkh5A0k0YXRFI4/o?=
 =?us-ascii?Q?aIgsF+nPqVCUA5++9Ke+FjK2/Fi0p7mzhZowXMoEvihswD2Xjju3D/d52LgV?=
 =?us-ascii?Q?u+WIjzEQYSoxjhOXGNaNhUvYV09jAoqCNg779qDwxb09F9oNdHupM1QZ3OEe?=
 =?us-ascii?Q?1uxpR8wqdNrPXl31diR//hkFTIAxaQmKnGaexn8vw17FlCakVXHhV88ZXPKw?=
 =?us-ascii?Q?RJkQDR7DghwWU+9EjlipuaYUk273293rCaoZBcF1kQE5agibCBmnVGlEnusX?=
 =?us-ascii?Q?winC68usNQ2RTU/RYf9mMcxiTWHVQJyxsVSlvpvVQOMs1z9w4aUlpg1i+Hem?=
 =?us-ascii?Q?YlTKBl+Iqv8JItYLQP6NfvI3TvWj5cxVOuwFaM4CvSk05+6Ombg0aRT+pDsN?=
 =?us-ascii?Q?hAddPkAuYfeDSujQ+Cb4aie02TZqaRBiw1hIwpschP+ytDt+77z2EDA7H+eO?=
 =?us-ascii?Q?QN5dZFmjE6zjcUXthC3k6ipqESij+G8lW55YBu57bVE8A8+0yvzpkuPbb77s?=
 =?us-ascii?Q?f3i27K6yrqqjE6nAsImxmi3Qln6EmmYfJQd1D+F5pNzosTdfiXLpwRe3sVax?=
 =?us-ascii?Q?XSSdUe0xbV1J9loUnczdVWw1zHBQ3inzGPNvmONvQOON7UTTlcel4eefXRVE?=
 =?us-ascii?Q?euwBDLRW0tV68pGNHq+0y/dnwXhmNrNlWHiwrO9PcFbiNDGSMoyLkND+0Cz7?=
 =?us-ascii?Q?9G1+uLQ7htolP+/yTt4HaIWyo6h7MeIFiAytcyygpTY4nXBJ4IKZ3jJV4TM9?=
 =?us-ascii?Q?5fGLhPFHr32wxVnIgJ+P27KBW1ljPTJ8IFBnV5dib4Z53IfkkRafBHijFIwr?=
 =?us-ascii?Q?NOmCRmAXJ4X6OnrcxEU4nEaT67QgK5PnYr1hEqmFxDIyCb7+Dw3elOUyD54/?=
 =?us-ascii?Q?AgmdOHQ7AvzYwJimJRuC6WVTjRGPWJfoYvcXMdISWhBAnZUmzrJ7f1OKt1fb?=
 =?us-ascii?Q?vnMmn27tVtnKHbYQOIThY0qx/1cNptfKhGooFN0ah49QEBHQ1ZfqKIpm2RGq?=
 =?us-ascii?Q?b/BR2ekEm7mbG05FBkRtuAYUKfeL/snd7nPb1K6hqeWwqQAhIjMmD8Oj8NUO?=
 =?us-ascii?Q?qZ/1ufwLNByuOd0T815nuut0LqcF9cZHfD1jGAGnr4b0dX4WoYnTkLvXCbgl?=
 =?us-ascii?Q?wAHrfhST4/xVGaUX5vfLixyH5LmKr7SbB727kjUGggeuNhfaZJFmd2B5h4z1?=
 =?us-ascii?Q?hdRDmMRn5LfwWGP/YigZ1foh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0448ec-74a0-4408-8f80-08d8f9fd74a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 19:43:45.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sskr4EArs/19JKAt3W6nuaNqV0L2p3ZHIvVInTVlRMj3St9nkJ2UA9NT5O8QT870kBglXWAWwXfA+o/E+uP0/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Why do you need 4 files here?  Can't you do this all in one?  There's no =
need
> for such a small driver to be split up, that just causes added complexity=
 and
> makes things harder to review and understand.
>=20

We will add more functions and boards down the road. So the abstraction her=
e is for future consideration =20

> >  include/uapi/linux/rsmu.h |  64 +++++++++++
>=20
> Where are you documenting these new custom ioctls?  And why do you even
> need them?
>=20

Other than comments in the header itself, no additional documenting. Do you=
 know if Linux has specific place to document custom ioctls?=20
Renesas software needs to access these ioctls to provide GNSS assisted part=
ial timing support. More specifically, RSMU_GET_STATE would tell us if a sp=
ecific DPLL
is locked to GNSS and RSMU_GET_FFO would tell us how much of frequency offs=
et for the DPLL to lock to the GNSS.

Thanks

Min
