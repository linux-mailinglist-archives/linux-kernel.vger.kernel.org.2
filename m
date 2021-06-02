Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4F397DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFBBEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFBBEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:04:52 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907B3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 18:03:10 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id c3so1148239oic.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 18:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6v4d48Zss5FUokcaaUtSt3kui+BNXg1BXI8kRVyRFLk=;
        b=LtN3231NVNq0mXT34pbs0UuC74vsdSIC+1A9r+79atUSmriT/q2OLfkAhm5aur3USF
         injadBILLKRZLH8VWLoRib5ugueg457K5frQigf8OGAOl8NI5LOOdl+jHSA67gElje+L
         neMMZL6Rk4kG2Hyz+Ib/Dc/JhVLSr2KEBekWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6v4d48Zss5FUokcaaUtSt3kui+BNXg1BXI8kRVyRFLk=;
        b=o15ttteLHXlaA/XnXsQaNf00+VWBgzQny7DA6FSyU7k86h3SW0qDRL+WL3dwT2RejT
         F6x1opmTdefwl86JTIV3cHJ89H0CLOxm15FkHZCuCKoK74xsuHQjERLvIdF75O1NkQCY
         fmek7Q7WPZe9Z78+UcPU2N30cRO6mRQyPKUdtp8Y2kIAGP0jnxzzN3H0wTqnsnkGUG8+
         uJScWBUJMsixq5pTsKcDdMhAyHbA3Rzr/Gwb7r4z6SVTPZFpcOg8d5hnqfbO4gxEKmVg
         A/f9M4rwcbAFYQR6iDuv+5YW+OsZr1I4a5l1CEali9zHGdTCJ5vw0ghZI7nwqj3ygFON
         zYaA==
X-Gm-Message-State: AOAM530IwCK+vm2B4yKyNV57j9VR4VX3elE49M7QZTuOVQe+RmtXRSHl
        jiEi9ON6gsIc/S4+5R/cN8rgvz8nu8O45M7JnOwz4Q==
X-Google-Smtp-Source: ABdhPJx6nDBP7InIFQYnGr+qlRC/3IhaDQEHA4xty1JZiAIex11jLAGNCc2LjHVj8tfVR+scGQ9IUXtDaweG/6f6QJU=
X-Received: by 2002:a05:6808:144e:: with SMTP id x14mr2045245oiv.166.1622595789856;
 Tue, 01 Jun 2021 18:03:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Jun 2021 18:03:09 -0700
MIME-Version: 1.0
In-Reply-To: <20210601172659.fd8c40a6548a1bd43be1bf11@linux-foundation.org>
References: <20210601182202.3011020-5-swboyd@chromium.org> <202106020644.UDFIJOUU-lkp@intel.com>
 <20210601172659.fd8c40a6548a1bd43be1bf11@linux-foundation.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 1 Jun 2021 18:03:09 -0700
Message-ID: <CAE-0n50F0E706Hzu9KyR7+7NRG39f0Rn05XT9mi8ci8csenxtQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug is enabled
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (2021-06-01 17:26:59)
> On Wed, 2 Jun 2021 06:45:55 +0800 kernel test robot <lkp@intel.com> wrote:
>
> > >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
> >            if (static_branch_unlikely(&slub_debug_enabled))
> >                                        ^
> > >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
> > >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
> > >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
> > >> mm/slub.c:4464:6: error: invalid argument type 'void' to unary expression
> >            if (static_branch_unlikely(&slub_debug_enabled))
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Thanks.  Stephen, how about this?

Looks good to me. Thanks for the quick fix!

>
> --- a/mm/slub.c~slub-force-on-no_hash_pointers-when-slub_debug-is-enabled-fix
> +++ a/mm/slub.c
> @@ -117,12 +117,26 @@
>   */
>
>  #ifdef CONFIG_SLUB_DEBUG
> +
>  #ifdef CONFIG_SLUB_DEBUG_ON
>  DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
>  #else
>  DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
> -#endif
> +
> +static inline bool __slub_debug_enabled(void)
> +{
> +       return static_branch_unlikely(&slub_debug_enabled);

To make this even better it could be

	return static_branch_maybe(CONFIG_SLUB_DEBUG_ON, &slub_debug_enabled);

> +}
> +
> +#else          /* CONFIG_SLUB_DEBUG */
> +
> +static inline bool __slub_debug_enabled(void)
> +{
> +       return false;
> +}
> +
> +#endif         /* CONFIG_SLUB_DEBUG */
>
>  static inline bool kmem_cache_debug(struct kmem_cache *s)
>  {
> @@ -4493,7 +4507,7 @@ void __init kmem_cache_init(void)
>                 slub_max_order = 0;
>
>         /* Print slub debugging pointers without hashing */
> -       if (static_branch_unlikely(&slub_debug_enabled))
> +       if (__slub_debug_enabled())

It would be super cool if static branches could be optimized out when
they're never changed by any code, nor exported to code, just tested in
conditions. I've no idea if that is the case though.

>                 no_hash_pointers_enable(NULL);
>
>         kmem_cache_node = &boot_kmem_cache_node;
