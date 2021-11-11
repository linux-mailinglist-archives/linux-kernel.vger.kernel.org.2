Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BBD44D326
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhKKI3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKKI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:29:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA857C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:26:43 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z21so21076640edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUA8cT1yNGUc7DNHm9M9jCLdwArLczgi/VVgmJMyKuw=;
        b=WD4t8nHEPj8jfQJ2PXumfYpqqhk/xWQKha1+7H9j+z/NWiUsvopX2M7GGVZwlP2zR1
         31+JgmrUgZ2Sil95OkdKdiTN2MPmXQNNIa+RfQUHedeT30XAwEIF55UGiI4Gh+x/JjNr
         /MAcHcLgz7YZ4ApS4LsBhT/2KxBtaIdor0t2/S9MfDJZLyJcWit2MgMlbhLd+oO3xXvN
         tzOidhK9yYdG6VIWAb4mol70Q2fI0vg3Xear+XvcC6r9Pu4MejS/FmEmK603p4/2BjcP
         MXVWtCLg95P+N6jOYLo4QXowewMVKNIY2WkDbNWWE8KXWEX277hxNXTkNDeV8/O6aLw8
         eOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUA8cT1yNGUc7DNHm9M9jCLdwArLczgi/VVgmJMyKuw=;
        b=ZlhfuwOVvI4k/WynjjK3+m1mLwJjC/X3A7NI9QCpCvHHI3CgYsMDE8q4qSZK7YSp80
         SQmtJbEEby9IN3MTtxM2YZj54OOmpm1Wq0Km9iArENDpBE59hNCjgFQVDbtt+6P9UrgY
         Yy6gSAJPsm2dkt3tnajB8aO2IWQ3n/oosUb98bDTrG+6oV8gy0YgrbbZ1EAoESLN1hXs
         +97Qj4BgJGRZRnulclk1YLjVc9ZeM+0wJfzoK6x3iGNOkZGS1J9CDglnTXHdI9ldpvKI
         OHYC+y6Rqz4jdwSz6My+7wHk/nvFq2ifLM1yFGAzdRQYyVH5STRRHuaRm3HQ8xv6yUn9
         YWlw==
X-Gm-Message-State: AOAM530F5rBQySd87IwSCjlP99MJrSlSRsjsECjuiogg7Aln1H3BdRfN
        K2AP9QdlBfJ+WMLfv9hMXCC2thIiorg8lWMrnT5rDA==
X-Google-Smtp-Source: ABdhPJyGyHbjogLeLt524wf5FjRZ2UBTmqsg3aU9e5sHbiRlTb+tWK8lhevxD8Or9lCYOyt8ZTGRTizAwj4jGSng2I8=
X-Received: by 2002:a17:906:a08d:: with SMTP id q13mr6923927ejy.465.1636619202419;
 Thu, 11 Nov 2021 00:26:42 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
 <20211110180359.2338349-1-anders.roxell@linaro.org> <CAKwvOdkoKvjecTfxbRwZ=BYirvy-Jq64pHtHuct8oWgExv1xPw@mail.gmail.com>
 <CAKwvOdnNKHJ++8vJS7WvaZX1aRZHk5uA7LP+S=ApSjRcU4QDkQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnNKHJ++8vJS7WvaZX1aRZHk5uA7LP+S=ApSjRcU4QDkQ@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 11 Nov 2021 09:26:31 +0100
Message-ID: <CADYN=9JRazXg+eGT8NYG-XVTkyhkpoTRkQKm=d7zjYRYzjkpRg@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: timens: exec: use 'labs()' over 'abs()'
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     shuah@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 at 21:11, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Nov 10, 2021 at 12:09 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Nov 10, 2021 at 10:04 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > When building selftests/timens with clang, the compiler warn about the
> > > function abs() see below:
> > >
> > > exec.c:33:8: error: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
> > >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> > >                             ^
> > > exec.c:33:8: note: use function 'labs' instead
> > >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> > >                             ^~~
> > >                             labs
> > >
> > > Rework to store the time difference in a 'long long' and pass that to
> > > llabs(), since the variable can be an 'int', 'long' or 'long long'
> > > depending on the architecture and C library.
> > >
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >
> > Thanks for the patch!
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> ah, gmail doesn't do a great job at showing the subject when a v2 is
> sent in-reply-to.

oh right, sorry.

>  Should the oneline mention llabs rather than labs
> now?

You are correct, can this be changed when the patch gets applied or
should I send a v3?

Cheers,
Anders
