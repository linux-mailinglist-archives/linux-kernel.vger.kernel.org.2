Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3A36830B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhDVPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:10:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:51992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236563AbhDVPKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619104211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGYTI5hb6XF/TrVV+tK4E4xlOyG7i9BsqrnGlynZSJM=;
        b=rkqpNHxQEq8IWYLVp0llAxNQCop0wQDhH19sDYwFQ1gk0VAjV4ZLRAnd/O5DophQu1UYRk
        pEiSJ2EiOmjVHzPlg2XnZBk5IWyblvtmK0qwMpFZl7499bg6QnKLQwCytl7FzyMM9fxSya
        SXO1bDbx/20HgyDjak27WeKH3lnP8Hs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9411B16D;
        Thu, 22 Apr 2021 15:10:10 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] xen: check required Xen features
Date:   Thu, 22 Apr 2021 17:10:05 +0200
Message-Id: <20210422151007.2205-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210422151007.2205-1-jgross@suse.com>
References: <20210422151007.2205-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel is not supported to run on Xen versions older than 4.0.

Add tests for required Xen features always being present in Xen 4.0
and newer.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/features.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/xen/features.c b/drivers/xen/features.c
index 25c053b09605..60503299c9bc 100644
--- a/drivers/xen/features.c
+++ b/drivers/xen/features.c
@@ -9,13 +9,26 @@
 #include <linux/types.h>
 #include <linux/cache.h>
 #include <linux/export.h>
+#include <linux/printk.h>
 
 #include <asm/xen/hypercall.h>
 
+#include <xen/xen.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/version.h>
 #include <xen/features.h>
 
+/*
+ * Linux kernel expects at least Xen 4.0.
+ *
+ * Assume some features to be available for that reason (depending on guest
+ * mode, of course).
+ */
+#define chk_feature(f) {						\
+		if (!xen_feature(f))					\
+			pr_err("Xen: feature %s not available!\n", #f);	\
+	}
+
 u8 xen_features[XENFEAT_NR_SUBMAPS * 32] __read_mostly;
 EXPORT_SYMBOL_GPL(xen_features);
 
@@ -31,4 +44,9 @@ void xen_setup_features(void)
 		for (j = 0; j < 32; j++)
 			xen_features[i * 32 + j] = !!(fi.submap & 1<<j);
 	}
+
+	if (xen_pv_domain()) {
+		chk_feature(XENFEAT_mmu_pt_update_preserve_ad);
+		chk_feature(XENFEAT_gnttab_map_avail_bits);
+	}
 }
-- 
2.26.2

