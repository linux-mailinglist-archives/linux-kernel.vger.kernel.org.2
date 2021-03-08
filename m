Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510403316CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhCHSzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:55:15 -0500
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:7360
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231439AbhCHSyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:54:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMCx4MsyHvA/fiKwXTSq4DBqAvb42ijdmFwe+TZdas25TyqfWaiJROZ7huwXMsatVJPCBRYYhd5NnB28f0+zN8TBbjKLhM9U58Bw7f7if6BsRzZUr1K4GWXKpQi50kAgbl0x8H9DsTMj9M82Pzs1Kv51WExj7D6KDcbaj2CgCrmPX2xvydJa9shLAgmmK1uQZ+U+FUHVIT6wo2nOVlZJ/Wz6iCkF7E2PCRLLIz6iG0NLblS5fhpU8eroTc9UKsMC//iodmbXRqWcczs3f1L3Y8/hhSpdi9TlkrJx+GzjwtLPm8nbBG1wCXT6Zv3x++OP0eAzO8oWa1vWPPrlrU+psw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLEhBERoq/y0GZFDJKxrpi0K8Z9RvCOHmQyQUK6kPSY=;
 b=oEAwHVCR03IugW0UxExizAfvJsVZo5SvZhJ6HnASYRfDVzQc4dmyuhJXz6dwDd3DNzDpYvymF4PkY9m993rPxFd905ORKITqUHAA9DEDxzpgXR0Nh1BiIIINvW6wmA8dIDJt16nV08IE8JdgiBEglxY6WGWGp64G55f1iBrgMgYKhBbOZClHyNp98LSMf5gsKDUMbnGgnOyy1X0O+Zr6zO3hZjpqOs50ntYY2Dyo2Zg1dO9Ew54o8TdgWuEjvvZq6s/2yql7y5WHXTVbwMl+hnAmIF35qKZ52Bb30vL4EZFEPpPYlEh1NGfWeiEEdxhPWIOpCJRnmwzE1fP1iQivPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLEhBERoq/y0GZFDJKxrpi0K8Z9RvCOHmQyQUK6kPSY=;
 b=JhSKfhkC9jsAn/hRF2n/UbqG3F8e/NuvNFvmEt54fabKo2FaipmhjZkV544B4cBEBHcC9speUMZB7s9zkvQO9eOfpLui6bDerQahUtdtx6noDFGscBXZYRiyUtYQKwGkZQT4OQdgbAHNvxZfLLib+ShQwxReHW/ze8DjYqltmQk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BL0PR11MB3201.namprd11.prod.outlook.com (2603:10b6:208:6b::21)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Mon, 8 Mar
 2021 18:54:50 +0000
Received: from BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d]) by BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d%3]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 18:54:50 +0000
From:   Ovidiu Panait <ovidiu.panait@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com,
        christian@brauner.io
