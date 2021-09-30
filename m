Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34A41D12C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347715AbhI3B5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:57:05 -0400
Received: from mail-eopbgr1320102.outbound.protection.outlook.com ([40.107.132.102]:16427
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233941AbhI3B5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:57:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDlU99MmCo/+MrRFuJNNBmv6hskeFbdjmBJcWrkimMacsMgwySeIMYmWOCphV1qciXViPzZMs+OPpHrVJncLDyorZKPbGGuw2nj53FezbW78WgUEBW/UATwfp9jvBzMrZl1Pglc+StOFxwWN2nLXar9YccyhsLuy3DVBA60CvEa9eMq3V1VVf8KIRUlbVUMawVPTQjArCFFgKjYST/YVgan7sXC8oNv9HMgAoQgkK1oLtNrZVQ6gIsY0Hm4eY8z6rETnBsVfJTQOgXJJhEjmwb6cfTaof4gt/5d/TxKCrwgPs9f3r1TpIzqRRd4TV4AvOLSTLd8NTcgNh3J+3INVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qqG+PaCFfoSZmZd9vDQ7BFh0VM9G4KN7P/ycXseFHI8=;
 b=eOXO/pPWr3UpmwGn0EhNiOmuLMrtI7Y5cPtnEgC7mdxDoSyIRRXi9VQyJkcmYmVHF5hoNAd3XRH/cUSTAWQk707+AZF38esA6umBUl8q9m1QpkA9LV8zLhQrsN+ZszreqPd7tfB2pEYYgwcYtyRN8INjEP2ifYwlT5cy790/ODc38Ql0UCoMciTS4TamXw7HmIqhz+kJwEYOoJw6VHgFVE/hz9JPb99FI4A/kLK6SUNgXhnb3GzQ8zAwwJTmw9UgOqbqMk286cvzDEJ4ZcUskO4VPib38S7QVLu2915N3v32dr17UPrN55TtZb2NmzvqF7HLvJrBIGlkHrAXMO4UxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqG+PaCFfoSZmZd9vDQ7BFh0VM9G4KN7P/ycXseFHI8=;
 b=iOTtlTM1J/uxThjHrKLLH85NkO/4UqWUbKEsG/hmoirCy41E/evYWce+EMhoQbOfW14bUNkYIlwUmJaaMXwXFY4/X4GfkYQfwAs291At4kqUUEjluc9RzYsCf3aVmoNeyFfsp/pj0F3lGPQbwnC0TGayICOkS7ZA/PYpvVGH5qR0f467Ciy5S3S8dX9d/3FsbnuahsNO1I0SVrQ/WS707JwUcUvqnE2Fz76HNbbMJzFDoNIE2UUDVrWHoZ6x27ji0CwBLyk5vTGzMK1UBIpM/IvMfCgwPBGbS2m8O4vaDP5KY1Ff4zjHbiU9KA52mLuAc4Ai5hc8iUSPztBGydmRiQ==
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com (2603:1096:203:b8::10)
 by HK2PR0601MB2004.apcprd06.prod.outlook.com (2603:1096:202:e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 30 Sep
 2021 01:55:20 +0000
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::b0bc:df6:113:e08d]) by HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::b0bc:df6:113:e08d%5]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 01:55:20 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "osk@google.com" <osk@google.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v7 3/5] dt-bindings: aspeed: Add UART routing controller
Thread-Topic: [PATCH v7 3/5] dt-bindings: aspeed: Add UART routing controller
Thread-Index: AQHXs0f9tHefCzsXE0KVS9CQb4i9M6u7l1EAgAA9ngA=
Date:   Thu, 30 Sep 2021 01:55:20 +0000
Message-ID: <HK0PR06MB377971D66A2ABA4929D3646791AA9@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-4-chiawei_wang@aspeedtech.com>
 <YVTkjKdXcyIVImmP@robh.at.kernel.org>
