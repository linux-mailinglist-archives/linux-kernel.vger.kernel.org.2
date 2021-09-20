Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF1A411706
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhITOb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbhITObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:31:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5ADC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:29:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id me1so3467741pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+lb5rV0LOZG6X4x4PyLRz7UJbh4IgA+uGggBnk9a57k=;
        b=EyUOu+EEkFGht9RZ5nV10ztgYdhuiiq0Jv2vp8uvpWYgvxfjMw8sVjMueajk5VXipv
         /oBwOAF3DtkDkuMxgwIsRcoKguHdtJ8vffvGHaa4qQxivNzK+5/DSlzFOlP2fyeqrwm8
         OvQoHu2ajNIlD5PhUdF9shFYfZd6HhXFp6JSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+lb5rV0LOZG6X4x4PyLRz7UJbh4IgA+uGggBnk9a57k=;
        b=jb5wYDGW7oU5PHmPaF97Nx4cADx64eLp1QyvbdeLXtTZ+kVgVOw0n21B22c13d22NN
         if+Yx0ok5AaXEdMeZAYRsUQ7u8a/l/Y/01LbWsmwPsalaZdud8sGPqZGMJDGarrVtFVT
         QMPBU7+BhP3/eBo4T4N+11YmKSLTFynNxQVaf/feJLpOaiXtnivXNKdzmV0klmsGrfJD
         XWXQQfjAwVBISIYfSgVawUagN5RdTK9XYKKbAb3x7c866e3dtlt8DTi1fHIKNKMlYxHR
         luFhJNcIznv1i69+/iLQVLFRNQaNCeND/s1HIR1hD7DibBZUZ6sjMtF+a3CageoO4pST
         P9lQ==
X-Gm-Message-State: AOAM531slyGgc+IqOy3lSvH4IsFE16freiNTJs76dFaar86qjbCju38n
        GfkVp0uLvh2LJzQdNjBaRNuc4g==
X-Google-Smtp-Source: ABdhPJwCfCkT5eXYYiNM8mNLhrjhZNHW7wB9H1w4DK0n5yjIGjtLA5jebXVcPBUaU2l4kUKjMyPyCQ==
X-Received: by 2002:a17:90b:4a88:: with SMTP id lp8mr13737014pjb.159.1632148196291;
        Mon, 20 Sep 2021 07:29:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b142sm7613439pfb.17.2021.09.20.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 07:29:55 -0700 (PDT)
Date:   Mon, 20 Sep 2021 07:29:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug
 is enabled
Message-ID: <202109200726.2EFEDC5@keescook>
References: <20210601182202.3011020-1-swboyd@chromium.org>
 <20210601182202.3011020-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601182202.3011020-5-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 11:22:02AM -0700, Stephen Boyd wrote:
> Obscuring the pointers that slub shows when debugging makes for some
> confusing slub debug messages:
> 
>  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> 
> Those addresses are hashed for kernel security reasons. If we're trying
> to be secure with slub_debug on the commandline we have some big
> problems given that we dump whole chunks of kernel memory to the kernel
> logs. Let's force on the no_hash_pointers commandline flag when
> slub_debug is on the commandline. This makes slub debug messages more
> meaningful and if by chance a kernel address is in some slub debug
> object dump we will have a better chance of figuring out what went
> wrong.
> 
> Note that we don't use %px in the slub code because we want to reduce
> the number of places that %px is used in the kernel. This also nicely
> prints a big fat warning at kernel boot if slub_debug is on the
> commandline so that we know that this kernel shouldn't be used on
> production systems.

Eeeek. I missed this patch. NAK NAK. People use slub_debug for
production systems to gain redzoning, etc, as a layer of defense, and
they absolutely do not want %p-hashing disabled. %p hashing is
controlled by the no_hash_pointers boot param (since v5.12), and needs to stay
separate from slub_debug.

Can we please revert this in Linus's tree and in v5.14?

-Kees

> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  include/linux/kernel.h | 2 ++
>  lib/vsprintf.c         | 2 +-
>  mm/slub.c              | 4 ++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 15d8bad3d2f2..bf950621febf 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -357,6 +357,8 @@ int sscanf(const char *, const char *, ...);
>  extern __scanf(2, 0)
>  int vsscanf(const char *, const char *, va_list);
>  
> +extern int no_hash_pointers_enable(char *str);
> +
>  extern int get_option(char **str, int *pint);
>  extern char *get_options(const char *str, int nints, int *ints);
>  extern unsigned long long memparse(const char *ptr, char **retptr);
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index f0c35d9b65bf..cc281f5895f9 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2186,7 +2186,7 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  bool no_hash_pointers __ro_after_init;
>  EXPORT_SYMBOL_GPL(no_hash_pointers);
>  
> -static int __init no_hash_pointers_enable(char *str)
> +int __init no_hash_pointers_enable(char *str)
>  {
>  	if (no_hash_pointers)
>  		return 0;
> diff --git a/mm/slub.c b/mm/slub.c
> index bf4949115412..a722794f1dbd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4460,6 +4460,10 @@ void __init kmem_cache_init(void)
>  	if (debug_guardpage_minorder())
>  		slub_max_order = 0;
>  
> +	/* Print slub debugging pointers without hashing */
> +	if (static_branch_unlikely(&slub_debug_enabled))
> +		no_hash_pointers_enable(NULL);
> +
>  	kmem_cache_node = &boot_kmem_cache_node;
>  	kmem_cache = &boot_kmem_cache;
>  
> -- 
> https://chromeos.dev
> 

-- 
Kees Cook
