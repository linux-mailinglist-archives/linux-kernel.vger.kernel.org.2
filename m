Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F162320923
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBUILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:11:47 -0500
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:9569
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229966AbhBUILK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:11:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBwgSU9BwiZUSkhDe29oisUxHja5j5OHR7kZ7S81fbf6wTzDChOFL1JFkcti6lgiycCeVFDHP9YRUYI5zCgo88GPEnL0EcOWkBsD8+VD2IR/43fAZc2QYm7QA4orPSSp2dOvFLa3BXz5ndtpCj9atKp0QBrtlH5CmlVoPYnlWbZYGSC2ufFWf9IWImfh3gOShxoNt5lqa/Xwn7fyS6II2Ysuuf3eeYO2B4uXkz5UZD4kNLOiku/ZdqGGkzlpzpn4Df6L1/0A6SnyR9k2uieyqZwsNtamXJqR2k4Oe0/wHNyaPazRFRraHgVzfsB1udKLO8TVe6TWLrD8E8Vq6Qnwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F9DO8JEDCx9cUU/k+tK6HhdZb1ccR5Of/EON1D/zQ8=;
 b=nhq+77T1DtKNQTzjKYrfE1vcKF7Ib/xm2IJ48+rWYAxXzFM2uC9RjsOVZQZXPdcM7wSGBJ/GRhRQXDJ5mBosVX3baMDwSijSnd3YUxWBqToEiAqQizhXcc2WfGnzA5AFe5mXr5nkpCoEUVT3fCjOJMZgNAtHv7c7Egt/RVP5FAF6OYo1ha8MaTO7ghKpIZb9eulIAjJaHZTzDVOC8D7It1PHKdMbir3RKTRuTy5FX0mgXc5F4Zi1B/EnbzK+g0QTlqGH/e0hD75MUuhb3a4Hjqy8TAbWEcyv/KPh3hWGH88QpyOZfwyUrkcasHFNcmm5ErTD7lXOcfyRfOS00gBteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F9DO8JEDCx9cUU/k+tK6HhdZb1ccR5Of/EON1D/zQ8=;
 b=i2iPlNyCZFWBMQe1CvXWx0IDu27nJHy6qNsvdd/k87nQpobxQt58Hne2A582gyuKAli5hW6EIyUZuce+HFJeEiSjEUKoTATAY4Hts9Rxmrc4bJ+gDcXmFKNt//gkby22mVikDFrtBMyDeZ1BINQpN12zaV3wtepIF86snj8GmH0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 21 Feb
 2021 08:08:55 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:08:55 +0000
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
Subject: [PATCH 7/8] lib: test_bitmap: add tests for "N" alias
Date:   Sun, 21 Feb 2021 03:08:26 -0500
Message-Id: <20210221080827.84862-8-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Sun, 21 Feb 2021 08:08:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e30a2f93-c761-4e08-de79-08d8d63feef8
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB474051CFE38A08F754F08FF083829@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7SHgHGSxVKhtgI+Ii4CuF36itSprTG9VYxYCqNqr6DgoJiWVwiFW0XJfNZNmmN2ub+bmOEoyromwKEUlpcHxV0YsChP9GXA8amO6L4InGoAZ6s2/plXJ8ci4VBvPRWzdivKpwHXz3zAe1l88ksmwI3GmL7ihdKWnJkj+ZVXIYmFevh9+AH5OOCBpsfCUo2r90ES8UsrcNgvfKasBbslIc8NFxPTIc4EJ3TtW9A9zWOJ/11rfz8yYzYY3IVYlQTeyt0IHseXj8LNQWfQuJyvT7OVza7gvy+wHx8RpUQrA4/DmcZYTxKxiZ/7a2Kkch1sTH0vOM1OgBA1dgTWnexFX7p6qvXfAwHIluIJx5rdSm0PecLB43Mnbn/OX+2Z4QxSG/YHIODIEHjSVj6+Rx/xI/Yk7iSau5iQJP2epDKfaUM/ajqdARNegwKlr35rFUIwVihWwGacLNHLTtnJF6DICuhknRN2WjrUWaPhMvtPYLdBQPf6fGEcKvaeVWfHp1coNBtF/3jIFq0tuV74d1AlFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39830400003)(346002)(2906002)(16526019)(316002)(186003)(54906003)(26005)(8676002)(5660300002)(6666004)(1076003)(8936002)(4326008)(36756003)(6512007)(478600001)(107886003)(83380400001)(66946007)(6916009)(2616005)(66556008)(66476007)(7416002)(956004)(6486002)(44832011)(52116002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1mRABo441zXDiUknRA7VeuPmjBt4dxZFc7Emc1WJ/x35Isqtb0+LjWDoU7nk?=
 =?us-ascii?Q?kAH5M6VI3vR/aLqk7UVxI+OIZtBiztoBeWyn2NOlABzSYOqDdLP8+e+GLdX8?=
 =?us-ascii?Q?4BhJRSh6esIci7HFM3q94srW+ZIKp5OUvH3919Ccb9Z6tazCf3nCGfYKVG4F?=
 =?us-ascii?Q?DoXMc09dcPpXt1drU4mDZODIGVp600NBW441153pAKTHkJ3eSKSB46rfq0oz?=
 =?us-ascii?Q?3q1j/HsCzjDHqc9y9vVYxmef05SEsjRKrTBqeTShmzEx+B2CHXTzh0rluOQg?=
 =?us-ascii?Q?Is5n0cKRpF5lFWWlfeIcXIUPsmuNT/qzxdZxYRv+tiYzopYBbcfTpimhlUWf?=
 =?us-ascii?Q?sOGD38AKAA1+BBhdw/Gbby/gfvG1npM3LF3/EK6a81ESZIy6HaZSFJjkn/CE?=
 =?us-ascii?Q?Zv5ziqZI1g5v1BX3RH0QZJd2JOeRaMzfFfHkdU9xbRctLZoEHulr01p1LyKn?=
 =?us-ascii?Q?VRQ51k0jeiXOJK/vY2NNwOa3uKOkOkn2EFUaTj2FAuaDQKGLvX6z5twOJpEa?=
 =?us-ascii?Q?hGM8l7YRHFwo+ENZq+qxwxtmznJ55ABBlGeudwyKDfUBSaHA+GoIcGQvc3Ks?=
 =?us-ascii?Q?vkUR664w8XBIfheGa3OvK5Y8x7dm/ZqyBA1XdP9A6rdvh+GhZLDyuljnTfA5?=
 =?us-ascii?Q?OBmiZ5W9f00ZfMgbnU36RqgmqVjbFadgL+27E6f6O8gNAoLWPAIw5qUgHt80?=
 =?us-ascii?Q?bQCVzfWvS0hb2ngg47wA/aKnnOJJ0z1ZJ2/N17sqoTuitWhGawgaXnlh14eq?=
 =?us-ascii?Q?VAqMpttLismJ7wi/OCvG6JSiNd/1KXgIiduHIiRCYwlyP1pngMQHtvRlf+ig?=
 =?us-ascii?Q?WGK9grR6Ar7cmc4e/1n5vgmzTtreNqchqCainV+kFk6NR273F3Cz1HTBrrwU?=
 =?us-ascii?Q?lwvG7+VgRPC0Gb2M/8WJXOF7TIplx7cvWn+VLAswK4Nn6Rg7lmbzpUnGzJMw?=
 =?us-ascii?Q?GmfNkqQKKomxyJOZmOrAMzybHX0qdyWQXb0MUDKE4SA4qDPGmV5nAUoqEPvm?=
 =?us-ascii?Q?F92LAEoAyXMNYtFf+gsklEIg37pLluctQSYCJLMbfgy/XzPmqMhrtixHKI5a?=
 =?us-ascii?Q?stl3qU0OrqHf4FC8nwOJJ7xvduMXhSW88Kn/T+iHZWxX4x0jnvb6MkRSImr1?=
 =?us-ascii?Q?GxJ/TJLO/igNMYr6RMilTmFAiFXDQtYeeH+34kMvG7RJvPbx+YUhnwXi4UkY?=
 =?us-ascii?Q?SOCVTgZlLJACxDjjPrH+tAX+ChEZGnyWRKl/sgrspodN7S1Fw0DXR3z8+7gU?=
 =?us-ascii?Q?i85niTvb6Dl1o7L5mxU6etnauNdqMS36jpc9xvxjlrFQX+3RVmNo4okxfFqE?=
 =?us-ascii?Q?aSSlvBv3Q81FEfHYj9Mu1arG?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30a2f93-c761-4e08-de79-08d8d63feef8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:08:55.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ousi8Wi1RAUplLtM+EFXZojg3NUTdXCH5bPRhtFZlSyxBlt04Po7xJyU/fSmn+C6OAneRT6nXwGG3BBSQhvNti5L9G6kk0M4VSzuUUL/V/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are copies of existing tests, with just 31 --> N.  This ensures
the recently added "N" alias transparently works in any normally
numeric fields of a region specification.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 9c6a88c480c1..a6048278d027 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -354,6 +354,16 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
 	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
 
+	{0, "N-N",			&exp1[14 * step], 32, 0},
+	{0, "0-0:1/N",			&exp1[0], 32, 0},
+	{0, "0-0:N/N",			&exp1[0], 32, 0},
+	{0, "0-15:16/N",		&exp1[2 * step], 32, 0},
+	{0, "15-15:N/N",		&exp1[13 * step], 32, 0},
+	{0, "15-N:1/N",			&exp1[13 * step], 32, 0},
+	{0, "16-N:16/N",		&exp1[3 * step], 32, 0},
+	{0, "N-N:N/N",			&exp1[14 * step], 32, 0},
+
+	{0, "0-N:1/3,1-N:1/3,2-N:1/3",		&exp1[8 * step], 32, 0},
 	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
 	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
 
-- 
2.30.0

