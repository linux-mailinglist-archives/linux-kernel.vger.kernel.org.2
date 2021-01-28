Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80F307E02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhA1SaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:30:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhA1S1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:27:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SI4ifU103005;
        Thu, 28 Jan 2021 18:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=tqJhKT76NLqh/eyaF2AncboIxMMfNa560RPJSZu10kw=;
 b=MqCn2okMLXDdsmwF4heCq3rMAjFVje50eLogGzk0T0txGJjsYuo1AlDfDSxYVtZ7EawF
 CHB+p5sbEX7FXKCk4Wv1t77rToBQYfnFKGzsPRr6N+9RB7deRTGilveh2w1PNX2u4Okq
 WQXm/tW7pdb573OsQP1PnxakNtjrSxqS1iiwrb+Wi3l1ozV3Tx3womVg4HXzk5Amz6j4
 H6a8/1Vr1H5rbVj20zIbKV91+qHzy8buar7v2S6eKaAJq7mSgrry53ygEz9kTh/DVURa
 QfOjA1f+hQep08JmfpwaI66cXi0Ulptf3B7O/sxKKBDUKZDUG4+dM1gJnu0RrEJiTUtA Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 368brkwh9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 18:26:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SI5CcY003666;
        Thu, 28 Jan 2021 18:26:51 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2059.outbound.protection.outlook.com [104.47.46.59])
        by aserp3030.oracle.com with ESMTP id 368wcr2g19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 18:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR+v5kze92pfcSlId1K6sYyhmgNop1qD8RVyXbvHLd867UR1i4nLHJ762nDFHIZjL3qqd2PjxfbQ9ghYuLnqVGEeaYzg6vBos+7+mEB5PLNuhEINgprNgazgVM4QsZ3cj2UehqTmVTc1mlCcavskjFCzlosowMgm3TfRSQOJer0ScwEP/ANrKDQ5u4HaP5yjLHWdL+RMPxi5EbghPidjKmMzTFG/etibO5BCP24lvtP9v8I1Ecd+h9Vysdv8He1LZ1BkY4GlUQICyR4A93gidoIzbK0G0/Gw6O4q7nf2F6AC/ngFd9k/CFPwRqBzPxYFsad0OgOKoLuO5qz10enSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqJhKT76NLqh/eyaF2AncboIxMMfNa560RPJSZu10kw=;
 b=ItTcgliRsjIdbECyM97uaKN9lEfPNhctS6amB4JMprvjCvOIB2U/FkSEjRfhY3FowH++wkuZtQNg8GW0EWv1IDYYwt1tAvhUWJuTCcJuhY17iDio4pE6/2Dl5ZwEAmof5t9Z1EP8AFqPYz+fJncp4E1J3T3sUqB2vNyi+K3L72FQihaeBYrsCFZ3f5QDZEUyC2lztEdftN/8zg/57YTrWdM64TVSxfIeJUWtr5e2YMyWKlb84qCbDis/Q97RGj/L6JibuJx6K6E4BPQsP8Warqexh9G2j2OATsS9zEWvUpA4JadWwexlU/kfwt5Ru5GFor7xMO4n7spCbrFjiCNnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqJhKT76NLqh/eyaF2AncboIxMMfNa560RPJSZu10kw=;
 b=ucckn1lC+9wQl45xuvincRkxCeIMeQcm+w390mc0rVrj0pySVauXCKuR66bPmjRouc+Jxi+6hTS9yTJCMY5/1F3Q1roZehH2jggvzc4aCKJkPDFY6SALePueS+jkzwqkAy8esD+Md7lJpCOoIFMOgC9VjTZX+gLORsrdCYpnzLE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2822.namprd10.prod.outlook.com (2603:10b6:a03:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Thu, 28 Jan
 2021 18:26:49 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%6]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 18:26:49 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 2/2] mm/hugetlb: refactor subpage recording
