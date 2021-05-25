Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2759038FDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhEYJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:29:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:4001 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhEYJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:29:20 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fq7wT0gkXzmbRj;
        Tue, 25 May 2021 17:25:29 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 17:27:49 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 17:27:48 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <jeyu@kernel.org>
CC:     <sfr@canb.auug.org.au>, <swboyd@chromium.org>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>
Subject: [PATCH -next v2] module: fix build error when CONFIG_SYSFS is disabled
Date:   Tue, 25 May 2021 18:50:49 +0800
Message-ID: <20210525105049.34804-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when disable CONFIG_SYSFS:
kernel/module.c:2805:8: error: implicit declaration of function ‘sect_empty’; did you mean ‘desc_empty’? [-Werror=implicit-function-declaration]
 2805 |   if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&

Fixes: 9ee6682aa528 ("module: add printk formats to add module build ID to stacktraces")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
Changes from v2:
Put the sect_empty() definition outside of #ifdef CONFIG_SYSFS.

 kernel/module.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index decf4601e943..0543b44db81d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1462,6 +1462,13 @@ resolve_symbol_wait(struct module *mod,
 	return ksym;
 }
 
+#ifdef CONFIG_KALLSYMS
+static inline bool sect_empty(const Elf_Shdr *sect)
+{
+	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
+}
+#endif
+
 /*
  * /sys/module/foo/sections stuff
  * J. Corbet <corbet@lwn.net>
@@ -1469,11 +1476,6 @@ resolve_symbol_wait(struct module *mod,
 #ifdef CONFIG_SYSFS
 
 #ifdef CONFIG_KALLSYMS
-static inline bool sect_empty(const Elf_Shdr *sect)
-{
-	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
-}
-
 struct module_sect_attr {
 	struct bin_attribute battr;
 	unsigned long address;
-- 
2.17.1

