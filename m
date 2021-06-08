Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA239F69A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhFHMak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhFHMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:30:39 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 05:28:46 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de [79.242.186.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id C3996206;
        Tue,  8 Jun 2021 14:28:44 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Fix section mismatch warning for detect_ivrs()
Date:   Tue,  8 Jun 2021 14:28:43 +0200
Message-Id: <20210608122843.8413-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

A recent commit introduced this section mismatch warning:

	WARNING: modpost: vmlinux.o(.text.unlikely+0x22a1f): Section mismatch in reference from the function detect_ivrs() to the variable .init.data:amd_iommu_force_enable

The reason is that detect_ivrs() is not marked __init while it should
be, because it is only called from another __init function. Mark
detect_ivrs() __init to get rid of the warning.

Fixes: b1e650db2cc4 ("iommu/amd: Add amd_iommu=force_enable option")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 4e4fb0f4e412..46280e6e1535 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2817,7 +2817,7 @@ static int amd_iommu_enable_interrupts(void)
 	return ret;
 }
 
-static bool detect_ivrs(void)
+static bool __init detect_ivrs(void)
 {
 	struct acpi_table_header *ivrs_base;
 	acpi_status status;
-- 
2.31.1

