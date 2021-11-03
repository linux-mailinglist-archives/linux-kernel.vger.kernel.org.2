Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750D94442F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhKCODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:03:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30915 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhKCODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:03:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HkpFn2xxhzcb0j;
        Wed,  3 Nov 2021 21:55:57 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 22:00:41 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 22:00:41 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH v4 4/4] nitro_enclaves: Add KUnit tests for contiguous physical memory regions merging
Date:   Wed, 3 Nov 2021 22:00:35 +0800
Message-ID: <20211103140035.2001-5-longpeng2@huawei.com>
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

Add KUnit tests for the contiguous physical memory regions merging
functionality from the Nitro Enclaves misc device logic.

We can build the test binary with the following configuration:
  CONFIG_KUNIT=y
  CONFIG_NITRO_ENCLAVES=m
  CONFIG_NITRO_ENCLAVES_MISC_DEV_TEST=y
and install the nitro_enclaves module to run the testcases.

We'll see the following message using dmesg if everything goes well:

[...]     # Subtest: ne_misc_dev_test
[...]     1..1
[...] (NULL device *): Physical mem region address is not 2 MiB aligned
[...] (NULL device *): Physical mem region size is not multiple of 2 MiB
[...] (NULL device *): Physical mem region address is not 2 MiB aligned
[...]     ok 1 - ne_misc_dev_test_merge_phys_contig_memory_regions
[...] ok 1 - ne_misc_dev_test

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
Changes v3 -> v4:
  - "int expect_num" -> "unsigned long  expect_num"  [Andra]
  - rename several variables and structures  [Andra]
  - invoke "kunit_kfree" to free the "regions"  [Andra]

Changes v2 -> v3:
  - update the commit title and commit message.  [Andra]
  - align the fileds in 'struct phys_regions_test'.  [Andra]
  - rename 'phys_regions_testcases' to 'phys_regions_test_cases'.  [Andra]
  - add comments before each test cases.  [Andra]
  - initialize the variables in ne_misc_dev_test_merge_phys_contig_memory_regions.  [Andra]
---
 drivers/virt/nitro_enclaves/ne_misc_dev_test.c | 139 +++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
index 6862e99..4648ec02 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
@@ -2,7 +2,146 @@
 
 #include <kunit/test.h>
 
