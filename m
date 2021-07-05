Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD83BB9B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGEJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:02:00 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:42035 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhGEJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:01:59 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210705085921epoutp020319b37a145fa1f8a4892e7533ba7c97~O2WkjGUKs2926929269epoutp02-
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 08:59:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210705085921epoutp020319b37a145fa1f8a4892e7533ba7c97~O2WkjGUKs2926929269epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625475561;
        bh=Nu7PfJjCtWVRTW61Q4wznKtwiU60A+jrReXpZWdnrew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZHPGGILaNPR9fJy093DU25cdCp26kNqmfyVQwmXeJtxi5yBNIkLWSvOtOVXk7XdA
         Bwg9/5BppGCYctl5KFZs+D167PO8NQ2kU+KPm03oL3LS+SkXX1iao9Hvah+Gv6qNv8
         T6Ol6D+E80QidHhNv1E6HUm4uOnKJWYklmNIQp/Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210705085920epcas1p3c5bd47189ebc75d43ceb42bb52964cf5~O2WkDHkHL0462004620epcas1p3z;
        Mon,  5 Jul 2021 08:59:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GJKPM36wCz4x9Q1; Mon,  5 Jul
        2021 08:59:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.DA.09952.6E9C2E06; Mon,  5 Jul 2021 17:59:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210705085918epcas1p3fdaf2bc0de2f1017c3057aeb6e8c82a7~O2Wh-QiQU0407404074epcas1p3z;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210705085918epsmtrp1e6e6368dc4bde7f82e981771bb7d74ef~O2Wh_is8F0607106071epsmtrp1D;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
X-AuditID: b6c32a35-447ff700000026e0-10-60e2c9e67810
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.C4.08394.6E9C2E06; Mon,  5 Jul 2021 17:59:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705085918epsmtip20004ee30010958c1ff2d1d456c582996~O2WhyS4X_2653026530epsmtip2k;
        Mon,  5 Jul 2021 08:59:18 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mm: sparse: pass section_nr to find_memory_block
Date:   Mon,  5 Jul 2021 17:55:37 +0900
Message-Id: <20210705085538.14557-3-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705085538.14557-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmge6zk48SDG48V7GYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjJO7dvJVHBIvOJ8o3MDY6NIFyMHh4SAicSH
        O1ZdjFwcQgI7GCWmfT7BDuF8YpS4saWXGcL5xijxfcsPoAwnWMerqUtYIRJ7GSV+vFzHBJIA
        a1m1UwXEZhPQltjfe4IZxBYRiJaYfbUDrIZZoECiof8TC8hqYQEPif0fc0DCLAKqEiemLGcE
        sXkFbCR2P+tigtglL7F6wwGwMZwCthJ/Xz1hAdkrIfCWXeL/nm2MEEUuEr93fmGFsIUlXh3f
        AnWolMTL/jZ2iIZ+RolDfdtZIZwJjBLruxrZIQFgL/H+kgWIySygKbF+lz5Er6LEzt9zGSFu
        5pN497WHFaKaV6KjTQjCVJVY9tsDolpaom/6ZTYI20PiVO8GRkjwAC16vO004wRGuVkICxYw
        Mq5iFEstKM5NTy02LDBEjq5NjOC0p2W6g3Hi2w96hxiZOBgPMUpwMCuJ8IpMeZQgxJuSWFmV
        WpQfX1Sak1p8iNEUGHgTmaVEk/OBiTevJN7Q1MjY2NjCxMzczNRYSZx3J9uhBCGB9MSS1OzU
        1ILUIpg+Jg5OqQYm55Wd5hJ81XdOaHivNX9w9Twbw/OF23r263pov9wX25RstpTT3+yJ/9mw
        Dg9T388POD/JHvX5K63m2qrzSnyysnTNnbKjllVlluZNf3i/PHy4Z/Ycvl/f05nNhRz2Tnaf
        4VB6YsKikOBjDjqSKz8k2jyXSJS7tMOs+ZVPXCHLnJiWEjsZ9bMckWkXfCfs33f0tXXms7MS
        F3n7ngtt4KypXnaaY5JzT3rupvNeFrkSHeuNxSRsjfJ+sSdFV2w1L9Tbzpl8b4ZhWfRx76uP
        PMQ26jUcD9gnuGTRLjtV/YshfnLqraaavkEHnrFYfks+siPwqPkOvpBa6R2xh15pcLuW7tLf
        YfJkFbOCUeCcV0osxRmJhlrMRcWJAAaQVhEEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvO6zk48SDC4e4rOYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUVw2Kak5mWWpRfp2CVwZp/btZCo4JF5xvtG5
        gbFRpIuRk0NCwETi1dQlrF2MXBxCArsZJZ69ncwGkZCWePpiF0sXIweQLSxx+HAxRM0HRok3
        J18wgtSwCWhL7O89wQxSIyIQLzH/GjtImFmgTOLqyr+sIGFhAQ+J/R9zQMIsAqoSJ6YsB+vk
        FbCR2P2siwlik7zE6g0HmEFsTgFbib+vnoBtFQKqmbApdAIj3wJGhlWMkqkFxbnpucWGBYZ5
        qeV6xYm5xaV56XrJ+bmbGMGhqaW5g3H7qg96hxiZOBgPMUpwMCuJ8IpMeZQgxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1PrziWLFIu+nkv+elrqI0/x
        3wNXb56yeModHrXf2f6a8CtF/Vc8t69YxKx+OTf0tPAu4Y2J1bWqFgrrs1gZ7n3ZZ1/js+TA
        vZ9Pyy9H/3uSuML5/m2Dadw9E5fc7JrD/P/d27IXKXpzL4jl7wlLOdP2KNpJgNO+rvvB4YKr
        ruVf2ZLn9tuWPlCdO/9WWufDSwpxGtxq2XGTT89Ukq/bt8T5UfpeNWcmHslnIpPO/W4TuObK
        z6VjWDnp5c5IhtY5Z89u/3LrusSObmdBfU23u2clthaevq2fsSzGxa373O7cgt+GLKs9nx8W
        r1z4KGj3z8juUuHbykZcpsJJ7atN6+OrBcpsvuxp+aD+fTb30ltKLMUZiYZazEXFiQCWUt6u
        vAIAAA==
