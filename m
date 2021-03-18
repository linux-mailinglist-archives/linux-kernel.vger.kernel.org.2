Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAB340DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhCRTBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhCRTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:00:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B309C061762
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:00:53 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z8so8817856ljm.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYca1ndZSGowpwQORXxcl09hudlmdW3oK/eLGvMXjGA=;
        b=DtsCZAMqawT8GwoT4PVd5v24eAtD3md/tl3oDtZnEKVjuf8aIFuUFBVtTcRdMUj6Ih
         vazygaVz3QAPRgp1KACpCc4mSY7ZQ4UgJLrM81ts8sPOGAXzrLp9kZE5HnvnYTtmGwhU
         DVpcdbN7dcpEadnZFbyTsL0eKtM0OTz4FUD6lMtMi92bWtcFi5FYXfOdeX879sB7qSNd
         MGRcHAxa7IQR9/I1QdEy6xgdnYOef1RbaCDGBREc/S1LWE1/lR3u87z8NjDX13dL1JD+
         M3BPK/lGlD78JdYbuYFfZF72YaWZpDwZaj//y3Dh1KBdjjZZPYoM/IHKunTLL4eOhGbz
         J/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYca1ndZSGowpwQORXxcl09hudlmdW3oK/eLGvMXjGA=;
        b=EPJ90tDUXyTaLWKuxDt8PDum8+3TOg0euCQMkim1bhzvjAcqy5Xd4OM1m4bZoKWahh
         BTjs1fNKIlTy2+T36VzeU2REEFHiKdcQ4tHJa3/mb6qBfrf2jpP7PbNABE2KOMUshoXk
         IQoPZ2TpLe3Wr3bE2h3mRyHcuBJRt/OilduzH+9IJJi87oc4YzLmCK8wg9lZRQRe97Yi
         d+SjqWIaPGcuw7EQ6oGYkea25KjVGNaObePYj25DOfxl4ENAatsqQoE+rF/B9ZraDe8+
         fvfhZiizM0qGkPjJl2lcgKEkcv8NmGGbPXYdk+CL4yvN47iOE5/auewFsa/gNmM3hQoS
         c7mw==
X-Gm-Message-State: AOAM533M/PzLLM7fafcBV3LYkoL/ZmvrunecMxAeH9BX1XswuvH9A661
        /w1rsvNA79QSEGR9NnwXtuGCyphhoHE/529M/qQHbg==
X-Google-Smtp-Source: ABdhPJzP/a52k5+dCj0sW8ZVd7EdWFyf0UEYVdSHJNFGWNp/U4i4CeFbe93RfhwQGYgCO4D0YFivDqiJb465mbw4K2E=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr6272028ljj.116.1616094051624;
 Thu, 18 Mar 2021 12:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com> <20210318171111.706303-8-samitolvanen@google.com>
In-Reply-To: <20210318171111.706303-8-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Mar 2021 12:00:39 -0700
Message-ID: <CAKwvOdkETA4OU5d_f_8eCeXgo4juagHuPWo6Fd4jg7C1cWqoYA@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] kallsyms: strip ThinLTO hashes from static functions
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With CONFIG_CFI_CLANG and ThinLTO, Clang appends a hash to the names
> of all static functions not marked __used. This can break userspace
> tools that don't expect the function name to change, so strip out the
> hash from the output.
>
> Suggested-by: Jack Pham <jackp@codeaurora.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/kallsyms.c | 54 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 8043a90aa50e..17d3a704bafa 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -161,6 +161,26 @@ static unsigned long kallsyms_sym_address(int idx)
>         return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
>  }
>
> +#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> +/*
> + * LLVM appends a hash to static function names when ThinLTO and CFI are
> + * both enabled, which causes confusion and potentially breaks user space

Might be nice to add an example, something along the lines of:
ie. foo() becomes foo$asfdasdfasdfasdf()

> + * tools, so we will strip the postfix from expanded symbol names.

s/postfix/suffix/ ?

> + */
> +static inline char *cleanup_symbol_name(char *s)
> +{
> +       char *res = NULL;
> +
> +       res = strrchr(s, '$');
> +       if (res)
> +               *res = '\0';
> +
> +       return res;
> +}
> +#else
> +static inline char *cleanup_symbol_name(char *s) { return NULL; }
> +#endif

Might be nicer to return a `bool` and have the larger definition
`return res != NULL`).  Not sure what a caller would do with `res` if
it was not `NULL`?

> +
>  /* Lookup the address for this symbol. Returns 0 if not found. */
>  unsigned long kallsyms_lookup_name(const char *name)
>  {
> @@ -173,6 +193,9 @@ unsigned long kallsyms_lookup_name(const char *name)
>
>                 if (strcmp(namebuf, name) == 0)
>                         return kallsyms_sym_address(i);
> +
> +               if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
> +                       return kallsyms_sym_address(i);
>         }
>         return module_kallsyms_lookup_name(name);
>  }
> @@ -303,7 +326,9 @@ const char *kallsyms_lookup(unsigned long addr,
>                                        namebuf, KSYM_NAME_LEN);
>                 if (modname)
>                         *modname = NULL;
> -               return namebuf;
> +
> +               ret = namebuf;
> +               goto found;
>         }
>
>         /* See if it's in a module or a BPF JITed image. */
> @@ -316,11 +341,16 @@ const char *kallsyms_lookup(unsigned long addr,
>         if (!ret)
>                 ret = ftrace_mod_address_lookup(addr, symbolsize,
>                                                 offset, modname, namebuf);
> +
> +found:
> +       cleanup_symbol_name(namebuf);
>         return ret;
>  }
>
>  int lookup_symbol_name(unsigned long addr, char *symname)
>  {
> +       int res;
> +
>         symname[0] = '\0';
>         symname[KSYM_NAME_LEN - 1] = '\0';
>
> @@ -331,15 +361,23 @@ int lookup_symbol_name(unsigned long addr, char *symname)
>                 /* Grab name */
>                 kallsyms_expand_symbol(get_symbol_offset(pos),
>                                        symname, KSYM_NAME_LEN);
> -               return 0;
> +               goto found;
>         }
>         /* See if it's in a module. */
> -       return lookup_module_symbol_name(addr, symname);
> +       res = lookup_module_symbol_name(addr, symname);
> +       if (res)
> +               return res;
> +
> +found:
> +       cleanup_symbol_name(symname);
> +       return 0;
>  }
>
>  int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
>                         unsigned long *offset, char *modname, char *name)
>  {
> +       int res;
> +
>         name[0] = '\0';
>         name[KSYM_NAME_LEN - 1] = '\0';
>
> @@ -351,10 +389,16 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
>                 kallsyms_expand_symbol(get_symbol_offset(pos),
>                                        name, KSYM_NAME_LEN);
>                 modname[0] = '\0';
> -               return 0;
> +               goto found;
>         }
>         /* See if it's in a module. */
> -       return lookup_module_symbol_attrs(addr, size, offset, modname, name);
> +       res = lookup_module_symbol_attrs(addr, size, offset, modname, name);
> +       if (res)
> +               return res;
> +
> +found:
> +       cleanup_symbol_name(name);
> +       return 0;
>  }
>
>  /* Look up a kernel symbol and return it in a text buffer. */
> --
> 2.31.0.291.g576ba9dcdaf-goog
>


-- 
Thanks,
~Nick Desaulniers