Subject: [PATCH] mm, tracing: improve rss_stat tracepoint message
Date:   Mon,  8 Mar 2021 20:50:00 +0200
Message-Id: <20210308185000.14052-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [46.97.150.20]
X-ClientProxiedBy: VI1PR0401CA0022.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::32) To BL0PR11MB3201.namprd11.prod.outlook.com
 (2603:10b6:208:6b::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from otp-linux01.wrs.com (46.97.150.20) by VI1PR0401CA0022.eurprd04.prod.outlook.com (2603:10a6:800:4a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 18:54:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4718ba47-3104-4e40-1e89-08d8e263a691
X-MS-TrafficTypeDiagnostic: MN2PR11MB4661:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4661028BAB30E6274E7619A0FE939@MN2PR11MB4661.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8pQN3qqDk9DZAilpIBQ1+t2aQ0j4TUDlqRotQ6C6ay6I0D0jhDIyPzFlBxcbkG0kGQ/5JFta2FilDlhVLIFXV88s19lecWcHad2iDK4hcWr0FvCCyBfpFb6OMlCAcOHgL3H+x6EJu58AEGpAzZLD0LEKaZbd/Nc+AyftqmFn1v9yIbzMVsOZGt2Ik7+7GYwOgFPBJK3gZEocnB2u0RaiNe3TQn1M6+ZoeXVsToagLTPXYFJIhWn8UX/10xNTXAueJ49o8QuLPcozPWrdo+ty91y0TLKd340o6bT1RHDv6I6pifnQIFxkheoxOxIQbW1lpWVyE7fEHlLQ9lyoD8PBmm2d4Tp1YIQXODnChgtDxm69plO3BIYyeXt5u7VBefmHwUbE3rYFHkM3HwNY3QJbzV96kZSG+QJDMsUwXP78GwkL5XIJ7lHNt1/B759wTqyRXzrwlfIwUH8NZdXjQaUvHHH2h4v1mZWSV5z8gEXBz943oajW5XQhLygYsFHM5aOYdNq3InBARgWqpoP+R4lVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(366004)(396003)(136003)(346002)(6506007)(8936002)(6666004)(44832011)(26005)(1076003)(6512007)(478600001)(66556008)(66946007)(15650500001)(6916009)(8676002)(86362001)(316002)(6486002)(5660300002)(4326008)(66476007)(52116002)(2616005)(956004)(186003)(83380400001)(16526019)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kJh3pMI9QDcDfDLhcW5whUhjUNfKRgj8mL5++UAaXDtGGhOuCDg8F2Vylpr9?=
 =?us-ascii?Q?8k7e0HkkKagallS43nJBbYU08CXSJaXyVoU7EudniKD1TQ0NrP2JG7BsABrV?=
 =?us-ascii?Q?UzC8eBkIGljm7uS8qYMJl+RKunRPVW5uzQgR758wPNA5pdm+njHbtPx6d321?=
 =?us-ascii?Q?+Li5rhYHPcP/ECC+tkjnlvYs8q0hGmJ2DSGGw1mgJ4UBJ0oJXAnMRSwvv6mp?=
 =?us-ascii?Q?56ZHSW4UdbORUWz1SrJMTVuJr08YBD5dEYfBKm0fu6KKFw8oM2An+sSka2F5?=
 =?us-ascii?Q?QdOwFBTXSTmh6ZypsUiYuNofCjjGAUqqUmRhS0Z8J0h5pYDS2KVNgVMfoJS1?=
 =?us-ascii?Q?YvL2YueJmt9y8AfU5KCptw+f6SQ6up7FeMIPovHpsW3L1ZuKmDbHOEgsDNiS?=
 =?us-ascii?Q?+P4hUGJxZ7PoiK9/CmbkccjOHgGxHvhdDcHCTnjX2PGR9Qgd9CgSwRHq8gcq?=
 =?us-ascii?Q?GWUQWqWxXJ2KGn06boUhq4ZKk/Qf4koUOYmeuK3tmeUUnbXxv9WsrpVFzARZ?=
 =?us-ascii?Q?TR3nxxe3snGjlDUgH/J7HYk7StUAq8xYTIHMiDTcEOxI91YXQ9n+gq18+ujv?=
 =?us-ascii?Q?WrbbuZjcfs1QknlY8uDYfrlyUk/dn5OSnxVM8YE33ze7aDylxy4ypH1Q76c2?=
 =?us-ascii?Q?+xCrwshOQ2CAss2w+g/Se/1QWGAH6e7JPbDHDBes0ix5dUjim8H+VBaT6Bk/?=
 =?us-ascii?Q?5oUC8kXyMKzGBfpg/yMp/tkKHGSf/XLyshXpxbD1UXccRPpZLnrvUlRe3mT3?=
 =?us-ascii?Q?rszVEfTv+5G9ok2W05f1ZMzIR41udnRulW3u045q7n5HBr0Y1yXK205BapBc?=
 =?us-ascii?Q?ssyThlUqDRe2JDDIp46ocdcQNHR3X+gVNy3v/opV1zcDjTlHKKW1sFMAW6h+?=
 =?us-ascii?Q?69ZSEOdoax9p7OLVgBYm3gewgYIz9WW+jJNqGKIyab8+g2pDrxRLVe39GLr7?=
 =?us-ascii?Q?xJpmXg4f5Bne7npz6bfQqIpXnq4Looy+eEu9qVAkyOQT2OBDNfsnSUj/mzcm?=
 =?us-ascii?Q?9q2FofyEcfFeWoyWBd1EPmnSjkHvclju41sSBVYYGpbi1QZcLesvSW0q9crc?=
 =?us-ascii?Q?QIk3jRtY1PHtu4C6zBYJ+Kz5ONraX/S+ksa5gLrMQWlErnvdq6dm5SEBXBUt?=
 =?us-ascii?Q?tUR9/jZEkfIML0Xve3F1KBmqJCA3VHqk3JwurdW8lVc9Te+sIMQgcFTRcGC0?=
 =?us-ascii?Q?JW3dl7foOlr6PJhmZtdY4InldzEIGkTg7/Fr4jNCqNLeICLuDa5eCZ7g8N1j?=
 =?us-ascii?Q?9kC5eET3Z2ho47+3JFikHNpdevo7/LWvQID1pBZhTI5cmBTJzuZ75gyoFkLG?=
 =?us-ascii?Q?NMGmWCXCGzimh9ornfimZTwz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4718ba47-3104-4e40-1e89-08d8e263a691
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 18:54:49.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mslgMTpvFd+1N/tmvRHvPY83ah+fm8ym1+eyYJoRJ/1/dl1m4LKY11O6g5WKYsTg1cvo/937duf9H0bAFUoYGesGh4gEqIz79x3a+eglAoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the rss_stat tracepoint to print the name of the resident page type
that got updated(e.g. MM_ANONPAGES/MM_FILEPAGES), rather than the numeric
index corresponding to it(the __entry->member value):

Before this patch:
------------------
rss_stat: mm_id=1216113068 curr=0 member=1 size=28672B
rss_stat: mm_id=1216113068 curr=0 member=1 size=0B
rss_stat: mm_id=534402304 curr=1 member=0 size=188416B
rss_stat: mm_id=534402304 curr=1 member=1 size=40960B

After this patch:
-----------------
rss_stat: mm_id=1726253524 curr=1 type=MM_ANONPAGES size=40960B
rss_stat: mm_id=1726253524 curr=1 type=MM_FILEPAGES size=663552B
rss_stat: mm_id=1726253524 curr=1 type=MM_ANONPAGES size=65536B
rss_stat: mm_id=1726253524 curr=1 type=MM_FILEPAGES size=647168B

Also, make the resident_page_types[] array in kernel/fork.c non-static so
that it can be reused from tracing code.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 include/linux/mm.h          | 2 ++
 include/trace/events/kmem.h | 5 +++--
 kernel/fork.c               | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 89fca443e6f1..7916112d5952 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3141,5 +3141,7 @@ void mem_dump_obj(void *object);
 static inline void mem_dump_obj(void *object) {}
 #endif
 
+extern const char * const resident_page_types[];
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 3a60b6b6db32..623506917cd0 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_KMEM_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_KMEM_H
 
+#include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
@@ -365,10 +366,10 @@ TRACE_EVENT(rss_stat,
 		__entry->size = (count << PAGE_SHIFT);
 	),
 
-	TP_printk("mm_id=%u curr=%d member=%d size=%ldB",
+	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
 		__entry->mm_id,
 		__entry->curr,
-		__entry->member,
+		resident_page_types[__entry->member],
 		__entry->size)
 	);
 #endif /* _TRACE_KMEM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index d3171e8e88e5..b30fe8ca56b3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -128,7 +128,7 @@ static int max_threads;		/* tunable limit on nr_threads */
 
 #define NAMED_ARRAY_INDEX(x)	[x] = __stringify(x)
 
-static const char * const resident_page_types[] = {
+const char * const resident_page_types[] = {
 	NAMED_ARRAY_INDEX(MM_FILEPAGES),
 	NAMED_ARRAY_INDEX(MM_ANONPAGES),
 	NAMED_ARRAY_INDEX(MM_SWAPENTS),
-- 
2.25.1

