Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17FB3574CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348784AbhDGTIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDGTIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:08:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F9C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 12:07:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bg21so7267194pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJr8wPst998PqQT7MGZfQ+Xd7fdt8VxKbhROA1rDigw=;
        b=jGwtRoP0LmUn59xwPUew7XiNR74RKMDZiCTLNe27aEg7xww+CEWE0NO2orECDGIdEg
         sZ124udMwXG2ANUuBW8K1kQluj1Qoq0GCpSfDitIRuPcjkc3eOm0noGGfY3NmpA4m5eL
         1SygP058DSHKfY/2dLPJ9TqpPSX4iBDwo9mk6DLD1WcXODmqROYBh/QVpSk3j87AycBR
         0nJLpS+4tdekRiOgZb3aNDM72OwzMy1Z4E8aFl5oASATJJk5fjmPfVWTa1GjZJCDSJ/Q
         9Qjkr3EMC7AFAWwL5pIgC7yxWIkrsAYMPMNg/d/3J8yuktaKTioZ0XEd6xeGT5UV3aqY
         3ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJr8wPst998PqQT7MGZfQ+Xd7fdt8VxKbhROA1rDigw=;
        b=evuHJRtcuEIwbDQXiPeAVV9VyGFDjaAh5LqWFU5TWiqWerh15mjMlHxeOiOsu75MC0
         ndcTbVgf+4ddjSsmdi6ZmRrDej/yMgOjgH9g/ZBD8UsyCokvKTSn7/FH8cg4IsQLi26P
         P5dt9kCCh6ECs36vyguCOzVxJ8hnMctqM67lWJMxqPsNQph/Ikk/XdVxhp2eH2/Y0B+4
         /0OqXcIkgmu3Dhy4IiXKPBpXvTJ/Bsmp7giT5qnM8k2OGjCqnWf24QodEqylk+tHjjpC
         ldBilxd0MBurSdS64ZJ0EijpGm43JUBGKbZ8h+DQ9GBdpnd7qeyKusMAR5I4uvG4cUcC
         nTOw==
X-Gm-Message-State: AOAM532s49ATJu7VixWAi3Xpr6EZSixzI8J0InWA/C4BcrCdAySiY/Lz
        ekAsYFICMvOeMbO+YdAKBYCRxg==
X-Google-Smtp-Source: ABdhPJy6ER/aXOMH0lGUV3Xv0nIc/X4Vg57YlZH8UxQsY/AUXSSTgUcLXLNeDtu9NhER+A4fck6gpQ==
X-Received: by 2002:a17:90a:c981:: with SMTP id w1mr4788223pjt.176.1617822472991;
        Wed, 07 Apr 2021 12:07:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:2840:b668:1017:7fcf])
        by smtp.gmail.com with ESMTPSA id c21sm22216553pgl.71.2021.04.07.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 12:07:52 -0700 (PDT)
Date:   Wed, 7 Apr 2021 12:07:49 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: Re: [PATCH 2/2] gcov: re-drop support for clang-10
Message-ID: <20210407190749.p3h72h4zlshiyt76@google.com>
References: <20210407185456.41943-1-ndesaulniers@google.com>
 <20210407185456.41943-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210407185456.41943-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-04-07, Nick Desaulniers wrote:
>LLVM changed the expected function signatures for
>llvm_gcda_emit_function() in the clang-11 release.  Drop the older
>implementations and require folks to upgrade their compiler if they're
>interested in GCOV support.
>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>---
> kernel/gcov/clang.c | 40 ----------------------------------------
> 1 file changed, 40 deletions(-)
>
>diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
>index 1747204541bf..78c4dc751080 100644
>--- a/kernel/gcov/clang.c
>+++ b/kernel/gcov/clang.c
>@@ -69,9 +69,6 @@ struct gcov_fn_info {
>
> 	u32 ident;
> 	u32 checksum;
>-#if CONFIG_CLANG_VERSION < 110000
>-	u8 use_extra_checksum;
>-#endif
> 	u32 cfg_checksum;
>
> 	u32 num_counters;
>@@ -113,23 +110,6 @@ void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
> }
> EXPORT_SYMBOL(llvm_gcda_start_file);
>
>-#if CONFIG_CLANG_VERSION < 110000
>-void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
>-		u8 use_extra_checksum, u32 cfg_checksum)
>-{
>-	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
>-
>-	if (!info)
>-		return;
>-
>-	INIT_LIST_HEAD(&info->head);
>-	info->ident = ident;
>-	info->checksum = func_checksum;
>-	info->use_extra_checksum = use_extra_checksum;
>-	info->cfg_checksum = cfg_checksum;
>-	list_add_tail(&info->head, &current_info->functions);
>-}
>-#else
> void llvm_gcda_emit_function(u32 ident, u32 func_checksum, u32 cfg_checksum)
> {
> 	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
>@@ -143,7 +123,6 @@ void llvm_gcda_emit_function(u32 ident, u32 func_checksum, u32 cfg_checksum)
> 	info->cfg_checksum = cfg_checksum;
> 	list_add_tail(&info->head, &current_info->functions);
> }
>-#endif
> EXPORT_SYMBOL(llvm_gcda_emit_function);
>
> void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
>@@ -274,16 +253,8 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
> 		!list_is_last(&fn_ptr2->head, &info2->functions)) {
> 		if (fn_ptr1->checksum != fn_ptr2->checksum)
> 			return false;
>-#if CONFIG_CLANG_VERSION < 110000
>-		if (fn_ptr1->use_extra_checksum != fn_ptr2->use_extra_checksum)
>-			return false;
>-		if (fn_ptr1->use_extra_checksum &&
>-			fn_ptr1->cfg_checksum != fn_ptr2->cfg_checksum)
>-			return false;
>-#else
> 		if (fn_ptr1->cfg_checksum != fn_ptr2->cfg_checksum)
> 			return false;
>-#endif
> 		fn_ptr1 = list_next_entry(fn_ptr1, head);
> 		fn_ptr2 = list_next_entry(fn_ptr2, head);
> 	}
>@@ -403,21 +374,10 @@ size_t convert_to_gcda(char *buffer, struct gcov_info *info)
> 		u32 i;
>
> 		pos += store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION);
>-#if CONFIG_CLANG_VERSION < 110000
>-		pos += store_gcov_u32(buffer, pos,
>-			fi_ptr->use_extra_checksum ? 3 : 2);
>-#else
> 		pos += store_gcov_u32(buffer, pos, 3);
>-#endif
> 		pos += store_gcov_u32(buffer, pos, fi_ptr->ident);
> 		pos += store_gcov_u32(buffer, pos, fi_ptr->checksum);
>-#if CONFIG_CLANG_VERSION < 110000
>-		if (fi_ptr->use_extra_checksum)
>-			pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
>-#else
> 		pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
>-#endif
>-
> 		pos += store_gcov_u32(buffer, pos, GCOV_TAG_COUNTER_BASE);
> 		pos += store_gcov_u32(buffer, pos, fi_ptr->num_counters * 2);
> 		for (i = 0; i < fi_ptr->num_counters; i++)
>-- 
>2.31.1.295.g9ea45b61b8-goog
>

Looks good for both. Thanks!

Reviewed-by: Fangrui Song <maskray@google.com>
