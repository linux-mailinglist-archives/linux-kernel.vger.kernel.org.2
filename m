Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7598932F70D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCFAEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCFAEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:04:20 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AADC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:04:20 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x4so115874lfu.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 16:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ng7BsdZElPC+gzGXsxquczNpRrNVtdewc/pU/jfXSXU=;
        b=o5cANNl02cVFCKeEn8S0ugiKV8NbQH9GEfE6+dziNCsAnt1NmX7DP1/cOm/whSzwxn
         s1MAwdppLndgTGvVJbVlf18fanM6QeIozEkrEAsI62ypB7S/3chPOmH27/E/38Io4M5N
         GrWjxXy8j8zUNcqLNUY33zYB7NG/Osz9S/Y3jt9tNs0DzHGA6cc9drCjwQ5nJHN9HH7g
         mE6/LzkHJ5MuzjfjQ+vi3c5tgNXeVfJvdDkcuVkEskaehdscQJm6y5sJjiSpLOO/p4p/
         tcWcOBh8wW3BfyWsN4K/BoZhFUHy5KeKJhRa4hEFrXZAYI+hbPn5kRmvKi5Rn9roQTjG
         biug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ng7BsdZElPC+gzGXsxquczNpRrNVtdewc/pU/jfXSXU=;
        b=cFcABGHeYurIof7nnmRHEFaSQJwOd4z3U3Y3VA022q6VA/tlIVZ4BRpGBnmcVIVEfr
         sag9YiJbyMPrauuB+CSFE1gYtLik/jia9/ts642t6RFxc1WUOeBmNh8fschLuhO4LoJo
         Pm0JwHfw9WxIpo5tXinsr/+HA2LxWOUaLygncx33TDpynwHiAWB1JjBxw/yqN0d6UbAs
         hA7nVXW1hACN778DDahA3kqB4Hw/M6dE2Qc+7DfA5ZnWTcSv3bAAYreW/9XAJncQibrl
         xR07/EiQa+pyNown88xV6ivF4I+Lz4iZG0+wd2Uum7GEiz1Dvmj8iq3yYM+BNWJ1pK1z
         WMTA==
X-Gm-Message-State: AOAM533/cWSGs4/TwfdOfbCcmqOhb7ib/0Vx4SnG0mYGZqnO9mxNOok4
        +xVAW+KzsFdxR4GS0G1xhUJj0H0IOqMF2WM1AeodSg==
X-Google-Smtp-Source: ABdhPJw3kAw6w2N1NCbGWxO+aTK6zp6EbB7I/d5Avwjp+/KBiNT6y/utjJk8NryZ4VkzD8cMkQqjJasW5zf5MpMUYiA=
X-Received: by 2002:a19:5055:: with SMTP id z21mr7120804lfj.297.1614989058347;
 Fri, 05 Mar 2021 16:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20210303170932.1838634-1-jthierry@redhat.com> <20210305235102.384950-1-ndesaulniers@google.com>
In-Reply-To: <20210305235102.384950-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Mar 2021 16:04:07 -0800
Message-ID: <CAKwvOdmgRAJXVdaHAnZoYm-Y4Dt01CYxvsnJC6zaSwr5amRWBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] objtool: add base support for arm64
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, ycote@redhat.com,
        Fangrui Song <maskray@google.com>,
        Bill Wendling <morbo@google.com>,
        Pete Swain <swine@google.com>,
        Yonghyun Hwang <yonghyun@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 3:51 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> (in response to
> https://lore.kernel.org/linux-arm-kernel/20210303170932.1838634-1-jthierry@redhat.com/
> from the command line)
>
> > Changes since v1[2]:
> > - Drop gcc plugin in favor of -fno-jump-tables
>
> Thank you for this!  I built+booted(under emulation) arm64 defconfig and built
> arm64 allmodconfig with LLVM=1 with this series applied.
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> One thing I noticed was a spew of warnings for allmodconfig, like:
> init/main.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> init/main.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
>
> I assume those are from the KASAN constructors. See also:
> https://github.com/ClangBuiltLinux/linux/issues/1238
>
> Can we disable HAVE_STACK_PROTECTOR if CC_IS_CLANG and CONFIG_KASAN is set,
> until we can resolve the above issue?

Ah, filtering the logs more, it looks like GCOV is has the same issue
KASAN does (known issue).  Here's a filtered log:
https://gist.github.com/nickdesaulniers/01358015b33bd16ccd7d951c4a8c44e7

I'm curious about the failure to decode certain instructions?

The stack state mismatches are what are valuable to me; we'll need
some help digging into those at some point.  The logs from defconfig
are clean.
-- 
Thanks,
~Nick Desaulniers
