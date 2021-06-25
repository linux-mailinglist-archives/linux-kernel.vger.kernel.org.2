Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A033B4AEA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFYXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhFYXdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:33:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 832336194C;
        Fri, 25 Jun 2021 23:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1624663840;
        bh=P/dzjEvY1zOQ2OCiVRU0Wn/VeWEHzTH9g4jio6B3WGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VUpBcT3i0DMg9YOYVF4k/fv9DWM8P4YQgk0OC5MTCggFnScDr0fJe1yvj+c2n59hH
         XDv+VwdYDpbPkLONMxp81XxXXWsmQb3+0rNL83q/LFG4+ynpwk+EyPownB0r7EbIsS
         XheBnHHFxBU81Z6oviee4+SBqrO6XHDdU+QZSPvc=
Date:   Fri, 25 Jun 2021 16:30:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] ELF: add and use SUPPRESS_WARN_UNUSED_RESULT
Message-Id: <20210625163040.a15af04872959da9af161fca@linux-foundation.org>
In-Reply-To: <YNZG6N0W/7gjG7Gm@localhost.localdomain>
References: <YNYz+hVeqsQmiEqN@localhost.localdomain>
        <YNZG6N0W/7gjG7Gm@localhost.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2021 00:13:12 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Last write to the "error" variable in load_elf_binary() is dead write.
> 
> Add and use SUPPRESS_WARN_UNUSED_RESULT macro to express intent better.
> 
> Credit goes to Ed Catmur:
> 
> 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425#c34
> 
> Macro doesn't work for WUR functions returning structures and unions,
> but it will work when gcc copies clang.
> 
> ...
>
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1290,7 +1290,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		   and some applications "depend" upon this behavior.
>  		   Since we do not have the power to recompile these, we
>  		   emulate the SVr4 behavior. Sigh. */
> -		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
> +		SUPPRESS_WARN_UNUSED_RESULT
> +		vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
>  				MAP_FIXED | MAP_PRIVATE, 0);
>  	}
>  
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -284,6 +284,10 @@
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#nodiscard-warn-unused-result
>   */
>  #define __must_check                    __attribute__((__warn_unused_result__))
> +/*
> + * "(void)" is enough for clang but not for gcc.
> + */
> +#define SUPPRESS_WARN_UNUSED_RESULT	(void)!

That macro is rather ugly.  Hopefully we won't really need it - how
many such sites are there in a full kernel build anyway?

I can't imagine who added this to load_elf_binary():

	if (current->personality & MMAP_PAGE_ZERO) {
		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
		   and some applications "depend" upon this behavior.
		   Since we do not have the power to recompile these, we
		   emulate the SVr4 behavior. Sigh. */
		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
				MAP_FIXED | MAP_PRIVATE, 0);
	}

I think it was there before most of us were born.  The comment has a
torvaldsy/viroey feel to it.

Do we really care about userspace which relies upon an SVR4 quirk?  I
guess it's too hard to prove the no case, so it stays.

But given that the loader is being asked to map this page, shouldn't we
handle this error (fail the exec) if the mapping attempt failed?  That
seems better behavior than permitting some creaky old application to
blunder into a mysterious crash?
