Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA662320920
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBUIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:10:20 -0500
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:18722
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229826AbhBUIKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:10:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWqG+VepepoKAKS5ol3unNRIAIRYELP+bufFtSh8tbQPSz1mlojqP2Nui6TDni37pttCRrCxqaPV2MpQstmHwGu9AE17cyy+ti+ANXpZkIG19gjITyjjhevBIyvGKG6f8AUsqTAfbWXPopN+scV022mPoP3XmRyzjvlqtQV4MnCtIwIBynnRSv9DohPuX0zXOpW2uaKfkZTrzg8PBNhGchVdIefWgvx7/+mvxsvnGEl3SQKJfjxtnOt2BHAzvFSKBMRpI6ZlgK2J4DbN2cilAr7GcoEHt9pJ3o5U84QR1j7hbfBpZYCRPqSFJfZNFtKDbERiz8/aeQ48CdjhvHKKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZhhibfNrB07pnrDjd/pvBU7wdrbhh83CCrUqPYspxA=;
 b=Qc0D90rB5uUiE8fjZE6bu4u2wcdCRebcO1ld4q8y4nNljutyPpQ6d6wCCXyzuJSPtePDeH5mEg7gMPQyfjvK48omSgRsqpemirxnDoclPzt/0bLv6DmlXatxnV1bC4PUjXPssEt/UAE6wnYhyxu/DX7Xis8URFiAmm3PkrV1EKgNjbVkrNBuNB1YcmDNsEBwR1z1fFKOQr243czvaRyC7TDGC7eawi0Tj1eKT9dfER14VVKXVZVzAj1Pbuuxsc/dw5qzLkAs/dPd221VGzmL5ULy6FlW7lkpPqRZ9f8AfLHm2G1pcIwRFvn8kR6sUR5lxFMX4si1GzbFT1Te2zMn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZhhibfNrB07pnrDjd/pvBU7wdrbhh83CCrUqPYspxA=;
 b=gVwI1uvl2Wm6igwRgPn/P8TTTgrkUhVKVwbvn9PrfMcPZEMEpixrHOGgAgZRj0+h5A7/9PIbErDt9WL1GOxfYKCwYu1YSLW5LOBv+xsGlmSDxOhd4DFhpVXsQuvP7HJZdxWXmAMRHWAt++WgzBcGcJjInPC+RszldTpMs9Zylcc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 21 Feb
 2021 08:08:50 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:08:50 +0000
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
Subject: [PATCH 2/8] lib: test_bitmap: add tests to trigger ERANGE case.
Date:   Sun, 21 Feb 2021 03:08:21 -0500
Message-Id: <20210221080827.84862-3-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Sun, 21 Feb 2021 08:08:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1231306-71dc-4700-402b-08d8d63fec08
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB4740CFFF6BE7D3B973EEFFFF83829@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Sl6/13kSK2JZS4ts10sxa1zTY820gquqlcyqXBYLrSlt6jdDWgWT6haDSJPRCeEZAtPJs+H8J3kyhZedOIeItEvvyMYiq5k9Uvs47yW62ZWE4/J8AHazY7n0qS5szyAzJ4lZ2w6v5ogezNh9m33g3UfZ2JQHli2nBfHucBgDUbPNpXuGznes/Qrw66vPoAknnivTZJ6rKjmiSAt+kBjNoyFVgKWtZUKbuHMx+MRb1uDPKC3mNzr/bSVRiuZaWo9mqrvfb9OqmtFUCsaKIxLnRSAE4wPIz6UlSMSoSxNxjLqwgYqthp9KGOS7rbicKUpmCR+69hD3kAcZ3+s586kYG1stDCDoHA8ZgIoMkBIxTnwEs35Ia5MFyok8uMf09fwecSXX/xnIPHBxAotALfvAWh9mEChuoXOmNNHYoH/2mZChFHH7xIZ61Rw7Wz/4wAmitSe0bdbFmsBEq6jWkSrAGzaYL4g4NLyNQfCmHMnaSophroyd3mHU2EMbnLhTrYSoc7UJuNvWPJ8iclPbpUMkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39830400003)(346002)(2906002)(16526019)(316002)(186003)(54906003)(26005)(8676002)(5660300002)(6666004)(1076003)(8936002)(4326008)(36756003)(6512007)(478600001)(107886003)(66946007)(6916009)(2616005)(66556008)(66476007)(7416002)(956004)(6486002)(44832011)(52116002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ULk4hVLU1BCaW+mrlXCT//1sEK3gvwOrQyheYrgx5s/fa3fT/jzoutEBSw9h?=
 =?us-ascii?Q?XBX/CYnD8Q6UUUEmXDf5JtnSnhE8DGPAsXQI6mI+RzV/F22om3kxw93l53RV?=
 =?us-ascii?Q?zSi0g1fmGHsFTwMgNFDpxpaKg4qhL3+DlbSWPDItbnc5h7T7ISsil506FneU?=
 =?us-ascii?Q?ZHF4s2xTx4EL/DxtnUQoJZyx5ru9JUFhRNHcmN2kyVUADSQbt5TGluEdDrAD?=
 =?us-ascii?Q?KiQQgB+baqZmkSIbrXZg39yy3/yfH59TKkmkrSNVxpv6qvL3TbSSiPuOou4E?=
 =?us-ascii?Q?w+apSAfQ0ogGesFFHCOwfyYFHjC4FPbpw87QALwV1WNlvG18/RP+ILcmyrce?=
 =?us-ascii?Q?Bkq6/m6tBw7mQoIe65uNnMVSs06AO4csd5SCQHd6PrE3fGiRoAoP4W0jLwnL?=
 =?us-ascii?Q?5EWvKqVR8vMkaVY62VWJcYwayGeTukw4X5Ccdklyr85dyyKmw1eNQ8t3I4M5?=
 =?us-ascii?Q?pyOP9UrDt7Bphv+uJTcuLs8P09LuOrgYMaWQU1PrR+QMxYXofCkQ9oH8wP3t?=
 =?us-ascii?Q?y6pM1y3KDwNBMAGoFNJaUFy0RQ8x3VmXso+OI2ixuNk6Kcot/F5eufo8XV+7?=
 =?us-ascii?Q?RCjUw7tHqiZ9+NtGAXdACGzbYy66cgvEU9a2jJ3dTrz0ub6v5c6WhWCOF+by?=
 =?us-ascii?Q?NVb0VVMUCgDyZYCEGVEYTKLxse0YMXqu2IZaTSzeBqOcCq9VV22mgXGIFty3?=
 =?us-ascii?Q?WWCVj9f/FBA8CWeHa/6JAWivCRFFTcsXjcHq08RyzG5ZS+GTJ2g2gCR/ZXxs?=
 =?us-ascii?Q?kKtT1sI3VbVW+PsKD5FPvNPVGy8aEZPOmdjVWlgSuxSSGVVCI5fdrfnqVCze?=
 =?us-ascii?Q?Uq1mp3JuLEnolUSmcSdB36z/NTs4PO2A0Un6ewBaP/iwNY8K8eQJuXx/bs/h?=
 =?us-ascii?Q?lZzQ4w5b8LAvjqLZg9HHEvuuIgloXjgZ7ZFG6mI9BNsS48cozpKiLfRN0aU2?=
 =?us-ascii?Q?3wkklH7Kh6zkAs8BtU5hY8EpvWBbLx9+qkenHuihuTBw/yyvLX3bJNhp+VwU?=
 =?us-ascii?Q?0iDpfd/yy5YIdEJGATF4mCFMsnGZ2PL00FGbTyPy9MJAkWGQAB+bspsqedIt?=
 =?us-ascii?Q?utweRX380UDBI9yl0oKRV+zMyLb0V9q2S/g8nXHEK+KC786Eg/qQG+5tNU01?=
 =?us-ascii?Q?QlfQGqyb/Tpq0q0WTkhM7+uyk3NbH2RjO43DFrxT9JWzuJ00PpWz6q25o0Hb?=
 =?us-ascii?Q?Nypd+XIodUhN+E5klm3FpnUyZkt8RNOV2Y76yD6MakJC44cXN41EHsYDJZe3?=
 =?us-ascii?Q?JWrMgJ7ECKxetI109Z0Q3PkZ5W4p8E+zOhJImCdeeZhoG+OSth2LfG2KDke4?=
 =?us-ascii?Q?FnV4o6pjk8S/tfrIDxddtAKE?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1231306-71dc-4700-402b-08d8d63fec08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:08:50.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JytsNw2Gcni7jiEGe1TXLwjdoGEKQtbZUomaxNwN1mUcIhCGXV+v4nxbmorMU+K4ydu90KtQktL/ClmrR+vj8Odrv+ERkaj0U6mtRpq6PBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests that specify a valid range, but one that is outside the
width of the bitmap for which it is to be applied to.  These should
trigger an -ERANGE response from the code.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 589f2a34ceba..172ffbfa83c4 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -338,6 +338,8 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
+	{-ERANGE, "8-8", NULL, 8, 0},
+	{-ERANGE, "0-31", NULL, 8, 0},
 	{-EINVAL, "0-31:", NULL, 32, 0},
 	{-EINVAL, "0-31:0", NULL, 32, 0},
 	{-EINVAL, "0-31:0/", NULL, 32, 0},
-- 
2.30.0

