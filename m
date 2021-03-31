Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B834F724
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhCaDFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhCaDF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 11so13509006pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/po15KKRSlgR9dMseFbu3AQQQYqUEvH0rgXBtKR72E=;
        b=CYcIXIGTD9yJWnn5Rsh2SMMB+J87N8+w+xLJ2ExRUAALtSRtnPgkvw2GCpb68XXd0y
         VPfVN490C+RcYetJDTne8IVJ1O1wOoNUPtM3dIZ3Ot2EQdCzRPx5YTFangS4HHeKDvJZ
         MPAQbjDOLIl2oO6H2KlFul/4Up2QFTMJCBWBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/po15KKRSlgR9dMseFbu3AQQQYqUEvH0rgXBtKR72E=;
        b=doxJV7DC3aQbQ9hptMr537rqW3ARsUdhxdpcvr1XFYVc7OG6cwEJj5I+pQxTUhQuz2
         SLQDQ9WljAdNl7GXcAbD7IHP9PwL8WjlrieJiALd86o0rBmOQ2KJVvX1Rv5MBeXJa4ix
         /X+U0MdxkuF6cK86YEJlQuS6w+RGDRuUUyn6IWQy+xpnQpFcw0bVNX2Kg8SP5ooUOC8j
         wcNNEbZ0ABwBqChzDc4YYjNUGidf8+hDm4xl5CE0hJX3bd1Uz9vHTl1qjjyXcsHthDj4
         roYKNN49CoYA2wfmVV+mcxToLaSaXgsPO6FXw72/rsl6ds/CwxfYiIuSE4VQxVKE1pDA
         Taew==
X-Gm-Message-State: AOAM531o3ov3T6C9ZQP0EiESUM6DAd054pDka1tiYM0jBTKu+prsmZPV
        0wgbtk274yQbUJVZpl+W1RmQmw==
X-Google-Smtp-Source: ABdhPJy7vAg6Wk9iiMrbNn5lgd6eyr0aYiYRUK/DQNz5L+ETLAiEIGHSyR4AwU8VzD95aqZb/OLyMQ==
X-Received: by 2002:a63:1706:: with SMTP id x6mr1106846pgl.362.1617159925748;
        Tue, 30 Mar 2021 20:05:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:25 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v3 02/12] buildid: Stash away kernels build ID on init
Date:   Tue, 30 Mar 2021 20:05:10 -0700
Message-Id: <20210331030520.3816265-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331030520.3816265-1-swboyd@chromium.org>
References: <20210331030520.3816265-1-swboyd@chromium.org>
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
 lib/buildid.c           | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index ebce93f26d06..0312660089c3 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -10,4 +10,7 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
+extern unsigned char vmlinux_build_id[];
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
index 010ab0674cb9..b939bbc59233 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/buildid.h>
+#include <linux/cache.h>
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
@@ -171,3 +172,19 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 {
 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
 }
+
+unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
+
+/**
+ * init_vmlinux_build_id - Get the running kernel's build ID
+ *
+ * Return: Running kernel's build ID
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

