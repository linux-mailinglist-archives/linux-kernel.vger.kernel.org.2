Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FF43623AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbhDPPRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245347AbhDPPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618585988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y31wAS8VhbNO8Hh/5HXcZZGq5ek4j0KdlPADbl+H2zY=;
        b=SxQQQ1x5n1/zTl1W7sqkRDDKKZunsRgSt6rArJ2YdooxAgUBduLu1cavrjXPFqwnljli2T
        j6M0KRrukjJgIMrhsgi9YGEqE9+o44GKzxnTxVlIdI3jLhT3pwl1B8YiFd9ke39MtrcU+o
        uAkmZUO9cVfV0NxZdZJzuwniECnotZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-dWRYUTRkOKOZ7b3GOxbilw-1; Fri, 16 Apr 2021 11:13:05 -0400
X-MC-Unique: dWRYUTRkOKOZ7b3GOxbilw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B465CA687E;
        Fri, 16 Apr 2021 15:13:02 +0000 (UTC)
Received: from treble (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54A8360861;
        Fri, 16 Apr 2021 15:13:00 +0000 (UTC)
Date:   Fri, 16 Apr 2021 10:12:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, nivedita@alum.mit.edu, clin@suse.com,
        andriy.shevchenko@linux.intel.com, ndesaulniers@google.com,
        dan.j.williams@intel.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de,
        peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] X86: Makefile: Replace -pg with CC_FLAGS_FTRACE
Message-ID: <20210416151258.gjchvi7c5uneiy63@treble>
References: <20210416053928.11576-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416053928.11576-1-zhaoxiao@uniontech.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Steven Rostedt (ftrace maintainer).

On Fri, Apr 16, 2021 at 01:39:28PM +0800, zhaoxiao wrote:
> In preparation for x86 supporting ftrace built on other compiler
> options, let's have the x86 Makefiles remove the $(CC_FLAGS_FTRACE)
> flags, whatever these may be, rather than assuming '-pg'.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
> v2: add the same change for the other Makefile in arch/x86 directory.
>  arch/x86/entry/vdso/Makefile |  8 ++++----
>  arch/x86/kernel/Makefile     | 16 ++++++++--------
>  arch/x86/kernel/cpu/Makefile |  4 ++--
>  arch/x86/lib/Makefile        |  2 +-
>  arch/x86/mm/Makefile         |  4 ++--
>  arch/x86/xen/Makefile        |  6 +++---
>  6 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 05c4abc2fdfd..c5bd91bf9f93 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -96,10 +96,10 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(
>  #
>  # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
>  #
> -CFLAGS_REMOVE_vclock_gettime.o = -pg
> -CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
> -CFLAGS_REMOVE_vgetcpu.o = -pg
> -CFLAGS_REMOVE_vsgx.o = -pg
> +CFLAGS_REMOVE_vclock_gettime.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_vdso32/vclock_gettime.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_vgetcpu.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_vsgx.o = $(CC_FLAGS_FTRACE)
>  
>  #
>  # X32 processes use x32 vDSO to access 64bit kernel data.
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 2ddf08351f0b..2811fc6a17ba 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -13,14 +13,14 @@ CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
>  
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not profile debug and lowlevel utilities
> -CFLAGS_REMOVE_tsc.o = -pg
> -CFLAGS_REMOVE_paravirt-spinlocks.o = -pg
> -CFLAGS_REMOVE_pvclock.o = -pg
> -CFLAGS_REMOVE_kvmclock.o = -pg
> -CFLAGS_REMOVE_ftrace.o = -pg
> -CFLAGS_REMOVE_early_printk.o = -pg
> -CFLAGS_REMOVE_head64.o = -pg
> -CFLAGS_REMOVE_sev-es.o = -pg
> +CFLAGS_REMOVE_tsc.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_paravirt-spinlocks.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_pvclock.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_kvmclock.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_early_printk.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_head64.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_sev-es.o = $(CC_FLAGS_FTRACE)
>  endif
>  
>  KASAN_SANITIZE_head$(BITS).o				:= n
> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> index 637b499450d1..4435c6de9145 100644
> --- a/arch/x86/kernel/cpu/Makefile
> +++ b/arch/x86/kernel/cpu/Makefile
> @@ -5,8 +5,8 @@
>  
>  # Don't trace early stages of a secondary CPU boot
>  ifdef CONFIG_FUNCTION_TRACER
> -CFLAGS_REMOVE_common.o = -pg
> -CFLAGS_REMOVE_perf_event.o = -pg
> +CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
>  endif
>  
>  # If these files are instrumented, boot hangs during the first second.
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index bad4dee4f0e4..0aa71b8a5bc1 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -21,7 +21,7 @@ KASAN_SANITIZE_cmdline.o  := n
>  KCSAN_SANITIZE_cmdline.o  := n
>  
>  ifdef CONFIG_FUNCTION_TRACER
> -CFLAGS_REMOVE_cmdline.o = -pg
> +CFLAGS_REMOVE_cmdline.o = $(CC_FLAGS_FTRACE)
>  endif
>  
>  CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index 5864219221ca..91883d5a0293 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -12,8 +12,8 @@ KASAN_SANITIZE_mem_encrypt_identity.o	:= n
>  KCSAN_SANITIZE := n
>  
>  ifdef CONFIG_FUNCTION_TRACER
> -CFLAGS_REMOVE_mem_encrypt.o		= -pg
> -CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
> +CFLAGS_REMOVE_mem_encrypt.o		= $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_mem_encrypt_identity.o	= $(CC_FLAGS_FTRACE)
>  endif
>  
>  obj-y				:=  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o \
> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
> index 40b5779fce21..179dfc124c94 100644
> --- a/arch/x86/xen/Makefile
> +++ b/arch/x86/xen/Makefile
> @@ -2,9 +2,9 @@
>  
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not profile debug and lowlevel utilities
> -CFLAGS_REMOVE_spinlock.o = -pg
> -CFLAGS_REMOVE_time.o = -pg
> -CFLAGS_REMOVE_irq.o = -pg
> +CFLAGS_REMOVE_spinlock.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_time.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_irq.o = $(CC_FLAGS_FTRACE)
>  endif
>  
>  # Make sure early boot has no stackprotector
> -- 
> 2.20.1
> 
> 
> 

-- 
Josh

