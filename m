Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD29B339970
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 23:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhCLWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 17:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbhCLWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 17:05:16 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D65C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:05:15 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v9so47656228lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwseNeEs0krod4F+IhuF+pHQNcsyduOIl992m6AfVdM=;
        b=FA1WSoHxObCG8KV4IFqpaR14oqL2QB9UGxuz2ki63NNRIj1K5dHISlascnXktpuqQR
         HHyUNZfZpOA4RfbkjDqTRlx6cKhYrlb1S1Ctjv+2CvNRkzookyiZFuFc4xfJT18mZMVk
         OI0ZfYLR9MRMy8Yn8d8KKUxfa+egoUASV61VHQMJsgtw7qf3PqUUJd/nCX1H+d60iXrV
         gJW2F3YZHsmADd6JuXsq3N/5dig0eRZDQWNcfSWDgBFGqEWasZtgdjeGPRkP3uKl0L55
         Ua90C4dn21FAg9OJNphicIY6igNgMvpuukjZy8RMPhHEGbimAEJ16PhjyIVWsOG8XMq7
         uhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwseNeEs0krod4F+IhuF+pHQNcsyduOIl992m6AfVdM=;
        b=a5wbry/lbGPhdOggDUZxBDuLfOQgCkX+PFW1lVxg4glVlAZUtpcWmbK/GgHNfEFKfM
         3KdRo8PeIyA6ov8V3OZhMEKAk6432dCcquXrGSVwldZw5z9nFnk/fUt8iUbsD4knSMfp
         pPNvxxqpzhrCl/3C029HvLd89P+HisOAypYGR133xQe1G7khRTe7QWT16MBV75jxQdzP
         FKdkRT52u5bm+ojOEm3Owpci3eKB2Zjx6oxW/d1FFZlrkM9uBCkCyDgiK+anSlmOp1YH
         z2S9hyiMjr+5Igxb046zss1hMFoCKdh8+yyklSPfsuqD1F74QcOL/yQ5c3A6M+OZIwPc
         49QA==
X-Gm-Message-State: AOAM531+Sa+UT9xJsuCSnH9ofEjgE3u6IXQE5vdH0BZryGsN2tUm3mST
        muEZqdL9+uFMo0e4TavJpJNXcAIlGOUoYoRT6hM9uQ==
X-Google-Smtp-Source: ABdhPJyGOAGStHXiFTJGVITN4c0QoM8CKvXLRI+jTbyBY0qOvJQ8LfSLVLErdePQPfJuAER5yEs+2x11QvP9fukI/oA=
X-Received: by 2002:a19:8c19:: with SMTP id o25mr757160lfd.547.1615586713934;
 Fri, 12 Mar 2021 14:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20210312192139.2503087-1-ndesaulniers@google.com> <20210312202537.z77v4qnvptbrug2f@google.com>
In-Reply-To: <20210312202537.z77v4qnvptbrug2f@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Mar 2021 14:05:02 -0800
Message-ID: <CAKwvOd=8WM9KVoPxy7x9kQR5cEz1M+hJ4Pbz8kU+5ipMSzSJ+A@mail.gmail.com>
Subject: Re: [PATCH] gcov: fix clang-11+ support
To:     Fangrui Song <maskray@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 12:25 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> function_name can be unconditionally deleted. It is not used by llvm-cov
> gcov.  You'll need to delete a few assignments to gcov_info_free but you
> can then unify the gcov_fn_info_dup and gcov_info_free implementations.
>
> LG. On big-endian systems, clang < 11 emitted .gcno/.gcda files do not
> work with llvm-cov gcov < 11.  To fix it and make .gcno/.gcda work with
> gcc gcov I chose to break compatibility (and make all the breaking
> changes like deleting some CC1 options) in a short window. At that time
> I was not aware that there is the kernel implementation. Later on I was
> CCed on a few https://github.com/ClangBuiltLinux/linux/ gcov issues but
> I forgot to mention the interface change.

These are all good suggestions. Since in v2 I'll drop support for
clang < 11, I will skip additional patches to disable GCOV when using
older clang for BE, and the function_name cleanup.

> Now in clang 11 onward, clang --coverage defaults to the gcov 4.8
> compatible format. You can specify the CC1 option (internal option,
> subject to change) -coverage-version to make it compatible with other
> versions' gcov.
>
> -Xclang -coverage-version='407*' => 4.7
> -Xclang -coverage-version='704*' => 7.4
> -Xclang -coverage-version='B02*' => 10.2 (('B'-'A')*10 = 10)

How come LLVM doesn't default to 10.2 format, if it can optionally
produce it?  We might be able to reuse more code in the kernel between
the two impelementations, though I expect the symbols the runtime is
expected to provide will still differ. Seeing the `B` in `B02*` is
also curious.

Thanks for the review, will include your tag in v2.
-- 
Thanks,
~Nick Desaulniers
