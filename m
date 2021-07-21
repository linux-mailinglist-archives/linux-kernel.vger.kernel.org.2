Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494753D1A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGUWZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:25:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41752 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230433AbhGUWZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:19 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMvacR031904;
        Wed, 21 Jul 2021 23:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=T7aTzh/od8/z0na96515K7P39K5dkQ+t5If8qBwYzOo=;
 b=l2DgWEUGsDftZi2+AvHeAXZ0GlFmkXdr7x2qivj9sFrKGbQTEEzSkx5QxFwIcKJ1Pd2u
 iIbVeYYwWpFXiwlBl1lTD6HbctyggALYr9X71KxRmE/qZztSWZmgEhqh3uVIjCDu820P
 XNcswRvdv2f+jgJLngnWTd73l80AXkk+Rh40Hfip1FfZxGNuyXgjv174/7NPcaUe29Zp
 N8fOqh2r9dYt+4KdjPUHdQdvnb3Q9k+6ciaRaPfVgSejKJisPZJDqDwtsb7J+4okf9dD
 FyAUCW0v/HFzI3uS07W4iRMfOmy0oQb7JVcalB2sED4SRIh9IMO9G5VPDN5LYo6kW8U2 TQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=T7aTzh/od8/z0na96515K7P39K5dkQ+t5If8qBwYzOo=;
 b=y2B8ZyqN2z2z+Bx72kQc2gowmGMMUmnGWGKvWKtcw+1vFR+4Nbrf/2/SyfuTmJEputNo
 MA8dzUesXd7IP7yOHKpKXFYMyyNkT2lFFJwsyEivJqnz0MnM3mIKcytYOq+uhRVxBHVl
 GKLZLamgvyXJitC3CioEJKrhxZGSM3wqRtfPL0SJVNEjnvn/fUQfz3mRSleA+y6Xrw5B
 /4lad5cmFJ6EZeGMUt/LzTUAPcYsMbIxWlY/VBAGxKsifmZKmB9yRqSD/pDs1Xs1kjl1
 8nrH7rlRQvMs4zQG2rQWm/MMl+M+pGFeQrD55DkdYoiHaf+MZd4BnccMeOysLKwI/ZYM PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39wwmtuxqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LN5OwM103297;
        Wed, 21 Jul 2021 23:05:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by aserp3030.oracle.com with ESMTP id 39wunmv2mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk6LEmq6skipAO7lyZPV3T15RcBrOAEifWI4QN+POSMklnp1b98FGmoTKgSYSag7+awa6IX691h0CxKILJCUbggR8DBMWnoio4Hn77kSVlPwns6z80rZKq8pUN63f3EFeK1fCWBd4hMkhwsOLoJaSlgSzBbwOy7/SYG0Kdi4puogtm99l3jj18IDKGdAkxbHzfbmZ2wgekNpNELmQIzPCzibZfy55CQS12GFJG+cmidSMrOP5DXRwjD8zNETnh+MduTOWw+i2jfvISBqwsgRm7+dks+wMi6Epx47CD8Rvm+aHiS1NUWc0L9yxocOmqM+ZRrS0/r/hDmVmulmieFBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7aTzh/od8/z0na96515K7P39K5dkQ+t5If8qBwYzOo=;
 b=MajbTL3/NBPKqR0u9+SZwWXB64bFBLp4vvdBcQFR/kfQECxjEgb1xwSeD1q56hEJlKGeHIF4rRbNSKyVK4M3zrm81UTIIyfg16ClkNdQ0ADslmVlXhE2Y1XIydHiTjL8N3HzAly9Q9JbdQ4p0GzzyHx1BzMYNxoXPE60344L9voY3bKzfyVM41K+s1+14IvH7+nQXEF9PsInFdTqOfJPJRXsLjdEdNIRgmv6MwSceZau20zDOGrU0q/5Q50VhhforRXOgPZ2cwXYYIOUJzgNCTP6NseJt45fsV6VcobZlgZk6EcNYpEgRNF7YiBnd0LgTcrtCrcsmDhfravJL/Ereg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7aTzh/od8/z0na96515K7P39K5dkQ+t5If8qBwYzOo=;
 b=T+K+dX3+OMjox3JWLan0iaN3YS/B6TI44IX+wXSbrxm7ttXcu2zcPfzGmJbTSDZTYupPdtBdH8iOhcezI2k53CXbNzfgeN+7Y6LPqM1oTGMsF06GP6gRZjeM9fn0GtGvAsbXpmTMLlnhNgb+CsT6fy7+ok/6EW3ahfkuD74wqXU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 23:05:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 23:05:32 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 5/8] hugetlb: document the demote sysfs interfaces
