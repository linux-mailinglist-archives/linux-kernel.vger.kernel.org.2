Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9433249A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCIL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:59:49 -0500
Received: from mail-eopbgr1410121.outbound.protection.outlook.com ([40.107.141.121]:9665
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229599AbhCIL7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:59:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbVx2Mv+ymME99Gt0g/JMrGiu6lqzM62Y014Ne//L1GktJGJfG6gsc+Uj+iqxasXboKQcrhrjGjm3OLZCsiTc3IeJWw09XXJdxvzMMebO16Of9anTLHBFAyYumH6C+gjxTV1DOKMe/ZYGUxqSGJs0cpeqwladPGAtczz045idyCWUHMYwKlPDBJWhxisLeidCGao9GzxJe/kO7aGkkBcNgmNhl56v3mleBTupp/mC+BceTOLdpjD0ybxXFParStmjH4o6OxsnvvkluWDB8pAMV5zsO4x2RiLzxML/NJQEYTaOXNUjTi0olsPVptNiPMCo09bm9nXBEij1q196RLImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHP7yGlfTKB43AnxpDPDjf9HMi6TLQz9OaDwi5dWMFA=;
 b=nNK2yHkqw0AL5wwOaowrX+2B70em+cyg/t170/h6scohruc0mTdLNndAZaDUak6f8RUjlAGqK6Ss4ptZuIau+CocWDGY0ggNkK3++8t81UuqvkgLbQwQXayNKEqQObcs31vcWmB2roTBHF6w3rg980OJ9UHW6o/kvEXStR1Y3Gou1Cigginp80UT28ovAlmuQGZh5bba8RZBOFMoEkEbiGrUAjiY6fAm866iCDwQ/cmUwjqclvKX+dvtWhemA9sbMxGPsoU23/Qjl/M7e6o8jQvOV/OHqXtAuOlmbyse9ZXQul6iCk232gxuhh0wc03lm8mSMzuEXo+ItR/MxLK/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHP7yGlfTKB43AnxpDPDjf9HMi6TLQz9OaDwi5dWMFA=;
 b=Z7QbG4E7O7DCxDZkkfBB/PFXMX94uHP/T1JQaeBqSieblX0fW6YynaUiVRQmNB1Al5cwnJlXfdjW+2E22P59r3rGureRBtKj3+/DURj7dS+73/SkBo9M3ir1VyjSI01DoDHDiQam02+aboYc/jSE7DTj8dLu+yFTWzoafmsMqQ4=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYXPR01MB1727.jpnprd01.prod.outlook.com (2603:1096:403:b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 9 Mar
 2021 11:59:39 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 11:59:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] usb: renesas_usbhs: fix error return code of
 usbhsf_pkt_handler()
Thread-Topic: [PATCH] usb: renesas_usbhs: fix error return code of
 usbhsf_pkt_handler()
Thread-Index: AQHXEzBZLDVGGgTzcUG+Bf2pWnAADap7i1zw
Date:   Tue, 9 Mar 2021 11:59:39 +0000
Message-ID: <TY2PR01MB36929E9390A48F6FC7042AF8D8929@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20210307090030.22369-1-baijiaju1990@gmail.com>
In-Reply-To: <20210307090030.22369-1-baijiaju1990@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e53d9599-23f7-4cbd-c08b-08d8e2f2d15d
x-ms-traffictypediagnostic: TYXPR01MB1727:
x-microsoft-antispam-prvs: <TYXPR01MB172718CFE9398D390543A11BD8929@TYXPR01MB1727.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: htN3XTa0IL9XO5spz+gFQgnfqPDLQV9uP7rMIXfRIdnjhG3kOT+L/EpP4NDjaTa82onjVZOgT7XP1tY/mG8R0aQmGXfwWBp8LyLxreLtgnnB1yg+EwRqlZ2+ktUa3RTIDK5RkqHXxkwA/sD38LcN+laTJqMcQhucDg0QzvDZhz4PLNsVsKVukxgGNHinki9rn1EiDy3VKKtA3ORztst1AyTeNiBYu7l5gBhW4P1ELC4MPrk8ns/553OsrOtkgVQ3KbW89mD238M0mBf74P6NOw5k1CVxSXYcIUYZvQZ6VGNDCOfF1PX9vS8jiMWXTlnggRmogqcXFwUZoq+DAVYyCUsAG8WsFqlHgM85MiJb/7T+u3YUkMXQ9sS5TLhrksqxDeRB7pBdVEzLoAsML1f4tgPRopo+tSMkZnGNWRLzZAn71bXkpA89ZqDEfkWxfRMlrwniy1yYuazoMN2qfSEC2ZL3b1sP/WmqksV21ghURrpBK28lTE+UYW1o2aSfubLX3b/Sop46ubaDGimqMVFZqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(136003)(366004)(396003)(5660300002)(7696005)(52536014)(6916009)(6506007)(186003)(8936002)(2906002)(83380400001)(54906003)(71200400001)(316002)(33656002)(8676002)(66946007)(66556008)(66446008)(64756008)(55016002)(9686003)(76116006)(4326008)(66476007)(55236004)(86362001)(26005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9neNwQ5M9olvaOBPgSlsIKgQ/GBk41ydocfzFHePoiEDMsy4p/2XAe2NNSqR?=
 =?us-ascii?Q?7jR7XFepAXE5VdEtGZIrlL2+a+xqgbx3FLuvozmGeV4D7r+wYFjyYUDsBuVM?=
 =?us-ascii?Q?VKPiJeox6Lq9QPeHC+75CKApO3Ui6HxCWvLFhhwtoZL/vv0KBPXGU6AvXbnP?=
 =?us-ascii?Q?uGo6AeQ7+y5fLGKXTNZT+5z9wTfEPDWI+6m/GR/ts2sCypvZl79A5xsDhPUN?=
 =?us-ascii?Q?/JwUu+GGeJRLtwfsXBWhJuPqYkHxzNmcSlkYMSOCrx2Il34GMmkVjxPxmCrA?=
 =?us-ascii?Q?wmIf9CuAxq4B3GoyW1z7yuaWfs9ZTscqAbf8H6N4tSBZpIxrFICy7WJPcZTK?=
 =?us-ascii?Q?MI46C9kzlZrdjoEbckKjbtBBVUP57ZG/Ttn+pM1y9osOL40F8AjuYYFH0gqT?=
 =?us-ascii?Q?WP53y/x0e68qBHeDMm14x+f1WddGIjy9QxXNjnMOfGKt4FuweHf/dEgGKEyU?=
 =?us-ascii?Q?xcOUtKiz3Z0gTjpojoGvbajIs3k+0VyXrChKQLv+AAvEyqdPpZMw+WGVDdRw?=
 =?us-ascii?Q?CTrZkZP7trHG1sj8wM9vW5oQb5zeURsDvPwU9/KYBJxZoUdBoSqasnncWVXH?=
 =?us-ascii?Q?N+KYw+rXRywUNe66RQfcTKt00o/5lX+w42XOhjfMKcGwgXZJaYoNSS0rOzs/?=
 =?us-ascii?Q?Ugmct1ItOAx46k2VX6FiL3wD7BVI8FxfM92bQj8SW052P4XK20rz7jO+9fic?=
 =?us-ascii?Q?yvgX44n4oyNN2erFfYBcXW3rPdS5mu2FYTMXklulWBVRf1zl8tJRp93w4f2J?=
 =?us-ascii?Q?o4yDFTLrFxH70YS7G/Zld680n+Z1vuIxPD1+bOPz3eoqUdIGf7cawu2b8IHL?=
 =?us-ascii?Q?na6xCAZwtzZBTEVfN2rxyhnQodt9GTHNPJ4yF4DGi4h7ZqJidGql7qLLGiIz?=
 =?us-ascii?Q?/RJDm8FNQSLBfx5fsXPv3/oNaVxAaiARbrbFC/yhjHt+ySOKLXKvXkVrN9oj?=
 =?us-ascii?Q?bx5AR/IvwM2e0X8eWt03oPOogPczHJfWdBCKTV+xfiX3K6ur56DV7QpiRdte?=
 =?us-ascii?Q?8+VbiA5hW6wtJABIV7WDvfzIZlqviMWWmbFhOX2FOJmdJmPHaIAyeeUD6QSM?=
 =?us-ascii?Q?xEVMPW+spsczD0luNDD+oRiVBGON2xiqHaweDWgPJ+6GbOngysSzBfmlgO1Y?=
 =?us-ascii?Q?W5FJ7x7fK2elXK1mW0/tn67tcU9acjTeLftp4r39wx1hPo15aKjoqUVeUBQg?=
 =?us-ascii?Q?FCE/BKjFmHqwOyBAgCGMAIju+YEM2OVS0qHkGRh89sPRIQLGN2uPzMXgcCnN?=
 =?us-ascii?Q?AB0jILq8gnIyu38pjTe9hJmKoQzbwhs4qE/Y2HFmdWq0T5BRWkGvljoMcdbA?=
 =?us-ascii?Q?Avb4oEiluUYvpRS1TjsnhDQZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53d9599-23f7-4cbd-c08b-08d8e2f2d15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 11:59:39.4411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EL7kPz74ir8xq/ENtMXdDElE/ooA33Kx4j6xguqBO25cZsFE7EwoDCeVa01bMDqDGfh7XjV3qUjJ4ZlvjH4JVAFTxEo1XOnL7r5egaaSPit3V+8+7U+J3u7ZkGGlbwBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1727
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-Ju,

Thank you for the patch!

> From: Jia-Ju Bai, Sent: Sunday, March 7, 2021 6:01 PM
>=20
> When __usbhsf_pkt_get() returns NULL to pkt, no error return code of
> usbhsf_pkt_handler() is assigned.

Yes. Also I realized that no error return code of usbhsf_pkt_handler()
was assigned if the type value was unexpected value. So, I'm thinking
initial value of ret should be -EINVAL instead of 0.
---
        int ret =3D 0;  // should be -EINVAL
        int is_done =3D 0;

        /********************  spin lock ********************/
        usbhs_lock(priv, flags);

        pkt =3D __usbhsf_pkt_get(pipe);
        if (!pkt)
                goto __usbhs_pkt_handler_end;

        switch (type) {
        case USBHSF_PKT_PREPARE:
                func =3D pkt->handler->prepare;
                break;
        case USBHSF_PKT_TRY_RUN:
                func =3D pkt->handler->try_run;
                break;
        case USBHSF_PKT_DMA_DONE:
                func =3D pkt->handler->dma_done;
                break;
        default:
                dev_err(dev, "unknown pkt handler\n");
                goto __usbhs_pkt_handler_end;    /// here
        }

        if (likely(func))  /// [1]
                ret =3D func(pkt, &is_done);

[1] This is always true here, so ret is always assigned by the func().
---

> To fix this bug, ret is assigned with -EINVAL in this case.

Just a record: After fixed this, actual behavior is almost the same
except printing error message.

Best regards,
Yoshihiro Shimoda

