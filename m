Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF363B7920
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhF2UOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbhF2UOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:14:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9F6C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:11:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso3217856pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QJc0mb+x40gFEPz1haa7djFZQRZCa6L/f14sJrf1KUw=;
        b=G0/YNUlI2YR+P1RnE/EF4YyNQGVOaXB1sykHkUh9Op2bVh4cW2HQke9UVXrATKfYW4
         lVqI6S4EYCly1yK/bZQBX8Xi4P5W8PJ0BXqYe6goXrmViCUrysW4zDy8YdDgfhIblpAV
         xzvOFYFUR/ePQAEAQK+jjqJUWGjssrrKjrD5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QJc0mb+x40gFEPz1haa7djFZQRZCa6L/f14sJrf1KUw=;
        b=SII4giEqAqDTq2QlSXlcUlS3aZ9WCfVJ3Eim0lqoPPln0BhzMyjwfYSoV4X35+Zjpm
         RagfovtvT3VE3N+iajoFLGfReFQ4iFcQThKu1TE4vw0qmHRs80LwBaoX1EAf2ez6IGz0
         J55Kab5Q3Udjb9PPgb8YBDEimgjV8ctyTJqPKAgFYEd6jaBTF57NViFPmvdA7kxqmuuA
         NahytFpY5vaNQUQNhhmDfO6mIgOi0svK8FExh2YabJecCKtI+iOXf6cvjYEqMoDHvedt
         7g8uUf05WapRNKfuuJpTOYcPWX5I39RwpMN2xb/5HoYzLJTetSI0p9Tqam0qR+l0oT+g
         J2zw==
X-Gm-Message-State: AOAM532MG3gmPGQXcphv1zHwBd7Utb1aLAgwIj1PR+LiRzn+jbP+9D7B
        zHcNaQRcLspg1E5GdbIYFhUnSA==
X-Google-Smtp-Source: ABdhPJxLm1wzWWH23kVF9TrURUddK+O3UE3rvnAkA1CtSXgQB12u+5lqhISA9ViJ9JoMfDJ8DFi3lw==
X-Received: by 2002:a17:90a:4584:: with SMTP id v4mr34943896pjg.77.1624997512810;
        Tue, 29 Jun 2021 13:11:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x4sm9584715pgr.40.2021.06.29.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:11:52 -0700 (PDT)
Date:   Tue, 29 Jun 2021 13:11:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
Message-ID: <202106291307.0DF14F9161@keescook>
References: <202106281231.E99B92BB13@keescook>
 <20210629131400.GA24514@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629131400.GA24514@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 02:14:00PM +0100, Mark Rutland wrote:
> Hi Kees,
> 
> On Mon, Jun 28, 2021 at 12:32:24PM -0700, Kees Cook wrote:
> > Hi Linus,
> > 
> > Please pull these Clang feature updates for v5.14-rc1.
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:
> > 
> >   Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.14-rc1
> > 
> > for you to fetch changes up to 6a0544606ec7f03e4a2534c87ea989de4bac41ae:
> > 
> >   pgo: rectify comment to proper kernel-doc syntax (2021-06-28 12:10:31 -0700)
> > 
> > ----------------------------------------------------------------
> > Clang feature updates for v5.14-rc1
> > 
> > The big addition for this merge window is the core support for Clang's
> > Profile Guided Optimization, which lets Clang build the kernel for
> > improved performance when running specific kernel workloads. This
> > currently covers only vmlinux, but module support is under active
> > development. (Sami Tolvanen, Bill Wendling, Kees Cook, Jarmo Tiitto,
> > Lukas Bulwahn)
> 
> I thought the PGO stuff was on hold given Peter had open concerns, e.g.
> 
> https://lore.kernel.org/r/20210614154639.GB68749@worktop.programming.kicks-ass.net
> 
> ... and there didn't seem to be a strong conclusion to the contrary.

Hi! Whoops, I think you weren't CCed on the later threads over noinstr:
https://lore.kernel.org/lkml/YNGQV09E9xAvvppO@hirez.programming.kicks-ass.net/

I understood that as the blocker for Peter from the earlier thread.