+#define MAX_PHYS_REGIONS	16
+#define INVALID_VALUE		(~0ull)
+
+struct ne_phys_regions_test {
+	u64           paddr;
+	u64           size;
+	int           expect_rc;
+	unsigned long expect_num;
+	u64           expect_last_paddr;
+	u64           expect_last_size;
+} phys_regions_test_cases[] = {
+	/*
+	 * Add the region from 0x1000 to (0x1000 + 0x200000 - 1):
+	 *   Expected result:
+	 *       Failed, start address is not 2M-aligned
+	 *
+	 * Now the instance of struct ne_phys_contig_mem_regions is:
+	 *   num = 0
+	 *   regions = {}
+	 */
+	{0x1000, 0x200000, -EINVAL, 0, INVALID_VALUE, INVALID_VALUE},
+
+	/*
+	 * Add the region from 0x200000 to (0x200000 + 0x1000 - 1):
+	 *   Expected result:
+	 *       Failed, size is not 2M-aligned
+	 *
+	 * Now the instance of struct ne_phys_contig_mem_regions is:
+	 *   num = 0
+	 *   regions = {}
+	 */
+	{0x200000, 0x1000, -EINVAL, 0, INVALID_VALUE, INVALID_VALUE},
+
+	/*
+	 * Add the region from 0x200000 to (0x200000 + 0x200000 - 1):
+	 *   Expected result:
+	 *       Successful
+	 *
+	 * Now the instance of struct ne_phys_contig_mem_regions is:
+	 *   num = 1
+	 *   regions = {
+	 *       {start=0x200000, end=0x3fffff}, // len=0x200000
+	 *   }
+	 */
+	{0x200000, 0x200000, 0, 1, 0x200000, 0x200000},
+
+	/*
+	 * Add the region from 0x0 to (0x0 + 0x200000 - 1):
+	 *   Expected result:
+	 *       Successful
+	 *
+	 * Now the instance of struct ne_phys_contig_mem_regions is:
+	 *   num = 2
+	 *   regions = {
+	 *       {start=0x200000, end=0x3fffff}, // len=0x200000
+	 *       {start=0x0,      end=0x1fffff}, // len=0x200000
+	 *   }
+	 */
+	{0x0, 0x200000, 0, 2, 0x0, 0x200000},
+
+	/*
+	 * Add the region from 0x600000 to (0x600000 + 0x400000 - 1):
+	 *   Expected result:
+	 *       Successful
+	 *
+	 * Now the instance of struct ne_phys_contig_mem_regions is:
+	 *   num = 3
+	 *   regions = {
+	 *       {start=0x200000, end=0x3fffff}, // len=0x200000
+	 *       {start=0x0,      end=0x1fffff}, // len=0x200000
+	 *       {start=0x600000, end=0x9fffff}, // len=0x400000
+	 *   }
+	 */
+	{0x600000, 0x400000, 0, 3, 0x600000, 0x400000},
+
+	/*
+	 * Add the region from 0xa00000 to (0xa00000 + 0x400000 - 1):
+	 *   Expected result:
+	 *       Successful, merging case!
+	 *
+	 * Now the instance of struct ne_phys_contig_mem_regions is:
+	 *   num = 3
+	 *   regions = {
+	 *       {start=0x200000, end=0x3fffff}, // len=0x200000
+	 *       {start=0x0,      end=0x1fffff}, // len=0x200000
+	 *       {start=0x600000, end=0xdfffff}, // len=0x800000
+	 *   }
+	 */
+	{0xa00000, 0x400000, 0, 3, 0x600000, 0x800000},
+
+	/*
+	 * Add the region from 0x1000 to (0x1000 + 0x200000 - 1):
+	 *   Expected result:
+	 *       Failed, start address is not 2M-aligned
+	 *
+	 * Now the instance of struct ne_phys_contig_mem_regions is:
+	 *   num = 3
+	 *   regions = {
+	 *       {start=0x200000, end=0x3fffff}, // len=0x200000
+	 *       {start=0x0,      end=0x1fffff}, // len=0x200000
+	 *       {start=0x600000, end=0xdfffff}, // len=0x800000
+	 *   }
+	 */
+	{0x1000, 0x200000, -EINVAL, 3, 0x600000, 0x800000},
+};
+
+static void ne_misc_dev_test_merge_phys_contig_memory_regions(struct kunit *test)
+{
+	struct ne_phys_contig_mem_regions phys_contig_mem_regions = {};
+	int rc = 0;
+	int i = 0;
+
+	phys_contig_mem_regions.regions = kunit_kcalloc(test, MAX_PHYS_REGIONS,
+					sizeof(*phys_contig_mem_regions.regions), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, phys_contig_mem_regions.regions != NULL);
+
+	for (i = 0; i < ARRAY_SIZE(phys_regions_test_cases); i++) {
+		struct ne_phys_regions_test *test_case = &phys_regions_test_cases[i];
+		unsigned long num = 0;
+
+		rc = ne_merge_phys_contig_memory_regions(&phys_contig_mem_regions,
+							 test_case->paddr, test_case->size);
+		KUNIT_EXPECT_EQ(test, rc, test_case->expect_rc);
+		KUNIT_EXPECT_EQ(test, phys_contig_mem_regions.num, test_case->expect_num);
+
+		if (test_case->expect_last_paddr == INVALID_VALUE)
+			continue;
+
+		num = phys_contig_mem_regions.num;
+		KUNIT_EXPECT_EQ(test, phys_contig_mem_regions.regions[num - 1].start,
+				test_case->expect_last_paddr);
+		KUNIT_EXPECT_EQ(test, range_len(&phys_contig_mem_regions.regions[num - 1]),
+				test_case->expect_last_size);
+	}
+
+	kunit_kfree(test, phys_contig_mem_regions.regions);
+}
+
 static struct kunit_case ne_misc_dev_test_cases[] = {
+	KUNIT_CASE(ne_misc_dev_test_merge_phys_contig_memory_regions),
 	{}
 };
 
-- 
1.8.3.1

