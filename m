Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793B733EBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCQIht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:37:49 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:15491 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhCQIhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:37:18 -0400
X-AuditID: 0a580155-20dff7000005482e-d4-6051b80492ee
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id A4.D4.18478.408B1506; Wed, 17 Mar 2021 16:04:20 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 17 Mar
 2021 16:37:14 +0800
Date:   Wed, 17 Mar 2021 16:37:14 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <yaoaili@kingsoft.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <sunhao2@kingsoft.com>, <yaoaili@kingsoft.com>
Subject: [PATCH] mm/gup: check page posion status for coredump.
Message-ID: <20210317163714.328a038d@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsXCFcGooMuyIzDB4N9yCYs569ewWVzeNYfN
        4t6a/6wWFxsPMDqweGz6NInd48SM3yweL65uZPH4vEkugCWKyyYlNSezLLVI3y6BK+NL51Hm
        gnVcFRuOdLM0MC7g6GLk5JAQMJFYtGozcxcjF4eQwHQmiSt/1zBBOK8YJToOPmAFqWIRUJXY
        9KWFEcRmA7J33ZsFFOfgEBGwkvhwUAiknllgHqPEljWHmUBqhAXsJf5M3QPWywtU09V0CKyX
        X0BMovfKfyaIzfYSbVsWMULUCEqcnPmEBcRmFtCROLHqGDOELS+x/e0cMFtIQFHi8JJf7BC9
        ShJHumewQdixEsvmvWKdwCg4C8moWUhGzUIyagEj8ypGluLcdKNNjJCgDd3BOKPpo94hRiYO
        xkOMEhzMSiK8pnkBCUK8KYmVValF+fFFpTmpxYcYpTlYlMR5HSOBUgLpiSWp2ampBalFMFkm
        Dk6pBqaiVdy3hDx2P1rg2ybWPt3m2I9mwct8e9acePP1unDRkm+5xT5N/9wLEtltnNgrZeuy
        Vkodior89nqT1MqfHHpOG/r7TK1uTlx/ympPZdHkGwe0/06bcTh8QsaautVZvXGrf6euF11x
        e4KfxOKG5Ithc4PF3skd21G1dj7/nMoqrT1BzdPiz7dJuf2T9bOeLKvSd71n9drkje88N8Zw
        fl6X6vE4oSpOoF/T2sIqyuyS5uRUxzrdnzmnLIWv+qyO5Oa9qNae+Du5eMnFqTuNvrHwfTVo
        TNxSVL/n48nDh2PuCUq6SBUW9kadter0/rnkZ/hq1aedqo0bZkdP4a1L/TiJd+si1qu7vk4L
        W3vK6osSS3FGoqEWc1FxIgBCtczwyQIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we do coredump for user process signal, this may be an SIGBUS signal
with BUS_MCEERR_AR or BUS_MCEERR_AO code, which means this signal is
resulted from ECC memory fail like SRAR or SRAO, we expect the memory
recovery work is finished correctly, then the get_dump_page() will not
return the error page as its process pte is set invalid by
memory_failure().

But memory_failure() may fail, and the process's related pte may not be
correctly set invalid, for current code, we will return the poison page
and get it dumped and lead to system panic as its in kernel code.

So check the poison status in get_dump_page(), and if TRUE, return NULL.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 mm/gup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index e4c224c..499a496 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1536,6 +1536,14 @@ struct page *get_dump_page(unsigned long addr)
 				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
 	if (locked)
 		mmap_read_unlock(mm);
+
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) && ret == 1) {
+		if (unlikely(PageHuge(page) && PageHWPoison(compound_head(page))))
+			ret = 0;
+		else if (unlikely(PageHWPoison(page)))
+			ret = 0;
+	}
+
 	return (ret == 1) ? page : NULL;
 }
 #endif /* CONFIG_ELF_CORE */
-- 
1.8.3.1

