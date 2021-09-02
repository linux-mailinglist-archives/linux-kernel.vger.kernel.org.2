Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0E3FE63C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbhIBADa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:03:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6976 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242987AbhIBAD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:03:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181M8Lj8018844;
        Thu, 2 Sep 2021 00:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PcB4KxgkbWGkMzpop9hfst2VcB1Zg8grq9XHeeW1XR4=;
 b=Invzd6NOz14/asdbs4euQK58sBgAP8Xu7PonZY7TuFJ1KgnXLwsOFg318Z8kSzNIKoP8
 QcJGShutydaKwUOkYmmNFUwpvNXhqxI0juIeHqKQW6SBEg9lI+rMjFYWJPTOIIHvyUgt
 4skYGlDItbhT6Fjsr2wiELTMMxUmGgwEWbfgxKWXUCCe+eiLtjtWpP1k3gdHEV7WyLzq
 YfxnIDFgc59wx3Vim2AZRMszyRVL6COATJEbjXFYZZdY3n/rpcaO+PeHQTjhaYAa8FMT
 q9k7HMiffUymp+KHD4NjnttfamrV5J4G3wMtzbgwxEGRHEJITQdlBYnD/p1wrrnTtj7h RQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=PcB4KxgkbWGkMzpop9hfst2VcB1Zg8grq9XHeeW1XR4=;
 b=Cl2GgtNFC25wW5ID6uMGJM6J4rQpK77mWcXjczGGc1F97eSid4zM8m88RsevlBNUDn/V
 FJXVJH4s9/XDcxxA/mBwBq5KLKr1qtRdHfinDnQk8QGixYQoGag0XUAcT57vVZOUKfgV
 4qM73Iy2AhFyzR39d28mYxTNvNEIm6FXjXMFMFGrSRJB9riO4uMaRFA2zKPX+VtM5JuW
 4N01eBNoQmZe/g9lmjNdOubCkJUPprocH32Gimn3dJSS//dOVTMPD3bK30cPTaQunUXi
 XeHABp9ElNxkxsmXZdgAnE4X+44BBo46aEKyYcs50wTU5kplqBld0ahj6zvxu4Oja3Ei YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdvygwcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:02:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181Nxtmq098749;
        Thu, 2 Sep 2021 00:02:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3020.oracle.com with ESMTP id 3atdyxxxnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs27f7zkw5yZhm9MKusZEnU6P4/eWNs8FzKJdnGSsA8+pOsloIYQJP/p6r0DIcwSgSf3isQ3gDbIc5xQqm0GxokzJ2wQhyAN7BCsNKHUZgN6FIsqxaqZGN7FAlMZVHXUC2A4gdbztvfG2z58Z8vzDnP1rj/Wcr7/YpRqak/tFHBWmLmAZlGLhwi5Kqsng5LsFMQccux1XMrgY16K7Y6uQWBvl+CC9EsYDTJYoa72cY1+A9qbcHhitEA5lBu/HT2XyKwsi8PnxeGONRDkwA4aMXu7vV/ECGhYl9VcAeLTO7dwVZhTfmpffrGFkL5rzir3vE9QDqu4MwTIp2n7FIZoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcB4KxgkbWGkMzpop9hfst2VcB1Zg8grq9XHeeW1XR4=;
 b=P72ImoMzAw/IGqU1K68rCbVC16lJb/0qyI4UQkH9M29/yfpGlxgQMLjCEEmzbNUxW4LLlt8eKEaaTCr/2aozuwD+0MeFeHAMdNWcq1TTAd7b1urobwfK+cTdFYf5RApOMf9gAY3bRcSrSLEUjMktIuhkc9O6EyC59aeJyKgC+r7mhc9N8lKEQZNbG76wSg1h6cEnUjdW9ljSTgnvlGDLM//one2gzN/YfBQmIVvIrjaZ2tv/vQ4LXx9dWVRSz/Zch8CnYi7OmxGpOM6PuPFg6ylc5D8KNcok9R6gNSarrRah4gULT7kyfx4eiCb0tw/7zKqqV4CoDOyGepZt7jg+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcB4KxgkbWGkMzpop9hfst2VcB1Zg8grq9XHeeW1XR4=;
 b=F36T4vyTWZyxON513UIx/K8zwVLD348fkk/xGV9XH0rEqr5HIctVz9lc7vPybguqwpMXfaknES3Ais8t7JpHhQMyAWZtMxcTDoTGmiz4U7oAIqClMIDBs93udSGXffx7zwkwKrKkbQ7bfPkgkUth51K83pfYXv0OOde5bqO9oYo=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1999.namprd10.prod.outlook.com (2603:10b6:300:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 2 Sep
 2021 00:02:15 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df%6]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 00:02:15 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     vbabka@suse.cz, geert@linux-m68k.org, akpm@linux-foundation.org,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] lib, stackdepot: Add helper to print stack entries.