Date:   Thu, 28 Jan 2021 18:26:32 +0000
Message-Id: <20210128182632.24562-3-joao.m.martins@oracle.com>
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
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 18:26:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3865b39c-1a2c-4b30-e1b1-08d8c3ba46dc
X-MS-TrafficTypeDiagnostic: BYAPR10MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB28229F5264F292F0F42A2A42BBBA9@BYAPR10MB2822.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7l0Brt8qfwGGTiDFwlm7k/QTLCdwpLxvIaxzq8TkFxOx1dyBP0Z0RmPC6mNpAvuObXnv6DhqXPgJqa9JKqsinOcZ1FcEKH2ybPdN6qkoJFbBlDinQ8KhDzRe43Iet2PKj96cWosPgP5tepVkz1E3FBEYBgteUbhJinDyAXtqutEg791kBgfL8TtCLMbZ3zkaQxauMALjAYpqWToQitFtWkUgyViP4PEApZYdynm7ej3pAFVoPpZm56xKzG6HOipbP64l+1StY6Z/WDITIj8bA9EjNJW57CY4GHt1i6HoZzfo3/BW1cQgEjQsWeWEdAOwgsoWNAsqZsZkk10+si4je6v2bTGwdjkufLu2ew78/z7UQ96RaPuGYmZvQJ4WwT9xBKb2lXUFEz7lmKgyqzoxAjJONEB96dJp//bFycdx4Y0OjdovTw4uzygAjhCIy8bdnBdXfMy6zeVxqik560Wzr8iydqVhYrtcJMlp98QNKWMjgsBcWiAOl/93kKhWoEOFvVhe2OjZ3U/+IiWQzF8FUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(66476007)(6666004)(316002)(66946007)(6486002)(6916009)(956004)(478600001)(8936002)(8676002)(66556008)(52116002)(2616005)(1076003)(7696005)(103116003)(107886003)(86362001)(2906002)(36756003)(186003)(54906003)(4326008)(16526019)(83380400001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jGxSnsK0ED3ZpK3gY0NA+i8jpwe04hPt+kCvu2VuKayhtp31HskHbveudJPe?=
 =?us-ascii?Q?vxsWYQ7L6X7IE6m7wfPsuHMrvVnSnQCkDzlbx4SU1EU18WJf/GbfTQTEdZ+l?=
 =?us-ascii?Q?eZDQ+kQdzpiuuH8tFWX0WofvXBjjAezed23EFlajQfa9abKOe8oSWCKWcmCQ?=
 =?us-ascii?Q?Xg3Q4i2/GOn55f6/WSMNpYGZ9mSggELYxmQzAV45eoPZODBcxeIcZB3qNq9u?=
 =?us-ascii?Q?ar0qAGF/Rxozwi/T1Jr/1NrttQbow7LmsD/RvmA1eRmHdYwz8i3R7ssYsTZ6?=
 =?us-ascii?Q?O76tCkQ9c58qEQEGry5Ew2FuKVfBA7/BokscNUiZ4X4UIn8yoh6DlM/udEQH?=
 =?us-ascii?Q?xqO8AOjy0qnLUBekqjJtn7/OLyROrpUYREhA07L6Ol7ybQWMdTxFonG5pTff?=
 =?us-ascii?Q?zs7b+MTQXhGy+K15bQeE1pwNTB5RxqjM4iACYNa+HF0UJS/IyYTgCZ/dXks8?=
 =?us-ascii?Q?XcI1px5vxTcEFEjdrkYWSuhTLT1cGT83VO7Mww0sXGGsSSbk7noOpDy/Jtqd?=
 =?us-ascii?Q?YWpTa4MQVxcsY+H5ys/SwdPxZh8+Wd2NrzZwVi0QyZT+ySL5m2uJm8XksbA3?=
 =?us-ascii?Q?p/3fvv3eQ4Ogq2/1Kr/J9INfZz/wFgB4Du4Tr8wPfTp77DAfHlJTzcGb34zR?=
 =?us-ascii?Q?X+ES4vjocnV88UdIhfYUrvzyFq8DM571YPXrFJhwrk42m6WGe4rl+sTC9+5U?=
 =?us-ascii?Q?1uWcPkVfAcqyOmw6BkJQRPjrVVl0gT8eGyPYTRwn7vB36gRAE+dsG6mR4QoO?=
 =?us-ascii?Q?hO/+5TBt0m2H2A/YrBzo3weWRL6kmAl7VTTF4mML5wnW5SYjYlD3bO6zerdh?=
 =?us-ascii?Q?irPjucyLGwswloeZfgDiXlP3DhZsO4qGYAsK2mTARtubNZWzv8Ix9KmoFEJ5?=
 =?us-ascii?Q?gbxUDTrPwY1lmbiXmKD1jfdl4LqANXqf8CNM7/X/FbsIh8c8xZCEz90LNZ5u?=
 =?us-ascii?Q?ImVJsJXU7hlOrj9PXLYNfBEiIPJDiOhSbeorNJdeJWr5J7YtY3Fyjsj/MmGL?=
 =?us-ascii?Q?Rv8MqicdwE9aUHldCUc8++15s9uxdHVqrirrC/Smx1dyZhUsMCBQPxaC+s4M?=
 =?us-ascii?Q?3REqkGiw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3865b39c-1a2c-4b30-e1b1-08d8c3ba46dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 18:26:49.5048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bffi/uvGG/BP4aPeXzAv2ZGNXtiD52xSYBUeIgOako9L+/Vb7RjIphU0/MbQL3pZpNtLvOMPTw7kK6LglAhO/RDaWFvqCI9tyMGDkWUnleg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2822
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a given hugepage backing a VA, there's a rather ineficient
loop which is solely responsible for storing subpages in GUP
@pages/@vmas array. For each subpage we check whether it's within
range or size of @pages and keep increment @pfn_offset and a couple
other variables per subpage iteration.

