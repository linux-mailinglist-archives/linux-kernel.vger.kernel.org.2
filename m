Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2195338D04
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhCLM0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:26:13 -0500
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:35169
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229568AbhCLM0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:26:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL9F30r2Ys1feFCH2fVoeNkdbNNNy+WW3krCx6NgG4EcY0P+BN0SigZ6oWloaEBgjf8pYScATkQqyenHjUdYi6RbnJAu7d0jPXLXvEFgO0rMAfcMQvmXGH9ir4OjZ/cO/CaIjWD2+n5VTmMRmLEZSb+/Cawi061tUx2uZoXPPze4zHB1ByabjIBk/Ree1bDf9sAcaBJnL+nvNoZbPHdfhvLlnT079rvmODZJEOnHjEg9JKqBzqLkA0be9pVW0omJ+m/SR/jR2ghfkADa9bsPqBhgZ/mK1oR5MhiPtA89aKUi6si2ymcoiygL9k3lOLZmjdT2qNAtY4MWHQ1/vd9rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnC35CjVhJPDVxrgifqJFBymt+SsucTjwl1BjMgP1Qg=;
 b=C7/zuM15fV6reSHZECyvD8dPZ2pOZUcNBnlPc1wKp4xgxP6bOjhrAAG/CD9RIBc3hBR1Vadeery+oWd583WbqsAIpjiRSKskfHT2s3WoCwSKMxySguj0n2aPIApVCw+LVwKCHNDVhWH7qC48EmTI75yDz1YCvvpJ32r8NRnktjqg7tBuIVsABroAFF83dL3cAnUN8lb0goTBqwlfyDLfvLL+z1dGsQGxK0wxNayCaAgQocnXGC8lfc+5enVBTlJOb3n5VVQwmAKu9WVR3/u8E2H0QgPeYQ+jrYIYS2YCYUYIsXPHCviicB0KXR+vDBYtgf436kbze0X3RXCarSfwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnC35CjVhJPDVxrgifqJFBymt+SsucTjwl1BjMgP1Qg=;
 b=BUr+XAOoEy26yYaan00h8anW5N/eAJ2BlBzzhwUX/LZ5+/et46fRonk7l2TaRlUG0RG5TvF0Atar6ecdczytQ4D7C2a11NqINJoeNEyQk1XthTmvlV9AM7WAfRHFAJIBWTLYQLD+Q7mY24x/wUcTVhrUt/+43ghxMzZ+rhEfWE4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BL0PR11MB3201.namprd11.prod.outlook.com (2603:10b6:208:6b::21)
 by MN2PR11MB4192.namprd11.prod.outlook.com (2603:10b6:208:13f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Fri, 12 Mar
 2021 12:26:04 +0000
Received: from BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d]) by BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d%3]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 12:26:04 +0000
From:   Ovidiu Panait <ovidiu.panait@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, akpm@linux-foundation.org, mingo@redhat.com,
        christian@brauner.io
