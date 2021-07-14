Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71F53C7C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhGNDM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbhGNDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:12:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8CC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:10:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m83so766769pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Jd8IZTQd2Xo6YcQuTq7axTVaDs+ebyxKHsj9sYi5wk=;
        b=TAcm7bx0cV65HGTmGl9RI4K8frOjQp3vH6tMqdpPabG1i5GqiK71GSHaEFQQvSjyYK
         s1EAPWrcypdEuKekGs3TwuS0GVWwZ3mBYVOF7p1JeLR5NKXtgtFLJg/NgL58bHIolLhH
         5wmP22T5MPZ+lMRoN3boZeFBeuWFnVpHYPSjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Jd8IZTQd2Xo6YcQuTq7axTVaDs+ebyxKHsj9sYi5wk=;
        b=UhGSdEATnmLLhn5mOZd6wLdyh7tRQxnjzux1G+y97qnzjvuzjKazl9K+5gaTLitlwI
         +040MnXXsECKEOhSFph0dK6QvcdcU0Qmmk2Z17+5W9QcL8YAM7hWX3kHciCCZNuQc8/g
         NrBbjjosDcLuW3jO1mzAUZjAcBP8M7lKnxqIQbFeMFyvGMxrVi433EAkHLn64uEtRsLA
         49lYWjYyrEUMFD0E69LeheWoQWWuZ5kQprTZ2THdaTzDpE03p0zZFVJ/KpmAoPne5ioQ
         7HozaVVymLwxLkPD+Uks/fgTI3QSH3sSzKZrGrgts/VORJt90wDpIVpa1FXPvfXUki4l
         3EHg==
X-Gm-Message-State: AOAM530QHPVq2OV8Du6jEVmSzCI/LYB3O5C+EZceFf+9Phb6Ep03AT43
        X4xRJ5ku1eqetDCkcno0CnJaMA==
X-Google-Smtp-Source: ABdhPJwXDrW9T0QbuKSZNzx6cpmaP+iYIbNR7ehR2k2xKhMmc5Oz0c7TnNyO/o5N/PpmJO+Ha6yVvw==
X-Received: by 2002:a63:405:: with SMTP id 5mr7300613pge.132.1626232203008;
        Tue, 13 Jul 2021 20:10:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cx4sm4258976pjb.53.2021.07.13.20.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 20:10:02 -0700 (PDT)
Date:   Tue, 13 Jul 2021 20:10:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, bowsingbetee@pm.me
Subject: Re: [PATCH] mm: page_alloc: fix page_poison=1 /
 INIT_ON_ALLOC_DEFAULT_ON interaction
Message-ID: <202107131953.BB3627156@keescook>
References: <20210712005732.4f9bfa78@zn3>
 <20210712215816.1512739-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712215816.1512739-1-slyfox@gentoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 10:58:16PM +0100, Sergei Trofimovich wrote:
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

But init_mem_debugging_and_hardening() is always called (by mm_init()).

> But after the 51cba1eb static branch could already be enabled
> by default. There was no code to ever disable it. That caused
> page_poison=1 / init_on_free=1 conflict.
> 
> This change extends init_mem_debugging_and_hardening() to also
> disable static branch disabling.
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Kees Cook <keescook@chromium.org>
> CC: Alexander Potapenko <glider@google.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: linux-mm@kvack.org
> Reported-by: bowsingbetee@pm.me
> Reported-by: Mikhail Morfikov
> Fixes: 51cba1eb ("init_on_alloc: Optimize static branches")
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  mm/page_alloc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3b97e17806be..46cb4a9c2b50 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -840,18 +840,22 @@ void init_mem_debugging_and_hardening(void)
>  	}
>  #endif
>  
> -	if (_init_on_alloc_enabled_early) {
> -		if (page_poisoning_requested)
> +	if (_init_on_alloc_enabled_early ||
> +	    IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON)) {

This doesn't look right. _init_on_alloc_enabled_early already has the
same value:

static bool _init_on_alloc_enabled_early __read_mostly
                                = IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);

So checking this is just a side-effect of how static_branch_maybe()
happens to be behaving.

> +		if (page_poisoning_requested) {
>  			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
>  				"will take precedence over init_on_alloc\n");
> -		else
> +			static_branch_disable(&init_on_alloc);
> +		} else
>  			static_branch_enable(&init_on_alloc);
>  	}
> -	if (_init_on_free_enabled_early) {
> -		if (page_poisoning_requested)
> +	if (_init_on_free_enabled_early ||
> +	    IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON)) {
> +		if (page_poisoning_requested) {
>  			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
>  				"will take precedence over init_on_free\n");
> -		else
> +			static_branch_disable(&init_on_free);
> +		} else
>  			static_branch_enable(&init_on_free);
>  	}

I think it would be better to clean this up without additional
confusion involving the CONFIGs:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b97e17806be..1f19365bc158 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -840,21 +840,24 @@ void init_mem_debugging_and_hardening(void)
 	}
 #endif
 
-	if (_init_on_alloc_enabled_early) {
-		if (page_poisoning_requested)
-			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
-				"will take precedence over init_on_alloc\n");
-		else
-			static_branch_enable(&init_on_alloc);
-	}
-	if (_init_on_free_enabled_early) {
-		if (page_poisoning_requested)
-			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
-				"will take precedence over init_on_free\n");
-		else
-			static_branch_enable(&init_on_free);
+	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
+	    page_poisoning_requested) {
+		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
+			"will take precedence over init_on_alloc and init_on_free\n");
+		_init_on_alloc_enabled_early = false;
+		_init_on_free_enabled_early = false;
 	}
 
+	if (_init_on_alloc_enabled_early)
+		static_branch_enable(&init_on_alloc);
+	else
+		static_branch_disable(&init_on_alloc);
+
+	if (_init_on_free_enabled_early)
+		static_branch_enable(&init_on_free);
+	else
+		static_branch_disable(&init_on_free);
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (!debug_pagealloc_enabled())
 		return;

-- 
Kees Cook
