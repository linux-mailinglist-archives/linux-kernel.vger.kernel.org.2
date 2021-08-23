Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AAD3F4F45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhHWRRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231418AbhHWRQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629738975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZFFKBLXvmTDOWmqTIb0MtmNKyCMkrWY/MlBcYf3Qag=;
        b=NBERgHSAFyi8mrSHGu+Eg6WgmEODzEKjOtstxlHzrElsRxRu7xdV4EILNAOm3hNKY+mAUI
        ESEuc1371QMJmvphLa0Y982uxAMAtoBpuDeMpUytlst9jzFWVdQ22dMg4O4AAz41KWqUJC
        vKAqMR/Z9bvlhGtiTYkkYb9je09kbA0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-MQSAtfUTNWW7Z3kORHPQvQ-1; Mon, 23 Aug 2021 13:16:13 -0400
X-MC-Unique: MQSAtfUTNWW7Z3kORHPQvQ-1
Received: by mail-qv1-f71.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so12828308qvt.20
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xZFFKBLXvmTDOWmqTIb0MtmNKyCMkrWY/MlBcYf3Qag=;
        b=DJOecw4tJeHTSCWWoVij6+ky2p3idt8z+CITxZThPQ2+bEkoWew07DM8WCmjLWFbTg
         g+eOhBC+qalL1bvn3s3Z9zlO12watY2wJP+Ojkno+fUeNVq2sN/y4kuPRdA3u/tQGgtm
         GZh+9nbPISlHS0YKXCMst4+maimJGTLgU3MrhslvDyYc9fcvmL/wzqCmGXfNQHUfefR7
         meDrqK4pUJwYr09eWRyHulOjnUo4FUDaraWzUJjHcWHEnYR9Ewc2d4Aumjl9dpI8qK15
         +FMvhReR8EXyQOPWzVZ0PCSZMi+/wzsQf9SPc32G2eip09092CcpAuk8HlrWAhhqxGRq
         bkiQ==
X-Gm-Message-State: AOAM530nhRBfrAiPCdMmjNng+ciJKWXQ6fQDfI3tpKG34GczKWsnWnEK
        FnrXK6Rt3+biW1upRR5grinGLxDHBV8NVIgY76mgm0f5zB3gzfiq6cwLBu6IYDXmZ0ALmz4UrqE
        nG5TQb8DbhS8JghQh6zjZeY12
X-Received: by 2002:ae9:e915:: with SMTP id x21mr22225256qkf.183.1629738973454;
        Mon, 23 Aug 2021 10:16:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiBD8uUARCKxXNSzoVbqrFZ+Jfv2SuNIY6/Q2oDsWp89XX08gcbM08qwqr7srUAbBQH3Ojww==
X-Received: by 2002:ae9:e915:: with SMTP id x21mr22225239qkf.183.1629738973302;
        Mon, 23 Aug 2021 10:16:13 -0700 (PDT)
Received: from tstellar.remote.csb (97-120-182-34.ptld.qwest.net. [97.120.182.34])
        by smtp.gmail.com with ESMTPSA id i67sm8999978qkd.90.2021.08.23.10.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 10:16:12 -0700 (PDT)
Subject: Re: [PATCH v2 00/14] x86: Add support for Clang CFI
To:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210823171318.2801096-1-samitolvanen@google.com>
From:   Tom Stellard <tstellar@redhat.com>
Message-ID: <1706ee8e-c21c-f867-c0be-24814a92b853@redhat.com>
Date:   Mon, 23 Aug 2021 10:16:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 10:13 AM, 'Sami Tolvanen' via Clang Built Linux wrote:
> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking to x86_64. With CFI, the compiler injects a runtime
> check before each indirect function call to ensure the target is
> a valid function with the correct static type. This restricts
> possible call targets and makes it more difficult for an attacker
> to exploit bugs that allow the modification of stored function
> pointers. For more details, see:
> 
>    https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> Version 2 depends on Clang >=14, where we fixed the issue with
> referencing static functions from inline assembly. Based on the
> feedback for v1, this version also changes the declaration of
> functions that are not callable from C to use an opaque type,
> which stops the compiler from replacing references to them. This
> avoids the need to sprinkle function_nocfi() macros in the kernel
> code.

How invasive are the changes in clang 14 necessary to make CFI work?
Would it be possible to backport them to LLVM 13?

-Tom

