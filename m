Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1F320921
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBUILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:11:04 -0500
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:9569
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229914AbhBUIKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:10:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEwViWeJz2BE2857OhG46tR9aFWW/t+TCiD1GdLzuvwMuy88nWaOAOzA9VJ1ZduoViMNHfx7r/+PU+xVjb/ENBrLlvbcAUlbz+o+y7JWtEd4UdFdNzzMLP6OiuTc8rP1FwCltYQIi8qe22CMN+TAWNru58a5reVqlqCyTJfgisGUd6wrJgst4l+p4my/lcEbVANUMkAjnfNdsaAgHpJRTYZTNiz6hoYpHH8XC+YCx/A9DkW512aCzGgMRMB0kAaNncjHKW9e/Yu0+ZUdgyCtZwPPez1OC7xJAlLw/joVdhQeiYOQfKTlTmM3/ICBpCmAU/fN8g3sJF4+rQi1JxvRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O92PnxaVGvXV+Qk3DdJCpdLpI83FsTPLQ1DsIceiOg4=;
 b=LE9ozA3QtnzcrQW+QnGcLHHsjwBGGYpBHPCSRBAKi9aACsoini/+wNuLe+Y+gxN1Xh+MFCAZCrvh99VendtZ+koY5raHofQ0QeEejNdJ76ug8KYAu5+Okc0SjchK/DZjEi1XUwyTin6kes0dxv1qozRsaFnmbqpX2Ngw9FCZbBN2ITqWE5L/H5sD8Wrhkj2k3cy1FHEVviknXHCMjCoQ0mYud4Rlz87ln6IOqsDFL0KUhO8W5avwacNOb1XJIlTgeSriCA4D+YEYewROHK/wlpTCHyeucsjD5uxDJK3Nj/0Uuaiz4+erZTn7kW0vZ6/xrJQtwZ1AbOsqRYRZAGK+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O92PnxaVGvXV+Qk3DdJCpdLpI83FsTPLQ1DsIceiOg4=;
 b=ZI7oXLQCvduqvJc9BvL8RRe/hRqaaUEWMTwFurDleYPv2ZlMhtemd+9FcbwNmwl2UHFI9F6xIml7K2CLDUxTsRzTKi2eDYc7Tjf3O0mC2EPHoOjdPpTA+ZQQv/8QBK4Reoxu3GU7P69hngDvT1PSIBy3xaOn+0nJQXl+9sgyXQ4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 21 Feb
 2021 08:08:51 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:08:51 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/8] lib: test_bitmap: add more start-end:offset/len tests
