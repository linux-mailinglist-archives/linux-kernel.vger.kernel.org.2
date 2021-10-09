Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E842756B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 03:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbhJIBfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 21:35:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13711 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhJIBfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 21:35:46 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HR6xD1SmhzWjNd;
        Sat,  9 Oct 2021 09:32:16 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 9 Oct 2021 09:33:47 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 9 Oct 2021 09:33:47 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH v3 4/4] nitro_enclaves: Add KUnit tests for contiguous physical memory regions merging
Date:   Sat, 9 Oct 2021 09:32:48 +0800
Message-ID: <20211009013248.1174-5-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20211009013248.1174-1-longpeng2@huawei.com>
References: <20211009013248.1174-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

Add KUnit tests for the contiguous physical memory regions merging
functionality from the Nitro Enclaves misc device logic.

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
Changes v2 -> v3:
  - update the commit title and commit message.  [Andra]
  - align the fileds in 'struct phys_regions_test'.  [Andra]
  - rename 'phys_regions_testcases' to 'phys_regions_test_cases'.  [Andra]
  - add comments before each test cases.  [Andra]
  - initialize the variables in ne_misc_dev_test_merge_phys_contig_memory_regions.  [Andra]
---
 drivers/virt/nitro_enclaves/ne_misc_dev_test.c | 136 +++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
index bcb755e..7bd6b34 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
@@ -2,7 +2,143 @@
 
 #include <kunit/test.h>
 
+#define MAX_PHYS_REGIONS	16
+#define INVALID_VALUE		(~0ull)
+
+struct phys_regions_test {
+	u64 paddr;
+	u64 size;
+	int expect_rc;
+	int expect_num;
+	u64 expect_last_paddr;
+	u64 expect_last_size;
+} phys_regions_test_cases[] = {
+	/*
+	 * Add the region from 0x1000 to (0x1000 + 0x200000 - 1):
+	 *   Expected result:
+	 *       Failed, start address is not 2M-aligned
+	 *
+	 * Now the instance of struct phys_contig_mem_regions is:
+	 *   num = 0
+	 *   region = {}
+	 */
+	{0x1000, 0x200000, -EINVAL, 0, INVALID_VALUE, INVALID_VALUE},
+
+	/*
+	 * Add the region from 0x200000 to (0x200000 + 0x1000 - 1):
+	 *   Expected result:
+	 *       Failed, size is not 2M-aligned
+	 *
+	 * Now the instance of struct phys_contig_mem_regions is:
+	 *   num = 0
+	 *   region = {}
+	 */
+	{0x200000, 0x1000, -EINVAL, 0, INVALID_VALUE, INVALID_VALUE},
+
+	/*
+	 * Add the region from 0x200000 to (0x200000 + 0x200000 - 1):
+	 *   Expected result:
+	 *       Successful
+	 *
+	 * Now the instance of struct phys_contig_mem_regions is:
+	 *   num = 1
+	 *   region = {
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
+	 * Now the instance of struct phys_contig_mem_regions is:
+	 *   num = 2
+	 *   region = {
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
+	 * Now the instance of struct phys_contig_mem_regions is:
+	 *   num = 3
+	 *   region = {
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
+	 * Now the instance of struct phys_contig_mem_regions is:
+	 *   num = 3
+	 *   region = {
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
+	 * Now the instance of struct phys_contig_mem_regions is:
+	 *   num = 3
+	 *   region = {
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
+	struct phys_contig_mem_regions *regions;
+	size_t sz = 0;
+	int rc = 0;
+	int i = 0;
+
+	sz = sizeof(*regions) + MAX_PHYS_REGIONS * sizeof(struct range);
+	regions = kunit_kzalloc(test, sz, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, regions != NULL);
+
+	for (i = 0; i < ARRAY_SIZE(phys_regions_test_cases); i++) {
+		struct phys_regions_test *entry = phys_regions_test_cases + i;
+
+		rc = ne_merge_phys_contig_memory_regions(regions,
+							 entry->paddr, entry->size);
+		KUNIT_EXPECT_EQ(test, rc, entry->expect_rc);
+		KUNIT_EXPECT_EQ(test, regions->num, entry->expect_num);
+
+		if (entry->expect_last_paddr == INVALID_VALUE)
+			continue;
+
+		KUNIT_EXPECT_EQ(test, regions->region[regions->num - 1].start,
+				entry->expect_last_paddr);
+		KUNIT_EXPECT_EQ(test, range_len(&regions->region[regions->num - 1]),
+				entry->expect_last_size);
+	}
+}
+
 static struct kunit_case ne_misc_dev_test_cases[] = {
+	KUNIT_CASE(ne_misc_dev_test_merge_phys_contig_memory_regions),
 	{}
 };
 
-- 
1.8.3.1

