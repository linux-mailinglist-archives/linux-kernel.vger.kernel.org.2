Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028C843E69C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJ1Qxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1Qxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:53:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C8C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:51:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t11so4834628plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Ih9L7I3EtdF1qtBtw2qCRFNuaZrqIqaenrbVoXp4F4=;
        b=XD7F5t6tImB4KG/Bnxg3NzCo0AUN5WtpFAx05860YtLZLdM118BIqyc4pGUjU8QruD
         RukjrLOMz5ylzXC7h+v32riAQ1GzHJ4R8Z+B7zKATLV/Urov/j26O9pmx+u2B9o7TiiA
         cranhBvRF4YmwqiJ+EszJg9Por2mPJq6svoTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Ih9L7I3EtdF1qtBtw2qCRFNuaZrqIqaenrbVoXp4F4=;
        b=MHzX6EpZZEjEBL38R/XdpVp2rRv3SevZt291B763FxI+xK8H+o8NlWg+w03RlXZMgS
         5yTYki08WJD4rIQuxQ+zjCb6uf2k4Y3F4bqf5sJVQgIBhnDwUx4GopbzEfo8mpa8LiET
         dRamTKj71w72WC3jfIMVabVAvqv9L+/LZm6ydk+R42Sh3afX1GfwQXCgv+ASzKQ4kFI2
         HMPegHMY3miHRDoLCOiuvr8NmlIZIhAGxDhihP7ojTqNoEL187RXLLMZV6JUXH2xE6j6
         mecwiUU0nIOJ5M8rsvKUE4fEpgaxVeDvd7RwOX8I/VdEMWJQu3a0PtkhJNxj6VrzyE18
         UUbA==
X-Gm-Message-State: AOAM531GC0weU8Un4RaivyaSEsqx503w/13BmvzRjT3CoIF4e8lZXfNS
        PwmISgVvpCQRUCHGZ3e7Nb7aEtnUOvhYRw==
X-Google-Smtp-Source: ABdhPJyOojSJtafDXFQKqZw579NK241/uRaI/w38ND8zzEPTgrbbDGtfRJTsI4pxdwqViKcLjv7PlQ==
X-Received: by 2002:a17:90a:e7c2:: with SMTP id kb2mr8704787pjb.15.1635439873835;
        Thu, 28 Oct 2021 09:51:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p7sm3154501pgn.52.2021.10.28.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:51:13 -0700 (PDT)
Date:   Thu, 28 Oct 2021 09:51:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, hjl.tools@gmail.com
Subject: Re: [RFC][PATCH] x86: Add straight-line-speculation mitigation
Message-ID: <202110280923.341FFA15D8@keescook>
References: <YXqNAJI3NJz3SQue@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXqNAJI3NJz3SQue@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 01:44:00PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> This little patch makes use of an upcomming GCC feature to mitigate
> straight-line-speculation for x86:
> 
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
> 
> It's built tested on x86_64-allyesconfig using GCC-12+patch and GCC-11.
> It's also been boot tested on x86_64-defconfig+kvm_guest.config using
> GCC-12+patch.
> 
> Enjoy!
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I'm all for such mitigations. In x86's case, it's small and easy. I do
note, however, than arm64 maintainers weren't as impressed:
https://lore.kernel.org/lkml/20210305095256.GA22536@willie-the-truck/

What's the image size impact?

> [...]
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -468,6 +468,18 @@ config RETPOLINE
>  	  branches. Requires a compiler with -mindirect-branch=thunk-extern
>  	  support for full protection. The kernel may run slower.
>  
> +config CC_HAS_SLS
> +	def_bool $(cc-option,-mharden-sls=all)
> +
> +config SLS
> +	bool "Mitigate Straight-Line-Speculation"
> +	depends on CC_HAS_SLS
> +	default y
> +	help
> +	  Compile the kernel with straight-line-speculation options to guard
> +          against straight line speculation. The kernel image might be slightly
> +          larger.

nit: differing indents; I'd expect the last two lines to match the first
(tab, space, space).

