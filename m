Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781B034752F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhCXJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhCXJ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:57:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6ECC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:57:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u5so31812519ejn.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ui3KK3mzwqbV9eLNTYNhSvBlcu0bQi8tP4Sx/vLrsFM=;
        b=RW6zzpKKOYU4TonZHWyHu86rXkdv9zk1Kn+dfUmAdQHSnL8x7WIErObnzx9/rde0cl
         R+mxfCOCbfNcgLEiAGTKpJyJgLqMS6bNhmImpdWBezU4dPQpX08sZi9eQdcsYiiyIJ2U
         Im+zCCfJX8PghtZ0tLRFjRwUsEypOLYW/flzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ui3KK3mzwqbV9eLNTYNhSvBlcu0bQi8tP4Sx/vLrsFM=;
        b=Bl9OGLYmwR8Gq4AHwTLNcPQ8X8HuAP8Lc3yjqFZ8kRErqoo2XSD1Avb+huTiJRM85Y
         Si2SpRtoEnOYJRFE20XM/w0+1w3qlamAi53NYfjX4Cp5WTORzRk9uGw71SiZfCIyQ5DL
         W/9yszw11rpRW89T7WZ0mt8fwpoy8cmSt0gQqVT/YbUoqDpLKthbonNqB7VX+dSkRDxJ
         KLRNRV/MeMESoBpdCA41TF14UWx7rmRC4Gv4P7/+O7KPCoMCaHtHBWq4uBE1s4Y6ORwl
         9wLDRbsaGTUphlAtu+DLMGKnORmG8p1wjnoAioNFmfSnTVeQvlEFLPVqvv55fLQMnGi8
         b8xg==
X-Gm-Message-State: AOAM533nlYabqbaUNKC5LioST/yKJGlReK3gkZtiiGx3ZkrwS5d7JbmD
        AXSFXQVZCEgAzAzAyQD+DLcHxA==
X-Google-Smtp-Source: ABdhPJzkMnHFljq3UR0armBnzHqGg/eD2m9c6+lIJW0if0dtjP6SqF8bGhC7DR7RD/5M3+15p/J/xg==
X-Received: by 2002:a17:906:2710:: with SMTP id z16mr2752772ejc.176.1616579834782;
        Wed, 24 Mar 2021 02:57:14 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id hd37sm645541ejc.114.2021.03.24.02.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 02:57:14 -0700 (PDT)
Subject: Re: [PATCH v2 04/12] module: Add printk format to add module build ID
 to stacktraces
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324020443.1815557-5-swboyd@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6dfb8ca2-20f3-e58a-ad6b-db6a6472afe0@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 10:57:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324020443.1815557-5-swboyd@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 03.04, Stephen Boyd wrote:

> @@ -2778,6 +2793,10 @@ static inline void layout_symtab(struct module *mod, struct load_info *info)
>  static void add_kallsyms(struct module *mod, const struct load_info *info)
>  {
>  }
> +
> +static void init_build_id(struct module *mod, const struct load_info *info)
> +{
> +}
>  #endif /* CONFIG_KALLSYMS */
>  
>  static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsigned int num)
> @@ -4004,6 +4023,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  		goto free_arch_cleanup;
>  	}
>  
> +	init_build_id(mod, info);
>  	dynamic_debug_setup(mod, info->debug, info->num_debug);
>  
>  	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
> @@ -4235,7 +4255,7 @@ void * __weak dereference_module_function_descriptor(struct module *mod,
>  const char *module_address_lookup(unsigned long addr,
>  			    unsigned long *size,
>  			    unsigned long *offset,
> -			    char **modname,
> +			    char **modname, unsigned char **modbuildid,

It's an existing defect with modname, but surely this should take a
"const unsigned char **modbuildid", no?

>  			    char *namebuf)
>  {
>  	const char *ret = NULL;
> @@ -4246,6 +4266,8 @@ const char *module_address_lookup(unsigned long addr,
>  	if (mod) {
>  		if (modname)
>  			*modname = mod->name;
> +		if (modbuildid)
> +			*modbuildid = mod->build_id;
>  
>  		ret = find_kallsyms_symbol(mod, addr, size, offset);
>  	}
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 41ddc353ebb8..9cd62e84e4aa 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -961,13 +961,15 @@ char *symbol_string(char *buf, char *end, void *ptr,
>  	char sym[KSYM_SYMBOL_LEN];
>  #endif
>  
> -	if (fmt[1] == 'R')
> +	if (fmt[1] == 'R' || fmt[1] == 'r')
>  		ptr = __builtin_extract_return_addr(ptr);
>  	value = (unsigned long)ptr;
>  
>  #ifdef CONFIG_KALLSYMS
>  	if (*fmt == 'B')
>  		sprint_backtrace(sym, value);
> +	else if (*fmt == 'S' && (fmt[1] == 'b' || fmt[1] == 'r'))
> +		sprint_symbol_stacktrace(sym, value);
>  	else if (*fmt != 's')
>  		sprint_symbol(sym, value);
>  	else
> @@ -2129,6 +2131,8 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
>   * - 'S' For symbolic direct pointers (or function descriptors) with offset
>   * - 's' For symbolic direct pointers (or function descriptors) without offset
>   * - '[Ss]R' as above with __builtin_extract_return_addr() translation
> + * - '[Ss]r' as above with __builtin_extract_return_addr() translation and module build ID
> + * - '[Ss]b' as above with module build ID (for use in backtraces)

The code doesn't quite match the comment. The lowercase s is not handled
(i.e., there's no way to say "without offset, with build ID"). You don't
have to fix the code to support that right now, the whole kallsyms
vsprintf code needs to be reworked inside-out anyway (having vsnprint
call sprint_symbol* which builds the output using snprintf() calls makes
me cringe), so please just replace [Ss] by S to make the comment match
the code - I notice that you did only document the S variant in
printk-formats.rst.

Is there any reason you didn't just make b an optional flag that could
be specified with or without R? I suppose the parsing is more difficult
with several orthogonal flags (see escaped_string()), but it's a little
easier to understand. Dunno, it's not like we're gonna think of 10 other
things that could be printed for a symbol, so perhaps it's fine.

Rasmus
