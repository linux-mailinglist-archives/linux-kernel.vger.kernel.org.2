Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED884373D59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhEEONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:13:15 -0400
Received: from mail-eopbgr1410129.outbound.protection.outlook.com ([40.107.141.129]:11934
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233908AbhEEOMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:12:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiPaELgbQGwUyALQYMDMv5pzMHEWqgyo3mMB4oxVFIL/mSXcDgLalTaV0izcDstaKtHiUwl7hYwvOfDjvqvTF4lCFxzVyIQsnoV604b4ZqXMqSBpXEDltwN2+kqouuyH6ZjR4HzdyHY5Csg449CaGmXSf7jCkd8gTj06LgoEX2WdEJf2jYeA+T4ik9pln6g/Icg8Bi8M6ESmmT6Rk32LCEsC7qFkymJstLFlz5IJNKU95hcoGCb1IBt67vELHqWdE9dqlZyTV0ny0q16dk55DTusEgem3r8stejCRZEtQNPX72GPoCSpctNyC/ngclp0CBJaLY/9v32WUtXafFxoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS7uA6ddIIb7EEMn5TdmQdb30R26ZnWcrIViCmoRwvA=;
 b=T9GjpX4yW6suFx6KMEjufLr2QeHeJxWmGsugzWgNClO8gf0pva+2+OueUr/hy96QAOloZTqR09xSgtgxFRGP01BLZE1FLxOkUfEt6L5xLfZiSS5YmQUFYCstnq4iGVkhBjbIcwc4snhsfhYUV6iI4KNMh77W7S+aRNqMwkm4ya+8VZlutGHwua2inpVylSA+vDkc4/7lknY8YehucOj3lWx0mnxnvs5Hx/JxGekxRq6tFHX6atIDUEqZUrfSyPdYQNQRpzdAZUd52okRABmiTp9PN4M0VufgVDNCc2SC9Wrn95YvO9qMzIcO2GjtmU7CecZ/OBoNe+wqJgX46mD5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS7uA6ddIIb7EEMn5TdmQdb30R26ZnWcrIViCmoRwvA=;
 b=OzSz1H3Xb78c2FmzIL1GNKjfgSFP8+PoOdqSqL1wV0Mbk8MYTEnwDcX+0zk8c74j7v1sa5IbiZNioJaqQLftqS8jU+jSeqjJflTaVItxUXTlxtObEwktkDFHFZ5V5hbiPK5GaBNVSqykWXnCqQn9GdJQWmLptZNe1o+utNozdvs=
Received: from TYCPR01MB6608.jpnprd01.prod.outlook.com (2603:1096:400:ae::14)
 by TYYPR01MB7021.jpnprd01.prod.outlook.com (2603:1096:400:d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 14:11:47 +0000
Received: from TYCPR01MB6608.jpnprd01.prod.outlook.com
 ([fe80::b476:9bc5:e9c2:31d6]) by TYCPR01MB6608.jpnprd01.prod.outlook.com
 ([fe80::b476:9bc5:e9c2:31d6%7]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 14:11:47 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Min Li <min.li.xe@renesas.com>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXOtSPoxM3P4fkKEmDrY8StfrCU6rU+rJg
Date:   Wed, 5 May 2021 14:11:47 +0000
Message-ID: <TYCPR01MB6608C23DE6681CF77729C04ABA599@TYCPR01MB6608.jpnprd01.prod.outlook.com>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
In-Reply-To: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa497703-6f63-433d-6a7d-08d90fcfb86b
x-ms-traffictypediagnostic: TYYPR01MB7021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYYPR01MB7021262827A28B853DB28EA4BA599@TYYPR01MB7021.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gB5/9xrXBJgnJ0QWwdn+JCIXQrI4IHkkMvyd7g2HcB/HRywksxNwL2opS7fevu2WC9XsjMOxP4XjwN1Z+0iDy2x3b+3hc3E6OlJbGHnepVxMCNp9WZBTjyfX9/Bg8zOG0JerxlzLlF3Xh9dE7w7qZHIG6/Bj2+g9y8T9n1YTx/JpV7U2T9epOj8m4nHnpExHAzanIEfRXKuznI2rvGUSKRP71anQKwuz1emeTHcZnjs/jMPme2Yf1eBk61V+NwHKno6YwCEx0f85Kj8uM/JSwlcwtLYYPjDf8ie01PSPPWgxt2wZD3OhNl88EfKko0Fv/mtxJXNczGZ6xFWDmaWlVc3kYwvEhz2NP/WpACL4J1m2KrM2/dYxAQ9m7Ddb1/zcuwCdFiyohwm47aQpsRe0TiAQFdRMmb6nEf+v0JtIv3CWJOwDhGB02+3VJmAxsy303GBbvakdfb8jllA/Jlfl+ViPLiecYCmOqjAX+z4/Y+9aP+HRt5k1NKKcpLI2JNs7/8rOJ3fa2fcOS8bDCL1csQ2Z4KtBHNbNMWe2XoHIwy+GU5e4BBSkpCXDMjwFXD/9n3RjX9Ls6s0v/SNKh623IpiipEFp4HTjFEAW3yddxw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6608.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(366004)(346002)(136003)(7696005)(4326008)(558084003)(9686003)(71200400001)(55016002)(316002)(6506007)(66946007)(38100700002)(86362001)(52536014)(186003)(76116006)(110136005)(5660300002)(2906002)(64756008)(26005)(66476007)(8676002)(66446008)(8936002)(33656002)(66556008)(54906003)(122000001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NRffOfWJWC5WQhfVgwHcFVUwGm2CEx4zJPsiSnPN9fW0epOhaiAPcBY1Ji/A?=
 =?us-ascii?Q?sF8V12y7fy3gh63UAbNEJSiGJxchyk3n6zSb+vYOaQQw5zcw/YS4mJIsFdOk?=
 =?us-ascii?Q?jYFQvSvvl2SlOGSpE9eQZo6l3IduuhMGrSL8WM0u0HkUwr/OQ62Qbdx1T6K4?=
 =?us-ascii?Q?7N6ewlhXNpCHdV2PNAbmfIukL/GUe02u0qJQB1vVPrDGt5WACeBN4zs50Bmh?=
 =?us-ascii?Q?fjaUdCufxjcfGoRY1WFRmo4mMnDlo5iHfAPK/NJZXa5fRVtYViqoa533LIRs?=
 =?us-ascii?Q?B+OPkoSBdm6PAmRtrfPoAPt14T9ZmVgNdmjqS/7VKz7YEgzSk1IRK3LhZ4u5?=
 =?us-ascii?Q?KVnBUDY05jLxtxlGgG4M2nXO/OETd9th1jXhk65xBrveRFc0aeDcWvdL1GTv?=
 =?us-ascii?Q?LPYO+cu05zBxSHfoKf8WDPi+p0/MbctHNaTwIy2zZLQKd1XB5PFn/oD9BsoF?=
 =?us-ascii?Q?1S3KHaL+oLFDwKPzQ8+Xeb4jFurcZPExKs/A90+3o+L3e/BUY6fLWfHnb6Fb?=
 =?us-ascii?Q?jW6jQsHZqqTenuRoMnMzuOgTvN1FDy5i1/2MkaS6bCl3+xF2ea4m7Cre2yCD?=
 =?us-ascii?Q?risgtaAyDkSGZd5AqMHbRmmnOT5TJN58FeemJtH830fh/DbxUEfx3SsChQP3?=
 =?us-ascii?Q?zhvvsnVN1TGy4f/kTCyJdvKZaVfxIpPygazJtddukPqKhTv9qbwqvy9NY8Gf?=
 =?us-ascii?Q?fWnN/vQpYSPwwMT9FtKH2dtNvakEOHlj188uuXyr+i9txljOo1cmo3YEJmuv?=
 =?us-ascii?Q?xz1Yiy+9Jy69tmGdBvZlEi2VeC8ZPTOR+WGAbSv+cjH81LCK234fi2kZ3f1R?=
 =?us-ascii?Q?Bo2ADOyK26lhHe86CqjONwDqnmldZuu1qhAcWeoPQWrbDSGlU7Il6I0RDKlc?=
 =?us-ascii?Q?LnRx0Lsk4kH7m4DOo+myEs2mkAINZkjpwOgXreZ9j9qhKeVF02auCkL5wF4d?=
 =?us-ascii?Q?GYZcTeaHkb7Unf4mj714nSkpUyAkpWKKr0eiY9mOe7CWvDj64RBPJB0BNUYa?=
 =?us-ascii?Q?jokXATcxxXBpbr9XQDTA+soYWFwdJbby+sitLXKzRzkyRfQ1oujUPCBmOEwU?=
 =?us-ascii?Q?wXeaay8mx5qS+DEzWcPxzWTL/o0vUJp43kO26+y3XvUfxQYfgF6HWOQtZoCR?=
 =?us-ascii?Q?XrN5HA3c7Sfa4lqjQEod0GS8fKIia70LdkbqygrxOcfqVdaZcF863Mz8RZYs?=
 =?us-ascii?Q?ydl9+At89svOFvayy4NQsvVkWkBoI+HnCgN/tCs464MOHCaOaT1UE/HF+bzJ?=
 =?us-ascii?Q?InDzXkEPRkesw17P0vaBjBk2A5apJBpomjiCdzGfKbUbuKgyK0CyEVIyqbCe?=
 =?us-ascii?Q?iWVfdoVsJtMv+/i+ZGyctkDm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6608.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa497703-6f63-433d-6a7d-08d90fcfb86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 14:11:47.4697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wf2AT9Sf2RAlx7XWMefhLtr/f3xbz6PNZ46iCq62sw7G+KE/7Cc0Thb3ffDuqJFWCUTc4LeMup88Bn3osMGXiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys

Can some one please review this patch? It's been submitted back and forth a=
 few months now without a meaningful review. Thanks for your attention for =
this issue.

Min
