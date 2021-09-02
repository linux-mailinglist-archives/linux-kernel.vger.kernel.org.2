Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259F23FEF0E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbhIBOCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:02:06 -0400
Received: from foss.arm.com ([217.140.110.172]:50258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhIBOCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:02:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B5D61FB;
        Thu,  2 Sep 2021 07:01:06 -0700 (PDT)
Received: from e122027.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB69F3F5A1;
        Thu,  2 Sep 2021 07:01:04 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panfrost: Calculate lock region size correctly
Date:   Thu,  2 Sep 2021 15:00:38 +0100
Message-Id: <20210902140038.221437-1-steven.price@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that when locking a region, the region must be a naturally
aligned power of 2. The upshot of this is that if the desired region
crosses a 'large boundary' the region size must be increased
significantly to ensure that the locked region completely covers the
desired region. Previous calculations (including in kbase for the
proprietary driver) failed to take this into account.

Since it's known that the lock region must be naturally aligned we can
compute the required size by looking at the highest bit position which
changes between the start/end of the lock region (subtracting 1 from the
end because the end address is exclusive). The start address is then
aligned based on the size (this is technically unnecessary as the
hardware will ignore these bits, but the spec advises to do this "to
avoid confusion").

Signed-off-by: Steven Price <steven.price@arm.com>
---
See previous discussion[1] for more details. This bug also existed in
the 'kbase' driver, so it's unlikely to actually hit very often.

This patch is based on drm-misc-next-fixes as it builds on top of
Alyssa's changes to lock_region.

[1] https://lore.kernel.org/dri-devel/6fe675c4-d22b-22da-ba3c-f6d33419b9ed@arm.com/

 drivers/gpu/drm/panfrost/panfrost_mmu.c | 33 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index dfe5f1d29763..afec15bb3db5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -58,17 +58,36 @@ static int write_cmd(struct panfrost_device *pfdev, u32 as_nr, u32 cmd)
 }
 
 static void lock_region(struct panfrost_device *pfdev, u32 as_nr,
-			u64 iova, u64 size)
+			u64 region_start, u64 size)
 {
 	u8 region_width;
-	u64 region = iova & PAGE_MASK;
+	u64 region;
+	u64 region_size;
+	u64 region_end = region_start + size;
 
-	/* The size is encoded as ceil(log2) minus(1), which may be calculated
-	 * with fls. The size must be clamped to hardware bounds.
+	if (!size)
+		return;
+
+	/*
+	 * The locked region is a naturally aligned power of 2 block encoded as
+	 * log2 minus(1).
+	 * Calculate the desired start/end and look for the highest bit which
+	 * differs. The smallest naturally aligned block must include this bit
+	 * change the desired region starts with this bit (and subsequent bits)
+	 * zeroed and ends with the bit (and subsequent bits) set to one.
+	 *
 	 */
-	size = max_t(u64, size, AS_LOCK_REGION_MIN_SIZE);
-	region_width = fls64(size - 1) - 1;
-	region |= region_width;
+	region_size = region_start ^ (region_end - 1);
+	region_width = max(fls64(region_size),
+			   const_ilog2(AS_LOCK_REGION_MIN_SIZE)) - 1;
+
+	/*
+	 * Mask off the low bits of region_start (which would be ignored by
+	 * the hardware anyway)
+	 */
+	region_start &= GENMASK_ULL(63, region_width);
+
+	region = region_width | region_start;
 
 	/* Lock the region that needs to be updated */
 	mmu_write(pfdev, AS_LOCKADDR_LO(as_nr), region & 0xFFFFFFFFUL);
-- 
2.30.2

