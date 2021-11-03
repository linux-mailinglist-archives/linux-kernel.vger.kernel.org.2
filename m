Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955E94442F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhKCOD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:03:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25355 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhKCODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:03:23 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HkpFm4RPTzbhDY;
        Wed,  3 Nov 2021 21:55:56 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 22:00:41 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 22:00:40 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH v4 3/4] nitro_enclaves: Add KUnit tests setup for the misc device functionality
Date:   Wed, 3 Nov 2021 22:00:34 +0800
Message-ID: <20211103140035.2001-4-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20211103140035.2001-1-longpeng2@huawei.com>
References: <20211103140035.2001-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

Add the initial setup for the KUnit tests that will target the Nitro
Enclaves misc device functionality.

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
Changes v3 -> v4:
  - Nitro enclaves -> Nitro Enclaves   [Andra]
  - check the return code of "ne_misc_dev_test_init()"  [Andra]
  - GPL-2.0-or-later -> GPL-2.0  [Andra]

Changes v2 -> v3:
  - update the commit title and commit message.  [Andra]
  - use "misc_dev"/"misc device"/"MISC_DEV" to be more specific.  [Andra]
---
 drivers/virt/nitro_enclaves/Kconfig            |  9 ++++++++
 drivers/virt/nitro_enclaves/ne_misc_dev.c      | 31 ++++++++++++++++++++++++++
 drivers/virt/nitro_enclaves/ne_misc_dev_test.c | 17 ++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 drivers/virt/nitro_enclaves/ne_misc_dev_test.c

diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
index 8c9387a..a7e5020 100644
--- a/drivers/virt/nitro_enclaves/Kconfig
+++ b/drivers/virt/nitro_enclaves/Kconfig
@@ -18,3 +18,12 @@ config NITRO_ENCLAVES
 
 	  To compile this driver as a module, choose M here.
 	  The module will be called nitro_enclaves.
+
+config NITRO_ENCLAVES_MISC_DEV_TEST
+	bool "Tests for the misc device functionality of the Nitro Enclaves"
+	depends on NITRO_ENCLAVES && KUNIT=y
+	help
+	  Enable KUnit tests for the misc device functionality of the Nitro
+	  Enclaves. Select this option only if you will boot the kernel for
+	  the purpose of running unit tests (e.g. under UML or qemu). If
+	  unsure, say N.
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 3741ae7..ec46c12 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1754,8 +1754,37 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
+#if defined(CONFIG_NITRO_ENCLAVES_MISC_DEV_TEST)
+#include "ne_misc_dev_test.c"
+
+static inline int ne_misc_dev_test_init(void)
+{
+	return __kunit_test_suites_init(ne_misc_dev_test_suites);
+}
+
+static inline void ne_misc_dev_test_exit(void)
+{
+	__kunit_test_suites_exit(ne_misc_dev_test_suites);
+}
+#else
+static inline int ne_misc_dev_test_init(void)
+{
+	return 0;
+}
+
+static inline void ne_misc_dev_test_exit(void)
+{
+}
+#endif
+
 static int __init ne_init(void)
 {
+	int rc = 0;
+
+	rc = ne_misc_dev_test_init();
+	if (rc < 0)
+		return rc;
+
 	mutex_init(&ne_cpu_pool.mutex);
 
 	return pci_register_driver(&ne_pci_driver);
@@ -1766,6 +1795,8 @@ static void __exit ne_exit(void)
 	pci_unregister_driver(&ne_pci_driver);
 
 	ne_teardown_cpu_pool();
+
+	ne_misc_dev_test_exit();
 }
 
 module_init(ne_init);
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
new file mode 100644
index 0000000..6862e99
--- /dev/null
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+
+static struct kunit_case ne_misc_dev_test_cases[] = {
+	{}
+};
+
+static struct kunit_suite ne_misc_dev_test_suite = {
+	.name = "ne_misc_dev_test",
+	.test_cases = ne_misc_dev_test_cases,
+};
+
+static struct kunit_suite *ne_misc_dev_test_suites[] = {
+	&ne_misc_dev_test_suite,
+	NULL
+};
-- 
1.8.3.1

