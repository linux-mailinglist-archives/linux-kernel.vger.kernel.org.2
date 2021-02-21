Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBC6320925
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBUIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:12:30 -0500
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:29930
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229998AbhBUILc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:11:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzbeFWwK7h4x/fOFalIxQcTB19Dwz2+ALdeaxOm3N0Ern1+wIcItQzlzbxDrEIs1eK7UDjKvIboLwepUxuOFH9Td+UWM4aQaY9gXME220wqM+rpaDKPdJsn/jyjHIB8bJ3oCIVOexojwJDQ0zYSU3ME9F/7LOhG7ewfA8QxYuC5gAjSBH2uRGGOh+A6q4zjBn84pl8uh6xH6mqlU3k0uH0FEMj92FbYDKeMkihK7NfUpsqKwbG9h5dORvvvWz1HQjCCnv6Yk7ydaa0FBQ1SjGwo7HVqyuO1p9zL1UhyHK3cRqh9pdPVpWKwpf9mK3f2eu22I7oSu9vn1WK6FG4JzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJBEXCmQFzdROsRkLqM2W9vSGgoYYAmNslbQcTL6TTQ=;
 b=YZ6tNGVM0lvA9OHIH0ySVUQ7c35PhIA9Wq94DcDbnRbge90dC9meRG4enV+S+2/NUUtBIWPKaJnBALNQtQAFDDpoQac31AkrqOeEEleNlz8VYUkjkHcY24zGsSCevEU9pGzz3h+w+DGpbvUOEzpiC4xB0Uq4peu6BoRnAlWamUXtr5GLLfTRGbkIqV3Aapk4OqQf6t5rgmYaz2cBxsbt5r5exN5fA6OMOkL3YCrnqr/tzXj+MfA+wI+8L2gVue1pAZs/LokFFxBgBjzqWQeKdqu5diVFmX5MR0ux7SY4GoisEBHVmEObyCE7rvy146PyREhZydYl+++p76xaoF2k9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJBEXCmQFzdROsRkLqM2W9vSGgoYYAmNslbQcTL6TTQ=;
 b=LfFqSF+QbQfQYv9+i0VM0aOBTYpfEkyswoQtisPwfq4rFaMDN+T/dEtFRQnmmY3lgEPxeMwzJvVHAkeVILq+Vt5+/iDjtspa46zLzxjU7krGP3l9Sj9OwNo2LQkG7hZxTmOjEFOxebHlOcHp5ClRiHH+SrkMZ8PbDpzBdfRg88U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 21 Feb
 2021 08:08:54 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:08:54 +0000
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
Subject: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap
Date:   Sun, 21 Feb 2021 03:08:25 -0500
Message-Id: <20210221080827.84862-7-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Sun, 21 Feb 2021 08:08:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 553ec44e-edd9-4433-f607-08d8d63fee65
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB4740F830FE87783D7E177C0C83829@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMaVkHHH0xXp9DE9yJGinXGZDq96JUQtLMvdUbbp7oHkhuSzDaJ9HeBlMfBON/ZMohEx0l2QjbhsO9gJmkRyzeTM4T9XTua2o3jes961BzXw7rcOOGio7d2bc3fY4C5434OHS44UPmI2z/QLbv1TEoXU1rixwemBgSu0mRHd0p2Ub/2Og+fMTrSrfUzI0feTrYDESUNV/KS8nGupqHY6EkFOKQVCiFHxmI0KR7+2OyV9IyQlBuv2ZuAqD7ZKZv6kjhraEJ/hxRw/buFyYEz6ljHg/bKs9G9iQh0V4MJiVTAjiC+avte4w3uZhB+AO8jJxyqKJtqGjX1zF+2uIwy3KqZfMLIi8THo65FPdZBEDJSfD9OnDVXP8CGjiJ/J50IZKQQBMPIb7yJ9yX2tXuBfky6U4HGIhNRb7sVh0pljy2g3/pWtSGu3nQEzOtm5Q0Ow7P8tsDeBk4OfeWork7GqgN8YafD4yOQ8xORN5BhKqSuwi/NCpl89YQf0l+X3vVvjw44g9f/qD26j3JyPhFnRxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39830400003)(346002)(2906002)(16526019)(316002)(186003)(54906003)(26005)(8676002)(5660300002)(6666004)(1076003)(8936002)(4326008)(36756003)(6512007)(478600001)(107886003)(83380400001)(66946007)(6916009)(2616005)(66556008)(66476007)(7416002)(956004)(6486002)(44832011)(52116002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UJubQQ8qmhWnFosb3siQ/WoYEtPwJZ2E3aFxSiepIuVEF8pqLmvkS4Xo643P?=
 =?us-ascii?Q?PrtchbejfMsd6KMUNIYFidaxoqm9iUWfDayEIq6UnRro+61vTELa+B7obOSN?=
 =?us-ascii?Q?yljA5/0WAj9Bd5ut1WpsQgVbp0Uqd2x7C9y0NeL8+MrAVbFULrLTgrDbr3n9?=
 =?us-ascii?Q?xJQcZAAw/2hxO6HEMEpIB5DKQzwlxIycoHmsI1rWOlvE15n6rtTxFw9+zsWJ?=
 =?us-ascii?Q?ey6PrzQL18WJKfzfsp+3KURiAj503X58Kj8EvOouaCLVEldWOre2NzDRvaVI?=
 =?us-ascii?Q?rsdg6Qa6zZs1lurzhlAqNnV793KEKQWPBaz8vxF18kRB7c8YlSqQ8/Y5R/z1?=
 =?us-ascii?Q?xwBHxaNwpfdsi8zIpyRhOCQi9XC7wNOlyQsO0S5c52BXZkLaTSCcyu1RbzOf?=
 =?us-ascii?Q?HDkykOTUF86kFKC8jcsb5tNcODicdwgpbuWJJF8n36NKDqGkxPOI3yZAPh1u?=
 =?us-ascii?Q?2pv4Opmed9yH6aSKb261WeTIjA3Y7nBjjfvN5v427pMFk9c+8X1det8jl+MU?=
 =?us-ascii?Q?oNCfUHc99B66gs/1JxrQ2+En6aPJGF39vs71Kf9oeWTjs2KkzSpta7mEkXM5?=
 =?us-ascii?Q?FQNtCZcSky8zF9WhPi2DYD64GQqugSPrAJbOvfm22RP2ru8I2ntBVMDFSose?=
 =?us-ascii?Q?W16SMECVEjTB3EBLPX1L5WmUe80EoeTxaPjiB6cJRB7a3jtWtnM/aS+SAfop?=
 =?us-ascii?Q?2MvOr0AOj3sYeFqd14xdqhKOKJui3nKxlLhWfUbhc6cTm6qwc6UZ8lE6sw2A?=
 =?us-ascii?Q?Lf55eW2omKqrGJFgJmAxLb+ClZdVUbg0b8SE7Lhv0oVwBVQl+VQ4sTvUga+N?=
 =?us-ascii?Q?VCjNSqIE1SD+9L8Xs+2P39/1E3bM8cowvgKFr48jFDyHXV36iOvjiRpF3x1Y?=
 =?us-ascii?Q?L8f5TP1j3CemX2EsUZmKbm8EvIEa/R8WBRgTIlLyZMUZDqPADJHJs+KLVLyc?=
 =?us-ascii?Q?y2zZF5nuJGyxDMM6NyxA8cH27e2qwXFU9+PoBIGVclkSF6WZHToR2nCPF+5R?=
 =?us-ascii?Q?3pWLYrOcFdQjts9fh5tXc0Y/Y43lACB+uT/vZUb2yYdYItSB5pXpSsfFMVoR?=
 =?us-ascii?Q?XqxP7rQ53EzIGv5U0lgBY4WF8vugRKEgBW6c72MTR4JddHAOQYS+6Uggl68N?=
 =?us-ascii?Q?NKNfTIDTkbK0ygwrp2036OspeXQdMNBGIYFDBPTmuXbgNOTFArnQn/s76Vz/?=
 =?us-ascii?Q?K0lZsM5diWP4M1Am5EoHrKXjCfVA4CExo8SQigOm5DB12Im9P+7bp2cJpmgR?=
 =?us-ascii?Q?/dTErD6TebfHehmdoDoewq/kTtAloyzq+oHZ1RpTsR1YozLixsLuh8JRXoqh?=
 =?us-ascii?Q?iwe8r0jlDwA4Hp++FKSxcfT+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553ec44e-edd9-4433-f607-08d8d63fee65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:08:54.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfgX87ZB2IZuUU9Uteh7/DUIYeX8Rv6kxTBfdtcCHEvLFfT1nC8ETm/H043h6hXeXcWWdW8jOmyef5x8F4r5FsJ2fjePj6wM1m0K3g2n/MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this is done for all bitmaps, the original use case in mind was
for CPU masks and cpulist_parse() as described below.

It seems that a common configuration is to use the 1st couple cores for
housekeeping tasks.  This tends to leave the remaining ones to form a
pool of similarly configured cores to take on the real workload of
interest to the user.

So on machine A - with 32 cores, it could be 0-3 for "system" and then
4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
setting up the worker pool of CPUs.

But then newer machine B is added, and it has 48 cores, and so while
the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.

Multiple deployment becomes easier when we can just simply replace 31
and 47 with "N" and let the system substitute in the actual number at
boot; a number that it knows better than we do.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com> # move it from CPU code
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../admin-guide/kernel-parameters.rst         |  7 ++++++
 lib/bitmap.c                                  | 22 ++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 682ab28b5c94..7733a773f5f8 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -68,6 +68,13 @@ For example one can add to the command line following parameter:
 
 where the final item represents CPUs 100,101,125,126,150,151,...
 
+The value "N" can be used to represent the numerically last CPU on the system,
+i.e "foo_cpus=16-N" would be equivalent to "16-31" on a 32 core system.
+
+Keep in mind that "N" is dynamic, so if system changes cause the bitmap width
+to change, such as less cores in the CPU list, then N and any ranges using N
+will also change.  Use the same on a small 4 core system, and "16-N" becomes
+"16-3" and now the same boot input will be flagged as invalid (start > end).
 
 
 This document may not be entirely up to date and comprehensive. The command
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 833f152a2c43..9f4626a4c95f 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -519,11 +519,17 @@ static int bitmap_check_region(const struct region *r)
 	return 0;
 }
 
