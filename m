Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4333FDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 04:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhCRDTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 23:19:17 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:15637 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhCRDSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 23:18:53 -0400
X-AuditID: 0a580155-1f5ff7000005482e-02-6052beded67c
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id DD.17.18478.EDEB2506; Thu, 18 Mar 2021 10:45:50 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 18 Mar
 2021 11:18:51 +0800
Date:   Thu, 18 Mar 2021 11:18:45 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     David Hildenbrand <david@redhat.com>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yangfeng1@kingsoft.com>, <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>, <yaoaili@kingsoft.com>
Subject: [PATCH v2] mm/gup: check page posion status for coredump.
Message-ID: <20210318111845.3d06141c@alex-virtual-machine>
In-Reply-To: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
References: <20210317163714.328a038d@alex-virtual-machine>
        <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXCFcGooHtvX1CCwd7v+hZz1q9hs/i6/hez
        xeVdc9gs7q35z2rxcX+wxcXGA4wWZ6YVObB7bPo0id3jxIzfLB4vrm5k8fj49BaLx/t9V9k8
        Np+u9vi8SS6APYrLJiU1J7MstUjfLoEr4/LZ9+wF/4QrznY/Zm9g/MffxcjJISFgInF+5l7W
        LkYuDiGB6UwSl188YIFwXjFK7Djbxg5SxSKgKvF89QoWEJsNyN51bxYriC0ioCGxqW0DM0gD
        s0Afk0THyiNgRcICThJr+7aAFfEKWEmcvHAeLM4pYCfx59NBRhBbSCBPYvGzpWwgNr+AmETv
        lf9MECfZS7RtWcQI0SsocXLmE7BeZgEdiROrjjFD2PIS29/OYYaYoyhxeMkvdoheJYkj3TPY
        IOxYiWXzXrFOYBSehWTULCSjZiEZtYCReRUjS3FuutEmRkh0hO5gnNH0Ue8QIxMH4yFGCQ5m
        JRFe07yABCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8jpFAKYH0xJLU7NTUgtQimCwTB6dUA9Pl
        45WRd1sMpx6bqctfcm/CikvHJcMdalkiZBxvME/65XRjO4NW7zuVnknZQpMS/yUFvJ+gtWm7
        cY445xc9o++5ISZCFtLSVUwsEnujHBrk7IM3h/Udz/L1fXwww+Mij3BncUJPXofsZn9Hz9Ud
        5S7bDslHubjHn05V+bXnsUGAS/+MjUv5OGYaMdUxKUza2Mg8V0p1/de3z+5GSmnteXZeStps
        wsoDd+5+Kfr5qkQ1JHqX0PF8vWU6flUBUWyxU7c6MU+Kl2Tf3p0tc/BLsaTApymCtbVLfsas
        LNzxIZc7hfV9XpOyyy2HO//+Vv7aVjnr+h3HxRM13DYtfC/ZfGUXY2G2mbLl/mvbvizdq8RS
        nJFoqMVcVJwIADCBtAj9AgAA
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

There maybe other scenario that is also better to check the posion status
and not to panic, so make a wrapper for this check, suggested by
David Hildenbrand <david@redhat.com>

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 mm/gup.c      |  4 ++++
 mm/internal.h | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index e4c224c..3b4703a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1536,6 +1536,10 @@ struct page *get_dump_page(unsigned long addr)
 				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
 	if (locked)
 		mmap_read_unlock(mm);
+
+	if (ret == 1 && check_user_page_poison(page))
+		return NULL;
+
 	return (ret == 1) ? page : NULL;
 }
 #endif /* CONFIG_ELF_CORE */
diff --git a/mm/internal.h b/mm/internal.h
index 25d2b2439..777b3e5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -97,6 +97,27 @@ static inline void set_page_refcounted(struct page *page)
 	set_page_count(page, 1);
 }
 
+/*
+ * When kernel touch the user page, the user page may be have been marked
+ * poison but still mapped in user space, if without this page, the kernel
+ * can guarantee the data integrity and operation success, the kernel is
+ * better to check the posion status and avoid touching it, be good not to
+ * panic, coredump for process fatal signal is a sample case matching this
+ * scenario. Or if kernel can't guarantee the data integrity, it's better
+ * not to call this function, let kernel touch the poison page and get to
+ * panic.
+ */
+static inline int check_user_page_poison(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) && page != NULL) {
+		if (unlikely(PageHuge(page) && PageHWPoison(compound_head(page))))
+			return true;
+		else if (unlikely(PageHWPoison(page)))
+			return true;
+	}
+	return 0;
+}
+
 extern unsigned long highest_memmap_pfn;
 
 /*
-- 
1.8.3.1

