Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C36235749D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355459AbhDGSzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348624AbhDGSzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:55:16 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F2C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:55:06 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w8so12375447qtk.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=732FuhF+yEqhx0MeVArWdFACqgUAoeDTQ99xUhtV4rU=;
        b=QvouwaN6YG/qoHUB8Qeyewtdqkqa2Q/dqDmCniod80CGN/jSvsW1xVnUOU1puMaSft
         OxNQKCSZDFmxAMbbHvakSmso29sjPHGxswRxhyXrVaFpi2GsA90DIv0X10IsWuc9bOGM
         /5SWJ63q1fNgrMpR3Z7kfhIB2GfUIzTT6uRUCGWnU/yYzhDMFVgvqRP5HRSNO9DdtbVC
         RH/+1Aq4tDpwSc56dfh/9P67azz3eS6I16zBozk1FaOJmkSVLxLAN5YDzTzJRKHCOFUB
         2V5uBAmdHIyF/gZoPMJzMzvRSgs2d4TgkQwR5ZberTfZLkcaEOjp20TAVqiasVKwiX8/
         vP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=732FuhF+yEqhx0MeVArWdFACqgUAoeDTQ99xUhtV4rU=;
        b=Sc0DcXqlv+QxFCE2qbyisWfv4XYX9VgfY04erNg0lvfBgviNereIdlGVOsa13zZWa4
         cll5twM/uBOrIMGP6RsaLTKqsQ394WX7Vw1zubXpMmet43AWQBFybRhCtnRHis+gfM8x
         NoqLi260rJ9UDLhSEQJvrZWRVvFpqdOBdYBmztYwvcogeN9VZfo5Nn1LyNI/R+688nBp
         wBurt5VdPoaVzJfMyW5UC6N0iqxMq+3PfZdY085sKdt9KdqfCFvNDZjIhqUyExVp9TPj
         AqycWLcJMmlsdzSIMfWxzhFmC5y9uJRuGlwZEe1+GfaFP1RYdCgvh6YBO1rxSuykgPAt
         HKOg==
X-Gm-Message-State: AOAM531sRKY8du0dYkbdoG76wwVxjvvpzi0Zbw8q5MdHmsek7O4P+u94
        oC1vQCa3iHF+5xQgr1EjXtMFT/GFKqNo06SVuGY=
X-Google-Smtp-Source: ABdhPJx+MwaWLhazSCXDyW0uPMVFfTmpoZ39SGpls22P89Am1HbnFr+5NI+sxrG4NG2cTV3NnJ6YFlFhasuxDhGps/g=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:c454:8587:ce1c:e900])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:a404:: with SMTP id
 w4mr4975968qvw.45.1617821705987; Wed, 07 Apr 2021 11:55:05 -0700 (PDT)
Date:   Wed,  7 Apr 2021 11:54:56 -0700
In-Reply-To: <20210407185456.41943-1-ndesaulniers@google.com>
Message-Id: <20210407185456.41943-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210407185456.41943-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 2/2] gcov: re-drop support for clang-10
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM changed the expected function signatures for
llvm_gcda_emit_function() in the clang-11 release.  Drop the older
implementations and require folks to upgrade their compiler if they're
interested in GCOV support.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 kernel/gcov/clang.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index 1747204541bf..78c4dc751080 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -69,9 +69,6 @@ struct gcov_fn_info {
 
 	u32 ident;
 	u32 checksum;
-#if CONFIG_CLANG_VERSION < 110000
-	u8 use_extra_checksum;
-#endif
 	u32 cfg_checksum;
 
 	u32 num_counters;
@@ -113,23 +110,6 @@ void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
 }
 EXPORT_SYMBOL(llvm_gcda_start_file);
 
-#if CONFIG_CLANG_VERSION < 110000
-void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
-		u8 use_extra_checksum, u32 cfg_checksum)
-{
-	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
-
-	if (!info)
-		return;
-
-	INIT_LIST_HEAD(&info->head);
-	info->ident = ident;
-	info->checksum = func_checksum;
-	info->use_extra_checksum = use_extra_checksum;
-	info->cfg_checksum = cfg_checksum;
-	list_add_tail(&info->head, &current_info->functions);
-}
-#else
 void llvm_gcda_emit_function(u32 ident, u32 func_checksum, u32 cfg_checksum)
 {
 	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
@@ -143,7 +123,6 @@ void llvm_gcda_emit_function(u32 ident, u32 func_checksum, u32 cfg_checksum)
 	info->cfg_checksum = cfg_checksum;
 	list_add_tail(&info->head, &current_info->functions);
 }
-#endif
 EXPORT_SYMBOL(llvm_gcda_emit_function);
 
 void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
@@ -274,16 +253,8 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
 		!list_is_last(&fn_ptr2->head, &info2->functions)) {
 		if (fn_ptr1->checksum != fn_ptr2->checksum)
 			return false;
-#if CONFIG_CLANG_VERSION < 110000
-		if (fn_ptr1->use_extra_checksum != fn_ptr2->use_extra_checksum)
-			return false;
-		if (fn_ptr1->use_extra_checksum &&
-			fn_ptr1->cfg_checksum != fn_ptr2->cfg_checksum)
-			return false;
-#else
 		if (fn_ptr1->cfg_checksum != fn_ptr2->cfg_checksum)
 			return false;
-#endif
 		fn_ptr1 = list_next_entry(fn_ptr1, head);
 		fn_ptr2 = list_next_entry(fn_ptr2, head);
 	}
@@ -403,21 +374,10 @@ size_t convert_to_gcda(char *buffer, struct gcov_info *info)
 		u32 i;
 
 		pos += store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION);
-#if CONFIG_CLANG_VERSION < 110000
-		pos += store_gcov_u32(buffer, pos,
-			fi_ptr->use_extra_checksum ? 3 : 2);
-#else
 		pos += store_gcov_u32(buffer, pos, 3);
-#endif
 		pos += store_gcov_u32(buffer, pos, fi_ptr->ident);
 		pos += store_gcov_u32(buffer, pos, fi_ptr->checksum);
-#if CONFIG_CLANG_VERSION < 110000
-		if (fi_ptr->use_extra_checksum)
-			pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
-#else
 		pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
-#endif
-
 		pos += store_gcov_u32(buffer, pos, GCOV_TAG_COUNTER_BASE);
 		pos += store_gcov_u32(buffer, pos, fi_ptr->num_counters * 2);
 		for (i = 0; i < fi_ptr->num_counters; i++)
-- 
2.31.1.295.g9ea45b61b8-goog