Subject: [PATCH v3] mm, tracing: improve rss_stat tracepoint message
Date:   Fri, 12 Mar 2021 14:23:43 +0200
Message-Id: <20210312122343.25784-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [46.97.150.20]
X-ClientProxiedBy: VI1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::17) To BL0PR11MB3201.namprd11.prod.outlook.com
 (2603:10b6:208:6b::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from otp-linux01.wrs.com (46.97.150.20) by VI1P18901CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:801::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 12:26:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b83b37-00d8-4028-6995-08d8e55200fb
X-MS-TrafficTypeDiagnostic: MN2PR11MB4192:
X-Microsoft-Antispam-PRVS: <MN2PR11MB41928D422AE1CE1F5EC0BE2FFE6F9@MN2PR11MB4192.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsghDfG0/WiFxG464yLOkJhM79iReCSrfUu/CICyo5djJtEEv6UPTYIMSCh1VwQZR1pZGHwePNdilSynLBNeSJdBVeETC5/rHW1+wNCMud2LuNXyFc4KuY5uY6JVHeJ11ZCrJFSwnstgJfD01Ay4i1BCyQZrdznuhy5IRTMAqWcY7O6KLmm30lUSicV/CVvkDVe5HljDI+IPXVEtdNj5IgM423Nr9ZEEpUjvBuTEDHJoe3ftRi2coMbVUWBQSuB4MsWRTIV1ynp6pDvX6SWR0tPvk6z+wny/gnM+iVn6fJ7IJTZ0Rok/Y3vkNa7JVpLi6UIefWHHEAZfGFBrhZ3fja23NBgAxJ36QVPfWuqZUPBZJvpGKe28LAtEPV+vt+c0ip/VSL5zeKJzuFT1n/sS9l6wowFtgBWKkdIauL+GfgptdYWOzM2uO51NKIzl8vw10fj29etloOPOJbOplrgExucnIZLj05RIwJ51P9A98mV41dOT9evjAR46Epxg7sxh58BSgmQYyceocPGnaZrEmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(366004)(396003)(136003)(316002)(8676002)(2906002)(44832011)(83380400001)(6486002)(4326008)(6666004)(2616005)(956004)(478600001)(6916009)(1076003)(52116002)(6506007)(15650500001)(5660300002)(86362001)(6512007)(66556008)(66476007)(66946007)(26005)(186003)(8936002)(16526019)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iUeW0NF9GF9hKYUYoTZbTyyRIgpDFoSBiCr18Dq3edzKTNaDwRjzPmkwSXWu?=
 =?us-ascii?Q?rwAvG5Ao3IppUmS5qqEYFwKmM5n9P0Ks57ByWDyXL6F4DuTdSl/XODH2PirS?=
 =?us-ascii?Q?G3mjJoqckz7sMJquoUXiH6lMGwMp8kMSqaQFQvhxFYkN08us7pcY9Vom88tH?=
 =?us-ascii?Q?zjjfukdOPbjSaYAYhPFLasA8KYJD6UEDFodz0sGN/8uzbMUUZE27TYuNcM6H?=
 =?us-ascii?Q?xxDs2OgllN7k5lcPwK3FCkt049ax9CHcCpCU3Ijd7OxyRi+sUzymG8Fh8Y+Q?=
 =?us-ascii?Q?Sbe1mQvQuXHuFpMUNfcbhQvltvBX6eAUQzZf2HySGfqjCqbW7EPonT+PMKV4?=
 =?us-ascii?Q?KQP7kqG4O5kc5/Rq3Lo6nyOrxPjBmpcVn5Q2nxbonIaLI09v9Tg2H/umPlFp?=
 =?us-ascii?Q?lkCDOcAjDzbh0cFevfKc0UPObh4zmEoMh+hZC7/bAw0qm0+ukg0O8xHMa6Bd?=
 =?us-ascii?Q?rMooJefXEGrQHtg7tJ4MHryQ1whCWoWNiXhEpa3+DT/kvvu8GcrivKDRbwcQ?=
 =?us-ascii?Q?G4whbW0qtgpZbkQe3yHER9mL8uZh5oYZHd/l0pwgL84xdPlQ6Wx1hzpc5JOH?=
 =?us-ascii?Q?MicM7Ad0BcupzW+8QkZGHGLw3Cc1f70ruFP/6MRljHSlmBW7LMRsWOBVtUei?=
 =?us-ascii?Q?wYV/x7/pDsZznKJ8PWVAV1RKI3tBHSGHBbm31PWj7imObRAKS+uqG4AYmHNX?=
 =?us-ascii?Q?RPfs3rJdIIcJ3+9fzX8yF1LhkARELqo7T3fnDkKo5K+ee+Bs25LSBD9IRCgP?=
 =?us-ascii?Q?sDCRBQ/p/ZHHxbAiyjTQHLyQQ0NPFS0NJIUKqnAQ5lfV2fnXpC8Fs2iTMeq8?=
 =?us-ascii?Q?RdH8S/jEup4E/FeipA0ID4t6yUkgbkW8SvEEoFS6hD6TeO1OCEyztzz7/Dzt?=
 =?us-ascii?Q?Q4e60vpkZ5+5KYSHXjgRDk6l2p0JG7U283S45ubvFPIg5Pb4+EiVCvuHXTks?=
 =?us-ascii?Q?YsvcvZiRiHiJhD4yTnYjvHPIVLw7Y2yq2tzc1/aw9s+Rlsk6djhQ6PylzGTE?=
 =?us-ascii?Q?qalHl+yKjpJqeBslLhEeVNHiwyyxvjRFHaPOkrg50erdZiKN7Q+qr2+2LOC8?=
 =?us-ascii?Q?hFm46VnQLcj3yNVDeQcKJ5bFjDu2YWkufvdcdm7+KGXpXbN2vDrptPjN9l/c?=
 =?us-ascii?Q?Qv7LnNJDc3O1NGvppmGspI1uuf87ldqDaG3At4Tc5ZdBrZA5XJvKDv7BT4ww?=
 =?us-ascii?Q?RnPhz4cjddQapigHdeQd0k9HhO7wfYrUTa3TfZU4nzgSI+OdrdHrk4G6jhb+?=
 =?us-ascii?Q?0nYFGTsGYEHReR1mErLKqoj7uIkmYYyD7oqidukx+scp7mcoJrnrdrzrXbw/?=
 =?us-ascii?Q?C7abGOLewJgHph56QsaRraQ2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b83b37-00d8-4028-6995-08d8e55200fb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 12:26:04.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjhGdLBfwLFJBfwG+gkqfAC5QdG2OSiHTKO1mxCJMFh1RH7oHv9hSaV8GjlZ0BW06ETFgiOzq+iTx/o2YSBfZx2FpOkFRiBpxjHX4Bo4IVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the rss_stat tracepoint to print the name of the resident page type
that got updated (e.g. MM_ANONPAGES/MM_FILEPAGES), rather than the numeric
index corresponding to it (the __entry->member value):

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

Use TRACE_DEFINE_ENUM()/__print_symbolic() logic to map the enum values to
the strings they represent, so that userspace tools can also parse the raw
data correctly.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
v3: add "Suggested-by" and "Reviewed-by" tags from Steven Rostedt
v2: rework the patch so that user space tools can parse the raw
    data correctly

 include/trace/events/kmem.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 3a60b6b6db32..829a75692cc0 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -343,6 +343,26 @@ static unsigned int __maybe_unused mm_ptr_to_hash(const void *ptr)
 #define __PTR_TO_HASHVAL
 #endif
 
+#define TRACE_MM_PAGES		\
+	EM(MM_FILEPAGES)	\
+	EM(MM_ANONPAGES)	\
+	EM(MM_SWAPENTS)		\
+	EMe(MM_SHMEMPAGES)
+
+#undef EM
+#undef EMe
+
+#define EM(a)	TRACE_DEFINE_ENUM(a);
+#define EMe(a)	TRACE_DEFINE_ENUM(a);
+
+TRACE_MM_PAGES
+
+#undef EM
+#undef EMe
+
+#define EM(a)	{ a, #a },
+#define EMe(a)	{ a, #a }
+
 TRACE_EVENT(rss_stat,
 
 	TP_PROTO(struct mm_struct *mm,
@@ -365,10 +385,10 @@ TRACE_EVENT(rss_stat,
 		__entry->size = (count << PAGE_SHIFT);
 	),
 
-	TP_printk("mm_id=%u curr=%d member=%d size=%ldB",
+	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
 		__entry->mm_id,
 		__entry->curr,
-		__entry->member,
+		__print_symbolic(__entry->member, TRACE_MM_PAGES),
 		__entry->size)
 	);
 #endif /* _TRACE_KMEM_H */
-- 
2.17.1

