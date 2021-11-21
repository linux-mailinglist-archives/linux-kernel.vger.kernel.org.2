Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640084585C5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 19:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbhKUSHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 13:07:39 -0500
Received: from mail-tycjpn01on2123.outbound.protection.outlook.com ([40.107.114.123]:46745
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238414AbhKUSHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:07:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6j/uo6KPUsyES3pvvp9Ilyd9p7KBKAGNi/jsC4xX4XaK3ARepVgt6tul5Jf6uCyuYZRVxDgt1kULKwctxV0VlKdueR3eVxHXTOmploScmUTuU0hEe1G8/2AKHrYo0IQrb3Ay4xBQkJKTfOr0hgD/d7SF74QOVA45YabBD1VDuDc4cI6JMXyAv/GE2+kE8TexMKsKkFx4wV6igFd3jAOSCw5c2KLfbCLQcAmEJ/irBPv99bEiyeDGhyt5MgdoNnJGF/xhVlrXhvXIepnSZutFKvFWKNoJ12IbsAU6oAMuzGYsnKDxfeptTiEnjxmyBE4oP7cgJZ+rnYmpcc2pKv36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+6tzaT7b/IzY5FIDervAUrpq4vXFcQCVQttAp0dYkM=;
 b=EXGPiK6Qh/CldSr4/N9POTUgx+YW4BKIsnZ72KiuE/uQUQAR64DP86gmYZQwQDxk9OO262PcSFVRvsifwRBaZ5ZgK7AlVArokHJOpJPZWfeRG249mpwlHmnK/Zrh1tY/Ef0NnD/O6Tx6crjFMGT0XexYz/cNbpFdUrSj1l/U8EoxJyAh6YA6LSSwduCFXFllRIXb/7e9jSCkUx+T2feNOt1YpooxMpU1ZRK1Tb/zHwl53Ub6zXHsJM8bIuLEQcgUCyt0mTE/AylteOvPyuJPKEiuwEsGPjoBNF1ARoRTLuZI/LWbhvnJj58LlbCtYvnuxw6ZrJBY+3uZXDMuRZ5XwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+6tzaT7b/IzY5FIDervAUrpq4vXFcQCVQttAp0dYkM=;
 b=sW4zhHdgRVZsuYlI7gTkD8TvFAKCsjoW4QKw0byxL9gqtxlXJepg6zh754Vf0jTAu4b65E81+1HI/DyAyJWai2kDJGyu2c9X2wFsp5/E04gpKq2c0sLv/bfVEnAL03QuL9qoQWwuIKEA94HQSyROOtmu3qkM3L2Wda0GPIDP6u8=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (10.242.9.136) by
 OSAPR01MB1746.jpnprd01.prod.outlook.com (52.134.230.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21; Sun, 21 Nov 2021 18:04:29 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae%8]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 18:04:29 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: RE: [krzk-mem-ctrl:for-v5.17/renesas-rpc 5/5]
 drivers/memory/renesas-rpc-if.c:253:14: warning: cast to smaller integer type
 'enum rpcif_type' from 'const void *'
Thread-Topic: [krzk-mem-ctrl:for-v5.17/renesas-rpc 5/5]
 drivers/memory/renesas-rpc-if.c:253:14: warning: cast to smaller integer type
 'enum rpcif_type' from 'const void *'
Thread-Index: AQHX22fj2QL8AZFpBki1abEJjB3N+awHYy8AgAaNPQCAAFyb4A==
Date:   Sun, 21 Nov 2021 18:04:28 +0000
Message-ID: <OSZPR01MB7019333DFA19C76600DEB7D9AA9E9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <202111171118.XlLOUQ87-lkp@intel.com>
 <e448d7b7-0a7d-7c88-271f-75ed5ac7e13a@canonical.com>
 <fb145fb3-61e0-5c24-4a87-5d17420abc72@canonical.com>
In-Reply-To: <fb145fb3-61e0-5c24-4a87-5d17420abc72@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c66d1634-7271-437b-0290-08d9ad195cbd
x-ms-traffictypediagnostic: OSAPR01MB1746:
x-microsoft-antispam-prvs: <OSAPR01MB1746F1C90ADEFEE4550C9DA6AA9E9@OSAPR01MB1746.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNyw7w17Xcd2o5XEsoyFS3SVq90ed1kboSn+b921jPDS+wFsnuytDEGoVf70HxAdO4p/tgJJL1Ml/Az3MraN23DBxayTu/Ior+EO20j9sLBha/1lmpyeYu8AIdNwyXoWNt+VYNRQ7GFjLEt+JAqb44ZdCgYzxnFj3nobqD3envPlngvQO1B4kDTcfZNe1KetQzfx97l8W5IA0K1I1TY79ZiaqvTShUw6fZSQ6XHiLT9d6UQoztNOuXfzlPejlM5IsaCk4UpbJJY14lfx5C9eL6IbENFMYy3sJhaaP6gUTINdx9Af//Eq1Y9oJQQDUnoiodiSxchLOyYPKVIpcqwHHFl3W/qXAogMHCTgjlGrlLd8wMfifqSGrVU2SWqWtL6MZQYcnd8HCh+uAg17nE0wfnQhraK4YfCPho1aLQQv+wiq53C4qCIOdBTbRjmSQ9wDMjWr201pWy/w0Wcqco0sHXPHI+/g0y+eHyZbYbhT8Cnrog7sTEQMSZNy9EGwZbrMICyfN2ZNAkpvm5KDVuS9VRcHoCrGJ7ARymb10WuQhhBzb78Cu40Xxllf1ZtAuZZhb9N0fG+gpHx2d1ZtIkURCYoTmYRlhQsvv8VuJpX5YVzyKejWXzEtp40Tnkddj8egwsXeOH49qXuDW+CiVNCRHqJZqe8pq1q53enKK6PRju0wcsoE7jQTLql5ICzy2SUnUtDiJIEpTiebSyCddxO5rOxEbmcQtbNXCKybnseFKeLPb97oE/EHspfEWq/JNEY4EKh79LHeaWyQMnY94zzPau5xYAzN2Ei0rLNJNdj7MVyIa/4bLnXw0600HGvvQGbMY7IuvWhmXLg7ERybKUUUyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(8936002)(38100700002)(64756008)(2906002)(45080400002)(71200400001)(110136005)(66446008)(26005)(53546011)(9686003)(6506007)(54906003)(52536014)(5660300002)(66946007)(55016002)(4326008)(66476007)(86362001)(508600001)(38070700005)(966005)(33656002)(83380400001)(122000001)(76116006)(8676002)(316002)(186003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KWUw+Tfd736vjH6fTxubK+17xaDj3N3UvePJEEH47OB20QRZ7tZQ/JjO7/FJ?=
 =?us-ascii?Q?NZzbwu8vfempIg2I2UknU9Yte66lNz/P/78i+JK7XUKWu0S/jjp7AwTyR9wv?=
 =?us-ascii?Q?/hTLt9ynbp5jkAeAgegbRnuz7yp+NYpwKlu5+sNjhG2TQTeYmzqwXrkE8DpK?=
 =?us-ascii?Q?JseOGnI3uYxUaVCWlplO0OQvjLnJCAwTq8IRCQXTa/QTv3mUwJ/9km8cyduy?=
 =?us-ascii?Q?FFKB+kf7iu+2RXlHSf3gI8bQ/ohfXOSc3gyxqYTeSFILxf4k9Fz/6TwltkoD?=
 =?us-ascii?Q?+nAX4aoR7zsbxIs7wDXFMk+tpBPR1Hhz5hzcUJUjQhNjaUhIaYxOlFueonPj?=
 =?us-ascii?Q?pfCA9nAVxh5iUY4npQyPjg73nY8AiAy36IG5wkOYhXyRg6WfO7JCqu4Ev5d0?=
 =?us-ascii?Q?c33XlL+eCB8kVPOS7L3ZjPFg3x00cuAo0ly31JWfGWEsJ9HyMHXC4Dy9Y8he?=
 =?us-ascii?Q?RI4M0jieCOy6dp4f0eXvUuXG1AjNyQWMKQhTtso/19rwigGvuoaiNtFlYgz+?=
 =?us-ascii?Q?YsX0zOANgVXz43je23YVUVX2PyCFPsEgKUtkFvo6ee/Msa6QeBwDMcqVXTHJ?=
 =?us-ascii?Q?dE6ywaJo5GSdqhQfZ9fa0rR766WW46OcBcKbBGxdEwIlWSCCSmU4AIxigFCm?=
 =?us-ascii?Q?VlXnblY7aX+hY80w9o+5qlmpdn8tDGGaTVtE0Gfp2NWQPmtdrdlvGrnhQWu3?=
 =?us-ascii?Q?WG1uPipmAK2qBM0pdLDn01iPBtBiWRjAR5AIOiSwOVzoYuxN6co9M9i6gdv0?=
 =?us-ascii?Q?LDpmBcIOSkOGCcuQ+WP/QgADclF5a/UsbdQRRBrsyAv9wsIbgTkCo0dgA4oj?=
 =?us-ascii?Q?txLsdKVNBAZYWlGhufLSzzv36PLHUzBGTO4DEoSbUtEwY+Qo/ucFDPwqY/3i?=
 =?us-ascii?Q?JmBCZJaj4V1mhgc0iJDoXUdH2pShpdX9XpCKxhxu65fD53Cvbadhucq3p5QN?=
 =?us-ascii?Q?VObzAHx3nJzkOAwmAHANbiDnL9PtHfdey20trv1wlOA5m2YoNoURl3fZfydT?=
 =?us-ascii?Q?rrsPDOgymoBftJMj1zU1gO4muVby79NfQ4i/ADPzUZrRmSyMQlG6g2flWDgQ?=
 =?us-ascii?Q?76xPK6cMQbC3V9uLUGofDY/Rbhw3pGAv+nJsxOIPaAAyE1sqceWFdl0o2Qrt?=
 =?us-ascii?Q?6ZdtHcDrQ8+cwa4mBluLSKlKD45RB0sWyaZQx0S1sa/GN4wR+2/VDvn0h+0e?=
 =?us-ascii?Q?jW4O7SfReDqYFiXdqmc/CAb3P+/cH02CS0ABcWJg8y0Jbji2LX0hhMUobOeS?=
 =?us-ascii?Q?go1gYjypF5qCMo31jIAHX8fA7FeVqEO8l0oAuSrlrwRTt/2Xd/HHNtiSjLtX?=
 =?us-ascii?Q?gP8kXemm8snluZf0dAEXQ1E1coaqelVMQIZKyKQlwuRUndT7tBXhdix7ck4k?=
 =?us-ascii?Q?l7Ob1olSrTXU0EzcO+pPoaPa/OstPUWSvVbqpqAmUnZ9b47IhmUQ5dLnjvWz?=
 =?us-ascii?Q?4VAXVMpXE2xqv+1U0BTlr9/F6qXuDM6ny3kwtBiMfuc4Z1VOUHIadUWnfPu7?=
 =?us-ascii?Q?/5/BgWdrutfhj69gJ59PVL8c42U3uYpzsudF7Yek/rZmLonHh4VBwo7NbMYC?=
 =?us-ascii?Q?qd8anVlVfWmbHhCa0fBfTTib/k54TSyQOiTc0s0JWcJj1+9LT9C9BHkDBiAn?=
 =?us-ascii?Q?UKlRuQ8a02M1AhPBxnEQHZ6zTHCcx53rO3Zms3eSMGFnAVJS9uZtRzlZoUiL?=
 =?us-ascii?Q?2zybsBap5783UsCdqNAkISHYTGf8IdmhHX2GSrryDqmhPhpvmXY6yPe0OdCq?=
 =?us-ascii?Q?xoYS2i/Qig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66d1634-7271-437b-0290-08d9ad195cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2021 18:04:28.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMeUs4e4ZTwCw9v85SOL/5M5T9IRj+xcA4ynz+wUANTGDIUlvS5LvHsbe4rcrF+6uLrLVMDydu1m/gxDbEnhV/vNooRkLYsgis1fCh3C97OgBk7R7/iTMYJNShiHUy2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1746
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Sent: 21 November 2021 12:31
> To: kernel test robot <lkp@intel.com>; Prabhakar Mahadev Lad <prabhakar.m=
ahadev-lad.rj@bp.renesas.com>
> Cc: llvm@lists.linux.dev; kbuild-all@lists.01.org; linux-kernel@vger.kern=
el.org; Biju Das
> <biju.das.jz@bp.renesas.com>; Wolfram Sang <wsa-dev@sang-engineering.com>
> Subject: Re: [krzk-mem-ctrl:for-v5.17/renesas-rpc 5/5] drivers/memory/ren=
esas-rpc-if.c:253:14:
> warning: cast to smaller integer type 'enum rpcif_type' from 'const void =
*'
>=20
> On 17/11/2021 09:27, Krzysztof Kozlowski wrote:
> > On 17/11/2021 04:56, kernel test robot wrote:
> >> tree:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ernel.org%2Fpub%2Fscm%2Flinux%2
> Fkernel%2Fgit%2Fkrzk%2Flinux-mem-ctrl.git&amp;data=3D04%7C01%7Cprabhakar.=
mahadev-
> lad.rj%40bp.renesas.com%7C2dc6e2d7058a4d615cec08d9aceac56f%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C637730946616076082%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000&amp;sdata=3DjDl%2B2uGmMvHbDRBNhRYdHcMs8tVpV2QyHjIEvIjmBo=
g%3D&amp;reserved=3D0 for-
> v5.17/renesas-rpc
> >> head:   b04cc0d912eb80d3c438b11d96ca847c3e77e8ab
> >> commit: b04cc0d912eb80d3c438b11d96ca847c3e77e8ab [5/5] memory:
> >> renesas-rpc-if: Add support for RZ/G2L
> >> config: x86_64-buildonly-randconfig-r002-20211116 (attached as
> >> .config)
> >> compiler: clang version 14.0.0
> >> (https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> >> thub.com%2Fllvm%2Fllvm-project&amp;data=3D04%7C01%7Cprabhakar.mahadev-=
l
> >> ad.rj%40bp.renesas.com%7C2dc6e2d7058a4d615cec08d9aceac56f%7C53d82571d
> >> a1947e49cb4625a166a4a2a%7C0%7C0%7C637730946616076082%7CUnknown%7CTWFp
> >> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> >> n0%3D%7C3000&amp;sdata=3DGncdHf45Tf5IFjq650tIcWCQHr8b%2FKi%2BW%2F5%2Fr=
h
> >> WLCZo%3D&amp;reserved=3D0 4c2cf3a314d9131b1b288e7c8ab0c75ac1b2be1d)
> >> reproduce (this is a W=3D1 build):
> >>         wget
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fraw.g=
ithubusercontent.com%2Fintel%2F
> lkp-tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=3D04%7C01%7Cprabhakar.mah=
adev-
> lad.rj%40bp.renesas.com%7C2dc6e2d7058a4d615cec08d9aceac56f%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C637730946616086037%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000&amp;sdata=3DA2rdd3p77C5yTeebqFwISM8aINdbRAbWrsreBV9%2Bcp=
I%3D&amp;reserved=3D0 -O
> ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         #
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ernel.org%2Fpub%2Fscm%2Flinux%2
> Fkernel%2Fgit%2Fkrzk%2Flinux-mem-
> ctrl.git%2Fcommit%2F%3Fid%3Db04cc0d912eb80d3c438b11d96ca847c3e77e8ab&amp;=
data=3D04%7C01%7Cprabhakar.maha
> dev-
> lad.rj%40bp.renesas.com%7C2dc6e2d7058a4d615cec08d9aceac56f%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C637730946616086037%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000&amp;sdata=3DRkD43W82kRZCCNpN%2FqxuQb%2FVNaKkJvgHt8NN8A%2=
BgIsw%3D&amp;reserved=3D0
> >>         git remote add krzk-mem-ctrl
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ernel.org%2Fpub%2Fscm%2Flinux%2
> Fkernel%2Fgit%2Fkrzk%2Flinux-mem-ctrl.git&amp;data=3D04%7C01%7Cprabhakar.=
mahadev-
> lad.rj%40bp.renesas.com%7C2dc6e2d7058a4d615cec08d9aceac56f%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C637730946616086037%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000&amp;sdata=3DunRWu2Zo3KD9lrN8%2BgWHDqvUdcmISul3ynABH8YVj4=
4%3D&amp;reserved=3D0
> >>         git fetch --no-tags krzk-mem-ctrl for-v5.17/renesas-rpc
> >>         git checkout b04cc0d912eb80d3c438b11d96ca847c3e77e8ab
> >>         # save the attached .config to linux build tree
> >>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross
> >> W=3D1 ARCH=3Dx86_64
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All warnings (new ones prefixed by >>):
> >>
> >>>> drivers/memory/renesas-rpc-if.c:253:14: warning: cast to smaller
> >>>> integer type 'enum rpcif_type' from 'const void *'
> >>>> [-Wvoid-pointer-to-enum-cast]
> >>            rpc->type =3D (enum rpcif_type)of_device_get_match_data(dev=
);
> >>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>    1 warning generated.
> >>
> >
> > I am afraid several drivers repeat this pattern and will be affected
> > as well on clang. GCC does not complain (apparently cast is enough for
> > GCC), but still this has to be fixed. Maybe cast via  uintptr_t would
> > quite it?
> >
> > Let me know when I can expect the fix.
> >
>=20
> Any progress on fixing this one? It blocks entire set (and further Wolfra=
m's patches) from being
> included in pull-request and might be postponed till next release.
>=20
Sorry for the delay I completely missed it, I have now posted a fix [1] to =
ML.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2021112118=
0155.9062-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

>=20
> Best regards,
> Krzysztof
