Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0048F43B47D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhJZOn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:43:57 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:58898 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhJZOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635259291; x=1666795291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V9amYGegQJ8S7wpYJOaO0b9hJ0MAlXfb64mMet8FQ/Q=;
  b=aJEU3/GSW0r1EU2SvCfHmCYMasjZOB8/VNwldUzsL1afAYG+FLSfUIsA
   XW8cjyo18SJBwGH6F/53c6YQUwJychFOHVg9NyUX6sAorMGovIhB1DqI/
   v7qwkdYvtk1TZtTHSsz2qbVVSx8+Ap6GLqJGbQSc1qcdm3OUs6do7oYFk
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 07:41:31 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 07:41:30 -0700
Received: from qian-HP-Z2-SFF-G5-Workstation.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 07:41:29 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>, Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
Date:   Tue, 26 Oct 2021 10:41:08 -0400
Message-ID: <20211026144108.35373-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since "size" is an "unsigned int", the rvalue "size - 1" will still be
"unsigned int" according to the C standard (3.2.1.5 Usual arithmetic
conversions). Therefore, GENMASK(size - 1, 0) will always return 0UL. Those
are also caught by GCC (W=2):

./include/linux/find.h: In function 'find_first_bit':
./include/linux/bits.h:25:22: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
   25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                      ^
./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:3: note: in expansion of macro '__is_constexpr'
   25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
      |   ^~~~~~~~~~~~~~
./include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |   ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:119:31: note: in expansion of macro 'GENMASK'
  119 |   unsigned long val = *addr & GENMASK(size - 1, 0);
      |                               ^~~~~~~
./include/linux/bits.h:25:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
   25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                  ^
./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |   ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:119:31: note: in expansion of macro 'GENMASK'
  119 |   unsigned long val = *addr & GENMASK(size - 1, 0);
      |                               ^~~~~~~

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 include/linux/find.h | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5bb6db213bcb..5ce2b17aea42 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -115,11 +115,8 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 static inline
 unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 {
-	if (small_const_nbits(size)) {
-		unsigned long val = *addr & GENMASK(size - 1, 0);
-
-		return val ? __ffs(val) : size;
-	}
+	if (small_const_nbits(size))
+		return size;
 
 	return _find_first_bit(addr, size);
 }
@@ -140,11 +137,8 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 				 const unsigned long *addr2,
 				 unsigned long size)
 {
-	if (small_const_nbits(size)) {
-		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
-
-		return val ? __ffs(val) : size;
-	}
+	if (small_const_nbits(size))
+		return size;
 
 	return _find_first_and_bit(addr1, addr2, size);
 }
@@ -162,11 +156,8 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 static inline
 unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
-	if (small_const_nbits(size)) {
-		unsigned long val = *addr | ~GENMASK(size - 1, 0);
-
-		return val == ~0UL ? size : ffz(val);
-	}
+	if (small_const_nbits(size))
+		return size;
 
 	return _find_first_zero_bit(addr, size);
 }
@@ -183,11 +174,8 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 static inline
 unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
-	if (small_const_nbits(size)) {
-		unsigned long val = *addr & GENMASK(size - 1, 0);
-
-		return val ? __fls(val) : size;
-	}
+	if (small_const_nbits(size))
+		return size;
 
 	return _find_last_bit(addr, size);
 }
-- 
2.30.2

