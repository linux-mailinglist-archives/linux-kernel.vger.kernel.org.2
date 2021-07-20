Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D944C3D0463
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 00:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhGTVg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 17:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhGTVgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 17:36:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4003CC0613DE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:16:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f17so39087wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rOPRdCz8cQm0jFl0E5n8kfyoXFor2GcetLoZd95FWRg=;
        b=DPN2qi0v93XbCsQF87FfDXlkDq8TrhDngoj9OmE9GG/zHqiC1stPrdcDw4ZPDLVOV2
         ZV7CUwlrToMUg4U2IVotQc3eUejoif/CkbeqLA7JlDS3D1m1FT7poqiyNnZtW3UZV9LB
         EX5piRv5Am1tIQcKWJZmAay7tx/1ix2Wn3/3fv+5+vQMWxoiTY2K9q4cmIi2m2tOxES9
         90iaRzj9QESbr/h6TE4n5IcK8wFENeEObt+RkQMhqBmkYCmXa6IXf5WY3GgPjQknlRIn
         p4RLurqkEYJDqt0osuxddGixGY3ANeVK74erz30bUcSP/HcEtHaeDcPkRG3iKWc/QO1t
         6lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rOPRdCz8cQm0jFl0E5n8kfyoXFor2GcetLoZd95FWRg=;
        b=uPswd3Km+fu/ZfILgRPDocLIsq6npaSAkaWPxA60dQ3ExufUzuCS1MjbrDvR6QucRz
         QJH9y864B/WZ/e9Zyj+36gz3/4vEhy7NEY1QqDtVO0C7O1T0sc3msR2BevRA8MVrvTbe
         HcAe/3XM1htOMzgqcQPIKVlOlnvG3TGB3PWKUiLRz3tCguFfDNqHYI0aaglD3gOQ9g3z
         +jhqQBC6OGcRu06GfoZ4CTLkp+JeVPqymALSwIFfJcSv5WwscG9cNLJkukbfXyABusfU
         0tgcidm7krEXZ6YoomBFEcnlbyu9FtU5HNsq42ExSWNnYKGXdBFTqXzGkRIwltmeLtRJ
         XvLg==
X-Gm-Message-State: AOAM530CzpjatEjJbuwQYq+wGhwP8YqLN8YA69qv4xJZsVVyTjg6R+yX
        6uA/o8lKi3OxJe/fZy/VWTg=
X-Google-Smtp-Source: ABdhPJyqlHgXmmwPbJ6zNuV0Ar/aJKt/dxSEMutP7zA243aGU1v10OyGcYRKHLZtbFUS/+/a66Co/w==
X-Received: by 2002:adf:ff85:: with SMTP id j5mr38992354wrr.49.1626819397767;
        Tue, 20 Jul 2021 15:16:37 -0700 (PDT)
Received: from pswork.fritz.box (i59F72CF2.versanet.de. [89.247.44.242])
        by smtp.gmail.com with ESMTPSA id j23sm3339045wmo.26.2021.07.20.15.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:16:37 -0700 (PDT)
From:   treasure4paddy@gmail.com
X-Google-Original-From: padmanabha.srinivasaiah@harman.com
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     samitolvanen@google.com, treasure4paddy@gmail.com,
        Padmanabha Srinivasaiah <padmanabha.srinivasaiah@harman.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] tracing/syscalls: Clang cfi enable syscall events
Date:   Wed, 21 Jul 2021 00:15:41 +0200
Message-Id: <20210720221541.16164-1-padmanabha.srinivasaiah@harman.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Padmanabha Srinivasaiah <padmanabha.srinivasaiah@harman.com>

With clang cfi syscall symbols are appended with <syscall>.cfi_jt,
hence syscall tracer can not find corresponding syscall name.
And results in no syscall ftrace events with CFI.

To fix this issue, this introduces custom cleanup_syscall_symbol_name()
to strip postfix ".cfi_jt" before comparing syscall and symbol name.

Signed-off-by: Padmanabha Srinivasaiah <padmanabha.srinivasaiah@harman.com>
---
 kernel/trace/trace_syscalls.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 8bfcd3b09422..dbc253fea34d 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -79,6 +79,27 @@ trace_get_syscall_nr(struct task_struct *task, struct pt_regs *regs)
 }
 #endif /* ARCH_TRACE_IGNORE_COMPAT_SYSCALLS */
 
+#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
+/*
+ * For a syscall symbol, clang generated non-canonical local jump tables
+ * will have entry as <syscall>.cfi_jt and address of this entry
+ * will be used to replace references to the syscall symbol.
+ * so we will strip the postfix from appended symbol name.
+ */
+static inline bool cleanup_syscall_symbol_name(char *s)
+{
+	char *res;
+
+	res = strrchr(s, '.');
+	if (res)
+		*res = '\0';
+
+	return res != NULL;
+}
+#else
+static inline bool cleanup_syscall_symbol_name(char *s) { return false; }
+#endif
+
 static __init struct syscall_metadata *
 find_syscall_meta(unsigned long syscall)
 {
@@ -90,6 +111,7 @@ find_syscall_meta(unsigned long syscall)
 	start = __start_syscalls_metadata;
 	stop = __stop_syscalls_metadata;
 	kallsyms_lookup(syscall, NULL, NULL, NULL, str);
+	cleanup_syscall_symbol_name(str);
 
 	if (arch_syscall_match_sym_name(str, "sys_ni_syscall"))
 		return NULL;
-- 
2.17.1

