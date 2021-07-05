Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D43BB9B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhGEJCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:02:03 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:62339 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhGEJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:01:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210705085921epoutp011c62ab0413da0659e2425d2d212b430c~O2Wk6bKFE2740827408epoutp01n
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 08:59:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210705085921epoutp011c62ab0413da0659e2425d2d212b430c~O2Wk6bKFE2740827408epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625475561;
        bh=eiXtJKwEaewkgKoO/19bGdQAS0EpH99MRdSzhegqUOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWwnOenD4K/YBV/S4cbmg9sxQunADVdASzPt3RL9Kust3GNqffl/VdNx/cH8YHKpX
         E5hbMo9evWy6ZUmOPLLWypwvxOw9C7cHpfOsidqeuTzFGg436bypMuKAzdN4Zrahg+
         7my9MO5O6ZbSx7wYlGfl/ajq0EvxwmT59IF9AHgg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210705085920epcas1p4ced8700a53d50de330ae4969d1c39618~O2WkZuUzI0213302133epcas1p4R;
        Mon,  5 Jul 2021 08:59:20 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GJKPM6132z4x9QK; Mon,  5 Jul
        2021 08:59:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.6C.09468.6E9C2E06; Mon,  5 Jul 2021 17:59:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210705085918epcas1p415e226a85dc289c2d306c009dbc4ef55~O2WiDm4F-0213302133epcas1p4H;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210705085918epsmtrp18bed893109164f371d7f915ba14c2335~O2WiCxa9L0607106071epsmtrp1E;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
X-AuditID: b6c32a37-0b1ff700000024fc-bd-60e2c9e61895
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.C4.08394.6E9C2E06; Mon,  5 Jul 2021 17:59:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705085918epsmtip2db0c596f5cdf3a853dbdd4d21f26e233~O2Wh2nZBN2867728677epsmtip2J;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mm: sparse: remove __section_nr() function
Date:   Mon,  5 Jul 2021 17:55:38 +0900
Message-Id: <20210705085538.14557-4-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705085538.14557-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmvu7zk48SDO6JWsxZv4bN4vyDX2wW
        X9f/Yra4vGsOm8W9Nf9ZLe73OVjs3e9rsevnCmaLG1Ma2Bw4PXbOusvusenTJHaPEzN+s3hM
        WHSA0eP9vqtsHn1bVjF6rN9ylcXj8ya5AI6oHJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoOOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQWGBgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5GWdPX2YpOMVXsefcV/YGxgaeLkZ2DgkBE4lN
        LF2MXBxCAjsYJfbu62PtYuQEcj4xSlw6JQyR+MYo8fjVNUaQBEj9z+lTmSASexkl/u3uZYRw
        gDo2H2wDq2IT0JbY33uCGcQWEYiWmH21gwnEZhYokGjo/8QCYgsLOEn07NsLVs8ioCqxu3EC
        WA2vgI1ET8dEdoht8hKrNxwAm8MpYCvx99UTsFslBN6ySzw7vgvqJBeJTY8nMkPYwhKvjm+B
        apaSeNnfxg7R0M8ocahvOyuEM4FRYn1XI1CGA8ixl3h/yQLEZBbQlFi/Sx+iV1Fi5++5jBBH
        80m8+9rDClHNK9HRJgRhqkos++0BUS0t0Tf9MhuE7SFxfPkEaJACLer90ss2gVFuFsKCBYyM
        qxjFUguKc9NTiw0LjJHjaxMjOO1pme9gnPb2g94hRiYOxkOMEhzMSiK8IlMeJQjxpiRWVqUW
        5ccXleakFh9iNAUG3kRmKdHkfGDizSuJNzQ1MjY2tjAxMzczNVYS593JdihBSCA9sSQ1OzW1
        ILUIpo+Jg1OqgalPrnBdxIyy3f8d0i5/+8G0X/7o9clHJ07jMRW/HX9L5rXE10NfGjoiv2sJ
        mbgteShkbHX6fH93y5xz00sSTs3fX8X6lVNfwj35x/sVK1KvOB823c482Wvir8mndUQK7jjf
        f7Q0mTv7dcyxK/ck5n7OY35SPMl+G0tPjJnltilzZry8dK/9a/C25yvT5ojxfXjg133gANca
        e5mHt7VmxjArsCTtWxF74Wak6oMYrU1eGZdtwvuazerDXy5xY1p7sixONvJh3ZKi7WdnB/v9
        NfJ8k/vYwO10YejHjDWcKRZzOXuaa2Zn1k5s9uWde8hPZVnq5cfRm+xidJWtfd4/d0/RP9vf
        2twzS3v6TcG442pKLMUZiYZazEXFiQBoO3PgBAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSvO6zk48SDGa0CFvMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOKC6blNSczLLUIn27BK6Ms6cvsxSc4qvYc+4r
        ewNjA08XIyeHhICJxM/pU5m6GLk4hAR2M0q83djCDpGQlnj6YhdLFyMHkC0scfhwMUTNB0aJ
        dU/fMYLUsAloS+zvPcEMUiMiEC8x/xpYK7NAmcTVlX9ZQWxhASeJnn17wcpZBFQldjdOYAKx
        eQVsJHo6JkKtkpdYveEAM4jNKWAr8ffVE7C1QkA1EzaFTmDkW8DIsIpRMrWgODc9t9iwwDAv
        tVyvODG3uDQvXS85P3cTIzg8tTR3MG5f9UHvECMTB+MhRgkOZiURXpEpjxKEeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYPIWbT8g+rFnT5GYVHbn2/yE
        3NhdXK1bTljJTH9qvkLq/9Of79X9zKK4y64H9PN2fHwUfC2Ud0OH94qHidFBN2wdlJeoF35S
        sz2ZOrVzZv2WpxNN1nqpuGs5L5vbem/J15nblrrtr/ylt+rLbP3w92sDv716GHL3IHum+NuA
        nxMm7st3zb6idXlrzYr/Ek3Zdk/lQqOOPanxi9x5c4UtU+JRLp6Qm1J/4pm/VltP81tyYM/G
        Kxdv9gX842dVUxbsy/hwbWXqPImLj9Mi2Ve9Y61P+/rLWNsu+p7HnGWTO1+K2dzevrX+gIfW
        miWPSo4Hl74VcN1mUFX+7Ij3l2Y9h0yHAsajDs/LwjeGziz9t1mJpTgj0VCLuag4EQD3kwSQ
        vgIAAA==
X-CMS-MailID: 20210705085918epcas1p415e226a85dc289c2d306c009dbc4ef55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705085918epcas1p415e226a85dc289c2d306c009dbc4ef55
References: <20210705085538.14557-1-ohoono.kwon@samsung.com>
        <CGME20210705085918epcas1p415e226a85dc289c2d306c009dbc4ef55@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the last users of __section_nr() are gone, let's remove unused
function __section_nr().

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h |  1 -
 mm/sparse.c            | 26 --------------------------
 2 files changed, 27 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fcb535560028..8827f4d081d4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1342,7 +1342,6 @@ static inline struct mem_section *__nr_to_section(unsigned long nr)
 		return NULL;
 	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
 }
-extern unsigned long __section_nr(struct mem_section *ms);
 extern size_t mem_section_usage_size(void);
 
 /*
diff --git a/mm/sparse.c b/mm/sparse.c
index b4fae2fc6276..c14d2b37fd16 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -109,32 +109,6 @@ static inline int sparse_index_init(unsigned long section_nr, int nid)
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

