Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D962A396794
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEaSJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 14:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhEaSJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 14:09:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEFAD611CA;
        Mon, 31 May 2021 18:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622484479;
        bh=M3OgetQba/UVAsB4M/CF8dyqe0zb+kxHEdtALs37FxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYn6Cm7R32o3ShYLIszlUD7o92/Uml5sSRlzX0qasDSeFYQ8nJiQtauxL/tGVcDKf
         UDxUf+rs8GZz7nfmUFH5a/Hs+jHYOKkTu4GV/HM4B3XxjEzNZnKUt6sPIiEmp7fR2W
         RD0yR3k2lMuSk+OlBCOHOWktiNq2tePYCArWgonbUKv7s40SorJ1j48bp5Rw2hQQXv
         UcRsHGZBoYw9PyrDVoytPeq6ClOn3fRjx3s9jBbkFa78QreuTl0Q7bwgxpKVGXXWu7
         f1jjbf+emNkA3tmy6WIX+mYiNz6QYifhIR4U1tQEYTi2vkW2TypROxEx9apQ3lETO1
         dB5yKqQkBFM4g==
Date:   Mon, 31 May 2021 11:07:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     samitolvanen@google.com, jeyu@kernel.org, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        wcw@google.com
Subject: Re: [PATCH 1/6] pgo: modules Expose module sections for clang PGO
 instumentation.
Message-ID: <YLUl/eQ1EzMFSb9F@Ryzen-9-3900X.localdomain>
References: <20210528200133.459022-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528200133.459022-1-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarmo!

I do not really have much input on the code side of things aside from
style changes, which I will comment on in each individual patch. I do
have some comments around process, hopefully they are helpful to you for
the future :)

My first comment is around the threading of the series. It seems like
you sent this series as individual patches when they really should have
been threaded together so they are all grouped together in our inboxes.
You can pass multiple patch files to 'git send-email' so they will be be
automatically threaded.

$ git send-email --to=... --cc=... *.patch

That way, everyone stays CC'd on the full series. You left Bill off of
this patch, which is important for the rest of the series. Bill,
original patch is here so you do not have to read my marked message.

https://lore.kernel.org/r/20210528200133.459022-1-jarmo.tiitto@gmail.com/

On Fri, May 28, 2021 at 11:01:33PM +0300, Jarmo Tiitto wrote:
> This patch series enables reading PGO profile data for
> modules. It also contains some changes to instrumentation
> code to fixup flaws when profile data is serialized from loaded modules.
> 
> To be able to export clang PGO profile data from modules into user space
> we need to expose __llvm_prf_xxx sections from loaded modules.
> This data is used by pgo/instrument.c and pgo/fs_mod.c in following patches.
> 
> ====
> The patch is based on Sami Tolvanen's earlier code: [1]
> Patch https://lore.kernel.org/linux-doc/20210407211704.367039-1-morbo@google.com/
> and kernel v5.13-rc3 was used as starting point for my changes.

This is general advice since it is not relevant for this particular
series: when submitting a patch series, it is best to work against
linux-next or a maintainer's tree so that you have the latest version of
the code that has been accepted:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-next/clang/pgo

I would base future revisions on Kees's tree above as that is the final
version that will go upstream. You can even include the commit that you based it on with 'git format-patch --base=<base_hash>'

$ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/pgo

$ git checkout -b kees/for-next/clang/pgo FETCH_HEAD

$ git format-patch --base=e1af496cbe9b4517428601a4e44fee3602dd3c15 e1af496cbe9b4517428601a4e44fee3602dd3c15..

> Be kind, I'm an kernel newbie and this is my first git send-mail. :-)
> 
> [1] https://patchwork.kernel.org/project/linux-kbuild/patch/20210407211704.367039-1-morbo@google.com/
> ====

This entire commit message belongs in a cover letter, which allows you
to tell the reviewers what your series is doing at a higher level, without it
being applied to the final commit.

https://kernelnewbies.org/PatchSeries

You can generate this with 'git format-patch' via the '--cover-letter'
option, which will add a 0000 patch file that you can use for that
purpose, and it will be the top message of your thread.

The commit message for this patch should describe what is being done and
why it is being done.

> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
>  include/linux/module.h | 12 +++++++++++-
>  kernel/module.c        |  8 +++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8100bb477d86..2aa1e1fe4afa 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -504,7 +504,6 @@ struct module {
>  	/* Elf information */
>  	struct klp_modinfo *klp_info;
>  #endif
> -
>  #ifdef CONFIG_MODULE_UNLOAD
>  	/* What modules depend on me? */
>  	struct list_head source_list;
> @@ -527,6 +526,17 @@ struct module {
>  	struct error_injection_entry *ei_funcs;
>  	unsigned int num_ei_funcs;
>  #endif
> +#ifdef CONFIG_PGO_CLANG
> +	/* Clang PGO llvm_prf_xxx sections */

This probably deserves a comment such as:

"Should to be kept in sync with the data sections in include/asm-generic/vmlinux.lds.h"

> +	void *prf_data; /* struct llvm_prf_data */
> +	int prf_data_size;
> +	u64 *prf_cnts;
> +	int prf_cnts_num;
> +	const char *prf_names;
> +	int prf_names_num;
> +	void *prf_vnds; /* struct llvm_prf_value_node */
> +	int prf_vnds_size;
> +#endif
>  } ____cacheline_aligned __randomize_layout;
>  #ifndef MODULE_ARCH_INIT
>  #define MODULE_ARCH_INIT {}
> diff --git a/kernel/module.c b/kernel/module.c
> index 7e78dfabca97..e49de3b95d87 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3342,7 +3342,13 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  
>  	info->debug = section_objs(info, "__dyndbg",
>  				   sizeof(*info->debug), &info->num_debug);
> -

I would shuffle this section to be between the 'mod->static_call_sites'
and 'mod->extable' above, as it looks better to me to have all of the
conditional sections grouped together.

> +#ifdef CONFIG_PGO_CLANG
> +    /* Grab module sections for Clang PGO profiler to hook into */

I think you can just drop this comment, none of the other conditional
preprocessor blocks have a comment in this function. Otherwise, tabs instead of
spaces.

> +	mod->prf_data = section_objs(info, "__llvm_prf_data", 1, &mod->prf_data_size);
> +	mod->prf_cnts = section_objs(info, "__llvm_prf_cnts", sizeof(u64), &mod->prf_cnts_num);
> +	mod->prf_names = section_objs(info, "__llvm_prf_names", sizeof(char), &mod->prf_names_num);
> +	mod->prf_vnds = section_objs(info, "__llvm_prf_vnds", 1, &mod->prf_vnds_size);
> +#endif
>  	return 0;
>  }
>  
> -- 
> 2.31.1

Overall, good job on your first submission! :)

Cheers,
Nathan
