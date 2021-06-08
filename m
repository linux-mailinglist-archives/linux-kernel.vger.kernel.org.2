Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71339FE3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhFHRzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:55:12 -0400
Received: from mail-bn8nam12on2107.outbound.protection.outlook.com ([40.107.237.107]:2561
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233572AbhFHRzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:55:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/ts1+ZCSkajB8eDztXT9YpxeYEuOdO1iFWU4okSCc207HO9PqjpfdvuxyNAQ4CGfs+rS6WiB5jDnNdzQED4mo+bp43Qx+fGjPFu+LBuJ11DtKpxAgvYziZWmtITpcEBagIWYSXFxbdIwkHR4RbAa5CaICJ42c9mKhb9x6506PSycEOQl4KW62lBajPF0/kCJ15+ONARYoiF5FpH5IAo7v6J42TlJItn9AAd+9Nqwv4hOYjxrlgDvj46uLQ2ZAXYYpqW/AIJUpUMLFwIM8yMxbjzpMNGrIA28atH1LCIeQCxQpGkid2/DYIlGEZ2AfCQE1STf3ndWGarIOA/xn98fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XiWjKjEjQ9gJ5FUqeihs+Y0x54Gt5HR3NJCbGd+8FE=;
 b=gp6YBrQTK/q22GlFzXuNiPlHt9P1ceYG/vsalLahLuMFyOIzqxJoyvyQ9rNApM6Ytkgd7SqER1Kj0UeOl0Um8Y7opmgy+u1GSP/ZE5VkF1sZ6umZVVpKa+yaB3tDQk+l3E7r9PpCxGUyXbvzfgNngpHkb0VlIAQp9ZF8BnsriL2MNutKcWF+9lLAIzK4zhkBI0M87eAqvpJCTgCQ/5kyT3+Uj+SX5lD+vlY/O9kCPqY8kCcFZcgCVzZMhCsK4De9y39+3FlqxLUD6E+iH9z4zkIrc0CFqzBqb8uIRLkMWKVvG7m8uMF+wk2INg8QyklSp9rQlYvE1q+ButdSo3sX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XiWjKjEjQ9gJ5FUqeihs+Y0x54Gt5HR3NJCbGd+8FE=;
 b=PHckJaPsE7mG2iU4QpPuTXj8YA+roYuMGPiKXTCSeTiw3xIoyiY+pRTIyjj3rbKeeuPmpuZcbx/VW2QPMWHJh8GpKILLJVeHqH811GocylnWMG/FFrua81CrJQR/eRqYPcP011VE2UxsdJjeIaAAoYEefU2iGDIHj5SOlv7UrJQ=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0782.namprd21.prod.outlook.com (2603:10b6:300:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.4; Tue, 8 Jun
 2021 17:53:15 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dbd:8360:af6:b8a2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dbd:8360:af6:b8a2%9]) with mapi id 15.20.4242.007; Tue, 8 Jun 2021
 17:53:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>
CC:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        James Morris <James.Morris@microsoft.com>
Subject: RE: [GIT PULL] x86/urgent for v5.13-rc5
Thread-Topic: [GIT PULL] x86/urgent for v5.13-rc5
Thread-Index: AQHXWqlnAKc2uywMC0GvJuk61QX3pKsHYb0AgAAWV4CAAAbygIAADHgAgAAQEYCAAUoDAIABgUXA
Date:   Tue, 8 Jun 2021 17:53:15 +0000
Message-ID: <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <YLx/iA8xeRzwhXJn@zn.tnic>
 <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com>
 <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic> <YL1UucKH0GfXddZo@sashalap>
 <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
In-Reply-To: <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c9e8de73-bd8e-4ad4-9f35-f6a9f1a5f42a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-08T17:45:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: namei.org; dkim=none (message not signed)
 header.d=none;namei.org; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beebfe4f-e212-40cd-1d25-08d92aa64aa4
