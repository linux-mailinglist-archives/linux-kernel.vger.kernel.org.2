Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1BC364F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 02:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhDTA3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 20:29:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44860 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhDTA3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 20:29:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13K09epb117650;
        Tue, 20 Apr 2021 00:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=9t6bQx3hf7y0KK+9Uvks+T9TuczIZIoFk/3d3Hqt1mQ=;
 b=s6PRllgewqnWV/laNG4SX3qSm+3Obo/wQ4Z7JUXNitbzWrqDVMyfq2kdCfOY6twfO+mn
 YL70K8RZzeTH0AZEDoQNTlP/LsGP96tYBDRHm5uzr87MJ5KnMXDDXG6+Kp6oIwrF2d7m
 kpB1n4GrLLhhhv8MrGVuJg5YxHtiwFx1TKnFw6xLkC5wetSGrbb/R0l2P3IDER/RGZha
 k5bGhvz/6sukEA3xXy/PgSCrgQ+zcD11U185XUKxBNuGZpVZ6SEwNaI9SX7rlKKb4rAT
 w0DTwTiZnt40LAwFIk/E9KWCqiOv/B3/1kpemduTJUzU8cdQJ8KPVZrrMa9QXFzcMwmo HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37yqmndefc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 00:28:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13K0AqFk170649;
        Tue, 20 Apr 2021 00:28:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3030.oracle.com with ESMTP id 38098pd7q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 00:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6suEVG2d5zcpZJEoqY6sOw/9Pis2A4yHhmFivu1Jv7I6uzJQCZpX3YhdoXSWlRkw591/cmLh4wOlS4tvrfVEz8Rvb3YdyJkuPFWYSR1osx5sqVBUrzsQfIYUbT2YXdI+ffbEVcbZyllhgtu6lA/RTTZ4kfwJRC1bA4oy8UuReLaWKytbYifmDFQiDufKs1PKPyU7IKtAtAogcPoneDlZjjRqU2OoQWFXtGXVn3tK8ALDG1a6sKxJ+2eqshb5aT5yTDPfXcHjGiKmmnhhUd8/pAHeW37e/ehPezEZ2kg+iuhpv1tQjpW3O4n7YscZfCBT7/IQy0tfiEwYGRVXkdInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t6bQx3hf7y0KK+9Uvks+T9TuczIZIoFk/3d3Hqt1mQ=;
 b=iHNU5jyYSSLCvmeOrb7sRXBT78+4cC8z/6UWiIELyKkTV8E9GE9VPWwEGvYNNZfH5xAyDXOXRs+QtU6v18czIPMcC30KATrF6FPE39YulhBPzNkb6mCCdfEKLD9EMoGlNCgtQPxqqIT+UYmjq3sgyWQLtRHbv09ZSIFp7vlXp8kkLTs57xVzWbhnSNSmJGMzVv5pVYx6uzjZtorVy4/IlHn3EEmCQQlVE6rJzsCalRltm30iBNHqh22AiikEhaB4ce+yvSNfwb7+417Ytf0UWRyTmigBBXMqpv4RIE76yuH+rx3/8rm5u0tI87BNbjeGCa0kj2bxBjV8WXFAgfzmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t6bQx3hf7y0KK+9Uvks+T9TuczIZIoFk/3d3Hqt1mQ=;
 b=mKE+KcGU8Se0ltZYS6dPLGtIQU9tgeBmFRFh5dHElKI0SkQcGG9SNTMWj4frY6K0eFouZMvzkCkTQKcORS4bARikinNnSEE1W2uXkY+qFU3aclOXTARe0IW9OkC7SxGjWRKENX04034/kHBzqz3SdhINWi2gk/PLidBkPwdEHCo=
Authentication-Results: nec.com; dkim=none (message not signed)
 header.d=none;nec.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3416.namprd10.prod.outlook.com (2603:10b6:a03:156::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 00:28:27 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::60a0:4ffb:bc59:7a90]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::60a0:4ffb:bc59:7a90%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 00:28:27 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     naoya.horiguchi@nec.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jane Chu <jane.chu@oracle.com>
