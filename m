Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE6339757
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhCLTWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhCLTVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:21:50 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C55CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:21:50 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id i1so18178803qvu.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fdqfNR+CjGGNSuJTg55c2hFzZvvxvJUGhqyHXXg4ybs=;
        b=nC4vXrBzqSl9AZnmLt2eJCNznY8YnPHT7ChQO1OQd2g0NDDmbq8/8MFMZXhP+9PR8A
         Dt6g78XS5HYJ29GGGz+4czTRfRrJfxcEVhdCG8xGzBUjxQw+Dug6g7mZkRC31hI0E+bh
         oal3xbIbIUFTqo/8N2L/xttfhxCurqIK5F9SqzGQ3YnTBf6uOI9JC7nuVgojaNGvpAmy
         Bs+CWgBLoblETKphLohfWM0x+cj0JGfjledhTg6RFLpXSiXLaqRNHa+b2hcWEq4to2Wj
         U8Y9eghudwUDAdHsZNQ+AWh5PdNm5AmYvCQJlHyMCl9SiMwec6jxnI3Ek3wElJbsI/R3
         o12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fdqfNR+CjGGNSuJTg55c2hFzZvvxvJUGhqyHXXg4ybs=;
        b=uoM+GJwtJbWuQqIkCuZP2WRgVWRJ8grwr81dEPf0Dqh9+qf4u5ir/0+ssbyIbB+k77
         XwgbyoHWcxldSecWVld0cYSIGyaferfQp57ocplVQ7f2rV370jcnsUnZTmz0pyoZv2JV
         ZBvw9Jq5JUxZwz5ZCIqTtBXNVJfebGTDszgKFgqqgOR6SbYRJE05Og+jyyhMSjuDnN7O
         2BjXGCUap40K6Nyh2z9iFRa4mRxkiNxFzzSkxe9XprPE7muHuVomYBpTeO37SQXBfzPc
         5UbmeHLDI6+C2Uj54QAQV2qeoQfSvWz07B76TAKxMdqvyjoOisZf2Fwr2GPiHa/f6qeK
         ovag==
X-Gm-Message-State: AOAM532Q5BkEaed2Xsc2ftkqQSBdqfuRWV8wwne6pgFYZpZZF2hf+Qrp
        9573rVlBJ/H4AutA/Cs8FBlW88NPDArWctrSoHk=
X-Google-Smtp-Source: ABdhPJz1W7I3Gcpoo/shePfLsf4g40kt3kjDxlfyBrCXW2fkkyPRa+kL8DMZW9K4YmYWjGinZxNxzMS7NbBIfnmjO1k=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f1f4:3252:5898:ad84])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:425:: with SMTP id
 a5mr8339289qvy.55.1615576909351; Fri, 12 Mar 2021 11:21:49 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:21:39 -0800
Message-Id: <20210312192139.2503087-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] gcov: fix clang-11+ support
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM changed the expected function signatures for llvm_gcda_start_file()
and llvm_gcda_emit_function() in the clang-11 release. Users of clang-11
or newer may have noticed their kernels failing to boot due to a panic
when enabling CONFIG_GCOV_KERNEL=y +CONFIG_GCOV_PROFILE_ALL=y.  Fix up
the function signatures so calling these functions doesn't panic the
kernel.

When we drop clang-10 support from the kernel, we should carefully
update the original implementations to try to preserve git blame,
deleting these implementations.

Link: https://reviews.llvm.org/rGcdd683b516d147925212724b09ec6fb792a40041
Link: https://reviews.llvm.org/rG13a633b438b6500ecad9e4f936ebadf3411d0f44
Cc: Fangrui Song <maskray@google.com>
Reported-by: Prasad Sodagudi<psodagud@quicinc.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 kernel/gcov/clang.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index c94b820a1b62..20e6760ec05d 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -75,7 +75,9 @@ struct gcov_fn_info {
 
 	u32 num_counters;
 	u64 *counters;
+#if __clang_major__ < 11
 	const char *function_name;
+#endif
 };
 
 static struct gcov_info *current_info;