Simplify this logic and minimize the cost of each iteration to just
store the output page/vma. Instead of incrementing number of @refs
iteratively, we do it through pre-calculation of @refs and only
with a tight loop for storing pinned subpages/vmas.

Additionally, retain existing behaviour with using mem_map_offset()
when recording the subpages for configurations that don't have a
contiguous mem_map.

pinning consequently improves bringing us close to
{pin,get}_user_pages_fast:

  - 16G with 1G huge page size
  gup_test -f /mnt/huge/file -m 16384 -r 30 -L -S -n 512 -w

PIN_LONGTERM_BENCHMARK: ~12.8k us -> ~5.8k us
PIN_FAST_BENCHMARK: ~3.7k us

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index becef936ec21..f3baabbda432 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4789,6 +4789,20 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	goto out;
 }
 
+static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
+				 int refs, struct page **pages,
+				 struct vm_area_struct **vmas)
+{
+	int nr;
+
+	for (nr = 0; nr < refs; nr++) {
+		if (likely(pages))
+			pages[nr] = mem_map_offset(page, nr);
+		if (vmas)
+			vmas[nr] = vma;
+	}
+}
+
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
 			 unsigned long *position, unsigned long *nr_pages,
@@ -4918,28 +4932,16 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			continue;
 		}
 
-		refs = 0;
+		refs = min3(pages_per_huge_page(h) - pfn_offset,
+			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
 
-same_page:
-		if (pages)
-			pages[i] = mem_map_offset(page, pfn_offset);
+		if (pages || vmas)
+			record_subpages_vmas(mem_map_offset(page, pfn_offset),
+					     vma, refs,
+					     likely(pages) ? pages + i : NULL,
+					     vmas ? vmas + i : NULL);
 
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		++pfn_offset;
-		--remainder;
-		++i;
-		++refs;
-		if (vaddr < vma->vm_end && remainder &&
-				pfn_offset < pages_per_huge_page(h)) {
-			/*
-			 * We use pfn_offset to avoid touching the pageframes
-			 * of this compound page.
-			 */
-			goto same_page;
-		} else if (pages) {
+		if (pages) {
 			/*
 			 * try_grab_compound_head() should always succeed here,
 			 * because: a) we hold the ptl lock, and b) we've just
@@ -4950,7 +4952,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * any way. So this page must be available at this
 			 * point, unless the page refcount overflowed:
 			 */
-			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i-1],
+			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i],
 								 refs,
 								 flags))) {
 				spin_unlock(ptl);
@@ -4959,6 +4961,11 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				break;
 			}
 		}
+
+		vaddr += (refs << PAGE_SHIFT);
+		remainder -= refs;
+		i += refs;
+
 		spin_unlock(ptl);
 	}
 	*nr_pages = remainder;
-- 
2.17.1

