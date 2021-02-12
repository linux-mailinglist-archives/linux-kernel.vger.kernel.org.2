Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7282731A24F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhBLQFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:05:32 -0500
Received: from mail-eopbgr1410099.outbound.protection.outlook.com ([40.107.141.99]:63723
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229558AbhBLQF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:05:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPWDXCU2kb+BwYpU0B4WaOZlZ1aCQde8IBkP/FsUXDS4yfDlhNkZo1SsdXM+3gFgXqnol505oXMXLaIEZVIin9EqqMrLO0t2T/1STf/qmAcPVZEMs265GGY+K0kTgvjRbuqzC6rHwyBVPEjmseKpm5OOgZkBTgneXlmlosWMwKCbI0i4/1lry31JeEXsxg7Ojmo/z5aQN3IbwcIznNWJlwCPK4bsJXrp9CQkYhqEfGwhsOriEtrVQ+xfteevMonzr/EYgV0GqyJfk16SD2WEQItXugE7C7s7/U8lYt4NFRBpFjQjntyuC/DtdnJl58k66dxKUx+hzlU7xo/N864RZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLhZ5Z7X6SNLi4rmZYMtjPvG0aeGOurSnrsJZRN7zN4=;
 b=NULhXNFgM3o13JJdSAnwIyQYGgNW3jvvi436rBG3rXpNmUlz0avlmDG1+hTCw0H2WeTzrKN3SEXOiEj+PQheLhMrY1T45493/+DRI0QOcYtx26BuLKUqEvEncYsMeEPk/zo+0KABHVqxAPizRoXDZuX6z44NpiDvAVMB4H4tACoDPGYophtpYeWv+ueXsBQ73ZFPJIUcdsHpMTtxL/L35oiwNxInH906xOIhARd7x+on0d5xadIlzi8TeIMnMdas6oVyIGVWuLxnYWQTXm+QEUaoOElskZ9j08/k6yZxwUqe2qhX/cJc3kKIIvFD70xfS/7cmYr5Mu2YbBP25bk3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLhZ5Z7X6SNLi4rmZYMtjPvG0aeGOurSnrsJZRN7zN4=;
 b=aNLGVLuqdlKum8R78pGqE8UMtkCZUVl1g0fY95NwuPWmR+EbU6PnvsAdYkmlyIp4XdsnBkMjwMigeUdVdxw6rlQsLsRs2924FFblhfMkUbg/TgVR67SN0PSuqUraxOTlMQTXSXEntH9Lg9wLRYTq9A3Mh40HPfkAzQ2avTKz/6Q=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSYPR01MB5509.jpnprd01.prod.outlook.com (2603:1096:604:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 16:04:39 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5%3]) with mapi id 15.20.3846.029; Fri, 12 Feb 2021
 16:04:39 +0000
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
Thread-Index: AQHXANy3Kc3xxVsbt0Wl/bCSqSMNqapUIuqAgACGZWCAAAPqAIAAAfVg
Date:   Fri, 12 Feb 2021 16:04:39 +0000
Message-ID: <OSBPR01MB47739045506976E51B10FA96BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYw5xXe16fSj6eI@kroah.com>
 <OSBPR01MB4773472EE0C8D34456C79121BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YCak7Eu2X0dzapPz@kroah.com>