Date:   Wed, 21 Jul 2021 16:05:08 -0700
Message-Id: <20210721230511.201823-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721230511.201823-1-mike.kravetz@oracle.com>
References: <20210721230511.201823-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:05:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91539aab-2700-47df-b3ac-08d94c9c0a4b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3735B49F5021E0F54400C694E2E39@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWrHud3LUDXWF5QOGbZkp2ega3iSG7YPU/edzIA0TQOinnDUdAG+jzKAGY+ZxjWEi7qmKyyYUdzJVdL/b+gC0lEMZuqv8xVS8Kcaj9S+ZWnHYv5Q/6Xlw5ZdhvUF1/SEjOp/msoFcn29JpdOFZFuvRWtpWROZg9ZnfeVa2zsqhMzeJwMppAxkdDEJXflGFgaoNSv8JWx5nCjpjj4yIHK5q+8kfVOFEBkP1YI98eosya+0AUgLJqgLedFHSLA/oZcoBYiuZPPCzNbbNrCFCwYMQts5ffCiMA441eeDiiPDZ/82HayyQgFlr0RzQC4vjdGgDLaeJZp4KD+ocIJBQIrzP9CDIXKEYtmUUWM+1gJBxoPOqWawGzKY3v9p4dnLVBZTVe/ioZo2lpBGroEhw1KcvhDs4iqJ9NF5J4xhyhqQC/M8kGuJkra9ssMQvDYCY3SgQeo34l0P0QBj6gMMJiuBbLnvRFCCNfu3Y42Th/X7e8XPbQLgRjZxqI3LJfdISphozWLNzoQtr5ifDh2J8xucmSblZGb4GSXBFwLEkexcuQBOWJWtYIqgNbQ49YPLWe9gDda89TqVzY6bDBtNee7P+NR7OmhOwt3QXR+xJ6jvR82+k2wK+c7rbKlMhq245c79zTXKWsR1TkHdMu+mtzO1Bh0r8Yj3lZBd8lQiZ2yQ4yMITfENwvOXFVBqnviC5izDJJz4eGFNKwGo4mEqcYVcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(66556008)(478600001)(52116002)(86362001)(2616005)(107886003)(8936002)(5660300002)(1076003)(4326008)(6486002)(2906002)(66946007)(66476007)(956004)(6666004)(26005)(316002)(38350700002)(38100700002)(7416002)(36756003)(83380400001)(7696005)(54906003)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ITnFFS1lmTO5fZvXzuxZIVw+aNyPb4WiW0NYUOK/qhXUqGKq8A7Cuoff5+2L?=
 =?us-ascii?Q?I9O0DwbvFRw0bl/e1XVv1/R4lg3fYyv47RVJg839CMnxG7nONaHA5SloKjX1?=
 =?us-ascii?Q?jefQ0D/HVDJ4xW2v7K8XaZW2qqA8uBvyJ9p8mwXaFRFv2JGOSJFaw/GHdOfz?=
 =?us-ascii?Q?/u4xjr/ArfUsAWZW5Fw93KRbeQwzELIAyIwnJk67FuhvzTpKYkqJHkba7s3j?=
 =?us-ascii?Q?AowxjHCqoxKxpgkMrmcbF64sTXD2Ylub47xFmnHHS5TXQfHkTjYYod8Zc1KZ?=
 =?us-ascii?Q?/3lGSjKW192NGSBA6napIrSqiLUKnvCIE66SWSM96B+fgVflBrmaHrbekaCn?=
 =?us-ascii?Q?JmRBqabXov3eVJOvtxAsRZmj0xlU5pNgXIHCFvfW2UFZnZitMPrwqu7D0fnh?=
 =?us-ascii?Q?sTu13k99M3YGAeezySxFVB9Ns3sVqxhfKQ7zGdVqEZeEKQIhs+ZasbiZjGht?=
 =?us-ascii?Q?5+mYjWOaS2txG4M39q8IhUWSIrCidBFKn6F3tTJVjPjOe7O/28LAmi8WvQF1?=
 =?us-ascii?Q?sLBcGYoLY6X3cV3oi6fiuFuQxyn//3GUgxTycEl31EYc0hLE6AsxkYKaFwUQ?=
 =?us-ascii?Q?qK3RdTNOfyj2WPXSC+LN5kri8y5ZHPjoQPIbLy0vmt86VYSgv4s5iKyi/PC8?=
 =?us-ascii?Q?wbZfIJY0tTo6LHW+0HKzUuvydNbiUXuD0Itz8AKw/FnM5lWccKbZkRRBNcsY?=
 =?us-ascii?Q?q5W+SyRgccVxotbFfKiuzjcnimJrs6sTnXsJ7lmrT8MXhw96A9/DaBHs4I3u?=
 =?us-ascii?Q?tKCvj2SbZ2c1Hsq6MEJ3qJPto3bqm01gMNRCRN+234ow+Xmht2anksCAA2/U?=
 =?us-ascii?Q?cE2bd/6fJPRb8mYGg9s/8viGX/1MD8FtgkWbSYnLAUITQnV2T9wt3brNQjgj?=
 =?us-ascii?Q?ThNbrewH4ork80GS/XO2K9skR5FtyNPSgbjlGHw2ZREjl+3gV0+utszPPiXD?=
 =?us-ascii?Q?65wO6DuJ7Vxi6bS/XwCSmEjMB9xBJ36Nn4kqa1tu1rEZAxYd+XkNqZxfNjJL?=
 =?us-ascii?Q?gML+v2Gei9NGkgcVj/DdWVqYm7tBkORV17He6BgNDY5R0Pb3talYh5QlLc8k?=
 =?us-ascii?Q?W5UY/bmaLsF69H/O41byMvjywKQAVJAWCBzJyC0yTctt5HUI1uWLGnIDJYRk?=
 =?us-ascii?Q?H0IYaLY3Jm3mqxUneby/BE9T6GZEZJy89QzWOSN9QzaKX5Bvv80uIJuYJKVK?=
 =?us-ascii?Q?gYxqVtjKdLIK5/EHrHMQ+4LQynv4l28CgOkfdT3W6/v6JxiIe57EMOwOlxOc?=
 =?us-ascii?Q?SeTlNxw9vffVyiUbCHhiV11BbtH+ugri7AH/CSqn7CiJkwlw+Um/8l5RGglc?=
 =?us-ascii?Q?z8ChFe2BcI5wyz2B/TEI5KLv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91539aab-2700-47df-b3ac-08d94c9c0a4b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:05:32.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLzxgg6XlU+8LOF+Pgt5O/YfY/IjLWZsU6l99c/fK8l83wvVvZNSNlfyueb7crODUHrw+JZpmpLE8I26U0T3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210138
