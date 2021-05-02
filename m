Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F261D370AA8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhEBHGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 03:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhEBHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 03:06:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8DC06138C
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 00:05:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so3975997pjj.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhWuHO15mzJ0eEmkfCxQQ410IKmY3/zDpjWtbS+BUSw=;
        b=Rszc7fTuxN9/0Hiy0uUfWYHVhGXjizzxbTwgjZQg2n9lNOVwFdujGVU9u30XYFk0NF
         ls8kmQuJiQPx4PqHkEYK/Fe6fc3cqaWYW1rnJOvg+ZeY7rBIW8WL3PyxJoxjQH3dZ1zH
         75cmjZtmMNnLq4SbIyVwM5lI4PtivUMbN4xXc0xEovhI9mq56Mhhfrur3vYCqv/eEMH8
         akmoKFiPe+LkX6WHqxXbzyDb4lmxWVO4JZl3xsmSSkkiv9r0tYvZ2Qftxm7n2aF761TC
         XWorXU9G4jMXsWoWwU2zfCYdH/uovC2cUT/Y9U6pXs/D0sQImo0R1Ol6LejbJMxoFrdT
         PHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhWuHO15mzJ0eEmkfCxQQ410IKmY3/zDpjWtbS+BUSw=;
        b=QHeoCLy/1e/2Ki+7+do0w2ozM4nZvyb7u14frSvJnRAsN9ZtuY38hYp8x1CXpC4NsL
         fYE44p2Ef6D7/Kny+XmbLHuq4ED0wgkUCDI6e0YwN5etUl9tckqPb1+zNCKlo9VQ1XiD
         vhnXOlI2uzrIYbQTINZld3Kx23y5fjrGYsC+1JumSSmFVgWd9R17U5wos2UGdvt/aI9/
         YbtqlcxAEUxO7+Q56/63YO+jA+ruyxqv2JtzeRchFZDDIRUvBP8Bruv4RmCtX4vv89st
         Sr4sGLn0Y6FgyQTf7MAhKuhPuZ2jHDfmCYkUPt9Me5RpmIZOrmc+drSOv5hGO48+9HTS
         kxsw==
X-Gm-Message-State: AOAM532V5kdvII88q3DOAqIdphFdWNRgklP6pqiZP8gw5cr0G5LtHRD2
        TTUrzgtnBSyxOUjPzNop6XY=
X-Google-Smtp-Source: ABdhPJyHFOshXt7GygOdxmGPBFevReHiOMEMndS9v5KQUb0kc5sQ/hKgnOfR1C5DtpRX8pRCa9LN6g==
X-Received: by 2002:a17:90b:3689:: with SMTP id mj9mr14582792pjb.154.1619939117103;
        Sun, 02 May 2021 00:05:17 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 00:05:16 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu/amd: Do not use flush-queue when NpCache is on
Date:   Sun,  2 May 2021 00:00:01 -0700
Message-Id: <20210502070001.1559127-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502070001.1559127-1-namit@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Do not use flush-queue on virtualized environments, where the NpCache
capability of the IOMMU is set. This is required to reduce
virtualization overheads.

This change follows a similar change to Intel's VT-d and a detailed
explanation as for the rationale is described in commit 29b32839725f
("iommu/vt-d: Do not use flush-queue when caching-mode is on").

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..ba3b76ed776d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,8 +1850,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
-	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
+	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
+		if (!amd_iommu_unmap_flush)
+			pr_warn_once("IOMMU batching is disabled due to virtualization");
+
 		amd_iommu_np_cache = true;
+		amd_iommu_unmap_flush = true;
+	}
 
 	init_iommu_perf_ctr(iommu);
 
-- 
2.25.1

