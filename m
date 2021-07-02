Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8703B9E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhGBJrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:47:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:26891 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhGBJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:47:32 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210702094458epoutp0482734bbe83008e21a688a6d349b2b12d~N8CjalZEg0453804538epoutp044
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 09:44:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210702094458epoutp0482734bbe83008e21a688a6d349b2b12d~N8CjalZEg0453804538epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625219098;
        bh=3SZIm72kfWLDeVLOSrwDonXCeeG3xtRkK7u1eImuk7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlpcmwxhJ8I0Ce5obaAJNzdpwd2ZoqHwpa3WwizUqniiYOZ6WWO9srm0zKpnH/PD/
         ORSTTc2xTdDq0o7d1XQLEDWp5eNvdtuCqaPwKtBbMaj4a86CSC2h93K6FJk7874unH
         aq3ExriFDSNf4L6ZMqWwhbK2ccvJF5zKNadZLUg4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210702094458epcas1p18364e87630d6b7a53996a6789409d194~N8Ci_sJ2o1141111411epcas1p1z;
        Fri,  2 Jul 2021 09:44:58 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GGVYP2R9dz4x9Pv; Fri,  2 Jul
        2021 09:44:57 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.C0.09952.910EED06; Fri,  2 Jul 2021 18:44:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210702094457epcas1p3ddac76bd3cc3e5b93fadb897cdb6dfd0~N8ChxPy8x1686016860epcas1p3I;
        Fri,  2 Jul 2021 09:44:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210702094457epsmtrp141f75960be13b61325e8107b73acd749~N8Chwgqa92300123001epsmtrp1N;
        Fri,  2 Jul 2021 09:44:57 +0000 (GMT)
X-AuditID: b6c32a35-45dff700000026e0-85-60dee019e713
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.E8.08394.810EED06; Fri,  2 Jul 2021 18:44:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210702094456epsmtip1bf2625fe867ff34f8d2cadf461e0d9dd~N8ChjjQiA1051310513epsmtip1s;
        Fri,  2 Jul 2021 09:44:56 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: sparse: pass section_nr to section_mark_present
