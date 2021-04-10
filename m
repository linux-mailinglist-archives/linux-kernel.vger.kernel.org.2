Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AEC35AA0A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhDJBxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhDJBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD43C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s11so5397243pfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVxXeOc0hKsCQhtdNSOBYITwGo/IIl7F5oIkiSC5GNA=;
        b=M2v490r7nGzxPyOhiB85EUVIhWJs5kaRQOHRQNfjHCLbu4fDzn7mvOqQ+j5zc8k3EL
         DF4PxmHTF4EiMFwexSv5Ja8Sl4T14aTCfK3ERIGDg98Oq8hsIa6qkvkjSN9CfgM+BLFi
         paUyavdwwNqw0NuVeNrLRT8co6F5mi5HFrliI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVxXeOc0hKsCQhtdNSOBYITwGo/IIl7F5oIkiSC5GNA=;
        b=H8oHJitOV72Qc1dvBHdx3HJA3DtAAfTzth9nyMF/oWJztIqnbm8Tq+mgOv4E/IOGRG
         SYSomN2eFmmcjvqDsz1Ky+a3PfYZJbgIjh9tHN1kIop3rL9MiuH8SYuW3p1ksr0vEkrC
         IyXGO08A/NmFHZdwzeP+1lThuaTHAHlkwreo8t/K9r9X6T+rbZWacliJvhvdPH/RYNlB
         R6Jezoo8q0c+GRQLQsqXpUovb5dhESWW1pRuqrrCniTmQxSKs1lPTSb5nxFmxEZdU3MH
         rn2gul4BbY3EyxQo6EchRwWSLNkmF3pMTBsCWcF5ecpDlmHOR3AfgtAPm/xmijUCs8PP
         zhrQ==
X-Gm-Message-State: AOAM530QwqY2394OuXRPqZHP7ulE5PfME8SYY9ajUxVclk0lfHC0zzqj
        EzIuVO2uFtObIuVi45O8gqM4yw==
X-Google-Smtp-Source: ABdhPJwaZhoYUK02GvtHfsIGZjAia1+izxqV/KVJMQN+YTVp46ZVr1YSRjXk8BY8I88BOFVNU7ZAug==
X-Received: by 2002:a63:356:: with SMTP id 83mr15913879pgd.344.1618019584525;
        Fri, 09 Apr 2021 18:53:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:04 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v4 03/13] buildid: Stash away kernels build ID on init
Date:   Fri,  9 Apr 2021 18:52:50 -0700
Message-Id: <20210410015300.3764485-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the kernel's build ID at initialization so that other code can
print a hex format string representation of the running kernel's build
ID. This will be used in the kdump and dump_stack code so that
developers can easily locate the vmlinux debug symbols for a
crash/stacktrace.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: <kexec@lists.infradead.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/buildid.h |  3 +++
 init/main.c             |  1 +
 lib/buildid.c           | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index ebce93f26d06..f375900cf9ed 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -10,4 +10,7 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
+extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
+void init_vmlinux_build_id(void);
+
 #endif
diff --git a/init/main.c b/init/main.c
index 53b278845b88..eaede2f41327 100644
--- a/init/main.c
+++ b/init/main.c
@@ -857,6 +857,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	set_task_stack_end_magic(&init_task);
 	smp_setup_processor_id();
 	debug_objects_early_init();
+	init_vmlinux_build_id();
 
 	cgroup_init_early();
 
diff --git a/lib/buildid.c b/lib/buildid.c
index 6aea1c4e5e85..1103ed46214f 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/buildid.h>
+#include <linux/cache.h>
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
@@ -172,3 +173,17 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 {
 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
 }
+
+unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
+
+/**
+ * init_vmlinux_build_id - Compute and stash the running kernel's build ID
+ */
+void __init init_vmlinux_build_id(void)
+{
+	extern const void __start_notes __weak;
+	extern const void __stop_notes __weak;
+	unsigned int size = &__stop_notes - &__start_notes;
+
+	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
+}
-- 
https://chromeos.dev

