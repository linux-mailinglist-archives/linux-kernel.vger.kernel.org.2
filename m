Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9C3342FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhCJQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:25:34 -0500
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:1505
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232489AbhCJQZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:25:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeYLpuyWfzCB2eHxhNKF6dwTkViQdQ8dICNPzZsYjzV8/9mscpZ3wMQmqFVWysGaeU20tUN2ApamnCOK78nMwAOQwE4G60lj86gUk7Rb3WUXi7YRi7Xbgz/BA2eiYD9k1s9qTjjMw6uj+EMom28omJCxnnNA44CIXsfAWVeVWBMG3vpLHeQfRg5e2tXwT5/PNsHIGjEFg80zAi7C+iXaMjaXPXd9/+VX/xuvzJBu97NJwdP1mtryCYdgoeiyxu1GeVGfOIGBQVIfTLS1zNfGeyqM3ybBkMzjPH5qVbTYTwTonkcwKBpizbEgPbIustwBfqn6LQNQqUrW9rsS4cd3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M3cyBb4HyOINkhYXbwig4ZcvN0jeo3Wjob+7CmJ1zg=;
 b=VqtERQgPYcRDt51HioVkKx5GIgTcRjWj91LRfRbWeIJb7j2GcY5GTZYQKKM6vzbwZfibW8N0y5ptVJUZedLa4men4v6Qn8cHddlqi2Glf/IsFcMoD14mwZdtCHyqTE3FEyldT0QYXB52IeVYR3cCQflhwaSXJKE9lwgGduFNx0XJ8Iqy73A1IKPqPnPu4KvB8E5+duFU7VTZc7gHNkke+jKLYOcS6Y1QJIlqpVklGn9qj+uEp2A6bG10G2NxnBXGe+iMANGM1GU9ZBVJXwwbi6JYXQ1SYrFouOyp5sPNrrBkthwHkvN0DnBK6gwbGOIByl/vTYmYzvqEhf4iaNzhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M3cyBb4HyOINkhYXbwig4ZcvN0jeo3Wjob+7CmJ1zg=;
 b=MDkLO4apSnx+6E24OyGl49GyOYtn4kVfsVS2KDQEMeU17L/jHQVPo5lUhk2V0uQtaSu2qAaxtqWWDDipFM2PISgAM+v6A3Y7XwZibQhqMO5yruzxoZf/GZlYW5/aoMKVVkIyuC9N5S3+diYPmMZSDgqNn25lmNeqqJwbdItc5MM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BL0PR11MB3201.namprd11.prod.outlook.com (2603:10b6:208:6b::21)
 by BL0PR11MB2994.namprd11.prod.outlook.com (2603:10b6:208:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 16:25:30 +0000
Received: from BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d]) by BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d%3]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 16:25:30 +0000
From:   Ovidiu Panait <ovidiu.panait@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, akpm@linux-foundation.org, mingo@redhat.com,
        christian@brauner.io