> +
>  config X86_CPU_RESCTRL
>  	bool "x86 CPU resource control support"
>  	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -179,6 +179,10 @@ ifdef CONFIG_RETPOLINE
>    endif
>  endif
>  
> +ifdef CONFIG_SLS
> +  KBUILD_CFLAGS += -mharden-sls=all
> +endif
> +
>  KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
>  
>  ifdef CONFIG_LTO_CLANG

Given the earlier patch for ARM, perhaps the Kconfig and Makefile chunks
should be at the top level instead, making this feature easier to
implement in other architectures?

> [...]
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -241,7 +241,8 @@ objtool_args =								\
>  	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
>  	$(if $(CONFIG_RETPOLINE), --retpoline)				\
>  	$(if $(CONFIG_X86_SMAP), --uaccess)				\
> -	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)
> +	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)             \
> +        $(if $(CONFIG_SLS), --sls)
>  
>  # Useful for describing the dependency of composite objects
>  # Usage:
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -531,6 +531,11 @@ int arch_decode_instruction(struct objto
>  		}
>  		break;
>  
> +	case 0xcc:
> +		/* int3 */
> +		*type = INSN_TRAP;
> +		break;
> +
>  	case 0xe3:
>  		/* jecxz/jrcxz */
>  		*type = INSN_JUMP_CONDITIONAL;
> @@ -697,10 +702,10 @@ const char *arch_ret_insn(int len)
>  {
>  	static const char ret[5][5] = {
>  		{ BYTE_RET },
> -		{ BYTE_RET, BYTES_NOP1 },
> -		{ BYTE_RET, BYTES_NOP2 },
> -		{ BYTE_RET, BYTES_NOP3 },
> -		{ BYTE_RET, BYTES_NOP4 },
> +		{ BYTE_RET, 0xcc },
> +		{ BYTE_RET, 0xcc, BYTES_NOP1 },
> +		{ BYTE_RET, 0xcc, BYTES_NOP2 },
> +		{ BYTE_RET, 0xcc, BYTES_NOP3 },
>  	};
>  
>  	if (len < 1 || len > 5) {
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -20,7 +20,7 @@
>  #include <objtool/objtool.h>
>  
>  bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
> -     validate_dup, vmlinux, mcount, noinstr, backup;
> +     validate_dup, vmlinux, mcount, noinstr, backup, sls;
>  
>  static const char * const check_usage[] = {
>  	"objtool check [<options>] file.o",
> @@ -45,6 +45,7 @@ const struct option check_options[] = {
>  	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
>  	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
>  	OPT_BOOLEAN('B', "backup", &backup, "create .orig files before modification"),
> +	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
>  	OPT_END(),
>  };
>  
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3084,6 +3084,12 @@ static int validate_branch(struct objtoo
>  		switch (insn->type) {
>  
>  		case INSN_RETURN:
> +			if (next_insn && next_insn->type == INSN_TRAP) {
> +				next_insn->ignore = true;
> +			} else if (sls && !insn->retpoline_safe) {
> +				WARN_FUNC("missing int3 after ret",
> +					  insn->sec, insn->offset);
> +			}
>  			return validate_return(func, insn, &state);
>  
>  		case INSN_CALL:
> @@ -3127,6 +3133,14 @@ static int validate_branch(struct objtoo
>  			break;
>  
>  		case INSN_JUMP_DYNAMIC:
> +			if (next_insn && next_insn->type == INSN_TRAP) {
> +				next_insn->ignore = true;
> +			} else if (sls && !insn->retpoline_safe) {
> +				WARN_FUNC("missing int3 after indirect jump",
> +					  insn->sec, insn->offset);
> +			}
> +
> +			/* fallthrough */
>  		case INSN_JUMP_DYNAMIC_CONDITIONAL:
>  			if (is_sibling_call(insn)) {
>  				ret = validate_sibling_call(file, insn, &state);

Oh very nice; I was going to ask "how can we make sure no bare 'ret's
sneak back into .S files" and here it is. Excellent.

Random thought, not for this patch, but can objtool validate the int3
linker padding too? (i.e. to double-check the behavior of
7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP for linker fill bytes"))

-Kees

-- 
Kees Cook
