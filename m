Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8232140350C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349276AbhIHHPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:15:38 -0400
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:3822
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233478AbhIHHPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSqOfMONhdTrgYIcMFelJQK5hwoUMPqHhQ1iJTunZv8iVE80UswK6CPPbtmfB7zXsGK/EK93WoV+K5YKxPByWi3rSjOh9ahNXLHb5TnQqAl8slai/AJRWe2lMpZqk/OYKdz5how2jJIo9p/S4xWq4i3hw6b+HyIqEQLIKlpjAoZ/19iTUZWHA4oLlza1+AVig9BWmDJX85w+xLd3Mmv3mhMBER4sMDhF6kbo0pVBm5hPh4XodSiP0tNsIqhLK5VX9SXC+9Wb49RdUFM1hm9mTuutWgcJz6xxfQ0O82nFGm2SWhRt+YsM+2T9J3QtQePZtO03SOY9HIdVFuziJ0yY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eBrLRwxJIYEl2kZzt113l8OxHQac2MV8LvrklL9Ejws=;
 b=dkbyXHBCZEN9xI+1vkhHrAG6mtFcXGnmI5dJ7kfey1V8ieU8HhKKjkMR8Cgs6zfgXng0sUatv6h8+2mSO1c2aou0yhSlY4JiG9bDMXcZp1I//U99Tw3NlUHF1Y0n6a9kx/s6Din0ahnpex1EhJDwspW9mDnFVAGUG2XP/poZjYVJgGOnKssT/JeQ98MFZK1i15dI6JGjDl+UIzdImMpShKGbclfEFTF+MZwc033PBY7SjXa7/nu0dNSTsSXi3knNDBjoO+4imknU+ssV5vVrEOlKLD/uxEB1H8FlyhH50idfvygfDcL+ntrMojZKjLJw/LjVFMnJ/KtWjGSyHVsNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBrLRwxJIYEl2kZzt113l8OxHQac2MV8LvrklL9Ejws=;
 b=C3cQYdphcpCAJ8WmzTvyU+wtUY7FatZ9XrvmV5a6UEI72kwCB0+imSVKjkEmNI/zGgyjl2YaPDr/5GjHSk3yFwgqEhIWivkHPxe3V61gpRBj0OsM0FMwJ2zbUGE+PCSklbojW7VbqgmDWtYpWsucQ71hjiDPiMqie2CUK1Y03bQ=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2502.eurprd04.prod.outlook.com (2603:10a6:4:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 07:14:25 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 07:14:25 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data" property
Thread-Topic: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
 property
Thread-Index: AQHXjbpIBwDJH2bCBk6a1JjgGNijp6tuGImAgAoQXgCAAMcfEIAZdZOAgARzF4CAAa1gAIABWL7A
Date:   Wed, 8 Sep 2021 07:14:25 +0000
Message-ID: <DB8PR04MB6795046DC70B8238963C343AE6D49@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
 <20210810073510.18218-2-qiangqing.zhang@nxp.com>
 <6e3f6881-929d-1663-58f1-39bf35069175@linaro.org>
 <YRwUyLsvoSpFI9X8@robh.at.kernel.org>
 <DB8PR04MB67951E2312CFD69808B4502BE6FF9@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <f572aca2-167a-be26-d89a-810c7023092f@linaro.org>
 <DB8PR04MB67953613ED725D00027E972BE6D29@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <2ab0b16d-5a22-2abe-e228-c058b5a853ff@linaro.org>
In-Reply-To: <2ab0b16d-5a22-2abe-e228-c058b5a853ff@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34d49a53-f4a4-461b-34a0-08d972984a2e
x-ms-traffictypediagnostic: DB6PR0401MB2502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2502831DB2934042AE44593CE6D49@DB6PR0401MB2502.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rxfhANgimqLHoKqqRx1aeo+vgdyhfXKdkbFjhjuqyYBv7zujxaI+a60H2NuV8RFq3XbqGNG7/ocQR2qpQZk00CLRXX+BMRw982VaL52kfo4FZ/22xkBmMy4qWn2DU8JhzRYtmQs4Xej6YbaFFoj3FDamV6KNnaFTLr93Sxo+RQHZsgg1FMwKsj/irbmVN6M+lKE3zQ5Wv/KPCfwHp0ySmVEFzNrI3kOYWg3VOh7beIamd/CQ+QQxzzE14EHhqXE9Y3DDIVBhGFKQwleOishvlSeGhocRygyUc3DBTRW7Ob4pDJeztAQUQebH2QAMXwOzMMxf5IftPl9zIVxfWlZfFce0PhRjMJelkA0JPy14ZTiJjJLxrTa0VFsYILOFVFQuEbXZ34D0dwdPVg+gWn5HNpS2K3u8UCOE2GGVRbr1ZOnsrSfkcUaa7rHYvOUHrV/BlRif4LyfgujuMQlAH7qKIsohkoa6MbFZJPIfu7baTto2q2YahpyHwKT7IMep0fE+hxmxDLyX4ylkNE53iT1jsPLvDUMsQp3jMCgKZfOoZ9tYdLJK9+zoFvNxv3aD5NGw5MD7h5z2nT9o7QlJIS9eXPbiIBDGvZuOG+CJMZbcEegerZkmPX6/UFAZtcGntfBl6q1i5qDoEOwurZjoU74pGvSqR4zJzUl7iN7/WEIaL8Vkkxn1LlBj2wapLmNQupFIOUOGzhMV5UlNvK6P5cdbaBHXtqrKUojI/Edyc88XhFEr4xZYzETUumCHU2ct3TJyZIBhSYkVYqtd7bW8rEGIk/gWZhp7Ek7T84LyVnEkfHqMnpXBoyMNELYr7h5HKb2gi5lU1/kaWlB3KFJwhZzWXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(4326008)(38100700002)(122000001)(110136005)(316002)(54906003)(71200400001)(66946007)(64756008)(66556008)(26005)(9686003)(66476007)(66446008)(5660300002)(83380400001)(38070700005)(76116006)(52536014)(86362001)(8936002)(55016002)(8676002)(186003)(2906002)(6506007)(33656002)(7696005)(45080400002)(478600001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JA36g9u2dKV3hQ4Jk3/p4nB59yBJFGUj4DWGW0Trqm2K7qKscvEH58MjlKh5?=
 =?us-ascii?Q?J5xAzEsONisy4T2APZssVNSxu6D8+5UAoWaSXWcOQw8KCsYvq4y0MMY0uFwr?=
 =?us-ascii?Q?IRAlY3zsQpU2B69UPwVQQDdaQZllO8qv1IRciT4fJ0NAuGWoXHzwXzYHf7Gd?=
 =?us-ascii?Q?6Of/ZW/AzmC33Ml4CbTpfqJRVyKjScLnvxMLvcukElHPGx1K/UKOl5DKfNC4?=
 =?us-ascii?Q?4R9uy1vYVsd2JKnGgB3F+I1YVUaCe7oB/1bw6NzalrARAT02H+ZCQ0vU9Jog?=
 =?us-ascii?Q?4R2kcicWpKDk+IPgqr6j79Znmxll5TYtvfyHTfdRDQ/9OQwdlRVHFCH0MTO7?=
 =?us-ascii?Q?jjC8GHo2qLSnfOaCfQDJxfkLA2wPUUV9TwClSs7bqn02JhP4y+U2CPDTJHVu?=
 =?us-ascii?Q?hoiWMgAc3NgTc9mdiLpmDlUVr+sxtMxxRXVCpy2kFUCpfv/7iEAO6VghFM/r?=
 =?us-ascii?Q?mSrTzx9utqO+NPunbVjjXilnOFgpfQusJAzIhXUU8Qf3bplIjrJDGRPOCuHN?=
 =?us-ascii?Q?7dRGa8UdFjgy3qfRnE40R4gnrhyVF9Y6VaYORwfQDMufxfp+jUgHsrHaAgiq?=
 =?us-ascii?Q?35ax7hSAu05HZ5yGZ8NuZwevk1R9JiikNKP1X/q6DKnSGQfUqRoEfdUladil?=
 =?us-ascii?Q?C74cXUsrug6zq3ucgrB2vHiY6sSVJyoiQbjmlARwgTheEIka0pDCpZ6SOITM?=
 =?us-ascii?Q?cDLsouu75tdJAEqt5bBLCDaXvdO9eQsGKRn6AAP02Box5WJFYg9W2BwmoOaK?=
 =?us-ascii?Q?SQkSr0AUR2Kk4oKkEjjqmwZAdfzw/41gtCxDqfGwpoBAiQwzLZcLdtowmh1F?=
 =?us-ascii?Q?cglg4COzoxb4RBC3Uzv/0/Za59D2f8lvSpCv7jw959h1TZfYAapNAazQAqy5?=
 =?us-ascii?Q?RjogBgNuuUzrAF+02ZnirLbarEKcscHq+KIh5K638TTihzgCLosFSWn8dJDu?=
 =?us-ascii?Q?ZkNqqbjUPwF5giDTQowAjpud4MbdH2XdNeXjpZEkC9IWEAys23A5OJOuudL4?=
 =?us-ascii?Q?uJ2LO3fowxt6dIDeSl/O7YGPrMq3PDHoF7wK3O79PLpo6sY5rEq1ct/R9en7?=
 =?us-ascii?Q?GwtN/fzka4co205Cp8IoWMGRotU2pw+TzLxyugqpLsXBVUxQ8DXslBOxUEc/?=
 =?us-ascii?Q?oc4ZFHQ2uASx7ByUi5x2z2uTP8zUYnFJDEaC5vbTFqNwFeYrE7wwNPnSGn52?=
 =?us-ascii?Q?9iYkSaxkxTDKX6mlSuVQR3EX/VyOIMszaxGl3budF7hlk1GsS6TavaFmh/Lo?=
 =?us-ascii?Q?CP9+qfB4jvuOVEPWEa8buEpg1hxs3BHvUrquU2x9ip5HWfnpoUyAVncjZp6h?=
 =?us-ascii?Q?pNs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d49a53-f4a4-461b-34a0-08d972984a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 07:14:25.3877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIXSjfobD2VhgRBeo+/RpYXQ2nFoa145NV2igvURiydnzieFHLLpLHM+N/P1bSPVOIhNfmM5uNujGAxAggL1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2502
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Srinivas,

[...]
> I have pushed some nvmem core patches which are just compile tested to
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fsrini%2Fnvmem.git%2Flog%
> 2F%3Fh%3Dtopic%2Fpost-processing&amp;data=3D04%7C01%7Cqiangqing.zhan
> g%40nxp.com%7Cadfa3ba63c634937876308d971e7e71f%7C686ea1d3bc2b4c6
> fa92cd99c5c301635%7C0%7C0%7C637666063097239185%7CUnknown%7CT
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
> XVCI6Mn0%3D%7C1000&amp;sdata=3DW9yAnGm9rYzlSZuAAGiN4VHUtKYUTt9S
> oyGQ9QsY7fI%3D&amp;reserved=3D0
>=20
> This should provide the callback hook I was talking about.

Thanks a lot! Yes, this could be more common, vendors can parse their mac
address for different encoding style, also can extend for other cases.

> Can you take a look at them and let me know if it works for you.

There are some small issues need to be update:
1) https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/commit/?=
h=3Dtopic/post-processing&id=3D624f2cc99b48bbfe05c11e58fb73f84abb1a646e
	of_get_property() can't get the cell value, so I change to of_property_rea=
d_s32()
2) https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/commit/?=
h=3Dtopic/post-processing&id=3Da424302c7b15da41e1e8de56b0c78021b9a96c1e
	if (!nvmem->cell_post_process) {} should be if (nvmem->cell_post_process) =
{}, if we have this callback, we need do the post-processing.

