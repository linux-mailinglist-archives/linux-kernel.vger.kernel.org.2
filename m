Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B531A1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhBLPjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:39:54 -0500
Received: from mail-eopbgr1410100.outbound.protection.outlook.com ([40.107.141.100]:56560
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229974AbhBLPjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:39:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfvP4EfMgG0I9kS20gopACUFIY/PjX9y3/4rFd0kQhaI21Akzf9li5i7g7ydjL1bG8apvgjOhy7TDkZ7jm2CgIuwk5FvX6i/RCTmbW3+AGEXCmdmIaLFCk1kQ7mMN/+WAI9msO+lQR4Bv9miObe6rN0ygoZTO2tPivEUDy1d1n7Pa2Sxf7GdURgB/WZ1RXe7eUQ4p/oLPenll0UoHEwLvqRDzaIE+aMLJ6z0D6uk35L6/i+9aTiXWUYXwG8h+sVSPAg3YyyXaGq965K+A8fSsk9M4NvopOZFhQefd+IUcMounAo3ObUNRfj5kRmlFzSh8juj+/2X36Jb1SnelVIQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfNC+4g6LQisBKLiz9qzXbUvPjJ8oNLtTVDRtO6OXvA=;
 b=lqJFYfJbC7yzkECB37qq6KBBb863/fsxLVjDuFDsQdle+M3Zqgdd5BqG7/X5LEZPReRdAAcbUw9GeNU/Dcodel5Gz4vaRMc3oieEw+kYyMtyRZRNAUt9CLpuyDZ1++UdBF71QWQgldhLwiCNWutclV79BBIt+mFmiOyblgxQmIhOKeZkApsaUNMPs/CnCj4a86TtjyNr+I0oVaCT0UV+f5IvYc8dDX2EM7j7c76gS0mYPEne18Wa9jGv8e/cJq6dMiNZPYchDk0l0kVs/jXWALqOpBMC/uV0FHPED9VnOKCkc7iKrBnrxkhUEUlaLPwVfZkmLMVJetr65NvPSG0jLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfNC+4g6LQisBKLiz9qzXbUvPjJ8oNLtTVDRtO6OXvA=;
 b=ZTLs/ZEfVLQ+iZDHHRvQPsVhzBar1Qtzk4LON7ns6ADMYus950oyJG7aUW5GYpljmAlJjm9cHRv6Ao9CPMxHZWxfvAJuBfI4AEKOjtp3TXla0XbDxcx3A+Z0A5dYXB6luYqJ9i7QagoXsbknqSthUZSA0RLQr7Yudrg9GTvD9W0=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSBPR01MB4599.jpnprd01.prod.outlook.com (2603:1096:604:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 12 Feb
 2021 15:39:03 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5%3]) with mapi id 15.20.3846.029; Fri, 12 Feb 2021
 15:39:03 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXANy3Kc3xxVsbt0Wl/bCSqSMNqapUIqQAgACD5GA=
