Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A94E38FBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhEYHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:32:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3656 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhEYHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:32:30 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fq5JC3gvdzQsMC;
        Tue, 25 May 2021 15:27:23 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 15:30:59 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 15:30:59 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <jeyu@kernel.org>
CC:     <sfr@canb.auug.org.au>, <swboyd@chromium.org>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>
Subject: [PATCH -next] module: fix build error when CONFIG_SYSFS is disabled
Date:   Tue, 25 May 2021 16:54:00 +0800
Message-ID: <20210525085400.15854-1-cuibixuan@huawei.com>
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
---
 kernel/module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index decf4601e943..7287ecc76714 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2794,7 +2794,8 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 }
 #endif /* CONFIG_KALLSYMS */
 
-#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) && \
+	IS_ENABLED(CONFIG_SYSFS)
 static void init_build_id(struct module *mod, const struct load_info *info)
 {
 	const Elf_Shdr *sechdr;
-- 
2.17.1

