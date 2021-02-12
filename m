Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913F531A2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhBLQdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:33:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:44491 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhBLQ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:27:42 -0500
IronPort-SDR: qfWInwRrtqWrGQyr8UoeZg5aKfdUv3x78M88A6nPkj1ePd5E0P67rGuUcv/XNrf+Zg1gVIMaco
 MrPkzjCG1M8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="201586481"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="201586481"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 08:25:51 -0800
IronPort-SDR: tzC/7NJyV3HMd421pvXXeXiDSVx4gH+MUZQpy3xrx7IcbaBekNnTb569rJb6GA3IjUQbuy8OKH
 odlqwNLS6SoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="415940678"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 12 Feb 2021 08:25:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 387A51FA; Fri, 12 Feb 2021 18:25:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] device property: Add test cases for fwnode_property_count_*() APIs
Date:   Fri, 12 Feb 2021 18:25:39 +0200
Message-Id: <20210212162539.86850-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test cases for fwnode_property_count_*() APIs.

While at it, modify the arrays of integers to be size of non-power-of-2
for better test coverage and decreasing stack usage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/test/property-entry-test.c | 50 +++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
index abe03315180f..3a4f755c483c 100644
--- a/drivers/base/test/property-entry-test.c
+++ b/drivers/base/test/property-entry-test.c
@@ -27,6 +27,9 @@ static void pe_test_uints(struct kunit *test)
 	node = fwnode_create_software_node(entries, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
 
+	error = fwnode_property_count_u8(node, "prop-u8");
+	KUNIT_EXPECT_EQ(test, error, 1);
+
 	error = fwnode_property_read_u8(node, "prop-u8", &val_u8);
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
@@ -48,6 +51,9 @@ static void pe_test_uints(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
 
+	error = fwnode_property_count_u16(node, "prop-u16");
+	KUNIT_EXPECT_EQ(test, error, 1);
+
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
@@ -65,6 +71,9 @@ static void pe_test_uints(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
 
+	error = fwnode_property_count_u32(node, "prop-u32");
+	KUNIT_EXPECT_EQ(test, error, 1);
+
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
@@ -82,6 +91,9 @@ static void pe_test_uints(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
 
+	error = fwnode_property_count_u64(node, "prop-u64");
+	KUNIT_EXPECT_EQ(test, error, 1);
+
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
@@ -95,15 +107,19 @@ static void pe_test_uints(struct kunit *test)
 	error = fwnode_property_read_u64_array(node, "no-prop-u64", array_u64, 1);
 	KUNIT_EXPECT_NE(test, error, 0);
 
+	/* Count 64-bit values as 16-bit */
+	error = fwnode_property_count_u16(node, "prop-u64");
+	KUNIT_EXPECT_EQ(test, error, 4);
+
 	fwnode_remove_software_node(node);
 }
 
 static void pe_test_uint_arrays(struct kunit *test)
 {
-	static const u8 a_u8[16] = { 8, 9 };
-	static const u16 a_u16[16] = { 16, 17 };
-	static const u32 a_u32[16] = { 32, 33 };
-	static const u64 a_u64[16] = { 64, 65 };
+	static const u8 a_u8[10] = { 8, 9 };
+	static const u16 a_u16[10] = { 16, 17 };
+	static const u32 a_u32[10] = { 32, 33 };
+	static const u64 a_u64[10] = { 64, 65 };
 	static const struct property_entry entries[] = {
 		PROPERTY_ENTRY_U8_ARRAY("prop-u8", a_u8),
 		PROPERTY_ENTRY_U16_ARRAY("prop-u16", a_u16),
@@ -126,6 +142,9 @@ static void pe_test_uint_arrays(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
 
+	error = fwnode_property_count_u8(node, "prop-u8");
+	KUNIT_EXPECT_EQ(test, error, 10);
+
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
@@ -148,6 +167,9 @@ static void pe_test_uint_arrays(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
 
+	error = fwnode_property_count_u16(node, "prop-u16");
+	KUNIT_EXPECT_EQ(test, error, 10);
+
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
@@ -170,6 +192,9 @@ static void pe_test_uint_arrays(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
 
+	error = fwnode_property_count_u32(node, "prop-u32");
+	KUNIT_EXPECT_EQ(test, error, 10);
+
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
@@ -192,6 +217,9 @@ static void pe_test_uint_arrays(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
 
+	error = fwnode_property_count_u64(node, "prop-u64");
+	KUNIT_EXPECT_EQ(test, error, 10);
+
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
@@ -210,6 +238,14 @@ static void pe_test_uint_arrays(struct kunit *test)
 	error = fwnode_property_read_u64_array(node, "no-prop-u64", array_u64, 1);
 	KUNIT_EXPECT_NE(test, error, 0);
 
+	/* Count 64-bit values as 16-bit */
+	error = fwnode_property_count_u16(node, "prop-u64");
+	KUNIT_EXPECT_EQ(test, error, 40);
+
+	/* Other way around */
+	error = fwnode_property_count_u64(node, "prop-u16");
+	KUNIT_EXPECT_EQ(test, error, 2);
+
 	fwnode_remove_software_node(node);
 }
 
@@ -239,6 +275,9 @@ static void pe_test_strings(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_STREQ(test, str, "single");
 
+	error = fwnode_property_string_array_count(node, "str");
+	KUNIT_EXPECT_EQ(test, error, 1);
+
 	error = fwnode_property_read_string_array(node, "str", strs, 1);
 	KUNIT_EXPECT_EQ(test, error, 1);
 	KUNIT_EXPECT_STREQ(test, strs[0], "single");
@@ -258,6 +297,9 @@ static void pe_test_strings(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, error, 0);
 	KUNIT_EXPECT_STREQ(test, str, "");
 
+	error = fwnode_property_string_array_count(node, "strs");
+	KUNIT_EXPECT_EQ(test, error, 2);
+
 	error = fwnode_property_read_string_array(node, "strs", strs, 3);
 	KUNIT_EXPECT_EQ(test, error, 2);
 	KUNIT_EXPECT_STREQ(test, strs[0], "string-a");
-- 
2.30.0

