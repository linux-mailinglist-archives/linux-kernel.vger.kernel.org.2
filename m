Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348FE3661BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhDTVuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbhDTVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA1C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y1so4780582plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVxXeOc0hKsCQhtdNSOBYITwGo/IIl7F5oIkiSC5GNA=;
        b=azPum2fPL7aelLx2spTQSlX7pdpba69xRaN/kunkA8tQkrDHdVazyKsB3WRbKcrYZd
         AS6fP54ZpuPwitQ/0xTbrzNfN0j2g1g8RuLEX1C5lZqr0jFElocJDOFNouGnC+zDtlAz
         7BuuS+n18fIdOoOYE7uTkRtp7k0GontguAp7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVxXeOc0hKsCQhtdNSOBYITwGo/IIl7F5oIkiSC5GNA=;
        b=iy3Y5elCn9rdMc0P2nztQBuN29GzWhayp+xG9KoEamGwJH3mIUaOeiNtWHyYzVgA7a
         I/wzyjApY7s1IEENn1hW93WZ1vE2BZ2gSU8N370Qc/hWdNU29iODfIjaQl5AiIVISHA4
         SiXm4KmX5ui9rgeJ3+vaBGzVSFzUZWjzlvH9bC3YFDAhsqezNJ4d7K1b+CxmCVTyoPyd
         GnSE1i86lvmJSu6j3xGW7QMGGvhXYUm3z/i09zEQetbhCA6+PhwXGgGNnSAIQtCCW41r
         cFj4ljW5uqUpv2jOsigMJWpekVECYMOUhdBs7351Csq9Z0eq6fr8JGftPTbd8UNJ23V8
         jBPA==
X-Gm-Message-State: AOAM531S6dL53iuqssCz83G10M2kwp0WXeNlYF822J8qDa7wgxyQQBMH
        NSsg3W3X6b0SkYu/azep8FXcb8z1Lw/bdQ==
X-Google-Smtp-Source: ABdhPJwO5/kNk6qBtU/RCnpv5ysH8jwwJruoestnWb2e9/CAPNCghp7IL+FfCj0FMcSRWncva2Dbtg==
X-Received: by 2002:a17:902:d884:b029:ec:9fcd:2311 with SMTP id b4-20020a170902d884b02900ec9fcd2311mr14258092plz.80.1618955407110;
        Tue, 20 Apr 2021 14:50:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v5 03/13] buildid: Stash away kernels build ID on init
Date:   Tue, 20 Apr 2021 14:49:53 -0700
Message-Id: <20210420215003.3510247-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
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

