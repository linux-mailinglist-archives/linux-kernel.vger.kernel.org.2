Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99108320922
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBUILO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:11:14 -0500
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:18722
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229949AbhBUIKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:10:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSOrgTUcJZl9cTniZ2GlFCWy4M2Bz6dSQSXL2MAWEIAqGJS9r60lZw2y1iky5X+ds7DKGlvSLfik4KzHHwBr+kVlg73gKPkc66tIgtqoxHzHfR4JP3E5ZwwtNP4ML8AMz+EZqcC3Q2KXVX+sEC49ewDyk4jrL6obZD7n5isd1lHl/xCny4wZdU6/52oBMHL0yxT3Noyk5RZxfSinWLaE/mIeZSrjvYSe06vU9+i0WvBQwEftF4FBJ0s168W7PUwW/16bOf/n+KDlfmv42tBgo2fU2ATan1Hm6CGsUdhQ2xbocKlyFYzbQwHKA8oC/dFN9D9HgIXncqWrXF0bO7NLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51qsEvDCovBIXgfogyeCWOpjR7LEMDRLtmA1sPJ/+J0=;
 b=TrhX9uR9KzbbOLTmeLY99aJbI7xS3GoIc22EvleBYvDGVcZZ822PKBvQbPhAfgPofeq/v5swKE2ILJHHHKKFAnLdB82gTVwRxk8A/YvNp0QuIAQ+UwnBQ4Ec8Ui1upN+54OmxiBM3CyU/IL7F7abxPZpmX6ENaOP5FgEGL0Od1Fz/XMPV9lLL0Fq6920QGOMRhhv9XFtK25H1EfAQL8JHdRj3Y302t7MqCRuFvLtrTulOsJI+3xSonO8KdabwWV2Q/teFYJ7Isg21qqD4tGrzKkqhKZ4wKaEvmYgtx75cOsz3rMzo1Va5fIvRTng9fAWY1Wq2Hgzn3VPhfwyzM2oNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51qsEvDCovBIXgfogyeCWOpjR7LEMDRLtmA1sPJ/+J0=;
 b=fhaubGCBBXFz3s41p5ZY4YY4AGIXGtvZG/SxCBCS8O1xBeG4B1TH9T7qfdTyJUzm0Rqje/E+CDEMFz3H8WwKonN9bJFU8COkQguqLaV87suD4XbQEKFYlTiBT2+P5FnHUKKr4jRd0UsTt3JW2OswiRi8P71VGpPZ5RIHvI7t3/c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 21 Feb
 2021 08:08:53 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:08:53 +0000
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
Subject: [PATCH 5/8] lib: bitmap: move ERANGE check from set_region to check_region
Date:   Sun, 21 Feb 2021 03:08:24 -0500
Message-Id: <20210221080827.84862-6-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Sun, 21 Feb 2021 08:08:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1569e9fb-8039-466f-a2c3-08d8d63fedd5
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB47408335490AF104BEB52E9783829@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +v9mXHzp6Gn8Jo6RDM1DuWpG/eOLoDb2lpUtc0MVIk1CQcnw+EmfOiV7Yi4PC/AhrpPv2EUt74E9QttyOBERL2Fd3jWwlfC28ESvSMmDqeIem/B2hqopCrbd/gBmhV8MChKzch9fu/WnvrTADRLbTa3eylF8+/jyorGotZvFfSWIpIZiYFwJIBtPmLOJqpC/QaDD4Tpkrpa80q52WeWMEc/hpYhGWtE7iRUt9Kl/M+Ym6uC0Wk7U4GyU9nRS9UhkpPHdAfYM+oChe+Q1YtZUR/kU8TY8x7lIwqmhMHRlHg1OiXDzw1eo4Zsy76p/5CnldzGVeCyXYWy6OdDDDfgIpcLKOgFfi4hQfhZHAJfB2r/OhFVNnL+Mp7wabEEZAhviUQdXSzeno2byOzydPugPRiYcZpJldPF/Z9fUFq7srxLI1uUE5YVRdFjFRjkHZEw6xxMZ5xt5nZdcdJwTpTOI3GNJdArfNguSqqwgvDyPukdfQaHhHVb8heKPLy9hepKrjtFRI8MfkZSccMw5VALwrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39830400003)(346002)(2906002)(16526019)(316002)(186003)(54906003)(26005)(8676002)(5660300002)(6666004)(1076003)(8936002)(4326008)(36756003)(6512007)(478600001)(107886003)(83380400001)(66946007)(6916009)(2616005)(66556008)(66476007)(7416002)(956004)(6486002)(44832011)(52116002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n2m5bDuEaSaSrtOMRJr2pXEofLbc/9TWemquSoe6vL1DjiiOKlrT71jR2LA6?=
 =?us-ascii?Q?noA7lOOgKDXeB8euJLpqVQOaIPyvk2QO02MNO3rSuV1WwZ+OG+syrT0SoM91?=
 =?us-ascii?Q?WXaSPRfSGllThvP5FTb4EkALqbf1l5SDHL4fWdDaC/VZPyPwfrDgEXjkoqZZ?=
 =?us-ascii?Q?73+48yuZcyDjvjZ+Dtkl44Tgh3ED/w/F5tUg6RhcKjPyT+URZSspv1k4gUhr?=
 =?us-ascii?Q?23iDxeyzKOAhx2HMQttywZIS7kJjICyQeuuemgGLRJqluqW4+iMBEjTOZofa?=
 =?us-ascii?Q?JtxLyKyi34hxKltYzdR9mXNWig13S87HXKUvPE5DaTwhSyHa7hVxYjcOZ5dU?=
 =?us-ascii?Q?R0hyXrtfuJMJjAfRnyhGzVyjA42Gls42LCnFPseWRzxiLSD7R9me2mlXFM0u?=
 =?us-ascii?Q?sXU1r4miUPzV3K/QLi17akZ7FCZgn4bYLssNgidfPdiK3cLI+1G/6mv0di1R?=
 =?us-ascii?Q?hSGtiiiQ+uz1RGTL3roqHvAXIpc4JamQQTKHsQjZkaU24isCektTxlL6zSqw?=
 =?us-ascii?Q?IsHGJIQm7jgGp0okIH5Bl5+URQ3ZYkB1QMBhMIs2xw7XjeuukLzOeBWQ2wbW?=
 =?us-ascii?Q?ITvUy0s+kC7D1GO+1FKB6R6nwql1QsqQPZYcX2hnH/XafUgJbcDKnH5iIesY?=
 =?us-ascii?Q?6S6PF3t8xD83Ct8L3yn0YCS7FpovzWuhAiErnXjQw3DGyCy3V2vxfgMj8isM?=
 =?us-ascii?Q?Ein3fN3X8NzUZrJBzqY0vLa9KtmN4cghdLdiJr2cV+hoGB+tJuCoIWu2+XQK?=
 =?us-ascii?Q?QjmMIuH0UI9gpj46GIpe67lVEYREGvXEY8EhFer3+fgFgAUTnopLX/DAZRjN?=
 =?us-ascii?Q?pkFHxIFTqwFeuq97KOP0tJqVU5OjxVlz/6Z5gGy5V6bqYkWjea5LiyEZKztw?=
 =?us-ascii?Q?6ivAVDokwCiqQbrj9l547XzLd7kI2u2nxTpPXq6EI6tL816gr53XcxTAxoLn?=
 =?us-ascii?Q?tozrxNhoH5zOQZ80R1SUUd3djlc8JlGwTc7RUmYyICWrzlb81RUXDm2AMZQO?=
 =?us-ascii?Q?8X9gE554Rf6SDAxOhwNaH5fCUTmjnOCj3ycDxgfiwts7zaHaVdmkKHcVWDCB?=
 =?us-ascii?Q?4M6JQ99Y/YlBxgBCNl8Ysw7U1b4u100I6bMWqk9nlOB0hX2SDP22VyE2UdVf?=
 =?us-ascii?Q?H1uIedGXKJZaWA20JLcUrPYZ8WkizhphhA2Ohk5fe/Q2lnITZiFlC4RJmVz0?=
 =?us-ascii?Q?c9p44gKLTij+hTwxB8u5t6XLWr4tpMgHq6RevkuHHkcdkCHsbSv1DaU5Bigq?=
 =?us-ascii?Q?FDgWgu2MLyfN+4H7/RQOWb0j4aO+gLM7SZW50zD1fLYVp/N/0gdo1n5wOwhb?=
 =?us-ascii?Q?9FdyeYdnHhoDEjeeVQkcBsDj?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1569e9fb-8039-466f-a2c3-08d8d63fedd5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:08:53.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6m/cx/81I/Z3ujSubySDRRudfxZusJ7GpYVDzRcERUUA6e67wF3bsNrdUI23xIdBrXWvhDG6BG7ye48CJkor9ils40dfNnmgRvKYLdCnHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to do all the checks in check_region() and not 1/2
in check_region and 1/2 in set_region.

Since set_region is called immediately after check_region, the net
effect on runtime is zero, but it gets rid of an if (...) return...

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/bitmap.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 162e2850c622..833f152a2c43 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -500,17 +500,12 @@ struct region {
 	unsigned int nbits;
 };
 
-static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
+static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
 
-	if (r->end >= r->nbits)
-		return -ERANGE;
-
 	for (start = r->start; start <= r->end; start += r->group_len)
 		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
-
-	return 0;
 }
 
 static int bitmap_check_region(const struct region *r)
@@ -518,6 +513,9 @@ static int bitmap_check_region(const struct region *r)
 	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
 		return -EINVAL;
 
+	if (r->end >= r->nbits)
+		return -ERANGE;
+
 	return 0;
 }
 
@@ -656,9 +654,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (ret)
 			return ret;
 
-		ret = bitmap_set_region(&r, maskp);
-		if (ret)
-			return ret;
+		bitmap_set_region(&r, maskp);
 	}
 
 	return 0;
-- 
2.30.0

