Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1937095B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 01:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhEAX4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 19:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEAX4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 19:56:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF70C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 16:55:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gj14so1017330pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 16:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cJtnQiMEQGHamwTnLSAL+yS7z+YYUkCJ8B6sDol3IVQ=;
        b=Yp+7NBsWnFAflu4GCKuRQLlPd6v80Ui4mAXBIVo3gcON1HmI7BdeLLI6869cIhZ1vO
         h2/M7Igv/g94ZPvy0WRqSMXC2+qP1R7QnMseB68G4cHFsDCLN4utoQC1MD8IDM89cvTh
         49MIK34pZKThqKTe6RTaaFOHHCDxmyD0b5z1NCAtoR6/rn3Xa77vTMo6hiORGHF/gSmh
         W3JIpeglGGGdKL3WxD0oGn2YHzisIcB9XgMW6SKRTxHj4gKXZQo9K/oFSSRno3F3GJ7n
         vn8b7JkOf5UnxdnTI+I9kCdbpNriZHl2QdyYTxJDfsGuOpgfy4LbwVvC2GZWW1WBdja9
         Txvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cJtnQiMEQGHamwTnLSAL+yS7z+YYUkCJ8B6sDol3IVQ=;
        b=J+IH6aoym9PB49ZLPkDfbgQosPvH9lfwJy5etek6dFhwaKOqOp9+3YVyfV5bKxg8Gs
         UkUSBBjt+9pDOP8KbeCve2stGZJJoTdmXY+w4XzMvAWF1qmrsplxESLFNWnoVLyZJqIQ
         41YBNF0qvUT5MIxQCRbNxlWCRlLTyoJsE62FTudMjGi32lZomApkdqjNFYt6DV8tvOwP
         XhZ2uDAYOdHCKL86A/xd9sah7N5YmKuWDijt96A52Hbo+d038nQmakHt6VumE+Aqvst9
         04W6Q6Ojf+hw5/zYi+0n7X7H/pidBvo98lv3BpfMP/z3TPN172JHX9sHxPVPO8EN7qvC
         26wQ==
X-Gm-Message-State: AOAM532uHjuyg+sIYZjdUG4niQ3aKptTYsHLTmeep0rMuyRzNtSvLeJ+
        kULl+WckJS6htzR9yMLOd2ddhA==
X-Google-Smtp-Source: ABdhPJwfJxEas2N4XgwNj/nRzonN9S29zdQfr178lqsJlGUq0CZIWXI84UQO0SJNk/Tc9e9lzH73Zg==
X-Received: by 2002:a17:903:1c2:b029:ec:a5b6:f840 with SMTP id e2-20020a17090301c2b02900eca5b6f840mr12676430plh.24.1619913353423;
        Sat, 01 May 2021 16:55:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:bd70:101f:7bf7:d724])
        by smtp.gmail.com with ESMTPSA id h6sm5383564pfb.157.2021.05.01.16.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 16:55:52 -0700 (PDT)
Date:   Sat, 1 May 2021 16:55:49 -0700
From:   Fangrui Song <maskray@google.com>
To:     Serge Guelton <sguelton@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>,
        Felix Yan <felixonmars@archlinux.org>
Subject: Re: Very slow clang kernel config ..
Message-ID: <20210501235549.vugtjeb7dmd5xell@google.com>
References: <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210501195750.GA1480516@sguelton.remote.csb>
 <CAHk-=whPoHOa6_gA3-pk=nOzpefZmsSK1an_iByEyhLe+3m-AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=whPoHOa6_gA3-pk=nOzpefZmsSK1an_iByEyhLe+3m-AA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-01, Linus Torvalds wrote:
>On Sat, May 1, 2021 at 12:58 PM Serge Guelton <sguelton@redhat.com> wrote:
>>
>> Different metrics lead to different choice, then comes the great pleasure of
>> making compromises :-)
>
>Even if that particular compromise might be the right one to do for
>clang and llvm, the point is that the Fedora rule is garbage, and it
>doesn't _allow_ for making any compromises at all.
>
>The Fedora policy is basically "you have to use shared libraries
>whether that makes any sense or not".
>
>As mentioned, I've seen a project bitten by that insane policy.  It's bogus.
>
>            Linus

