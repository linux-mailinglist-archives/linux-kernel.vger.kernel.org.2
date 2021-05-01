Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2DE37045C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 02:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhEAA0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 20:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhEAA0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:26:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:25:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j10so19545269lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUs/JERTrW3HUrDL/wVgoAkdrrpfaLfIyhV+eubJz2w=;
        b=ovfeJotqKRsfWrPIH6AIxi/XyxgV6ULfCeDnbzlEglpH+gp/04eFGbHmqgeptZTVki
         +cRjF3KDoiPmfsOylvLmq9YJ+5oVUtZezoVdzJQRGmHbiHOr5+mcn/S9yT+yZkGYkOVQ
         40grV2eLwoILokTAGYdmPUS19V78mI8XFkXWyvWBqM4B4PBTl3cxTyy83t9WHv7BFKlT
         pxsqNAvzWLJ2uqb98WFaSSM6BmSN8Q65f+C6HBk6/XeCYl3vSbJmmrw7AQUu4IXHpub+
         acTOcakDRFyCPDtvu50Db9IB+E5EteLRCjViFP8rcIQPLPDYI2o5yK5wT7SNJn1gqJtf
         LoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUs/JERTrW3HUrDL/wVgoAkdrrpfaLfIyhV+eubJz2w=;
        b=P+PWY8tWNBBnYnIR0H1cfVdIxhWjzx9wfN+sgrkZfPbC1fhQynrJGFFcliiPfVjUva
         qwgExKKH6S/rDowlkBQ1x/CEUthX+YZ3xADcZbg09EPhqCwsrIYMICrKZ2HDf0F42SBK
         W20Jeu4wM4PF6ZK8/Y5ep8QXzeaZOQ6LvB2hQ2DtJ78aefpvik5vi0YHs6zaeHLYJvop
         PkvhYbzvCqajclgDvGhUwZelbrgCZeNZ2pzKEF6r5LHnrSVQTE05g0qTEgY02j5Gvp+X
         X5+jx3uGeHGwxdJg1xRNBPuxJwLSl9PztlSOK7GLpECb9JHq3kuLm5zZCg0acOfUGlli
         COmA==
X-Gm-Message-State: AOAM530vPOw9Yb/L2EJnJgt/kUTjlxYvNqlNhpJTTVoqSwDPxDLg+wW+
        PIufKQZcvte4dZkMJbDqPJCHn16qYnZzjkqzcVXJEA==
X-Google-Smtp-Source: ABdhPJwrCGjFzrIGadve5J2FKRLLJTGo55M0OYqu4dLKi7taQ4gue28o+B8PwwPcGzfInNpsLVa4xR4vwG+ra3TmWNI=
X-Received: by 2002:a05:6512:94d:: with SMTP id u13mr4794407lft.368.1619828713748;
 Fri, 30 Apr 2021 17:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com> <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
In-Reply-To: <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Apr 2021 17:25:02 -0700
Message-ID: <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 5:23 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Apr 30, 2021 at 5:19 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > A quick:
> > $ perf record -e cycles:pp --call-graph lbr make LLVM=1 LLVM_IAS=1
> > -j72 allmodconfig
> > $ perf report --no-children --sort=dso,symbol
> > shows:
> >      2.35%  [unknown]                [k] 0xffffffffabc00fc7
> > +    2.29%  libc-2.31.so             [.] _int_malloc
> >      1.24%  libc-2.31.so             [.] _int_free
> > +    1.23%  ld-2.31.so               [.] do_lookup_x
>
> ^ bfd


> > +    0.63%  ld-2.31.so               [.] _dl_lookup_symbol_x
>
> ^ bfd

Ah, no, sorry, these are the runtime link editor/loader. So probably
spending quite some time resolving symbols in large binaries.

-- 
Thanks,
~Nick Desaulniers
