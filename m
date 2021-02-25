Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920C93251E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBYPAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 10:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229961AbhBYPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614265132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bvA3joDxtGwPdmhV+qc0G7SWpdH/9IEUumaO+ZmZvA=;
        b=FizIyTj2meBlh6aSs9lDT9Fbvt48LPJMVBuWCe7mPxUG62s/J1vLMYf1yPYv2ogIObwh9m
        TN4dqAnWbU0fZ9Vxd1zlMJRV6TccQMcHMPa6LQcPbCfnHVsIfFZde5MHulf9REa2Fu3G7+
        IHqtc6gzQBWHumzvEyrJ0UoRWQ05pPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-lb9ELSTvP6yQZUv6UXS15w-1; Thu, 25 Feb 2021 09:58:48 -0500
X-MC-Unique: lb9ELSTvP6yQZUv6UXS15w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AE33107ACF3;
        Thu, 25 Feb 2021 14:58:46 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E14DE1346D;
        Thu, 25 Feb 2021 14:58:43 +0000 (UTC)
Subject: Re: [PATCH] memblock: fix section mismatch warning
To:     Arnd Bergmann <arnd@kernel.org>
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
References: <20210225133808.2188581-1-arnd@kernel.org>
 <60989b76-1ae6-6be3-0277-df9f0cc8dc3e@redhat.com>
 <CAK8P3a0W5F14uW+0jqkNAxcXfODhK9_1L-DXnC_h2yrev13aAA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <269fdc41-3ac8-8919-1330-d87b32689e89@redhat.com>
Date:   Thu, 25 Feb 2021 15:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0W5F14uW+0jqkNAxcXfODhK9_1L-DXnC_h2yrev13aAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.21 15:06, Arnd Bergmann wrote:
> On Thu, Feb 25, 2021 at 2:47 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 25.02.21 14:38, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The inlining logic in clang-13 is rewritten to often not inline
>>> some functions that were inlined by all earlier compilers.
>>>
>>> In case of the memblock interfaces, this exposed a harmless bug
>>> of a missing __init annotation:
>>>
>>> WARNING: modpost: vmlinux.o(.text+0x507c0a): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
>>> The function memblock_bottom_up() references
>>> the variable __meminitdata memblock.
>>> This is often because memblock_bottom_up lacks a __meminitdata
>>> annotation or the annotation of memblock is wrong.
>>>
>>> Interestingly, these annotations were present originally, but got removed
>>> with the explanation that the __init annotation prevents the function
>>> from getting inlined. I checked this again and found that while this
>>> is the case with clang, gcc (version 7 through 10, did not test others)
>>> does inline the functions regardless.
>>
>> Did I understand correctly, that with this change it will not get
>> inlined with any version of clang? Maybe __always_inline is more
>> appropriate then.
>>
>> (I don't see why to not inline that function, but I am obviously not a
>> compiler person :) )
> 
> Looking at the assembler output in the arm64 build that triggered the
> warning, I see this code:
> 
> 0000000000000a40 <memblock_bottom_up>:
>   a40:   55                      push   %rbp
>   a41:   48 89 e5                mov    %rsp,%rbp
>   a44:   41 56                   push   %r14
>   a46:   53                      push   %rbx
>   a47:   e8 00 00 00 00          call   a4c <memblock_bottom_up+0xc>
>                          a48: R_X86_64_PLT32     __sanitizer_cov_trace_pc-0x4
>   a4c:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
>                          a4f: R_X86_64_32S       memblock
>   a53:   e8 00 00 00 00          call   a58 <memblock_bottom_up+0x18>
>                          a54: R_X86_64_PLT32     __asan_load1_noabort-0x4
>   a58:   44 0f b6 35 00 00 00    movzbl 0x0(%rip),%r14d        # a60
> <memblock_bottom_up+0x20>
>   a5f:   00
>                          a5c: R_X86_64_PC32      memblock-0x4
>   a60:   bf 02 00 00 00          mov    $0x2,%edi
>   a65:   44 89 f6                mov    %r14d,%esi
>   a68:   e8 00 00 00 00          call   a6d <memblock_bottom_up+0x2d>
>                          a69: R_X86_64_PLT32
> __sanitizer_cov_trace_const_cmp1-0x4
>   a6d:   41 83 fe 01             cmp    $0x1,%r14d
>   a71:   77 20                   ja     a93 <memblock_bottom_up+0x53>
>   a73:   e8 00 00 00 00          call   a78 <memblock_bottom_up+0x38>
>                          a74: R_X86_64_PLT32     __sanitizer_cov_trace_pc-0x4
>   a78:   44 89 f3                mov    %r14d,%ebx
>   a7b:   80 e3 01                and    $0x1,%bl
>   a7e:   41 83 e6 01             and    $0x1,%r14d
>   a82:   31 ff                   xor    %edi,%edi
>   a84:   44 89 f6                mov    %r14d,%esi
>   a87:   e8 00 00 00 00          call   a8c <memblock_bottom_up+0x4c>
>                          a88: R_X86_64_PLT32
> __sanitizer_cov_trace_const_cmp1-0x4
>   a8c:   89 d8                   mov    %ebx,%eax
>   a8e:   5b                      pop    %rbx
>   a8f:   41 5e                   pop    %r14
>   a91:   5d                      pop    %rbp
>   a92:   c3                      ret
>   a93:   e8 00 00 00 00          call   a98 <memblock_bottom_up+0x58>
>                          a94: R_X86_64_PLT32     __sanitizer_cov_trace_pc-0x4
>   a98:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
>                          a9b: R_X86_64_32S       .data+0x3c0
>   a9f:   4c 89 f6                mov    %r14,%rsi
>   aa2:   e8 00 00 00 00          call   aa7 <memblock_bottom_up+0x67>
>                          aa3: R_X86_64_PLT32
> __ubsan_handle_load_invalid_value-0x4
>   aa7:   eb cf                   jmp    a78 <memblock_bottom_up+0x38>
>   aa9:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
>   ab0:   00 00 00
>   ab3:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
>   aba:   00 00 00
>   abd:   0f 1f 00                nopl   (%rax)
> 
> This means that the sanitiers added a lot of extra checking around what
> would have been a trivial global variable access otherwise. In this case,
> not inlining would be a reasonable decision.

It's not like if there are a lot of call sites:

  $ git grep memblock_bottom_up
arch/x86/mm/init.c:     if (memblock_bottom_up()) {
include/linux/memblock.h:static inline bool memblock_bottom_up(void)
mm/cma.c:               if (!memblock_bottom_up() && memblock_end >= SZ_4G + size) {
mm/memblock.c:  if (memblock_bottom_up())


Similarly for memblock_set_bottom_up() within a kernel image.

But it's not like this is performance-sensitive code :)

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

