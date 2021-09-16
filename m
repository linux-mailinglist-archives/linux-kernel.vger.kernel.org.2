Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3383B40DEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhIPP4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:56:16 -0400
Received: from mail-eopbgr1410134.outbound.protection.outlook.com ([40.107.141.134]:61072
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231702AbhIPP4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:56:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS5lsHMDU+bQKO4aFkYQuF1HxmXH4xBVO3ZRPY0yU/8zm/MdCvL32/tHYvHnPOpYLdeKbfGA7zWa6sNaWaekBQkDUHQTgCyJaeIEq2WxPkHBxOjDNbKoxGWqkiSeCAAyLlrEutxh/gJQKfMv/WQRoODzq26iHNV51vDXtdyX5r2JjV8nfwAaqXeypsjEZ/fF9r2Bc+LL7Yckxj83T72Ikss5pUUAijCpn6TmppoHwnBVVmwQQ8bGbRAjzm9u9bLgA63htTJvnTOg7AMukgaj+egyM0XsnjhBmSpZ4C+fdAAaVlWh8EYF2ICfY6SBy75k6qSzS3bGctGcLdQwH2sZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wmjiMti8alfo16ReER8JoYDI5uRq79ornKIlwJFJoNU=;
 b=gN8VXUdJdMzJtbh2t5xf0GNY28JSanUI8yFqy2M+GV8rTPkXvxuRKnsSwpgv7/HPV8dhPvnZDzacxgs672V4Jxi7QgQBq5IL28KlaRDdtaBO0PzWkR8g7aDsiGj22VmB/HoD0/KAoH13rng1FbtypyX6ffSs8al4VRjE4kPbdePo6kV4aDmT2BFePjf67Cnob5OQnaGfCBMVHkmFbUvBR5yuyC+N14bxc/8Yla61Y/f4I480gm/W5dDncIF7q5Kx5ZH7K4Vc94Wx5eiw+VDKGlB/bg1FnDa1TDtwkStjp6vrKBChVUFK1F7LMkb65e3YJvJCyIihDTvdLgBZXfaOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmjiMti8alfo16ReER8JoYDI5uRq79ornKIlwJFJoNU=;
 b=cdr5t4/Vqh/Aiueb/rNZ+XHGN1OY5xY02aVi35pkvFbd8OXzk7xRvE1SgJ21HbxzlLmXlS5T2gzvAHvq4pVqaSRF5CgbCtIOUA79e6tmZtL5XGhAEXYviZ4+fyNmCYBcdGNRIpQl1U15m5z9sJFVJ3yT4gOkmrONVzSHKOe/wkQ=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS3PR01MB5832.jpnprd01.prod.outlook.com (2603:1096:604:c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 15:54:53 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 15:54:52 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.or" <lee.jones@linaro.or>
Subject: RE: [PATCH misc v2 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH misc v2 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXqmIqGzfEPA/ASUKU/78egiaTO6umId8AgACkSYCAAAc7gIAAAX9g
Date:   Thu, 16 Sep 2021 15:54:52 +0000
Message-ID: <OS3PR01MB65937881AFAA1D8C575E63DABADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1631731629-20862-1-git-send-email-min.li.xe@renesas.com>
 <1631731629-20862-2-git-send-email-min.li.xe@renesas.com>
 <YULVYrvUM+JQils9@kroah.com>
 <OS3PR01MB659340151F61C6ABA2D9043BBADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YUNlQ1d8gsNzY0mz@kroah.com>
In-Reply-To: <YUNlQ1d8gsNzY0mz@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 315de5dd-6dcc-451c-cd91-08d9792a5276
x-ms-traffictypediagnostic: OS3PR01MB5832:
x-microsoft-antispam-prvs: <OS3PR01MB5832BDB03D321CFBCE980C44BADC9@OS3PR01MB5832.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXIeKoFQFiKZEENf9dkVlsDlFECm8HbVTH9G5cnYohmqmLiGvs8OCMbJodLxGN3bn8whEdkArFNbxyM7TepJf28BHUv4TPEtsfQDTvoR2ki47sS9jIxOkUjJRu3JnJZh3191cq53+XNSuvhP+zPOW3TUjwlK8/s+FXauqZl5K6q2AU5ddARAkON//c2uE2F44pJBKF7y6svdq8b1TnpkESqG5GFGa/sRkZEmmol+c1FkX8ODxoD70hWNLfBNPRdgJfMoIlaWgPsamLI9xfjU9ESMziTNyJnt9n8mELtnod9qlssqrSCOqh+aWed2Jq3/DfE31ZGnVfoIZWdEQaXEU40pp+8VZvKxEHhUEHUDATfpxB3qS8q90oUax3UxR+kbu6VlEWUMHm52nwgODp5hKQJawehekoNp1IjkA/ZjZjMg3DWea5GF/NuQWCB3XfXXfMEZHuTvCUpzt9vSWUvPhJDWa7QgejopqcLz4z5MSCRiPJwntYNBZg08YkrZ6usEeenXaSt2jQr01pD+kjSlXFlNATb/UytcaIXsOoE14MNYyILhmL8s2Hob8xJCQlcTaRXfCIifXFhtertRO2K/3SiieJxvJhSH023frr3ZeAeHkW62o+57KxLGLsKBownpMMmYEc+cE/+4BNwlPTkpgoucdLrTLauci0c+FY47rEQXiDKIFxdPBNB+/zaWuX4STPCdW9l99A/QMflYv+Sxyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(4326008)(6506007)(33656002)(122000001)(2906002)(66476007)(71200400001)(38100700002)(86362001)(6916009)(54906003)(55016002)(9686003)(186003)(38070700005)(316002)(26005)(83380400001)(8676002)(5660300002)(66946007)(478600001)(8936002)(7696005)(76116006)(66556008)(66446008)(64756008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MnpASm7U9+QiHmnKcNF66Piqoe3QTXd0Qe+AW0ky5/GqGgy1pYk4Gmuk7A1a?=
 =?us-ascii?Q?FBQn+05WFW5xcEs4PS5a/rcguFrOS8HhHCK6CjWAncOhJkQ3tnWKqYb8vQ4q?=
 =?us-ascii?Q?MclpLwA5B762C2B8TmMMh0gSLB1JxgGsqHGNqfUuLeEj12Q3Sk5Z2tyGW9aw?=
 =?us-ascii?Q?TzwrnrIme47d7Ioei6Q2cUnsFDntHH0RRdvbdGqpLH0T+V0CvVOTfLiUjVSy?=
 =?us-ascii?Q?Pw0LFJQ+KtYnlzMjrakcl1qEDGSppyVpGN8XwNHsUJn/9w94TWfhe5HvyaV/?=
 =?us-ascii?Q?tfOwJSntOKhFWgRBUL/i0MA37v4cvAQVVRZBE/YH28gUSD/oKcRaDVV9bUj0?=
 =?us-ascii?Q?a+qANZiX4ziJCVFmckfploZn4X+WSR4oa0xNOF5jBi7GjJZNVfwTgfbk6WcV?=
 =?us-ascii?Q?8LvYIFbuPyLALxY0OXyOVRerLBuN0La4zyDoScP02V7d29mkDBGkk4jmpPRt?=
 =?us-ascii?Q?CbHZvnPTtLVIly4AEG0VyS6xpRfxm2GIsaGGQiPgAKw45Ykfatmvb3vcDIlY?=
 =?us-ascii?Q?pwmdfZ1hr3D2yDUwPDOo9c7mFGEsF8o3mhGVGkKdAnxotD61ZbIG7QFJG4nE?=
 =?us-ascii?Q?Mre1TicOmpdsjbz0vWcjI5QdpmM21MHww2fYTsvrqzzoEdP3iLple6wT5HmC?=
 =?us-ascii?Q?vVr4I1MCIR80cPY3BvnLxtZQn6RkRvWAnii3cwVuc+Rw+uC2NY20JCxLyif6?=
 =?us-ascii?Q?A0gmOJGHfouCAwlWzH1s4s7PT1TBzBMuna+GMOc2ozZrvAl+xiuBq3edvsN7?=
 =?us-ascii?Q?bMUTbU4BFCxhVifQaGJomfZrRvFPMNBa8vzGSDxiZgbnKiw42vOUziJo5w3N?=
 =?us-ascii?Q?u9h+kFafn8OcuGJTdxlAqQFZQIpIq2OTAWanMFFCoUHJc87KgV0ScFVwu4J7?=
 =?us-ascii?Q?XxXx6iLv3KQJOskUHM5CKIX10XCDEwosOKFZw70chzD1JcFzWCN7wRe/ZtDT?=
 =?us-ascii?Q?rEwa8fdTqbVgr5Xe4ZtNsHJzZS+iJ5Ke4QxuUHhitm0CiN1CC2pum9gdQje5?=
 =?us-ascii?Q?kixragtfZZG3p7hQR+LZIUvXrZsPzQloSzflZzgw3kaHHWrRXG7QHCIJJCUE?=
 =?us-ascii?Q?5uM8yFGN213YZYJxEFzAunpmZt7WDTtyCXBqDPLXDVQTaDzCkrTE0U5ZJh2k?=
 =?us-ascii?Q?j7VZRwzHmJS2LYXBuCztbTQUyZu8N2h79039y0iLEhL6mjv7nG4zT09v7JFG?=
 =?us-ascii?Q?RM5Pdu2mOk3jUapxAET/qb7YfaVMRNAIshBjHIe9OuSqu+ph+PdstnitZA7J?=
 =?us-ascii?Q?J/Xv13MHWxOk5EMw2cc/14DrqozK9U0/449vLIG2wuP9Tt4ouT+eLKoTdhRT?=
 =?us-ascii?Q?3xsPoHM7HJj23BkM+6XqXPbm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315de5dd-6dcc-451c-cd91-08d9792a5276
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 15:54:52.5425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDJpDUTvip9Oz618nw/GohzfzFk6PLdMKf/4ehg0uey+RpRCFbBmPUCooK5+oQVUD6anP029XRFw5mcoFOgl3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5832
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Please put that link in the changelog comment and in the .c code as well =
so
> that people know where to find it.
>=20
> > >
> > > Why is this new api not a standard one?
> > >
> >
> > There is no actual standard for the GNSS assisted partial timing
> > support (APTS) In terms of Linux kernel API
>=20
> Then make one!  :)

Yes it is on our roadmap to do that for next release

>=20
> > > What is the standard here?
> > >
> > > What do other devices do and why is this a new api?
> > >
> >
> > There is really no standard for APTS and different company has its own
> > hw/sw solutions
>=20
> But userspace has to all deal with this in a standard way somehow, right?
> What libraries and apis do they interact with there?

So far there is none. Some companies just use userspace driver and don't bo=
ther
kernel

>=20
> > > > Current version provides kernel API's to support the following
> > > > functions -set combomode to enable SYNCE clock support -read
> > > > dpll's state to determine if the dpll is locked to the GNSS
> > > > channel -read dpll's ffo (fractional frequency offset) in ppqt
> > >
> > > Why do all of these have to be in the kernel at all?
> > >
> >
> > Because all these API's need spi/i2c accesses to the RSMU card and
> > spi/i2c accesses have been abstracted to the MFD driver in kernel
>=20
> Why not just do this all from userspace then?  You can have spi/i2c
> userspace code, right?  Why does this have to be a kernel driver?
>=20
We used to do everything in userspace. But since PHC (ptp hardware clock) c=
ame along, we decided
to move the driver part to kernel. Please take a look at drivers/ptp/ptp_cl=
ockmatrix.c for reference.
Recently, we have some functions like APTS that doesn't belong to PTP or an=
ything else so we have to split those functions
to RSMU misc driver and i2c/spi bus accesses to RSMU MFD driver.

