Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993B8307DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhA1S37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:29:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43016 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhA1S1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:27:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SI3vW2062763;
        Thu, 28 Jan 2021 18:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Hub1Nv0zKeWt8gzEggjV6eYlRfOld2E6fyEdOhT1tic=;
 b=rn/qV1FhfdxRW3JmGinNwpRRrY2fE/0XXPb0xC+SgSuUIDi+R+3rdTPsf+F0sk3DF8rX
 7P/h2+8ez7G9P84nkGL4I0m2HjTUWpSc0wKaSWf2oB0s6/NYZBrLPtuTOIDau8bMz2Nn
 x9dDU1p7o8E05yhcnotb7rPTPJjJvwRTuf8ARNoOtsW/PvXYrMayebBOY0O6A6d1dHSx
 p//QcuiUBBd0ZkboUIdXZeRjP2LbsQN4GnVV38VeUPtIriySKT1YAzUF2bdp/aOQQFu/
 tpwYdykvsM+kHP5fGHOWLDiIRsMkDmQ+UeaNR8yecZO473qJwdvgijoJan24O324UeNP tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 368b7r5m2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 18:26:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SI6G7K053858;
        Thu, 28 Jan 2021 18:26:50 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2059.outbound.protection.outlook.com [104.47.46.59])
        by userp3030.oracle.com with ESMTP id 368wr0qhf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 18:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg/zFMcPOlkTFtw+iFvVHPXkAiQS5kC8QBSAuAh2sbkf+jSlimEkCnsFWOziMULKfaOdhZWIx/zsOeHcW6q9XEjFXvR15SzJe3y8RsoToUQYCIGvijBCUpl5WfsaMXINeuvGJQvA3AUGSaXYRj+OVeRGGegTTedOuZ9CYEb7d2cMOY980n2Xu8QsjtqKIHP4uzukvELmYWrdlbMf7CB6SiccwHs3xcGiND80XFz6VbtSGKqQM1llVeFHqA5o2Q5nV2sHWZ9GbL8ZrE3exdSV+ah0njDWWZ0EYLTczSWwfQ7isgLkGbsVnTRj/LhN+dGsWHlsSXEOdKsbeq5tgWr9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hub1Nv0zKeWt8gzEggjV6eYlRfOld2E6fyEdOhT1tic=;
 b=n65B8ci+dCpFo+SDIEW74VUeurWOdnjHIshjoVjEIIDrXzIZiJqBWfzXVbLGpN8v2xx4Y4EJUUWjrKYs0cneAYLjYh4tyW65ljWEUEnyYyRrvJ/m7SFnRb4/mckuPFgMnijQ0F5hTMFO38/BWtA2WzMnEl6qyA/8t4zk8UUGxMWJIhXgXamx14XImv7vLxU5xoqyUli/4nn/g0MPmNSCJipA/7y/mUYrojy/i64ZrgBd6FOMccP3PGOsdzF9ABxaLSdAUW8Dw3ZLCPEMyqyflqBRCyHIJ3M1u6ESclrJOkWvpnFtK90YKUyClS/qRqKTQze+a9WwMOz2oO49ai6QhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hub1Nv0zKeWt8gzEggjV6eYlRfOld2E6fyEdOhT1tic=;
 b=tZfkC+rDy/LRkyRJ/MSdSQFgdyFm1LfmOKMe2TYb75iMuB8fz79BFdAyidM0k/k0SqSUIeWSznr94yakafq8r8PNrfxkbjzzFxWccszikzWPU1s0j0rN/fk/6ulIaJyyCmVEuOHHE48ZG+7M+sS1Hgn7Cs/dC2ZRrQNJ80V+dFY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2822.namprd10.prod.outlook.com (2603:10b6:a03:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Thu, 28 Jan
 2021 18:26:47 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%6]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 18:26:47 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 1/2] mm/hugetlb: grab head page refcount once for group of subpages
