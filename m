Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA63B3297CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbhCAWyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbhCARtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:49:42 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D15C06121D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:47:56 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id a4so12043908pgc.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CeLzYBc2/6C58NOZDJVHGzCqnQ3KpitJUBARyhZi7zg=;
        b=W0LXQwAbpxiw3UJZl/cA6iHAXazH82Gp5S3mbyx6KIz2yF5UZk2LXd96DAwVF6niV4
         dUaGFvkUfLoaiJ8T2wE3RRngO/uzjSgdjKevDIf8VMUi2RoeN8pZmdSDbRuteEFmMfh+
         jxB6l95GEpVNA1y1ahgi4J4+HMaNLU+o8NAlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CeLzYBc2/6C58NOZDJVHGzCqnQ3KpitJUBARyhZi7zg=;
        b=eCKn+1rCcIuAVYPa32DF8tivfu8fK+1QCf73chEkSizyXDoSlE+LYegfbLeWFrbmH8
         d0e6QkYC8QyMNgUVmTqZSW506CC/8TBfdYt2d8fk4HbN6+DYAspcOyf6zuOwCfa+upv0
         yOIPDBhugNsT2078ZjjMoaWZd+oG5dSSY+rR9QPkWPoLrG5PWpf0jcjyNfMps8cw/1mK
         XM9jCtDQcCMlKzGSi8cuCExHXZRMu5vBNvalKGTdPCqAwu+yX545+hk+T/5j1bOc+iC3
         ctEo68VnkGdaoOecbT6ywdRvimDTax/z7NSKN7q0OdaGxI2HauB0nH2YLiINQbrnEVbd
         2nZQ==
X-Gm-Message-State: AOAM533VF+oOB/MBiiKrbyfnmpEiR7VrA4FDQXlcV83vbG1VU9jceXdS
        drg1BZejzeAo34JfU2BopJO3XA==
X-Google-Smtp-Source: ABdhPJyNvn/UoMpLDmKMQ/n5kZSz+8dTO9WV0Bo+UATpoZwDoDh2pyO9Ewys+jSgtstfye/Ht36njA==
X-Received: by 2002:aa7:8503:0:b029:1ee:6e6c:694b with SMTP id v3-20020aa785030000b02901ee6e6c694bmr8736410pfn.18.1614620876542;
        Mon, 01 Mar 2021 09:47:56 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3c20:df33:e36:93df])
        by smtp.gmail.com with ESMTPSA id y202sm19071325pfb.153.2021.03.01.09.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:47:56 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH 4/7] module: Parse and stash build ID on insertion
Date:   Mon,  1 Mar 2021 09:47:46 -0800
Message-Id: <20210301174749.1269154-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301174749.1269154-1-swboyd@chromium.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the build ID of a module when it is inserted and stash it away in
'struct module' in case we print module symbols. This will be used in a
future patch to print the module build ID when module functions are in a
stack trace.

Note: we only do this if CONFIG_KALLSYMS is enabled, because if it isn't
enabled then module names aren't printed for symbolic pointers and thus
build IDs aren't printed either.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/module.h |  4 ++++
 kernel/module.c        | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 59f094fa6f74..9d1f6a5240c1 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -11,6 +11,7 @@
 
 #include <linux/list.h>
 #include <linux/stat.h>
+#include <linux/buildid.h>
 #include <linux/compiler.h>
 #include <linux/cache.h>
 #include <linux/kmod.h>
@@ -432,6 +433,9 @@ struct module {
 
 	/* Notes attributes */
 	struct module_notes_attrs *notes_attrs;
+
+	/* Module build-id */
+	char build_id[BUILD_ID_STR_SIZE_MAX];
 #endif
 
 	/* The command line arguments (may be mangled).  People like
diff --git a/kernel/module.c b/kernel/module.c
index 30479355ab85..a7559a0de9d8 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -13,6 +13,7 @@
 #include <linux/trace_events.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
+#include <linux/buildid.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
@@ -2770,6 +2771,20 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 	}
 	mod->core_kallsyms.num_symtab = ndst;
 }
+
+static void module_init_build_id(struct module *mod, const struct load_info *info)
+{
+	const Elf_Shdr *sechdr;
+	unsigned int i;
+
+	for (i = 0; i < info->hdr->e_shnum; i++) {
+		sechdr = &info->sechdrs[i];
+		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
+		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
+					sechdr->sh_size))
+			break;
+	}
+}
 #else
 static inline void layout_symtab(struct module *mod, struct load_info *info)
 {
@@ -2778,6 +2793,10 @@ static inline void layout_symtab(struct module *mod, struct load_info *info)
 static void add_kallsyms(struct module *mod, const struct load_info *info)
 {
 }
+
+static void module_init_build_id(struct module *mod, const struct load_info *info)
+{
+}
 #endif /* CONFIG_KALLSYMS */
 
 static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsigned int num)
@@ -4004,6 +4023,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto free_arch_cleanup;
 	}
 
+	module_init_build_id(mod, info);
 	dynamic_debug_setup(mod, info->debug, info->num_debug);
 
 	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
-- 
https://chromeos.dev

