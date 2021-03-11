Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2538D336A15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 03:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCKCOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 21:14:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56472 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhCKCOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 21:14:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12B25GF5072370;
        Thu, 11 Mar 2021 02:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=2y1yo9Y39hVh8xv54fpFEzyxwyLOgp++lwpX3VnOykI=;
 b=QgH/WOXxtSjkFKsv7ibRJnQm7eMAaJsVdPzCyBCpOLq6hdj5dgoIP3S/ZGugZVhgQIVq
 /cKQ5v7EjvLj7p16EICNm7fiSboQArMORkfhfFB8uQrMiQn1e11oou8YB0KEKA90cq6o
 R9lYro3/OUrSJmkiutyGZqgNUJJM2dfv2M8+5Xj0uXzON8yJyKMAX3gXS85pUdQbpvwy
 ClS0/pzWZyOkkd12NVYtjcNd2dJ6PnsahHDXg39+LGxauI7DSV3fU6sDi6rKsu+uEJ5M
 1RgAuikdO4DwaalfHD7nUxr9InUsInB8OwLvCuWu76tzGi98cxjLbKoBFBq8kjy9CXU/ lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37415rd3xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 02:13:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12B2B6Hw046176;
        Thu, 11 Mar 2021 02:13:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by userp3020.oracle.com with ESMTP id 374kgu7nd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 02:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+hd7fdMeJsud/OGrkNCMkMRPtkHBbDWG0Maaw1N0ni0LeV1PdtWzumjy1kUgJYOhO0tRTH4NqlFlUyTL1NYG0ta/3ho9+brXHxr/CBhEywWMoPL0fvQSkktoehdmpnPZ5XdQ54CKy3bH3da+AbNlgoO4YtMr0XXUhNiNk5FyhUFQ33lqqCdBnhx+0z8+yDqEoqls9RtJFFzPlaYFS0a18i+B/GkK3DwFkqeVSyDK6gqjCaOLB8fX6Hwl7b5ntf8NpU5ZywDqnKSCQmKbt8fjTlIE1YYJeEKyWtpwAL99NizsBcFo+QbmGzaPcWn9d5OwO4OOttM9lqIIqZN+Zi11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y1yo9Y39hVh8xv54fpFEzyxwyLOgp++lwpX3VnOykI=;
 b=aUgivR373LeI4XizBQnX23COREOWfwOzerZEY6HNT/WGNIZC/jKXXr4YgTJZqu05uMNsrANqVw3MfXZ100I8I470n1s2C7qroALk+CCfWDcdJIIxpHD9HtKqVY/xYvBs/3ZgiVwqr/rOMDsalMW0V5ydIh0XlQhi59qQSVSoT9huiYtb7TRRc5iEYDiyyM9Od2u3XqIsdQBdIW9ynRzEICjv7Tr+ISA9j6BkdFDdqGXNhN/56h5BRxtLGERkMpZoibjRY4o4Ve9aPJvLhWn78Du4dqFomMFk5f7XVrE7MkQ+1tESbPWks/nboxu4l3NtG5MSkB+zNbz/F7axRbbAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y1yo9Y39hVh8xv54fpFEzyxwyLOgp++lwpX3VnOykI=;
 b=HYzqUUM3hfMOK4Tr1Rn+ULW+bDVVkLpLHIvNTHENegrPLdbSN7uCR7sfLoCnBOrnz/GQyrOdjS7keT1558KmJFQAl5c0nZmSDmZrQwgn1RgpYlhZyJ3GistVj/tllvzEeRlmX86H/I8WG9WlalZRFa5J3MXpFQKxFCxIeaMRAdg=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4068.namprd10.prod.outlook.com (2603:10b6:a03:1b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 11 Mar
 2021 02:13:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.029; Thu, 11 Mar 2021
 02:13:31 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>, peterz@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for in_atomic use
Date:   Wed, 10 Mar 2021 18:13:21 -0800
Message-Id: <20210311021321.127500-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR21CA0042.namprd21.prod.outlook.com
 (2603:10b6:300:129::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR21CA0042.namprd21.prod.outlook.com (2603:10b6:300:129::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.3 via Frontend Transport; Thu, 11 Mar 2021 02:13:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d2e6e93-ef86-4bff-71c5-08d8e433443f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB406830E8C21097F81FF55BCEE2909@BY5PR10MB4068.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3EgfusQ61tBJDPkq/j/t3UKauYJF5fPeBqoXR83kffOh4x9I+3RUzmmuoTHs4z/0yXiD6P3jp1ZCB5Q/aQ9986R0MEKssWbmCJYy/ANllkW2VX95Ns0dnvrPtDcmoPVMe9+KuVQZqMJrfAJ8JYIpqq0qTryeg8kAsCK1KGfByVb+w9e2DWSg8x0M4jYq6rmD2wZgYXM6+jfxBgQrrAFo36MFqhQS/aZLmNlg2EUWKD/kVmTCbtndVlzTtqTdCjMS1ey5R48E5RxM9+YEm6XpC3cuVHEgv3yXOA9B/nomdCPnrMr0ntkGA1CznwIkjLIwmtUO9p1AR5YV2ClaPNLh9wNn/XGEypHjz/JJCm7Mwf4cFFjeu32C9b/nAhb9Q+rVPK6ZW/gb++ybX+C3aNGEOKyY9P6+apS/QjwmLaUZgiWTb+axeKqwqWEkJlF5Ka4kPaetOPAhL1AvmSrsu4VmnyukpeXYF4byJscJKd7e+Fe+ruSpBt27T3VVIRNHk7Jq8cjTtzQDaqgM5wQf487h++U236oVGT+NSbSPjgwT/dPIl1iaj3UAaY3+5jNJ1C+bn7Ny9eyx6a0uuT1hJc4HxhASXrLhPeiuZnutMD/eE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(39860400002)(346002)(86362001)(6486002)(5660300002)(7696005)(36756003)(52116002)(186003)(1076003)(16526019)(7416002)(66476007)(26005)(66556008)(966005)(54906003)(4326008)(107886003)(83380400001)(66946007)(2616005)(956004)(6666004)(8676002)(8936002)(316002)(478600001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dEDs9tHJhwk6a9+nlgsKSLAf2KSxIu2JMue55hs9QgZHR3KkiWS4twbujY9X?=
 =?us-ascii?Q?GM8oSQGbRXRgCUez/gTrWPHWBgz6pKkfjz6cRQe2IW3LOtZJq/8h6SveNFe0?=
 =?us-ascii?Q?VvXOIH9By+hIbUGgFB2LtlN4WIeZA7c3NLxy+qIHTOPDja9fpkwCg2+Sb850?=
 =?us-ascii?Q?83y7eZ/oCji8liWuEkOaMHkcimyA0ZT4ntoOPwTmcXBUBAb03DafeWGS1T2X?=
 =?us-ascii?Q?8j7LRDknvoniwqGQ6Ro7C7CbWfTIAETlznbJvTIQod6lweB0Vgusib9RifuN?=
 =?us-ascii?Q?hsYSrSNQb/jHd9naDXJ0AdicgsX6+e3BkSJ1gSR21C7i7DNhzKhPYgsgLHQB?=
 =?us-ascii?Q?3kxqUqU8GV3ym4b8E3PjLF0bRfFomO5F+HJ5P9gQegtcTpL2FILySTTj4KJb?=
 =?us-ascii?Q?KFESiIa8/u2X3oF3BLs9p9jlyFFtN3F21stuQecsHDIFlrw/htSl049ocdEz?=
 =?us-ascii?Q?HTkB7x5Fx46yaNlGTL/KH61JckTMUj0EKXzUaxD/gsIatFpfbqj/jXcrH1+i?=
 =?us-ascii?Q?PwNvtLv2IVX/X1UiZGZsQVPdgzoLJY2E3A4arqxGhKi3AeiE2GJH/jkArMLh?=
 =?us-ascii?Q?Zv+1P7UPscDyPKzU8JigkuHW9WJa+BCvU7/fBJCYOosK9u7NAbUb8zKdWoTh?=
 =?us-ascii?Q?x4Nuq2LDcqtwBC5T6gAue7rIuZQVBs1WQS43COAYw+qK4mZtq/jrjDwjwvzX?=
 =?us-ascii?Q?9ZOedIeWvdgGmMOtoiFTDNLcGw1ifWvKTe8MpwD2vIhq865K2/iXuo+5IZTR?=
 =?us-ascii?Q?UYP8BCLMXQWZpTgou5tdvzDzG/TtE0qOoxPVQCspVcxkLEI8+5mIYqYAiJNS?=
 =?us-ascii?Q?sfPhumH/3Wul/LbrMor6+jZV+3mTMDe/fGWeATp15W9m1bpdF1z1gMCJyMv1?=
 =?us-ascii?Q?VXRBgHC4cUJ0IdP0ZMwbCTqil5Pt5opsCZVcJyaopSb0Cr34RzrFbXhWPI0W?=
 =?us-ascii?Q?MRJF9cm5KJ5TL6/Aklts8f3zGoGPqxUCIaPLo5erOJfpUoos0MAvYn+WlLbA?=
 =?us-ascii?Q?m1kS3T3MdjUGQB070R+CQmi4UHBwmfDHQdpF1L4UpGte9m3mZOQOXxtKCd3s?=
 =?us-ascii?Q?F1gpHz2GMWAOJkGviRx5xVvGEnLwxrSdX5lp0gZo4a2useYi1FzpAr3u5dil?=
 =?us-ascii?Q?jHWgByaowUPHA1Sa6HKqF2Gkpsh4LNwMqPMvQXJPy31tXQWEWwRHc+YlSix6?=
 =?us-ascii?Q?UZHOKF0JqVLMboxsygh/JsatvjnKpQhHnSiiSo1rcfhTQG3EKRKUIRk0N3S8?=
 =?us-ascii?Q?Q4hrAtsMKdV6XoDrB76JCgsxmd6R8z4pIbzz3lLGT9fPkDTwymzofZtufLui?=
 =?us-ascii?Q?OcYhLVyxV4a9vaxvFMDGZx9U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2e6e93-ef86-4bff-71c5-08d8e433443f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 02:13:31.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9B3aqw3FYDyRhUTHDOpWtBA2BmrRevutF/5ZUe9FCVKPImEATcYG36CwnE6qeOyYSDzgqw8SA4pgn2K/UL9O2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4068
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103110012
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_page does not correctly handle all calling contexts for hugetlb
pages.  This was recently discussed in the threads [1] and [2].

free_huge_page is the routine called for the final put_page of huegtlb
pages.  Since at least the beginning of git history, free_huge_page has
acquired the hugetlb_lock to move the page to a free list and possibly
perform other processing. When this code was originally written, the
hugetlb_lock should have been made irq safe.

For many years, nobody noticed this situation until lockdep code caught
free_huge_page being called from irq context.  By this time, another
lock (hugetlb subpool) was also taken in the free_huge_page path.  In
addition, hugetlb cgroup code had been added which could hold
hugetlb_lock for a considerable period of time.  Because of this, commit
c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task
context") was added to address the issue of free_huge_page being called
from irq context.  That commit hands off free_huge_page processing to a
workqueue if !in_task.

The !in_task check handles the case of being called from irq context.
However, it does not take into account the case when called with irqs
disabled as in [1].

To complicate matters, functionality has been added to hugetlb
such that free_huge_page may block/sleep in certain situations.  The
hugetlb_lock is of course dropped before potentially blocking.

One way to handle all calling contexts is to have free_huge_page always
send pages to the workqueue for processing.  This idea was briefly
discussed here [3], but has some undesirable side effects.

Ideally, the hugetlb_lock should have been irq safe from the beginning
and any code added to the free_huge_page path should have taken this
into account.  However, this has not happened.  The code today does have
the ability to hand off requests to a workqueue.  It does this for calls
from irq context.  Changing the check in the code from !in_task to
in_atomic would handle the situations when called with irqs disabled.
However, it does not not handle the case when called with a spinlock
held.  This is needed because the code could block/sleep.

Select PREEMPT_COUNT if HUGETLB_PAGE is enabled so that in_atomic can be
used to detect all atomic contexts where sleeping is not possible.

[1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
[2] https://lore.kernel.org/linux-mm/YEjji9oAwHuZaZEt@dhcp22.suse.cz/
[3] https://lore.kernel.org/linux-mm/YDzaAWK41K4gD35V@dhcp22.suse.cz/

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/Kconfig   |  1 +
 mm/hugetlb.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 462253ae483a..403d7a7a619a 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -235,6 +235,7 @@ config HUGETLBFS
 
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
+	select PREEMPT_COUNT
 
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 33b0d8778551..5407e77ca803 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1437,9 +1437,9 @@ static void __free_huge_page(struct page *page)
 }
 
 /*
- * As free_huge_page() can be called from a non-task context, we have
- * to defer the actual freeing in a workqueue to prevent potential
- * hugetlb_lock deadlock.
+ * If free_huge_page() is called from an atomic context, we have to defer
+ * the actual freeing in a workqueue.  This is to prevent possible sleeping
+ * while in atomic and potential hugetlb_lock deadlock.
  *
  * free_hpage_workfn() locklessly retrieves the linked list of pages to
  * be freed and frees them one-by-one. As the page->mapping pointer is
@@ -1467,9 +1467,9 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
 void free_huge_page(struct page *page)
 {
 	/*
-	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
+	 * Defer freeing if in atomic context and sleeping is not allowed
 	 */
-	if (!in_task()) {
+	if (in_atomic()) {
 		/*
 		 * Only call schedule_work() if hpage_freelist is previously
 		 * empty. Otherwise, schedule_work() had been called but the
-- 
2.29.2

