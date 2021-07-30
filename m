Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB633DB45E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhG3HSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 03:18:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43422 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbhG3HSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:18:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA8E11FDB3;
        Fri, 30 Jul 2021 07:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627629486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXHUM7lXyWrAMLgi9KDBkwkBbe+GUHRQIfTUEaC3Es0=;
        b=CmagrxEtD3TrPfNSVaCrRb3MI++Zl+msTB5z3G5Rw6JB7REz302fCG1SqoONxV1eNTGnct
        Y+rl61k756x1QzQ+JElqVBfV00m8i4I2NGBtj+H1Y8RxSlw4j5dStPbm5iOlPeHUUcHVtO
        /QcnYVu7ZytRetzZdBNEKdoG4o56Ej8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C1BDE13748;
        Fri, 30 Jul 2021 07:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KJISLq6nA2FufQAAGKfGzw
        (envelope-from <jgross@suse.com>); Fri, 30 Jul 2021 07:18:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 1/3] xen: check required Xen features
Date:   Fri, 30 Jul 2021 09:18:02 +0200
Message-Id: <20210730071804.4302-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210730071804.4302-1-jgross@suse.com>
References: <20210730071804.4302-1-jgross@suse.com>
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
V2:
- rename macro (Boris Ostrovsky)
- panic() in case of missing feature (Boris Ostrovsky)
---
 drivers/xen/features.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/xen/features.c b/drivers/xen/features.c
index 25c053b09605..7b591443833c 100644
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
+#define chk_required_feature(f) {					\
+		if (!xen_feature(f))					\
+			panic("Xen: feature %s not available!\n", #f);	\
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
+		chk_required_feature(XENFEAT_mmu_pt_update_preserve_ad);
+		chk_required_feature(XENFEAT_gnttab_map_avail_bits);
+	}
 }
-- 
2.26.2

