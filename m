Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF883BE8AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhGGNV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:21:29 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58315 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhGGNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:21:25 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210707131843epoutp0339df8c440207f141b58e0ae8b6355e2a~PhLm8jLe51030710307epoutp031
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:18:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210707131843epoutp0339df8c440207f141b58e0ae8b6355e2a~PhLm8jLe51030710307epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625663923;
        bh=rjLVc5Pk7mEfS5QJsbX09lDUXd0mFsvlZisGIyejgVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laCqJy/7OOmoasl+F2BV5g9Mesa48lbVO1D7ZC/Gj4XaWUY2nsi6gKgwWAL8bEuef
         CfG6pgoA2ACs9voy2kH482URfHqVecc0SqQWMUNUEkctoZwPQQ+Uo2bQwab86TZI19
         41jBl3aoMheKfBRkA+scqj+P2qLSfVPcz1L2G0Qs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210707131843epcas1p4c49d010c9b1244e466218b1c655343b7~PhLmZx1QF0134701347epcas1p4B;
        Wed,  7 Jul 2021 13:18:43 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GKg3k1r9pz4x9Pv; Wed,  7 Jul
        2021 13:18:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.D8.10119.2B9A5E06; Wed,  7 Jul 2021 22:18:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210707131841epcas1p129d1c10efdbbe403e80f45245b0b5afd~PhLlJjxy21869818698epcas1p1k;
        Wed,  7 Jul 2021 13:18:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210707131841epsmtrp1a4aa7983947469a7278fbf25f01564dd~PhLlIydgd1302713027epsmtrp1B;
        Wed,  7 Jul 2021 13:18:41 +0000 (GMT)
X-AuditID: b6c32a38-965ff70000002787-3d-60e5a9b28c8d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.36.08289.1B9A5E06; Wed,  7 Jul 2021 22:18:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210707131841epsmtip2f9cf584be63033435fbada1bdfede54a~PhLk6i74G2143921439epsmtip29;
        Wed,  7 Jul 2021 13:18:41 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] mm: sparse: pass section_nr to section_mark_present
Date:   Wed,  7 Jul 2021 22:14:43 +0900
Message-Id: <20210707131443.6242-2-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707131443.6242-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmvu6mlU8TDBasZreYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjI2vZ/IVHCZr2Lj+XbmBsY5PF2MnBwSAiYS
        03ofMHUxcnEICexglFjQtZUdwvnEKDGldQmU85lR4u6Wc0wwLddW7YZK7GKUWH5lBULLob7D
        bCBVbALaEvt7TzCD2CIC0RKzr3aAdTMLFEg09H9iAbGFBbwlNm/aA1TDwcEioCox66oHSJhX
        wFri1sSf7BDL5CVWbzgANoZTwEbi1b4LLCC7JATeskt8mNzOCFHkIjF302So64QlXh3fAtUs
        JfGyv40doqEf5LjtrBDOBEaJ9V2N7CCbJQTsJd5fsgAxmQU0Jdbv0ofoVZTY+XsuI8TNfBLv
        vvawQlTzSnS0CUGYqhLLfntAVEtL9E2/zAZhe0isPfYKGqRAWy9Nfs02gVFuFsKCBYyMqxjF
        UguKc9NTiw0LTJBjbBMjOPlpWexgnPv2g94hRiYOxkOMEhzMSiK8jA5PE4R4UxIrq1KL8uOL
        SnNSiw8xmgLDbiKzlGhyPjD95pXEG5oaGRsbW5iYmZuZGiuJ8+5kO5QgJJCeWJKanZpakFoE
        08fEwSnVwKSwVn3dZKarIdYnGmueMX8+X73xrFrAc+e2qPsz+UzYDebNUc9+//F8pEXbvdY4
        A9NVl+54d32ffTzoZMr2TYxHY25vqG55vlnN6LLtw0lat2KK2ALnGJRIu7Vu/34vrmZKqsuE
        Z37Ma3J/TVyq+2CSRfe1KEWN00mnxYNPvHy1dIPKy9dqnREL3x5zFNzEeeBMx7w7M+Yf8ZC4
        3muwffq9nogHO8vmHfTs7L/7bcbGJSseCZ4JbJv5x4nBVOB56Hulid+FvAS2rvN5wSn/a5lS
        vfBCpTt9U5295vHIWDz9uEyacSrXB/Fg8Z+RKu3LZ1wsKl42ya97MnNopvPLY4+n5JxffDbm
        goZA7sEVj0t7lFiKMxINtZiLihMBs0TNFQcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSvO7GlU8TDO6+1rSYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUVw2Kak5mWWpRfp2CVwZm95PZCq4zFex8Xw7
        cwPjHJ4uRk4OCQETiWurdrN3MXJxCAnsYJT4/Gs/C0RCWuLpi11ANgeQLSxx+HAxRM0HRol7
        h9czgtSwCWhL7O89wQxSIyIQLzH/GjtImFmgTOLqyr+sILawgLfE5k17wEpYBFQlZl31AAnz
        ClhL3Jr4kx1ik7zE6g0HmEFsTgEbiVf7LoBdIARU8+P9ZvYJjHwLGBlWMUqmFhTnpucWGxYY
        5aWW6xUn5haX5qXrJefnbmIEh6eW1g7GPas+6B1iZOJgPMQowcGsJMLL6PA0QYg3JbGyKrUo
        P76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamq061trJGdx6eq1Pa+3XK
        MV7p9ujHClvnLpmlWv9jrWtozAyL/du8uueGxgvqSG36sPOm9tTZEzZH79xToujOtGHBnGPG
        25nSRReVcZ19etjC6ONFvprEye/uMgtdfcsfyfFF28HqyuRpe7a0X3U/e/a6y6pXfsejbz1d
        YB9yT/D25bC11z4pJNzyEPJZrC7oXB/ifXbliVuvHx5jzvXNmvEr+aWzu0XZtNDY8869k+rv
        //vBtYG1trTXxfSU8GJt8ZrvMQvPTL7LN8f65A7R7FP/8sO2mU9Mu6fLpSnG9W72Xc1jkapV
        HP0HDveUf/z1Zp3I260lM36xNKy1Zwu4n13blClvcHStx/dm8/+2aUosxRmJhlrMRcWJABtZ
        CbK+AgAA
X-CMS-MailID: 20210707131841epcas1p129d1c10efdbbe403e80f45245b0b5afd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210707131841epcas1p129d1c10efdbbe403e80f45245b0b5afd
References: <20210707131443.6242-1-ohoono.kwon@samsung.com>
        <CGME20210707131841epcas1p129d1c10efdbbe403e80f45245b0b5afd@epcas1p1.samsung.com>
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