@@ -105,6 +107,7 @@ void llvm_gcov_init(llvm_gcov_callback writeout, llvm_gcov_callback flush)
 }
 EXPORT_SYMBOL(llvm_gcov_init);
 
+#if __clang_major__ < 11
 void llvm_gcda_start_file(const char *orig_filename, const char version[4],
 		u32 checksum)
 {
@@ -113,7 +116,17 @@ void llvm_gcda_start_file(const char *orig_filename, const char version[4],
 	current_info->checksum = checksum;
 }
 EXPORT_SYMBOL(llvm_gcda_start_file);
+#else
+void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
+{
+	current_info->filename = orig_filename;
+	current_info->version = version;
+	current_info->checksum = checksum;
+}
+EXPORT_SYMBOL(llvm_gcda_start_file);
+#endif
 
+#if __clang_major__ < 11
 void llvm_gcda_emit_function(u32 ident, const char *function_name,
 		u32 func_checksum, u8 use_extra_checksum, u32 cfg_checksum)
 {
@@ -133,6 +146,24 @@ void llvm_gcda_emit_function(u32 ident, const char *function_name,
 	list_add_tail(&info->head, &current_info->functions);
 }
 EXPORT_SYMBOL(llvm_gcda_emit_function);
+#else
+void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
+		u8 use_extra_checksum, u32 cfg_checksum)
+{
+	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info)
+		return;
+
+	INIT_LIST_HEAD(&info->head);
+	info->ident = ident;
+	info->checksum = func_checksum;
+	info->use_extra_checksum = use_extra_checksum;
+	info->cfg_checksum = cfg_checksum;
+	list_add_tail(&info->head, &current_info->functions);
+}
+EXPORT_SYMBOL(llvm_gcda_emit_function);
+#endif
 
 void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
 {
@@ -295,6 +326,7 @@ void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
 	}
 }
 
+#if __clang_major__ < 11
 static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
 {
 	size_t cv_size; /* counter values size */
@@ -322,6 +354,28 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
 	kfree(fn_dup);
 	return NULL;
 }
+#else
+static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
+{
+	size_t cv_size; /* counter values size */
+	struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
+			GFP_KERNEL);
+	if (!fn_dup)
+		return NULL;
+	INIT_LIST_HEAD(&fn_dup->head);
+
+	cv_size = fn->num_counters * sizeof(fn->counters[0]);
+	fn_dup->counters = vmalloc(cv_size);
+	if (!fn_dup->counters) {
+		kfree(fn_dup);
+		return NULL;
+	}
+
+	memcpy(fn_dup->counters, fn->counters, cv_size);
+
+	return fn_dup;
+}
+#endif
 
 /**
  * gcov_info_dup - duplicate profiling data set
@@ -362,6 +416,7 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
  * gcov_info_free - release memory for profiling data set duplicate
  * @info: profiling data set duplicate to free
  */
+#if __clang_major__ < 11
 void gcov_info_free(struct gcov_info *info)
 {
 	struct gcov_fn_info *fn, *tmp;
@@ -375,6 +430,20 @@ void gcov_info_free(struct gcov_info *info)
 	kfree(info->filename);
 	kfree(info);
 }
+#else
+void gcov_info_free(struct gcov_info *info)
+{
+	struct gcov_fn_info *fn, *tmp;
+
+	list_for_each_entry_safe(fn, tmp, &info->functions, head) {
+		vfree(fn->counters);
+		list_del(&fn->head);
+		kfree(fn);
+	}
+	kfree(info->filename);
+	kfree(info);
+}
+#endif
 
 #define ITER_STRIDE	PAGE_SIZE
 

base-commit: f78d76e72a4671ea52d12752d92077788b4f5d50
-- 
2.31.0.rc2.261.g7f71774620-goog

