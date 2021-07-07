Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3675B3BEA55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhGGPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:08:26 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:39339 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhGGPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:08:22 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210707150541epoutp022ebd220b377e27525d1c29086ccee50e~Pio-kr4GY1863918639epoutp021
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:05:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210707150541epoutp022ebd220b377e27525d1c29086ccee50e~Pio-kr4GY1863918639epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625670341;
        bh=vie/MD3bp15OOdNkmszQP60mktTrs2rhI3koi1uWjBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcyYyRHY+ptHI/Z4f1VWz9BT7+uIf4FVE6ZH5bX5emsO/VciBGTP/2CYYAjmrdTth
         HQp7khSB6tBLYsuXVqRHc9W7JSLrGj5FDMJif4Azuo6RtxrYJFJlwRZyLhe2g2ikh2
         s9LlSkii6WHi+GsCiyBW4xM3fK29ipA57Npf3vSQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210707150540epcas1p12159d4c80c6fd1eb77d57e7c0ac17c60~Pio-HL-ts0349803498epcas1p1J;
        Wed,  7 Jul 2021 15:05:40 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GKjR73wgKz4x9Pw; Wed,  7 Jul
        2021 15:05:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.01.09952.3C2C5E06; Thu,  8 Jul 2021 00:05:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210707150538epcas1p4b893d4fcd9eab24e4e06714efc24299e~Pio9awENd2640426404epcas1p4B;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210707150538epsmtrp112acc4da4fe30925052138cfe2657ff4~Pio9ZgyOu3041830418epsmtrp1i;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
X-AuditID: b6c32a35-45dff700000026e0-f1-60e5c2c31ee1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.19.08289.2C2C5E06; Thu,  8 Jul 2021 00:05:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210707150538epsmtip256ce86beebcb9af87f2e14b30de15558~Pio9Rfqqg0193201932epsmtip2V;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] mm: sparse: pass section_nr to section_mark_present
Date:   Thu,  8 Jul 2021 00:02:10 +0900
Message-Id: <20210707150212.855-2-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707150212.855-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmge7hQ08TDOZ0y1jMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORltZy6wFPzlqzixtZ2xgfEgTxcjJ4eEgInE
        k64pzF2MXBxCAjsYJdqfL2SBcD4xSqx5/o8JwvnMKHFn3RxWmJbjt2ZCtexilNj2+yMbXMvm
        D5eZQKrYBLQl9veeYAaxRQSiJWZf7QCLMwsUSDT0f2IBsYUFvCUe7jgPNpVFQFXi9vTjbCA2
        r4CVxIfpp9ghtslLrN5wAGwOp4C1xOV191hBlkkIvGWXOHtoElSRi8Tn3Q2MELawxKvjW6Di
        UhIv+9vYIRr6GSUO9W2H6p7AKLG+qxEowwHk2Eu8v2QBYjILaEqs36UP0asosfP3XEaIo/kk
        3n3tYYWo5pXoaBOCMFUllv32gKiWluibfpkNwvaQaNt6HBpyfYwSH+7eYprAKDcLYcECRsZV
        jGKpBcW56anFhgWGyFG2iRGc/rRMdzBOfPtB7xAjEwfjIUYJDmYlEV5Gh6cJQrwpiZVVqUX5
        8UWlOanFhxhNgYE3kVlKNDkfmIDzSuINTY2MjY0tTMzMzUyNlcR5d7IdShASSE8sSc1OTS1I
        LYLpY+LglGpguvrXo6jCeBpH8O0U3s/745h/m0pYK5+zNX71WTqzb5/JdqOVP7Xerluy85z7
        VcuUBsZUhqMr3gbxX0/Rs96VkMy6tUl0leXDzhnT702fslSrg4P5+czKjre7m14qTfp5+tfE
        /QrL9eZt2y8YLBSTPdH+Szjb502v0884XTAwPverROehdmhDEKNowSrvHVO6vTZKTnw26cG7
        g5bnxdenVj/5sGB7xKyJUidXrFEy+39fS52l5GzZCuk9z8T/fhX3v+Rk/WTRpMxYg7Vrnmws
        n33t1lL2+h/Hrmld4vs4Q6zP8I+c4j6ZgMB0L59t0vfYLs+qX1b2QzZ5oVSC6armJ3fj1nPn
        6C354j695tP+mmNKLMUZiYZazEXFiQDyesKACAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSvO6hQ08TDDbe07WYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUVw2Kak5mWWpRfp2CVwZbWcusBT85as4sbWd
        sYHxIE8XIyeHhICJxPFbM5m7GLk4hAR2MEpM+t/MCpGQlnj6YhdLFyMHkC0scfhwMUTNB0aJ
        488awWrYBLQl9veeYAapERGIl5h/jR0kzCxQJnF15V+wEmEBb4mHO86D2SwCqhK3px9nA7F5
        BawkPkw/xQ6xSl5i9YYDzCA2p4C1xOV191hBRgoB1TQtcZjAyLeAkWEVo2RqQXFuem6xYYFR
        Xmq5XnFibnFpXrpecn7uJkZweGpp7WDcs+qD3iFGJg7GQ4wSHMxKIryMDk8ThHhTEiurUovy
        44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDaqXNx0YxtR+bLft5QwD7p
        EOuc0CX9Bfte8vo/VJzYkvZm5kmt7FfTFioEJ7b5RufdWL8jVp1v2r1bp14/6416FrN7xjGp
        qgm3102b7nMzluuyTv2GD4vNUmr2ejeei2B6csiw7faCxJdxxpxrqhbOLtBifvSG0W8ud4H5
        R+ETN5Jbi5q/7Tqiee6lu6eV+TKWlnZuWeep8bmLvBR2Giu+6/hpwXFTrCt9/bVJN/jEprDv
        qn5z7kiA5MpO59SQQikrLRuW93K75v5O3yrv3d4nrac+6/CpMzsNdG4lp5blCD1913Vq/67z
        hx0u+Sf+WfTMSj6RfV/qYs7TMSXebfsjVPbxrr0ecJPzQEQX8ywXJZbijERDLeai4kQA0Z/A
        zb4CAAA=