In-Reply-To: <YVTkjKdXcyIVImmP@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f24f332c-c297-48d8-a122-08d983b55c0f
x-ms-traffictypediagnostic: HK2PR0601MB2004:
x-microsoft-antispam-prvs: <HK2PR0601MB2004EE128A85555D5AB2C00B91AA9@HK2PR0601MB2004.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SyVIyab2IfvVspQOGGusER/cjPuHYTRl2ey8qe1vxAI95ocLXoU4jva0o+bRkytCoc9rMulCzdrxNOk1jTQe5pULOvPOFOTXCoGlZJ4ZvM9FMMPNU3ml3KGqMlkwSFB749uENpYjrqIHlzROp1+l8nLulMcu02IrjWVOdsK1cDOPBDAepnmOQZ17BxWw/0zmOOSY3Rc66OEslSuYD/dx0nnUGDO0dqMdOzo9yumNLa9uS2D5dufUnBtDSpPpOV98MSskXE04tb8pv6b/sopgMP2IakntOX1Hv0cBrUnJeO9HctfC5T8HIO6QHAEjuDc7KZhaWz4c0+JuhzaBltT2j4Do/3/dFvip9oKROlUmRzJjWWYVMA2C7NFJx6u0S7Fh0PpdIzKKpehzi4yrCGCnrOeEcSAjH2VPeM8Z8J4VibXDDoadVYKhy9HcMpDJjNgr6+Kf7w86xi2DJgmcCP6B3bzmFI/eqcxPRzj4eqXxqnte7ScgGzp5YQ+e8VoRo1vHVi68GzLCPKvBoUwRKgZXWvPrp4aD/XfapXt2fdtNTVl04PebClskMGnC9Gbjsd37cjZoRNw/DhQx/bbZ3AML15SaNdvd3nIFcjQVFtVB+aYZd+PPGZ0e2MpUXzZIWao1djfgONewvmB80B5AlK3s7GANJyOMletnNu2kmG3YFVPxRtNzGHmKwskt1EQxxpgDrH6pXTsa+kaV5bROnpaibg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3779.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(508600001)(186003)(52536014)(26005)(4744005)(71200400001)(66946007)(5660300002)(76116006)(6506007)(122000001)(55016002)(8676002)(8936002)(6916009)(38100700002)(33656002)(38070700005)(54906003)(7416002)(316002)(66446008)(64756008)(66556008)(7696005)(2906002)(4326008)(9686003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Egkoc94LmopKOCJp8Eehf3vkTktGKBU3Ihp2MAJuJGADJh+kWXMX2n24puId?=
 =?us-ascii?Q?tE9aaQI+2VMAsASew01+t7LsJQQu89tO8HBjT+QvQi1Wi8UIkvcFN5fYIOT9?=
 =?us-ascii?Q?RyQhipgwnYhxQy0axpA5FQrGYMhdpARcdOxZOgzXi6++CBpepfSG2SnyJy3e?=
 =?us-ascii?Q?+4fh44T1Rg/wnKn3RcQkVDvog2eMk3iRlYe6zZCgzb+4HfNX7JnjVQp07+Ha?=
 =?us-ascii?Q?mCnfnxZqZQ80Ipp63HCc+71AV/IDlpljPqXZz84v393Jp/OOHiXnjghAAeWr?=
 =?us-ascii?Q?cMQ/yx4Si0BgqNyZkCCiDtepKP2MQwewYtoESEjW+CHVVLzH8k6vXCQoVNPP?=
 =?us-ascii?Q?1JiscV9kK4t42P68ff0AFY3qCVhBR9XFWxcSoqpQmW6ODaXL2/Ek5M5ofsJO?=
 =?us-ascii?Q?0GxQfaOiYCkdguzQmFGjT7EOEsmq+l+bNwd8uIn5O9s3CGSJiGKteMaK62Kt?=
 =?us-ascii?Q?Yr2MB+7mZrs8U67rb5JeVoqnbPhKBG0Mz1EVsWQtbexj2xFxVKUAnPgQok97?=
 =?us-ascii?Q?Vs0dZ97bKwlcA6A5cqi9fXMVMPrKtHVDw03qqqyJYEJpGK8GtzEYQW9L6f2Y?=
 =?us-ascii?Q?5lTBII2l8pQ9ycBv7KnIBBLTOFry3QEkQGptWPMYQf9qP56oTebo3w5Jy45Y?=
 =?us-ascii?Q?ZyUQg1xQTr4m9T7yppnqMRcR3hOEZ5eGEbM//5mdi1uQHNAE/VeAXNO+B0ih?=
 =?us-ascii?Q?E6VS3qJ5IALRD5iPdNp2Zog1LLbvDMEyKuW2gEPvADx9LMtnI0POXilKzpN/?=
 =?us-ascii?Q?PwOHNY3OuGJsIIvZ1597HK1T7aGnvV7RxABa/HAnAHm6sHqkJB7jK6CZKZIY?=
 =?us-ascii?Q?blvK+/r+7vaN5Jj9BjUWGZDx+rZwb7T/03xLaR1FkK7jQvZ2ZN4zKvcqrB8T?=
 =?us-ascii?Q?51B4szLne0SWw/s9hD0ljt+5DJxwClh2629RYUjJelthVU9bMo9fqSgEW+jO?=
 =?us-ascii?Q?/Bc8M9gpdk0H0P/68DrDWpdXz3uOB1RpD8HO9p3+vlBjkjBh0y4GdE7Eue2I?=
 =?us-ascii?Q?8ntMU5x6fEFVFiGJEc8v0iSlzzrWP92ElLeCyPhRvDKDsR6p9V73ZgQkWAQ9?=
 =?us-ascii?Q?nWJH2U9I2faabBk7wYAGOaTC/ESOxcDkdM+E8fuSibXjbd3C34VabmU1uYYj?=
 =?us-ascii?Q?U8Hxf/m1ad2U67aZVYF9qDo3sRMiQax7hgnwKPQFOrsLZdhReCrjg8q0BiC6?=
 =?us-ascii?Q?Zf1CqJZu13HPsJZI22+oKNxe3tITyBIwTqJ7zHa4zPXVeKJL8jo45bg+7Uad?=
 =?us-ascii?Q?l3oR5ouAYw9a8IAyQnhBD8nIHY2Ez5i6Yvh28sqcV+bxb2FTMQYkXnOPr2Ir?=
 =?us-ascii?Q?XfOaGLb6ej8WQHA7cwd0BhoB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3779.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24f332c-c297-48d8-a122-08d983b55c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 01:55:20.2625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3T8OH05vM0kmSJMia2tJ10wCBmzH8ostjSLPkGpxI5uk6sUvxgStC27vln1kueFnQRerlgiz43JiHelYXA+VVCUBvAOGOCy7n8wLkm/aM6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB2004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, September 30, 2021 6:11 AM
>=20
> On Mon, 27 Sep 2021 10:30:51 +0800, Chia-Wei Wang wrote:
> > Add dt-bindings for Aspeed UART routing controller.
> >
> > Signed-off-by: Oskar Senft <osk@google.com>
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++
> >  .../bindings/soc/aspeed/uart-routing.yaml     | 56
> +++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> >
>=20
> Applied, thanks!

Thanks!

Hi Joel,

Could you help to review the rest patches to see if they are ready to be me=
rged into the linux-aspeed tree?
Thanks.

Regards,
Chiawei
