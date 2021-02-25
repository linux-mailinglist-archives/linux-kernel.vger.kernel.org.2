Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43003325142
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBYOHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhBYOH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:07:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1672664F11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614262005;
        bh=0sjikrwzMaPzLwlQVzVdjhVuB/wHbvv4ywEq3KaB7ho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PGJl+jt4MdkT/HYamMwOlW0AgFSV/58Hy/+P56aC82O4Y/lFuvDXsUEG78hYDdpsf
         Xgk0mv4lUY42beMHV7b0LKndq3jjCfW1zYOv/tzMiXBoF2nTFkrs6EjnSnslPrUXIJ
         COEreQQ7fVTM/QBo0TBixDuRsXkR0UiIjbReWg5GZaXeSkO1Y3uoDgcIs0X8LNKn9R
         LDm4pO9AlPgbFH0tMqQpj7waotNJ/XnjAjjilaJO9c0swJ9hndY24tiu1Ww3pBxY/Q
         f+WvZ7zm4jfQfzTaIh1m6fdDh00TZJfeRF6DCRYrmQ/Biym3Ulghk593gavpkNGnvA
         v8mK88+CCFmQA==
Received: by mail-ot1-f47.google.com with SMTP id b8so5736327oti.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:06:45 -0800 (PST)
X-Gm-Message-State: AOAM531lrfryFrUzSTB07Dtem9CiQCUyN2oBT/4DPENUpYqNrZOkUtO3
        BDMvbDH0Jb05Mpmd2JFWRT1Bg9qDoZNr6dsHjwM=
X-Google-Smtp-Source: ABdhPJxdQP5lt28Fr/qiSQBFp+gFXT8m/2LNqM9368PhfyJKaPmxkcUSlzQTeNPJHxfcGaCOYRzzB7tfNTaI79PjjNU=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr2415875otq.210.1614262004172;
 Thu, 25 Feb 2021 06:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20210225133808.2188581-1-arnd@kernel.org> <60989b76-1ae6-6be3-0277-df9f0cc8dc3e@redhat.com>
In-Reply-To: <60989b76-1ae6-6be3-0277-df9f0cc8dc3e@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Feb 2021 15:06:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0W5F14uW+0jqkNAxcXfODhK9_1L-DXnC_h2yrev13aAA@mail.gmail.com>
Message-ID: <CAK8P3a0W5F14uW+0jqkNAxcXfODhK9_1L-DXnC_h2yrev13aAA@mail.gmail.com>
Subject: Re: [PATCH] memblock: fix section mismatch warning
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Aslan Bakirov <aslan@fb.com>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 2:47 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.02.21 14:38, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The inlining logic in clang-13 is rewritten to often not inline
> > some functions that were inlined by all earlier compilers.
> >
> > In case of the memblock interfaces, this exposed a harmless bug
> > of a missing __init annotation:
> >
> > WARNING: modpost: vmlinux.o(.text+0x507c0a): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
> > The function memblock_bottom_up() references
> > the variable __meminitdata memblock.
> > This is often because memblock_bottom_up lacks a __meminitdata
> > annotation or the annotation of memblock is wrong.
> >
> > Interestingly, these annotations were present originally, but got removed
> > with the explanation that the __init annotation prevents the function
> > from getting inlined. I checked this again and found that while this
> > is the case with clang, gcc (version 7 through 10, did not test others)
> > does inline the functions regardless.
>
> Did I understand correctly, that with this change it will not get
> inlined with any version of clang? Maybe __always_inline is more
> appropriate then.
>
> (I don't see why to not inline that function, but I am obviously not a
> compiler person :) )

Looking at the assembler output in the arm64 build that triggered the
warning, I see this code:

0000000000000a40 <memblock_bottom_up>:
 a40:   55                      push   %rbp
 a41:   48 89 e5                mov    %rsp,%rbp
 a44:   41 56                   push   %r14
 a46:   53                      push   %rbx
 a47:   e8 00 00 00 00          call   a4c <memblock_bottom_up+0xc>
                        a48: R_X86_64_PLT32     __sanitizer_cov_trace_pc-0x4
 a4c:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                        a4f: R_X86_64_32S       memblock
 a53:   e8 00 00 00 00          call   a58 <memblock_bottom_up+0x18>
                        a54: R_X86_64_PLT32     __asan_load1_noabort-0x4
 a58:   44 0f b6 35 00 00 00    movzbl 0x0(%rip),%r14d        # a60
<memblock_bottom_up+0x20>
 a5f:   00
                        a5c: R_X86_64_PC32      memblock-0x4
 a60:   bf 02 00 00 00          mov    $0x2,%edi
 a65:   44 89 f6                mov    %r14d,%esi
 a68:   e8 00 00 00 00          call   a6d <memblock_bottom_up+0x2d>
                        a69: R_X86_64_PLT32
__sanitizer_cov_trace_const_cmp1-0x4
 a6d:   41 83 fe 01             cmp    $0x1,%r14d
 a71:   77 20                   ja     a93 <memblock_bottom_up+0x53>
 a73:   e8 00 00 00 00          call   a78 <memblock_bottom_up+0x38>
                        a74: R_X86_64_PLT32     __sanitizer_cov_trace_pc-0x4
 a78:   44 89 f3                mov    %r14d,%ebx
 a7b:   80 e3 01                and    $0x1,%bl
 a7e:   41 83 e6 01             and    $0x1,%r14d
 a82:   31 ff                   xor    %edi,%edi
 a84:   44 89 f6                mov    %r14d,%esi
 a87:   e8 00 00 00 00          call   a8c <memblock_bottom_up+0x4c>
                        a88: R_X86_64_PLT32
__sanitizer_cov_trace_const_cmp1-0x4
 a8c:   89 d8                   mov    %ebx,%eax
 a8e:   5b                      pop    %rbx
 a8f:   41 5e                   pop    %r14
 a91:   5d                      pop    %rbp
 a92:   c3                      ret
 a93:   e8 00 00 00 00          call   a98 <memblock_bottom_up+0x58>
                        a94: R_X86_64_PLT32     __sanitizer_cov_trace_pc-0x4
 a98:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                        a9b: R_X86_64_32S       .data+0x3c0
 a9f:   4c 89 f6                mov    %r14,%rsi
 aa2:   e8 00 00 00 00          call   aa7 <memblock_bottom_up+0x67>
                        aa3: R_X86_64_PLT32
__ubsan_handle_load_invalid_value-0x4
 aa7:   eb cf                   jmp    a78 <memblock_bottom_up+0x38>
 aa9:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
 ab0:   00 00 00
 ab3:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
 aba:   00 00 00
 abd:   0f 1f 00                nopl   (%rax)

This means that the sanitiers added a lot of extra checking around what
would have been a trivial global variable access otherwise. In this case,
not inlining would be a reasonable decision.

      Arnd
