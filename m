Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C249409DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347775AbhIMUEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347763AbhIMUEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:04:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8DBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:02:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s10so23528323lfr.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVlem88uR6+O3AEpNn6Yh2wjkDnIsvdG9SBuzHecDPY=;
        b=UtwnzoxIKMk4tOfMxxm4CpllD0ShmrKrKQSd8xl/r5+Nf6ZLZtS9/OyvibeXeJRjJm
         qJb8asXWsxkH8rMGhQmFiAc9zt9A20ouuq77sfZCOcwEBRY3tnwTv8gByYQCor/Quz48
         og1G2y8Pl9wxe7Gr4qj+V+3W1nEqAaqVtcdiHmee1cHKUsJcv7M1ZOYmo851M7WyJjxB
         s2cwUJHvcdnzka3/e/fwcF8RA8HvXllV2N/rj5OSMWm+RkgRLLf9Vx78zmfKw/WSWc7j
         E1acsbtB9KLKrBrScCWd2Unh4K44M/5o+4GJsvBA1ZhCB35t9GyhLHgeM4zk+YAM2EGy
         Bj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVlem88uR6+O3AEpNn6Yh2wjkDnIsvdG9SBuzHecDPY=;
        b=ohv+Lbf26h88n1ZoDkngL15xjGVMC9rn8IPtswrnvXYgzw+vCiqzGIwj2DBr+PGWIr
         mnY5Al7kw3T83WJKsTGlSg9oSd6uc6/etrt5dUYyAefa6phyRL6gcBUcR1qkv1pTNTuu
         umBYEXShdzpYYNSLVsFhgZy03WTK3EY20AgiV2vS8R6c2LZmRFh1aMeFTpvAQF5P6lI3
         GPdsIlMEuszFQXjZjsRR9K28VWHRBW1KwLbyB8Nr62J+NVehEL59aFbUSQ3inUJF7T5j
         JymBHVRlsZhvDnFnhuqALrh/0QrQFmcI7QXVKY0VE4/ijajB7gTPLzo5/WbrEwgCRyQt
         dWvA==
X-Gm-Message-State: AOAM531QfotECHV1HDsererxjN6d/q4nlTsdEdoV/JR8Qe5e0BWhJ6W7
        4wvnoz39s1G8wXnDBGH+73wGmDQQyg/bPKtlgpq2RQ==
X-Google-Smtp-Source: ABdhPJybQilluIHG6i+P60qv7XmPd0cdDddL5AUg5XZKqBiVfw8k7+1hrq7lipQL53Lr2BDFIjLWKWvU6iKbwY7roOA=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr9744729lfa.523.1631563363038;
 Mon, 13 Sep 2021 13:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210913131113.390368911@linuxfoundation.org> <20210913131114.028340332@linuxfoundation.org>
 <CA+G9fYtdPnwf+fi4Oyxng65pWjW9ujZ7dd2Z-EEEHyJimNHN6g@mail.gmail.com>
 <YT+RKemKfg6GFq0S@kroah.com> <CAKwvOdmOAKTkgFK4Oke1SFGR_NxNqXe-buj1uyDgwZ4JdnP2Vg@mail.gmail.com>
 <CAKwvOdmCS5Q7AzUL5nziYVU7RrtRjoE9JjOXfVBWagO1Bzbsew@mail.gmail.com> <CA+icZUVuRaMs=bx775gDF88_xzy8LFkBA5xaK21hFDeYvgo12A@mail.gmail.com>
In-Reply-To: <CA+icZUVuRaMs=bx775gDF88_xzy8LFkBA5xaK21hFDeYvgo12A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Sep 2021 13:02:32 -0700
Message-ID: <CAKwvOdmN3nQe8aL=jUwi0nGXzYQGic=NA2o40Q=yeHeafSsS3g@mail.gmail.com>
Subject: Re: [PATCH 5.14 018/334] nbd: add the check to prevent overflow in __nbd_ioctl()
To:     sedat.dilek@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Baokun Li <libaokun1@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:57 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Sep 13, 2021 at 9:53 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 11:39 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > There's an issue with my alternative approach
> > > (https://gist.github.com/nickdesaulniers/2479818f4983bbf2d688cebbab435863)
> > > with declaring the local variable z in div_64() since either operand
> > > could be 64b, which result in an unwanted truncation if the dividend
> > > is 32b (or less, and divisor is 64b). I think (what I realized this
> > > weekend) is that we might be able to replace the `if` with
> > > `__builtin_choose_expr`, then have that whole expression be the final
> > > statement and thus the "return value" of the statement expression.
> >
> > Christ...that...works? Though, did Linus just merge my patches for gcc 5.1?
> >
>
> "Merge branch 'gcc-min-version-5.1' (make gcc-5.1 the minimum version)"

Ha! I pulled+rebased and this code disappeared...I thought I had
rebased on the wrong branch or committed work to master accidentally.
Patch to stable-only inbound.
-- 
Thanks,
~Nick Desaulniers