Subject: [PATCH] mm/memory-failure: unecessary amount of unmapping
Date:   Mon, 19 Apr 2021 18:28:21 -0600
Message-Id: <20210420002821.2749748-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-Originating-IP: [129.157.69.51]
X-ClientProxiedBy: BYAPR07CA0051.namprd07.prod.outlook.com
 (2603:10b6:a03:60::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-16.us.oracle.com (129.157.69.51) by BYAPR07CA0051.namprd07.prod.outlook.com (2603:10b6:a03:60::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 00:28:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e20b6666-65aa-4a4c-a0fb-08d903933753
X-MS-TrafficTypeDiagnostic: BYAPR10MB3416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3416E14D0C8783B7B8853151F3489@BYAPR10MB3416.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TB+y5LjNRPWw+6KV3YeQE/I+FIOUHZ8yNdXBBPvCw+QcBssPxSvNYIRY7LtbYC7S83R2JWp2BTUNA1NzLzLCn6eLKDejRk5opTvvNVJ659XTDrmKsHChXi52VW1K5b1gHiipn/8FrLdglLDpmMHQm4SSZTn76ji7G0E4+nZxmn4jIGcly63+mTAisgJWz5Gg4jerRsbsJVsz3Mjpv2v1awJ1bd0+gGe5WOZXViwW/IpsMd1HHTxrNaQmwi9Ddc+wzQTuHmT9tFrkH1nwOHc3nA7DG24pjNKSubcS50CGwIPXYyZPCysvFSLZBi14mMwSKR+i0IA6btmhUzM0Ll1Vo9ybIzWi1H1QuJpSEZ8p61cnZicMafmLwIP1s2lLhw8So4gj62vUHHVIhBoacV6ohdun5ic9Qpe7LMKkSLb2LKx0rXU4AUj6dxNk04B+pXGDVSZtWE0fxsGV/a2RQu1VkuFE0hEpdjwlc3dqD9fEqnUNVlQz5Vn6Db8HctCgBHpmhCh68PhoZTvZnYzLv1irEcVwEt2SRHB4ugDYoLy2EaAYj0CUZPMiJ584A7D1gWzXn7hJdhTSSl9SBi97uGXN/boUoF9clmHYjv5GYUTrHI2vlLKoBVBTe3s1HelXMh50fW0kzEA+0VR9FfczS7xuCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(316002)(107886003)(38100700002)(5660300002)(956004)(66946007)(6486002)(6666004)(478600001)(16526019)(1076003)(4326008)(186003)(4744005)(8676002)(8936002)(86362001)(83380400001)(38350700002)(26005)(44832011)(2906002)(66476007)(52116002)(66556008)(2616005)(7696005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IbgIflMe/wSw//kkwxOxwiaselNujUc85fsR06AD9NGo3GWaRT0vXudrR95L?=
 =?us-ascii?Q?hKnJr9MKx4woZoEJ1x2MFOd/5pBnKhI6zmELLa8Z1b2R2YExG8BKy96JY8FL?=
 =?us-ascii?Q?DaMqDUEIeOw87tpCUX4jJeNQ+Ld2gDwHm0tLqQJxau/N8dDBlAzV7qr6+X4+?=
 =?us-ascii?Q?e0+esw8MC/uYEwxI1TCN5fYsCVXcYZZdrpCyVCoFErQ/d5gZAnxAKkVglpap?=
 =?us-ascii?Q?RRQ4KWxU8QkLPrSnXLcVsCltfXoUqH1kMwxU5dn999jSy0mWDlYerkTmcarn?=
 =?us-ascii?Q?Y7DenHDaiBkjbIGgPBciE14nNUJ85HV+zHtq8XQVNJPcyXhDz5nFMsKEfeBl?=
 =?us-ascii?Q?VslVnLUwxaEXqjDLuHNDZTicomZ7Od9IsNCfo7EWgSkIOOfegIn0oOfeyK7P?=
 =?us-ascii?Q?GAynIPihA6rVUeYtKI24W6ccPPKwoqL9I7Fe7oURpJnMOhup6Z4vq1Kpw6bj?=
 =?us-ascii?Q?cAAd15PTTFlj85c1jTTiEl0qw+8KFsNhoaWHTNdjPClXFWN/5/gSLcfi+riE?=
 =?us-ascii?Q?rElEZJTXAbAy+VhqsTPDVUSmjCv1EdLCK9nTkV/e/4hg44giJhC6zp7i1uUT?=
 =?us-ascii?Q?dBVejU7GVpSjVaovQG54OUYwxBq7Y1FwWW5NrWBc07sY5DMkshixBTewxkeC?=
 =?us-ascii?Q?sRZ3EnbUCVZeokb54srwmP233YfKy57NcQ495lCyRz49fiisPy47fD8KFBcQ?=
 =?us-ascii?Q?hMEr4RM7iYSBuKHIbCwjsdKH9Tfb4HGRwjARzuDX584ytC6HEkIdrpYZNBPx?=
 =?us-ascii?Q?3kN48qgwc5y+eEYK0My5VlqwG+WoSRVwPhwuwt0WDVW72DLvGpjqMwo0Z443?=
 =?us-ascii?Q?lzlcm09mycppmzcX8aAiey8Uf6MmvbVQ+8+hkgDQQSWIwkgzwpj+CV+o0O+W?=
 =?us-ascii?Q?P8I/uECmBu8Rp95UDI6kvkvTDaRkEst85exe7GmKi6tD6KZ+QLMExrcPCbll?=
 =?us-ascii?Q?yH7kgSLaSKLRuCmtYemFWQr1gvuXd96y2hhjDfc5Z6eU9TMBHnQTth+UieGp?=
 =?us-ascii?Q?dGH1SWE2y5dz7HULp7HbmmTOaWCkMWlxi1bzUb//XngMmvX3ZujdgH4hGRZY?=
 =?us-ascii?Q?+BzSh/k1eBfta0mWbAEKc0QcyRanOKY0w7CatC9adl2PhWMPPIT4Nz2sfVWQ?=
 =?us-ascii?Q?wT8kWEZwAqsE7zXAQMmTi9VuSlfwZ1/knehe3U+F2LTosCTUGF2o0+ZYZ5M5?=
 =?us-ascii?Q?eSyTQZvblqV7t1fn1N2mETUX/smPGRqJmvWh1v71ypq7L4BmPCE3pEmf9oTs?=
 =?us-ascii?Q?M4hh5W2Qv/MSez5g7kQc447gYZRt4J1RPijyd3R/e50BPcdxzxk8tK+E14/V?=
 =?us-ascii?Q?PO1K1sJKuj0m8ep3c89q2ngq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20b6666-65aa-4a4c-a0fb-08d903933753
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 00:28:27.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxrEofmTfSskEqu1zM3RxFcG/2Mj58oXU2L3L+8Gu6lkceKwE8R1SUD8T05Bn4QZzCxT0eB6OJoUxzePPvtnwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3416
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190167
X-Proofpoint-ORIG-GUID: 1aZ5cbkDjMvriyKdUQHd4uNqAyGEEKJR
X-Proofpoint-GUID: 1aZ5cbkDjMvriyKdUQHd4uNqAyGEEKJR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190167
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that unmap_mapping_range() actually takes a 'size' as its
third argument rather than a location, the current calling fashion
causes unecessary amount of unmapping to occur.

Fixes: 6100e34b2526e ("mm, memory_failure: Teach memory_failure() about dev_pagemap pages")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f7ed9559d494..85ad98c00fd9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1368,7 +1368,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		 * communicated in siginfo, see kill_proc()
 		 */
 		start = (page->index << PAGE_SHIFT) & ~(size - 1);
-		unmap_mapping_range(page->mapping, start, start + size, 0);
+		unmap_mapping_range(page->mapping, start, size, 0);
 	}
 	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
 	rc = 0;
-- 
2.18.4

