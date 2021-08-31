Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687DD3FC685
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbhHaL0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:26:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43866 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbhHaL0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:26:46 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A86D20162;
        Tue, 31 Aug 2021 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630409150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41ODscT9R7StQRKZE9661t2A2etPFHtRWGhN70Cg1Q0=;
        b=uhya+yYl6sOPZyOTq4fFraw8fr6GxHaziudZmQgXccAdLnlcGPIoOf+AQtXow2hAwtQ88p
        XZ+ThAsfJCkWWMJCBqCUkukGHHM1NQw394j32gxgjumA89AGF5ti1DNx76alTMmJkVP8Xc
        xlxbQq/pUwo6fXGoyA9oPk1YnVwf9hY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630409150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41ODscT9R7StQRKZE9661t2A2etPFHtRWGhN70Cg1Q0=;
        b=nJCfGYuAIk1WUtafgMu0N6YUTAEh/M6N9ZWx95RnF5lKiI0SCK5U8KAyRtBuVQfqxAhv74
        LEGH74gIu94zfwDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 46B2413A8B;
        Tue, 31 Aug 2021 11:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EIySEL4RLmFIDAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 31 Aug 2021 11:25:50 +0000
Message-ID: <ac61af5a-f6f3-315a-59a8-7beed8de2aac@suse.cz>
Date:   Tue, 31 Aug 2021 13:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, cl@linux.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Oliver Glitta <glittao@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20210831062539.898293-1-imran.f.khan@oracle.com>
 <20210831062539.898293-2-imran.f.khan@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 1/2] lib, stackdepot: Add input prompt for STACKDEPOT
 option.
In-Reply-To: <20210831062539.898293-2-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+CC rest of slab maintainers (please use get_maintainers.pl next time)