> 
> > Added CC_HAS_NO_PROFILE_FN_ATTR in preparation for PGO support in
> > the face of the noinstr attribute, paving the way for PGO and fixing
> > GCOV. (Nick Desaulniers)
> > 
> > x86_64 LTO coverage is expaned to 32-bit x86. (Nathan Chancellor)
> > 
> > Small fixes to CFI. (Mark Rutland, Nathan Chancellor)
> 
> FWIW, all the rest of this looks good to me.

Thanks!

-Kees

> 
> Thanks,
> Mark.
> 
> > 
> > ----------------------------------------------------------------
> > Bill Wendling (1):
> >       pgo: rename the raw profile file to vmlinux.profraw
> > 
> > Jarmo Tiitto (2):
> >       pgo: Limit allocate_node() to vmlinux sections
> >       pgo: Fix sleep in atomic section in prf_open()
> > 
> > Kees Cook (2):
> >       MAINTAINERS: Expand and relocate PGO entry
> >       pgo: Clean up prf_open() error paths
> > 
> > Lukas Bulwahn (1):
> >       pgo: rectify comment to proper kernel-doc syntax
> > 
> > Mark Rutland (1):
> >       CFI: Move function_nocfi() into compiler.h
> > 
> > Nathan Chancellor (2):
> >       MAINTAINERS: Add Clang CFI section
> >       x86, lto: Enable Clang LTO for 32-bit as well
> > 
> > Nick Desaulniers (3):
> >       compiler_attributes.h: define __no_profile, add to noinstr
> >       compiler_attributes.h: cleanups for GCC 4.9+
> >       Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR
> > 
> > Sami Tolvanen (1):
> >       pgo: Add Clang's Profile Guided Optimization infrastructure
> > 
> >  Documentation/dev-tools/index.rst     |   1 +
> >  Documentation/dev-tools/pgo.rst       | 127 +++++++++++
> >  MAINTAINERS                           |  25 ++
> >  Makefile                              |   3 +
> >  arch/Kconfig                          |   8 +
> >  arch/arm64/Kconfig                    |   1 +
> >  arch/arm64/include/asm/compiler.h     |  16 ++
> >  arch/arm64/include/asm/memory.h       |  16 --
> >  arch/s390/Kconfig                     |   1 +
> >  arch/x86/Kconfig                      |   6 +-
> >  arch/x86/boot/Makefile                |   1 +
> >  arch/x86/boot/compressed/Makefile     |   1 +
> >  arch/x86/crypto/Makefile              |   3 +
> >  arch/x86/entry/vdso/Makefile          |   1 +
> >  arch/x86/kernel/Makefile              |   3 +
> >  arch/x86/kernel/vmlinux.lds.S         |   2 +
> >  arch/x86/platform/efi/Makefile        |   1 +
> >  arch/x86/purgatory/Makefile           |   1 +
> >  arch/x86/realmode/rm/Makefile         |   1 +
> >  arch/x86/um/vdso/Makefile             |   1 +
> >  drivers/firmware/efi/libstub/Makefile |   1 +
> >  include/asm-generic/vmlinux.lds.h     |  32 +++
> >  include/linux/compiler.h              |  10 +
> >  include/linux/compiler_attributes.h   |  19 +-
> >  include/linux/compiler_types.h        |   2 +-
> >  include/linux/mm.h                    |  10 -
> >  init/Kconfig                          |   3 +
> >  kernel/Makefile                       |   1 +
> >  kernel/gcov/Kconfig                   |   1 +
> >  kernel/pgo/Kconfig                    |  37 +++
> >  kernel/pgo/Makefile                   |   5 +
> >  kernel/pgo/fs.c                       | 413 ++++++++++++++++++++++++++++++++++
> >  kernel/pgo/instrument.c               | 188 ++++++++++++++++
> >  kernel/pgo/pgo.h                      | 211 +++++++++++++++++
> >  scripts/Makefile.lib                  |  10 +
> >  35 files changed, 1130 insertions(+), 32 deletions(-)
> >  create mode 100644 Documentation/dev-tools/pgo.rst
> >  create mode 100644 kernel/pgo/Kconfig
> >  create mode 100644 kernel/pgo/Makefile
> >  create mode 100644 kernel/pgo/fs.c
> >  create mode 100644 kernel/pgo/instrument.c
> >  create mode 100644 kernel/pgo/pgo.h
> > 
> > -- 
> > Kees Cook
> 
> -- 
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210629131400.GA24514%40C02TD0UTHF1T.local.

-- 
Kees Cook