In-Reply-To: <YCak7Eu2X0dzapPz@kroah.com>
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
x-ms-office365-filtering-correlation-id: 919804e6-975c-4c66-0257-08d8cf6fe715
x-ms-traffictypediagnostic: OSYPR01MB5509:
x-microsoft-antispam-prvs: <OSYPR01MB5509EABEF63237984D07BCFFBA8B9@OSYPR01MB5509.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBFAYaAuDN530TjD42WRf7/nIkcMpvyPbtf9gpyXZ5fCciSSg/7Cyes2WNdawaIT2TiXUwEtVxKezHMJpJemqhaqrmPDAEZ/Qa8oFRAkcmrAtrmZJpzDDLI2TsvuGwcUhYncz1zm4ZmH9ti+ORzCGZ9Bm3OlrKcgBzlfn3rSjhTji7WsaGJz98g7xuwa47xVrNkMP+481cKO6b1s7wX25uuHUX8Ly8AmwtTBWyVC6bz35/bZN2Cw7lbFRq3gZRuGsh9TXdYVhYiauM+psIoto5/inARVx2/YXyo68WO64sqIdMZzIkao+BlBTQ/6OrJEajgRGLxdpuDq7oWfEGEXcFzoCoFTlt+/cXzt16aQt9HUojPNiteNqFBxZGOV4hXaQBQkoWirkRZj+VCAlPB5ZXVkc6lRulF1yyTgiCeHgvpo8ue+nJzpo5X8k36sfZW4JOjGBd8qFeafuyKCJS9Y//TNVSGj5dkjJSdbPKM0QhS6S7uUY1I9xkb/V/U002crnzSI8gPFEVOxGtAWrcBbJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39850400004)(346002)(136003)(26005)(186003)(6506007)(2906002)(55016002)(54906003)(86362001)(66476007)(316002)(7696005)(9686003)(76116006)(478600001)(4744005)(5660300002)(52536014)(71200400001)(64756008)(6916009)(66446008)(33656002)(8936002)(8676002)(4326008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5d+IQGbWyUo4xBJtyjy/6OdCLCXCz85NkcOC3Ge+uUG35v/Q+TFUgYjFq5Kq?=
 =?us-ascii?Q?u+7XK1qjHFAUwCvN9J6YTB5P2Z73G3qzW6r/QzOSXZZOY0gDB1ryavkxZ+FB?=
 =?us-ascii?Q?+ZZIgKVE6YchHsh5GF07VUWjJCJWRxK4drSZfAiE/5BFHc3TCkWL2FBuRkqC?=
 =?us-ascii?Q?MDlYCvFgL2z62PawP7LbRbIaUprPwU2r5dzUJEoQL0T5HmThB+RHwb5QFVPu?=
 =?us-ascii?Q?wAFMlqG042bF5SaFa+7j0omGhTSip4K7qbpqsp4WrlgHDQiflP8dUK81OpVx?=
 =?us-ascii?Q?m/mhlBBpyAqByJkZAt1jYLrBHnZ2PVjlWkwngeHUYxHxvd+KIFWV9GzoaNy+?=
 =?us-ascii?Q?u6GmWgXubQjmJqmoL+mMGStue9QUPgwZIMDI+KbJ27d7o11fVTx+O8Na/qsn?=
 =?us-ascii?Q?aPuJIn5XSNeRGU98HZx9TJ/xzPW34VoOfLinDWOLMl2oMtMJjHGkHlo60nun?=
 =?us-ascii?Q?YRV1WBu80FkkmLhj9rS3th3tT8hlk8MPRGRueD4mpWAH6ndt7Az3SsQQDyD/?=
 =?us-ascii?Q?mHWURsfEC0w3DNgtwRM9O6DU7QgUcLtLbgijeRnxQ/Pzs0u8XlmSF7Tcuzlu?=
 =?us-ascii?Q?IWFQ8u34abtEwROHu45UeULyEVdRkJuEHyNF4YSUFJV4G/P3iNVi3PsQTIpi?=
 =?us-ascii?Q?zgzZIwTFSUKaw4NinDi2zzLPYNwucq2bd+2/C8Q+S+7Rm5UGBjF1U1woFbeh?=
 =?us-ascii?Q?D8nTeMPN/M1+yK7+NrEE9I5H6oeNENOCzSWYMr+EoTjiqL6Y5AT1SxfpcXQO?=
 =?us-ascii?Q?wVlfP/lqH8rS9dBgLr6t7dMyB+YYnCUhvzZDsH2fv2WsYcmPCxPGkHTfp6kN?=
 =?us-ascii?Q?GkIIAAhCmwjVKaG5zKnvGZg8stXuPh5LvVm91RbzujghByyJxOvgMP3sh8cn?=
 =?us-ascii?Q?IFidvkQDEAGdc0qzPDzaqg1qxBJ420HgufHLJDiTaawOGmCunt0yqRv/tkul?=
 =?us-ascii?Q?0BKIEb5rIT1/q00jPBntEP5DrFLhBeToC7qs0kRUL02U30WnVY/Hq5798Q1b?=
 =?us-ascii?Q?ywPXFExy43q+T1qkXDp5ZBIuNpNoNx7LAziPxPvOlxBzDGrJQxsvOMtcmIvo?=
 =?us-ascii?Q?4c2+us8oVDFa/+eK7e45tNQLfNlewsxdIxqjH85btIGKw8EfnFCI11QM+7nG?=
 =?us-ascii?Q?HM2y89Urz5HFn4hdwNlKkfiZifcPfUNTEx86M8b64xn9Wx5orLxW+d27vQ04?=
 =?us-ascii?Q?hZ1rCR2jRCzsFSK8nsCcXfmJQ9Ql1tpyUIiC2m7lb+fqKWFahRZEKsTqMdjh?=
 =?us-ascii?Q?xk6bAOpOgEr+uz2McNciAty8/7WBdbJf8o23suTHkMXv0Qqkq/wqjmN5FaWx?=
 =?us-ascii?Q?JBwrJ4R2V28hFVeA2B0wBVad?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919804e6-975c-4c66-0257-08d8cf6fe715
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 16:04:39.7258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zR0VcDSv3NJ8TazAtvQWiHlUCk2JvIfNaywJrpP44yk0+G2nVdw1GqcYr6O7rQofDJE5ghywpCaC8VkMB65BmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5509
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > If I come up with an rsmu.rst under Documentation/driver-api, is that
> something you are looking for?
>=20
> No, all sysfs files need to be documented in Documentation/ABI/
>=20
> thanks,
>=20
> greg k-h

Hi Greg

I decided to follow Arnd's suggestion and drop the extra sysfs attributes d=
eclaration here.

Any other documents that you are looking for here?