Date:   Thu,  2 Sep 2021 10:01:54 +1000
Message-Id: <20210902000154.1096484-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210902000154.1096484-1-imran.f.khan@oracle.com>
References: <20210902000154.1096484-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::14) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from localhost.localdomain (110.33.47.182) by SY6PR01CA0009.ausprd01.prod.outlook.com (2603:10c6:10:e8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 00:02:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fd33a3-71bb-4146-4ae2-08d96da4ebec
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:
X-Microsoft-Antispam-PRVS: <MWHPR10MB199994B2519214B4B76FA30EB0CE9@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeRr9NQSwbrzJuM6PAafV5VVly41lhH/frSK7psQgeqyDkxwohKx3uKwpXWp4q+rbSYfse8lY/eijnFKy3wsee90y5kApKmTFPbu7JHeIze/fBQbXSs3LFdM/zZnvqy21+mp2mzOP93Ti0TLOaTjn8ascVrg0mnGHuAzDYT6HpnS14TS/Y0yI/okZyt55sKTm6i5iUJdOsFVdrz/Jamq3lmciCs9SquofKvMzUvTSxaQIE6Nyd/YWxTRZtI0ALTSPuzQZ3WF5Rw0xcaqEU6Dq6OBmq+41U1yFZZY+IkXkkf0Ad+bu7utyaRpNiwxadjTvblOSPltQZSfnGJArzKfZvRgXm6zV9KuHmP28uPycAp+9HQhZ5A1N6CVlENjMrpicF8nLZ9j+fMyKcZUDF1OG7bNqekB465DrDrWu54/hwZNMe+1wSEQDvZ4gAHz40s37WfK/pe+sB5YdUVdnuNbuCON2zLrx194jp1Vu9031OngW4ElsULk9QxT/2tm+TJMs71OG3ZTdx3/5j5w75ph9GkNsKHtD6mrCxbS8mED4vVpdbqYcGSw4d4I5YuFSh3eKW9M00xco9sWKIWRoQPXLyZwg38La/xuAnWrTyx0ZLpwLk/J25w6OraF17OlPmwXQKmXwAMTggcxSEC4+cKRz/D+Nn2bNfPRtuhQ0nN8vfuy43xsg+sM0lTf5bzQvumPVd3eS3IEDwBkMCiyGHQRwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(39860400002)(136003)(66476007)(66556008)(83380400001)(36756003)(1076003)(5660300002)(8936002)(52116002)(6506007)(8676002)(316002)(2906002)(478600001)(6666004)(6512007)(956004)(103116003)(2616005)(186003)(86362001)(6486002)(38100700002)(38350700002)(66946007)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GYyqh2bimr8qwer62JjyEQuhkKYK8ERz6tzINjK5MLs1Ek2r8m9qr1gpwUGY?=
 =?us-ascii?Q?73b/S5V0qxwvDguxaoiVYQAUb32XqyciuGlV+QjYE6jfB0XiYLG3an5uoD4d?=
 =?us-ascii?Q?VCoFGIOtQriB3HHjnZxyWj3uKRmGbLs9w/8Sdv+jUMU2HkIwEEbL4WBOmJmV?=
 =?us-ascii?Q?kzx/BsGhHiu8iGtJ7gMd6LqpYaN0aXKzMMVNmRDeKfN4XINgHuj5IBWvqMaQ?=
 =?us-ascii?Q?YLxbzh22+lrlun/s3YZL+dUnQUQA4UYY+pAgWSab1K3vUaBgowLGmC/2RVtP?=
 =?us-ascii?Q?iDubinsOhAdPdu8BHpIlwFoBj5ttFoYOX2668HokDBCDG1cN1m6VNYkr4+Mm?=
 =?us-ascii?Q?bBRiTufTIyi/EY9ayXhNBJjJidaH+VcvngiJLi5HQVs7Mum7UdT4O/NUnO1H?=
 =?us-ascii?Q?lyT5W3Pt0T30p735EqdQBJXhhyWYF0jELZC3RkWOibc99vxB4M9qrOdTFBLb?=
 =?us-ascii?Q?B9BL9EXytbc52J1cDzK54Dn5GH6IbEvyF6/8yDbgicrKEeHfSyAEQoY9jgrn?=
 =?us-ascii?Q?dWxIUSx1bPPKcrap7cch/ye05s94Z6nIOQEBXBVjMp0A1z4xpheY3q+QJsP4?=
 =?us-ascii?Q?BFbDucVnml0JJKtDoZB/wKj2VCIK6BHXa1jP6evZmDBlVB+ABYXu/3Yjcb4t?=
 =?us-ascii?Q?92yMYgRUET+PuVDIx8YQje7EFATjqJjWeUvw+4GefTou2ijK73RlNDL5iKC1?=
 =?us-ascii?Q?YVnb2n75kH5tcaUXLGlMPVzM37SUuVmQorq0/QqVnf0OxDsqcROJe5tDJbhi?=
 =?us-ascii?Q?e/ejLdQePgz3QOE4+LBk2v8gNxtDlJDszK5OZ3aW3n0RO15j+c/R+Hm032R6?=
 =?us-ascii?Q?F+8UdOF7y87fE1OQxtdTAw7wCOHDRUndBo4tW3ai7ySMOwbPOgM4bZIbljs3?=
 =?us-ascii?Q?5PZyO11KUF/EmD2XJf4Vxuwzvt8U6afWq/aMrQYZP4vLz63ZazgnnVyQ7M5h?=
 =?us-ascii?Q?hde9V+A26LUkGIOBnwvosBVUBDMOme810+QMjZ4lJYgjoXPJgWkiMGZbS75y?=
 =?us-ascii?Q?7qe0f9fmPrjQKDwW8FOnkA19jx++txLQZKS+8V20v86PpAWkqaaGwwGhn0ud?=
 =?us-ascii?Q?PmjVTUg+GvuX2CSlX8MJm/2Imp4vOlU/kyByXsNdfFc1Yh+1PTvEqPy2Z20C?=
 =?us-ascii?Q?W8kjhBbdgLWDIKl0aW4/SKC8z/Hbsk1LU0kqQBez38yrA7vYAjCoLY99vo0w?=
 =?us-ascii?Q?dYJHV33jO5tBLqBXctHPC/416UD3alwqtP9pwjZq8Yx2j9x/a6iwpNtbAb2M?=
 =?us-ascii?Q?ywCkH5a7lkBFHh1P+AY63FMmetTdD//FMbBy200H0QLkqVMtNguZMlqjdJbT?=
 =?us-ascii?Q?NDZ2/jDZWbYnK1r2sXJoysZg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fd33a3-71bb-4146-4ae2-08d96da4ebec
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 00:02:15.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKFQcDcErdncgJ8r73OnPM/RUk7gpK3VcJ0AVfq0BTQvNa9BSTzu2C8pLAgcjSV2Q3b8JGZAakbaeO7wVFbWLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109010142
X-Proofpoint-GUID: rQsZl1CEoPs-Yff_08Ibe7i9Dq7tP4Te
X-Proofpoint-ORIG-GUID: rQsZl1CEoPs-Yff_08Ibe7i9Dq7tP4Te
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To print a stack entries, users of stackdepot, first
use stack_depot_fetch to get a list of stack entries
and then use stack_trace_print to print this list.
Provide a helper in stackdepot to print stack entries
based on stackdepot handle.
Also change above mentioned users to use this helper.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/stackdepot.h |  2 ++
 lib/stackdepot.c           | 17 +++++++++++++++++
 mm/kasan/report.c          | 15 +++------------
 mm/page_owner.c            | 13 ++++---------
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 6bb4bc1a5f54..d77a30543dd4 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -19,6 +19,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
+void stack_depot_print(depot_stack_handle_t stack);
+
 unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
 
 #ifdef CONFIG_STACKDEPOT
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 67439c082490..873aeb152f52 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -214,6 +214,23 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
 	return NULL;
 }
 
