Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A38320929
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhBUINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:13:07 -0500
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:32993
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229989AbhBUILV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:11:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vcji5aBQq7OLWVKaDxCVoh73Bp6k8YuTuxKLstPDAJrRLKnPTx3xaUQsrJ5RJwlkFzHdSkbqQ/ZKOsU0h7kLmUorjK2D6OapvKDrdj8/1zpewnHFeOSvhvKLgKcH/ghJfyZXrLYSc5wjuA0k2vCNBIPcsgbRipatJsC/IGV9zDeKRwHsPFpRWwz8LcvEQ6cmncFwNFn8trsKukSo0OOpcgBpmgOxx+3PE7utk4npTaZea0P3e5ghcb8yJNR2a/2iJAwHfFWrHZif45gN6lL8A6WXVYZHI+i633x60BrYphHTdZJJ6nGMzuqafD6iSB08KPEFZVSMuy1PjPYPlcHwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6Pr3DAptr5RPDNU07MeGHg4Dt/bsU3BKUxmyJhrlRQ=;
 b=RIrJm0KpuGPpSvXNHmXI2NA2d+gZ1IAwYMPBi+sDIypr9reyjdYz8vw8BjFy+PnovpaS6pjXU4+YljZRDgnhNPmWsyl9J7RpUAz4RgkawCQVLJJpSfE1a1/mrucdsO21zZMlyFpsO9d+eQtO8mOJnBiVRg1L6E3oc8nBIX3MzNxMTGNWkZr3R13aBRvCy1egh5D8cYOA7S6maRcYpnxUXdTHNXglRVtuN9tJdG2jhjt9aLx0CWj2nMv5IHE8lucu9x70DOJQVWrOq/zo0CNmwibxaCKcsRQK+Fm8vTZ2pii78zDm4u6pcBpCurCGpxqB55GUoy6twSoWozwhO/XHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6Pr3DAptr5RPDNU07MeGHg4Dt/bsU3BKUxmyJhrlRQ=;
 b=ZQwVdF25LaGxp8+ak3IptYYeazEbfqZrhPRIHx77uphH3X8NdYt87wSubjJg5+MD7pFyxIE6eWvgR3Etp3OP5rb0OzrGcUMKdTZgqMVYVwK089YGJ6ADGsxlFTjtZfIgX7pEKPGDSWVZE8NGi05MrdOJk2fWUfl+/BjMal0zjuw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 21 Feb
 2021 08:08:52 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:08:52 +0000
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
Subject: [PATCH 4/8] lib: bitmap: fold nbits into region struct
Date:   Sun, 21 Feb 2021 03:08:23 -0500
Message-Id: <20210221080827.84862-5-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Sun, 21 Feb 2021 08:08:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91fcc18f-e1e6-42c6-4c17-08d8d63fed40
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB4740EBE0B747392526CE687B83829@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: co7B1nFWVLMSTC7xo2qll+cRMJNAvZNj+36Oqil+Mwpfr1XkFtgD3lqOr92PN6iY9vzbO5X6pTp6puIw30p3F10WxZ6gJL3/vsz2EWIIrAhWS4kbvlk4UU2vIDqQtMYbpmhF83lwQf9Owm54QCKRki8ruZmkpZp89KX6B+AJcCxmHlf9LAIAuXKwO2DLVGYx2wH4cGU1UUoVOaGBj0tx2A+ouCDqeggBNWaB3Hxc8i+KqgQF/D+73ig/Y3IcJNlOXmTFMYzsnndSXBPTTZOktD53OZtYKvQBkw0TArwLxsDZJOv6DFUbjNbZnR63WSkuOsYOc/c0fFfndfEbgKKAoSz1luuGCyo12cYOZWY8yKA24f0pO2GwUaVOVNvw7zqo7fgMrtD0Qr4Igxxn6MLPPalEobYCBmDvb2/sF5xDOeDKsJ68j6lnNua8kMBAOGiBW6yGu8b8nmSq8wJrWflMV/+ERHSkEmDZ+ftkMM3b8M5PkLgupwBaVQQU1qrHsD5EUf+H4YTzKNVlFNSkquEkKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39830400003)(346002)(2906002)(16526019)(316002)(186003)(54906003)(26005)(8676002)(5660300002)(6666004)(1076003)(8936002)(4326008)(36756003)(6512007)(478600001)(107886003)(83380400001)(66946007)(6916009)(2616005)(66556008)(66476007)(7416002)(956004)(6486002)(44832011)(52116002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4RTUZVKYOfx7KUM7hE3G47TBF4WmSHuIyAt355gBCOTuzxzulIeTU91n9ydy?=
 =?us-ascii?Q?qplyfDq1TaQwRDRX0MinoH99kgOfqn5vr2eqb3WVsVqEMhm5wfQpBRKhsSLE?=
 =?us-ascii?Q?YhqkOdMzTM1PxENhZy89Hy9cBhZbtJggh3fPvYwOYSi+mutikqsLQwLDPguo?=
 =?us-ascii?Q?0cDpJYAKHZL4IgkwScIE4AvBEhtdtXMDstztOhaTRFj98Ndyn0nAvw7PJUGu?=
 =?us-ascii?Q?SRLtOoBQ75Rgglt7+h+0Iw8m+VCWLped+wkWic91HA/ib1bDO102m3YmIEzu?=
 =?us-ascii?Q?i5wBmpwS23lYhmzrRXQtPpcWWpjc9rDTp+GLcbxfgkvy1WmbAtZssTHhoKQT?=
 =?us-ascii?Q?j6+MTCgJpPT57aRKCIN1NRc/qsoRweGrmsRA/ivytDEPLM/3snyCVZ2xmIoW?=
 =?us-ascii?Q?YjXuPecClNP4VzfpQkMjXeRNhicF3J6/bBap+VYu2MIBeWvwqC5FeBqP4Jic?=
 =?us-ascii?Q?AqDzZc8qh2msQ6A3PR3mLPZvExRMC+NuVTULeG8MJTQrz0UOLaw9XZZetNXc?=
 =?us-ascii?Q?zBy31UVmieL76ZpqmDlSQTUGPy31bbSlkz2MAtdjDeUQUYHI4gazpqMCxI7e?=
 =?us-ascii?Q?2QJiOege4+mMDMu7ftXHD6x9SnO+8Jq/hXUbMVjKM2jn7GfhG1xWWAjE05p1?=
 =?us-ascii?Q?YTw/NfYohnnjG1FnQjAyY++GBxg+j6+Qxwe0Od0hvVY2xXY/mTtqWfI6UEA9?=
 =?us-ascii?Q?zo/fNIy+9K91To4nVvO1qBBzu0pxR0kaPEUqWWFfYvmI4Sy/9nsBMqrrMRtW?=
 =?us-ascii?Q?JcP2Yl0XtN4MqO+5N5h7AXpR7XphGpc6mQI8jDLP9IuNOz/ieFjBhXBCoz8N?=
 =?us-ascii?Q?fIw01daTkE6WpkuKLhV8kaeyu7xZfOf1M+xi2N1Po8bR39FkhjfV6yF/oB/i?=
 =?us-ascii?Q?zkakKZYMaZxgVqPBJDZFI4InUEDnnrfXC8fUCZvwe94M99j+iBIi4FghiEcw?=
 =?us-ascii?Q?dldZX+Ij8D4vN0OYO7+LHkYfYhrD5EkJAmWPvEbMQwN+6GvRyNctTwH+NSeR?=
 =?us-ascii?Q?jSkuCPMR95Q/XiRAGwNtPc++9lVOffwunyKhj2YEKfpGUNOeqtBDm+dziK8y?=
 =?us-ascii?Q?pRf8NtxPFXIK7/4jV/0+Xw+4E/DvbVG/xfXT21oBYzClkL8Zgew6h+Y42teY?=
 =?us-ascii?Q?Q2lWHeX05IbJ7KbFknSpWOUGglgaIiedDtXuEGf/l1l/zubgC2zSAIchkXLa?=
 =?us-ascii?Q?ttn0KQx/9Ilkk/IHcq0ZzkgPPHpsLAxqWoIC7Us6f/p3pToPcRoxzPejx3wg?=
 =?us-ascii?Q?3F0xofut5RParfSOZc4RgLeSY/kT4ZqOAbU9Q+YFl9hW0/VljJ+RftFR9s4h?=
 =?us-ascii?Q?k35EcmFzuIHwleUP/uRJjdPt?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fcc18f-e1e6-42c6-4c17-08d8d63fed40
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:08:52.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gVc/RiIW40zSRSsNms2kfLzISxbXP1qNJvNV3GJVUeDtum28T4knX6iRlAmuDOAbFCrxtdQUs9MBZxfHeu9nwqzCkCfe7R706Z2ESF+nSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will reduce parameter passing and enable using nbits as part
of future dynamic region parameter parsing.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/bitmap.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 75006c4036e9..162e2850c622 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -487,24 +487,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
 
 /*
  * Region 9-38:4/10 describes the following bitmap structure:
- * 0	   9  12    18			38
- * .........****......****......****......
- *	    ^  ^     ^			 ^
- *      start  off   group_len	       end
+ * 0	   9  12    18			38	     N
+ * .........****......****......****..................
+ *	    ^  ^     ^			 ^	     ^
+ *      start  off   group_len	       end	 nbits
  */
 struct region {
 	unsigned int start;
 	unsigned int off;
 	unsigned int group_len;
 	unsigned int end;
+	unsigned int nbits;
 };
 
-static int bitmap_set_region(const struct region *r,
-				unsigned long *bitmap, int nbits)
+static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
 
-	if (r->end >= nbits)
+	if (r->end >= r->nbits)
 		return -ERANGE;
 
 	for (start = r->start; start <= r->end; start += r->group_len)
@@ -640,7 +640,8 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 	struct region r;
 	long ret;
 
-	bitmap_zero(maskp, nmaskbits);
+	r.nbits = nmaskbits;
+	bitmap_zero(maskp, r.nbits);
 
 	while (buf) {
 		buf = bitmap_find_region(buf);
@@ -655,7 +656,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (ret)
 			return ret;
 
-		ret = bitmap_set_region(&r, maskp, nmaskbits);
+		ret = bitmap_set_region(&r, maskp);
 		if (ret)
 			return ret;
 	}
-- 
2.30.0