X-Proofpoint-ORIG-GUID: IAT_FspoB-uF-p2PsaCpeUZfGz5AJhnP
X-Proofpoint-GUID: IAT_FspoB-uF-p2PsaCpeUZfGz5AJhnP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe demote and demote_size interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst | 29 ++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 8abaeb144e44..902059a0257b 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -234,8 +234,12 @@ will exist, of the form::
 
 	hugepages-${size}kB
 
-Inside each of these directories, the same set of files will exist::
+Inside each of these directories, the set of files contained in ``/proc``
+will exist.  In addition, two additional interfaces for demoting huge
+pages will exist::
 
+        demote
+        demote_size
 	nr_hugepages
 	nr_hugepages_mempolicy
 	nr_overcommit_hugepages
@@ -243,7 +247,28 @@ Inside each of these directories, the same set of files will exist::
 	resv_hugepages
 	surplus_hugepages
 
-which function as described above for the default huge page-sized case.
+The demote interfaces provide the ability to split a huge page into
+smaller huge pages.  For example, the x86 architecture supports both
+1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
+2MB huge pages.  The demote interfaces are:
+
+demote_size
+        is the size of demoted pages.  When a page is demoted a corresponding
+        number of huge pages of demote_size will be created.  For huge pages
+        of the smallest supported size (2MB on x86), demote_size will be the
+        system page size (PAGE_SIZE).  If demote_size is the system page size
+        then demoting a page will simply free the huge page.  demote_size is
+        a read only interface.
+
+demote
+        is used to demote a number of huge pages.  A user with root privileges
+        can write to this file.  It may not be possible to demote the
+        requested number of huge pages.  To determine how many pages were
+        actually demoted, compare the value of nr_hugepages before and after
+        writing to the demote interface.  demote is a write only interface.
+
+The interfaces which are the same as in ``/proc`` function as described
+above for the default huge page-sized case.
 
 .. _mem_policy_and_hp_alloc:
 
-- 
2.31.1

