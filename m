Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D843E018E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhHDNCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:02:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7922 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbhHDNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:02:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GfsH839dZz83XM;
        Wed,  4 Aug 2021 20:58:12 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 21:02:03 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 21:01:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <chris@chrisdown.name>, <pmladek@suse.com>,
        <senozhatsky@chromium.org>, <rostedt@goodmis.org>,
        <john.ogness@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] printk/index: Fix -Wunused-function warning
Date:   Wed, 4 Aug 2021 21:01:05 +0800
Message-ID: <20210804130105.18732-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_MODULES is n, we got this:

kernel/printk/index.c:146:13: warning: ‘pi_remove_file’ defined but not used [-Wunused-function]

Move it inside #ifdef block to fix this warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/printk/index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/index.c b/kernel/printk/index.c
index 58d27272f992..d3709408debe 100644
--- a/kernel/printk/index.c
+++ b/kernel/printk/index.c
@@ -143,12 +143,12 @@ static void pi_create_file(struct module *mod)
 				       mod, &dfs_index_fops);
 }
 
+#ifdef CONFIG_MODULES
 static void pi_remove_file(struct module *mod)
 {
 	debugfs_remove(debugfs_lookup(pi_get_module_name(mod), dfs_index));
 }
 
-#ifdef CONFIG_MODULES
 static int pi_module_notify(struct notifier_block *nb, unsigned long op,
 			    void *data)
 {
-- 
2.17.1

