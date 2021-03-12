Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBF7339834
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhCLU0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhCLUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE86C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:25:48 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso11612372pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l1XdOGwIHlgShuWyG/qyw32Z0LhndfoXT9jRJKn1tLU=;
        b=qrvpBtlTj5Hdli2+67eRBlZAHhpWIR6JFbnomelMkH0t/CIb8NHxaGPyUFHiV0I2t1
         Z172xHAs2wLE7cnVYg/IeOvzQoFNAlo3oQuyGP2iFUuhINw+aqKBe70Oo7saK0ioSGBP
         EssWrOaebhInuUoq8ZSkJHzAhkTl4pYle1JCvbimw7JPA+nkQ6u3sTq7MfgIrxlWswUg
         GVNd+30KYNvcA+E5N69DuTEuDzddjE7cXn1/n3D5S9sVr6LREVH4LWkcibxZwj0xAHIs
         OFR1QsnvGKE7rDZoNoIcQJsceMkUMu07YdeIvT3/ReM1Fee00Kw2e2reqgp9Zl4L835B
         TXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1XdOGwIHlgShuWyG/qyw32Z0LhndfoXT9jRJKn1tLU=;
        b=mh6PueGV0E9rdem7a2MxAaVAIwK3tjShe/yIWnvvTKTqbrqPEMggBvGTNQYgjylBJV
         n9ZSsdEJ8rw/1hGv5x/gLiSlfr2M3QrP9xjlk8/PVXD395A5j1ZtvyXABj2e923CMebg
         gwhjf1Ofo86MFUxod+UoMwMPjELTJRkXlOMc2pj5mEyVDgAw3MyGORmfoKsvAu4acyAb
         aoqe0r+r3IqFijjpeLFcTs2ZjexZiCrS2+B/RC2HhjbWeGcQRLn/JUhM0lEOhaIFbdOb
         H41LEYU9jcj/xASN4MYtBPPC4un6nhVvGjY96wYBqtd0DHnBVEnerTvCYwiJZ6BbTks3
         tyXw==
X-Gm-Message-State: AOAM531bc6ZwHkNN0BZDT9M4uMkxRq6eev2Rap/jLXep5rg3J53ZyPl/
        fFjS1ybBUGmIs36SHerlUoubQg==
X-Google-Smtp-Source: ABdhPJwMMapxN9XHYzCcmSDNS8XPMb87YXRwx+wyeg99NH/Ojn0TT0ja010ax9rM/D+4KdDqeQcXNw==
X-Received: by 2002:a17:902:e884:b029:e5:fece:3bb0 with SMTP id w4-20020a170902e884b02900e5fece3bb0mr791629plg.61.1615580747373;
        Fri, 12 Mar 2021 12:25:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:bca6:9fa5:8695:2f0d])
        by smtp.gmail.com with ESMTPSA id t5sm5980038pgl.89.2021.03.12.12.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:46 -0800 (PST)
