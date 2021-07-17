Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435373CC53D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhGQSVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhGQSVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 14:21:47 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23001C061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 11:18:51 -0700 (PDT)
Date:   Sat, 17 Jul 2021 19:18:42 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, bowsingbetee@pm.me
Subject: Re: [PATCH] mm: page_alloc: fix page_poison=1 /
 INIT_ON_ALLOC_DEFAULT_ON interaction
Message-ID: <20210717191842.3ad53af8@zn3>
In-Reply-To: <20210713190051.5d841c9269cf7cddf1731e5a@linux-foundation.org>
References: <20210712005732.4f9bfa78@zn3>
        <20210712215816.1512739-1-slyfox@gentoo.org>
        <20210713190051.5d841c9269cf7cddf1731e5a@linux-foundation.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 19:00:51 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 12 Jul 2021 22:58:16 +0100 Sergei Trofimovich <slyfox@gentoo.org> wrote:
> 
> > To reproduce the failure we need the following system:
> >   - kernel command: page_poison=1 init_on_free=0 init_on_alloc=0
> >   - kernel config:
> >     * CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> >     * CONFIG_INIT_ON_FREE_DEFAULT_ON=y
> >     * CONFIG_PAGE_POISONING=y
> > 
> >     0000000085629bdd: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     0000000022861832: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00000000c597f5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     CPU: 11 PID: 15195 Comm: bash Kdump: loaded Tainted: G     U     O      5.13.1-gentoo-x86_64 #1
> >     Hardware name: System manufacturer System Product Name/PRIME Z370-A, BIOS 2801 01/13/2021
> >     Call Trace:
> >      dump_stack+0x64/0x7c
> >      __kernel_unpoison_pages.cold+0x48/0x84
> >      post_alloc_hook+0x60/0xa0
> >      get_page_from_freelist+0xdb8/0x1000
> >      __alloc_pages+0x163/0x2b0
> >      __get_free_pages+0xc/0x30
> >      pgd_alloc+0x2e/0x1a0
> >      ? dup_mm+0x37/0x4f0
> >      mm_init+0x185/0x270
> >      dup_mm+0x6b/0x4f0
> >      ? __lock_task_sighand+0x35/0x70
> >      copy_process+0x190d/0x1b10
> >      kernel_clone+0xba/0x3b0
> >      __do_sys_clone+0x8f/0xb0
> >      do_syscall_64+0x68/0x80
> >      ? do_syscall_64+0x11/0x80
> >      entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > Before the 51cba1eb ("init_on_alloc: Optimize static branches")
> > init_on_alloc never enabled static branch by default. It could
> > only be enabed explicitly by init_mem_debugging_and_hardening().
> > 
> > But after the 51cba1eb static branch could already be enabled
> > by default. There was no code to ever disable it. That caused
> > page_poison=1 / init_on_free=1 conflict.
> > 
> > This change extends init_mem_debugging_and_hardening() to also
> > disable static branch disabling.
> > 
> > ...
> >
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -840,18 +840,22 @@ void init_mem_debugging_and_hardening(void)
> >  	}
> >  #endif
> >  
> > -	if (_init_on_alloc_enabled_early) {
> > -		if (page_poisoning_requested)
> > +	if (_init_on_alloc_enabled_early ||
> > +	    IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON)) {
> > +		if (page_poisoning_requested) {
> >  			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> >  				"will take precedence over init_on_alloc\n");
> > -		else
> > +			static_branch_disable(&init_on_alloc);
> > +		} else
> >  			static_branch_enable(&init_on_alloc);
> >  	}
> > -	if (_init_on_free_enabled_early) {
> > -		if (page_poisoning_requested)
> > +	if (_init_on_free_enabled_early ||
> > +	    IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON)) {
> > +		if (page_poisoning_requested) {
> >  			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> >  				"will take precedence over init_on_free\n");
> > -		else
> > +			static_branch_disable(&init_on_free);
> > +		} else
> >  			static_branch_enable(&init_on_free);
> >  	}
> >    
> 
> I'm thinking this is sufficiently serious and sufficiently reported to
> warrant a cc:stable backport.  Agree?

I agree. The patch might be tricky to apply as is too far back. But current
release should be fine.


-- 

  Sergei
