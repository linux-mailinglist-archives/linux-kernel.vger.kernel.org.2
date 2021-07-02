Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBF3B9E7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhGBJrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:47:45 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22707 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhGBJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:47:33 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210702094459epoutp01ad1af15b14b248fd6ae757ce3e3130d6~N8CkKyq8Y2869228692epoutp01A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 09:44:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210702094459epoutp01ad1af15b14b248fd6ae757ce3e3130d6~N8CkKyq8Y2869228692epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625219099;
        bh=PZeug9R6FQNTHC+xQXAuKq+kM6dLfUDapXf6oc2oZIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsr65edLGuEavcVjdhi1a8+O5vPFEaFyAWJHQmgz3NrLOSUeVB29fo7nIssHXWczo
         EBlLCvEvHZEsFr+DMDIlLVPGNWoVdnPWWyy2zbYKWYuLo7rfk/0j9q9LLsOCxeO1LA
         BSegCKWHI7QYkRvmHVUYJSDgoKiD+8DCU7htFd9E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210702094459epcas1p281aafdc9c527ddefd3ddb64ad99e0cbb~N8CjyztZ92030120301epcas1p2p;
        Fri,  2 Jul 2021 09:44:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GGVYP657Zz4x9Py; Fri,  2 Jul
        2021 09:44:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.70.10119.910EED06; Fri,  2 Jul 2021 18:44:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210702094457epcas1p40fba85e22861cf1cc85a085719030c24~N8Ch0I1FG1021710217epcas1p4p;
        Fri,  2 Jul 2021 09:44:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210702094457epsmtrp21f13f7db8a4c2b91647677929a1f7b94~N8ChzU_TM0297302973epsmtrp2M;
        Fri,  2 Jul 2021 09:44:57 +0000 (GMT)
X-AuditID: b6c32a38-965ff70000002787-51-60dee019f743
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.E8.08394.810EED06; Fri,  2 Jul 2021 18:44:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210702094456epsmtip1f7ec03c85a419dad0e5b17fe413911c0~N8ChncmmR0979009790epsmtip1Y;
        Fri,  2 Jul 2021 09:44:56 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: sparse: pass section_nr to find_memory_block
Date:   Fri,  2 Jul 2021 18:41:31 +0900
Message-Id: <20210702094132.6276-3-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210702094132.6276-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmvq7kg3sJBhOu6FnMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORnn1gYUbBer2Db1OXsDY6twFyMnh4SAiUT/
        hpPMXYxcHEICOxglZu9bzgKSEBL4xChxt7sGIvGNUeLg0oNsMB3dt+4xQiT2Mkr87LvHBuEA
        dWx/voERpIpNQFtif+8JZhBbRCBaYvbVDiYQm1mgQKKh/xPYCmEBV4nVM3aC2SwCqhLPnk1g
        BbF5Bawlfj78D7VNXmL1hgNgczgFbCROdO5lBVkmIfCSXeLs9k2MEEUuElf7Z0HZwhKvjm9h
        h7ClJD6/28sG0dDPKHGobztU9wRGifVdjUBVHECOvcT7SxYgJrOApsT6XfoQvYoSO3/PZYQ4
        mk/i3dceVohqXomONiEIU1Vi2W8PiGppib7pl6FO9pBY9esxNICAtv5f2sk8gVFuFsKCBYyM
        qxjFUguKc9NTiw0LTJAjbBMjOPVpWexgnPv2g94hRiYOxkOMEhzMSiK8ofPuJQjxpiRWVqUW
        5ccXleakFh9iNAUG3kRmKdHkfGDyzSuJNzQ1MjY2tjAxMzczNVYS593JdihBSCA9sSQ1OzW1
        ILUIpo+Jg1OqgalFbkUlv8C0mIq1zy0PHKtfcOaZ22q57FuyJxo//jKcPSEvLLNMR13zH8f1
        C19m8Z1WeldTGr3z0Zmzf3Y2pzPsP3z0b12k+rknV/pFQrwaxE7NYGj+VbKE83ns7G0RqU6R
        HOviJm62Xie0cOkGpeJuiQhRXYPtHtwrztW+Dzq8a5HvvMRrp/JWGNgHz8uartl5N4Wt8UbK
        zySbjWeaQoySNl90C5reb5pw7qn4n5er7nUoznfwdCozm2jas7D5s7QZ/xvhvF1VnxJa7E/I
        O30seJ+RKn46fYVVkPuPrSZBvy/5On6bMTW1lvUPl8f7dx/jy66qT7MRYXlTuzbOa8qVTI7N
        pYFXGGddu9MhZajEUpyRaKjFXFScCADmkZdmBgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnK7Eg3sJBns7bCzmrF/DZnH+wS82
        i6/rfzFbXN41h83i3pr/rBb3+xws9u73tdj1cwWzxY0pDWwOnB47Z91l99j0aRK7x4kZv1k8
        Jiw6wOjxft9VNo++LasYPdZvucri8XmTXABHFJdNSmpOZllqkb5dAlfGubUBBdvFKrZNfc7e
        wNgq3MXIySEhYCLRfeseYxcjF4eQwG5GiWm9E1kgEtIST1/sArI5gGxhicOHiyFqPjBKbFz6
        khWkhk1AW2J/7wlmkBoRgXiJ+dfYQcLMAmUSV1f+BSsRFnCVWD1jJ9hIFgFViWfPJoDFeQWs
        JX4+/M8GsUpeYvWGA8wgNqeAjcSJzr1gNUJANZ93H2efwMi3gJFhFaNkakFxbnpusWGBYV5q
        uV5xYm5xaV66XnJ+7iZGcHhqae5g3L7qg94hRiYOxkOMEhzMSiK8ofPuJQjxpiRWVqUW5ccX
        leakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAlL9PkGPBhOcrv8ncZz21sJzt
        3+KLz/eni0e8SUjatWy66umMPW4qfPKcRz6vzPnAP1nn+E+ztJgL836bnLf15FzNLfhw4jq1
        9b5b4izMnGbe414ot9zk+PJzG3U+tfjp6Ww9ssT1y6KJy29L61l0OXzl0p0TFMca1Fp9QuqU
        UqXUx78eelI3rDSFeN7X3C18yHnqmeiCTftvBrb++ZSX8n3yooBrn+f3r3Ja6O88NWyr2auV
        m+Xjwz3jP5Qw/3bmdnnyKqBRiOO7lxl7+rVTdf7tLZd/+vZ5Zs790lgormH90n/ztaXHjP68
        KV7m3OhjZWM201vJxK5v5e3wJe/rBCR/3noUP0HOaOWWpnMh3UosxRmJhlrMRcWJANc2qL2+
        AgAA
X-CMS-MailID: 20210702094457epcas1p40fba85e22861cf1cc85a085719030c24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210702094457epcas1p40fba85e22861cf1cc85a085719030c24
References: <20210702094132.6276-1-ohoono.kwon@samsung.com>
        <CGME20210702094457epcas1p40fba85e22861cf1cc85a085719030c24@epcas1p4.samsung.com>
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
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 4 +---
 drivers/base/memory.c                           | 4 ++--
 include/linux/memory.h                          | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 8377f1f7c78e..905790092e0e 100644
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

