Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF79372645
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhEDHHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:07:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:4376 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbhEDHHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:07:25 -0400
IronPort-SDR: rvjhtqyzYc4HLc1VQNhC3+we1XG7pJoCGtMXPaY9R1J76LKNkrhXDN6dbb8IMT644nUKFBly7T
 +OvR9sMmUGfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197534538"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="197534538"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 00:05:59 -0700
IronPort-SDR: V9Ra87L4nOH6km8gO5xNTMigeVOsTZxMYNjNC+KueNI1ARdbEkADhXiGe6KJNrCy2wmBxMRoD5
 HBAKJ2Avcqew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="450895511"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2021 00:05:40 -0700
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH v5 09/20] tools lib: introduce bitmap_intersects() operation
Date:   Tue,  4 May 2021 10:04:44 +0300
Message-Id: <65ef6a2c0aabd22c067944ad0f74c9d14818fd00.1619781188.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce bitmap_intersects() routine that tests whether
bitmaps bitmap1 and bitmap2 intersects. This routine will
be used during thread masks initialization.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/include/linux/bitmap.h | 11 +++++++++++
 tools/lib/bitmap.c           | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 477a1cae513f..2eb1d1084543 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -18,6 +18,8 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
+int __bitmap_intersects(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, unsigned int bits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 
@@ -178,4 +180,13 @@ static inline int bitmap_equal(const unsigned long *src1,
 	return __bitmap_equal(src1, src2, nbits);
 }
 
+static inline int bitmap_intersects(const unsigned long *src1,
+			const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	else
+		return __bitmap_intersects(src1, src2, nbits);
+}
+
 #endif /* _PERF_BITOPS_H */
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 5043747ef6c5..3cc3a5b43bb5 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -86,3 +86,17 @@ int __bitmap_equal(const unsigned long *bitmap1,
 
 	return 1;
 }
+
+int __bitmap_intersects(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] & bitmap2[k])
+			return 1;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return 1;
+	return 0;
+}
-- 
2.19.0

