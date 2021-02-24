Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744D4323877
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhBXISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbhBXIR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:17:58 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:17:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w18so725218plc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wTo08982+SRCLKzowpo4WdQTuev/V4/nqg+2goUnX8U=;
        b=mjh+E6hzjGLNsory5HuqDkALHlHVGSepkPQlhN+i8cTQh9zCKQ1wMT2n2OxAPojvUH
         vXZ62JUdLNBHAS9G1spCc2a8bxyMam9bQlHSOMCDYFQazyJER0SiwmUtPIHKSfXv6DQg
         iY2GyoPkURFhHFshtdn7H32/eKneXvbyOPDJmTkq1TnqIqOrQGK2l4W2HfTB88bqyiFf
         NQJLiG9WC4lTjsVD2x/qIalSZSXjpRcpoI1t4gVa0eRUj57tA4IfB8hOX0D4pwZzE5Yq
         //VVHiyxoG/wZl3nh3/y60jhsN8lGF3DvN82Tp5k/VyAmOAS0BRm/hfhw9QWBrkHSHcx
         fFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wTo08982+SRCLKzowpo4WdQTuev/V4/nqg+2goUnX8U=;
        b=nbviTGeL4TrWGaW8YrsexuqIHYO/dA3iQMotvPhWoL/lf/fUS4GFE/8hpUn1fqKzxd
         3Y914jcrjoX8ubzLaL3T+TeEUWC7ddYGi+DX4a1lEGePSPps0smIxK6y3Pd8qcYcJcLS
         bmSy20AsdWFqYgeNx3MCHIRB3m2H6DpnS+1+jshYbZLRHmXpxaKbVSNCy+Ru6QV3I9np
         GQI5ICSszoxbPTMzIeqrKvikKCYaYNHrbyJQsuXiAcuxGT1PaBt4B7SzfHFzvJs4LOit
         0oZdQirr2ojtA9NWvJ5/YT7y3I7ENrcfJMQ+p77iYr3CAB4NCWYoIevw8iavt8P1lk14
         QEcA==
X-Gm-Message-State: AOAM533IrxrznC5G1O8YG/u0orWwcKrwuQYdZ2zyZYS7YFMNO9YvVEfd
        1CTj5RXVXEqRD/OqSUkWOgbSrw==
X-Google-Smtp-Source: ABdhPJzgYGKeGutf/PkGMpFLC1AP3NyykDukQYFrcKKhJzsJLv3igC8E/Sjb44KT8BgZ4PLyoLtLRA==
X-Received: by 2002:a17:902:7887:b029:e3:8ef0:9a9d with SMTP id q7-20020a1709027887b02900e38ef09a9dmr31191575pll.2.1614154637564;
        Wed, 24 Feb 2021 00:17:17 -0800 (PST)
Received: from localhost.localdomain ([122.173.196.104])
        by smtp.gmail.com with ESMTPSA id h75sm1445286pfe.162.2021.02.24.00.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:17:17 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org,
        rostedt@goodmis.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org,
        peterz@infradead.org, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] kgdb: Fix to kill breakpoints on initmem after boot
Date:   Wed, 24 Feb 2021 13:46:52 +0530
Message-Id: <20210224081652.587785-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently breakpoints in kernel .init.text section are not handled
correctly while allowing to remove them even after corresponding pages
have been freed.

Fix it via killing .init.text section breakpoints just prior to initmem
pages being freed.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/linux/kgdb.h      |  2 ++
 init/main.c               |  1 +
 kernel/debug/debug_core.c | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 57b8885708e5..3aa503ef06fc 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -361,9 +361,11 @@ extern atomic_t			kgdb_active;
 extern bool dbg_is_early;
 extern void __init dbg_late_init(void);
 extern void kgdb_panic(const char *msg);
+extern void kgdb_free_init_mem(void);
 #else /* ! CONFIG_KGDB */
 #define in_dbg_master() (0)
 #define dbg_late_init()
 static inline void kgdb_panic(const char *msg) {}
+static inline void kgdb_free_init_mem(void) { }
 #endif /* ! CONFIG_KGDB */
 #endif /* _KGDB_H_ */
diff --git a/init/main.c b/init/main.c
index c68d784376ca..a446ca3d334e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1417,6 +1417,7 @@ static int __ref kernel_init(void *unused)
 	async_synchronize_full();
 	kprobe_free_init_mem();
 	ftrace_free_init_mem();
+	kgdb_free_init_mem();
 	free_initmem();
 	mark_readonly();
 
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 229dd119f430..319381e95d1d 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -465,6 +465,17 @@ int dbg_remove_all_break(void)
 	return 0;
 }
 
+void kgdb_free_init_mem(void)
+{
+	int i;
+
+	/* Clear init memory breakpoints. */
+	for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
+		if (init_section_contains((void *)kgdb_break[i].bpt_addr, 0))
+			kgdb_break[i].state = BP_UNDEFINED;
+	}
+}
+
 #ifdef CONFIG_KGDB_KDB
 void kdb_dump_stack_on_cpu(int cpu)
 {
-- 
2.25.1