+/**
+ * stack_depot_print - print stack entries from a depot
+ *
+ * @handle:		Stack depot handle which was returned from
+ *			stack_depot_save().
+ *
+ */
+void stack_depot_print(depot_stack_handle_t stack)
+{
+	unsigned long *entries;
+	unsigned int nr_entries;
+
+	nr_entries = stack_depot_fetch(stack, &entries);
+	stack_trace_print(entries, nr_entries, 0);
+}
+EXPORT_SYMBOL_GPL(stack_depot_print);
+
 /**
  * stack_depot_fetch - Fetch stack entries from a depot
  *
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 884a950c7026..3239fd8f8747 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -132,20 +132,11 @@ static void end_report(unsigned long *flags, unsigned long addr)
 	kasan_enable_current();
 }
 
-static void print_stack(depot_stack_handle_t stack)
-{
-	unsigned long *entries;
-	unsigned int nr_entries;
-
-	nr_entries = stack_depot_fetch(stack, &entries);
-	stack_trace_print(entries, nr_entries, 0);
-}
-
 static void print_track(struct kasan_track *track, const char *prefix)
 {
 	pr_err("%s by task %u:\n", prefix, track->pid);
 	if (track->stack) {
-		print_stack(track->stack);
+		stack_depot_print(track->stack);
 	} else {
 		pr_err("(stack is not available)\n");
 	}
@@ -214,12 +205,12 @@ static void describe_object_stacks(struct kmem_cache *cache, void *object,
 		return;
 	if (alloc_meta->aux_stack[0]) {
 		pr_err("Last potentially related work creation:\n");
-		print_stack(alloc_meta->aux_stack[0]);
+		stack_depot_print(alloc_meta->aux_stack[0]);
 		pr_err("\n");
 	}
 	if (alloc_meta->aux_stack[1]) {
 		pr_err("Second to last potentially related work creation:\n");
-		print_stack(alloc_meta->aux_stack[1]);
+		stack_depot_print(alloc_meta->aux_stack[1]);
 		pr_err("\n");
 	}
 #endif
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d24ed221357c..7918770c2b2b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -394,8 +394,6 @@ void __dump_page_owner(const struct page *page)
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
 	depot_stack_handle_t handle;
-	unsigned long *entries;
-	unsigned int nr_entries;
 	gfp_t gfp_mask;
 	int mt;
 
@@ -423,20 +421,17 @@ void __dump_page_owner(const struct page *page)
 		 page_owner->pid, page_owner->ts_nsec, page_owner->free_ts_nsec);
 
 	handle = READ_ONCE(page_owner->handle);
-	if (!handle) {
+	if (!handle)
 		pr_alert("page_owner allocation stack trace missing\n");
-	} else {
-		nr_entries = stack_depot_fetch(handle, &entries);
-		stack_trace_print(entries, nr_entries, 0);
-	}
+	else
+		stack_depot_print(handle);
 
 	handle = READ_ONCE(page_owner->free_handle);
 	if (!handle) {
 		pr_alert("page_owner free stack trace missing\n");
 	} else {
-		nr_entries = stack_depot_fetch(handle, &entries);
 		pr_alert("page last free stack trace:\n");
-		stack_trace_print(entries, nr_entries, 0);
+		stack_depot_print(handle);
 	}
 
 	if (page_owner->last_migrate_reason != -1)
-- 
2.30.2

