Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F272B3B9E80
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhGBJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:47:49 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:39861 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhGBJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:47:33 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210702094459epoutp03bf1e71139b988dc2cfec730feb986ade~N8Cj6S_nQ1759617596epoutp03v
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 09:44:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210702094459epoutp03bf1e71139b988dc2cfec730feb986ade~N8Cj6S_nQ1759617596epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625219099;
        bh=q1Bo5tHP3Pm++tV7Sf0f+PhSILKdUAIb8tIn5N0cOf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTBImMNZ1ohhSINerQWp27FoT8qyP8Gs44cyJ8YjV429xAnauoGbQEGJxwVm10KSw
         CIBb3aGKbQ52zXkpNgqRId22Hd48po6BRNhlW8vnR+cyeVTI5xusq8mIZq9Nq+A+ef
         msVrfevIsqn/EDhK+AKH2nDjAjDqWyfiN1Q5qfUg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210702094458epcas1p2d95e8fc80c3ba68340e069f241dcdc4d~N8CjcCpJf0305903059epcas1p27;
        Fri,  2 Jul 2021 09:44:58 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GGVYP6kRNz4x9Q7; Fri,  2 Jul
        2021 09:44:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.44.09468.910EED06; Fri,  2 Jul 2021 18:44:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210702094457epcas1p4e181c7b0a18338403a7ffb57f44807fe~N8Ch5Y8_I1021710217epcas1p4q;
        Fri,  2 Jul 2021 09:44:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210702094457epsmtrp1790de2480197cb01e08ee6d78fb6b37f~N8Ch4l_Sp2300123001epsmtrp1P;
        Fri,  2 Jul 2021 09:44:57 +0000 (GMT)
X-AuditID: b6c32a37-0b1ff700000024fc-7c-60dee0193921
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.E8.08394.910EED06; Fri,  2 Jul 2021 18:44:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210702094456epsmtip164eeec37388c6e6e0f19a267e7bfcb19~N8Chrfzhr1051310513epsmtip1t;
        Fri,  2 Jul 2021 09:44:56 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: sparse: remove __section_nr() function
Date:   Fri,  2 Jul 2021 18:41:32 +0900
Message-Id: <20210702094132.6276-4-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210702094132.6276-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmrq7kg3sJBvPOGlnMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORkvm46wFMwRrDj8fhV7A+MEvi5GTg4JAROJ
        jXsfMHUxcnEICexglLiw7hULhPOJUWLR/AdsEM43RontZyczwrR8mbMEqmovo8SZxXcRWp4+
        OswCUsUmoC2xv/cEM4gtIhAtMftqBxOIzSxQINHQ/wmsRljAXqKvZy9YDYuAqsTt7deBajg4
        eAWsJXbtCodYJi+xesMBsBJOARuJE517WUF2SQi8ZZc4/fMlM0SRi8TMYy+grhOWeHV8CzuE
        LSXxsr+NHaKhn1HiUN92qO4JjBLruxrZQbZJAF3x/pIFiMksoCmxfpc+RK+ixM7fcxkhbuaT
        ePe1hxWimleio00IwlSVWPbbA6JaWqJv+mU2CNtDomXVLmiQAG1dc2M1+wRGuVkICxYwMq5i
        FEstKM5NTy02LDBGjrFNjODkp2W+g3Ha2w96hxiZOBgPMUpwMCuJ8IbOu5cgxJuSWFmVWpQf
        X1Sak1p8iNEUGHYTmaVEk/OB6TevJN7Q1MjY2NjCxMzczNRYSZx3J9uhBCGB9MSS1OzU1ILU
        Ipg+Jg5OqQamkDkR4sql1s0sV7ln2L28qpjEWu6TE9T692LrmT/uP1K2f/1z9Mumm53+FyLO
        LltbP2WDv3z0pId6fFVzn1Vd8rpzZ7pFSbTfrk9+61lE1mc/qW1W3nt3sQHvrcmbN/2fJZV/
        SW4DM/e6GvPlTTOev1r25BDTu1U9tnu3CNzXPnw2x1FN/Od1u+5mq8Yrj1/eZXV7vbZF2ZtX
        9o/3rO0yL7KO3piwumzVxvdVx+Q2e66WrWBp2790iaOci+S+Lz0xoT/PbWKXrn2zO+rXq+xJ
        sZauRnEJ01gvhH628Nz9y6vo0IOzn8/cfXIiMlyyObztfnH7O/09T96qFqz/cqIj9janS/91
        qauzndb+d/7D5qTEUpyRaKjFXFScCAAyA+JkBwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnK7kg3sJBm82MFvMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOKC6blNSczLLUIn27BK6Ml01HWArmCFYcfr+K
        vYFxAl8XIyeHhICJxJc5S1i6GLk4hAR2M0pc7X7IApGQlnj6YheQzQFkC0scPlwMUfOBUaLx
        92lGkBo2AW2J/b0nmEFqRATiJeZfYwcJMwuUSVxd+ZcVxBYWsJfo69nLDGKzCKhK3N5+nQmk
        nFfAWmLXrnCITfISqzccACvhFLCRONG5F6xVCKjk8+7j7BMY+RYwMqxilEwtKM5Nzy02LDDM
        Sy3XK07MLS7NS9dLzs/dxAgOTy3NHYzbV33QO8TIxMF4iFGCg1lJhDd03r0EId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpgC/6oJHD1rfzCU68d8warN
        msl7v0tGR9yZw77wZSFfWsF79pmrLggqihwLnbzZzjt0dovA5tMJmyfP5pLO5XiW0OKymsMl
        nsfo7zSdGLPkvCytA+Wf1NjXzf2t5Jj08++fLSuv/r004e+M9ryLe09rnl/RZMF4e0587WcF
        tV+/zigKNj7ZaFjVnLXWyPThiW0LvqyKP7J8/kIGO92Qx+0zze5EFiZm830zOJI2Rb9X5dKV
        RtdLa00uTjs9f1K9/NlWFa68iK21UhmHBZY/Od32fJ98RcuF7KjYjZnffv6fsqzngrwSo6Ob
        UesVlxc/Us6/kvusmbE/JExEIPMvz/dd7ceWXPJ7eS300L7XGe8uKLEUZyQaajEXFScCAMMB
        eGO+AgAA
