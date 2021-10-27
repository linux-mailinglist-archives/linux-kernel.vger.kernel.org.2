Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4043C844
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbhJ0LIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 07:08:40 -0400
Received: from mail-eopbgr1410103.outbound.protection.outlook.com ([40.107.141.103]:10800
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233865AbhJ0LIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:08:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXbEImL9dF1a2fM7zeNuWYqDWo6BMjyFngqBs7HQnwcrm7uftl0A8L9e//UOrmVoQlekm6YJ+XaFPR0GISHHomo5AyFRZyw7aVjL3EzMyp7TqZh9UEFGFcnKC21/Kh+okDo1HoQfqdVvLLy4syDeKS+TgQfTKXQe9OqLXli05RtdhAUf1Mwn/JtEITqYmOABUy7ATOKh3RqlEj2bzqFns6TW/Wrg/6psQlAnDCXkHhivbuvDlsVtekvzkSHlDzaSIfz/Gc8fHc42CkW9JMbxYfbXvRa81g1pxp1ivHuT7xyB6rURpBb/YigwDvqeywG3rCYCAiM3drwJjHz4VPSGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTfDZ0W7ueix02CcbCXmhBUp4uNfQK8wsivYeHfhvFA=;
 b=T7zrRO+1z7SQQALzrEdkv+Yi5Wvm7CPYNgcyzXtTFhkes6mS96+evRr8SS12dEONopLZFk9pWE8PSf9NpfdEv5UEAhgLVMKv5u3xp9ShgSnAMrwzd+VBl43fYWjmFzafJpIgYYrmKTlgN4+Y0iAN2OE/Lmuf45JFF5UaqAh9/j2CceI9v45JV/590KvZiPXaIR9FtAqD43t9wgXB7Medw9MUB9HcdbpJhraXMImBNmNu5imrVHkFa6CMlFfx6Ju4szjIE9wZz6OFfLyIoEQ8NlTwGbWtzwAWevum6y0S5mGH6Xf2Ch2RWB8et2z4EzwivofhhUb6MZ8rud+5Apu+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTfDZ0W7ueix02CcbCXmhBUp4uNfQK8wsivYeHfhvFA=;
 b=gAvM5ZrCXeSbUSO5PxmallfcYpMoYxLSIb/KjOvJHHP0p8klacZGy08jq7wb0fF9dhDQP3UfTsfUO3g40bDZVEjmoKMj3hgqGcsa9Jd2KRubf6Shbw2VH1qSdEDz0zBH74HmQV86othSkHVojJgUzwvy/lax7RQeG7+A/CenC2A=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYBP286MB0381.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8023::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Wed, 27 Oct 2021 11:06:11 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 11:06:10 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/crypto: suspected missing null check in hisi_qm_pre_init
Thread-Topic: drivers/crypto: suspected missing null check in hisi_qm_pre_init
Thread-Index: AdfLImPw9K3hXRldQ8ebJhLRIqPCMw==
Date:   Wed, 27 Oct 2021 11:06:10 +0000
Message-ID: <TYCP286MB11889662BE368CEEF92CF65E8A859@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f07fcbc-81c1-4c21-e111-08d99939c8af
x-ms-traffictypediagnostic: TYBP286MB0381:
x-microsoft-antispam-prvs: <TYBP286MB038156084BFC1845A60F955B8A859@TYBP286MB0381.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZo9e9+zOM6NNFtMGd9nuDRLw4PEydAnmq8Yg3YePDc8j00DGNpNyhlxFqSNjEH73GU3BEfPkv28KlVqlGocJfl+0I/9PtRMIE6WTgeHYoN2ncCo8Ksw99rwMOPVJs/R3CJ+egA1eIcN8XfonvwvEHyNwrByQOSxKEFYDAaVaqypkmm7uVyskCCMn+01EHk4OuK2l7rFBSHwZbd06uSNu2+2ZTGMkt2idDWwDlDyJJXS6FJPe8693aQLdekcl5WHMHBkY2xQCZt5SwvJ2mPLWyFJj7MeKh8/WayYbi9lwFcQjv4hJHjQQ1QaqXspc0+bo/OtA3OAf3CP4aRZzP49KcXToiQRyHAcz8i2uWKpTsUJxkJ8AayYKfbJx3TN3IUEOpIjKJuanl/XIbZHqkww4/lnYLD2RlRWyfdilRm1Q/N6o4R6dUTY7dv388mWBgwtUjAVg7P8h/5t5g3UTk7mP8/l/AFLg8rRQMrrYoQ3DyoTSluS/63s3Q9tmLD3nG6AWJAB9RPakbnuX8alcxPNs9raFIzBf7Rb6yD7AXyb/+eMxaL/zU8gqcqJmZZqgPoih5qWEcfWl5GzXnig5RzJgCqzNEPuJTYD5rTQuE+2oz3FpTOpg/db1Ed7rjlVXf47GqW/PI2wR1aCtsrPDjZns5hasVsw5gbBJBpl49ZiixgkJiy1TNeiO+adzq5q0iUu8AAnJ9TnAiLOTbcAtXA8Xzxi0un/Zw71GFKpR5hGvJc0QQdKeilu22tdOjXVBSvnAxQJmgbNg9IbL1ake0Ofiv/NYl7crmPsO/SajPiXG/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(110136005)(966005)(8936002)(4326008)(26005)(83380400001)(66446008)(66946007)(5660300002)(55016002)(9686003)(786003)(6506007)(38100700002)(8676002)(66556008)(64756008)(71200400001)(186003)(7696005)(52536014)(66476007)(316002)(86362001)(122000001)(33656002)(2906002)(76116006)(4744005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qwskMt9lh9l2xiJN0uZaqPLUfdlqwTgiJHA7ShGtuHFbFudGElS47aq/oQ4M?=
 =?us-ascii?Q?2nATaX+liZV28xPiPcWuSSIAtMbtmcmMDB8XoLaeowh/UqlJvuk1i/ppnDeA?=
 =?us-ascii?Q?n3Lcj/Z+aPuFK2pSvDSyJ3Evbpn4qOk/85gEr3LKtA8ewb0nUVNYcIIaf0Q/?=
 =?us-ascii?Q?5QOD4duieBesYX73jLO+HRhJe7Bk+KgnBksA6cfasKwYgH6YqyFv0Il9xZPz?=
 =?us-ascii?Q?lQXyeYM9EhMi0qAnQfwGo4OrhNHj0v8qfdOU/dRhHW/MGIlsULpUXZLjvWaq?=
 =?us-ascii?Q?6nTJUPlonPEjXCSxVGoRgxbBqVTA9MazcLfJQ5744iXbVQbnlG8gfkSWWw4s?=
 =?us-ascii?Q?Uiq9Rc6AeKs8V8rnLXAHK47i4sp/1xqMc7TXVyVbCvMI1itY+bmYkHBbSlFD?=
 =?us-ascii?Q?HIusigsRHe/12NrQgUvpbXnhlF41HAgwKocTQTRx0NIfBPThQvzxUwVHGZbG?=
 =?us-ascii?Q?/n8Rk2IHAzlztvNuYabP1HhDaa4hFkLcvvQ6wTpXIAlWOpyxFkTxpg6/xomO?=
 =?us-ascii?Q?JEWg0HnJncZ42rEgpw+DorXuSuAmuCpiq2LLBb82CiH+ZJ6o0mZhN0O1sxkZ?=
 =?us-ascii?Q?66bG146m7CBuNCnCXg3Yaa+RqDnGgxpskFhqf3ruEwzGRtudeGNfDVQ/LxCF?=
 =?us-ascii?Q?f9jpUH2MXnBy27SVUhDz143XhRjAda3ItohD6RZ+ApIy95zBIGMVEwudGK+M?=
 =?us-ascii?Q?HlAdzT3J2uoGdqA76mKDMEXEV2ddOx6A121NtZPSzEIcP+VD64xF/VP2Bfk3?=
 =?us-ascii?Q?/9jmQxuFugpVGmgLqq9t9MoNVPV7nxB/xXycox8+VuqsKNwgK0M4ruO8aD6f?=
 =?us-ascii?Q?RgtFT3uoMC362GA2tO4Fq0AUj4Gj3vhOozLmBUkp5TgHNDULlgADpyiLcvVg?=
 =?us-ascii?Q?U56ba+pXkm26JlMNrbPNOBCVt8kNvFALpXW2QZvmPF6oi6SRE0JdG7DOQ6p2?=
 =?us-ascii?Q?Ek5gh1DVfGB4nA2HqQ/o9I3VdNqtT0BpsRoffTo16atr1nHc8HqN55PVk/FD?=
 =?us-ascii?Q?us0wRFyWfYbId/IlCktcyjGv1DfN4Aaw4Vcoq9IBPnokA/6Qfvya9bFixVp+?=
 =?us-ascii?Q?xoAvXe0nLh4CFf7/PsDyeO3s53sZYXfWQqeTm+yKoNkv9QUPwyvYvL8pWlaP?=
 =?us-ascii?Q?h0+/Is0VA0SFx32LvWH+eMMLDQ84DWUUu3wpmwUZ3b2nYPl1dTnuYMt+R2IP?=
 =?us-ascii?Q?eL1fsK3jB0m33nL1g6OeNYgiQe7IYtGY/njkvQPly3M2lTpnvZVQFJOOSNR/?=
 =?us-ascii?Q?OTM1D3lJjoZMLW0n1oh6EU2rZe2AOxFzTeOAvxcp+uRNikturzNQRSFNKagL?=
 =?us-ascii?Q?ORnVBeimFQG1VofFhLimBXLLg67/Ti3RBBBM6NCf9KIJIQ0f3Ib7b6XdOKJK?=
 =?us-ascii?Q?C6EtsFSHTL4Izb0X71SGHIhRHQfntRk2w3NcEvr/ewoPGSTfntq0W576lofH?=
 =?us-ascii?Q?ZvbgGQLYmplFd6kNb8MllobTRWV9QSUsgBmE2B3YT7O7NHJ9RmZE7THjnnMu?=
 =?us-ascii?Q?bY5/wilYzi5GxpUQmf+gDrA3oDVvpw8WlyvZ+w0M5/yDfswRbPihDoBfrfzj?=
 =?us-ascii?Q?RXqEhtqq4sdlnKrvK75/sV8czzslMKQnlvW/ofZmaXes0rAVcO2lZlLGBQwi?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f07fcbc-81c1-4c21-e111-08d99939c8af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 11:06:10.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrR3DhhEgjBxPuW2uO2qrnzWxc8NSzlyVvdzORSTsswdv7mHJ0n2Pg4pbOBQbQL4Oon5c+N9NxNLa8uWUkEr1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0381
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/master/drivers/crypto/hisilicon/qm.c=
#L3286

We notice that at #line 3286, the return pointer of ACPI_COMPANION is not n=
ull-checked, and then it's dereferenced in acpi_device_power_manageable. Se=
ems that it could be a potential null-pointer-dereference issue.

This is detected by our experimental static analysis tool, it could be fals=
e positive, so we manually check and report those we think may be true bugs=
. Would you like to have a look at them? If it's real bug, we could like to=
 provide patch to ease your workflow.

Thanks so much,
Chengfeng
