Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00A334A6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhCZL4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:56:11 -0400
Received: from m12-12.163.com ([220.181.12.12]:33630 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhCZLzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qmOVU
        bBT6UUgOqC+nqtqAfxo5EXyRbjGxCrrXHUkSkY=; b=OE282vqPxehvpHcP6Jnt0
        vHSIkxXunmFunj6W+2fuUnDATpyvtlgT4Kr9GJ+XkLACOwJnJquDnIVmkpNT3wLJ
        0o1jZfOSeYG71T1uy8RMrnMM9gxR7MQ6lfsZkFKYOToCCV0pTcI17BaN372LlrUL
        m/mmoiVvuyeNFdKQLiPFxE=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowACXG5hNy11gTlIqWg--.38911S2;
        Fri, 26 Mar 2021 19:53:52 +0800 (CST)
From:   dingsenjie@163.com
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] powerpc: powernv: Remove unneeded variable: "rc"
Date:   Fri, 26 Mar 2021 19:53:56 +0800
Message-Id: <20210326115356.12444-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowACXG5hNy11gTlIqWg--.38911S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1kJw4kAFykWr1UAw4UXFb_yoWkuFg_Jw
        48t3yYkrs7trWqy3s8Cw1fXryDA39agr1Utr1aga1akrnxKasxGrWDury3ZayxXr1jyFWD
        GFn8GrZ0kFyxAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8imRUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiThFhyFUDIa1M6gAAsK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Remove unneeded variable: "rc".

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 arch/powerpc/platforms/powernv/opal-prd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index deddaeb..a191f4c 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -105,7 +105,6 @@ static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	size_t addr, size;
 	pgprot_t page_prot;
-	int rc;
 
 	pr_devel("opal_prd_mmap(0x%016lx, 0x%016lx, 0x%lx, 0x%lx)\n",
 			vma->vm_start, vma->vm_end, vma->vm_pgoff,
@@ -121,10 +120,8 @@ static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma)
 	page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
 					 size, vma->vm_page_prot);
 
-	rc = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, size,
+	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, size,
 				page_prot);
-
-	return rc;
 }
 
 static bool opal_msg_queue_empty(void)
-- 
1.9.1


