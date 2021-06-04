Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B2D39C3E3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhFDXa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:30:28 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:41815 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhFDXa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:30:26 -0400
Received: by mail-lf1-f47.google.com with SMTP id v8so16417986lft.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7anXLdFX+ZgbpqbGjfcU0VDRvEPB4cOmvxPC9Qde3gE=;
        b=dg5Sc1Fgf6UKGlFgha4QJpSOVLUwcpm0SuYUIoFeBNUr40YIUsrCYlLfrq3CXSeQsz
         rD+PJqCu2j6Huv/sftQaU4j9AfEEopEGQQOG6dooBYwe9Sg9z32bbH8NZVR9qpQwPWMX
         vsBbL3ztFYzzImuZOgHqF/vNdo9zz8fxUdoQKeNgC56uFXRWdmogwc1EC1SzWkGNYC/s
         DYiYRdnDLY5MNmGdtVb8WUx4kx9tBmb8NsZIV52cbe2bf8CsYHjI/OQubE+FZU9qc62Z
         T0OGMUNP3/x3cz7AUWWUnfsnkoeU/2AtbyTaDREPOjaLBtW2454sl4pnOqCEtnCVHUTg
         2mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7anXLdFX+ZgbpqbGjfcU0VDRvEPB4cOmvxPC9Qde3gE=;
        b=guSgfURNPYETF3KzbiZfeT2UoW851LHyD4PiaRY8SNXMj5U08k42lY1XTf3MrCFUtT
         apXU+DiLI4/p/PbEOM8dEFrx6DaLoDKwBYA4921lTrcXoHExkO+btasOC/P4KM8UuJ3+
         AaJV8DsP8TPwpAUpE4YsCYwevYUPpLQlTtjDOI6+Dvx2QU3nFXwERShI5iGtREZEmbcy
         9+Mb+kJeBN/+dIz0hnCyD5iYKkwI3I8QkZq+8PsoRwZIYvmzQvHXW7+8yhkzuMXqRwP5
         GVm8gXrFHWRgAkIUrYBsjdiGI9/jMs+ExoU2qdj+RTaUbRw6PemWQd+jdqkaRdAQdcNj
         xzzg==
X-Gm-Message-State: AOAM531u6kBODUD8Wm4hu1w1IK71xZJpUU0gu5R4Gp9BDSsbRVe8H8Df
        RTYrL1q3KRAtJ6NgLmajY2GS0aAu1p8vqWlspPjPG7mEMBvPzA==
X-Google-Smtp-Source: ABdhPJw3yQaZ7dKyZwmDS53ELm0vG7Glph1hP/DO/n9yzyGDTHVYAiSpgqO03vCHNRJxz+gGO3G+WcQxpM1mGRuSiCc=
X-Received: by 2002:a19:f706:: with SMTP id z6mr4188361lfe.122.1622849258457;
 Fri, 04 Jun 2021 16:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
In-Reply-To: <20210604205018.2238778-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 4 Jun 2021 16:27:26 -0700
Message-ID: <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        rad@semihalf.com, upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 1:50 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> (Manually replying to https://lore.kernel.org/lkml/CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com/)
>
> Hi Peter,
> We're also tracking 2 recent regressions that look like they've come from this
> patch.
>
> https://github.com/ClangBuiltLinux/linux/issues/1384
> https://github.com/ClangBuiltLinux/linux/issues/1388
>
> (Both in linux-next at the moment).
>
> The first, it looks like a boot failure. The second is a warning from the
> linker on a kernel module; even readelf seems unhappy with the results of the
> output from objtool.
>
> I can more easily reproduce the latter, so I'm working on getting a smaller
> reproducer. I'll let you know when I have it, but wanted to report it ASAP.

Sent a pretty big attachment, privately.  I was able to capture the
before/after with:

$ $ echo 'CONFIG_GCOV_KERNEL=n
CONFIG_KASAN=n
CONFIG_LTO_CLANG_THIN=y' >allmod.config
$ OBJTOOL_ARGS="--backup" make -kj"$(nproc)" KCONFIG_ALLCONFIG=1
LLVM=1 LLVM_IAS=1 all

It looks like

$ ./tools/objtool/objtool orc generate  --module  --no-fp
--no-unreachable  --retpoline  --uaccess  --mcount
drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o; ld.lld -r -m elf_x86_64
-plugin-opt=-code-model=kernel -plugin-opt=-stack-alignment=8
--thinlto-cache-dir=.thinlto-cache -mllvm -import-instr-limit=5
-plugin-opt=-warn-stack-size=2048 --build-id=sha1  -T
scripts/module.lds -o drivers/gpu/drm/amd/amdgpu/amdgpu.ko
drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o
drivers/gpu/drm/amd/amdgpu/amdgpu.mod.o

is producing the linker error:

ld.lld: error: drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o:
SHT_SYMTAB_SHNDX has 79581 entries, but the symbol table associated
has 79582

Readelf having issues with the output:
$ readelf -s amdgpu.lto.o.orig
<works fine>
$ readelf -s amdgpu.lto.o
readelf: Error: Reading 73014451695 bytes extends past end of file for
string table
$ llvm-readelf -s amdgpu.lto.o
llvm-readelf: error: 'amdgpu.lto.o': unable to continue dumping, the
file is corrupt: section table goes past the end of file

`file` having issues:
$ file drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o
drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o: ELF 64-bit LSB relocatable,
x86-64, version 1 (SYSV), no section header

for comparison:
$ file ./drivers/spi/spi-ath79.lto.o
./drivers/spi/spi-ath79.lto.o: ELF 64-bit LSB relocatable, x86-64,
version 1 (SYSV), not stripped
-- 
Thanks,
~Nick Desaulniers