Date:   Fri,  2 Jul 2021 18:41:30 +0900
Message-Id: <20210702094132.6276-2-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210702094132.6276-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmga7kg3sJBsfPC1jMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORm3G2axF/zjq3hyZjZ7A+N2ni5GDg4JAROJ
        Y3MLuxi5OIQEdjBK/Nk0gRnC+cQocfPqBiYI5xujxMzbC1i6GDnBOvqvTmKFSOxllJjQvJcJ
        ruXw/0fMIFVsAtoS+3tPgNkiAtESs692MIHYzAIFEg39n8AmCQt4SMy7uwAsziKgKnFy+h+w
        OK+AtcTDhhaobfISqzccAJvDKWAjcaJzL9hmCYG37BLN/5YyQhS5SPSufc4GYQtLvDq+hR3C
        lpJ42d/GDtHQzyhxqG87VPcERon1XY3skCCwl3h/yQLEZBbQlFi/Sx+iV1Fi5++5jBBH80m8
        +9rDClHNK9HRJgRhqkos++0BUS0t0Tf9MtQFHhJXD6xgg4QJ0NYVy/eyTGCUm4WwYAEj4ypG
        sdSC4tz01GLDAkPkGNvECE5+WqY7GCe+/aB3iJGJg/EQowQHs5IIb+i8ewlCvCmJlVWpRfnx
        RaU5qcWHGE2BgTeRWUo0OR+YfvNK4g1NjYyNjS1MzMzNTI2VxHl3sh1KEBJITyxJzU5NLUgt
        gulj4uCUamCKsrT7HuzukpPsuyFFzO5fnEP0h8+P5b50+bdKb+d6JyE3U1u39ddlzqqsnBVH
        W1efc7nDqNiZM/lo8Xmdvueqd9eeyRL0Du3ZuL+pfu+P3wXmBdULf+2r5Zwtv+m1nEJmzXyv
        BRa5jZ77A+tYkiNiv9rqrlmyPGrhvaTCZV+ElRZcXzTN8PSVSoN7Eo4StsdmR73jsmlcYMa3
        l4Gloi9F8cFdZ8645qhFy/z2xbNuvKzEGCnEY3nZ50iOV/jL6ZKT69zZe3byVzy8qZO0a/s0
        n0CPQ8JMAV+PBvMtu5j8J1gp+VSl/pqfgpKvE2dbKXD+bLujE3a8cibD+8j6GSFBFV2Sb2tl
        5iXbLs5frcRSnJFoqMVcVJwIANGNCnYHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnK7Eg3sJBn9XWVjMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOKC6blNSczLLUIn27BK6M2w2z2Av+8VU8OTOb
        vYFxO08XIyeHhICJRP/VSawgtpDAbkaJjUcSIeLSEk9f7GLpYuQAsoUlDh8u7mLkAir5wChx
        Yel5ZpAaNgFtif29J5hBakQE4iXmX2MHCTMLlElcXfkXbKSwgIfEvLsLmEBsFgFViZPT/7CA
        2LwC1hIPG1pYIFbJS6zecABsJKeAjcSJzr1Q51hLfN59nH0CI98CRoZVjJKpBcW56bnFhgWG
        eanlesWJucWleel6yfm5mxjB4amluYNx+6oPeocYmTgYDzFKcDArifCGzruXIMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAMTR/KH8OCjMbWbZ5YtPz2z
        XvO+N3t4yvejVpPftz5Rfp/Ww51lKli9YBXPUxb7pKtf47be0jXc7n7hTbCR14TSxFnHVydt
        X9aks7DgRYaxzNqdT1WYV337fr5x27Xwx6oMq569m7e2dOEdlQXsV0XPpNwzPrvMZafF4yCF
        I5/0olhTZGSWrFp76b2pW1/Fq3oO9y/iQjJ3GiO+ndhWcH62t9uGIv62qC0OJWW6LZvyIlPP
        bbhsfEi16WDQNxWNzakSxhJ1lep/Ly/tcdkV4nicbfFjDiuZmfI6rvPmJCVLiCQs6RYwNuuT
        dw8MUY49fjPvxVL23elRxkaTMiXYPm7/WSZxXCGpXkzd79yvBUlKLMUZiYZazEXFiQA4kWtz
        vgIAAA==
X-CMS-MailID: 20210702094457epcas1p3ddac76bd3cc3e5b93fadb897cdb6dfd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210702094457epcas1p3ddac76bd3cc3e5b93fadb897cdb6dfd0
References: <20210702094132.6276-1-ohoono.kwon@samsung.com>
        <CGME20210702094457epcas1p3ddac76bd3cc3e5b93fadb897cdb6dfd0@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
mem_section to section_nr could be costly since it iterates all
section roots to check if the given mem_section is in its range.

On the other hand, __nr_to_section() which converts section_nr to
mem_section can be done in O(1).

Let's pass section_nr instead of mem_section ptr to
section_mark_present() in order to reduce needless iterations.

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
---
 mm/sparse.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 55c18aff3e42..4a2700e9a65f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -186,13 +186,14 @@ void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
  * those loops early.
  */
 unsigned long __highest_present_section_nr;
-static void section_mark_present(struct mem_section *ms)
+static void section_mark_present(unsigned long section_nr)
 {
-	unsigned long section_nr = __section_nr(ms);
+	struct mem_section *ms;
 
 	if (section_nr > __highest_present_section_nr)
 		__highest_present_section_nr = section_nr;
 
+	ms = __nr_to_section(section_nr);
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
 
@@ -279,7 +280,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
 		if (!ms->section_mem_map) {
 			ms->section_mem_map = sparse_encode_early_nid(nid) |
 							SECTION_IS_ONLINE;
-			section_mark_present(ms);
+			section_mark_present(section);
 		}
 	}
 }
@@ -933,7 +934,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 
 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
-	section_mark_present(ms);
+	section_mark_present(section_nr);
 
 	/* Align memmap to section boundary in the subsection case */
 	if (section_nr_to_pfn(section_nr) != start_pfn)
-- 
2.17.1

