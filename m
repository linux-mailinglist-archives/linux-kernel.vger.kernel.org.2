Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D939441D05C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347448AbhI3ACk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346417AbhI3ACi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:02:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4451161528;
        Thu, 30 Sep 2021 00:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632960057;
        bh=0MMynBqiekCN+c61iP/+B0vlhMcM9QSp+cw6iOEJzsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FQHRQuj0v4JVG5KfJx0k8emzR/XMZcXl+cx6BZzPOI9lvgU4BVzjdCwXBdytMPE0I
         kcmf7X1To3uCA+8k9JpgFxxtKgatpjALCDL98NPbK8F4RZwwrRC62izuyavLqegCu2
         GCXC4uAUGIWSvjz8VGE7jY0cE0VNXVitA8hOPIGgYZuFA6h23ZQyyMCLfmM4PiaAKV
         ftK+reQpUUHpv7zX9Tc9UwjQYkV4AKb1E8T11/ZfHglnSETHuRULsJ79kRFGCD5d5R
         SOePrJXz6d8WuGkuslXrYFvIe6y2m2OoOLO/YJWQ5oACh0EkXIL3paatw9tR2HgwL5
         L7pVyRz28UqvQ==
Date:   Thu, 30 Sep 2021 09:00:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] x86/insn: Use get_unaligned() instead of memcpy()
Message-Id: <20210930090054.dc54a2ce50dda8f196084c75@kernel.org>
In-Reply-To: <YVSsIkj9Z29TyUjE@zn.tnic>
References: <163265189226.178609.9712455554034472888.tglx@xen13>
        <163265189517.178609.6605494600326137493.tglx@xen13>
        <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
        <YVC4zz1vCskBMb6I@zn.tnic>
        <CAHk-=whJvs+-kCMynbt9YRVfcyM5TL8wwNhdOX9iygC5y--CHw@mail.gmail.com>
        <YVNXWJEeGOqxXIjf@zn.tnic>
        <CAHk-=whSHDmcAbe=1AhRC8D8WcT6DpCP59kgjZc-wa8TfhxMiw@mail.gmail.com>
        <YVN94ojuLApdN1IT@zn.tnic>
        <CAHk-=wjyNDcrS1nEskxdes38wAajF+4B+cFwh4HCPhPEDvFL9w@mail.gmail.com>
        <YVSsIkj9Z29TyUjE@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 20:10:42 +0200
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Use get_unaligned() instead of memcpy() to access potentially unaligned
> memory, which, when accessed through a pointer, leads to undefined
> behavior. get_unaligned() describes much better what is happening there
> anyway even if memcpy() does the job.
> 
> No functional changes.

Thank you very much to fix this! This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> 
> Fixes: 5ba1071f7554 ("x86/insn, tools/x86: Fix undefined behavior due to potential unaligned accesses")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/lib/insn.c                   |  5 +++--
>  tools/arch/x86/lib/insn.c             |  5 +++--
>  tools/include/asm-generic/unaligned.h | 23 +++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 4 deletions(-)
>  create mode 100644 tools/include/asm-generic/unaligned.h
> 
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index c565def611e2..55e371cc69fd 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
> @@ -13,6 +13,7 @@
>  #endif
>  #include <asm/inat.h> /*__ignore_sync_check__ */
>  #include <asm/insn.h> /* __ignore_sync_check__ */
> +#include <asm/unaligned.h> /* __ignore_sync_check__ */
>  
>  #include <linux/errno.h>
>  #include <linux/kconfig.h>
> @@ -37,10 +38,10 @@
>  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
>  
>  #define __get_next(t, insn)	\
> -	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> +	({ t r = get_unaligned((t *)(insn)->next_byte); (insn)->next_byte += sizeof(t); leXX_to_cpu(t, r); })
>  
>  #define __peek_nbyte_next(t, insn, n)	\
> -	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
> +	({ t r = get_unaligned((t *)(insn)->next_byte + n); leXX_to_cpu(t, r); })
>  
>  #define get_next(t, insn)	\
>  	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index 797699462cd8..8fd63a067308 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -13,6 +13,7 @@
>  #endif
>  #include "../include/asm/inat.h" /* __ignore_sync_check__ */
>  #include "../include/asm/insn.h" /* __ignore_sync_check__ */
> +#include "../include/asm-generic/unaligned.h" /* __ignore_sync_check__ */
>  
>  #include <linux/errno.h>
>  #include <linux/kconfig.h>
> @@ -37,10 +38,10 @@
>  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
>  
>  #define __get_next(t, insn)	\
> -	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> +	({ t r = get_unaligned((t *)(insn)->next_byte); (insn)->next_byte += sizeof(t); leXX_to_cpu(t, r); })
>  
>  #define __peek_nbyte_next(t, insn, n)	\
> -	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
> +	({ t r = get_unaligned((t *)(insn)->next_byte + n); leXX_to_cpu(t, r); })
>  
>  #define get_next(t, insn)	\
>  	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
> diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
> new file mode 100644
> index 000000000000..47387c607035
> --- /dev/null
> +++ b/tools/include/asm-generic/unaligned.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copied from the kernel sources to tools/perf/:
> + */
> +
> +#ifndef __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
> +#define __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
> +
> +#define __get_unaligned_t(type, ptr) ({						\
> +	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
> +	__pptr->x;								\
> +})
> +
> +#define __put_unaligned_t(type, val, ptr) do {					\
> +	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
> +	__pptr->x = (val);							\
> +} while (0)
> +
> +#define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
> +#define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
> +
> +#endif /* __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H */
> +
> -- 
> 2.29.2
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


-- 
Masami Hiramatsu <mhiramat@kernel.org>
