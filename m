Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057C93D7936
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhG0PBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:01:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:20693 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhG0PBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:01:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="192055823"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="192055823"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 08:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="662768002"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jul 2021 08:01:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 366DFDE; Tue, 27 Jul 2021 18:01:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v1 1/1] lib/test_scanf: Handle n_bits == 0 in random tests
Date:   Tue, 27 Jul 2021 18:01:32 +0300
Message-Id: <20210727150132.28920-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN reported (via LKP)

[   11.021349][    T1] UBSAN: shift-out-of-bounds in lib/test_scanf.c:275:51
[   11.022782][    T1] shift exponent 32 is too large for 32-bit type 'unsigned int'

When n_bits == 0, the shift is out of range. Switch code to use GENMASK
to handle this case.

Fixes: 50f530e176ea ("lib: test_scanf: Add tests for sscanf number conversion")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_scanf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index 84fe09eaf55e..abae88848972 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -271,7 +271,7 @@ static u32 __init next_test_random(u32 max_bits)
 {
 	u32 n_bits = hweight32(prandom_u32_state(&rnd_state)) % (max_bits + 1);
 
-	return prandom_u32_state(&rnd_state) & (UINT_MAX >> (32 - n_bits));
+	return prandom_u32_state(&rnd_state) & GENMASK(n_bits, 0);
 }
 
 static unsigned long long __init next_test_random_ull(void)
@@ -280,7 +280,7 @@ static unsigned long long __init next_test_random_ull(void)
 	u32 n_bits = (hweight32(rand1) * 3) % 64;
 	u64 val = (u64)prandom_u32_state(&rnd_state) * rand1;
 
-	return val & (ULLONG_MAX >> (64 - n_bits));
+	return val & GENMASK_ULL(n_bits, 0);
 }
 
 #define random_for_type(T)				\
-- 
2.30.2