As a very safe optimization, distributions can consider
-fno-semantic-interposition (only effectful on x86 in GCC and Clang,
already used by some Python packages):
avoid GOT/PLT generating relocation if the referenced symbol is defined
in the same translation unit. See my benchmark below: it makes the built
-fPIC clang slightly faster.

As a slightly aggressive optimization, consider
-DCMAKE_EXE_LINKER_FLAGS=-Wl,-Bsymbolic-functions -DCMAKE_SHARED_LINKER_FLAGS=-Wl,-Bsymbolic-functions.
The performance is comparable to a mostly statically linked PIE clang.  (-shared
-Bsymbolic is very similar to -pie.): function calls within libLLVM.so
or libclang-cpp.so has no extra cost compared with a mostly statically linked PIE clang.

Normally I don't recommend -Bsymbolic because

* it can break C++ semantics about address uniqueness of inline functions,
   type_info (exceptions) when there are multiple definitions in the
   process. I believe LLVM+Clang are not subject to such issues.
   We don't throw LLVM/Clang type exceptions.
* it is not compatible with copy relocations[1]. This is not an issue for -Bsymbolic-functions.

-Bsymbolic-functions should be suitable for LLVM+Clang.



LD=ld.lld -j 40 defconfig;  time 'make vmlinux'

# the compile flags may be very different from the clang builds below.
system gcc
     1050.15s user 192.96s system 3015% cpu   41.219 total
     1055.47s user 196.51s system 3022% cpu   41.424 total

clang (libLLVM*.a libclang*.a); LLVM=1
     1588.35s user 193.02s system 3223% cpu   55.259 total
     1613.59s user 193.22s system 3234% cpu   55.861 total
clang (libLLVM.so libclang-cpp.so); LLVM=1
     1870.07s user 222.86s system 3256% cpu 1:04.26 total
     1863.26s user 220.59s system 3219% cpu 1:04.73 total
     1877.79s user 223.98s system 3233% cpu 1:05.00 total
     1859.32s user 221.96s system 3241% cpu 1:04.20 total
clang (libLLVM.so libclang-cpp.so -fno-semantic-interposition); LLVM=1
     1810.47s user 222.98s system 3288% cpu 1:01.83 total
     1790.46s user 219.65s system 3227% cpu 1:02.27 total
     1796.46s user 220.88s system 3139% cpu 1:04.25 total
     1796.55s user 221.28s system 3215% cpu 1:02.75 total
clang (libLLVM.so libclang-cpp.so -fno-semantic-interposition -Wl,-Bsymbolic); LLVM=1
     1608.75s user 221.39s system 3192% cpu   57.333 total
     1607.85s user 220.60s system 3205% cpu   57.042 total
     1598.64s user 191.21s system 3208% cpu   55.778 total
clang (libLLVM.so libclang-cpp.so -fno-semantic-interposition -Wl,-Bsymbolic-functions); LLVM=1
     1617.35s user 220.54s system 3217% cpu   57.115 total



LLVM's reusable component design causes us some overhead here.  Almost
every cross-TU callable function is moved to a public header and
exported, libLLVM.so and libclang-cpp.so have huge dynamic symbol tables.
-Wl,--gc-sections cannot really eliminate much.


(Last, I guess it is a conscious decision that distributions build all
targets instead of just the host -DLLVM_TARGETS_TO_BUILD=host. This
makes cross compilation easy: a single clang can replace various *-linux-gnu-gcc)


[1]: Even if one design goal of -fPIE is to avoid copy relocations, and
   normally there should be no issue on non-x86, there is an unfortunate
   GCC 5 fallout for x86-64 ("x86-64: Optimize access to globals in PIE with copy reloc").
   I'll omit words here as you can find details on https://maskray.me/blog/2021-01-09-copy-relocations-canonical-plt-entries-and-protected
   -Bsymbolic-functions avoids such issues.