> 
> The first two patches contain objtool support for CFI, the
> remaining patches change function declarations to use opaque
> types, fix type mismatch issues that confuse the compiler, and
> disable CFI where it can't be used.
> 
> You can also pull this series from
> 
>    https://github.com/samitolvanen/linux.git x86-cfi-v2
> 
> ---
> Changes in v2:
> - Dropped the first objtool patch as the warnings were fixed in
>    separate patches.
> 
> - Changed fix_cfi_relocs() in objtool to not rely on jump table
>    symbols, and to return an error if it can't find a relocation.
> 
> - Fixed a build issue with ASM_STACK_FRAME_NON_STANDARD().
> 
> - Dropped workarounds for inline assembly references to
>    address-taken static functions with CFI as this was fixed in
>    the compiler.
> 
> - Changed the C declarations of non-callable functions to use
>    opaque types and dropped the function_nocfi() patches.
> 
> - Changed ARCH_SUPPORTS_CFI_CLANG to depend on Clang >=14 for
>    the compiler fixes.
> 
> Kees Cook (2):
>    x86/extable: Do not mark exception callback as CFI
>    x86, relocs: Ignore __typeid__ relocations
> 
> Sami Tolvanen (12):
>    objtool: Add CONFIG_CFI_CLANG support
>    objtool: Add ASM_STACK_FRAME_NON_STANDARD
>    linkage: Add DECLARE_ASM_FUNC_SYMBOL
>    ftrace: Use an opaque type for functions not callable from C
>    lkdtm: Disable UNSET_SMEP with CFI
>    lkdtm: Use an opaque type for lkdtm_rodata_do_nothing
>    x86: Use an opaque type for functions not callable from C
>    x86/purgatory: Disable CFI
>    x86, module: Ignore __typeid__ relocations
>    x86, cpu: Use LTO for cpu.c with CFI
>    x86, kprobes: Fix optprobe_template_func type mismatch
>    x86, build: Allow CONFIG_CFI_CLANG to be selected
> 
>   arch/x86/Kconfig                      |  1 +
>   arch/x86/include/asm/ftrace.h         |  2 +-
>   arch/x86/include/asm/idtentry.h       | 10 +++---
>   arch/x86/include/asm/page_64.h        |  7 ++--
>   arch/x86/include/asm/paravirt_types.h |  3 +-
>   arch/x86/include/asm/processor.h      |  2 +-
>   arch/x86/include/asm/proto.h          | 25 ++++++-------
>   arch/x86/include/asm/uaccess_64.h     |  9 ++---
>   arch/x86/kernel/alternative.c         |  2 +-
>   arch/x86/kernel/ftrace.c              |  2 +-
>   arch/x86/kernel/kprobes/opt.c         |  4 +--
>   arch/x86/kernel/module.c              |  4 +++
>   arch/x86/kernel/paravirt.c            |  4 +--
>   arch/x86/kvm/emulate.c                |  4 +--
>   arch/x86/kvm/kvm_emulate.h            |  9 ++---
>   arch/x86/mm/extable.c                 |  1 +
>   arch/x86/power/Makefile               |  2 ++
>   arch/x86/purgatory/Makefile           |  2 +-
>   arch/x86/tools/relocs.c               |  7 ++++
>   arch/x86/xen/enlighten_pv.c           |  6 ++--
>   arch/x86/xen/xen-ops.h                | 10 +++---
>   drivers/misc/lkdtm/bugs.c             |  2 +-
>   drivers/misc/lkdtm/lkdtm.h            |  2 +-
>   drivers/misc/lkdtm/perms.c            |  2 +-
>   drivers/misc/lkdtm/rodata.c           |  2 +-
>   include/linux/ftrace.h                |  7 ++--
>   include/linux/linkage.h               | 13 +++++++
>   include/linux/objtool.h               |  6 ++++
>   tools/include/linux/objtool.h         |  6 ++++
>   tools/objtool/arch/x86/decode.c       | 16 +++++++++
>   tools/objtool/elf.c                   | 51 +++++++++++++++++++++++++++
>   tools/objtool/include/objtool/arch.h  |  3 ++
>   tools/objtool/include/objtool/elf.h   |  2 +-
>   33 files changed, 166 insertions(+), 62 deletions(-)
> 
> 
> base-commit: d5ae8d7f85b7f6f6e60f1af8ff4be52b0926fde1
> 

