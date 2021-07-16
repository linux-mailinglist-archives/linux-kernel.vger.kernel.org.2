Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770573CBF65
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 00:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhGPWrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 18:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhGPWrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 18:47:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66878613DF;
        Fri, 16 Jul 2021 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626475465;
        bh=+OtcNEH2sKfz8tajetndVWNnt7tYpjOCK9SU/b98tao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRzcMCH/WjUxv97dnBAZ4X0kYnhoD5Npnt4MhsENvjeJ/2rxDWwAfIXfVLHbTbPWZ
         5uNPIkKUus4JNKc6TT95RCjeDZchP8866bfmZgVOI0T2b0+hLdofOqZueCtShss9iI
         zpbe80RFG6Qra0fsMtbYySfMHljnM4qA2jYpybJreCEVZZ7VcCsQjxnW0XzQn/iFC2
         BiK+oGb3JGbnWaSBbpeUj/ShEpviMpbSbkF3/UqYQj5ndZGUqB0ChgNYDUgwnRZAMT
         oAYSw8JBHFkTodLmyTNjhNn9LTyDvog8N0zByBQRW1Iqlza+9TCExHkH8/OrfdivY4
         01azUqG4Wm1Ww==
Date:   Fri, 16 Jul 2021 15:44:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] smpboot: remove inline from __always_inline'd
 function idle_init
Message-ID: <YPILxbDHCC2EN/3u@archlinux-ax161>
References: <20210715164018.62712-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715164018.62712-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 05:40:18PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Declaring a idle_init as inline when it is __always_inline is redundant
> so this can be removed. Also swap the order of __always_inline and void
> to match the more usual coding style.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This resolves a clang warning that I see:

kernel/smpboot.c:50:20: error: duplicate 'inline' declaration specifier [-Werror,-Wduplicate-decl-specifier]
static inline void __always_inline idle_init(unsigned int cpu)
                   ^
./include/linux/compiler_attributes.h:65:41: note: expanded from macro '__always_inline'
#define __always_inline                 inline __attribute__((__always_inline__))
                                        ^
./include/linux/compiler_types.h:149:16: note: expanded from macro 'inline'
#define inline inline __gnu_inline __inline_maybe_unused notrace
               ^
1 error generated.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> index 21b7953f8242..cf6acab78538 100644
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -47,7 +47,7 @@ void __init idle_thread_set_boot_cpu(void)
>   *
>   * Creates the thread if it does not exist.
>   */
> -static inline void __always_inline idle_init(unsigned int cpu)
> +static __always_inline void idle_init(unsigned int cpu)
>  {
>  	struct task_struct *tsk = per_cpu(idle_threads, cpu);
>  
> -- 
> 2.31.1
> 
