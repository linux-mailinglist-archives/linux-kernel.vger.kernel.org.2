Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352FB39EBB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhFHB5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHB5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:57:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1F6C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 18:55:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y12so3442401pgk.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 18:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gA93gcDJeBg/RhtboQ/3cmND2A1WryjuLSn85WsFu6g=;
        b=smr3+6OdXCX0hxcoS3KifFK/dV+LXqWV0dvi3Zm9J0DyNPNH7h2U08dl5QLHIjkWXM
         UKozM1JMhBxDdFhL1Ce2WCfg9Ig4REet6bVp8J9Bm/pglDJfb5H+m2hSp+fcPB4Ocjfi
         RTrsMc+gLmd5Pjb36a6ezbUGGDre5VVLY2jR2BRU89KOAUSUPoJUoKkScAJjA3tnwMyw
         WKTSumESx4sH8LDWKWCY1BXJPkDubzipufR8I3eHaomR3DfugGYS3kuhDsNOM+o/lCme
         mOPEPV89hmsgtakWyeP+Knl1ZS4/mrrMx3er/HSZWkteycTJrddPXtMmxDWyRKvR3RAT
         XqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gA93gcDJeBg/RhtboQ/3cmND2A1WryjuLSn85WsFu6g=;
        b=ZaN3OVJM1KQBftgQUZ8Cv4AWt3MW6OGOnJUJm5Cl0Mcb2YI2cfuQZI89Or/7lmWat/
         PO2laFagj5SWG6My2tKOBv6/7RW3PO1P5/XKOkvIy5Dmf49UujOcZhPkVpiFz3rzw3hg
         gHRiIeGJxD3HgO1yziJMC9xSs3znSB4HBWsTxR8CnkHAaXzYkpNR3guvd+f4+jTzLgym
         tHt/WMYH5uJfhMeH+y4jp3XAUWkgvbQmqk+PIRXPJnUlJQoRPICCkAelw5s/40aa8Jhu
         tGK6XBBONQNCBgySwOMauypRL3201/IGopgEq4JDrTLOnyfOxO8G7iubMFdH4JSjLIxE
         x3UA==
X-Gm-Message-State: AOAM531GF/LUJK/5nJHfUOTLtRHR099/mM8Hy0M603ZHNY/I9JckdNSW
        vglMrUt9uGuVRopdsBIbV4U=
X-Google-Smtp-Source: ABdhPJxEWq3ejES1pz5zIYlzqOcXjYDrBEEmksqiBOvaj5ucy7+uYMegKQfJMj4S4H4yXtBkArI+ew==
X-Received: by 2002:a62:b604:0:b029:2d5:d7b8:b531 with SMTP id j4-20020a62b6040000b02902d5d7b8b531mr19567614pff.31.1623117323356;
        Mon, 07 Jun 2021 18:55:23 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:55:22 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] iommu/amd: Do not use flush-queue when NpCache is on
Date:   Mon,  7 Jun 2021 11:25:37 -0700
Message-Id: <20210607182541.119756-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607182541.119756-1-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
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
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
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

