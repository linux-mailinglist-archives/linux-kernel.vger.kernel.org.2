Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A74135EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhIUPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:12:21 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9750 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbhIUPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:12:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HDPwf5dkLzW8bW;
        Tue, 21 Sep 2021 23:09:38 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 23:10:47 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 23:10:47 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        <gregkh@linuxfoundation.org>, <kamal@canonical.com>,
        <pbonzini@redhat.com>, <sgarzare@redhat.com>,
        <stefanha@redhat.com>, <vkuznets@redhat.com>,
        <ne-devel-upstream@amazon.com>,
        "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v2 3/4] nitro_enclaves: add test framework for the misc functionality
Date:   Tue, 21 Sep 2021 23:10:38 +0800
Message-ID: <20210921151039.1502-4-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20210921151039.1502-1-longpeng2@huawei.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test framework for the misc functionality.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/virt/nitro_enclaves/Kconfig        |  8 ++++++++
 drivers/virt/nitro_enclaves/ne_misc_dev.c  | 27 +++++++++++++++++++++++++++
 drivers/virt/nitro_enclaves/ne_misc_test.c | 17 +++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 drivers/virt/nitro_enclaves/ne_misc_test.c

diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
index 8c9387a..24c54da 100644
--- a/drivers/virt/nitro_enclaves/Kconfig
+++ b/drivers/virt/nitro_enclaves/Kconfig
@@ -18,3 +18,11 @@ config NITRO_ENCLAVES
 
 	  To compile this driver as a module, choose M here.
 	  The module will be called nitro_enclaves.
+
+config NITRO_ENCLAVES_MISC_TEST
+	bool "Tests for the misc functionality of Nitro enclaves"
+	depends on NITRO_ENCLAVES && KUNIT=y
+	help
+	  Enable KUnit tests for the misc functionality of Nitro Enclaves. Select
+	  this option only if you will boot the kernel for the purpose of running
+	  unit tests (e.g. under UML or qemu). If unsure, say N.
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index d551b88..0131e1b 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1735,8 +1735,33 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
+#if defined(CONFIG_NITRO_ENCLAVES_MISC_TEST)
+#include "ne_misc_test.c"
+
+static inline int ne_misc_test_init(void)
+{
+	return __kunit_test_suites_init(ne_misc_test_suites);
+}
+
+static inline void ne_misc_test_exit(void)
+{
+	__kunit_test_suites_exit(ne_misc_test_suites);
+}
+#else
+static inline int ne_misc_test_init(void)
+{
+	return 0;
+}
+
+static inline void ne_misc_test_exit(void)
+{
+}
+#endif
+
 static int __init ne_init(void)
 {
+	ne_misc_test_init();
+
 	mutex_init(&ne_cpu_pool.mutex);
 
 	return pci_register_driver(&ne_pci_driver);
@@ -1747,6 +1772,8 @@ static void __exit ne_exit(void)
 	pci_unregister_driver(&ne_pci_driver);
 
 	ne_teardown_cpu_pool();
+
+	ne_misc_test_exit();
 }
 
 module_init(ne_init);
diff --git a/drivers/virt/nitro_enclaves/ne_misc_test.c b/drivers/virt/nitro_enclaves/ne_misc_test.c
new file mode 100644
index 0000000..3426c35
--- /dev/null
+++ b/drivers/virt/nitro_enclaves/ne_misc_test.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <kunit/test.h>
+
+static struct kunit_case ne_misc_test_cases[] = {
+	{}
+};
+
+static struct kunit_suite ne_misc_test_suite = {
+	.name = "ne_misc_test",
+	.test_cases = ne_misc_test_cases,
+};
+
+static struct kunit_suite *ne_misc_test_suites[] = {
+	&ne_misc_test_suite,
+	NULL
+};
-- 
1.8.3.1

