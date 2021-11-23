Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8145A0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhKWK6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:58:46 -0500
Received: from 8bytes.org ([81.169.241.247]:58520 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235762AbhKWK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:58:45 -0500
Received: from cap.home.8bytes.org (p549adbee.dip0.t-ipconnect.de [84.154.219.238])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 4155ED7A;
        Tue, 23 Nov 2021 11:55:34 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] iommu/vt-d: Remove unused PASID_DISABLED
Date:   Tue, 23 Nov 2021 11:55:06 +0100
Message-Id: <20211123105507.7654-2-joro@8bytes.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123105507.7654-1-joro@8bytes.org>
References: <20211123105507.7654-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The macro is unused after commit 00ecd5401349a so it can be removed.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 00ecd5401349a ("iommu/vt-d: Clean up unused PASID updating functions")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/fpu/api.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 6053674f9132..c2767a6a387e 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -102,12 +102,6 @@ extern void switch_fpu_return(void);
  */
 extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
 
-/*
- * Tasks that are not using SVA have mm->pasid set to zero to note that they
- * will not have the valid bit set in MSR_IA32_PASID while they are running.
- */
-#define PASID_DISABLED	0
-
 /* Trap handling */
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 extern void fpu_sync_fpstate(struct fpu *fpu);
-- 
2.33.1

