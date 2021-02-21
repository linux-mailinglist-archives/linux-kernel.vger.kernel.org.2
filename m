Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8232091E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBUIJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:09:42 -0500
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:9569
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229686AbhBUIJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:09:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQwGvgp3axrBOfVLCaEqvPQ3qKjjpkPqBoejsDN1OiXVgC5Dae/Mytcg0vCTXH4YUQ7QWAitTNtZmA5NG8wptrG/lMIDJiNQDg6Kcda0j+jmLh7ijMd8OQgAZj1UbAe+ILFICKxoH6/bpEI+Y7Dxjq9JxeVGkO+47yUOXGLvUvbZlIl+l5J48IjjQcKbkB6XV21cMBiA2oO5L+0K7ROab8b6k33x9Hs/V5fc+jus8f5hUlQrqy8WrhodDPxX5wUBjsmicgHxkKkKW1bX+n+RZ6fN7QlCbAr+etM6eFbapFlka4ohVwCq2YCyb4CVbdC/pjNa6WdCVEWdARJdNgrOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf1VJEFtHfUwSTemGZr7rbn8HeI379YVOzmTnJI16wU=;
 b=UpgS6/VOGpzV4pfYkKHGjlhyD2UMmh1K+KHJO7Sw3317pVAXl4dsFd+B8pjISOL4+PyrGaDlINkrtr0hrCjM4V5JlvJ1xG9ktiIFw7J03alEg4eZA8nQc5EzB7yV9n1MqYeBC8zXl8b12FUQr4153q3+3t5oWzBhDsiZyaREE+GX7wSjsmlbn6Z93s0ZV+I4dgReaArItBXsgKJIvr8ktuL/RWischTNTxDNciiCGjSiqRt7LKqwADNHDEbRomh2zij1wchxCfdyGWJQKFPpOTahNbFZMKXTeOI3bv6V0pWfR//9X/mxkr0blymZJPk+2RMxspHyNDiJPf5GnmeSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf1VJEFtHfUwSTemGZr7rbn8HeI379YVOzmTnJI16wU=;
 b=kDsSB6HkN4aer+czwBQemWT/iKSt1FhOoIYlyuTbs46At5NNoyMOAKewzLDJVoLKTyDRyCVW8sQ6nHS2p3acDXF3i2U/qOdvi1m0wAMwxwJ6DLgIbnyQxgBye1w/M+ePkt8gz84iBikBf64S7Nt6So+O9rG0FFOMsqRuAG86WBU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 21 Feb
 2021 08:08:49 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:08:49 +0000
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
Subject: [PATCH 1/8] lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
Date:   Sun, 21 Feb 2021 03:08:20 -0500
Message-Id: <20210221080827.84862-2-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Sun, 21 Feb 2021 08:08:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ecdf27b-cd93-47ee-fefb-08d8d63feafe
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB4740A8D36FD2029D88F79F4383829@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usTwlfW7CXt9sfgo/opsyIQF7Cjli0uLrU1Sqk5sR84xmHl/4n4B3XD4kWDpLF8YAsluk5YQOxepuMa2WieHZcQYEAaD0KOu/y7izCDUi5/3wis7jVAfEOqJLWlPlPTNPhvW6Tclw3GEoz+QOm4JvhpCLlX2ZapP3Gi0ytEtsJDi5OXd7XvEXnOXCvCwd/9cnqnbeZmnyOOukYMNi8ZuHQlAri2sXGcYvY5LGR9SSw/DdJmgsySULaDCatLc6/3e94WecPSD/SdJU4khk+xEO3/vT6Qdm+MSEIzaUpW50n55CptfU/0gkkF7231kB+4hWihTgkmeVMMqkHHGf0c9fpnNnAZ4YZJIUDNvbpdiSrJyeK9jR2FRuDa8AgXISnJMWy9UOJQYb/UHg7w5f/VMUbLEhiotTfxzsvNiVZpzV/F16uwDC8vFSFTeBEXLg6/eS1Oqc4Zl9Ivcb4gEYHBpC8/+R25Pea8fdP93ZtuEJq7mDVnJ4O5Mvpu+A7fGPFDFOI7qMM11iwLeku4m2I+4tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39830400003)(346002)(2906002)(16526019)(316002)(186003)(54906003)(26005)(8676002)(5660300002)(6666004)(1076003)(8936002)(4326008)(36756003)(6512007)(478600001)(107886003)(83380400001)(66946007)(6916009)(2616005)(66556008)(66476007)(7416002)(956004)(6486002)(44832011)(52116002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QYsZyIRGikqil7dFlZ6bbKG9Gb/DhHs028XFq1lv4aqZPXXdfn404WbhuOWP?=
 =?us-ascii?Q?ZcUc+QYEvIvZskWbGwUm5h4gcr7jzEhP6B3Q+jiLkZKpbR/7IBH20oCt/5Dy?=
 =?us-ascii?Q?d8E/6dIE6HwnF19zlPYPgd0cU474xYq6Fm3QhG7WEaOegulNWH7zxtIkjMIi?=
 =?us-ascii?Q?5q7x8NKWfKC7kFBiVwix5UDWJvzmmFlYE35IcOZyHoR8axTnQht0afxau7kY?=
 =?us-ascii?Q?A1FazAVOyztl6W3GDhqw/XgWX3kidU6B0GnNCLGh6Gc+DMO6UTWnSR86Qm2W?=
 =?us-ascii?Q?5WVV/2UPXkTZfjYnO9BHbmJEoXDatB5iCMT/70hNP/TB4YjXiLd970A0sbyf?=
 =?us-ascii?Q?QdVX9uh+eCYaIREQ79Gc5HBYuG9puSX0Z0ZtBO76VLY8UbV1YbG63RXxKkKT?=
 =?us-ascii?Q?wOYdyx1SpzjJjlCNr96ggfc8n181UQ4GJQ02+z4v5/12w+BesmGTGkc8hp0H?=
 =?us-ascii?Q?x0CJBc3jT1StBVbYOqiA5BLKkLX0XHzUDxHTu0ihKR5v9H/jEQKkj4RKYPEn?=
 =?us-ascii?Q?h08Mq3kA2IjUMFGxAmG6sDY0KNDsmsXDcDvCtvYe0M6LadxdZvnTS+72q4yY?=
 =?us-ascii?Q?H7IB6Cj5UY5vwsY8V8/5qBkrXs/DkpAd94X1b3Wjv8dhQIJPo7XBJDY1PY0c?=
 =?us-ascii?Q?Ncv30aWES50dIa0CyXU0dQ740LXDaEcPj/xgQE8GIEz0XE4O04ok63YKMH9s?=
 =?us-ascii?Q?C/JroS7+JSILg1MVlH9ZEIMr0oyqi7Hm/hOAZA1Fp0IqQ5tQ0+GQlQzYkmrA?=
 =?us-ascii?Q?tNmXWW0ldEn/VirSTUpg+0rAlZkTbai/w9aDHsZ8XTK/35MIA31D5OT8WKJ3?=
 =?us-ascii?Q?daZ8R+ElA6LU62qcbZSonEIxGAnfHxQOOClW38Kq0r0ik5f/N/x+ounBDv0Q?=
 =?us-ascii?Q?pSRcQr9yt6U0lpS7oc/PlyaLKIczE6kV69C1otNkZ4P8x+vop5sa35kUjtFv?=
 =?us-ascii?Q?Mr8OvX5RZ+422WNK3F/Gg1pjrUBSR2ZYbAXsYYal3rS2g71MBHNKJne7/N8a?=
 =?us-ascii?Q?pQX2c/n/xOXCWiNsGbti59nja/LjMeuLYbQOrF7at8JIRNooC96gDc6bM+xj?=
 =?us-ascii?Q?2HBATy4wj5cco2VpQv/cjUqy/PNZDow8lA+Uv6kGy6gnF4aUkKbdrsX1mg10?=
 =?us-ascii?Q?oiHknSfelnOgZ1oqMerotEvrd0EooM/UKgLNiiLbNVw6kY0U/7S7p3zgbggl?=
 =?us-ascii?Q?64IVjbrEUd1BVGawvi3FeRqijCuIfaBot3RuPwHR4p6Lk56v8A/AE/xQtSV4?=
 =?us-ascii?Q?ja8TrYGcc/YyUvyOM2toG19wrfcit5tbE8CIDNGNjg0DQJ40oT2SO7zfQrnT?=
 =?us-ascii?Q?XgqSg5TO7kQgh04LWFk+1sAC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecdf27b-cd93-47ee-fefb-08d8d63feafe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:08:49.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3rExdAXipUbUIlmfYGtFvkQsOw04lvCBPJc8bcpEsuW98rF+CBBMvBD3G5maoDcq4eB5NCiJwqoIzOx2TwZXQ8yxJMsahrA2r1jQtgCROw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This block of tests was meant to find/flag incorrect use of the ":"
and "/" separators (syntax errors) and invalid (zero) group len.

However they were specified with an 8 bit width and 32 bit operations,
so they really contained two errors (EINVAL and ERANGE).

Promote them to 32 bit so it is clear what they are meant to target.
Then we can add tests specific for ERANGE (no syntax errors, just
doing 32bit op on 8 bit width, plus a typical 9-on-8 fencepost error).

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4425a1dd4ef1..589f2a34ceba 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -338,12 +338,12 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
-	{-EINVAL, "0-31:", NULL, 8, 0},
-	{-EINVAL, "0-31:0", NULL, 8, 0},
-	{-EINVAL, "0-31:0/", NULL, 8, 0},
-	{-EINVAL, "0-31:0/0", NULL, 8, 0},
-	{-EINVAL, "0-31:1/0", NULL, 8, 0},
-	{-EINVAL, "0-31:10/1", NULL, 8, 0},
+	{-EINVAL, "0-31:", NULL, 32, 0},
+	{-EINVAL, "0-31:0", NULL, 32, 0},
+	{-EINVAL, "0-31:0/", NULL, 32, 0},
+	{-EINVAL, "0-31:0/0", NULL, 32, 0},
+	{-EINVAL, "0-31:1/0", NULL, 32, 0},
+	{-EINVAL, "0-31:10/1", NULL, 32, 0},
 	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
 
 	{-EINVAL, "a-31", NULL, 8, 0},
-- 
2.30.0

