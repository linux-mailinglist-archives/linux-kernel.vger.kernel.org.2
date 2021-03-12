Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FDC3399C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 23:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhCLWmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 17:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbhCLWlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 17:41:49 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:41:48 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id k92so14850168qva.20
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J1whg9fhlESRN1AXNMF/1Wm8AFqRcdPHT/jpGd62N0s=;
        b=c5Rqb6ADovl1GO0RxMB7Ym8wNK3YTc4QTNoh/bbt6KG5eYsVKnAdVC2Ht8t/xFv28/
         4r9fBH5q+009NF91F91W5hhO0zu1RDrn9VOCVd11Njr/OKuyVFf4f972YruDQo7Ie8ax
         /dxxMIXLQgZZwFIFeZlGwjF9jejtfzvgH1nJT8/0DS3nG7d65q8VsC1sD2yYIMz+LWiQ
         18qadOwciCfs1sxtr/HizrAgXzokG5h2MJxVG65X5vK4Tf/3AaVwu0t8o6yR4CawtP7T
         1R1ztVQNoINnx2BNl2oLswTCYOwt0ugPSupDE9jr7MZU3hkTzHdEXrz3G37zm+mG6caC
         9ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J1whg9fhlESRN1AXNMF/1Wm8AFqRcdPHT/jpGd62N0s=;
        b=aedmm0tc+l3AdGe67z4OKM29EjPEq2+kUuLFnHjQIHX+yPfkBOiGnglOZKaFvVlYvi
         jI27879cPGqp0gyDWCDrDldoP3hs6nrcen8q2BURuBCgF9F1biwuE9449y91LBS32WQp
         tXZ+SmjNrs9s5JbQw8BGVgMx2m4Tm2WaqJ7Kw1Te+m0A23v9rJaG83nIc7GACh8hGWiS
         ZGpIY47U93LtHrTgUNfJFwmR1wOF2M0/9/iifpVVidwxeBlPsjcLY/4OTkFFlAxnzJ1w
         bNiOLn2vUlqfyrMs8rqSS6ZzOYJkm9GjNhGyBWYWkjzjVKsJTe0+5jsJgnHw1CUpwNCq
         SMNA==
X-Gm-Message-State: AOAM533EgtQB3c5Ku3RCTgYWzzCLSrmeSZWPnA+uoBtho4XR6T34b1Zs
        74YEKIytnYBBhOvgvHi78jlzvjLnQUyRkN6607E=
X-Google-Smtp-Source: ABdhPJwxOcznDUHTXkJ1DGUIHrYh2dEp37uZojOXU3eZLCKN7cPqnEYLijcu5+FLto9z0el6hRx+5lvWPlCGw6DjME4=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f1f4:3252:5898:ad84])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:5ce8:: with SMTP id
 iv8mr474566qvb.16.1615588907955; Fri, 12 Mar 2021 14:41:47 -0800 (PST)
Date:   Fri, 12 Mar 2021 14:41:32 -0800
In-Reply-To: <20210312224132.3413602-1-ndesaulniers@google.com>
Message-Id: <20210312224132.3413602-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210312220518.rz6cjh33bkwaumzz@archlinux-ax161> <20210312224132.3413602-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 2/2] gcov: clang: drop support for clang-10 and older
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM changed the expected function signatures for llvm_gcda_start_file()
and llvm_gcda_emit_function() in the clang-11 release. Drop the older
implementations and require folks to upgrade their compiler if they're
interested in GCOV support.

Link: https://reviews.llvm.org/rGcdd683b516d147925212724b09ec6fb792a40041
Link: https://reviews.llvm.org/rG13a633b438b6500ecad9e4f936ebadf3411d0f44
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
For an easier time reviewing this series, reviewers may want to apply
these patches, then check the overall diff with `git diff origin/HEAD`.

 kernel/gcov/Kconfig |  1 +
 kernel/gcov/clang.c | 85 ---------------------------------------------
 2 files changed, 1 insertion(+), 85 deletions(-)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index f62de2dea8a3..58f87a3092f3 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -4,6 +4,7 @@ menu "GCOV-based kernel profiling"
 config GCOV_KERNEL
 	bool "Enable gcov-based kernel profiling"
 	depends on DEBUG_FS
+	depends on !CC_IS_CLANG || CLANG_VERSION >= 110000
 	select CONSTRUCTORS
 	default n
 	help
diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index 8743150db2ac..14de5644b5cc 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -75,9 +75,6 @@ struct gcov_fn_info {
 
 	u32 num_counters;
 	u64 *counters;
-#if CONFIG_CLANG_VERSION < 110000
-	const char *function_name;
-#endif
 };
 
 static struct gcov_info *current_info;