X-CMS-MailID: 20210702094457epcas1p4e181c7b0a18338403a7ffb57f44807fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210702094457epcas1p4e181c7b0a18338403a7ffb57f44807fe
References: <20210702094132.6276-1-ohoono.kwon@samsung.com>
        <CGME20210702094457epcas1p4e181c7b0a18338403a7ffb57f44807fe@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__section_nr() was used to convert struct mem_section * to section_nr.

With CONFIG_SPARSEMEM_EXTREME enabled, however, __section_nr() can be
costly since it iterates all section roots to check if the given
mem_section is in its range.

On the other hand, __nr_to_section() which converts section_nr to
mem_section can be done in O(1).

The only users of __section_nr() was section_mark_present() and
find_memory_block().

Since I changed both functions to use section_nr directly in the
preceeding patches, let's remove __section_nr() which has no users.

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
---
 include/linux/mmzone.h |  1 -
 mm/sparse.c            | 26 --------------------------
 2 files changed, 27 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0d53eba1c383..8931f95cf885 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1321,7 +1321,6 @@ static inline struct mem_section *__nr_to_section(unsigned long nr)
 		return NULL;
 	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
 }
-extern unsigned long __section_nr(struct mem_section *ms);
 extern size_t mem_section_usage_size(void);
 
 /*
diff --git a/mm/sparse.c b/mm/sparse.c
index 4a2700e9a65f..1b32d15593e4 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -108,32 +108,6 @@ static inline int sparse_index_init(unsigned long section_nr, int nid)
 }
 #endif
 
-#ifdef CONFIG_SPARSEMEM_EXTREME
-unsigned long __section_nr(struct mem_section *ms)
-{
-	unsigned long root_nr;
-	struct mem_section *root = NULL;
-
-	for (root_nr = 0; root_nr < NR_SECTION_ROOTS; root_nr++) {
-		root = __nr_to_section(root_nr * SECTIONS_PER_ROOT);
-		if (!root)
-			continue;
-
-		if ((ms >= root) && (ms < (root + SECTIONS_PER_ROOT)))
-		     break;
-	}
-
-	VM_BUG_ON(!root);
-
-	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
-}
-#else
-unsigned long __section_nr(struct mem_section *ms)
-{
-	return (unsigned long)(ms - mem_section[0]);
-}
-#endif
-
 /*
  * During early boot, before section_mem_map is used for an actual
  * mem_map, we use section_mem_map to store the section's NUMA
-- 
2.17.1

