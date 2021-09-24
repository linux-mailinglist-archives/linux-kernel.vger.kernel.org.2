Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B36417659
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbhIXN50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:57:26 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31267 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346569AbhIXN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:57:24 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210924135549epoutp026860defe5a44dd4f375ec4c51fc4a3b7~nxpjM486n2409424094epoutp02S
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:55:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210924135549epoutp026860defe5a44dd4f375ec4c51fc4a3b7~nxpjM486n2409424094epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632491749;
        bh=mNQhFy+0EiS+QFcEKoyz6Gg5CkSs9cKnhKzNpsJdN6Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LUFa8tWWuJ3QsitRJZIkoHZ7waYbvAmvaatQPxkOKiNPxbaUi7CO7J5XOeR7kOP+V
         ZJRwnAZbdwD3kdlMlEh5GB97G+mQla8KI8HfUz9F9L0lkffkcj/WYJlyqsHEnbwf6C
         xy7FJ1VS8+2URU2+rSr+BNTJH3xRf6pKTYuY6vCE=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210924135548epcas5p114c5dca6c0cb260a1e30d3bde0962b39~nxph5DVLr1707317073epcas5p1g;
        Fri, 24 Sep 2021 13:55:48 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.22.59762.3E8DD416; Fri, 24 Sep 2021 22:55:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210924121457epcas5p39266266f9cef79177f2301a6a4f7d79a~nwRe_0fYE1848718487epcas5p3u;
        Fri, 24 Sep 2021 12:14:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210924121457epsmtrp21f242e919d84fda83da496006302ee51~nwRe_AMG82712327123epsmtrp2B;
        Fri, 24 Sep 2021 12:14:57 +0000 (GMT)
X-AuditID: b6c32a49-10fff7000000e972-97-614dd8e38bdf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.6D.09091.141CD416; Fri, 24 Sep 2021 21:14:57 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210924121455epsmtip2923d25f8bf1e960d7c28e1c1f758c3bc~nwRc95v331682016820epsmtip2a;
        Fri, 24 Sep 2021 12:14:55 +0000 (GMT)
From:   Manjeet Pawar <manjeet.p@samsung.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     r.thapliyal@samsung.com, a.sahrawat@samsung.com,
        v.narang@samsung.com, Manjeet Pawar <manjeet.p@samsung.com>
Subject: [PATCH] mm/kfence: Null check is added for return value of
 addr_to_metadata