@@ -107,16 +104,6 @@ void llvm_gcov_init(llvm_gcov_callback writeout, llvm_gcov_callback flush)
 }
 EXPORT_SYMBOL(llvm_gcov_init);
 
-#if CONFIG_CLANG_VERSION < 110000
-void llvm_gcda_start_file(const char *orig_filename, const char version[4],
-		u32 checksum)
-{
-	current_info->filename = orig_filename;
-	memcpy(&current_info->version, version, sizeof(current_info->version));
-	current_info->checksum = checksum;
-}
-EXPORT_SYMBOL(llvm_gcda_start_file);
-#else
 void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
 {
 	current_info->filename = orig_filename;
@@ -124,29 +111,7 @@ void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
 	current_info->checksum = checksum;
 }
 EXPORT_SYMBOL(llvm_gcda_start_file);
-#endif
-
-#if CONFIG_CLANG_VERSION < 110000
-void llvm_gcda_emit_function(u32 ident, const char *function_name,
-		u32 func_checksum, u8 use_extra_checksum, u32 cfg_checksum)
-{
-	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
-
-	if (!info)
-		return;
 
-	INIT_LIST_HEAD(&info->head);
-	info->ident = ident;
-	info->checksum = func_checksum;
-	info->use_extra_checksum = use_extra_checksum;
-	info->cfg_checksum = cfg_checksum;
-	if (function_name)
-		info->function_name = kstrdup(function_name, GFP_KERNEL);
-
-	list_add_tail(&info->head, &current_info->functions);
-}
-EXPORT_SYMBOL(llvm_gcda_emit_function);
-#else
 void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
 		u8 use_extra_checksum, u32 cfg_checksum)
 {
@@ -163,7 +128,6 @@ void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
 	list_add_tail(&info->head, &current_info->functions);
 }
 EXPORT_SYMBOL(llvm_gcda_emit_function);
-#endif
 
 void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
 {
@@ -326,7 +290,6 @@ void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
 	}
 }
 
-#if CONFIG_CLANG_VERSION < 110000
 static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
 {
 	size_t cv_size; /* counter values size */
@@ -335,47 +298,15 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
 	if (!fn_dup)
 		return NULL;
 	INIT_LIST_HEAD(&fn_dup->head);
-
-	fn_dup->function_name = kstrdup(fn->function_name, GFP_KERNEL);
-	if (!fn_dup->function_name)
-		goto err_name;
-
-	cv_size = fn->num_counters * sizeof(fn->counters[0]);
-	fn_dup->counters = vmalloc(cv_size);
-	if (!fn_dup->counters)
-		goto err_counters;
-	memcpy(fn_dup->counters, fn->counters, cv_size);
-
-	return fn_dup;
-
-err_counters:
-	kfree(fn_dup->function_name);
-err_name:
-	kfree(fn_dup);
-	return NULL;
-}
-#else
-static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
-{
-	size_t cv_size; /* counter values size */
-	struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
-			GFP_KERNEL);
-	if (!fn_dup)
-		return NULL;
-	INIT_LIST_HEAD(&fn_dup->head);
-
 	cv_size = fn->num_counters * sizeof(fn->counters[0]);
 	fn_dup->counters = vmalloc(cv_size);
 	if (!fn_dup->counters) {
 		kfree(fn_dup);
 		return NULL;
 	}
-
 	memcpy(fn_dup->counters, fn->counters, cv_size);
-
 	return fn_dup;
 }
-#endif
 
 /**
  * gcov_info_dup - duplicate profiling data set
@@ -416,21 +347,6 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
  * gcov_info_free - release memory for profiling data set duplicate
  * @info: profiling data set duplicate to free
  */
-#if CONFIG_CLANG_VERSION < 110000
-void gcov_info_free(struct gcov_info *info)
-{
-	struct gcov_fn_info *fn, *tmp;
-
-	list_for_each_entry_safe(fn, tmp, &info->functions, head) {
-		kfree(fn->function_name);
-		vfree(fn->counters);
-		list_del(&fn->head);
-		kfree(fn);
-	}
-	kfree(info->filename);
-	kfree(info);
-}
-#else
 void gcov_info_free(struct gcov_info *info)
 {
 	struct gcov_fn_info *fn, *tmp;
@@ -443,7 +359,6 @@ void gcov_info_free(struct gcov_info *info)
 	kfree(info->filename);
 	kfree(info);
 }
-#endif
 
 #define ITER_STRIDE	PAGE_SIZE
 
-- 
2.31.0.rc2.261.g7f71774620-goog

