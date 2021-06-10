Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B63A2715
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFJIdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhFJId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:33:27 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7076C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:31:29 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de [79.242.186.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 3501317C;
        Thu, 10 Jun 2021 10:31:27 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Will Deacon <will@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/vt-d: Fix linker error on 32-bit
Date:   Thu, 10 Jun 2021 10:31:20 +0200
Message-Id: <20210610083120.29224-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

A recent commit broke the build on 32-bit x86. The linker throws these
messages:

	ld: drivers/iommu/intel/perf.o: in function `dmar_latency_snapshot':
	perf.c:(.text+0x40c): undefined reference to `__udivdi3'
	ld: perf.c:(.text+0x458): undefined reference to `__udivdi3'

The reason are the 64-bit divides in dmar_latency_snapshot(). Use the
div_u64() helper function for those.

Fixes: 55ee5e67a59a ("iommu/vt-d: Add common code for dmar latency performance monitors")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel/perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index faaa96dda437..73b7ec705552 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -141,14 +141,14 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 				if (val == UINT_MAX)
 					val = 0;
 				else
-					val /= 1000;
+					val = div_u64(val, 1000);
 				break;
 			case COUNTS_MAX:
-				val /= 1000;
+				val = div_u64(val, 1000);
 				break;
 			case COUNTS_SUM:
 				if (lstat[i].samples)
-					val /= (lstat[i].samples * 1000);
+					val = div_u64(val, (lstat[i].samples * 1000));
 				else
 					val = 0;
 				break;
-- 
2.31.1