Date:   Sun, 21 Feb 2021 03:08:22 -0500
Message-Id: <20210221080827.84862-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221080827.84862-1-paul.gortmaker@windriver.com>
References: <20210221080827.84862-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: MN2PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:208:160::49) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Sun, 21 Feb 2021 08:08:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee821ff-36f8-4ae2-be36-08d8d63feca9
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB474002188968FA34DE4895CA83829@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sw6H9y8mYtcp2E//LyS1Gedg6hnvoICx1yJMAn7FaNjsOwcREH52YE/9HaSPu1wN9SQ6vj2YmO712LgzlC+pgLZ6RH1+x6AB8PSEyjl81IbQiqLYBRo9b17dSckWL0kPWDRNASC8mre39n/KO94BRq6CXw71g3e3XWkaGGtqvR79um2NxsT0JquDg768acuSqQrwF9rSGq5NlyfMobjvzsIixDvBDBlJxz+O336xTrBJwL2vqwLheXxT9TKGbfQPaOEDP04ZkeFVaYtKhLruZeRSpKkJ7bIjTg9jNwEhwoMffQNvzodfyxsVBnSzOO/gdgCbkS/JrXKs48lfefp21vwJypyV++2IPwmitOUIfFiseNC4n6zZ5SacOuS4iuOOX8QNrP8vBowkAcFKMc1f0b+Asg+qEABWfYDvfn0vQLaXei/gcpdMBaVYiojt8CA+0RYp27ea0Yn0ln395LlBUFFwCEjDA2RKeLSawFqVNEP7wz5KAlGk7jeEvGnXRVgqEaSq/iWC4YXXdWzZAx2WJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39830400003)(346002)(2906002)(16526019)(316002)(186003)(54906003)(26005)(8676002)(5660300002)(6666004)(1076003)(8936002)(4326008)(36756003)(6512007)(478600001)(107886003)(66946007)(6916009)(2616005)(66556008)(66476007)(7416002)(956004)(6486002)(44832011)(52116002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zun0TJG0zCLmg9ra0KPT6Qwrnj6hQVbPG1yzzHmzlyQJVq0WxX1pqx5dzJw4?=
 =?us-ascii?Q?uE0xVAR6J462irK/hRnZMR2I12sksBQsa9sym7iXOdftGx2UrpC72MPptXNF?=
 =?us-ascii?Q?3CXR1+YM4/mCidwdCuhV5Zq6fkCfYcDLzClHC9yKJnPBgCwbtLgN7b+It3mu?=
 =?us-ascii?Q?4ue/AMM/WBqFYxtqxHuqzsVRrdefNDouf1EHVBpG8rdbuHcAxYA6S4gCluDT?=
 =?us-ascii?Q?+TYKr0fj71KrY+Y09tVsQflolJhe7tKbWYZ3HS3nptuoiru9Uq+O33cjJYMK?=
 =?us-ascii?Q?QXgqQER5cuTDiQR8qJV4R2Inj7bB4EI4a0mxSszjPQE3C0zu1rLww8WQzSsh?=
 =?us-ascii?Q?UAUwMp8qzn3lQ9F1Ji94mC/U/Tgc4RZ6+efSja3a0UFiNpAfqgzHyBORv/Pm?=
 =?us-ascii?Q?BO03Inyu5SVGb/1keGkdli/+I3Fqu9JKXGU7nkOPRYJwcAgSLFQV7nywbtEZ?=
 =?us-ascii?Q?zJI1LuYxWXXJruWV9MIwlqEi5nBjSG3dvLuGM079Y6malsU1mt+OqcxyyKAX?=
 =?us-ascii?Q?XcBRhUYI2tYE9sd/EqtZY7cYWN9R4Oz/xbUkIgIJ6XC80s9TahTEQXuBTndx?=
 =?us-ascii?Q?60Tu55RgEujcjVljICBekRzd2r9W3lx7zvs7sfK3VwzaTKitHL/hMcs7J7Vy?=
 =?us-ascii?Q?NxZgZgeHS0eUqWQPOzEqZM2OCF0SsYB9Dr3SwDSzGs9xmGpQQ1CnBNy5bWKK?=
 =?us-ascii?Q?2PKxN3TRML8+IjV/C5rUT+buTjzVvZkPjIAq3LdVlMmy9R6TER+zT+jywFXO?=
 =?us-ascii?Q?iRUHdyK7RkNgaV2z1+gN3jJv9cSmyCd/0pC/lNHZ+zBY0ZwdOdFIOsjbl5BG?=
 =?us-ascii?Q?jwlF+LLsy48EkotqPJ5JgqgiJ/+sfxN5B8GaoLYu+wPGYk5I8ja3d6eXUwgW?=
 =?us-ascii?Q?pApzddeSQJMXmDstT6lQeUjxX0Ac3zRxz6tEaJ/W0C93m5t1FqO0Or/y7kAy?=
 =?us-ascii?Q?S/qTr2FVfjxgoWFkJkEa1HynmjqfOzjG3RsxYHiIMgrRvOfe0DZsZkOqBxZ0?=
 =?us-ascii?Q?8fuDZ6dRlPV433AhH4tc9/Fn7uYAfN+hio6KID5e4GQ+IihJ6oSOYiKeUCcE?=
 =?us-ascii?Q?VdAUqon6zAYm7iGIiGyce5QuKFbnq+XUAehSajS/Bd8j3TAWTyR27J5ChQar?=
 =?us-ascii?Q?wCqXSibu2AmgrEfDfuoj9yNBPLU3ONdkiPcqzsLSrEMklmOD0Q0EW+FbJk8J?=
 =?us-ascii?Q?IV6cyRY6PY6mlpEPriGp9LMQY+Bg9Ew/NzNZgYULgQarmqkoaeINJiy2torz?=
 =?us-ascii?Q?KhT4L0QrdLJ4IHbmTGhVUukrfHBdlZFT9ZEVy+Hp/BrrSm/RJdPlRD8Fc678?=
 =?us-ascii?Q?CUTiDBEtX2Cx/HtM1S52/Z1o?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee821ff-36f8-4ae2-be36-08d8d63feca9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:08:51.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9PsSzZftafvWBGkDn48JNZKNv3FhpcoQ5eWONAtP5TUPWXCmbysl13nqClI8HMFR0nm0YKrMRzfk7vx9rkT9zzQYEihVgB3QET7+8lIABg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are inputs to bitmap_parselist() that would probably never
be entered manually by a person, but might result from some kind of
automated input generator.  Things like ranges of length 1, or group
lengths longer than nbits, overlaps, or offsets of zero.

Adding these tests serve two purposes:

1) document what might seem odd but nonetheless valid input.

2) don't regress from what we currently accept as valid.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 172ffbfa83c4..9c6a88c480c1 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -35,6 +35,8 @@ static const unsigned long exp1[] __initconst = {
 	BITMAP_FROM_U64(0x3333333311111111ULL),
 	BITMAP_FROM_U64(0xffffffff77777777ULL),
 	BITMAP_FROM_U64(0),
+	BITMAP_FROM_U64(0x00008000),
+	BITMAP_FROM_U64(0x80000000),
 };
 
 static const unsigned long exp2[] __initconst = {
@@ -335,6 +337,26 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, " ,  ,,  , ,   ",		&exp1[12 * step], 8, 0},
 	{0, " ,  ,,  , ,   \n",		&exp1[12 * step], 8, 0},
 
+	{0, "0-0",			&exp1[0], 32, 0},
+	{0, "1-1",			&exp1[1 * step], 32, 0},
+	{0, "15-15",			&exp1[13 * step], 32, 0},
+	{0, "31-31",			&exp1[14 * step], 32, 0},
+
+	{0, "0-0:0/1",			&exp1[12 * step], 32, 0},
+	{0, "0-0:1/1",			&exp1[0], 32, 0},
+	{0, "0-0:1/31",			&exp1[0], 32, 0},
+	{0, "0-0:31/31",		&exp1[0], 32, 0},
+	{0, "1-1:1/1",			&exp1[1 * step], 32, 0},
+	{0, "0-15:16/31",		&exp1[2 * step], 32, 0},
+	{0, "15-15:1/2",		&exp1[13 * step], 32, 0},
+	{0, "15-15:31/31",		&exp1[13 * step], 32, 0},
+	{0, "15-31:1/31",		&exp1[13 * step], 32, 0},
+	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
+	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
+
+	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
+	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
-- 
2.30.0

