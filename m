Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F3326C90
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 10:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhB0Jui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 04:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhB0Juf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 04:50:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BE1764ED5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614419394;
        bh=QnCKsmX1z+jo5IvDvC2SRFzXJdLgt9XfSJ423kUZSFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A9aZzVI1Rt+R7sLFk7A4CWh68L2/CbKXNmqB+i55w+1FDvnGh/MtfDUQe9/HQqFgC
         L8+84jfTbsuJk5O63BewbLCU8xLhi1ghr2Lz7awL8Oz9XxIdbkoONOvIuxus8OjpAL
         sm0LoNyU/NxotiXKxcTcpfTSJvjegoNzQ2S8gj0taHjnfYXzpRKmNMlFSOzYsyt0Uh
         iYKLWq4KZze0BVEsdok6/Ppb8wwd2qkpG3+kUnUZRMptuMmU0TBcVFXTMZ4E2TMo2v
         xu2x77wZNQwLKD2fFVj+fu8LR40ldBRX6RUy4yKI/UYtbbhtECW632CdXb9udb9RVZ
         UhhsLwi2JOduA==
Received: by mail-oi1-f172.google.com with SMTP id l64so12544322oig.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 01:49:54 -0800 (PST)
X-Gm-Message-State: AOAM530okQmbyyu12PrlTgOPY7T487QdVt9wkhwXKeRjvDNZsPBq0iLC
        syZxMkE6u7DksbclyOzYkVoTI9kTuIPhbrM/oco=
X-Google-Smtp-Source: ABdhPJw+kOn7l9nrSQGnFuHQpOC8GhLagXYoKOy+RHRScC6OEHvaA/pQOPFe4EzgqDRKim8+dMhHaLScWNgRsvfoguo=
X-Received: by 2002:aca:c381:: with SMTP id t123mr3973837oif.4.1614419393843;
 Sat, 27 Feb 2021 01:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <20210226211323.arkvjnr4hifxapqu@google.com>
In-Reply-To: <20210226211323.arkvjnr4hifxapqu@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 27 Feb 2021 10:49:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
Message-ID: <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Fangrui Song <maskray@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:13 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> For folks who are interested in --gc-sections on metadata sections,
> I want to bring you awareness of the implication of __start_/__stop_ symbols and C identifier name sections.
> You can see https://github.com/ClangBuiltLinux/linux/issues/1307 for a summary.
> (Its linked blog article has some examples.)
>
> In the kernel linker scripts, most C identifier name sections begin with double-underscore __.
> Some are surrounded by `KEEP(...)`, some are not.
>
> * A `KEEP` keyword has GC root semantics and makes ld --gc-sections ineffectful.
> * Without `KEEP`, __start_/__stop_ references from a live input section
>    can unnecessarily retain all the associated C identifier name input
>    sections. The new ld.lld option `-z start-stop-gc` can defeat this rule.
>
> As an example, a __start___jump_table reference from a live section
> causes all `__jump_table` input section to be retained, even if you
> change `KEEP(__jump_table)` to `(__jump_table)`.
> (If you change the symbol name from `__start_${section}` to something
> else (e.g. `__start${section}`), the rule will not apply.)

I suspect the __start_* symbols are cargo-culted by many developers
copying stuff around between kernel linker scripts, that's certainly how I
approach making changes to it normally without a deeper understanding
of how the linker actually works or what the different bits of syntax mean
there.

I see the original vmlinux.lds linker script showed up in linux-2.1.23, and
it contained

+  . = ALIGN(16);               /* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;       /* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;

originally for arch/sparc, and shortly afterwards for i386. The magic
__ex_table section was first used in linux-2.1.7 without a linker
script. It's probably a good idea to try cleaning these up by using
non-magic start/stop symbols for all sections, and relying on KEEP()
instead where needed.

> There are a lot of KEEP usage. Perhaps some can be dropped to facilitate
> ld --gc-sections.

I see a lot of these were added by Nick Piggin (added to Cc) in this commit:

commit 266ff2a8f51f02b429a987d87634697eb0d01d6a
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Wed May 9 22:59:58 2018 +1000

    kbuild: Fix asm-generic/vmlinux.lds.h for LD_DEAD_CODE_DATA_ELIMINATION

    KEEP more tables, and add the function/data section wildcard to more
    section selections.

    This is a little ad-hoc at the moment, but kernel code should be moved
    to consistently use .text..x (note: double dots) for explicit sections
    and all references to it in the linker script can be made with
    TEXT_MAIN, and similarly for other sections.

    For now, let's see if major architectures move to enabling this option
    then we can do some refactoring passes. Otherwise if it remains unused
    or superseded by LTO, this may not be required.

    Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

which apparently was intentionally cautious.

Unlike what Nick expected in his submission, I now think the annotations
will be needed for LTO just like they are for --gc-sections.

      Arnd