Date:   Thu, 28 Jan 2021 18:26:31 +0000
Message-Id: <20210128182632.24562-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210128182632.24562-1-joao.m.martins@oracle.com>
References: <20210128182632.24562-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::26) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 18:26:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33260b67-91ba-4b30-9482-08d8c3ba4565
X-MS-TrafficTypeDiagnostic: BYAPR10MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB282214C67BBC6B1B0EA23FEDBBBA9@BYAPR10MB2822.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrC8ZfyvHhWd/NU0FWMZFlTRUpPYEQoo9T7nk5hw299LNOWWKFp61upWclrcrnPbAbNhRxDVblTiZp9E7otH5DtW5wgERM4StnlUV7F1eV3h70lbL6MwdzgYEOfk1HilsNAg+skBCvBFa9Y24a7GI7/XoLVsorjlQnTIH8MPMQf8/mFDiC3AOIQzlvNwJzQDTRtOGLz/Kyl0tZ9TjYK1zmK8TZ47x6EBwekEMrDL5ySJsa21wbOX4XxzX+e/6k+riOw2sA/s6erll0xkEKDt12nDFCmkkWyPYbBXc/BQzrKMDqKfxG9cn4Q91m62742PQTNfPXsbm51SL97MDhdjvrdM1QFfoLoUDfDgNRklPtzOzIkUhY2pwpwBQCRbmE0hNXj7HJZUt+EFxrTfNJPJoD0pPyVZgDzmslgP2lb0lY38OEo6hg+GVbmzSOI1VD2Tt66Z2o/f0fKzyam2msDx/1qCyEgCkp5NpbLborBfD9B/517PHf4TiOvh9hwkG3CN0OoVJvq0IPhpABU27Ef2tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(66476007)(6666004)(316002)(66946007)(6486002)(6916009)(956004)(478600001)(8936002)(8676002)(66556008)(52116002)(2616005)(1076003)(7696005)(103116003)(107886003)(86362001)(2906002)(36756003)(186003)(54906003)(4326008)(16526019)(83380400001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ACmJ3Dy5catAR8dZhoEvIzYo4HZQvdM1Ue0uf2WG4NGIEPGjXie1FPvRan8m?=
 =?us-ascii?Q?uxYhQQbpsLQO6CbtFQAakD+JZZSb+3cjMORdqzsVnXNWdxcFlWXovoRk8ov2?=
 =?us-ascii?Q?3bL+yVo96Wx9wpz4rJQj8oWnAG8qh4fnSu5p/dp4IynjZ45EPAQ8u2ALCkvs?=
 =?us-ascii?Q?JTfPkp/1jLhA73wrMMvjLDDgrgeKR/gAklvwmk1nNG42tXrk/3/UMOzqc1fT?=
 =?us-ascii?Q?kTPHRSBTI0q9d1Jo2leRjS0kOP916dUiDC8154vsa5nZ9THi96aWLFLFM7nt?=
 =?us-ascii?Q?jiW53H2qcI1+b9Ny+cSb/sQJQTojsHwttfX5Z3Lx1I04J+DpAjb2kVNcF0FS?=
 =?us-ascii?Q?xgTBXZaMp3ns6eUxg/gxiC0XcfP1c3ump4cNyVrwhdWmUT+btcVyN2Z9LOvJ?=
 =?us-ascii?Q?fStJymARq3++0FvrAFyMBCGW+l/fFWEumhkgUkZHPF/+zx9QrRG4lFLY0Xjm?=
 =?us-ascii?Q?l69DjnAatbjJk2TeEwQvJQLviWwHlFNIDkYDEzEWLhgRbFeXzpmMTLxGdbqW?=
 =?us-ascii?Q?GLeS+lOTDNYxmU4IMZI9+vmOd1n+moRjx3OkN9IMWDxWbf8bbMdYgt8DYln/?=
 =?us-ascii?Q?0U25AIhQZAE6x5Zbaq5Rb2YVRs9pknqnsr/+na+gXN1RkrMbCJ5Q+Ekp3z8X?=
 =?us-ascii?Q?a0HbbZNZYMnh0V7jFLUKzff3DkqGMYKU9t5gjMFMv98oOWSipgs1jrgOHCpJ?=
 =?us-ascii?Q?2c8Z6axU2Tk7ggeCAcNFPZWrwyG49TEA4npCdlgkP6wFkRrY86yN0aP6B/U5?=
 =?us-ascii?Q?YIfhuR4Ydla2KhRsLp4SCTdcOKTdkdoY2O+r6p3Kqd2hjcMX5Vf1cN+twISE?=
 =?us-ascii?Q?4nHOiuYZUWm1qha114lP/aHfRYdmhs/KG2eqPsIA/tKEatHn5aXJlD4msF5w?=
 =?us-ascii?Q?v7Kdlat4je/A9jXk5mkPTGPc/L+/BPHZYnPznC7VmcpPJUiWF1sS/lAXf0MR?=
 =?us-ascii?Q?GYnGdqsXypu1VT5jNo6St4l0f5NSJJy2uJY2vEN8APJr7wt+ctV8WKt+2IhF?=
 =?us-ascii?Q?1qax905IHdWCmfqk9Lxxz3wO9PW6qLKD485r42RnD2KOjTVnFPUupqH5nvOW?=
 =?us-ascii?Q?Qgh8MXvd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33260b67-91ba-4b30-9482-08d8c3ba4565
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 18:26:47.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gbrx1YQGHAxs1G9PR3TO/o0aFYBwycLZp6TbpZq0/xGFC6z2sTP64kOMawnbW97gbHCmKVi5O3ekXqRC5w5Pqj27djTSlQEng3RCry9QwDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2822
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow_hugetlb_page() once it locks the pmd/pud, checks all its
N subpages in a huge page and grabs a reference for each one.
Similar to gup-fast, have follow_hugetlb_page() grab the head
page refcount only after counting all its subpages that are part
of the just faulted huge page.

Consequently we reduce the number of atomics necessary to pin
said huge page, which improves non-fast gup() considerably:

  - 16G with 1G huge page size
  gup_test -f /mnt/huge/file -m 16384 -r 10 -L -S -n 512 -w

PIN_LONGTERM_BENCHMARK: ~87.6k us -> ~12.8k us

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/mm.h |  3 +++
 mm/gup.c           |  5 ++---
 mm/hugetlb.c       | 43 ++++++++++++++++++++++++-------------------
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a5d618d08506..0d793486822b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1182,6 +1182,9 @@ static inline void get_page(struct page *page)
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
+__maybe_unused struct page *try_grab_compound_head(struct page *page, int refs,
+						   unsigned int flags);
+
 
 static inline __must_check bool try_get_page(struct page *page)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 3e086b073624..ecadc80934b2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -79,9 +79,8 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
  * considered failure, and furthermore, a likely bug in the caller, so a warning
  * is also emitted.
  */
-static __maybe_unused struct page *try_grab_compound_head(struct page *page,
-							  int refs,
-							  unsigned int flags)
+__maybe_unused struct page *try_grab_compound_head(struct page *page,
+						   int refs, unsigned int flags)
 {
 	if (flags & FOLL_GET)
 		return try_get_compound_head(page, refs);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a6bad1f686c5..becef936ec21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4798,7 +4798,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long vaddr = *position;
 	unsigned long remainder = *nr_pages;
 	struct hstate *h = hstate_vma(vma);
-	int err = -EFAULT;
+	int err = -EFAULT, refs;
 
 	while (vaddr < vma->vm_end && remainder) {
 		pte_t *pte;
@@ -4918,26 +4918,11 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			continue;
 		}
 
+		refs = 0;
+
 same_page:
-		if (pages) {
+		if (pages)
 			pages[i] = mem_map_offset(page, pfn_offset);
-			/*
-			 * try_grab_page() should always succeed here, because:
-			 * a) we hold the ptl lock, and b) we've just checked
-			 * that the huge page is present in the page tables. If
-			 * the huge page is present, then the tail pages must
-			 * also be present. The ptl prevents the head page and
-			 * tail pages from being rearranged in any way. So this
-			 * page must be available at this point, unless the page
-			 * refcount overflowed:
-			 */
-			if (WARN_ON_ONCE(!try_grab_page(pages[i], flags))) {
-				spin_unlock(ptl);
-				remainder = 0;
-				err = -ENOMEM;
-				break;
-			}
-		}
 
 		if (vmas)
 			vmas[i] = vma;
@@ -4946,6 +4931,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		++pfn_offset;
 		--remainder;
 		++i;
+		++refs;
 		if (vaddr < vma->vm_end && remainder &&
 				pfn_offset < pages_per_huge_page(h)) {
 			/*
@@ -4953,6 +4939,25 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * of this compound page.
 			 */
 			goto same_page;
+		} else if (pages) {
+			/*
+			 * try_grab_compound_head() should always succeed here,
+			 * because: a) we hold the ptl lock, and b) we've just
+			 * checked that the huge page is present in the page
+			 * tables. If the huge page is present, then the tail
+			 * pages must also be present. The ptl prevents the
+			 * head page and tail pages from being rearranged in
+			 * any way. So this page must be available at this
+			 * point, unless the page refcount overflowed:
+			 */
+			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i-1],
+								 refs,
+								 flags))) {
+				spin_unlock(ptl);
+				remainder = 0;
+				err = -ENOMEM;
+				break;
+			}
 		}
 		spin_unlock(ptl);
 	}
-- 
2.17.1

