Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45617308F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 22:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhA2V2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 16:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhA2V2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 16:28:02 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC28C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:27:22 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o7so7538209pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H9w4bRYBU76OhsJf1ZTWPcMTo7sL+1mxGISEO7vuja8=;
        b=dX37CiuMQ4aXIY1kTIUP4PzukKYIdr8eZlMKzfLK3WjreHdGbMMCpS72DXvwzzA9IV
         8giEw0ti1ilbZGsXxxTOiyGvTSSzJdTbN4pGgc/KblDO4eO14V2rb7mu9vBPuoyIIthS
         ZNLBdoGTi3si0CJkE9Tnkd/9aDOmOY/D9ejKNxXwva0wMXoCdHckQza8LPBWNnvRzqMG
         7zZG1uKe1W9c6nXhf/j3bi3DLlqFQdTralnrRT/urIXcmjBsRjW9wXv4eftDz0/TyMaL
         QfbU80bxqcSWC9XHgsc6YeV6ZdBYfsASx8pgCaZ4f3sFzsJSZsuSGnzxe1Qo2Q56D5S4
         zAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9w4bRYBU76OhsJf1ZTWPcMTo7sL+1mxGISEO7vuja8=;
        b=iYCn+WZcnOEIXS4EehFWRYe8mLCdP0Tz5RFufruyttLGo6IVQduvUp6dx2fj28EsNF
         jAxaVIg52647Yr5K2hbtSBiRMSjs2ZKvyVh8A3lkOF0aRLTPSGqBEXCObPNVPFBBemvl
         eOyRE/Ix5qzTB1i/cV1Mzq0erOHxVbEyQs9GT6sdKyzD82Ucc/GjAwO0OiPtTkY5oZqZ
         3ftgnuEowDs1GlRX5sdX1aJ4ap5abbBSxoKBs/en1OrqXyLE8Txekoa9VDUz9t//IZcc
         PNyEOtM+oK10oDOC0ouq7opeW4u6MdCnUiRSaqeO4qtZt1BQgtIGIKhYRrn5HcmrGT/E
         R6lw==
X-Gm-Message-State: AOAM533V9P7OuejUygMbBY5Fr5zu+56Vpl0MovL+n8rsZIQ16UYSxSs2
        4OzLbLuASuqwmoelY+2nxhSqWw==
X-Google-Smtp-Source: ABdhPJySt6fJ+IqK5L+y2zjshv5Q1SLhsOLmcqnB+6azczQ6YBYXKKndghfgc3uZ82/kZrgAE+xLow==
X-Received: by 2002:a65:4c4c:: with SMTP id l12mr6376812pgr.361.1611955641890;
        Fri, 29 Jan 2021 13:27:21 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id o190sm6607952pgo.50.2021.01.29.13.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:27:21 -0800 (PST)
Date:   Fri, 29 Jan 2021 13:27:18 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vmlinux.lds.h: Define SANTIZER_DISCARDS with
 CONFIG_GCOV_KERNEL=y
Message-ID: <20210129212718.lf7kdw6d5rrtnt4q@google.com>
References: <20210129201116.2658179-1-nathan@kernel.org>
 <CAKwvOdkoivL4+HjXi4aKQbQ7R2J_oKBcMKrSsdxuOGLpseQZcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdkoivL4+HjXi4aKQbQ7R2J_oKBcMKrSsdxuOGLpseQZcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-29, Nick Desaulniers wrote:
>On Fri, Jan 29, 2021 at 12:11 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> clang produces .eh_frame sections when CONFIG_GCOV_KERNEL is enabled,
>> even when -fno-asynchronous-unwind-tables is in KBUILD_CFLAGS:
>>
>> $ make CC=clang vmlinux
>> ...
>> ld: warning: orphan section `.eh_frame' from `init/main.o' being placed in section `.eh_frame'
>> ld: warning: orphan section `.eh_frame' from `init/version.o' being placed in section `.eh_frame'
>> ld: warning: orphan section `.eh_frame' from `init/do_mounts.o' being placed in section `.eh_frame'
>> ld: warning: orphan section `.eh_frame' from `init/do_mounts_initrd.o' being placed in section `.eh_frame'
>> ld: warning: orphan section `.eh_frame' from `init/initramfs.o' being placed in section `.eh_frame'
>> ld: warning: orphan section `.eh_frame' from `init/calibrate.o' being placed in section `.eh_frame'
>> ld: warning: orphan section `.eh_frame' from `init/init_task.o' being placed in section `.eh_frame'
>> ...
>>
>> $ rg "GCOV_KERNEL|GCOV_PROFILE_ALL" .config
>> CONFIG_GCOV_KERNEL=y
>> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
>> CONFIG_GCOV_PROFILE_ALL=y
>>
>> This was already handled for a couple of other options in
>> commit d812db78288d ("vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted
>> sections") and there is an open LLVM bug for this issue. Take advantage
>> of that section for this config as well so that there are no more orphan
>> warnings.
>>
>> Link: https://bugs.llvm.org/show_bug.cgi?id=46478
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1069
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>
>Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>I suspect we're going to need to add module level attributes in LLVM
>IR for these options, then check those when synthesizing new function
>definitions within LLVM.  At least we'll be able to point to this file
>and say "hey, this is a general problem in LLVM, and here are 3
>specific cases now where it's a problem."  Not a large problem, but
>would help us save some bytes in the final object.  LLVM is not
>producing data in this section for all code, just these synthesized
>routines.

Maybe. There are also a long list of security features which may impose
additional requirements. Adding a module flag metadata for each such
feature will be a long battle. For .eh_frame, I think it is
important/generic enough and can benefit other applications that
deserves special handling (and I can look into it). For .init_array, I
am not too sure....

>> ---
>>  include/asm-generic/vmlinux.lds.h | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index b2b3d81b1535..f753fd449436 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -988,12 +988,13 @@
>>  #endif
>>
>>  /*
>> - * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
>> + * Clang's -fsanitize=kernel-address, -fsanitize=thread,
>> + * and -fprofile-arcs -ftest-coverage produce unwanted
>>   * unwanted sections (.eh_frame and .init_array.*), but
>>   * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
>>   * https://bugs.llvm.org/show_bug.cgi?id=46478
>>   */
>> -#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
>> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN) || defined(CONFIG_GCOV_KERNEL)
>>  # ifdef CONFIG_CONSTRUCTORS
>>  #  define SANITIZER_DISCARDS                                           \
>>         *(.eh_frame)
>>
>> base-commit: bec4c2968fce2f44ce62d05288a633cd99a722eb
>> --
>> 2.30.0
>>

Drop -ftest-coverage. -ftest-coverage just produces .gcno and does not
affect code generation.

Reviewed-by: Fangrui Song <maskray@google.com>