-static const char *bitmap_getnum(const char *str, unsigned int *num)
+static const char *bitmap_getnum(const char *str, unsigned int *num,
+				 unsigned int lastbit)
 {
 	unsigned long long n;
 	unsigned int len;
 
+	if (str[0] == 'N') {
+		*num = lastbit;
+		return str + 1;
+	}
+
 	len = _parse_integer(str, 10, &n);
 	if (!len)
 		return ERR_PTR(-EINVAL);
@@ -571,7 +577,9 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
 
 static const char *bitmap_parse_region(const char *str, struct region *r)
 {
-	str = bitmap_getnum(str, &r->start);
+	unsigned int lastbit = r->nbits - 1;
+
+	str = bitmap_getnum(str, &r->start, lastbit);
 	if (IS_ERR(str))
 		return str;
 
@@ -581,7 +589,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != '-')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->end);
+	str = bitmap_getnum(str + 1, &r->end, lastbit);
 	if (IS_ERR(str))
 		return str;
 
@@ -591,14 +599,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != ':')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->off);
+	str = bitmap_getnum(str + 1, &r->off, lastbit);
 	if (IS_ERR(str))
 		return str;
 
 	if (*str != '/')
 		return ERR_PTR(-EINVAL);
 
-	return bitmap_getnum(str + 1, &r->group_len);
+	return bitmap_getnum(str + 1, &r->group_len, lastbit);
 
 no_end:
 	r->end = r->start;
@@ -625,6 +633,10 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
  * From each group will be used only defined amount of bits.
  * Syntax: range:used_size/group_size
  * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
+ * The value 'N' can be used as a dynamically substituted token for the
+ * maximum allowed value; i.e (nmaskbits - 1).  Keep in mind that it is
+ * dynamic, so if system changes cause the bitmap width to change, such
+ * as more cores in a CPU list, then any ranges using N will also change.
  *
  * Returns: 0 on success, -errno on invalid input strings. Error values:
  *
-- 
2.30.0