X-CMS-MailID: 20210707150538epcas1p4b893d4fcd9eab24e4e06714efc24299e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210707150538epcas1p4b893d4fcd9eab24e4e06714efc24299e
References: <20210707150212.855-1-ohoono.kwon@samsung.com>
        <CGME20210707150538epcas1p4b893d4fcd9eab24e4e06714efc24299e@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
mem_section to section_nr could be costly since it iterates all
section roots to check if the given mem_section is in its range.

Since both callers of section_mark_present already know section_nr,
let's also pass section_nr as well as mem_section in order to reduce
costly translation.

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/sparse.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 6326cdf36c4f..8018ee7fcda5 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -187,10 +187,9 @@ void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
  * those loops early.
  */
 unsigned long __highest_present_section_nr;
-static void section_mark_present(struct mem_section *ms)
+static void __section_mark_present(struct mem_section *ms,
+		unsigned long section_nr)
 {
-	unsigned long section_nr = __section_nr(ms);
-
 	if (section_nr > __highest_present_section_nr)
 		__highest_present_section_nr = section_nr;
 
@@ -280,7 +279,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
 		if (!ms->section_mem_map) {
 			ms->section_mem_map = sparse_encode_early_nid(nid) |
 							SECTION_IS_ONLINE;
-			section_mark_present(ms);
+			__section_mark_present(ms, section);
 		}
 	}
 }
@@ -934,7 +933,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 
 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
-	section_mark_present(ms);
+	__section_mark_present(ms, section_nr);
 
 	/* Align memmap to section boundary in the subsection case */
 	if (section_nr_to_pfn(section_nr) != start_pfn)
-- 
2.17.1