> I have also added some test changes to imx provider driver as well, which=
 you
> might have to take a closer look to get it working.
>=20
> You need to look at adding/changing two things:
>=20
> 1. setting reverse_mac_address flag in imx driver.
> 	Does IMX always has mac-address reversed? if yes then we do not need
> any new bindings for imx nvmem provider, if no we might need to add some
> kind of flag to indicate this.

No, it's depend on how to program the effuse.=20
To avoid introducing consumer property in devicetree, I prefer to move reve=
rse_mac_address
flag into ocotp_params struct, since each platforms has their own, it's eas=
y to indicate this. I tried
it, and works.

> 2. In imx devicetree for mac-address nvmem cell make sure you add
>=20
> cell-type =3D <NVMEM_CELL_TYPE_MAC_ADDRESS>;
>=20
>=20
>=20
>=20
> >
> >> Option 2: nvmem core handles the post processing.
> >>
> >> Pros:
> >> - provider driver does not need to implement callbacks
> >>
> >> Cons:
> >> - We have to find a way to define vendor specific non-standard
> >> encoding information in generic bindings which is going to be a
> >> challenge and high chance of ending up in to much of clutter in generi=
c
> bindings.
> >>
> >> Finally, The way I look at this is that once we start adding
> >> post-processing in nvmem core then we might endup with code that will
> >> not be really used for most of the usecases and might endup with
> >> cases that might not be possible to handle in the core.
> >>
> >>
> >> Does Option 1 work for you?
> >
> > Yes, I also prefer to implement it in specific driver, as you mention
> > above, these code are for very rarely use cases.
> >
> > If we chose Option 1, I want to implement it totally in specific
> > driver(imx-ocotp.c), and I have a draft, could it be acdeptable?
> Yes, this is the direction, however we need a proper callback to do this.=
 And
> offset information is still comes from Device tree.
>=20
>=20
> Have a look at the patches pushed into topic/post-processing branch.

I have improved this patch set according above comments and tested it. Also=
 rebase to
the nvmem/for-next branch.

I plan to keep you as the nvmem part author and send out this patch set wit=
h dts changes. If it's fine for you?
 =20
Best Regards,
Joakim Zhang
