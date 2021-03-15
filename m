Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C733C557
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhCOSOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhCOSOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:14:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9447664DF0;
        Mon, 15 Mar 2021 18:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615832081;
        bh=PsJNs1xz8Lw0JYp0Ii3n0KV7iakaqISjoVHYI6sUiQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VkUc79ctzOxurzRpmYUNTqIBPxCT2XVA8VxtZxe9mGQLXXW+Rj1sQvKVJJGgWXLeI
         hQL7rew0xdjjfn+EkMMLXDCi84Gy0xp63a0g5dMRcaPo07rIWTFfj0bu7ngyVXQFPh
         2V9/8XR0TPy9P3vHOZ/9yYVd5zD8kifsqwGEv+V1sDy6TkwwPLVJFZ5rHZtZ93m9sS
         0UTfk7PTm7pZGQ5BvbY+ZfP8pNPAWGOZoo4SWGBvhKNGy7J86O3exbCnX14UPjEseS
         ETdMyTVV1xkMSiQsOePIGIzX77pJ+I2/6v3u0iJP11chz2Tw45VLF37fB98v5TTaqP
         qbzTRmK12TUcw==
Date:   Mon, 15 Mar 2021 11:14:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: Re: [PATCH v2 2/2] gcov: clang: drop support for clang-10 and older
Message-ID: <20210315181435.ta56n3r4dusdpl2p@archlinux-ax161>
References: <20210312220518.rz6cjh33bkwaumzz@archlinux-ax161>
 <20210312224132.3413602-1-ndesaulniers@google.com>
 <20210312224132.3413602-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312224132.3413602-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 02:41:32PM -0800, Nick Desaulniers wrote:
> LLVM changed the expected function signatures for llvm_gcda_start_file()
> and llvm_gcda_emit_function() in the clang-11 release. Drop the older
> implementations and require folks to upgrade their compiler if they're
> interested in GCOV support.
> 
> Link: https://reviews.llvm.org/rGcdd683b516d147925212724b09ec6fb792a40041
> Link: https://reviews.llvm.org/rG13a633b438b6500ecad9e4f936ebadf3411d0f44
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> For an easier time reviewing this series, reviewers may want to apply
> these patches, then check the overall diff with `git diff origin/HEAD`.
> 
>  kernel/gcov/Kconfig |  1 +
>  kernel/gcov/clang.c | 85 ---------------------------------------------
>  2 files changed, 1 insertion(+), 85 deletions(-)
> 
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index f62de2dea8a3..58f87a3092f3 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -4,6 +4,7 @@ menu "GCOV-based kernel profiling"
>  config GCOV_KERNEL
>  	bool "Enable gcov-based kernel profiling"
>  	depends on DEBUG_FS
> +	depends on !CC_IS_CLANG || CLANG_VERSION >= 110000
>  	select CONSTRUCTORS
>  	default n
>  	help
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index 8743150db2ac..14de5644b5cc 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c
> @@ -75,9 +75,6 @@ struct gcov_fn_info {
>  
>  	u32 num_counters;
>  	u64 *counters;
> -#if CONFIG_CLANG_VERSION < 110000
> -	const char *function_name;
> -#endif
>  };
>  
>  static struct gcov_info *current_info;
> @@ -107,16 +104,6 @@ void llvm_gcov_init(llvm_gcov_callback writeout, llvm_gcov_callback flush)
>  }
>  EXPORT_SYMBOL(llvm_gcov_init);
>  
> -#if CONFIG_CLANG_VERSION < 110000
> -void llvm_gcda_start_file(const char *orig_filename, const char version[4],
> -		u32 checksum)
> -{
> -	current_info->filename = orig_filename;
> -	memcpy(&current_info->version, version, sizeof(current_info->version));
> -	current_info->checksum = checksum;
> -}
> -EXPORT_SYMBOL(llvm_gcda_start_file);
> -#else
>  void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
>  {
>  	current_info->filename = orig_filename;
> @@ -124,29 +111,7 @@ void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
>  	current_info->checksum = checksum;
>  }
>  EXPORT_SYMBOL(llvm_gcda_start_file);
> -#endif
> -
> -#if CONFIG_CLANG_VERSION < 110000
> -void llvm_gcda_emit_function(u32 ident, const char *function_name,
> -		u32 func_checksum, u8 use_extra_checksum, u32 cfg_checksum)
> -{
> -	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
> -
> -	if (!info)
> -		return;
>  
> -	INIT_LIST_HEAD(&info->head);
> -	info->ident = ident;
> -	info->checksum = func_checksum;
> -	info->use_extra_checksum = use_extra_checksum;
> -	info->cfg_checksum = cfg_checksum;
> -	if (function_name)
> -		info->function_name = kstrdup(function_name, GFP_KERNEL);
> -
> -	list_add_tail(&info->head, &current_info->functions);
> -}
> -EXPORT_SYMBOL(llvm_gcda_emit_function);
> -#else
>  void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
>  		u8 use_extra_checksum, u32 cfg_checksum)
>  {
> @@ -163,7 +128,6 @@ void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
>  	list_add_tail(&info->head, &current_info->functions);
>  }
>  EXPORT_SYMBOL(llvm_gcda_emit_function);
> -#endif
>  
>  void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
>  {
> @@ -326,7 +290,6 @@ void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
>  	}
>  }
>  
> -#if CONFIG_CLANG_VERSION < 110000
>  static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
>  {
>  	size_t cv_size; /* counter values size */
> @@ -335,47 +298,15 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
>  	if (!fn_dup)
>  		return NULL;
>  	INIT_LIST_HEAD(&fn_dup->head);
> -
> -	fn_dup->function_name = kstrdup(fn->function_name, GFP_KERNEL);
> -	if (!fn_dup->function_name)
> -		goto err_name;
> -
> -	cv_size = fn->num_counters * sizeof(fn->counters[0]);
> -	fn_dup->counters = vmalloc(cv_size);
> -	if (!fn_dup->counters)
> -		goto err_counters;
> -	memcpy(fn_dup->counters, fn->counters, cv_size);
> -
> -	return fn_dup;
> -
> -err_counters:
> -	kfree(fn_dup->function_name);
> -err_name:
> -	kfree(fn_dup);
> -	return NULL;
> -}
> -#else
> -static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> -{
> -	size_t cv_size; /* counter values size */
> -	struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
> -			GFP_KERNEL);
> -	if (!fn_dup)
> -		return NULL;
> -	INIT_LIST_HEAD(&fn_dup->head);
> -
>  	cv_size = fn->num_counters * sizeof(fn->counters[0]);
>  	fn_dup->counters = vmalloc(cv_size);
>  	if (!fn_dup->counters) {
>  		kfree(fn_dup);
>  		return NULL;
>  	}
> -
>  	memcpy(fn_dup->counters, fn->counters, cv_size);
> -
>  	return fn_dup;
>  }
> -#endif
>  
>  /**
>   * gcov_info_dup - duplicate profiling data set
> @@ -416,21 +347,6 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
>   * gcov_info_free - release memory for profiling data set duplicate
>   * @info: profiling data set duplicate to free
>   */
> -#if CONFIG_CLANG_VERSION < 110000
> -void gcov_info_free(struct gcov_info *info)
> -{
> -	struct gcov_fn_info *fn, *tmp;
> -
> -	list_for_each_entry_safe(fn, tmp, &info->functions, head) {
> -		kfree(fn->function_name);
> -		vfree(fn->counters);
> -		list_del(&fn->head);
> -		kfree(fn);
> -	}
> -	kfree(info->filename);
> -	kfree(info);
> -}
> -#else
>  void gcov_info_free(struct gcov_info *info)
>  {
>  	struct gcov_fn_info *fn, *tmp;
> @@ -443,7 +359,6 @@ void gcov_info_free(struct gcov_info *info)
>  	kfree(info->filename);
>  	kfree(info);
>  }
> -#endif
>  
>  #define ITER_STRIDE	PAGE_SIZE
>  
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