X-CMS-MailID: 20210705085918epcas1p3fdaf2bc0de2f1017c3057aeb6e8c82a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705085918epcas1p3fdaf2bc0de2f1017c3057aeb6e8c82a7
References: <20210705085538.14557-1-ohoono.kwon@samsung.com>
        <CGME20210705085918epcas1p3fdaf2bc0de2f1017c3057aeb6e8c82a7@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
mem_section to section_nr could be costly since it iterates all
section roots to check if the given mem_section is in its range.

On the other hand, __nr_to_section() which converts section_nr to
mem_section can be done in O(1).

Let's pass section_nr instead of mem_section ptr to
find_memory_block() in order to reduce needless iterations.

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 4 +---
 drivers/base/memory.c                           | 4 ++--
 include/linux/memory.h                          | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 377d852f5a9a..d4f28ee4d5dc 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -211,13 +211,11 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
 static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
 {
 	unsigned long section_nr;
-	struct mem_section *mem_sect;
 	struct memory_block *mem_block;
 
 	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
-	mem_sect = __nr_to_section(section_nr);
 
-	mem_block = find_memory_block(mem_sect);
+	mem_block = find_memory_block(section_nr);
 	return mem_block;
 }
 
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index d5ffaab3cb61..e31598955cc4 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -578,9 +578,9 @@ static struct memory_block *find_memory_block_by_id(unsigned long block_id)
 /*
  * Called under device_hotplug_lock.
  */
-struct memory_block *find_memory_block(struct mem_section *section)
+struct memory_block *find_memory_block(unsigned long section_nr)
 {
-	unsigned long block_id = memory_block_id(__section_nr(section));
+	unsigned long block_id = memory_block_id(section_nr);
 
 	return find_memory_block_by_id(block_id);
 }
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 97e92e8b556a..d9a0b61cd432 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -90,7 +90,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
-extern struct memory_block *find_memory_block(struct mem_section *);
+extern struct memory_block *find_memory_block(unsigned long section_nr);
 typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t func);
-- 
2.17.1