On 8/31/21 08:25, Imran Khan wrote:
> So far CONFIG_STACKDEPOT option was being selected by
> features that need STACKDEPOT support for their operations,
> for example KASAN.
> Since next patch makes use of STACKDEPOT to store user tracking
> information for slub debugger and since user tracking info may
> or may not store stack trace for allocating and freeing contexts,
> make STACKDEPOT explicitly configurable.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Right so you're probably not aware, but switching slub to stackdepot was
just recently attempted by 788691464c29 ("mm/slub: use stackdepot to save
stack trace in objects"), but Linus reverted it in ae14c63a9f20. Enabling
stackdepot unconditionally was one of the reasons as there's memory overhead.

> ---
>  lib/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 6a6ae5312fa0..7e4b54f48af7 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -665,8 +665,9 @@ config ARCH_STACKWALK
>         bool
>  
>  config STACKDEPOT
> -	bool
> +	def_bool n
>  	select STACKTRACE
> +	prompt "Enable stackdepot support"
>  
>  config STACK_HASH_ORDER
>  	int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
> 

I'm not a big fan of a solution that throws another prompt at the person
configuring the kernel, especially if there's nothing to help decide how to
answer it.

Incidentally just yesterday I was trying locally to resolve this in a
different way, where stackdepot would be enabled if both CONFIG_SLUB_DEBUG
and CONFIG_STACKTRACE is enabled. That could be enough, unless there are
systems that would like to have STACKTRACE enabled for other reasons,
SLUB_DEBUG also for other reasons but still not want to pay the memory
overhead of stackdepot. At that point it could be more useful to investigate
if it's possible to optimize stackdepot to not make memblock allocations
unconditionally on init, but normal buddy allocations only when actually used.

Thoughts on the below?

----8<----
commit d3582a7c54b26f6fd3a44f1327a26c383e6b951c
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Mon Aug 30 17:26:15 2021 +0200

    Rework stackdepot deps

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 80b57e7f4947..8c25b27014ee 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -267,7 +267,6 @@ config UNWINDER_FRAME_POINTER
 config UNWINDER_GUESS
 	bool "Guess unwinder"
 	depends on EXPERT
-	depends on !STACKDEPOT
 	help
 	  This option enables the "guess" unwinder for unwinding kernel stack
 	  traces.  It scans the stack and reports every kernel text address it
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 7ff89690a976..4638c4ece8f2 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -47,7 +47,8 @@ config DRM_DEBUG_MM
 	bool "Insert extra checks and debug info into the DRM range managers"
 	default n
 	depends on DRM=y
-	depends on STACKTRACE_SUPPORT
+	depends on STACKDEPOT_SUPPORT
+	select STACKTRACE
 	select STACKDEPOT
 	help
 	  Enable allocation tracking of memory manager and leak detection on
diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 72a38f28393f..70794c6bb84f 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -21,9 +21,11 @@ config DRM_I915_DEBUG
 	depends on DRM_I915
 	depends on EXPERT # only for developers
 	depends on !COMPILE_TEST # never built by robots
+	depends on STACKDEPOT_SUPPORT
 	select DEBUG_FS
 	select PREEMPT_COUNT
 	select I2C_CHARDEV
+	select STACKTRACE
 	select STACKDEPOT
 	select DRM_DP_AUX_CHARDEV
 	select X86_MSR # used by igt/pm_rpm
diff --git a/init/Kconfig b/init/Kconfig
index 55f9f7738ebb..f9a4ec802516 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1847,6 +1847,7 @@ config SLUB_DEBUG
 	default y
 	bool "Enable SLUB debugging support" if EXPERT
 	depends on SLUB && SYSFS
+	select STACKDEPOT if STACKDEPOT_SUPPORT && STACKTRACE
 	help
 	  SLUB has extensive debug support features. Disabling these can
 	  result in significant savings in code size. This also disables
diff --git a/lib/Kconfig b/lib/Kconfig
index 5c9c0687f76d..67c388a09b7a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -661,9 +661,37 @@ config ARCH_HAS_COPY_MC
 config ARCH_STACKWALK
        bool
 
+# encompasses STACKDEPOT dependencies
+config STACKDEPOT_SUPPORT
+	def_bool y
+	depends on STACKTRACE_SUPPORT && !UNWINDER_GUESS
+
+# STACKDEPOT consumes megabytes of memory when compiled in, so we want to make
+# sure it's only enabled when needed. But we don't want to burden the user with
+# another choice. STACKTRACE is already configurable (but often selected by
+# other configs).
+#
+# Due to how kconfig dependency resolution  works, it's slightly complicated
+# as we cannot e.g. change STACKDEPOT to select STACKTRACE. Here are common
+# scenarios how to use STACKDEPOT with your config options:
+#
+# Scenario 1: hard dependency, will select also STACKTRACE, your config will
+# only be visible when STACKDEPOT_SUPPORT (and thus also STACKTRACE_SUPPORT) is
+# satisfied:
+#
+# 	depends on STACKDEPOT_SUPPORT
+#	select STACKTRACE
+#	select STACKDEPOT
+#
+# Scenario 2: soft dependency (e.g. for code with #ifdef CONFIG_STACKDEPOT
+# guards), will select STACKDEPOT only when STACKTRACE was configured by user
+# (or selected by some other config)
+#
+#	select STACKDEPOT if STACKDEPOT_SUPPORT && STACKTRACE
+#
 config STACKDEPOT
 	bool
-	select STACKTRACE
+	depends on STACKDEPOT_SUPPORT
 
 config STACK_HASH_ORDER
 	int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 1e73717802f8..56a248814788 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -47,7 +47,7 @@ config DEBUG_PAGEALLOC_ENABLE_DEFAULT
 
 config PAGE_OWNER
 	bool "Track page owner"
-	depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
+	depends on DEBUG_KERNEL && STACKDEPOT_SUPPORT
 	select DEBUG_FS
 	select STACKTRACE
 	select STACKDEPOT