x-ms-traffictypediagnostic: MWHPR21MB0782:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0782B2C40F2BBB52D1196048D7379@MWHPR21MB0782.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ky6PJXTxQKvJBDEkpW4YzHJwD3Mz1u7sd4RalF457YcWqakXlCBUXiawuuioXK3WAuR3PH8z9u/5EPWwxqpY/Yz3LU4vXqzLs2Jr8Om3zU0V482ox0RgrVUfBLlIlwXOwp3IZVRgCAFSgeGvZGpAw4OOjp1e89UGNqy1WEk0EetDeeZ1Qs9I4JqR+rjiz5DnIA8jffkqKy69P5MFSmvNi2EyczxgE2sGMDNt1imAHkKqzkV5kzy+DAcIAtHSdz/l0cDafB+vFiP34M8Eso0RNOpGQ440KZj3ZDo/0aeOqdzfQMZaX59PqwNdf6SigqsmH5t6kHcdkBChUVQXPR0TNg5Ny+D4sbi8k5GlZBpepM+uuJN3h5A86WXvi57pQpgzjKCwjABZMD000b9FjOX41luOov1taog4ejU1kH3e9wz2Dho7Os5cktypKcyU700ZwgE2RoO5aZNkiZCgcZi8mBoIg4gFhfnAEN21stiXZtpJKnJKPWIq/y8ufqDM/rwcfj0GytSEpdUjmhsUJOnT7PtuYxyvH4GcFlFKPgrbg8L3JQ0BoGxgdcHAxbqbd3feWy1SL+nrGeR9Bm6xwsK9BuQLlq/RLqbFI/Kg3B0WBO/ugwerAwnQ6AZGgFVbHLdQF2CGXY+xY+4o2gFaektd1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(110136005)(52536014)(38100700002)(478600001)(186003)(66446008)(5660300002)(66946007)(26005)(10290500003)(8676002)(82950400001)(54906003)(316002)(33656002)(64756008)(8990500004)(86362001)(2906002)(6506007)(4744005)(7696005)(8936002)(66476007)(107886003)(82960400001)(66556008)(9686003)(76116006)(4326008)(55016002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GomMRMf4bI6/j9FzUuJh5jm66u/eZF+lhayCgbVR2lzNA1aAZeh60W/xdSlP?=
 =?us-ascii?Q?9rZVt5l3R4wpweeJZSfsZ1GbjhhIOvt7l09jWvotYzU3H4sAe/t8t9/sY+WP?=
 =?us-ascii?Q?dYJE6MCYQp5ZNYr6EGPSNYYVZpZMd7X02O/avkOpvQM+UsR/IW7g7ASn9i6Y?=
 =?us-ascii?Q?NpJSPtbmYDDqe33ztVRpI9z7bl3WQrrcn6S4rhfodvBrzL2astk/IoGnrf0b?=
 =?us-ascii?Q?OuhSy3lWVwIzOEYTNnJFPFXmEZV/ykcMXvtqlrtv8EsiuRdCal5qUAL5mx2x?=
 =?us-ascii?Q?l47jPK/PMvvg1q2etB3gkTLt1/lTrXR5J+rciCcJvSroCUyu8Y7+ZRl2Cjjv?=
 =?us-ascii?Q?2FyOG8hor17/YlLrVLdpKUL0traZYz5bnwlwHpn076kXO4VTWspjTQep+KCJ?=
 =?us-ascii?Q?sArW3gcKhcL6xXWf2oQtGC+IC/nkdP5UkAcsCLL1aAnIrdffO7ff3GtMoeKB?=
 =?us-ascii?Q?ljINPGgVhbQA7mQfyiSYPtux1A3KgA2Vu7uvCvu7EgQ6R4BBZom9orZ4QE8O?=
 =?us-ascii?Q?OknRqbDctAgG+v/WgdOIBpIwRrprj0ca2ROUHxDE9Cwgk94XOkALTheYagLv?=
 =?us-ascii?Q?trzkfc2/guiRFhe/6ol2W5EP+HkoZf+BJXFXLRwMP8nA4buPUG9HdWRwU7hi?=
 =?us-ascii?Q?OkWIJwSUpxj+KC3jptgdBnVZqxjSuuuohAf9NSv0iVkiaT6MGchzdQdAP53F?=
 =?us-ascii?Q?y9/cFuHh5b5PpaQFgBCmWhSeUJ6pkBwd67gWBA3Ht1L3e4PrzxSo6CWWmxbT?=
 =?us-ascii?Q?ZSfJoVHpfpriYQFQzRmQUduQFULG1pLIcBupn5HwrDRyqItY2l1KGkYQZL6f?=
 =?us-ascii?Q?JBfBg0qTOgyfFo8lrI1b8PXWfWn6t+nT4/cUzt/j74IAa624umY1QnrXSq7G?=
 =?us-ascii?Q?xk5Apqn+gCmDsrayELIN8IxUvtTYZLriTI/MXH1Zn0XlhCntlSQ2B1Wa5x4y?=
 =?us-ascii?Q?RYdHfrLLNI1Mm/LB6I2T9OscJ06dRRbjEMkufqx1+TbJhGTiGACuoXCagU+h?=
 =?us-ascii?Q?tNxM6+K8tlc87YbSv2XeS/jbEIR3P/qjmKSvBvp3tBEgN5/4q4FCNjGHFmoe?=
 =?us-ascii?Q?WG16YW5xGqJHTryfhyWj/w8t5xY0Uj6fDi4+z9nFrapqA2LuDMYOkIUtTPrW?=
 =?us-ascii?Q?bvi/Dj558xGdVddWRHI3OYUk+M0HuU7RBH4BtZh5IQgM5XFNkVABRkIMvliZ?=
 =?us-ascii?Q?AW4Y5b2AN2nJR6XRKIbyXFt9YcKomfNrrTLHyHPwRGc8K8AixTEKxBSjNe0o?=
 =?us-ascii?Q?i3ShD8KYI+423SVaBRfODc6xfN8ix1B4FdafKlTwGgjXEtZQ7IB8brLxCv87?=
 =?us-ascii?Q?zslZU8J+xhW2qdJ4BmF/fXi8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beebfe4f-e212-40cd-1d25-08d92aa64aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 17:53:15.3193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eS5luHJu2WtcoVFuDs8eV69r/Mwn5zwQLll1/lFbEP0JUHF1O2Jc5f76U9O6aZqwbwLXw3ZTwqqJ23fu8UwodKJgSFqrP5k+1jNkXCsozZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0782
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morris <jmorris@namei.org> Sent: Monday, June 7, 2021 11:47 AM
>=20
> On Sun, 6 Jun 2021, Sasha Levin wrote:
>=20
> > >
> > >Let's see if Sasha can dig out something... CCed.
> > >
> > >@Sasha, can you figure out who we can talk to whether Windoze reserves
> > >the first megabyte of memory unconditionally?
> >
> > That's a great question, but I can't help there anymore :)
> >
> > Adding James Morris...
>=20
> Adding Michael Kelley.
>=20

I checked with the Windows team.  Peter Anvin's statement from 11
years ago is true.  On Intel and AMD processors, Windows unconditionally
reserves the 1st megabyte of memory, minus one page used for real
mode startup.   This is done to work around BIOS bugs.

Michael