Date:   Fri, 12 Mar 2021 12:25:37 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] gcov: fix clang-11+ support
Message-ID: <20210312202537.z77v4qnvptbrug2f@google.com>
References: <20210312192139.2503087-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210312192139.2503087-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-12, Nick Desaulniers wrote:
>LLVM changed the expected function signatures for llvm_gcda_start_file()
>and llvm_gcda_emit_function() in the clang-11 release. Users of clang-11
>or newer may have noticed their kernels failing to boot due to a panic
>when enabling CONFIG_GCOV_KERNEL=y +CONFIG_GCOV_PROFILE_ALL=y.  Fix up
>the function signatures so calling these functions doesn't panic the
>kernel.
>
>When we drop clang-10 support from the kernel, we should carefully
>update the original implementations to try to preserve git blame,
>deleting these implementations.
>
>Link: https://reviews.llvm.org/rGcdd683b516d147925212724b09ec6fb792a40041
>Link: https://reviews.llvm.org/rG13a633b438b6500ecad9e4f936ebadf3411d0f44
>Cc: Fangrui Song <maskray@google.com>
>Reported-by: Prasad Sodagudi<psodagud@quicinc.com>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>---
> kernel/gcov/clang.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 69 insertions(+)
>
>diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
>index c94b820a1b62..20e6760ec05d 100644
>--- a/kernel/gcov/clang.c
>+++ b/kernel/gcov/clang.c
>@@ -75,7 +75,9 @@ struct gcov_fn_info {
>
> 	u32 num_counters;
> 	u64 *counters;
>+#if __clang_major__ < 11
> 	const char *function_name;
>+#endif

function_name can be unconditionally deleted. It is not used by llvm-cov
gcov.  You'll need to delete a few assignments to gcov_info_free but you
can then unify the gcov_fn_info_dup and gcov_info_free implementations.

> };
>
> static struct gcov_info *current_info;
>@@ -105,6 +107,7 @@ void llvm_gcov_init(llvm_gcov_callback writeout, llvm_gcov_callback flush)
> }
> EXPORT_SYMBOL(llvm_gcov_init);
>
>+#if __clang_major__ < 11
> void llvm_gcda_start_file(const char *orig_filename, const char version[4],
> 		u32 checksum)
> {
>@@ -113,7 +116,17 @@ void llvm_gcda_start_file(const char *orig_filename, const char version[4],
> 	current_info->checksum = checksum;
> }
> EXPORT_SYMBOL(llvm_gcda_start_file);
>+#else
>+void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
>+{
>+	current_info->filename = orig_filename;
>+	current_info->version = version;
>+	current_info->checksum = checksum;
>+}
>+EXPORT_SYMBOL(llvm_gcda_start_file);
>+#endif

LG. On big-endian systems, clang < 11 emitted .gcno/.gcda files do not
work with llvm-cov gcov < 11.  To fix it and make .gcno/.gcda work with
gcc gcov I chose to break compatibility (and make all the breaking
changes like deleting some CC1 options) in a short window. At that time
I was not aware that there is the kernel implementation. Later on I was
CCed on a few https://github.com/ClangBuiltLinux/linux/ gcov issues but
I forgot to mention the interface change.

Now in clang 11 onward, clang --coverage defaults to the gcov 4.8
compatible format. You can specify the CC1 option (internal option,
subject to change) -coverage-version to make it compatible with other
versions' gcov.

-Xclang -coverage-version='407*' => 4.7
-Xclang -coverage-version='704*' => 7.4
-Xclang -coverage-version='B02*' => 10.2 (('B'-'A')*10 = 10)

Reviewed-by: Fangrui Song <maskray@google.com>

>+#if __clang_major__ < 11
> void llvm_gcda_emit_function(u32 ident, const char *function_name,
> 		u32 func_checksum, u8 use_extra_checksum, u32 cfg_checksum)
> {
>@@ -133,6 +146,24 @@ void llvm_gcda_emit_function(u32 ident, const char *function_name,
> 	list_add_tail(&info->head, &current_info->functions);
> }
> EXPORT_SYMBOL(llvm_gcda_emit_function);
>+#else
>+void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
>+		u8 use_extra_checksum, u32 cfg_checksum)
>+{
>+	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
>+
>+	if (!info)
>+		return;
>+
>+	INIT_LIST_HEAD(&info->head);
>+	info->ident = ident;
>+	info->checksum = func_checksum;
>+	info->use_extra_checksum = use_extra_checksum;
>+	info->cfg_checksum = cfg_checksum;
>+	list_add_tail(&info->head, &current_info->functions);
>+}
>+EXPORT_SYMBOL(llvm_gcda_emit_function);
>+#endif
>
> void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
> {
>@@ -295,6 +326,7 @@ void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
> 	}
> }
>
>+#if __clang_major__ < 11
> static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> {
> 	size_t cv_size; /* counter values size */
>@@ -322,6 +354,28 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> 	kfree(fn_dup);
> 	return NULL;
> }
>+#else
>+static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
>+{
>+	size_t cv_size; /* counter values size */
>+	struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
>+			GFP_KERNEL);
>+	if (!fn_dup)
>+		return NULL;
>+	INIT_LIST_HEAD(&fn_dup->head);
>+
>+	cv_size = fn->num_counters * sizeof(fn->counters[0]);
>+	fn_dup->counters = vmalloc(cv_size);
>+	if (!fn_dup->counters) {
>+		kfree(fn_dup);
>+		return NULL;
>+	}
>+
>+	memcpy(fn_dup->counters, fn->counters, cv_size);
>+
>+	return fn_dup;
>+}
>+#endif
>
> /**
>  * gcov_info_dup - duplicate profiling data set
>@@ -362,6 +416,7 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
>  * gcov_info_free - release memory for profiling data set duplicate
>  * @info: profiling data set duplicate to free
>  */
>+#if __clang_major__ < 11
> void gcov_info_free(struct gcov_info *info)
> {
> 	struct gcov_fn_info *fn, *tmp;
>@@ -375,6 +430,20 @@ void gcov_info_free(struct gcov_info *info)
> 	kfree(info->filename);
> 	kfree(info);
> }
>+#else
>+void gcov_info_free(struct gcov_info *info)
>+{
>+	struct gcov_fn_info *fn, *tmp;
>+
>+	list_for_each_entry_safe(fn, tmp, &info->functions, head) {
>+		vfree(fn->counters);
>+		list_del(&fn->head);
>+		kfree(fn);
>+	}
>+	kfree(info->filename);
>+	kfree(info);
>+}
>+#endif
>
> #define ITER_STRIDE	PAGE_SIZE
>
>
>base-commit: f78d76e72a4671ea52d12752d92077788b4f5d50
>-- 
>2.31.0.rc2.261.g7f71774620-goog
>
