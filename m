Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B879D38D331
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 05:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEVDF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 23:05:57 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:43109 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhEVDF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 23:05:56 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 14M33vpK028828
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 12:03:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 14M33vpK028828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621652638;
        bh=YGP0GO/05S1q3RgfS4gVurm0s0DX3V4DOhOSb9eSQmM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ytBNA3gG54JRUdmevHtfRZwTEP6rq/S24feMPxoAQN4TziH/ENrfIjdher4w3yEUg
         5IQ1w+tgQ9Bf25eQqXzTID1GASY1JH7BBh4CagQJ5QT0CL+MmRHTTEtr37TGnq09Wl
         S0sAn9xVPuGqb3Lx7UMxe4NMScg3lJz3V6D6me2eKxJJeTSdouPDXbfnJOd4LXBRB+
         +1WxgPuDwsVQ36mEWt13G7T548B1dN6bg0IbR6e8tRKfjQAhj0YzIBmL8uTpf1NKu0
         6DfGERiVrsAIcRX+AcpqROyQudSwNRN/GjLIIZbBW8B0WINSyU4dHwZtTQ/60k9GsP
         SXd+7GqlrWSqQ==
X-Nifty-SrcIP: [209.85.215.176]
Received: by mail-pg1-f176.google.com with SMTP id r1so841342pgk.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 20:03:57 -0700 (PDT)
X-Gm-Message-State: AOAM530EG+SMg1JgfiX/CLjVOLbl6aZz17QJB0rB1jOfQmaBfnTB/uK2
        CY5W32Zdd14JM/gQZPBQjkna1iG9zNmXjVBHIvk=
X-Google-Smtp-Source: ABdhPJzyaynMWDWGIhE6UGgD41oOv2YmkFzgxPr65GEyxXmAqkJKPHYl/k/4c+BN2DzvRfdT7waoohR0IKkVeT1Q1DU=
X-Received: by 2002:a05:6a00:158d:b029:2e0:6ae2:17b1 with SMTP id
 u13-20020a056a00158db02902e06ae217b1mr12708778pfk.76.1621652637185; Fri, 21
 May 2021 20:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210520231821.12272-1-maciej.falkowski9@gmail.com>
 <20210520231821.12272-2-maciej.falkowski9@gmail.com> <CAKwvOd=32_yNvAWRjyczOoEjsWje9SfaB=S1s9kS1bRFZhuU8g@mail.gmail.com>
In-Reply-To: <CAKwvOd=32_yNvAWRjyczOoEjsWje9SfaB=S1s9kS1bRFZhuU8g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 22 May 2021 12:03:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQtnX6x1AWUU8+7MtUo4OkCrhKjoP=w0-cbH08u__wGWg@mail.gmail.com>
Message-ID: <CAK7LNAQtnX6x1AWUU8+7MtUo4OkCrhKjoP=w0-cbH08u__wGWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile: clang-tools: Omit printing stack trace when
 KeyboardInterrupt is raised
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Maciej Falkowski <maciej.falkowski9@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 2:18 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, May 20, 2021 at 4:18 PM Maciej Falkowski
> <maciej.falkowski9@gmail.com> wrote:
> >
> > When user terminates the script (also implicitly through for example
> > `make clang-analyzer`) by using
> > Ctrl+C (or sending SIGINT more generally) the KeyboardInterrupt
> > is raised printing stack trace of the execution as shown below:
> >
> > $ ./scripts/clang-tools/run-clang-tools.py clang-tidy ./compile_commands.json
> > ^CTraceback (most recent call last):
> >   File "./scripts/clang-tools/run-clang-tools.py", line 74, in <module>
> >     main()
> >   File "./scripts/clang-tools/run-clang-tools.py", line 70, in main
> >     pool.map(run_analysis, datastore)
> >   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 364, in map
> >     return self._map_async(func, iterable, mapstar, chunksize).get()
> >   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 765, in get
> >     self.wait(timeout)
> >   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 762, in wait
> >     self._event.wait(timeout)
> >   File "/usr/lib64/python3.8/threading.py", line 558, in wait
> > Process ForkPoolWorker-6:
> > Process ForkPoolWorker-1:
> > Process ForkPoolWorker-5:
> > Process ForkPoolWorker-7:
> > Process ForkPoolWorker-2:
> > Process ForkPoolWorker-3:
> > Process ForkPoolWorker-4:
> > Process ForkPoolWorker-8:
> >     signaled = self._cond.wait(timeout)
> >   File "/usr/lib64/python3.8/threading.py", line 302, in wait
> >     waiter.acquire()
> > KeyboardInterrupt
>
> With this applied,
> $ make LLVM=1 LLVM_IAS=1 -j72 clang-analyzer
> ^C
> Process ForkPoolWorker-5:
> make: *** [Makefile:1902: clang-analyzer] Error 130
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks for the patch!


I am not a python expert, but is
"Let's suppress back-trace when a user presses an interrupt"
the common coding style?

If really so, do we need to do something similar in all python scripts?
I do not know what is special about run-clang-tools.py.

For example, if I press Ctrl-C while building Clang
by using tc-build, I see a back-trace.
I have never thought back-tracing was annoying.

The exit code is 130 regardless of this patch.


BTW, I prefer not having "Makefile:" in the patch subject
since this is not touching Makefile at all.

I rather like "clang-tools:" or "scripts/clang-tools:".







> > The patch handles the raise of the KeyboardInterrupt and exits when occurred
> > with code 130 as documented in: https://tldp.org/LDP/abs/html/exitcodes.html
> >
> > Signed-off-by: Maciej Falkowski <maciej.falkowski9@gmail.com>
> > ---
> >  scripts/clang-tools/run-clang-tools.py | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> > index 38fc311d2e03..eb0e0ecfce24 100755
> > --- a/scripts/clang-tools/run-clang-tools.py
> > +++ b/scripts/clang-tools/run-clang-tools.py
> > @@ -77,4 +77,7 @@ def main():
> >
> >
> >  if __name__ == "__main__":
> > -    main()
> > +    try:
> > +        main()
> > +    except KeyboardInterrupt:
> > +        sys.exit(130)
> > --
> > 2.26.3
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--
Best Regards
Masahiro Yamada
