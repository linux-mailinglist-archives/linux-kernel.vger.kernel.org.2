Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231EC3AFF80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFVIpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:45:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:57636 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhFVIp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:45:29 -0400
IronPort-SDR: exWo9i/hOZIBlEKJ8tcKLpbmB0cwukX0lHO+v1yxkhtKf56WN4zJq/ochFWbFFCilnPC0MKVHr
 PkeQdndYnSNg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292641572"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292641572"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 01:43:01 -0700
IronPort-SDR: Ni+v0rxX/uMqi2KSHrHWHrbK+I2qvr2ato3lI0A74Kfj94Wt5zPbq1FXuMBNfrvun6W64pL4Zj
 HFiMq6x7BH5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="417332563"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2021 01:42:59 -0700
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
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH v7 09/20] tools lib: Introduce bitmap_intersects() operation
Date:   Tue, 22 Jun 2021 11:42:18 +0300
Message-Id: <e0954d71b62591c9c1b2ad1628cccf3d496659f8.1624350588.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
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
index 330dbf7509cc..9d959bc24859 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -18,6 +18,8 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
+int __bitmap_intersects(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, unsigned int bits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
@@ -170,4 +172,13 @@ static inline int bitmap_equal(const unsigned long *src1,
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
index f4e914712b6f..db466ef7be9d 100644
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

