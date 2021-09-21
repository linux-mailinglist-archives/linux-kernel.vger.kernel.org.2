Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA154135EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhIUPMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:12:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9898 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhIUPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:12:19 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HDPrm44YLz8yhV;
        Tue, 21 Sep 2021 23:06:16 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 23:10:48 +0800
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
Subject: [PATCH v2 4/4] nitro_enclaves: add kunit tests for physical contiguous region merging
Date:   Tue, 21 Sep 2021 23:10:39 +0800
Message-ID: <20210921151039.1502-5-longpeng2@huawei.com>
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

Add kunit tests for the physical contiguous memory region merging
functionality.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/virt/nitro_enclaves/ne_misc_test.c | 46 ++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_test.c b/drivers/virt/nitro_enclaves/ne_misc_test.c
index 3426c35..8532bec 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_test.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_test.c
@@ -2,7 +2,53 @@
 
 #include <kunit/test.h>
 
+#define MAX_PHYS_REGIONS	16
+
+struct phys_regions_test {
+	u64 paddr;
+	u64 size;
+	int expect_rc;
+	unsigned long expect_num;
+	u64 expect_last_paddr;
+	u64 expect_last_size;
+} phys_regions_testcases[] = {
+	{0x1000, 0x200000, -EINVAL, 0, ~0, ~0},
+	{0x200000, 0x1000, -EINVAL, 0, ~0, ~0},
+	{0x200000, 0x200000, 0, 1, 0x200000, 0x200000},
+	{0x0, 0x200000, 0, 2, 0x0, 0x200000},
+	{0x600000, 0x400000, 0, 3, 0x600000, 0x400000},
+	{0xa00000, 0x400000, 0, 3, 0x600000, 0x800000},
+	{0x1000, 0x200000, -EINVAL, 3, 0x600000, 0x800000},
+};
+
+static void ne_misc_test_set_phys_region(struct kunit *test)
+{
+	struct phys_contig_mem_region *regions;
+	size_t sz;
+	int i, rc;
+
+	sz = sizeof(*regions) + MAX_PHYS_REGIONS * sizeof(struct phys_mem_region);
+	regions = kunit_kzalloc(test, sz, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, regions != NULL);
+
+	for (i = 0; i < ARRAY_SIZE(phys_regions_testcases); i++) {
+		rc = ne_add_phys_memory_region(regions, phys_regions_testcases[i].paddr,
+					       phys_regions_testcases[i].size);
+		KUNIT_EXPECT_EQ(test, rc, phys_regions_testcases[i].expect_rc);
+		KUNIT_EXPECT_EQ(test, regions->num, phys_regions_testcases[i].expect_num);
+
+		if (phys_regions_testcases[i].expect_last_paddr == ~0ul)
+			continue;
+
+		KUNIT_EXPECT_EQ(test, regions->region[regions->num - 1].paddr,
+				phys_regions_testcases[i].expect_last_paddr);
+		KUNIT_EXPECT_EQ(test, regions->region[regions->num - 1].size,
+				phys_regions_testcases[i].expect_last_size);
+	}
+}
+
 static struct kunit_case ne_misc_test_cases[] = {
+	KUNIT_CASE(ne_misc_test_set_phys_region),
 	{}
 };
 
-- 
1.8.3.1

