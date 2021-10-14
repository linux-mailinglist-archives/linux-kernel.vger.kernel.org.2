Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8342E354
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhJNViI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhJNViG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:38:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B9C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:36:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so7885538pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ucthCVLQbHs9EV1Uw1Bv+F6lYLHxvFpuoWX8HwMgpt8=;
        b=VQQ5XftKFdJxIqUHw8qRFJat71Dbqr2AD8qwnlFgMvFJilatzmha8I6vmL6yvrzpkP
         hvXQ2mD6ttiO3AiCefR9vWjBp4Q7T/wGfxf4JQjnzp3eY+AnFAfleMbYmsvVYJNrXhMf
         F+Jl/P5vsIdt4melRbvlQ+FV9+ngeKkjBbp7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ucthCVLQbHs9EV1Uw1Bv+F6lYLHxvFpuoWX8HwMgpt8=;
        b=qvDRNwA7gK+KNpNSxZIjEUDXks1Jh8oJ5QkQdGqFbF8VR/hExmrkvzPh+hjCxJpDdu
         knMBgyvB0mrqfe+IBow8PMaAr4TR4SxLy8Gy6CQejf/Y33/qQSx8/gtX/k96JXeej4cC
         0uUWDmJyJUm9FAgwSY3NmMm8/UZEe7EtilPtUUosyhjBLiyJhTx3Z0fxMQRKnq18aaU1
         MlgW34nzmZS5tpUXi5UlKDK4KMEhLS2f2AMAa7FKKc6XvGdtx4c9m5M14aRozznvN/PO
         F/1hIFpxisJONKhA77rXvuj7RgFzEK6z8/ValnVyb7vk2pieD1J7D336SuLskDxdjomg
         c0dQ==
X-Gm-Message-State: AOAM533OJM9/KNGnnQhJ0MfTWtcv5mJ1Lknd3hGH+fPe0eMJZQxKaWD0
        pu+hwKSJ/SnrlvM+ip8L5JhXUg==
X-Google-Smtp-Source: ABdhPJw1rTBhUzGBU+OCQNwxLaPgrU3yVEgNpct3REqnkn5dEyRgg6pBD5Hi+HUutoGMqi2zC8/tfg==
X-Received: by 2002:a17:90b:4ac1:: with SMTP id mh1mr8767562pjb.144.1634247360274;
        Thu, 14 Oct 2021 14:36:00 -0700 (PDT)
Received: from localhost ([2001:4479:e300:600:4901:2fb9:ed97:3a3e])
        by smtp.gmail.com with ESMTPSA id k7sm3292676pfk.59.2021.10.14.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 14:35:59 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/13] Fix LKDTM for PPC64/IA64/PARISC
In-Reply-To: <cover.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
Date:   Fri, 15 Oct 2021 08:35:56 +1100
Message-ID: <87a6jb47cz.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> PPC64/IA64/PARISC have function descriptors. LKDTM doesn't work
> on those three architectures because LKDTM messes up function
> descriptors with functions.

Just to nitpick, it's powerpc 64-bit using the ELFv1 ABI. [1]

The ELFv2 ABI [2] doesn't use function descriptors. (ELFv2 is used
primarily for ppc64le, but some people like musl support it for BE as
well.)

This doesn't affect the correctness or desirability of your changes, it
was just bugging me when I was reading the commit messages :-)

Kind regards,
Daniel

[1] See e.g. https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.html
[2] https://openpowerfoundation.org/wp-content/uploads/2016/03/ABI64BitOpenPOWERv1.1_16July2015_pub4.pdf


> This series does some cleanup in the three architectures and
> refactors function descriptors so that it can then easily use it
> in a generic way in LKDTM.
>
> Patch 8 is not absolutely necessary but it is a good trivial cleanup.
>
> Changes in v2:
> - Addressed received comments
> - Moved dereference_[kernel]_function_descriptor() out of line
> - Added patches to remove func_descr_t and func_desc_t in powerpc
> - Using func_desc_t instead of funct_descr_t
> - Renamed HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR to HAVE_FUNCTION_DESCRIPTORS
> - Added a new lkdtm test to check protection of function descriptors
>
> Christophe Leroy (13):
>   powerpc: Move 'struct ppc64_opd_entry' back into asm/elf.h
>   powerpc: Rename 'funcaddr' to 'addr' in 'struct ppc64_opd_entry'
>   powerpc: Remove func_descr_t
>   powerpc: Prepare func_desc_t for refactorisation
>   ia64: Rename 'ip' to 'addr' in 'struct fdesc'
>   asm-generic: Use HAVE_FUNCTION_DESCRIPTORS to define associated stubs
>   asm-generic: Define 'func_desc_t' to commonly describe function
>     descriptors
>   asm-generic: Refactor dereference_[kernel]_function_descriptor()
>   lkdtm: Force do_nothing() out of line
>   lkdtm: Really write into kernel text in WRITE_KERN
>   lkdtm: Fix lkdtm_EXEC_RODATA()
>   lkdtm: Fix execute_[user]_location()
>   lkdtm: Add a test for function descriptors protection
>
>  arch/ia64/include/asm/elf.h              |  2 +-
>  arch/ia64/include/asm/sections.h         | 25 ++-------
>  arch/ia64/kernel/module.c                |  6 +--
>  arch/parisc/include/asm/sections.h       | 17 +++---
>  arch/parisc/kernel/process.c             | 21 --------
>  arch/powerpc/include/asm/code-patching.h |  2 +-
>  arch/powerpc/include/asm/elf.h           |  6 +++
>  arch/powerpc/include/asm/sections.h      | 30 ++---------
>  arch/powerpc/include/asm/types.h         |  6 ---
>  arch/powerpc/include/uapi/asm/elf.h      |  8 ---
>  arch/powerpc/kernel/module_64.c          | 38 +++++--------
>  arch/powerpc/kernel/signal_64.c          |  8 +--
>  drivers/misc/lkdtm/core.c                |  1 +
>  drivers/misc/lkdtm/lkdtm.h               |  1 +
>  drivers/misc/lkdtm/perms.c               | 68 ++++++++++++++++++++----
>  include/asm-generic/sections.h           | 13 ++++-
>  include/linux/kallsyms.h                 |  2 +-
>  kernel/extable.c                         | 23 +++++++-
>  18 files changed, 138 insertions(+), 139 deletions(-)
>
> -- 
> 2.31.1
