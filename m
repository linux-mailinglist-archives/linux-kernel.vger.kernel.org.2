Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712C139C41C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFDXxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:53:52 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:41979 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhFDXxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:53:50 -0400
Received: by mail-pg1-f177.google.com with SMTP id r1so9075486pgk.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NNdIv1Q9mZxSjkjhRDb+rDB0M2eG3pxayo33UlZp4vY=;
        b=lZqKUeBTWKyFvDEHDx0B+i0pEmT99bstvbzdIYk8nYImpwyWbdJpbY5qXV+OFGPR2G
         gvE9/Ykn2RDbMIjRMSf9bFk8yfpbM0f/RTK8rNxGTPc3nTaSxVU/BfuvwP6G7ZPwKhFl
         OT2MCjWz9j9lOxwb1j/o++N1r8HavbE6ETPlqdCW4k8JC4r0K1c2Ko/lUZ2BgyN+ApXy
         ljfbEh2+rHRjiQ3vtClaaEhntWavyCt1o6apX1zj2xf0IgEVBID+ORGqNBEcZHF6D3TI
         9X/kQQ14frihONf1msrqUihWNhwj1Te2C475tV9atjr3n0/mylzMTf0WK0S52z8oLNTx
         7grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NNdIv1Q9mZxSjkjhRDb+rDB0M2eG3pxayo33UlZp4vY=;
        b=ZZmoWeLrUFZ/xyYYRLA5LkrXgjXA+ziUTTFTkziyIvyDR4ObA4qDfpEozfb+Qp3pHU
         NnKci9AH+EQ+37FpVjfEIKZJ1H6ZONx+BtjLBXmmeX+TOWjsdmXDD6GvJ/aEeeTvtA2X
         IAZ6Ix4cME5pJ9KotrMCDWvkLkluycwQ5KNmSFPcbqNkLjgaSNrC51tk24YhxxfUuySW
         82tAoCZm+whHV3HwhVXMStyDca5P6at0oZ7EAs4noNUq8nTJXnGIk6+J76BsVupp3Fk3
         sE87PBGBYXFKvBCH4+IloV53ZwlE2guEOjOudxjgJTdlvdBXKyPl3e+kynQSfR5L4AeQ
         TDYQ==
X-Gm-Message-State: AOAM531YQTG7SXbbaaUjQOnd+6z7FiJmA1SHPVdVivMZbhubf9ybJO3w
        V+UTbJUusX+c0kFcU1Z2+4bngw==
X-Google-Smtp-Source: ABdhPJxsoDT1Ur9b6iG87rFWYKvZ8gFBhkESrkbMwtBZIIVurxtE/XXcBCe6HxM9jTxR5n9qDyMt+Q==
X-Received: by 2002:a63:7e0a:: with SMTP id z10mr7159079pgc.12.1622850651840;
        Fri, 04 Jun 2021 16:50:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:dabb:6084:19a6:c9d5])
        by smtp.gmail.com with ESMTPSA id 23sm115825pjw.28.2021.06.04.16.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 16:50:51 -0700 (PDT)
Date:   Fri, 4 Jun 2021 16:50:46 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        rad@semihalf.com, upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210604235046.w3hazgcpsg4oefex@google.com>
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-04, 'Nick Desaulniers' via Clang Built Linux wrote:
>On Fri, Jun 4, 2021 at 1:50 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> (Manually replying to https://lore.kernel.org/lkml/CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com/)
>>
>> Hi Peter,
>> We're also tracking 2 recent regressions that look like they've come from this
>> patch.
>>
>> https://github.com/ClangBuiltLinux/linux/issues/1384
>> https://github.com/ClangBuiltLinux/linux/issues/1388
>>
>> (Both in linux-next at the moment).
>>
>> The first, it looks like a boot failure. The second is a warning from the
>> linker on a kernel module; even readelf seems unhappy with the results of the
>> output from objtool.
>>
>> I can more easily reproduce the latter, so I'm working on getting a smaller
>> reproducer. I'll let you know when I have it, but wanted to report it ASAP.
>
>Sent a pretty big attachment, privately.  I was able to capture the
>before/after with:
>
>$ $ echo 'CONFIG_GCOV_KERNEL=n
>CONFIG_KASAN=n
>CONFIG_LTO_CLANG_THIN=y' >allmod.config
>$ OBJTOOL_ARGS="--backup" make -kj"$(nproc)" KCONFIG_ALLCONFIG=1
>LLVM=1 LLVM_IAS=1 all
>
>It looks like
>
>$ ./tools/objtool/objtool orc generate  --module  --no-fp
>--no-unreachable  --retpoline  --uaccess  --mcount
>drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o; ld.lld -r -m elf_x86_64
>-plugin-opt=-code-model=kernel -plugin-opt=-stack-alignment=8
>--thinlto-cache-dir=.thinlto-cache -mllvm -import-instr-limit=5
>-plugin-opt=-warn-stack-size=2048 --build-id=sha1  -T
>scripts/module.lds -o drivers/gpu/drm/amd/amdgpu/amdgpu.ko
>drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o
>drivers/gpu/drm/amd/amdgpu/amdgpu.mod.o
>
>is producing the linker error:
>
>ld.lld: error: drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o:
>SHT_SYMTAB_SHNDX has 79581 entries, but the symbol table associated
>has 79582
>
>Readelf having issues with the output:
>$ readelf -s amdgpu.lto.o.orig
><works fine>
>$ readelf -s amdgpu.lto.o
>readelf: Error: Reading 73014451695 bytes extends past end of file for
>string table
>$ llvm-readelf -s amdgpu.lto.o
>llvm-readelf: error: 'amdgpu.lto.o': unable to continue dumping, the
>file is corrupt: section table goes past the end of file
>
>`file` having issues:
>$ file drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o
>drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o: ELF 64-bit LSB relocatable,
>x86-64, version 1 (SYSV), no section header
>
>for comparison:
>$ file ./drivers/spi/spi-ath79.lto.o
>./drivers/spi/spi-ath79.lto.o: ELF 64-bit LSB relocatable, x86-64,
>version 1 (SYSV), not stripped

tools/objtool/elf.c:elf_add_symbol may not update .symtab_shndx .
Speaking of llvm-objcopy, it finalizes the content of .symtab_shndx when .symtab
is finalized. objtool may want to adopt a similar approach.

read_symbols searches for the section ".symtab_shndx". It'd be better to
use the section type SHT_SYMTAB_SHNDX.