Date:   Fri, 12 Feb 2021 15:39:03 +0000
Message-ID: <OSBPR01MB47733A5CB20E20E48EE84602BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYwrNE8547uuODo@kroah.com>
In-Reply-To: <YCYwrNE8547uuODo@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0410dc21-e381-4d13-a393-08d8cf6c538c
x-ms-traffictypediagnostic: OSBPR01MB4599:
x-microsoft-antispam-prvs: <OSBPR01MB4599C796749BB4FAC1617651BA8B9@OSBPR01MB4599.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lldDybsY/KIoOv90orjhhVtcZLCJUmpRaQ3urSPuWNOyufXJSpkzPSs/hZE2ljJNjruNv5lgJVHemxImdRhCgePqU+dhXIITaQsASPPxMd/VVQxuH3CZvPuYl1qz5nhWSaIbkSVijnf7HZbs9umKqiJ6CoPGMDyo8QWdF64KPjZ1rGigiQJqwthSySGIi/PMM7vEU5PxYRblJ3SG7wyVFrpzA1KxmKRoDKZ1trtxYymNhuO8TvqWwUQXAv9PQwt/zIFMbB2kLLph/jp1j6fnY0iQy8q9QlZqOz/rBlYh2Ti+hH5ewSx3lopHLHRRaObqzy3sYzs2evi3NC3/+W4dbduGq13Hmk9+fnUKZrSifwWVNyTNna8MXchZEeVeRBJhSk8aWzlvLdXk3l4sA1R86HkkW6NqgBjoGsykUg7PikH+MiPzdL8pGZwvY9AZGy5oU1+VeoUFfUosUhoJ2WdhGasmAZGLYdzm67RgmJx+SEN0f4fD6xL/P0qGUlxGkVuqHYGUWEiw6ZA5xJWZZvtYEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39850400004)(33656002)(64756008)(52536014)(6506007)(316002)(66476007)(76116006)(71200400001)(66556008)(54906003)(66446008)(86362001)(7696005)(6916009)(55016002)(4744005)(9686003)(186003)(5660300002)(8676002)(478600001)(8936002)(4326008)(2906002)(66946007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gGYzyTtZAXVZBbqhpCjC2d0MWRks6/cN4ch67YBv12fLJXavqcwZ9SZZ0ufI?=
 =?us-ascii?Q?mzAUnWsvX3PN5zgQp7N2YWWYqZ2LreuhOQnN615ixgReSJ9G9UozosE+GctC?=
 =?us-ascii?Q?kD6FKzFnmc0LEN1jKbH7BFtO0rzaEwBwtsUlXvSkN00YF48kyF8/b5pWFy7r?=
 =?us-ascii?Q?m1elqzQNC/R4kNJIbDNVfXJPg9hno5JnY0TWq38DcY5E3PHEV5OOA/hnUDRd?=
 =?us-ascii?Q?9gGYr3Q/yhfc/ANDkIsaut/tqVsJnne74Kwge+WHPtD9cDydd5uTn9mFXO3S?=
 =?us-ascii?Q?3JmqB6YOAEn3luOnqgdDX15fPCc/sfsMGX9PSMH0WgGXAnGEKPsDJddr/VDr?=
 =?us-ascii?Q?ArLRl/Pp8kCYOj1ZUOalqEi2noIF1mKt2OcCNLdDgKf7f/bDB+mBCz/qv1sd?=
 =?us-ascii?Q?OaM8o/FwxAGG/TsY3IPQwXwuWbDjbc/dK2XlkoxKRMKjuZUxdtkJu4SnYHk4?=
 =?us-ascii?Q?h2eg6B1o21jregi/cytcj3UnOunLCfS3cFcLdtl/qikxJmZKjGWD/sShhvE0?=
 =?us-ascii?Q?BXZKlUx/6AW6xtaqFYYlB5LSEVPXVWfILi3q3P9TbkEhFVhEMWSJFiDB4QCH?=
 =?us-ascii?Q?IOKiQzNQ2j80BOUT44ALoPt22QqTzpHcQtq+YXmIeMThD6xd33PKocFgsQZ8?=
 =?us-ascii?Q?Ci3VzuVyBHiZTqrEQ0cxHz439JDWJO/4VgsM4J2yvGQiW6iQWrDlXReQZBqo?=
 =?us-ascii?Q?bzQuldORqTWRdbYUMmDbnaFyrwG3v6KC66O2Ws2gyHrfNVdPur/uxGQjZP6T?=
 =?us-ascii?Q?Z3pv42zFIXchJt3+HCEGNthNjc/Mg1sMeem9BYj5o1SoHr6LHRfhxlGEieIU?=
 =?us-ascii?Q?XjjMD3RJ1K1nmedOQ9xWonyUU9HSjkLCG3rRCXMsPsGyOZegfbOV8Plg5UvD?=
 =?us-ascii?Q?ttYAFaO0a1uxXwPKN+bqR+LYRSCttYVBnuOLUcm3DPMQPPVPn4BtWp0n4IbF?=
 =?us-ascii?Q?RbzwiRgVtuCXxDQjx7Vatry8izFMtJO4DqkBZ0FWFjQKHgagGv+6bCfA7JMt?=
 =?us-ascii?Q?5WX4zCDz2X8OS7MnT/rnX0olp2SskWdNHovWotfpGnn3Xlj534C7DnVcV1Fz?=
 =?us-ascii?Q?fxLhf384EBEiV2ne++Xckd0NYPmI1pvDBorX4iLRzjazvNz7zKULK9dOK86I?=
 =?us-ascii?Q?l9XNWYZriaQ8Kn6Cgu7EzFBDP97keEoc6unesJ40DYyjJLyRw/2Mms6iNeMd?=
 =?us-ascii?Q?X+O4Tzb35Xk4fuv66/edQAgSUpHgF9TvZVF5ZzoM0DQr3SS05LnVsow9Qt8B?=
 =?us-ascii?Q?KODRk9CT8AuBqCGL13W384zTd3t20gjhedSaBH63wUbUOckcW8ibh6OwYSIW?=
 =?us-ascii?Q?PpVxFW+XnUQu3URc0eqzw9h3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0410dc21-e381-4d13-a393-08d8cf6c538c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 15:39:03.7229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxwyEGFtElRopiaWSh+GlCn6dkYDAgz1WtLLmTytUwNyfrYsW9HHhQaJ7lUm2ytUVoZM3FEQvzQDLEwKxO2cyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4599
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +	/* Only one open per device at a time */
> > +	if (!atomic_dec_and_test(&rsmu->open_count)) {
> > +		atomic_inc(&rsmu->open_count);
> > +		return -EBUSY;
>=20
> This does not do what you think it does, and does not prevent multiple
> applications from talking to your device at the same time.
>=20
> There is no need for this at all, as it does not work, sorry.  If multipl=
e apps
> talk to your device, it's their fault, not the kernel's fault, that thing=
s go
> wrong.
>=20
> And I thought that Arnd already told you to fix this?
>=20

Hi Greg

Sorry for not replying to the list, I am new so not very familiar with the =
process.

Can you elaborate why it doesn't work? I kind of borrow the idea from xilin=
x_sdfec.c and I don't see why it doesn't work.

I mean if an application failed at opening the device, how can it proceed t=
o talk the device without a file descriptor?

Thanks

Min
