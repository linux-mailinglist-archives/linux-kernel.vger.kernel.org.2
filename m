Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3745EC99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbhKZL3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243476AbhKZL1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:27:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1891C06179E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:39:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so10350382wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eEOAK+Cf03lXZLaEkmNwb12jRPlVUMgen83gdYf33Eg=;
        b=DjaajmbIsKB9yMfgL/taA4pTpsc8kcUwXrfJlALf9JjhOfJk//UcPxuHdGf468nTUs
         pxwYkAp95XHwagf4tebbYD2u654HCpsPvbN10HD6UptZy6RfqD4/UpmrlluNrVfrxzst
         038QJyvfHuL0tJMtpypMmqRybUEk3NlrRNh/9QbIYh6FeZGZdiNe7DL/3f9MCd6jJtR/
         zvJGWnxmKESRHm0kG+IcZeZFt4MSIEBTmaspCdmwwFN84fVVilCbbnJm7xYZTvSN6jJx
         nbQRtV6chtpgtnFUs15KkHDtFsbtphFZPKurccAFDjpMwAusO+ZJ9an3EdqR12EGFBbt
         lsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eEOAK+Cf03lXZLaEkmNwb12jRPlVUMgen83gdYf33Eg=;
        b=1JYRWCeGh5PeVpNveqVQR4TY2WyjR6t4lhUpvhEhJx2aSglYC5nEfFecYExny4bx92
         DwqDVKd7GL3b2zXpbG4b/Htiqgu6Jx4ihX9s2VSvOdmi+GElOKYCd5eyjcMsN+BRex21
         NlHQ/ZjC4OFpp+fnGW7yKczFIlrWJ9iS6/4v/poVGUdtaCQtJCd0S8QYwyG1kB4xp2S+
         x1REkUGz5sFK/tp9orZF1H3erDl//R2sHQq5dLlD97ezBZDz/8kzSSNqMDgD4kjzhSri
         UTduFYACV9bVmpM/H/JfiSstT+5vOKB4c7zPDxS6nyRZCv/ITW1rRl5IOM7WiciZthBQ
         Eqgg==
X-Gm-Message-State: AOAM532e65tiYhSXtHrojAQuaTF1tqMLeS3oYCwDVHMgCZimGVChQSTp
        /xuerIkusdaOKL5uiZgwyabGrdwR8J4H/g==
X-Google-Smtp-Source: ABdhPJxBfoTzoNbY0PHI41v/czzcwdiOWjFBenHv+Z0zooM9k5xQiSu81UJFybPMsuF3nHHSjDmEvA==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr14510921wmk.152.1637923195234;
        Fri, 26 Nov 2021 02:39:55 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:1d51:a6f6:77af:b142])
        by smtp.gmail.com with ESMTPSA id r11sm5155267wrw.5.2021.11.26.02.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 02:39:54 -0800 (PST)
Date:   Fri, 26 Nov 2021 11:39:49 +0100
From:   Marco Elver <elver@google.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Enable KCSAN
Message-ID: <YaC5dbsw/uDYOVEv@elver.google.com>
References: <20211126080008.77202-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126080008.77202-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 04:00PM +0800, Kefeng Wang wrote:
> This patch enables KCSAN for arm64, with updates to build rules
> to not use KCSAN for several incompatible compilation units.
> 
> Tested selftest and kcsan_test, and all passed.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Nice! Although I think Mark (Cc'd) also had been working on this and
probably knows what, if anything, is still missing.

For one, have you tested gcc 11? To make it work with gcc 11, my
preferred solution is that you simply squash this:

---

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index c2bb07f5bcc7..d7d0b51b79f5 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -8,6 +8,7 @@ CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 
 CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
+		 $(call cc-option,-mno-outline-atomics) \
 	-fno-stack-protector -DDISABLE_BRANCH_PROFILING
 
 obj-y := core.o debugfs.o report.o

---

[ I have changes to kernel/kcsan/Makefile that I expect to land in -next
  soon'ish, the above is small enough that git can auto-merge. ]

gcc somehow made outline-atomics the default (unlike clang), which will
cause linker errors for kernel/kcsan/core.o. While the support for
builtin atomics shouldn't be required on arm64, I want it to be
(compile-)testable on all architectures. Although there's an exception
that certain compiler instrumentation actually require working builtin
atomics support, specifically GCOV_KERNEL.

Thanks,
-- Marco

> ---
> Tested on Qemu with clang 13, based on 5.16-rc2.
> 
> [    0.221518] kcsan: enabled early
> [    0.222422] kcsan: strict mode configured
> ...
> [    5.839223] kcsan: selftest: 3/3 tests passed
> ...
> [  517.895102] # kcsan: pass:24 fail:0 skip:0 total:24
> [  517.896393] # Totals: pass:168 fail:0 skip:0 total:168
> [  517.897502] ok 1 - kcsan
> 
>  arch/arm64/Kconfig               | 1 +
>  arch/arm64/kernel/vdso/Makefile  | 1 +
>  arch/arm64/kvm/hyp/nvhe/Makefile | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4ff73299f8a9..0ac90875f71d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -150,6 +150,7 @@ config ARM64
>  	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
> +	select HAVE_ARCH_KCSAN
>  	select HAVE_ARCH_KFENCE
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_MMAP_RND_BITS
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 700767dfd221..60813497a381 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -32,6 +32,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
>  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
>  				$(CC_FLAGS_LTO)
>  KASAN_SANITIZE			:= n
> +KCSAN_SANITIZE			:= n
>  UBSAN_SANITIZE			:= n
>  OBJECT_FILES_NON_STANDARD	:= y
>  KCOV_INSTRUMENT			:= n
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index c3c11974fa3b..24b2c2425b38 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -89,6 +89,7 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI)
>  # cause crashes. Just disable it.
>  GCOV_PROFILE	:= n
>  KASAN_SANITIZE	:= n
> +KCSAN_SANITIZE	:= n
>  UBSAN_SANITIZE	:= n
>  KCOV_INSTRUMENT	:= n
>  
> -- 
> 2.26.2
> 
