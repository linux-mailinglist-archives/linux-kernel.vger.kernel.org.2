Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39365379BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhEKAkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhEKAj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:39:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F43C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g24so10729120pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNr5btaUnSetNhJ+yyRaaTxmPcfBotU+IOGTNNGA/IQ=;
        b=EPHd5GVFZB7FQshHLcCwQ3AVW2O0dFKdhAfBFHP3sIIHTdfbx4f1W/G3fWebRWawvc
         cViOTHoZedLYjRxKO4JNGkRb7tV8FY2uJIE6/P57g2bNpuhAjYflmdsx5GLzpUGNPAdW
         Vr98asez/kBq5Bf+72SDmFdqVH7Os0iZrlGzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNr5btaUnSetNhJ+yyRaaTxmPcfBotU+IOGTNNGA/IQ=;
        b=Cc+pO6NHFzPtwe8rVhbGqX6BCFaNQ+ZOeD3D4NDkvoizDJuH8EnqM70nf/W+TIarOS
         p8U5+fZI13n1V7XMXYa9WItkNBgc+kl2stAjzntA48j2oUftyZ5QAUFmARRCvdIlA2iY
         nKdm64497QLbUgse54uuhK+5CQXkjsB02VK7PrqYYD6zosjbflkgZHb2JfWz9O/QppQz
         g9rUwfndM8Wfvi6fOy6rmh4luYNB8J13Ouk+VFMIDEbYtD9N+yZ0en7+LFdBhr5tfTUK
         KMD8RQW1I3ZCt5FL/UoO8EJshp3tZCQzCnuuGeXIhBe8zlnermLLRWK2YVF6tLn9wTBs
         TcnQ==
X-Gm-Message-State: AOAM5326McD9kRxADO17oNqcWCn+PCJv1Fvsc4PQvEI37Jv0PzQmTVLj
        jIgm6AqD3ChnZCj4tLCNV+9V+g==
X-Google-Smtp-Source: ABdhPJzrFr6iinMb8f8HiQKfJQSrqG/uwSPoXW/o246WEmC2gNqQHdwr4fKpPohlYqKHjCAyGw2MgQ==
X-Received: by 2002:a17:903:244:b029:ec:9666:9fc6 with SMTP id j4-20020a1709030244b02900ec96669fc6mr27050995plh.63.1620693531517;
        Mon, 10 May 2021 17:38:51 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:38:51 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v6 03/13] buildid: Stash away kernels build ID on init
Date:   Mon, 10 May 2021 17:38:35 -0700
Message-Id: <20210511003845.2429846-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
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
Acked-by: Baoquan He <bhe@redhat.com>
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

