Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7E358B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhDHR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:26:54 -0400
Received: from mail-eopbgr1400095.outbound.protection.outlook.com ([40.107.140.95]:21241
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232299AbhDHR0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODcr13yhAiS+1CPOioRrTFQAZ4lIvcJwO29Ti/SD0ipBhtMTn+8ESBdFsCqnYTsU8ZUg86foONqpoTsFrKXszVHn2DbbT3qTJBD7Tpq7RB2DhnuGxwH3FKpER7j7fxGV8+g0+6XcY2bWOeRN7ooqchpBn+iHiP3c1YuLoWx3gNcktmtvBccHVeKFH3NhIrx2pd2yIb30DrZwBFDd4dson98vaCQxNexLhb6oZnWrJC+iymSmtnmOvlaa8e5VjiVQx61I3KRYLcusew2YKK34CFYtRboWtnJJ1mh86iOwK38YgZobryjofm703ANbPzNGVe6KaFIv18r3wK0stLuuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE9S/IHCBVACIJ6V+9y5KN4T5aNFTPwLAGNh5EyTvL8=;
 b=RSIBfRDEnIl38J4WKpJLhOEwhRF6ULrmzLHQNdoqUGCYM7M2/X9N4uv6suqJ+oFCqTe+ShYmXnrM/HU5YpsrfOxANcrj1dz1Bq4JQ/9ZPiAUDe9u5kdHekEJvw7jqEySlHsLlaIXWirtllZONGx6jQ31gf8IP9msnj/lb7uz5tpHLlV+uhdWSQHeQ0jebEzhwqrXZMNl1rJRlusrSLpjLN9dKt/1HGoDX48HgaO5El3pU27upXJn2GNVjkTBNwNGv2G2EKwRYuLtq4y5+fyKCyzzI2nzZRQxAQ+FpZ5HO3qim6jH6ttFSraHUQJa5iBGkwZ+RtoNEcvoL2Q4Ofek3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE9S/IHCBVACIJ6V+9y5KN4T5aNFTPwLAGNh5EyTvL8=;
 b=dDyJR95qvRodWG6DuYD8bxJ3bodmsmzJXlXnmGIuwDYuJDtEcrCtZFhevguwnM31deHdO+ttonzT8ErbYixX+aWkn2Mt1bD4DkgB+8YTo8ZJfT+1du8YztPpHSMxtgQfOWnk4kv8VGgIwpEcKwaqnbCXtdzd59v7HGnvChBaVFo=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSBPR01MB4055.jpnprd01.prod.outlook.com (2603:1096:604:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 17:26:40 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 17:26:40 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXLBphHjneZXXdB0ur+8N3VlMUXaqqJv4AgAC3vHA=
Date:   Thu, 8 Apr 2021 17:26:40 +0000
Message-ID: <OSBPR01MB4773182AF8FD263D65D52949BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <1617846650-10058-2-git-send-email-min.li.xe@renesas.com>
 <YG6hOuOO5EL9xTwH@kroah.com>
In-Reply-To: <YG6hOuOO5EL9xTwH@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd3bdc8a-b0a1-47d6-1dc2-08d8fab378ed
x-ms-traffictypediagnostic: OSBPR01MB4055:
x-microsoft-antispam-prvs: <OSBPR01MB4055C8B6F46A165EC4584072BA749@OSBPR01MB4055.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BMPM+o3txeYrwr8SEpS6dsgg7Yct/ZiMpNmdyhMsF7aISAkBjjtXmPbSgK9hRVZ+DwgmWEJNObceuSheNpYH+8fUZZEElDxzeEAlByv/eWyr+6ePX02TUXulRmFDx96Y8ZOc5o5gOU7AQnzG9/mE44fSPsGod4gnMmNsLFCQjjSREXODFt8PjFXLWVdB7/cclFAk8G0Tg23blzguUlAELYIkfdfJymUnwPOtKRm5GRt0OxRs9fgQy7zwuvvKnauiCCOJ4o9Coikgn5wT/JugZxRr599gbGWzwhYRyolfC+JEo8Zb5GUjYfbI7W3VUaTMoxa4+U6xQoA7iI/oM3m9G9XvCc5raZNrnWYa33+mBV2XaE8XdxLWFz0Ja6dv5KPNzuzdqhEqthjtgmjiiiWTpoew0kd2kM3zSLrPpBaSC337sQA6d+ILq41POb6c2vjEbFsqWFyGCkAl5MvHZx2Q0UXoqt24Vswc0J73gAz4dQ4ZK6M5t92otwAQVRQ9MaqqNd+lYdkkL+iBrnFs2FcRgPDTWVVHh8zTUZ2cqyHgynlxWJIz1uljjm4CVPQuRi5ldH8YpQ9F7r5+lCsLpTgq15Sq8ERj4vOLPWOf8qC1p1uhUiePY6IXRGyUCcs0jwdITenJ8fHN09tNZf+ELcu2VtWNrMSsIn5mXiCFiDxgp8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(52536014)(316002)(558084003)(4326008)(38100700001)(2906002)(8676002)(6916009)(64756008)(66476007)(7696005)(66946007)(71200400001)(76116006)(33656002)(478600001)(54906003)(8936002)(55016002)(86362001)(5660300002)(66446008)(186003)(9686003)(26005)(6506007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kURzqQDLkJ/4M4Npplg8KIIc0QWi9bIV4pE39Zt0UlzXUQEPyPyHk2sfEK9r?=
 =?us-ascii?Q?TS3BlrI6YPPzDyCH77t7HmI+GaipdTzyOTT6zkX4qq2IHYkXaY2ZHIjcFIdx?=
 =?us-ascii?Q?vR8OLTwLc2eMDj4XZZE/5goVPfP9ikwNkGaVJ4mH9oSBKS7/NAykOs0XgWYd?=
 =?us-ascii?Q?swBU4jyfnUywyNWP1Tq9JlnXjUh9EfLZQSh07g5WYqw0iODThzi3o7w+FM2b?=
 =?us-ascii?Q?3DlT8SaNNQQBz+b2d6YdG4n+qUPOKYsOs2FqIsl1ZxmDIuQsS7IHMLhQsz1a?=
 =?us-ascii?Q?yXcCh6zvVuIQwz1ZJRN2P361GpWlkzwSfGptVRJu0OexpzUIf3Xizv12Weyf?=
 =?us-ascii?Q?QOd37zXcHp3t9y3GrFTfs+N1SElDVwxPIzPgMtk80nmc2iEMXdalHJnpQfWG?=
 =?us-ascii?Q?5DxN2ZrlphFGNOjHJ4NVFAbvUfTq276uqPik3BM382n3B56VIiTi98ua7a95?=
 =?us-ascii?Q?HMWgEDx4JV3i+HhZ5CWIgQ3+0M0kDuorN6ONTB2RKrIY22ZfK+6Y1wUnpkcm?=
 =?us-ascii?Q?wD9FsdwjH6YW7SZE1VZT8Mo7b2tJXG89k0/7mWqa0HbLpGg9XzISP90ABdI1?=
 =?us-ascii?Q?ty3rkr5ZyU97uvM3QNAtb/Re0+/vyhfZxSrlvE7dkO1d3UJqpkd6ZckN48dU?=
 =?us-ascii?Q?JvImKyeytTliIlfhHNU+w4j5Ciz0aDsFP4ab4rkS+huUMXnWKRFNPpI69WnG?=
 =?us-ascii?Q?ujv+arhS95re2BbjQZ5eKq5CICEX3MhCY25LTe0vaActbSdm2SrrNDoHA+j9?=
 =?us-ascii?Q?2otZjRwM16agN6qvQ7n+BvICxd1xsE7Y0XP3HT0nmef+e6vr1cfwK2F1sMyJ?=
 =?us-ascii?Q?6Nbe+FxZLDBvgCjykhq+zHUO80510JT1Linodozs+QXGLTrAfz3b/JTIPgNw?=
 =?us-ascii?Q?QSEi48NM5/jwlaZ4L/5MQlctZTt0MjMpIFwbB+oHenk/98Ipurv8UD6r096N?=
 =?us-ascii?Q?nc0ZDen8VVdyP+xrG7SWh23bB2Ll2Vf7SAu99xNyQNeuERAWiPTufEowyqBT?=
 =?us-ascii?Q?zwffVMrcRIqE9qPmBgung71hz9aV4ActFZ9DJv+alUr5C4RXKSpLkc0zDn4z?=
 =?us-ascii?Q?CZUhmn73taqLpesBGO52+9y9oaQfVyHZJZGIJVQd4xrjUxJRy1YhWa0YAdyu?=
 =?us-ascii?Q?enBU3y5S7ShgpJF0JxVJi22oWqH57nY6+kPUXecg9HSjbrDYpJRrX/KoTO6G?=
 =?us-ascii?Q?L0MMm2Lmo76aV3wB+e1fq10TEQiy+nF9FDNt+bilvCO+FeiE/G/He9XuH5kq?=
 =?us-ascii?Q?44eKA5ycP+1tG4sgFzqf4CR8PKGCDi+whzp3tnHtaBzlS6QlSGJ93nqlZv0s?=
 =?us-ascii?Q?yfW7eRbRm5Y5t7Pa9hN0JbD5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3bdc8a-b0a1-47d6-1dc2-08d8fab378ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 17:26:40.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kTjQTeLoxplCrUvT9D1oj1vPBBHDB/Hegm0dCpazupv5gABDiaTFhqI9CxjAoUBh0uR9+5z7DH0WbnhX/k9yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Again, please make this only one file.
>=20
Hi Greg, the 2 boards have some same named registers in idt82p33_reg.h and =
idt8a340_reg.h
so if I put them all in the same file, there will be name conflicts.=20
