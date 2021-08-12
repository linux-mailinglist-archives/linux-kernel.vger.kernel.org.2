Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1B33EA43E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhHLMEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:04:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17009 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbhHLMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:04:18 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GllcW6FSyzb19c;
        Thu, 12 Aug 2021 20:00:11 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 12
 Aug 2021 20:03:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/4] shmem: remove unneeded header file
Date:   Thu, 12 Aug 2021 20:03:48 +0800
Message-ID: <20210812120350.49801-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210812120350.49801-1-linmiaohe@huawei.com>
References: <20210812120350.49801-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mfill_atomic_install_pte() is introduced to install pte and update mmu
cache since commit bf6ebd97aba0 ("userfaultfd/shmem: modify
shmem_mfill_atomic_pte to use install_pte()"). So we should remove
tlbflush.h as update_mmu_cache() is not called here now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/shmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index bf4a47419521..41d2900153d9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -39,8 +39,6 @@
 #include <linux/frontswap.h>
 #include <linux/fs_parser.h>
 
-#include <asm/tlbflush.h> /* for arch/microblaze update_mmu_cache() */
-
 static struct vfsmount *shm_mnt;
 
 #ifdef CONFIG_SHMEM
-- 
2.23.0