Subject: [PATCH v2] mm, tracing: improve rss_stat tracepoint message
Date:   Wed, 10 Mar 2021 18:23:05 +0200
Message-Id: <20210310162305.4862-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [46.97.150.20]
X-ClientProxiedBy: VI1P195CA0033.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::22) To BL0PR11MB3201.namprd11.prod.outlook.com
 (2603:10b6:208:6b::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from otp-linux01.wrs.com (46.97.150.20) by VI1P195CA0033.EURP195.PROD.OUTLOOK.COM (2603:10a6:802:5a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 16:25:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f908cdb3-cdb7-4207-4e56-08d8e3e11eff
X-MS-TrafficTypeDiagnostic: BL0PR11MB2994:
X-Microsoft-Antispam-PRVS: <BL0PR11MB29948E339E89FDB3F8571E74FE919@BL0PR11MB2994.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnza5A/XOjSIPELFZvXn3gclEnF0JFOR6n/ZeEiKB/ge2X8nvtm4BpyNC4MYdrvsUXc6LqB2Mmm5GXb0cze0ONpRKOVIcY+AklXwzmpt3mRZH7xn/6EmXc9etNHKU20lNdcBATzWKaariEUCrYLQDbmCetCWtcCWvM3YD4DdfZA1OBfDviRMSYV5EECs+0UpEEKgMnQRA40HaDNek2meTMAwlp41NgNLzdrLuAalEFFK8JqvfZ6dTFn7W5RPk6EinHS1Ot1mDFVqGIulGwXmtzchR9sxHlM8TMHAnfJ7gZjGyD7DK7KBkkR8HBW4LseSzz8iL13KDoxWmbjt4vHXuLsIbQnbv74blgehNB08gSRHJhX3+YbZ6LqNcRt4+MRCQ9NXS2extey8LpuNZK28a8M+zpVwK4b4audx0fmL9Ud292DGAITxJrZFOHdN9hmrmnhcn7ZzCV+1+GGM/cbxX5FBjYbz0PQP+cLEVRwgS8OOyLSElQalomImcbil/d1QfvfZQgCGpuBWCLrMLSwCAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39850400004)(396003)(4326008)(6512007)(8936002)(83380400001)(6916009)(478600001)(16526019)(26005)(86362001)(52116002)(956004)(44832011)(6486002)(6506007)(8676002)(2616005)(6666004)(316002)(2906002)(66946007)(66556008)(36756003)(66476007)(1076003)(15650500001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Bv4Rp6YJkhNY7KVG2bSzyzqDC9P5OVmQtit7fp9hOeA/MIRcGjzltkcvYj0V?=
 =?us-ascii?Q?Epqc3CmFf5L0Pn856bfF3arfDIB/6nyQwbNzXztImg5Nl60B5rYlDGef+nLX?=
 =?us-ascii?Q?vIxleKulDrSh9L4nEyhhvNHu9yYfuzfo8+eNtNXfMZ4uwk1WlhPPnWnt0spN?=
 =?us-ascii?Q?lm1ufCDpFqqgoKF4wFRO3hqGh+FAPHIm4+tb4o7RwRjzsj3qdMTaMXzt4zbm?=
 =?us-ascii?Q?0j8w/5BbhhBF95pejKIk43UDcBXWXhc/CubYDNMcmKMCjl5Ib3ApVTwpZn+R?=
 =?us-ascii?Q?bFXFVcrHeXhYoo9wjXDfQAtPJ60aBN2n9Q1mR7waBtkB3Z7iAsimjQcvWpzN?=
 =?us-ascii?Q?JZbDV06nceiUcpBgSxIrxLq1dUsiWrf9NuK7hqz8M9plZhVx7n/RHPctRWDN?=
 =?us-ascii?Q?KSXQbiSLsKctLU/aKha5c47Mryqk3qY6viYpKDtwvWqiQtWi5h9zhfLdOWD2?=
 =?us-ascii?Q?bVUGOEkD8Uo97p6eecKPEC76l4vcYfurZATYP/Bc/zpdwtXruZqRg8J8tkZM?=
 =?us-ascii?Q?4H1r6IK9zZo6SisX1RmzwllM8ytr+Tk+IAgDDp2ENhn39LFZP6ONmegl54Hj?=
 =?us-ascii?Q?qSGDZCVHlZhAYfFBZ9VR6OdVbykKnfeyF/OUpU6JaAQohr44EkTZ/D5HgL0x?=
 =?us-ascii?Q?XSUPGlFvQa0qMT+LkLgJfo+pN9jPOAf/T/qGhD5zhSKzriMP8u6Vc2sR1WBB?=
 =?us-ascii?Q?/kWvO5Vabb5atkMwD9lLJvBm19aaQ4iPFKAJ0wKZCixxXs/EUBRQKfz35sfx?=
 =?us-ascii?Q?UDHxmRFHT3MIYDUztJ1ZUE5alO0fCAniobpGvSPI3jKhRN5ZyPktRGDl/NJg?=
 =?us-ascii?Q?8EZZEst/fhCCG2xiybTFN1u7m7azZT3W/CYcMEQxcHzDgKSWZBq9L+ON6Mpb?=
 =?us-ascii?Q?iflYn7P3thBoR5BAl6e9ZaKkg0pb4QyT5/RzhY06cd9fVQZSSYFb1cl3EmRL?=
 =?us-ascii?Q?Q+cVNxclQ5OHYQ1sA3lvTMUG+ZtYXHwNQ2IbN1HXjVl5yILGfClOlSaDuwFo?=
 =?us-ascii?Q?+O35UsQwglWosWAjpXZ7+JRt9VDGb8J3lvvN78+XOPuEJPr5egNAWL5c/A+J?=
 =?us-ascii?Q?fUHM3X5AZBdZgSoviopdrSDmSzegWMRPlDAIQCqBRxqMKjbwfIm3Shmzb48U?=
 =?us-ascii?Q?4MRTuEegK4W44ASs/7643tsiJuzlvpEfqP2eD7jfjbD5JZajAivHAO00e7VS?=
 =?us-ascii?Q?YsGfyvfeoy/kOFXNfIMV87SNWQ0VlVkwi2DwYmS0QK8Sc286IGvsuzakQaMd?=
 =?us-ascii?Q?01T8UldZyUAFnGoiFdC+oBV79BRULXmPxXdfzuXrdouzz8htBMohpkacW8XE?=
 =?us-ascii?Q?H1UW2hNPTAReJKWJPmhw6cZB?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f908cdb3-cdb7-4207-4e56-08d8e3e11eff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 16:25:30.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LkRqVVCfI+z3IC8gmGAhytgxKdONlsvVzIfH8htu3hBfXFJyVjjPxGpH1w3KRMFwKRK/Vy2/F940yv0fmHgeKkvxDqQlot/+p3xY3fz7Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2994
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
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
v2: - rework the patch so that user space tools can parse the raw
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

