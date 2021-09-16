Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4240E4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbhIPRG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:06:28 -0400
Received: from mail-eopbgr1400095.outbound.protection.outlook.com ([40.107.140.95]:46941
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348308AbhIPRCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:02:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DChOythpMyIHTGnHbrfZW1i0H6pWcrhkjVd1wmbi2Y52C02YpZPoa8gWztg7ZT5jYbnWB85Cn5BwP3qpB7PHtPThHIlY/nAG3Yk/1nWlb1THQU0xOYiM7d1dpTwyoIV2F1jBws6yaVLGBP7JbrjfQdYJ/zLhH7pYe5f8n4zwlkNpEluaxDiIhxOQxUVqzBPOZk90G5hyyJYSPcxQil5djn6MQQfjT45DXPNFzD9xrJ5iPg4aoOFpjjTHuMxabOHhfvaoO3ymoxrlgVf7j6LfHLup6YU9tUqjI4ABuQHbreCbqN+ACDZjee1GhWc3aqNQUWt63ED1kqBJncGXn6IWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZnaEN1OmT1Br8lT1epZl3BR5Q3cM3ewgQKRfvoN5CJc=;
 b=Dm1AS1alJhgR1LATNImAUIUGD5P3QesTImbQRefC+TohzcCcqEHsxDoahltFAHJWtT7zaV863rXJR6tuBM+WRYVB/pslUeJgg/dUFW3SFqp2uIpQMqTQLafkgGEq8Pw1HUGxrtAPBrJRrl8eHEdCfHVNS7wC5jKKY7CgcRb5b4JQ3d6IH7iH6lmOtUxez/BMLUZmVBTb1n8au5WEwFtENnVMJz72ZwfwbWiwICbOKNisJhOs/ZVx99VyUJ0/3ftJiiE7SckWQ2b1V+rYyeP2ciBzqWpI1UBC4Xs/aAulb1KR3RC0Qd67yth+crIKT1UsBwxDZLJaTapUyRQkeOrH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnaEN1OmT1Br8lT1epZl3BR5Q3cM3ewgQKRfvoN5CJc=;
 b=kj5FyvzQMKrcu9zlhWs871R/XZsIGzE3ysD1om4dOrDcYBl0hrdz+hVxd19WdQ+kbvcw+f0HPRnXIvT/8ewWDppH3bqri9fSyEKqq5s8LZG/VpAdefzv0frBbESr3DKjfJsSgPQ0nKtgfRmbgTMeOI4zq3QEuXsYkVqnprXyJ3M=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS0PR01MB5988.jpnprd01.prod.outlook.com (2603:1096:604:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Thu, 16 Sep
 2021 17:01:11 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 17:01:10 +0000
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
Thread-Index: AQHXqmIqGzfEPA/ASUKU/78egiaTO6umId8AgACkSYCAAAc7gIAAAX9ggAAFoACAAA5yMA==
Date:   Thu, 16 Sep 2021 17:01:10 +0000
Message-ID: <OS3PR01MB6593C988FB68699B58609D4ABADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1631731629-20862-1-git-send-email-min.li.xe@renesas.com>
 <1631731629-20862-2-git-send-email-min.li.xe@renesas.com>
 <YULVYrvUM+JQils9@kroah.com>
 <OS3PR01MB659340151F61C6ABA2D9043BBADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YUNlQ1d8gsNzY0mz@kroah.com>
 <OS3PR01MB65937881AFAA1D8C575E63DABADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YUNrPD5pbq5NBi26@kroah.com>
In-Reply-To: <YUNrPD5pbq5NBi26@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa214d80-26d3-4351-f123-08d97933957f
x-ms-traffictypediagnostic: OS0PR01MB5988:
x-microsoft-antispam-prvs: <OS0PR01MB5988220125CAB77783D15561BADC9@OS0PR01MB5988.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yCEtc5sOL094tJwEoHorOIszu9+0oeyT07EpNsmvaU2tv+aTKzBHhMrsC5D87BIK5Wtv+hQLm2Rvyc5opXeWqkeskZIvA/TYhP0IS9yhQvw/V+Y+qQ+cpqKjVPpqMeusRnJyaSy7/ETEhnBriBFZ8qNWECe0quY1Vvsy1CplVELk761db4o3zcx/9AAAfzCi4Yi10jzzD9EPpkAOWOCty2kslQ9XUNehGZVBdPMhf0HwB33UTO//Kk6xd5XCPfnQn0jphUzvgoc1shfuC75GUtku7k670SyzK3AeBUnQbEmpJJC2rGM7Q74gGx+hV6naxjmjXWmVnsoj3hO8LLvESflwBVrfU7CNjBMkC5rU0LGgN+neDSEemeHuyLuc0ywmBGWxspHkKpE2luYPNMeAIJkh96tiualUJhQxV9GxJ1ft44tkPodMaIshj1EmP+gUY6f8BMyEhcYwvVm99iGInoCrvyy8TCpMrJwLruKaXXN+8HC/XFywzPrF7OdS1F81A4g0l1UNiMNrxepVKw1knjbTtdD/0xZaZgn5/jzzHWsIrHGSfze7/IUDEb2NEo5ddkA10s9pTlolK25VcvFX85kU+p33vS083/1IPp/XdarOC2Aub+eubDTeYIR0T/N6sZ8TaPRq/tExTqO49nBScdawZuIsm8yeZEeAH3iFc9H5KZglOW9ec6mCMZTu0qyKSDtQaEl+Vc9IjwqDVFcZmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(52536014)(71200400001)(55016002)(6916009)(8936002)(186003)(478600001)(86362001)(5660300002)(316002)(66556008)(64756008)(66446008)(38100700002)(8676002)(122000001)(2906002)(76116006)(26005)(9686003)(66946007)(38070700005)(6506007)(53546011)(54906003)(66476007)(4326008)(33656002)(83380400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ymSFgzspFR1j3zBMNVQIAUAmZpo0SZRJkvVD9Ly0oa94PlUOwxfP1gTRqhDy?=
 =?us-ascii?Q?Tg+AfWkKThUElBeDGdn9c/GHyqAcs6lCjOQvfQHMlLSbX4T4cjwX3Ene/9HO?=
 =?us-ascii?Q?cbZI6Qwef3t7ebtF+iIBu59IS1Q8ofOdpjUrk1t+qIE5ekg64FZQKYj10b36?=
 =?us-ascii?Q?MgOuy6lepKIXHcAihVNQ75cjPWhqOcbCI8bFa8ilSaBJZJPoKRhIJe2tZRJs?=
 =?us-ascii?Q?M4FF4/wUZYh+i5blgGV5Scpq5MgDlHA9q9aEXRXd1QuxEkwrUYx74qFQLaEj?=
 =?us-ascii?Q?cgcO6JHQtx7ZMgCaw0KrvQZ4xetv6QTzo0m3kn3wp/M47K2SXvKSHYs4lnDv?=
 =?us-ascii?Q?HrSd81nCOwAlPehgHdYofzqWXwC6SFxBegYXCVluoHE//TgIxM8zjxvUdZGo?=
 =?us-ascii?Q?dWURHHOmWVAsfKZiSnlmTxTqKPb7dycpj8/Q+XlcPlCd0p1x525KhlMWD3Gl?=
 =?us-ascii?Q?NM0OjQDoxurtYkbN+bF70wpQH8yz8uot1tjssJLm4iKlJ/acayGI4IH+y/Kf?=
 =?us-ascii?Q?Szjl+DpIwa7/FWH7IY2XWf2kwKxrfKK7sQnhzzijTFi1iaba5OkbZMK4W/gP?=
 =?us-ascii?Q?gEPTJEAk1zBW5OXjwe9Ul8GqwxSROjFLXM9suljJyAI2KFGL7Mo1892PTcuq?=
 =?us-ascii?Q?BbwClTlMc6z/yDmngN4KUodzmVeG3YRubNXiwvSbH9DHnQ2UZwgZxtotPPPH?=
 =?us-ascii?Q?r2aVill/oDKZeA3kxW124SUAIBIYNeqxbox+D44nGKf4eOVITaeFH4MA7XTB?=
 =?us-ascii?Q?X2zNbDNutx9CtvkcIXUqnFLvSKTxm4x8abK7rdzy5HiKNqxCL3gDoTM4F4ja?=
 =?us-ascii?Q?F4OtLlO/7ZYA+fs9M7A70fo4i9yqtbwEAqwQuC0yUbQB/2uzD/eEm71VVZij?=
 =?us-ascii?Q?ybMRUmXfDOqBAhogRuIFUhvWeoYRcCmACewF7Bt4NT3CzhUnNawUoz+VozXy?=
 =?us-ascii?Q?tUUyRF/MRTK+N1P2giUcYxQwq70+ZyMQhEqwYlQ+PtBOJIBzA4E4phHn7dJ5?=
 =?us-ascii?Q?vkRiqIxMnHmgKDBhAwjWZZ3gQ1a8GQu9u2sXCywaTBex/8DkWJClVRmWyvxa?=
 =?us-ascii?Q?1uGbQ8yhLQM0OPtdQlRgFCf2Ph6Dcu03p8Lia9ojNohRBEKJgo2s8cOOoszf?=
 =?us-ascii?Q?oG3xBumjB9pIkjkJMMr1wr/q/bvEI2WocykzkG3kAkyoIvNwGBlr+e6F+hhJ?=
 =?us-ascii?Q?2QflVXNYDivB9uGPihtVRSIqNqdWjtJgcVT6jjhsVY8ISG8YzYVks+w3cXyJ?=
 =?us-ascii?Q?sMd5TA4c+/cnbjl2Xauo0SE6mt0J9o0W9BZ20anZGRuY1ap8F75OYZDDZwJW?=
 =?us-ascii?Q?LzcrUC43DlYM/cPF2ALNpZmQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa214d80-26d3-4351-f123-08d97933957f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 17:01:10.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnwO4NdmUShZnf2YFu7Gt19+JuZaPaFoZxUbxcFmK5oW9En9pBHEJi1JT/Ev3OCtocqUitpkjt5yuZlOtld8YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5988
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: September 16, 2021 12:05 PM
> To: Min Li <min.li.xe@renesas.com>
> Cc: arnd@arndb.de; derek.kiernan@xilinx.com; dragan.cvetic@xilinx.com;
> linux-kernel@vger.kernel.org; lee.jones@linaro.or
> Subject: Re: [PATCH misc v2 2/2] misc: Add Renesas Synchronization
> Management Unit (SMU) support
>=20
> On Thu, Sep 16, 2021 at 03:54:52PM +0000, Min Li wrote:
> > >
> > > Please put that link in the changelog comment and in the .c code as
> > > well so that people know where to find it.
> > >
> > > > >
> > > > > Why is this new api not a standard one?
> > > > >
> > > >
> > > > There is no actual standard for the GNSS assisted partial timing
> > > > support (APTS) In terms of Linux kernel API
> > >
> > > Then make one!  :)
> >
> > Yes it is on our roadmap to do that for next release
>=20
> Please do it for this kernel api, otherwise you have to support this for =
the
> next 20+ years as-is :(
>=20

In that case, I would have to get back to you in a few months. If you are r=
ejecting this
change due to this reason. Please tell me explicitly so that I can copy pas=
te to my manager
and that would be it. Thanks=20

> > > Why not just do this all from userspace then?  You can have spi/i2c
> > > userspace code, right?  Why does this have to be a kernel driver?
> > >
> > We used to do everything in userspace. But since PHC (ptp hardware
> > clock) came along, we decided to move the driver part to kernel. Please
> take a look at drivers/ptp/ptp_clockmatrix.c for reference.
> > Recently, we have some functions like APTS that doesn't belong to PTP
> > or anything else so we have to split those functions to RSMU misc drive=
r
> and i2c/spi bus accesses to RSMU MFD driver.
>=20
> I still do not understand why this has to be a kernel driver, sorry.
> What exactly forces it to be that way?
>=20
That is our management decision since everyone is trying to move their driv=
er to Linux kernel
to contribute so that we don't have to release the driver to each customer =
separately. The customer
can just grab the driver from linux
