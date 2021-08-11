Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A873E9354
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhHKOLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:11:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231902AbhHKOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:11:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BE31w3037444;
        Wed, 11 Aug 2021 10:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dUKxIJSDOKApYQlXkSoKV4OJ/WGFyoGgyMLFMdjO54o=;
 b=quELoMWgefur2ZOYWb8r83XOCCJhEd62nnp/w8CijaQveGvoL/xS2dkl5Tvm7x/z6eYy
 v1oRodDR7ZGPF2x+sv2CKMhacf6rfc/OhKmAERUMxO7fIa2pzjZLbC3YgcYrLTdsaO5w
 vC7Zd3FKUiV8uHnkwCNopn/ij/Cmx1Yx1x0bodMLW5+iJCpD6q8Hfct1eLQq/5DrZ+lQ
 +L9M3hv6DeoIDBJ1l/AjlrqkVQuatcKraBrOsIp+uWPL66Ls67uocMCqj8LIzxsPUaek
 Fp2abClT7H3tLHO88vBLW+cWTtfse3i7dS5jGnqZ8YNcuNBU99OahVwzPkdKN52jwdAO PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abvtekusj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 10:11:13 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17BE3s9W041379;
        Wed, 11 Aug 2021 10:11:13 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abvtekurd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 10:11:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17BE7j36005828;
        Wed, 11 Aug 2021 14:11:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3a9ht90628-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 14:11:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17BEB87U14287190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 14:11:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34733AE04D;
        Wed, 11 Aug 2021 14:11:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B064AE05D;
        Wed, 11 Aug 2021 14:11:07 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.154.55])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 11 Aug 2021 14:11:07 +0000 (GMT)
Date:   Wed, 11 Aug 2021 17:11:05 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-next: crash in alloc_huge_page()
Message-ID: <YRPaeQYHPwI9r5a/@linux.ibm.com>
References: <846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com>
 <YRM+qm66PfTUQNFL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRM+qm66PfTUQNFL@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oY_pqWWuTXzOrNTlOMeyorEWhc-F3EiB
X-Proofpoint-ORIG-GUID: yXV4swswMghlNMsSqlQCOAdWbZcYiV4H
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_04:2021-08-11,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 04:06:18AM +0100, Matthew Wilcox wrote:
> On Tue, Aug 10, 2021 at 10:22:37PM -0400, Qian Cai wrote:
> > and the page->lru has an address fffffffffffffffc for some reasons. Does it sound like some error code
> > had not been handled properly and had been propagated here instead? I tried reverting a few recent
> > commits for mm/hugetlb.c and mm/memblock.c without luck so far.
> 
> Yes, ff..fc is going to be at offset 8 from the actual address, so
> that's -12 and -12 is ...
> 
> #define ENOMEM          12      /* Out of memory */
> 
> so something's returning ERR_PTR(-ENOMEM) instead of NULL.

page is not initialized in alloc_buddy_huge_page_with_mpol() and after
commit 2cfa8b23744f ("mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many-fix") we have 

	struct page *page;

	...

	if (mpol_is_preferred_many(mpol)) {
		gfp_t gfp = gfp_mask | __GFP_NOWARN;

		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
		page = alloc_surplus_huge_page(h, gfp, nid, nodemask, false);

		/* Fallback to all nodes if page==NULL */
		nodemask = NULL;
	}

	if (!page)
		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false

	mpol_cond_put(mpol);
	return page;

so for !mpol_is_preferred_many() we return an uninitialized variable.

This should fix it:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 008662083fec..6337697f7ee4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2152,7 +2152,7 @@ static
 struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr)
 {
-	struct page *page;
+	struct page *page = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 	int nid;
 
-- 
Sincerely yours,
Mike.
