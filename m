Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B813B928B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhGAN6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:58:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:51484 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhGAN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:58:18 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210701135546epoutp025f0092dfd314697903e3bd8bc6186643~Nr0PLKfCd2858128581epoutp02-
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 13:55:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210701135546epoutp025f0092dfd314697903e3bd8bc6186643~Nr0PLKfCd2858128581epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625147746;
        bh=+JB5+cpQDpLU27pBmFRZ7gFnvJC8IodegInNgepuL3M=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=ImUJbbeuJw+U4MhENSDB4O97nu7GeW8jG2IKESS1nr8qZHSwk4XqkzJxrfWa/PF6B
         zIbPUnwWkzLjDeC/L3Tqooh6ox7yP8Me7YwtcC65lkrsmvidtF88zn2KRixc2d7FG3
         HRLrKQqgHeWtGUcepytbP6Po3ToW9Bez+VXW9D5Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210701135545epcas1p47234258c441803fa23f82b1174a9d320~Nr0Ob6ecF0639606396epcas1p4V;
        Thu,  1 Jul 2021 13:55:45 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GG09D3Y2fz4x9Pr; Thu,  1 Jul
        2021 13:55:44 +0000 (GMT)
X-AuditID: b6c32a35-447ff700000026e0-85-60ddc960918c
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.0F.09952.069CDD06; Thu,  1 Jul 2021 22:55:44 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] mm: sparse: pass section_nr to section_mark_present
Reply-To: ohoono.kwon@samsung.com
Sender: =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
From:   =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210701135543epcms1p84a043bf49757bafada0a773372611d69@epcms1p8>
Date:   Thu, 01 Jul 2021 22:55:43 +0900
X-CMS-MailID: 20210701135543epcms1p84a043bf49757bafada0a773372611d69
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmnm7CybsJBrPmiFnMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORk9dxexFnzmqzh3fyZrA+N6ni5GTg4JAROJ
        vm+NTCC2kMAORok926y7GDk4eAUEJf7uEAYJCwu4SKy69YMZJCwkoCix7bQbRNhKYlrfP7BO
        NgELiedrf7KC2CICSRJL94LYXBzMAmeYJD6/O8YKsYpXYkb7UxYIW1pi+/KtjBC2qMTN1W/Z
        Yez3x+ZDxUUkWu+dZYawBSUe/NwNFZeUuNl2lwVkgYRAP6PE/XUtUM4ERoklTyaxQVSZSzzb
        0MIO8YyvxIUzwSBhFgFVie0XLkEd4SKx8eNrsOOYBeQltr+dA/Yks4CmxPpd+hAlihI7f89l
        hCjhk3j3tQfulx3znjCBlEsAjVz22wPmrb7pl6EO8JDoW3CNFRKygRLPTnQwT2CUn4UI3FlI
        9s5C2LuAkXkVo1hqQXFuemqxYYEhcnRuYgSnTS3THYwT337QO8TIxMF4iFGCg1lJhHfC9LsJ
        QrwpiZVVqUX58UWlOanFhxhNgT6eyCwlmpwPTNx5JfGGpkbGxsYWJmbmZqbGSuK8O9kOJQgJ
        pCeWpGanphakFsH0MXFwSjUwndsjGZHXuzDHNaDqoQHjHH/JfPd/yfWfo48rTUypM6mLu3Qn
        eYb3hs9Ge9duOh7K4/qR6TDDnM2nO3L/T3134lpjrOqOVcd2//BqcvBzfRGjEFFTqy3I+7yd
        1eVyyO9fjXLrTLbGlSyIsrlULP08l1VNPSRN4LLQpyyhKN3jX3l3lmp/yy+ouBBQ1/iz6UfD
        EfZz814KXHJ3kzp5MzZ3n6ZfZAhznJ7c9ZPKSty7veZ4Mwq37LlRZddslsmcOM1M64NBHP+/
        GJ+Ey41Bfn8v3U5+qB8i8e+/dMnZCSvEChS38F816UkXfXxsazWP7hcDs7tPu439na/+OXNg
        /iV9V89VEYpXJ6823F78lUeJpTgj0VCLuag4EQBvtGe+JAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210701135543epcms1p84a043bf49757bafada0a773372611d69
References: <CGME20210701135543epcms1p84a043bf49757bafada0a773372611d69@epcms1p8>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
mem_section to section_nr could be costly since it iterates all
sections to check if the given mem_section is in its range.

On the other hand, __nr_to_section which converts section_nr to
mem_section can be done in O(1).

Let's pass section_nr instead of mem_section ptr to section_mark_present
in order to reduce needless iterations.

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
