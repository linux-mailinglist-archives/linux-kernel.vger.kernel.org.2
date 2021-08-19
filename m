Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60F3F10D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 04:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhHSC6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 22:58:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13444 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhHSC61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:58:27 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gqq993m5vzdc7k;
        Thu, 19 Aug 2021 10:54:05 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 10:57:50 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 10:57:49 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tong Tiangen" <tongtiangen@huawei.com>
Subject: [PATCH -next 2/2] riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for write killable
Date:   Thu, 19 Aug 2021 03:06:50 +0000
Message-ID: <20210819030650.716478-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210819030650.716478-1-tongtiangen@huawei.com>
References: <20210819030650.716478-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv architectures relying on mmap_sem for write in their
arch_setup_additional_pages. If the waiting task gets killed by the oom killer
it would block oom_reaper from asynchronous address space reclaim and reduce
the chances of timely OOM resolving.  Wait for the lock in the killable mode
and return with EINTR if the task got killed while waiting.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/riscv/kernel/vdso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 5fecd5529eff..54629c11c639 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -73,7 +73,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 	vdso_len = (vdso_pages + VVAR_NR_PAGES) << PAGE_SHIFT;
 
-	mmap_write_lock(mm);
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
 	vdso_base = get_unmapped_area(NULL, 0, vdso_len, 0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
 		ret = vdso_base;
-- 
2.18.0.huawei.25

