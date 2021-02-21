Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE0320924
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBUIMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:12:10 -0500
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:18722
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229983AbhBUILS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:11:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwT7+zfpAlVIZWsa2N3OfX/PQj0QY7twxVEf56KiYR/28BkPywJJPur9QBUPC0n9quQC2560ous0aiYJJAZhPeFPrEq2gufU6lvgNengFy2eNLPexi+fTAGdeDvopQJxWjNwXuQyct7/3fXumcMHYO8mLrw2q1xQizOhJUTzWbDZx5XD09Nq6iX91Fm7Ex79XDbo0UD1M669fLEKOJPbJEXqP20QFoiBbOtWndyUoXloWUjf8XbV6icaGgHHaTMkAcaR1ZneLTDe6l47Ndb/1tB9IhDvtqjzJo8imUKMtAbRWgVO/FrQ7O9u1xHrFY5jiZ40JY5ae9aW7UUvoB5UEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slvpb6JOD9JBcOZvnABIEqHnHa7hhdAl16iRkPuB034=;
 b=N962wFodoHY7rkbU227m0jBQjHQz3D04nmNpzqBvnb3bltktZYcBmI4HLd/z7hy+gUI4MdYTBO2E50N+BhySAaWfdVHvkbPxDYtEVhzxrM1tUHZ2BFpnYGJxRnY3fg4zitg9HwcCBpQo9ysypBAKeuHQ81fomASXohoYaWssvdpJTxM8ExEGm1ZKbHU4+njxwjgPGlIexRXfoHt3ke+ssZm9jU1dq96zx1uMaGRTAqEOz/HHuWSs6DsYxxkJ6p4RoT/HuJeVFnR/fd+vYyLeUBVU1+chEC7Rb/pxof20xkdFAIp6PYKXBzoDXxUDeH16NDWqiEf0RBRgmRaXPEpqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slvpb6JOD9JBcOZvnABIEqHnHa7hhdAl16iRkPuB034=;
 b=N+53PDoHFpg8MbiJ24mjeWy4/B9TqVUCygqT41lb/tvSU0FeW1jJM+tL9lfW+KMfKbiHB2J7fmfrhekpzhrpMZXPCov9+k/SKhnZXqNFls0BKHSt393YBXlTfALvNifPfwJ7Sg2gjQJCLK83kXpOvFAtx/kGIXAfERZYLd6kLR0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 21 Feb
 2021 08:08:56 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:08:56 +0000
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
Subject: [PATCH 8/8] rcu: deprecate "all" option to rcu_nocbs=
Date:   Sun, 21 Feb 2021 03:08:27 -0500
Message-Id: <20210221080827.84862-9-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Sun, 21 Feb 2021 08:08:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 769f665e-879d-4c65-84bf-08d8d63fefbe
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB4740E86BC215D30273D1D8E983829@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTBgat4XAsCTJvrTpJ3rXFenY9Pty4X6SfCyIw3GJ43sb/QKYLeK0NU19jAqMCP4PGv8zLs3pYWMxF+3TC5LDYRCFnzyNJ0UFUleAbrB4LvLCO3Vo27vzm9SFFjkGw/JFLzOn8RNMpBFXcPUi7VfHDlVDdBl7xiii5dSvPbNrRgUv5gofecksuOF3VgyTmT2O8NLl4KS5L8PzYhS5Tw2A8U1FpcE7xTAAVIy/eGw+s16wpy689Glb/ptszixijYR3XIYSGPAl4jOjcVudtJL9R8qQLccZ3ntAMKgs4800WJjJYHG9PVbM+V/k924P6RCgLD4lG046nWdk8Oh4kFsibY/YxCWqnKaqmW/9eRzZnVZLle4ywvLVo8L4hJqvVjOMAl/++5lwor4R4LOQY5Qx7DB+wKy2kNO4r7IrlQxJRXbwipHtp5Zj+d+wKJYuSKYBcm1VFEM/9k7dhPdB6Z7uTqBrWK7n9B0AJvIqARshO6mWUNX1vAsIl6ifU0adA6TrnSXr8cYoGmh7CVFjbWX3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39830400003)(346002)(2906002)(16526019)(316002)(186003)(54906003)(26005)(8676002)(5660300002)(6666004)(1076003)(8936002)(4326008)(36756003)(6512007)(478600001)(107886003)(83380400001)(66946007)(6916009)(2616005)(66556008)(66476007)(7416002)(956004)(6486002)(44832011)(52116002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fG+e+ldGqbGi3HQ8C0Cxwex80QuTF9r3lmQbFjqSzbUZxVT377wLjv5xVaa6?=
 =?us-ascii?Q?cp4m6E09/mdNehvDiBQRSeqVZ8dzNYALEuES/RABunSEYrSCK+TJSaN4qHTH?=
 =?us-ascii?Q?W2ha/oRP9bEriyF690rNGHDewnvinZeXhcJ4Lx6fxkdd/+FFpTlZ6kMyHbPD?=
 =?us-ascii?Q?tFkSipBk+bEVb1tNZvtapZm4W8t8qN1P0ADZj/pi2yhjyCcNTr0OH+DZ+LoM?=
 =?us-ascii?Q?BWLp2CVj4DRmmYbKHQCnXfKWX3BcVYqlJqQDzUQHYPfEcK6X7SAVUmkikYu1?=
 =?us-ascii?Q?JiHpvPCP9wS6SEHPZBoNdESO3h6qvc+AoQkxqNyKqVY4T7EhKnoC5CbsAR9i?=
 =?us-ascii?Q?C6n0qYGWGHY7RpkwKlEuLFxetpT+ES5p7S1R/DQKsnSaGBhp6liS8FHzQ7SS?=
 =?us-ascii?Q?PaJVFY2A9xAWMT8/fsVTy9+xKwaCgHkCoun8vju9kB41m2fgvt477K1ga6ya?=
 =?us-ascii?Q?MSDoBH7QuYLk6c/9c8oicZQksHMV6Qn/0YCHhUPPmzu1PGEl4+3ki1rFe3rs?=
 =?us-ascii?Q?oyvrgHPHUGA4s0MMaG9Bf2EBKH32P/X9u03XhI1Mt8/Tw9TmOzneLrZsZYz1?=
 =?us-ascii?Q?vI2qXxBlumzVkJGBuRBI6moTtpyk4FWkXom/D1OXay/uNzybkER3mZ598/2F?=
 =?us-ascii?Q?dVpRWdTdde9fb7svOBs8DMOdbMtdcZCxtEwQZLjn7OJpw2n3VUzs4hC1yBJK?=
 =?us-ascii?Q?hOQEsEPb/q7FUPKvLan/ZaIPOwJ3Urvj934Fz4uAqlU3BWVmxvqWQPBzkbcj?=
 =?us-ascii?Q?BE52jKXuOzkNb56+pY3QkD+9bde8M2TD9miIyXc76RVQpDvWOl051SBQQxbR?=
 =?us-ascii?Q?0RgSlO95Nph0E9H8pqTy7AVXA51wuEwQPdwePtjV8k88BY/4pvfNhDiQCx92?=
 =?us-ascii?Q?ATvZeEOfvwU4SNDfTVTlA8GweJxjfdsZ210i9LnyAhO0H2lDOTgVXF0ZYTeF?=
 =?us-ascii?Q?ja8o+UaVZwsLCtJkhAZHYq2fG6eu4weXV+9mvcuYuG7luVa7NmBb46CoRLVC?=
 =?us-ascii?Q?ZCLgV10aiMns10sdpTg8JVtE+MPGYucy9FCGl3P+g8RwOFMfXYoIFNAPutKI?=
 =?us-ascii?Q?02QZkJPw2rB0d27yGkjDLqwuwD/ikVeHUPID/WDR7nLJejFiViA7mfEsyL0N?=
 =?us-ascii?Q?bj/qTXWYJZEojXXI2GPbmuWIE1oLxaCDB/jw+fIsZ58ltkwctERTNwA/+QtP?=
 =?us-ascii?Q?INUcn8qDp3mwBYn+p+swJc6LzGfTEB2n914WxOb31Eu027mREeik2K7tVLO9?=
 =?us-ascii?Q?e8nG8LTGtyWpG5zV8bCgT9pLDPzGWE+pliS0fBEPcAbv/s0oz6BQz3QtMGRQ?=
 =?us-ascii?Q?qoRhH9i0v3/EQ/773dXdujni?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769f665e-879d-4c65-84bf-08d8d63fefbe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:08:56.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIDI4UENvUkidXNZzoNHq6bn6IoZmb1nsRKO/kgP25jk2xlWvzIeE9DFziQnc5yWjCQg7xJRxmRFeG9ItG4n5AkcMpwLml7yd7Uw3EzCdFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the core bitmap support now accepting "N" as a placeholder for
the end of the bitmap, "all" can be represented as "0-N" and has the
advantage of not being specific to RCU (or any other subsystem).

So deprecate the use of "all" by removing documentation references
to it.  The support itself needs to remain for now, since we don't
know how many people out there are using it currently, but since it
is in an __init area anyway, it isn't worth losing sleep over.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +---
 kernel/rcu/tree_plugin.h                        | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a10b545c2070..a116c0ff0a91 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4037,9 +4037,7 @@
 				see CONFIG_RAS_CEC help text.
 
 	rcu_nocbs=	[KNL]
-			The argument is a cpu list, as described above,
-			except that the string "all" can be used to
-			specify every CPU on the system.
+			The argument is a cpu list, as described above.
 
 			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
 			the specified list of CPUs to be no-callback CPUs.
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7e291ce0a1d6..56788dfde922 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1463,14 +1463,12 @@ static void rcu_cleanup_after_idle(void)
 
 /*
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
- * The string after the "rcu_nocbs=" is either "all" for all CPUs, or a
- * comma-separated list of CPUs and/or CPU ranges.  If an invalid list is
- * given, a warning is emitted and all CPUs are offloaded.
+ * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))
+	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
 		cpumask_setall(rcu_nocb_mask);
 	else
 		if (cpulist_parse(str, rcu_nocb_mask)) {
-- 
2.30.0

