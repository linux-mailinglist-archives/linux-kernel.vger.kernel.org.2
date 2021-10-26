Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44B643AC85
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhJZHC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:02:57 -0400
Received: from mail-eopbgr1410118.outbound.protection.outlook.com ([40.107.141.118]:10520
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231233AbhJZHCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Caz1skk2ZCU2fwIGJ1DRFrfUSRcdqU2W7m7ydWTmrQy0DiGZu1gTUXiseVS//GB2tiNx1BEtGzjGHhSRCDdIxtdQkHv2rGACKGJswW8G6GV1SoA0/GUptvMj4uQgFBhtLbKRC18iZWcHs/mMuAGS051PwI7vQuCcn9GsTjH4K8vvOwgdVX6Q9d0icJzbAvli9+vhtaRgGqAUeuwkLr3GzDMRi2Iyb2d9oHNdQE/YH2pSNfEE8fTqwQfSQsJtEWMrF+gi5q3VOVUyGpb8Mb6wRL8C2W8kY5WzGrbKg81CkTRXBRmo1BrEhwnRsyQ7wHl73fBAlle9qppmtC6st4rrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQlUTN+UVyy8e5S4O2oJw+g1SEUBzHeTpuCPtWo5GGI=;
 b=cUIYgML8ZDXA0gwNSrNXjWOfF6qub1OejjDIMghlSpkhh2g2bVJg1JnIUijLsVP0KXfREkw/RwAmJbdNxTfhCAIiuFwOsRQ/AYVG39kdfzsnWha3Y2EjJKg++eSRdmrWDibIgcFZ0a+ekLTd16NPp9kEI4Zpo/5Db4QEuQ8mtSeG5JIWe52JqjXumejH3gILRASBodkzzVFuiGgXrIhlu3+zudO7Hd04Iwf2ToCUhmpbiZiOYwICGGSezh9S4QBxClF3iCwiZjksoJeKN3+4cALnomJ0xAQdA2bcOOzUJ4VFC3Ys6nQtu9Yv88iMkbm+IfgtnY57fMedak2C1dw+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQlUTN+UVyy8e5S4O2oJw+g1SEUBzHeTpuCPtWo5GGI=;
 b=U2K/RWdJCK7VICiiTp0PTjmyTzwzujgsFcc38hL5W/liW6+4IduYbja1iCal591/FFC6EuX9XIQtBtSw6nre9Oxfl9tuUPTp1w0P3kkvFkONjYOyHpJQ8RtcpYJkLZBvVXSkQnzr21NL2cFzZ/xqaTSIHAYea6Ny33K1E9Xcu/4=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB0878.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:77::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Tue, 26 Oct 2021 07:00:22 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 07:00:22 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/clk/qcom: suspected missing null check for callsite of
 clk_hw_get_parent in clk_pll_vote_enable
Thread-Topic: drivers/clk/qcom: suspected missing null check for callsite of
 clk_hw_get_parent in clk_pll_vote_enable
Thread-Index: AdfKNx9H596yrqX+T56TbsWA+cLqtA==
Date:   Tue, 26 Oct 2021 07:00:22 +0000
Message-ID: <TYCP286MB1188F60382E69E029F8C4A798A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 145de8be-c400-4ef4-2799-08d9984e478c
x-ms-traffictypediagnostic: TYCP286MB0878:
x-microsoft-antispam-prvs: <TYCP286MB0878E9DA4E599DF495D443938A849@TYCP286MB0878.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bH6GbnZ+AVIFOT0B2FUjfARw6G38mIyXiUCvLJRanPlVur04Lpz3JKCZXlkqhhGpKbLzPrEpw+IyeSW12Sev5qZ7w1qig6xp/ELqKhC0Z+FOUhfUnEBqpEWITVNpJnfjytKHain2cSzUapV7ILjshOReWQ3jFfZPz6+7DzFx9dgGmIWV3Yr35TtOrm7xeh5iZ2JMjUxd19b4AufjILxuiItQrdLxpJtK98FCdZHWN/kX7DSPl3GnnRAKXHA4jk6qKdzGoVbdDIfqvVjhJ2ftKSv9gf+6jlu/y00Tc7xjPBnJF+z/TxXPwcDUzc2oDi4v55Y8hO8yqpxOooJHUeCleqf9B8uuCtCzYT/eRZtV9Dz29fXyINlyk9gm2lFJZCFvkzTYBqKLxpEXfvhxTfLao4E+yMnpdWgHQiRS7aRlKdlnCe3AqopBlyFcxAqzl1VCBvxS9hjR2SXErqMZ0UJSEXiJ0+MUm4RJqI9jgsIr9VRUSp0n4dX6BO3M5bNM+7IPuJ1cdhdnAmuocO5JRX9t0Dw01LXu5aOZL9SMq1zS3YIN/kCjJ9/fPCpcq5k45b3QiJkvE5VamIuBnaj0YLZi3gwTHSQHEFBwy7cU4FyroQMFnt4fxk4YLA0xT2ehlEddbpq2d0eX/WNNaV0XZt1A46MaCHqBjRgyf7Otp25wohB/59r9vmkTgx7UwSlUDtbHxYnBKJbAelxhyVDm/MJltaG4sfJCCQjvPP6BsJi8RP7bOU/8GyXgOWE5L1VYEdkiCyOC8gnSNISypZibLZKS6LhMP3aiesso7LR6rZg+Xhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(66446008)(55016002)(8676002)(64756008)(7696005)(38100700002)(38070700005)(966005)(76116006)(4744005)(66946007)(52536014)(33656002)(2906002)(122000001)(508600001)(5660300002)(110136005)(66556008)(71200400001)(86362001)(8936002)(26005)(6506007)(186003)(83380400001)(4326008)(786003)(66476007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sQv2ST+o6rD7wvA0DQNfYI9o9TU/prFSA4jEPkWGtNGUb1Uk9IhEy1RSRVir?=
 =?us-ascii?Q?30vJbvZ/kv0ToxbigXwr2/Hzlo+Ikn1fc5ULTsx/huVHuzvARaaFUb75RbhG?=
 =?us-ascii?Q?xuzBMrVB46fcGM9a7eRUwsL45dOpylCmuEPBwpNuaiKQE4S3EgtAoc/kirV3?=
 =?us-ascii?Q?T+pNofDIC1zoEu8HAzMuVBg9B9DwttecuqvwVANF0kA71lRQo1ltZQ7YjIml?=
 =?us-ascii?Q?rPlY8zyjXfZU8m+0JyJ00TX9o6X4t+HVKr1zhGUIIwvc04Lw/pHZD88MooSb?=
 =?us-ascii?Q?S+RfygPZb3wn2S/d7lswmwwvxnSodgMMjjQk5Ltmle22m/54bSVnTaT4/eb5?=
 =?us-ascii?Q?wFTMzbkiwkI+zFBe+1Ltp+DLV2Pa0/mS6ZeUXQmZLquEbKbYwlHPNF3HYt6P?=
 =?us-ascii?Q?2b1EYftmZoluapX8kXPHOPbDgsEufbvIP5a4acMyMdvaynV+4jO2Br7pVYNX?=
 =?us-ascii?Q?Bu/7hNHUg1C2DOKLqwPuOXe/x/FBFW9w+HdE6Cx4r9FoFByGKMzbz3whsQC3?=
 =?us-ascii?Q?6H2C6Vte8HcxpyESV2rncudIkh1krgjGZCPIEXHpRHyiMGsp7GAu1IEYvTbY?=
 =?us-ascii?Q?9DusEwYr1hE6NtS9H3H6F5AhEMfhEEiRqFFU5R5223bByt3cGVQImOtRq5hx?=
 =?us-ascii?Q?5PKO14C2eFQBoC/jhdFmObkK1blBsyNgQyEA3oo9iIr+sWJKtREShtWtuxa9?=
 =?us-ascii?Q?tXtxZgW4mH4rT44o+sxYl+WPli5RpqQmJh75uDMF4ACjpFZgGqxG3UilB+sd?=
 =?us-ascii?Q?BjFAh45OfMW81clEY594jVYWUeXVwoYFtR9ZVV1GFHIhB6c2Yaf1NMW1+YX1?=
 =?us-ascii?Q?mquwcGmXCm0jszahOG0FTJHduGpzkxPM1r2+KR0Yl4hldApJ24dwK3794r5R?=
 =?us-ascii?Q?EOlfkGSUDimd9Mc5VTptBK0dVu0u2BChgjXjrt1DdLt8KVOwvErmJvr4IJG+?=
 =?us-ascii?Q?biOUEgVkUyM49SGIsYkoTS5libI9ZYgtPi/nGOlynYA/MByRO+sZPV8iH+qN?=
 =?us-ascii?Q?4VJrEVi+gN3wlCjpp4/9+ZMce94SOe2OR/Uo3I8jGp+mybWex9QPIt9LQRIx?=
 =?us-ascii?Q?NDVzBpCu745nMSoGGzF0WW3G+q4nj2rJFU0j7vqRHwkdGHxFRuuE065k49MV?=
 =?us-ascii?Q?TsWb1kEjHz9GnwkaKp8z51hedLquajBGBqSv5swKf58FmsNy7fe7IhE9p0i4?=
 =?us-ascii?Q?3A+Ghu+i2GnnNYTZSfX8zTsxN4UQTJvav7NzS6mKe8aG3Dje6EBcNlml/yM9?=
 =?us-ascii?Q?LkMie8YCzGCmuJf0thFOLDC0kjDuGFLLLw+l6WYXaaB6adiSaIXCQ/gJbHDt?=
 =?us-ascii?Q?BbK4vudX9tWp2xiLY5Oz/g/3gR6M+6ff5FepX+6/jspNHfA9r8s6+sfzXJbM?=
 =?us-ascii?Q?KcqzBxBmBQaZxZjbttyaM6SQ9DMRBRSQ3m8yRW4mvjz+x5T+rzq2bsPqsP22?=
 =?us-ascii?Q?+I8BJBq5QZVycexUCaUugxpXxN605zLv2r3rmc7BVtHqFoNxhC28IyZ4bapG?=
 =?us-ascii?Q?keEF4I03fa4QmyKKLjVn7PSxWhRCwUODHB3Nq1LxZ3Pt5PfvaZdQ33Sk1iRp?=
 =?us-ascii?Q?GePKU9gurmg+K6V6Bn62nW4PVhidFN4615RaDDZg3VjfdkMrtYYJMdPRJqZF?=
 =?us-ascii?Q?Y1PD1R4iNx5sQPX9MkvwOvA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 145de8be-c400-4ef4-2799-08d9984e478c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 07:00:22.2156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/U+CwSpviUYTrZm3+Ly/gYkoBaHg3pPccSAUsmOtjDFYqnVdDFkH4gpZI7T0ehzdZJ5fOf3L8qqYIKAq1jUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/master/drivers/clk/qcom/clk-pll.c#L2=
03

Our experimental static analysis tool detects a null-ptr-reference problem.=
 It could be false positive, we report this to you just in case.

In this call sites of clk_hw_get_parent, the return pointer is not null-che=
ck. We are not familiar with the code, and don't know whether it would be a=
 potential null pointer dereference problem. Would you like to spare some t=
ime to have a look at it?

Thanks so much,
Chengfeng

