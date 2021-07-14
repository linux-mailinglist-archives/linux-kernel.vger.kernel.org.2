Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405D43C7CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhGNDYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbhGNDYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:24:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06111C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:21:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso789003pjp.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=64mggpW6L4yB/ZEu7p2r3XShD+rh1n8ieqDQws5Tc/Y=;
        b=bGgk1p6qwfmwY89UHFIEwQnMeSf1Tcy78ZHVU2ZCcYNH+yiv+32oMcTdKVHuELGLch
         XM2fHPlMe/skyle71IO0gJISnMxORQB/7G/7c6/A5qMhJIIvAZBnNVps0mPGCEQabM0P
         hi1LQK2owE8S/at+ZfqMq9e3wXclD/ERcxf3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=64mggpW6L4yB/ZEu7p2r3XShD+rh1n8ieqDQws5Tc/Y=;
        b=TQpoqu6aQGad+X9EK3HEaZZ1JYef55BvgXuvi7u/7dC1s+Ihghems5unk64igtGnal
         HpR1WobLj4obJebkRUc0YF2kgtZ+srCMqkqlGVvCz31qbxudg+BIok85s19Gwe2vsNyT
         v9JqlzdEUoUGZF6v0G9iezKPiZrtEhudIgMfHasoFP2If9cxpJ4zP3nqMwnnXtDdPZSI
         nQD1GSo4IYpWFRAZO3ZDjV7SC3ni/ovOT2JE4gr4bfkg+ffP1fZ5P5kGrbDkFNrc3OUU
         XJ8LAt0VVntfVdmh/fYGd+z5mlZ00mTDcR+Igrd/AkSZdEizpDuGUODH/096ftTjOseX
         MzyA==
X-Gm-Message-State: AOAM531hQE2CKhKl7xFx9I6f68XOTFkl/qet+AIgjePFEJBEkXUpq9jB
        P3DqLvCgLZVlhXNzCGqgsMUNUg==
X-Google-Smtp-Source: ABdhPJyNYOB+j3ZbBDXJWPOf5A6Ucr7okcs9yX+ymdGINqozkDOuLrTOu5dRfoY/9kbQYbWee4x64w==
X-Received: by 2002:a17:902:e14c:b029:129:d117:fa3d with SMTP id d12-20020a170902e14cb0290129d117fa3dmr6316920pla.53.1626232888490;
        Tue, 13 Jul 2021 20:21:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10sm555424pgl.46.2021.07.13.20.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 20:21:27 -0700 (PDT)
Date:   Tue, 13 Jul 2021 20:21:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        bowsingbetee@pm.me, Mikhail Morfikov <mmorfikov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mm: page_alloc: Fix page_poison=1 /
 INIT_ON_ALLOC_DEFAULT_ON interaction
Message-ID: <202107132020.6511A69EEC@keescook>
References: <20210714031935.4094114-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714031935.4094114-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 08:19:35PM -0700, Kees Cook wrote:
> From: Sergei Trofimovich <slyfox@gentoo.org>
> 
> To reproduce the failure we need the following system:
>   - kernel command: page_poison=1 init_on_free=0 init_on_alloc=0
>   - kernel config:
>     * CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
>     * CONFIG_INIT_ON_FREE_DEFAULT_ON=y
>     * CONFIG_PAGE_POISONING=y
> 
>     0000000085629bdd: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     0000000022861832: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00000000c597f5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     CPU: 11 PID: 15195 Comm: bash Kdump: loaded Tainted: G     U     O      5.13.1-gentoo-x86_64 #1
>     Hardware name: System manufacturer System Product Name/PRIME Z370-A, BIOS 2801 01/13/2021
>     Call Trace:
>      dump_stack+0x64/0x7c
>      __kernel_unpoison_pages.cold+0x48/0x84
>      post_alloc_hook+0x60/0xa0
>      get_page_from_freelist+0xdb8/0x1000
>      __alloc_pages+0x163/0x2b0
>      __get_free_pages+0xc/0x30
>      pgd_alloc+0x2e/0x1a0
>      ? dup_mm+0x37/0x4f0
>      mm_init+0x185/0x270
>      dup_mm+0x6b/0x4f0
>      ? __lock_task_sighand+0x35/0x70
>      copy_process+0x190d/0x1b10
>      kernel_clone+0xba/0x3b0
>      __do_sys_clone+0x8f/0xb0
>      do_syscall_64+0x68/0x80
>      ? do_syscall_64+0x11/0x80
>      entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Before the 51cba1eb ("init_on_alloc: Optimize static branches")
> init_on_alloc never enabled static branch by default. It could
> only be enabed explicitly by init_mem_debugging_and_hardening().
> 
> But after the 51cba1eb static branch could already be enabled
> by default. There was no code to ever disable it. That caused
> page_poison=1 / init_on_free=1 conflict.
> 
> This change extends init_mem_debugging_and_hardening() to also
> disable static branch disabling.
> 
> CC: Alexander Potapenko <glider@google.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: linux-mm@kvack.org
> Reported-by: bowsingbetee@pm.me
> Reported-by: Mikhail Morfikov <mmorfikov@gmail.com>
> Fixes: 51cba1ebc60d ("init_on_alloc: Optimize static branches")
> Cc: stable@vger.kernelo.org

yay typo "kernelo". Andrew, are you able to clean this up, or should I send a v3?

Sorry!

-Kees

> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> Link: https://lore.kernel.org/r/20210712215816.1512739-1-slyfox@gentoo.org
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/page_alloc.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3b97e17806be..1f19365bc158 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -840,21 +840,24 @@ void init_mem_debugging_and_hardening(void)
>  	}
>  #endif
>  
> -	if (_init_on_alloc_enabled_early) {
> -		if (page_poisoning_requested)
> -			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> -				"will take precedence over init_on_alloc\n");
> -		else
> -			static_branch_enable(&init_on_alloc);
> -	}
> -	if (_init_on_free_enabled_early) {
> -		if (page_poisoning_requested)
> -			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> -				"will take precedence over init_on_free\n");
> -		else
> -			static_branch_enable(&init_on_free);
> +	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
> +	    page_poisoning_requested) {
> +		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> +			"will take precedence over init_on_alloc and init_on_free\n");
> +		_init_on_alloc_enabled_early = false;
> +		_init_on_free_enabled_early = false;
>  	}
>  
> +	if (_init_on_alloc_enabled_early)
> +		static_branch_enable(&init_on_alloc);
> +	else
> +		static_branch_disable(&init_on_alloc);
> +
> +	if (_init_on_free_enabled_early)
> +		static_branch_enable(&init_on_free);
> +	else
> +		static_branch_disable(&init_on_free);
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  	if (!debug_pagealloc_enabled())
>  		return;
> -- 
> 2.30.2
> 

-- 
Kees Cook