Date:   Fri, 24 Sep 2021 17:44:02 +0530
Message-Id: <1632485642-20625-1-git-send-email-manjeet.p@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7bCmpu7jG76JBkt6bCwu7k61mLN+DZvF
        hIdt7BZtZ7azWrR/3MtsseLZfSaLy7vmsFncW/Of1eJe61o2i433si0OnZzL6MDtsWBTqcee
        iSfZPDZ9msTucWLGbxaPvi2rGD0+b5ILYIvisklJzcksSy3St0vgyujeeoC9oJmt4tjeZYwN
        jJ9Zuhg5OSQETCR6tq9l7GLk4hAS2M0oMWfaNFaQhJDAJ0aJjx+dIBLfGCW+zO5khOn49+YL
        VMdeRomeDVPYIJwvjBIvFi0Dq2IT0JbY86ONHSQhIrCCUWLWifdMIAlmgSKJ97+Xs4PYwgJh
        Eh2HF4DFWQRUJY5f2gq2m1fAVeLYxbvsEOvkJG6e62QGGSQhcIpd4uDUj6wQCReJ3w/+s0HY
        whKvjm+BapCS+PxuL1S8XmLzhs1QzT2MEj/P/oRK2Es8ubgQaBAH0EWaEut36UOEZSWmnloH
        dSifRO/vJ0wQcV6JHfNgbGWJZec3Q9mSErPPHGWGsD0kNt94xQwJvFiJyR9amCYwys5C2LCA
        kXEVo2RqQXFuemqxaYFhXmq5XnFibnFpXrpecn7uJkZwotDy3MF498EHvUOMTByMhxglOJiV
        RHg/3/BKFOJNSaysSi3Kjy8qzUktPsQozcGiJM778bVlopBAemJJanZqakFqEUyWiYNTqoGp
        /1Dko7KdWw/uuDax9KSaZ6fU/GIHu7CJjX9e3z7bk5eU5ZEXclKzU52v916l6q+by4/wn+H8
        HDorTP6OL+NXzb7XqZlmE57rSTldqxBbf+3vlYil+vrHor4dDJHcKD55yn+lbdNt/m5LaW2M
        4Y1YxLp6kbi36+1dqR+O/snMvf3m6oETzad5FApr29+9Fn/e6tP+hXm95aIDHlVvnVhrXy6s
        vLTBKEWma3OHwS6+o1Flp/azM8ld6rwVeO6q4PWi76YnN9xb9Nv0nJjSpALW/7U7HhTYpO9l
        OjaLj831KU+bg0dqx6+7HYdSTtm8PePpHTI3f4r7k8i1YvobP1wIdP32fb1YxyktfnGj25v2
        KLEUZyQaajEXFScCAFiuq3aDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsWy7bCSvK7jQd9Eg/7rwhYXd6dazFm/hs1i
        wsM2dou2M9tZLdo/7mW2WPHsPpPF5V1z2CzurfnPanGvdS2bxcZ72RaHTs5ldOD2WLCp1GPP
        xJNsHps+TWL3ODHjN4tH35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZXRvPcBe0MxWcWzvMsYG
        xs8sXYycHBICJhL/3nxhBLGFBHYzSjyeogsRl5ToXzcVqkZYYuW/5+wQNZ8YJba1poDYbALa
        Ent+tIHFRQQ2MEqseefdxcjBwSxQJtHwWQAkLCwQIjFh4XpmEJtFQFXi+KWtrCA2r4CrxLGL
        d9khxstJ3DzXyTyBkWcBI8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgYNPS3MG4
        fdUHvUOMTByMhxglOJiVRHg/3/BKFOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJ
        anZqakFqEUyWiYNTqoHJbXHGqX+Jk57xvSx7/+JT1xXZm891IjdVnRCXYLVfvvby65jfs+1Z
        MwoDg7+mSPdnTfn1JTdpo/uUuVV3dsQocwh9uGsUWHovvcdrv4HWgVUek6+z39ZJ/W11zkLW
        KLnqT9+Pa1zfeSKP/Hz2vztB3DTkytG+K9m7xSuVDiza5Xeapym0O+Jq3luDiRtz8x+IPrj/
        +26trXyeetpWRdP4rT8NPkXX7NH2eTCjlYXvkenLD4YWGX+O+SzY/+DJ0v9SWUmJ3o+aF/H/
        9jWUecxofPl97EtjY0v2Z/8bG3V1hJ89TCudoM94d6dup3+qbRani/CyU7v+Ja6eenJT89me
        hHfsC9gixdylVv1a0DZHiaU4I9FQi7moOBEAT32yLaUCAAA=
X-CMS-MailID: 20210924121457epcas5p39266266f9cef79177f2301a6a4f7d79a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210924121457epcas5p39266266f9cef79177f2301a6a4f7d79a
References: <CGME20210924121457epcas5p39266266f9cef79177f2301a6a4f7d79a@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add null check for return value of addr_to_metadata().
currently 'meta' is geting accessed without any NULL check but it is
usually checked for this function.

Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
---
 mm/kfence/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 575c685aa642..9b953cfa7fee 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -802,6 +802,9 @@ void __kfence_free(void *addr)
 {
 	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
 
+	if (unlikely(!meta))
+		return;
+
 	/*
 	 * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
 	 * the object, as the object page may be recycled for other-typed
-- 
2.17.1

