Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660EA357537
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355756AbhDGTwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345736AbhDGTwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:52:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDBC4610A4;
        Wed,  7 Apr 2021 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617825116;
        bh=WQd0A2usJFQcP3caPt1efatQVgCVEId2F/kHJCBs2oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2asrBe9dArzn4UObZDtiFYuhwgv0kvJeDAK9WPHefsTmtfgdqu6Sed++uXsNvtw+
         2SvWkw7FZh5xiDS+UosEL8+AmiRfmIix+KpMvnLVb9RRIcg5PWV+h5VSQaU5btSSMQ
         dvLepBLrpycjEIWQp2wFA4eAeIkqaz81N/kuzne7RX4rR24BU8Mmh/vuGG39rABZd6
         pVUGqhT7bMuAq2LM0NUMxsnm1QwRzYNp6lf2NABDu38arICoExVu87WA7ZTYRfaGw9
         UX/GFtRfVY96YAIjd4TFndf/dWWnTtJQVoPdN3Ahq2uXknzp1Uw9l4+rMzGvqLbeZD
         9cZnBphPlBPTg==
Date:   Wed, 7 Apr 2021 12:51:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: Re: [PATCH 2/2] gcov: re-drop support for clang-10
Message-ID: <20210407195151.h2hlpwsjo2rdnnhs@archlinux-ax161>
References: <20210407185456.41943-1-ndesaulniers@google.com>
 <20210407185456.41943-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407185456.41943-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:54:56AM -0700, Nick Desaulniers wrote:
> LLVM changed the expected function signatures for
> llvm_gcda_emit_function() in the clang-11 release.  Drop the older
> implementations and require folks to upgrade their compiler if they're
> interested in GCOV support.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  kernel/gcov/clang.c | 40 ----------------------------------------
>  1 file changed, 40 deletions(-)
> 
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index 1747204541bf..78c4dc751080 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c
> @@ -69,9 +69,6 @@ struct gcov_fn_info {
>  
>  	u32 ident;
>  	u32 checksum;
> -#if CONFIG_CLANG_VERSION < 110000
> -	u8 use_extra_checksum;
> -#endif
>  	u32 cfg_checksum;
>  
>  	u32 num_counters;
> @@ -113,23 +110,6 @@ void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
>  }
>  EXPORT_SYMBOL(llvm_gcda_start_file);
>  
> -#if CONFIG_CLANG_VERSION < 110000
> -void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
> -		u8 use_extra_checksum, u32 cfg_checksum)
> -{
> -	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
> -
> -	if (!info)
> -		return;
> -
> -	INIT_LIST_HEAD(&info->head);
> -	info->ident = ident;
> -	info->checksum = func_checksum;
> -	info->use_extra_checksum = use_extra_checksum;
> -	info->cfg_checksum = cfg_checksum;
> -	list_add_tail(&info->head, &current_info->functions);
> -}
> -#else
>  void llvm_gcda_emit_function(u32 ident, u32 func_checksum, u32 cfg_checksum)
>  {
>  	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
> @@ -143,7 +123,6 @@ void llvm_gcda_emit_function(u32 ident, u32 func_checksum, u32 cfg_checksum)
>  	info->cfg_checksum = cfg_checksum;
>  	list_add_tail(&info->head, &current_info->functions);
>  }
> -#endif
>  EXPORT_SYMBOL(llvm_gcda_emit_function);
>  
>  void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
> @@ -274,16 +253,8 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
>  		!list_is_last(&fn_ptr2->head, &info2->functions)) {
>  		if (fn_ptr1->checksum != fn_ptr2->checksum)
>  			return false;
> -#if CONFIG_CLANG_VERSION < 110000
> -		if (fn_ptr1->use_extra_checksum != fn_ptr2->use_extra_checksum)
> -			return false;
> -		if (fn_ptr1->use_extra_checksum &&
> -			fn_ptr1->cfg_checksum != fn_ptr2->cfg_checksum)
> -			return false;
> -#else
>  		if (fn_ptr1->cfg_checksum != fn_ptr2->cfg_checksum)
>  			return false;
> -#endif
>  		fn_ptr1 = list_next_entry(fn_ptr1, head);
>  		fn_ptr2 = list_next_entry(fn_ptr2, head);
>  	}
> @@ -403,21 +374,10 @@ size_t convert_to_gcda(char *buffer, struct gcov_info *info)
>  		u32 i;
>  
>  		pos += store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION);
> -#if CONFIG_CLANG_VERSION < 110000
> -		pos += store_gcov_u32(buffer, pos,
> -			fi_ptr->use_extra_checksum ? 3 : 2);
> -#else
>  		pos += store_gcov_u32(buffer, pos, 3);
> -#endif
>  		pos += store_gcov_u32(buffer, pos, fi_ptr->ident);
>  		pos += store_gcov_u32(buffer, pos, fi_ptr->checksum);
> -#if CONFIG_CLANG_VERSION < 110000
> -		if (fi_ptr->use_extra_checksum)
> -			pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
> -#else
>  		pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
> -#endif
> -
>  		pos += store_gcov_u32(buffer, pos, GCOV_TAG_COUNTER_BASE);
>  		pos += store_gcov_u32(buffer, pos, fi_ptr->num_counters * 2);
>  		for (i = 0; i < fi_ptr->num_counters; i++)
> -- 
> 2.31.1.295.g9ea45b61b8-goog
> 
