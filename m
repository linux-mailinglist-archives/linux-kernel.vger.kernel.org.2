Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E212E447338
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhKGOMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:12:19 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27117 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhKGOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:12:16 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HnGJy26y2z1DJ9M;
        Sun,  7 Nov 2021 22:07:14 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sun, 7 Nov 2021 22:09:24 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sun, 7 Nov 2021 22:09:23 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH v5 3/4] nitro_enclaves: Add KUnit tests setup for the misc device functionality
Date:   Sun, 7 Nov 2021 22:09:16 +0800
Message-ID: <20211107140918.2106-4-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20211107140918.2106-1-longpeng2@huawei.com>
References: <20211107140918.2106-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

Add the initial setup for the KUnit tests that will target the Nitro
Enclaves misc device functionality.

Signed-off-by: Longpeng <longpeng2@huawei.com>
Reviewed-by: Andra Paraschiv <andraprs@amazon.com>
---
 drivers/virt/nitro_enclaves/Kconfig            |  9 ++++++++
 drivers/virt/nitro_enclaves/ne_misc_dev.c      | 31 ++++++++++++++++++++++++++
 drivers/virt/nitro_enclaves/ne_misc_dev_test.c | 17 ++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 drivers/virt/nitro_enclaves/ne_misc_dev_test.c

diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
index f53740b..2d3d981 100644
--- a/drivers/virt/nitro_enclaves/Kconfig
+++ b/drivers/virt/nitro_enclaves/Kconfig
@@ -14,3 +14,12 @@ config NITRO_ENCLAVES
 
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
index 83ed9b5..51ba4ca 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1756,8 +1756,37 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
@@ -1768,6 +1797,8 @@ static void __exit ne_exit(void)
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

