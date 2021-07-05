Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF53BB9B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhGEJCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:02:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23410 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhGEJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:01:59 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210705085921epoutp04ad76375e4d7f45e14a58e8efa87e9061~O2Wknlv5G3036330363epoutp04h
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 08:59:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210705085921epoutp04ad76375e4d7f45e14a58e8efa87e9061~O2Wknlv5G3036330363epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625475561;
        bh=2y/NVkLne+0y/XisEygWczbRR0MKGa628Bu0+nxLkNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2FYXUfUE1W6xlEwJDXqcIAgdH9suW+UnRT9xXELpVaQKEC/gNkKqmA5daVO7jsSD
         bMaee7b+lkWGnDrnOcgfm2G5bY0w0ENAHceeTZIe6AVuWqWbkA6CKO84k1bZ/G7Jpv
         r4QzFp05vKSz4Jvmebe3dRrjbVUuUxrWtk2h8/Ho=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210705085920epcas1p12afb92abfbcef9927da7da9c48f520c5~O2WkIgz8s2231422314epcas1p1C;
        Mon,  5 Jul 2021 08:59:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GJKPM373pz4x9Q2; Mon,  5 Jul
        2021 08:59:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.DA.09952.6E9C2E06; Mon,  5 Jul 2021 17:59:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210705085918epcas1p17e0ac84d91c591897d00fbc3d3caa771~O2Wh52fKY2231422314epcas1p15;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705085918epsmtrp2caefd19958129f7f5750f8fb94f29cfc~O2Wh5As2B1532215322epsmtrp2U;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
X-AuditID: b6c32a35-447ff700000026e0-12-60e2c9e68cfb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.C4.08394.6E9C2E06; Mon,  5 Jul 2021 17:59:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705085918epsmtip209624057555c41d1b2a653d34eae2c9b~O2Wht-FyX2867228672epsmtip2X;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mm: sparse: pass section_nr to section_mark_present
Date:   Mon,  5 Jul 2021 17:55:36 +0900
Message-Id: <20210705085538.14557-2-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705085538.14557-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmru6zk48SDP51qFnMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORkXlj9jKegUqJi99AFjA+Nm3i5GTg4JAROJ
        bcsnsYHYQgI7GCUW/1LqYuQCsj8xSiw/eo4dwvnGKDHp/mommI6zO/8wQyT2Mkr0vtjHBNey
        7msbI0gVm4C2xP7eE8wgtohAtMTsqx1g3cwCBRIN/Z9YQGxhAW+J3dtegu1mEVCV6Ls0D6ye
        V8BG4uC/BawQ2+QlVm84ABbnFLCV+PvqCQtE/C27xOtf4hC2i8TqRc1sELawxKvjW9ghbCmJ
        z+/2soEcJyHQzyhxqG87K4QzgVFifVcjUBUHkGMv8f6SBYjJLKApsX6XPkSvosTO33MZIW7m
        k3j3tYcVoppXoqNNCMJUlVj22wOiWlqib/plqAs8JJZ8vc4GCRKgRetuXmeewCg3C2HBAkbG
        VYxiqQXFuempxYYFhsgRtokRnPq0THcwTnz7Qe8QIxMH4yFGCQ5mJRFekSmPEoR4UxIrq1KL
        8uOLSnNSiw8xmgLDbiKzlGhyPjD55pXEG5oaGRsbW5iYmZuZGiuJ8+5kO5QgJJCeWJKanZpa
        kFoE08fEwSnVwNTXlyojt+TLhvnhSWtiXnZZqstNUt28grE8JvjN7WONd3aVWD6eFnrTYuWM
        KRXTb5zuKZncwDGn8XTe1nuRX44Jmv+a9KfBntfu7huRuEe7dCWbZ2juZp8s4jpTMtf37N+f
        y4+n5DksOzqh+cPLSB5tFYYDmux/lJ7ttjnee65qkZ32l87zHLlWV+KmHtO5tDg/RJbv/cMN
        djMy397x3Dv1cnFXaM6Ggg8JVjNNrztMe1mfEhe+1sa/qUbJovvR78P/74m6vVTVFZnwZt27
        107CRhIzKqst/7Ian1Z3rtg9syNi07ZbV+cm5sv35pxsP3Qkruwfyx7uZWoiJ08KuLxVv77H
        e9pvjuzfBq13inyUWIozEg21mIuKEwHAAghLBgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSvO6zk48SDKbu4LKYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUVw2Kak5mWWpRfp2CVwZF5Y/YynoFKiYvfQB
        YwPjZt4uRk4OCQETibM7/zB3MXJxCAnsZpTYvuAXC0RCWuLpi11ANgeQLSxx+HAxRM0HRoll
        V84ygdSwCWhL7O89wQxSIyIQLzH/GjtImFmgTOLqyr+sILawgLfE7m0v2UBsFgFVib5L85hB
        bF4BG4mD/xawQqySl1i94QBYnFPAVuLvqydga4WAaiZsCp3AyLeAkWEVo2RqQXFuem6xYYFh
        Xmq5XnFibnFpXrpecn7uJkZweGpp7mDcvuqD3iFGJg7GQ4wSHMxKIrwiUx4lCPGmJFZWpRbl
        xxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDkKPbovkJ1/bWSd9m78rgk
        pbc9YJPUkZ2/WH3rqp1b1YsXbbsXHHTsweQXpfmtDrm5ix17cr8aPvrjmlP86HDp46Kg5Vev
        p8XevrxQ44/m5NKpz0P38Px5q+F6+jD72oS3U+Z8vnd31xaXhXf3CZQ7uwr2no5j0ZN/s+H+
        jnWdBzaXOFzi+d7qKd7vz2+6ZIm2RmJUC2db8Ycd5xc9vc3r9fS50XzhpueOlxvMxM5N7cmb
        KxSvIPu5drrT6/SuEyLh3hsuGT3eb6S2Y+b9mG2/WeQCdO8e6ZP4+rZxck3qpNwN/5cUpud8
        XWN955/pxN4jJ9r1q0wPTHxyT/7vfobWpb6B7WWGf+UD33Q+W2XhocRSnJFoqMVcVJwIAHpO
        NxO+AgAA
X-CMS-MailID: 20210705085918epcas1p17e0ac84d91c591897d00fbc3d3caa771
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705085918epcas1p17e0ac84d91c591897d00fbc3d3caa771
References: <20210705085538.14557-1-ohoono.kwon@samsung.com>
        <CGME20210705085918epcas1p17e0ac84d91c591897d00fbc3d3caa771@epcas1p1.samsung.com>
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
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/sparse.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 6326cdf36c4f..b4fae2fc6276 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -187,13 +187,14 @@ void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
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
 
@@ -280,7 +281,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
 		if (!ms->section_mem_map) {
 			ms->section_mem_map = sparse_encode_early_nid(nid) |
 							SECTION_IS_ONLINE;
-			section_mark_present(ms);
+			section_mark_present(section);
 		}
 	}
 }
@@ -934,7 +935,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 
 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
-	section_mark_present(ms);
+	section_mark_present(section_nr);
 
 	/* Align memmap to section boundary in the subsection case */
 	if (section_nr_to_pfn(section_nr) != start_pfn)
-- 
2.17.1

