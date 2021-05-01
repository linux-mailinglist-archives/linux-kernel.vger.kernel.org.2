Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855B13704AF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 03:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhEABXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 21:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEABXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 21:23:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:22:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 12so112498053lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYQ9Il+dA/pq2ZY5nJ7eyP52AYYn0pZLbsxAJBCe+mw=;
        b=cWa96zKJSn/iv11BQQ85n+L5O6NSSLrS/x4DnwB4QnZGc2VleTsOV+GzzeiyILVulW
         dqsQTIGaohhzpoupQQpDsyRxUPXu4Mzv/NoilAB+OJCOCWYzm+FJxWM26b7kGfiQBtWu
         JNiOxboSIimSA5d1tKM0uRpO+/861n7M5g61E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYQ9Il+dA/pq2ZY5nJ7eyP52AYYn0pZLbsxAJBCe+mw=;
        b=GKjkUifEa0NvyhClrk9aB3TDUAULiu80TnotoZRpZisSl/B2xzfzqOrShXW/H4Ua9X
         uwVcO5cC75GN0QY1MIOv6kbEuJprSUkPh8giEiqUWC5Po5AVDE9ScXixAR8oKl1X95MK
         o0Z8iHfqJP6kLQFnEfxG+OnG6ddnVsqsphUe+XPlWNv8n0iv8XtIbONL4okJ3oBd32NJ
         aSzLrMXXwvEc/VyxiXTPpEiLII0wzl5ZmIHfBL3qkCAbQbTpaluyboONcVhOtnIOfgx8
         ELNT5VL6Ir2H0pYDJLfh0c/3aiSrwzFX1nJ3NfdWygCKlbMF/kLdVEw/M57s/Aw4nFH6
         vjgg==
X-Gm-Message-State: AOAM533jSpLLkgMCxzveMgjgdTbtN3Iazhnhgn6HGORrTojZYECk4Z/h
        bTmHCaAfPCMbWhgFaqlZNPXjr40HCB5MbTGq
X-Google-Smtp-Source: ABdhPJxpB+cB13J8TXUEDH9HXcwRaKp0sWX/OKZwHf9JTzlAhYhwQ6K0xiny7WRZ8w7fP8rGgfCukg==
X-Received: by 2002:a19:e015:: with SMTP id x21mr5323306lfg.390.1619832165850;
        Fri, 30 Apr 2021 18:22:45 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n13sm433219lfa.209.2021.04.30.18.22.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 18:22:45 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id s9so334573ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:22:45 -0700 (PDT)
X-Received: by 2002:a2e:b555:: with SMTP id a21mr5593886ljn.507.1619832164814;
 Fri, 30 Apr 2021 18:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com> <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
In-Reply-To: <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Apr 2021 18:22:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
Message-ID: <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 5:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Ah, no, sorry, these are the runtime link editor/loader. So probably
> spending quite some time resolving symbols in large binaries.

Yeah. Appended is the profile I see when I profile that "make
oldconfig", so about 45% of all time seems to be spent in just symbol
lookup and relocation.

And a fair amount of time just creating and tearing down that huge
executable (with a lot of copy-on-write overhead too), with the kernel
side of that being another 15%. The cost of that is likely also fairly
directly linked to all the dynamic linking costs, which brings in all
that data.

Just to compare, btw, this is the symbol lookup overhead for the gcc case:

   1.43%  ld-2.33.so             do_lookup_x
   0.96%  ld-2.33.so             _dl_relocate_object
   0.69%  ld-2.33.so             _dl_lookup_symbol_x

so it really does seem to be something very odd going on with the clang binary.

Maybe the Fedora binary is built some odd way, but it's likely just
the default clang build.

             Linus

----
  23.59%  ld-2.33.so          _dl_lookup_symbol_x
  11.41%  ld-2.33.so          _dl_relocate_object
   9.95%  ld-2.33.so          do_lookup_x
   4.00%  [kernel.vmlinux]    copy_page
   3.98%  [kernel.vmlinux]    next_uptodate_page
   3.05%  [kernel.vmlinux]    zap_pte_range
   1.81%  [kernel.vmlinux]    clear_page_rep
   1.68%  [kernel.vmlinux]    asm_exc_page_fault
   1.33%  ld-2.33.so          strcmp
   1.33%  ld-2.33.so          check_match
   0.92%  libLLVM-12.so       llvm::StringMapImpl::LookupBucketFor
   0.83%  [kernel.vmlinux]    rmqueue_bulk
   0.77%  conf                yylex
   0.75%  libc-2.33.so        __gconv_transform_utf8_internal
   0.74%  libc-2.33.so        _int_malloc
   0.69%  libc-2.33.so        __strlen_avx2
   0.62%  [kernel.vmlinux]    pagecache_get_page
   0.58%  [kernel.vmlinux]    page_remove_rmap
   0.56%  [kernel.vmlinux]    __handle_mm_fault
   0.54%  [kernel.vmlinux]    filemap_map_pages
   0.54%  libc-2.33.so        __strcmp_avx2
   0.54%  [kernel.vmlinux]    __free_one_page
   0.52%  [kernel.vmlinux]    release_pages
