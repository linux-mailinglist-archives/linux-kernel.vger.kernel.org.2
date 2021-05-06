Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14903375A0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhEFSQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhEFSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:16:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91748C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 11:15:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b7so8267798ljr.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvX/ivL7N3DqyFpAsZ+ComjXBki6wX2A4dJqbWfCdxQ=;
        b=lCSZ0VCXTz8YNEl+4x/RUdDW95uH5gW6yNZxvzjFKTc/Y4nfqjK6i2mrFFOCZYBnu5
         TWDLN8e42zkgB6RVPl0Zr5RVcQYRnfQSnWwLa+9+vUOLncN3uE19BJG+BO4IJsIIC2Sg
         MyFLF4cA9cQqOxPuT/AC0Bl2TMm3p9zUIbw83+9siHB7tZs6aybHnRef2vrQJNiSHX31
         QoPm0ZZAZIMLSYz7DOA5svquKx0ht9tzQ+8LiXR2ls6L42+CHodNqZtr2AW0bznJKMxE
         cvhm9SKVfaOIkQcB5Z3mQuJNMm19O0q3RpmPr3JSMFbRRkFEPNDmRIl24n9ixythJ/aF
         2fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvX/ivL7N3DqyFpAsZ+ComjXBki6wX2A4dJqbWfCdxQ=;
        b=tvyPjlXv1Z4JvXFElTdufUkN7M6jezrkBwwjVABxqPvYnghuSwB8cR/EaEShQPyiXO
         KJDIebUuCCyPeyaoezNateZLOXyBfwpJK0HqUF6GrHPfQf+q6B/4KCUbi360dUQa2hk+
         DjREXyCc1bMX12qa8kvTahyXDxhrRHliCyzZWLQevLCPI4/f/h/kGoGg5GPsEthH39Rk
         PLfllEf158+Lblb7L3yPBjmMos/pNgxTtGcpKKaf/+FYJTYKGMb8oUqze13UH2Z5nZPL
         7WEdShAII3pIcnbT1V64m/ESVwloXR4VXEigMiLEzlJal6bFK6nGQaB1acZAf/iCdNfW
         nYwA==
X-Gm-Message-State: AOAM5331F+clPvN2mAPY9bVxkRFqVyT+fgCrWtzzHIUfkKYUIJ47gE/w
        VLCd7vZVHv37UPUWnxACDBEEmB3EGOtFZ3JhvNo6JA==
X-Google-Smtp-Source: ABdhPJxTqUMAxyk1yYAOiEDd9G6SOS2+SnuK/Fo8ht7+qtGf5OSORlH+ikZhAVl1WQDkMffSYdD5aL1ZfqdakOB3cn8=
X-Received: by 2002:a2e:8e3a:: with SMTP id r26mr4517995ljk.244.1620324941858;
 Thu, 06 May 2021 11:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210506001410.1026691-1-nathan@kernel.org>
In-Reply-To: <20210506001410.1026691-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 May 2021 11:15:30 -0700
Message-ID: <CAKwvOd=SnnzVt7mpKnLOW_zwcwrmzhBSuwQ+--BGrOhga86M2w@mail.gmail.com>
Subject: Re: [PATCH] vmlinux.lds.h: Handle decrypted data section with !SMP
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel test robot <lkp@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 5:28 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> With x86_64_defconfig and the following configs, there is an orphan
> section warning:
>
> CONFIG_SMP=n
> CONFIG_AMD_MEM_ENCRYPT=y
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_KVM=y
> CONFIG_PARAVIRT=y
>
> ld: warning: orphan section `.data..decrypted' from `arch/x86/kernel/cpu/vmware.o' being placed in section `.data..decrypted'
> ld: warning: orphan section `.data..decrypted' from `arch/x86/kernel/kvm.o' being placed in section `.data..decrypted'
>
> These sections are created with DEFINE_PER_CPU_DECRYPTED, which
> ultimately turns into __PCPU_ATTRS, which in turn has a section
> attribute with a value of PER_CPU_BASE_SECTION + the section name. When
> CONFIG_SMP is not set, the base section is .data and that is not
> currently handled in any linker script.
>
> Add .data..decrypted to PERCPU_DECRYPTED_SECTION, which is included in
> PERCPU_INPUT -> PERCPU_SECTION, which is include in the x86 linker
> script when either CONFIG_X86_64 or CONFIG_SMP is unset, taking care of
> the warning.
>
> Fixes: ac26963a1175 ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1360
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch; LGTM.

Reviewed-by:Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com> # build

> ---
>
> I took the simple fix route with this patch since I highly doubt someone
> is actually running a CONFIG_AMD_MEM_ENCRYPT=y + CONFIG_SMP=n kernel. If
> this section should actually be in .data, I can respin.
>
>  include/asm-generic/vmlinux.lds.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 40a9c101565e..17325416e2de 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -960,6 +960,7 @@
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  #define PERCPU_DECRYPTED_SECTION                                       \
>         . = ALIGN(PAGE_SIZE);                                           \
> +       *(.data..decrypted)                                             \
>         *(.data..percpu..decrypted)                                     \
>         . = ALIGN(PAGE_SIZE);
>  #else
>
> base-commit: 8404c9fbc84b741f66cff7d4934a25dd2c344452
> --
> 2.31.1.442.g7e39198978
>


-- 
Thanks,
~Nick Desaulniers
