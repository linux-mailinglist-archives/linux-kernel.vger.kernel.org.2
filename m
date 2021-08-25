Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EF73F7191
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbhHYJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:18:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18038 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbhHYJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:18:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GvgJD5blFzbhGf;
        Wed, 25 Aug 2021 17:13:32 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:17:22 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:17:22 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 4/4] mm: kfence: Only load kfence_test when kfence is enabled
Date:   Wed, 25 Aug 2021 17:21:16 +0800
Message-ID: <20210825092116.149975-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide kfence_is_enabled() helper, only load kfence_test module
when kfence is enabled.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/kfence.h  | 2 ++
 mm/kfence/core.c        | 8 ++++++++
 mm/kfence/kfence_test.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 3fe6dd8a18c1..f08f24e8a726 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -22,6 +22,8 @@
 #define KFENCE_POOL_SIZE ((CONFIG_KFENCE_NUM_OBJECTS + 1) * 2 * PAGE_SIZE)
 extern char *__kfence_pool;
 
+bool kfence_is_enabled(void);
+
 #ifdef CONFIG_KFENCE_STATIC_KEYS
 #include <linux/static_key.h>
 DECLARE_STATIC_KEY_FALSE(kfence_allocation_key);
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 7a97db8bc8e7..f1aaa7ebdcad 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -51,6 +51,14 @@ static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE
 #endif
 #define MODULE_PARAM_PREFIX "kfence."
 
+bool kfence_is_enabled(void)
+{
+	if (!kfence_sample_interval || !READ_ONCE(kfence_enabled))
+		return false;
+	return true;
+}
+EXPORT_SYMBOL_GPL(kfence_is_enabled);
+
 static int param_set_sample_interval(const char *val, const struct kernel_param *kp)
 {
 	unsigned long num;
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index eb6307c199ea..4087f9f1497e 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -847,6 +847,8 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
  */
 static int __init kfence_test_init(void)
 {
+	if (!kfence_is_enabled())
+		return 0;
 	/*
 	 * Because we want to be able to build the test as a module, we need to
 	 * iterate through all known tracepoints, since the static registration
-- 
2.26.2

