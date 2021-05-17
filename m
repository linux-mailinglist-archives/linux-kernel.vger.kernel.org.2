Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB77938272A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhEQIiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:38:24 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:46224 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235286AbhEQIiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:38:23 -0400
IronPort-SDR: jCI6qzrQXU5R62EF0XTllF0IIX/HwQswt/VJKf4T3jnASfPJate8ZBRxjAiAMDqnp+pFc5TDla
 HuC4oW+ubgielLGQOGZk7GoPLXRlEv7hQ/2y9jFNWuThRBncXtB8sJKvPBUDmY6n45Vw+Cm54P
 +QCvS6zvoNCkjBOGT4ycGoyDS8H1g2ROnYoSZgbRfm/0AYhNEm4fL+AwK0uZz2e13fJ4szEFh2
 /KICWi/hNMWUwqOisiCC6qWufPKNqELLKF4jIYL9Ccvv4ZSgZoTvze3dDXJu6TdOZizu2XC+Ld
 LmM=
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="31362932"
X-IronPort-AV: E=Sophos;i="5.82,306,1613401200"; 
   d="scan'208";a="31362932"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:37:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLow6LtbyeT8XHlSnby+m+BkIAf2zcmmMFVps6A6J2Hs1QIs7NSSAymztgey0spbCC3ifKBfYll3vXX+UaEEiurz0t3TWrWrZO0mwgM8V7YuC8LXVBG1ZxYicy1isZmLKn9ByfmciXkYnGm8n1jbZFcuvtaZaOTnXm493uduGUosZrlKw3KNq4JLlyOMhGOqCyrzb3KGNn7v3RfTUHnxzVsgIrgIbi4mOO3nGuPGwNdykVCN9Y1trkqOzZcpEOB1QPY1X3jJBw1vXfd/XJE8EF4xUDPHnqvsDJ1P1ub/sNOAJepr/UrytDpbVv7RiY5kUWQfGXzYu5KjLw3jKecx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9CmseLTMYIPVPvrNJLB9jOGRyeWlWYAhuvH962wlh4=;
 b=Ax55l+u5hH8et8w7xQ9yiJ5IjyWRP0CFavn289vVcNDb6QvHKke3uEMvfpfd6mgg7/4zBTJO43lxe+YnlzMiUi6WUy6NCaf15GR0uqZf14NJjKIzoL70kpDjdXQ/rYrHK4IbEgxwbONGGqzBKIGe/zIW5lnD8EDqGfW25KWCz1eKTlJj+YrZXqEqv91ZtYCQzCStzcHjHI0gE1i5V/0yNoPNiJ/tI4l++FmoO8K9UIuGhfl1ivmGtuFlDJTZ9m8A6gsDUH+hviy6/grDzwp2//BBebUk6PR07rCWKocF8Bf8zXM+Rx1oumj//EMHWw51nWXZwqrWsFAWkozhoQ0ylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9CmseLTMYIPVPvrNJLB9jOGRyeWlWYAhuvH962wlh4=;
 b=f5LjQK3/ksZN7NHoingXqPawlSZ97pZjqsooVBuImc+FPyD96iwBOSSplVe5tEHq9s/q1tZg6j0c60Rl4rmikhFRopqAI/ybMzVt1uA4psMpJipixWhWEUTTBYu/dTqYVhuEN/d2kZ2POYTmS55pzgeOa0bGwhKcm5/6Xa970fk=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB3021.jpnprd01.prod.outlook.com (2603:1096:404:80::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 08:37:02 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 08:37:01 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: RE: About add an A64FX cache control function into resctrl
Thread-Topic: About add an A64FX cache control function into resctrl
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYAFB/HO8A==
Date:   Mon, 17 May 2021 08:37:01 +0000
Message-ID: <TYAPR01MB633050EF44B5071B97917D208B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
In-Reply-To: <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea13ea8b-2419-45b7-8e8a-08d9190ef164
x-ms-traffictypediagnostic: TYAPR01MB3021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3021663BE9E44093F8C441768B2D9@TYAPR01MB3021.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HB3Vc5qYzfa5pdmcHBn9ASvY7tb3sTcYNQTw0beGlDRwkBw8ugvWG5XJDgtPhTMEWqQzTldu6ZgjpQq0cyTmZ1R67IGC0waZ/AD39HSXffHme460SiCsZSwdD8rf2CeGl8IQki8aGbH5ZTqRHKSsgL6zSbr6zxYF6orwEd1w3aW6jLEaGMivM+UleayrHXcC4k7mBasIrXnuRiX2XRTNSYbGg/KJ0GeOEm7JiwWUCWyVXs/xkeO3VDYej+ZLpjsrChKQCMhu5o7Q8mO4TIygvdo3Br7D8tkJlHlCblp2ARrU3IWyMbu12hkyP17WCIvFVzUL2ozWmroPcaguLs7vZvfsUpnTNVGEHH98Tb4yJy6rWGvv59uPShDNhRlKuRLCrs7asxisuPNtbaaC41NFhSmfBytVKibn8W+pnc5lLisp9K9rqKNKMtOKdf2odrYiezBuVzv+ioComUtba7awwKPb4y2pI0FvJtd2VbfKCUP7GygcXDtEYDPv0tj0g9sRH0HfweSR/ErXqFST2gEoKJKo3oEWOMiXTqrQWgGfSWKlLPkHat2DsdNjmppRBRb4gonMj2XXU10xo2q/lDZ7OhZaHuS7ivU6GflGO3ny4UT1wCIIAeXgqerxGCfw5UaEsOjmfj6MqQUWBSeRlPqNC4ucGoxZTmpCe7Bx1eORdbOE0uzdg/mv+cekErP2WcUW2lTnivDZnl+ONQVexTrfTJtZy2AdBIq7lQLlhCih8BdR8DTMqUaFSGuekjFORv/L0knYPk/mqBXoN17dR1Dx3YqBWHzXXFixzxlYFz8L7ib/t5Q2og09r4yZU4knakrZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(9686003)(966005)(52536014)(26005)(186003)(55016002)(54906003)(4326008)(33656002)(8936002)(76116006)(122000001)(107886003)(6506007)(2906002)(66556008)(66476007)(316002)(64756008)(83380400001)(53546011)(7696005)(66446008)(38100700002)(71200400001)(8676002)(85182001)(110136005)(86362001)(66946007)(478600001)(5660300002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?b0F4b1BHTU5FQk1Ub09pb0lpVm1GejF5S1lxNlhLdjhybUJBdVhjUDFM?=
 =?iso-2022-jp?B?eHdRVSsxTWdoUlFoVEJYQURmdHpiQWl5RWJleDZWdVNETXhRRE5QRU50?=
 =?iso-2022-jp?B?dXRjRE56K2xvTk0yT1dhZm1JUmRmOVV2eFBuczlDV2xLM1Ixa1hYU1RP?=
 =?iso-2022-jp?B?NnJoUElHdGVpYVhtNVdkV2xJRFlhaFh4QTZoWDJKaFBTMkN2ZlNIOGdQ?=
 =?iso-2022-jp?B?TVo0Nk1EQmR4cnJ3Qmg5TDlHeDEyYlJvOUYwMXV2YnkweVpCb3EwT3hv?=
 =?iso-2022-jp?B?Y21Qb054cGJKbjRDMUh5SlRFcjdnbXBjeDdJQ1RSRWJSYlZGR2ROdnFx?=
 =?iso-2022-jp?B?Z1Y3cVlpckMvaDYzRElyQmg2Nk1TVXo1eFVmdnRpNTZkY1pZVStRWVVw?=
 =?iso-2022-jp?B?NDI2ZDZ0bG9YKy9xTXUzU1hnRnBibDlNbUVBb1NWOG1WT2FEdVVoUy9H?=
 =?iso-2022-jp?B?dEtpdXh1dTlDTGhrbXJOaXFxbkNBTE9qaE9uUTJvZVcyY3VuS2J2VjJm?=
 =?iso-2022-jp?B?V1YzeFE3UnBINDFMNzRJall3WTVySk1xbXd6ZlNscEY5eEwvL2o0c3Z2?=
 =?iso-2022-jp?B?WGJYaEkzbFNibUZ1OHVZWXp3Qk5lWEYzZWRNb1JhZHIyeTJrOFF1WG5Y?=
 =?iso-2022-jp?B?ZnVONGdJUUY5dHhsc3R1SThjT0dnSTRQdTNFV2I4OW5TY3JVakg2Wmlj?=
 =?iso-2022-jp?B?citJOHUzMmtBam9yeHJqVXJCZlNGeEdwdEZ4ZnBEK081N2x4YUVKVkN3?=
 =?iso-2022-jp?B?ZGlXb3F4QnBRK1Y2V0pzWW9QVnhCOG9DSGNhK2FSOFY4UldxN1Z0VDkr?=
 =?iso-2022-jp?B?QmFBL0owY09SOTNlaFNyT0Y0MnhTNDFmdVE0WnpadTZZV0gwK3FsVVR6?=
 =?iso-2022-jp?B?QnB1OVRyeGR1c0hUQmpSR2hqZnNXeTVobVFVR0c0MkpGTE0vUjE5L3pQ?=
 =?iso-2022-jp?B?cko2OW5CeTI5ajR3UnJyZmpaQzBwQ0NqdE52aVpzWE9VZEJLMUtyTkVx?=
 =?iso-2022-jp?B?WitZSk9rTm5FaTRxR1d0RlF2Y0w1VHhFcTdBWGtBMzlXdGN0TjU1b1Jt?=
 =?iso-2022-jp?B?cDVSbFlMTmxmYnlEOUZOemVJU1Q4L3RXNjl5K0FhNFl6UTBKQWxDbVlS?=
 =?iso-2022-jp?B?NWpxVWdXblNtVWlkU2Z5anE4WEN5dzBzSFY1bUJIR0lwdlhQZG8xTG52?=
 =?iso-2022-jp?B?aXZ5U2pNMm1rTm1tMjFDQXlsUVFKUzNyYlE0dVFqL0ZxcWdyT25XMXRl?=
 =?iso-2022-jp?B?Z0JEYUxUdUxYZnRIWEpXNHo3alhMVzVtVkFsWE0yUnRGYnFUNFYyTE9o?=
 =?iso-2022-jp?B?akROVnUwa3FGczUzdDg0bVIvMmtYaFZDbnhEbUFUNFJYRlFMbzBzRU0x?=
 =?iso-2022-jp?B?Rmd6TEJtOEZlM3FpajVFMGVFTCswK2o3T3JWWERjb2RGV1huTlhzdGZX?=
 =?iso-2022-jp?B?YXlDeXVDYXFjTWo3NDB6NCt0ZndoLzJBck1XMWd1K2VLVTRST1JaYmNq?=
 =?iso-2022-jp?B?eGNLbTkwRUdTNElHSGQrM3RYTi8rZTBYUEY1RHpHTlJHUmNDc2FMOVVE?=
 =?iso-2022-jp?B?T2dRYzBPdGNjbnJVSEFGRHpkZnZtenRma2FBZkN1KzhYako4V2xFSGUr?=
 =?iso-2022-jp?B?ZktCYWRTbmNTd1IyMms5UVJkZ3gvbXNIS0xWZm9nbGZDNjhqZkdmYzBB?=
 =?iso-2022-jp?B?NkZKS3N3MnRYYUxnL0lXcGltWDlHS3BRVXhXZFJjcHlMR3lJZ3h6K1h6?=
 =?iso-2022-jp?B?a0YrTklwdXFHOW5kdU41b092UFR3c2thdzBpcDVzRU5wWGd1akQwWW1Y?=
 =?iso-2022-jp?B?cXd4R3MreW1XeG1OTDBsd0RPQ3QyUHRxbzFaVkI4WWtuUXEwQ1NmY0FL?=
 =?iso-2022-jp?B?Wlo4MEpvZUxEcE1QMUFWOVhhdG5ZWEljQTJ5cVFGdnZxNHE1KzFYK01a?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea13ea8b-2419-45b7-8e8a-08d9190ef164
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 08:37:01.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7adi9bLOf2xULViz56GUsX6barFLNq+eQx5eH9CuPfj4Q1m/9l7IAzCywvSFHzldgXMli9OckYidfnnMTbwnlNPQXd24usCkUPG+rmBjmTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

> On 4/21/2021 1:37 AM, tan.shaopeng@fujitsu.com wrote:
> > Hi,
> >
> > Ping... any comments&advice about add an A64FX cache control function
> into resctrl?
>=20
> My apologies for the delay.
>=20
> >
> > Best regards
> > Tan Shaopeng
> >
> >> Hello
> >>
> >>
> >> I'm Tan Shaopeng from Fujitsu Limited.
> >>
> >> I=1B$B!G=1B(Bm trying to implement Fujitsu A64FX=1B$B!G=1B(Bs cache re=
lated features.
> >> It is a cache partitioning function we called sector cache function
> >> that using the value of the tag that is upper 8 bits of the 64bit
> >> address and the value of the sector cache register to control virtual =
cache
> capacity of the L1D&L2 cache.
> >>
> >> A few days ago, when I sent a driver that realizes this function to
> >> ARM64 kernel community, Will Deacon and Arnd Bergmann suggested an
> >> idea to add the sector cache function of A64FX into resctrl.
> >>
> https://lore.kernel.org/linux-arm-kernel/CAK8P3a2pFcNTw9NpRtQfYr7A5Oc
> >> Z=3DAs2kM0D_sbfFcGQ_J2Q+Q@mail.gmail.com/
> >>
> >> Based on my study, I think the sector cache function of A64FX can be
> >> added into the allocation features of resctrl after James' resctrl rew=
ork has
> finished.
> >> But, in order to implement this function, more interfaces for resctrl =
are
> need.
> >> The details are as follow, and could you give me some advice?
> >>
> >> [Sector cache function]
> >> The sector cache function split cache into multiple sectors and
> >> control them separately. It is implemented on the L1D cache and
> >> L2 cache in the A64FX processor and can be controlled individually
> >> for L1D cache and L2 cache. A64FX has no L3 cache. Each L1D cache and
> >> L2 cache has 4 sectors. Which L1D sector is used is specified by the
> >> value of [57:56] bits of address, how many ways of sector are
> >> specified by the value of register (IMP_SCCR_L1_EL0).
> >> Which L2 sector is used is specified by the value of [56] bits of
> >> address, and how many ways of sector are specified by value of
> >> register (IMP_SCCR_ASSIGN_EL1, IMP_SCCR_SET0_L2_EL1,
> >> IMP_SCCR_SET1_L2_EL1).
> >>
> >> For more details of sector cache function, see A64FX HPC extension
> >> specification (1.2. Sector cache) in https://github.com/fujitsu/A64FX
>=20
> The overview in section 12 was informative but very high level.
> I was not able to find any instance of "IMP_SCCR" in this document to exp=
lore
> how this cache allocation works.

Maybe you have already known, the sector cache works as follows.=20
 - Set the maximum number of ways for sector (id =3D 0/1/2/3) of L1&L2=20
   by setting the "IMP_SCCR" register.=20
 - When running a task, the sector id is specified by [56:57] bits of=20
   the virtual address. If the sector id is not specified, the sector=20
   id specified in IMP_SCCR_ASSIGN_EL1.default_sector will be used.

> Are these cache sectors exposed to the OS in any way? For example, when t=
he
> OS discovers the cache, does it learn about these sectors and expose the
> details to user space (/sys/devices/system/cpuX/cache)?

These cache sectors are not exposed to the OS in any way.

> The overview of Sector Cache in that document provides details of how the=
 size
> of the sector itself is dynamically adjusted to usage. That description i=
s quite
> cryptic but it seems like a sector, since the number of ways associated w=
ith it
> can dynamically change, is more equivalent to a class of service or resou=
rce
> group in the resctrl environment.

I explained the difference between "sector" and "class of service"=20
in another email.

> I really may be interpreting things wrong here, could you perhaps point m=
e to
> where I can obtain more details?

I'm sorry, there is no documentation other than the manual and=20
specifications. More details about how sector cache function works=20
as follows.=20
(1) By setting the access control register IMP_SCCR_CTRL_EL1, cache=20
    capacity setting registers (IMP_SCCR_CTRL_EL1, IMP_SCCR_ASSIGN_EL1,=20
    IMP_SCCR_L1_EL0, IMP_SCCR_SET0_L2_EL1, IMP_SCCR_SET1_L2_EL1,=20
    IMP_SCCR_VSCCR_L2_EL0) can be set from user space or kernel space.=20
(2) Set L1 sector cache capacity register from kernel space.=20
    By setting the register IMP_SCCR_L1_EL0, set the maximum number=20
    of ways of sector (id =3D 0/1/2/3) of L1.=20
(3) Set L2 sector cache capacity register.=20
    (one of cases) By setting IMP_SCCR_ASSIGN_EL1.assign =3D 0 from=20
    kernel space, IMP_SCCR_VSCCR_L2_EL0 becomes alias of=20
    IMP_SCCR_SET0_L2_EL1. By setting IMP_SCCR_VSCCR_L2_EL0 from user=20
    space, set the maximum number of ways of sector (id =3D 0/1) of L2.=20
(4) When running a task, the sector ID of L1 is decided by [56:57]=20
    bits of virtual address, and the sector ID of L2 is decided by=20
    [56] bit of the address. These bits are programed by the users.

> >> [Difference between resctrl(CAT) and this sector cache function]
> >> L2/L3 CAT (Cache Allocation Technology) enables the user to specify
> >> some physical partition of cache space that an application can fill.
> >> A64FX's L1D/L2 cache has 4 sectors and 16ways. This sector function
> >> enables a user to specify number of ways each sector uses.
> >> Therefore, for CAT it is enough to specify a cache portion for each
> >> cache_id (socket). On the other hand, sector cache needs to specify
> >> cache portion of each sector for each cache_id, and following
> >> extension to resctrl interface is needed to support sector cache.
> >>
> >> [Idear for A64FX sector cache function control interface (schemata
> >> file details)]
> >>
> L1:<cache_id0>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D<cw
> >> bm>,<cwbm>,<cwbm>,<cwbm>;=1B$B!D=1B(B
> >>
> L2:<cache_id0>=3D>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D
> >> <cwbm>,<cwbm>,<cwbm>,<cwbm>;=1B$B!D=1B(B
> >>
> >> =1B$B!&=1B(BL1: Add a new interface to control the L1D cache.
> >> =1B$B!&=1B(B<cwbm>,<cwbm>,<cwbm>,<cwbm>=1B$B!'=1B(BSpecify the number =
of ways for
> each
> >> sector.
> >> =1B$B!&=1B(Bcwbm=1B$B!'=1B(BSpecify the number of ways in each sector =
as a bitmap
> (percentage),
> >>    but the bitmap does not indicate the location of the cache.
> >> * In the sector cache function, L2 sector cache way setting register i=
s
> >>    shared among PEs (Processor Element) in shared domain. If two PEs
> >>    which share L2 cache belongs to different resource groups, one
> resource
> >>    group's L2 setting will affect to other resource group's L2 setting=
.
>=20
> In resctrl a "resource group" can be viewed as a class of service.

Thanks for your explanation. Adding sector cache function into resctrl,=20
I will use this mechanism of resctrl as it is.

> >> * Since A64FX does not support MPAM, it is not necessary to consider
> >>    how to switch between MPAM and sector cache function now.
> >>
> >> Some questions:
> >> 1.I'm still studying about RDT, could you tell me whether RDT has
> >>    the similar mechanism with sector cache function?
>=20
> This is not clear to me yet. One thing to keep in mind is that a bit in t=
he capacity
> bitmask could correspond to some number of ways in a cache, but it does n=
ot
> have to. It is essentially a hint to hardware on how much cache space nee=
ds to
> be allocated while also indicating overlap and isolation from other alloc=
ations.
>=20
> resctrl already supports the bitmask being interpreted differently betwee=
n
> architectures and with the MPAM support there will be even more support f=
or
> different interpretations.

when adding sector cache function into resctrl,=20
the bitmap will only show the maximum number of ways of sector=20
and does not indicate cache position like in RDT.=20
Sector is a group of cache ways, and one cache line cannot be assigned=20
to different sectors at the same time. Different sectors have different=20
cache space. When different tasks use different sectors,=20
the cache space used can be isolated.

> >> 2.In RDT, L3 cache is shared among cores in socket. If two cores which
> >>    share L3 cache belongs to different resource groups, one resource
> >>    group's L3 setting will affect to other resource group's L3 setting=
?
>=20
> This question is not entirely clear to me. Are you referring to the hardw=
are layout
> or configuration changes via the resctrl "cpus" file?
>=20
> Each resource group is a class of service (CLOS) that is supported by all=
 cache
> instances. By default each resource group would thus contain all cache
> instances on the system (even if some cache instances do not support the
> same number of CLOS resctrl would only support the CLOS supported by all
> resources).

[Idea for A64FX sector cache function control] =20
An example of using the sector function when working on resctrl=20
as follows.=20
  # mount -t resctrl resctrl /sys/fs/resctrl
  # cd /sys/fs/resctrl
  # mkdir p0
  # echo XXXX > /sys/fs/resctrl/p0/cpus *1=20
  # echo =1B$B!H=1B(BL1:0=3D000F,000F,000F,000F;1=3D000F,000F,000F,000F=1B$=
B!I=1B(B > /sys/fs/resctrl/p0/schemata*2
  # echo =1B$B!H=1B(BL2:0=3D000F,000F,0,0;1=3D0,0,000F,000F=1B$B!I=1B(B > /=
sys/fs/resctrl/p0/schemata=1B$B"(=1B(B2=20
  # echo PID > sys/fs/resctrl/p0/tasks

*1=20
   Since the A64FX L2 settings are shared by NUMA, all PEs (cores)=20
   on the same NUMA should be specified at the same time.=20
   In other words, we want to specify NUMAs instead of PEs to the=20
   resource group. Maybe it is better to change the interface to=20
   numas(/sys/fs/resctrl/p0/numas). Could you give me some advice?=20
*2=20
   L1:<cache_id0>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D<cwbm>,<cwbm>=
,<cwbm>,<cwbm>;=1B$B!D=1B(B=20
   L2:<cache_id0>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D<cwbm>,<cwbm>=
,<cwbm>,<cwbm>;=1B$B!D=1B(B=20
  =1B$B!&=1B(B L1:
     Add a new interface to control the L1D cache.=20
  =1B$B!&=1B(B <cwbm>,<cwbm>,<cwbm>,<cwbm>:
     Specify the number of ways for each sector. =20
     Each L1/L2 cache has 4 sectors.
     And it is needed to specify the number of ways for each sector.=20
  =1B$B!&=1B(B cwbm=1B$B!'=1B(B
     Specify the number of ways in each sector as a bitmap (percentage),=20
     but the bitmap does not indicate the position of the cache.=20
     The range is from 0 way to 16 ways.=20

When creating a resource group, the number of ways for 4 sectors of=20
L1&L2 is set. When running a task, the [56:57] bits of virtual=20
address are used for sector selection. Even different tasks running=20
in the same resource group can use different sector caches. Therefore,=20
when running a task that handles a large amount of infrequently used=20
data and a task that handles a large amount of frequently used data=20
at the same time, cache size limitation and cache space isolation can=20
be performed, and cache thrashing also can be reduced.=20

Is this approach acceptable? Could you give me some advice? =20

Best regards,
Tan Shaopeng

