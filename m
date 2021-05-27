Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692DE392C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhE0LHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:07:05 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2370 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhE0LHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:07:03 -0400
Received: from dggeml708-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FrPyk2xDJz660g;
        Thu, 27 May 2021 19:01:50 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggeml708-chm.china.huawei.com (10.3.17.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 19:05:28 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 19:05:28 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jeyu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] module: fix compile error that sect_empty() is not defined in init_build_id()
Date:   Thu, 27 May 2021 19:14:53 +0800
Message-ID: <20210527111453.195014-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'CONFIG_SYS' is not enabled while 'CONFIG_KALLSYMS' is enabled,
fix following compile error:

kernel/module.c:2805:8: error: implicit declaration of function ‘sect_empty’;
did you mean ‘desc_empty’? [-Werror=implicit-function-declaration]

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 kernel/module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index decf4601e943..173acb2aecc7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2794,7 +2794,8 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 }
 #endif /* CONFIG_KALLSYMS */
 
-#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+#if IS_ENABLED(CONFIG_SYSFS) && IS_ENABLED(CONFIG_KALLSYMS) &&\
+	IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
 static void init_build_id(struct module *mod, const struct load_info *info)
 {
 	const Elf_Shdr *sechdr;
-- 
2.25.4

