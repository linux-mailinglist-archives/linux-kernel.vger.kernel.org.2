Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647F43CD496
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbhGSLjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:39:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:34990 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236845AbhGSLjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:39:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="198244952"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="198244952"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 05:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="499897119"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2021 05:19:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D5F6A23A; Mon, 19 Jul 2021 15:20:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mm/util: Rephrase documentation for kmemdup_nul() to clarify input
Date:   Mon, 19 Jul 2021 15:20:02 +0300
Message-Id: <20210719122002.41334-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup_nul() strictly speaking is not related to the string API,
while being quite useful for it. Rephrase documentation to make it
clear that input data can be anything (any data, which may contain
any bytes, including 0x00).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 mm/util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 9043d03750a7..3b717d34753b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -133,13 +133,16 @@ void *kmemdup(const void *src, size_t len, gfp_t gfp)
 EXPORT_SYMBOL(kmemdup);
 
 /**
- * kmemdup_nul - Create a NUL-terminated string from unterminated data
+ * kmemdup_nul - Create a NUL-terminated data from unterminated one
  * @s: The data to stringify
  * @len: The size of the data
  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
  *
+ * In particular this function is useful to add NUL-termination to
+ * unterminated strings.
+ *
  * Return: newly allocated copy of @s with NUL-termination or %NULL in
- * case of error
+ * case of error.
  */
 char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 {
-- 
2.30.2

