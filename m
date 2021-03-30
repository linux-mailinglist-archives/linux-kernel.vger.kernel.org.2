Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84E034E56E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhC3K3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:29:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhC3K33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:29:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617100165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7WS9GYZv6yarrFiDqvb3XNUuJWp0o56iTRHk5IyVDk=;
        b=ZiTpcqPM1a8N9uyEPV0fgtsVevxy7ZWiJGSkryRE9AK+P/78SyhwiQm25QzePbpe78zIs8
        GyxPi+7N+Uy0IVx72a6AkZnO9acMpIeS36SPyOtop1Z4L2VfHlEqOb2A5nWAc3UtR6rLSD
        RWKk3LT+A6UItIcoL/1gbMCDvsCE198=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8349AB1F3;
        Tue, 30 Mar 2021 10:29:25 +0000 (UTC)
Date:   Tue, 30 Mar 2021 12:29:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 04/12] module: Add printk format to add module build
 ID to stacktraces
Message-ID: <YGL9hHFg9Pm4xaNM@alley>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324020443.1815557-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324020443.1815557-5-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-23 19:04:35, Stephen Boyd wrote:
> Let's make kernel stacktraces easier to identify by including the build
> ID[1] of a module if the stacktrace is printing a symbol from a module.
> 
> Example:
> 
>  WARNING: CPU: 3 PID: 3373 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
>  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE hci_uart <modules trimmed>
>  CPU: 3 PID: 3373 Comm: bash Not tainted 5.11 #12 a8c0d47f7051f3e6670ceaea724af66a39c6cec8

I tested it with "echo l >/proc/sysrq-trigger" and I got the following
output:

[   71.905593] CPU: 0 PID: 1762 Comm: bash Kdump: loaded Not tainted 5.12.0-rc5-default+ #167 00000080ffffffff0000000000000000
00000000

It does not looks like an unique build-id.
Any idea what was going wrong?

> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -91,6 +93,7 @@ const char *kallsyms_lookup(unsigned long addr,
>  
>  /* Look up a kernel symbol and return it in a text buffer. */
>  extern int sprint_symbol(char *buffer, unsigned long address);
> +extern int sprint_symbol_stacktrace(char *buffer, unsigned long address);
>  extern int sprint_symbol_no_offset(char *buffer, unsigned long address);
>  extern int sprint_backtrace(char *buffer, unsigned long address);

Could we use a more clear name? It is hard to guess what is
the difference between sprint_*_stacktrace() and sprint_backtrace().

What about sprint_symbol_build_id() ?


> diff --git a/kernel/module.c b/kernel/module.c
> index 30479355ab85..9e9cb502fb33 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2770,6 +2771,20 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>  	}
>  	mod->core_kallsyms.num_symtab = ndst;
>  }
> +
> +static void init_build_id(struct module *mod, const struct load_info *info)
> +{
> +	const Elf_Shdr *sechdr;
> +	unsigned int i;
> +
> +	for (i = 0; i < info->hdr->e_shnum; i++) {
> +		sechdr = &info->sechdrs[i];
> +		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
> +		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
> +					sechdr->sh_size))
> +			break;
> +	}

Just to be sure. Is this really reliable way how to find the build ID,
please?


> +}
>  #else
>  static inline void layout_symtab(struct module *mod, struct load_info *info)
>  {
> @@ -2778,6 +2793,10 @@ static inline void layout_symtab(struct module *mod, struct load_info *info)
>  static void add_kallsyms(struct module *mod, const struct load_info *info)
>  {
>  }

Best Regards,
Petr
