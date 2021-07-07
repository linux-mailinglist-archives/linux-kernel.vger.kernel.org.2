Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D333BEA53
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhGGPIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:08:24 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:39347 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhGGPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:08:22 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210707150541epoutp02f39d42c8c65f1c9c1653ad783c4eb94d~Pio-ywJf01849818498epoutp027
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:05:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210707150541epoutp02f39d42c8c65f1c9c1653ad783c4eb94d~Pio-ywJf01849818498epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625670341;
        bh=Nu7PfJjCtWVRTW61Q4wznKtwiU60A+jrReXpZWdnrew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uP+CLyn/jm5XBnK2i89WFmvJ6VIhmOlxZcZbKrrumath/tO58OOSV9XjEsDM6yXR6
         42FKZmiGSp3+X3TNwfVRItB9QEuyijv9Ql1oAWO8TamcIEEY2VE9RQV6YSHW4JAkc1
         Ws/H874J6fBauLJAc/Uc0BCCp/xq64t6+l0VrYvU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210707150540epcas1p47228373b8397b4ec0fbf75fb7a09944c~Pio-GzkSQ2556725567epcas1p4H;
        Wed,  7 Jul 2021 15:05:40 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GKjR73FZWz4x9Pw; Wed,  7 Jul
        2021 15:05:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.46.09468.3C2C5E06; Thu,  8 Jul 2021 00:05:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210707150538epcas1p2b2424d8303874d62d3ede60c38db6b59~Pio9kG32D0400804008epcas1p2I;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210707150538epsmtrp10fb213ab2216b92da0e966f1244307f2~Pio9eOpJ43041830418epsmtrp1j;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
X-AuditID: b6c32a37-0c7ff700000024fc-7a-60e5c2c39668
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.E7.08394.2C2C5E06; Thu,  8 Jul 2021 00:05:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210707150538epsmtip281dbc6f35b95aa9a88a820967a9669f1~Pio9UfKUd0863308633epsmtip2_;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] mm: sparse: pass section_nr to find_memory_block
Date:   Thu,  8 Jul 2021 00:02:11 +0900
Message-Id: <20210707150212.855-3-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707150212.855-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmvu7hQ08TDN6sErGYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjJO7dvJVHBIvOJ8o3MDY6NIFyMnh4SAicTm
        wweYuhi5OIQEdjBKTPs1gw3C+cQocXXedyaQKiGBb4wSvYc4YDqmN25khijayyjRMG89M1zH
        nomz2EGq2AS0Jfb3nmAGsUUEoiVmX+0Am8QsUCDR0P+JpYuRg0NYwEOi6bAbiMkioCrxrMkW
        pIJXwEriyp6rzBC75CVWbzgAZnMKWEtcXnePFWSVhMBLdom+tm4WiCIXids7J7JB2MISr45v
        YYewpSRe9rexQzT0M0oc6tsO1T2BUWJ9VyM7yGYJAXuJ95csQExmAU2J9bv0IXoVJXb+nssI
        cTKfxLuvPawQ1bwSHW1CEKaqxLLfHhDV0hJ90y9DXeAhsfDffXZIiPQxSvzYe4t1AqPcLIQF
        CxgZVzGKpRYU56anFhsWGCNH1yZGcNrTMt/BOO3tB71DjEwcjIcYJTiYlUR4GR2eJgjxpiRW
        VqUW5ccXleakFh9iNAWG3URmKdHkfGDizSuJNzQ1MjY2tjAxMzczNVYS593JdihBSCA9sSQ1
        OzW1ILUIpo+Jg1OqgemghZbq1ssV7s2XZhjcsgn49NdOaee5c0cL2UQj5lz5qjgx0plbVO/j
        846O9Yczr/B5Bvg/sl7gvXubodz9CyY2a5JkvYPeGKi6fWxwX/m3wLfGp0jlE9//9JepP8V2
        qYe1Sxlr/nv3vnJ2QcwWBtbNeSVx0Stfmj08FMUzNWemw1Wmu33edm5pjgusDj1kmLtPM3g2
        I5vi18vr79uXtsdX7WivrTQN+OAq/MC/Nt+/0bKlZMGNdXLcnpxpYjIP192psJhwVLvlks7L
        ZkHHpdafK3ZP0JmUnvzWe6Jcj+nHBaeUNB98Ldcqevo6Xf3L+VlLtvSarONaPOf4l1IuZnuF
        RfktBw4Isj7p2dv8SomlOCPRUIu5qDgRAMcVDF8EBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvO6hQ08TDNZ8MbCYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUVw2Kak5mWWpRfp2CVwZp/btZCo4JF5xvtG5
        gbFRpIuRk0NCwERieuNG5i5GLg4hgd2MEi+uzWKFSEhLPH2xi6WLkQPIFpY4fLgYouYDo8SK
        zW+YQWrYBLQl9veeYAapERGIl5h/jR0kzCxQJnF15V9WkLCwgIdE02E3EJNFQFXiWZMtSAWv
        gJXElT1XmSEWyUus3nAAzOYUsJa4vO4eWKcQUE3TEocJjHwLGBlWMUqmFhTnpucWGxYY5qWW
        6xUn5haX5qXrJefnbmIEB6aW5g7G7as+6B1iZOJgPMQowcGsJMLL6PA0QYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmjZYTzy9LdIbwfuV7UWeT9WnR
        4RcRSdlNznf8nbPdnBx17pduPFZ0Mb9R6r2Lxg+GbyvnLPv34V1uYvJmjknCM8/udDpx8ole
        zY2lfa0bX0WKzVmw9jtrTX95e1jg1YRDR6NKrqSn2YqGZ8dW25nu/JXofn6yAPfqCR0BpZuq
        p6tNzd52KE6/TV6E53bbXcb4wxL7OCd3XzLeMEHy4rlqkYnPU0unmXoETVJJ2z9ZfdO3xu3n
        Z0+KT07iaXW7s4+lcM5seVvbMxN1/31eut/ux3qdoAu+F0wfvtx4XbL58v0b9/9Zp/1zdF6y
        vmLC1dazi+4b8VvP4EtZWdmffoB/l+kcQeWKP4c9fNg/8x95qcRSnJFoqMVcVJwIAEQGAbi7
        AgAA
X-CMS-MailID: 20210707150538epcas1p2b2424d8303874d62d3ede60c38db6b59
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210707150538epcas1p2b2424d8303874d62d3ede60c38db6b59
References: <20210707150212.855-1-ohoono.kwon@samsung.com>
        <CGME20210707150538epcas1p2b2424d8303874d62d3ede60c38db6b59@epcas1p2.samsung.com>
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

