Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F45B37A5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhEKLgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:36:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230501AbhEKLga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:36:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620732923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9ftnEprnJR+ecG9/KIu42CmG3FUYjZYMpe6qMgEarE=;
        b=ske5PixWDoCRPpfIHj7Q9RLA35KvPYh3oejmOcRz7cIRInPeazbnvZODdpJA0AtN2vSeFM
        hIb3buKHSCUJy6uN4jg9Pa8DlLt+OL/J7tG5qG4QryLSwTYL4+J1TVAla7CVhCTws7v1q2
        giJJlIBrHBHh7S0z7Sr79RPy2cxrMHs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12785B05C;
        Tue, 11 May 2021 11:35:23 +0000 (UTC)
Date:   Tue, 11 May 2021 13:35:21 +0200
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
Subject: Re: [PATCH v6 05/13] module: Add printk formats to add module build
 ID to stacktraces
Message-ID: <YJpr+T616Wki2542@alley>
References: <20210511003845.2429846-1-swboyd@chromium.org>
 <20210511003845.2429846-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511003845.2429846-6-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-05-10 17:38:37, Stephen Boyd wrote:
> Let's make kernel stacktraces easier to identify by including the build
> ID[1] of a module if the stacktrace is printing a symbol from a module.

> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -11,6 +11,7 @@
>  
>  #include <linux/list.h>
>  #include <linux/stat.h>
> +#include <linux/buildid.h>
>  #include <linux/compiler.h>
>  #include <linux/cache.h>
>  #include <linux/kmod.h>
> @@ -364,6 +365,11 @@ struct module {
>  	/* Unique handle for this module */
>  	char name[MODULE_NAME_LEN];
>  
> +#ifdef CONFIG_STACKTRACE_BUILD_ID
> +	/* Module build ID */
> +	unsigned char build_id[BUILD_ID_SIZE_MAX];
> +#endif
> +
>  	/* Sysfs stuff. */
>  	struct module_kobject mkobj;
>  	struct module_attribute *modinfo_attrs;
> @@ -627,7 +633,7 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr);
>  const char *module_address_lookup(unsigned long addr,
>  			    unsigned long *symbolsize,
>  			    unsigned long *offset,
> -			    char **modname,
> +			    char **modname, const unsigned char **modbuildid,

Nit: It would have been better to follow the existing style and put only one
     parameter per-line.

Please, fix it in the next version if there is any. But no need
to resend it just because of this unless Jessica asks for it.

>  			    char *namebuf);
>  int lookup_module_symbol_name(unsigned long addr, char *symname);
>  int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);

> diff --git a/kernel/module.c b/kernel/module.c
> index 30479355ab85..a5eaf5188a83 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -4235,7 +4257,7 @@ void * __weak dereference_module_function_descriptor(struct module *mod,
>  const char *module_address_lookup(unsigned long addr,
>  			    unsigned long *size,
>  			    unsigned long *offset,
> -			    char **modname,
> +			    char **modname, const unsigned char **modbuildid,

Same here.

>  			    char *namebuf)
>  {
>  	const char *ret = NULL;

Otherwise, it looks good.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
