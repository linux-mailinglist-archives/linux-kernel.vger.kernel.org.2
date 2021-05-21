Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6238CBD7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhEURTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhEURTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:19:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE72C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:18:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v8so25789349lft.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfCe3Mmq/4WfJ6JanDJbmMfZ9bv2HspViLWfH/Y54Xs=;
        b=FcvGu3T3fRXsNR7QX3Co2QAv4UikUqzYXXlHq185LEqZvIFy5NkPw0QgYsYCuSOnnG
         pTQyEBEAV9aGyHJbjfcPoC7sp89ceeUFUfEgTsbQ7TgsevG00JCKTd0mnFc2ktsgiDKl
         CRU8bfVI4mrSog0S7TTE9rusQGcQXE3dUzKdc7JtJT8Lc/+S0rQbzQRoSfenSdhkZVuG
         iNNQnGCJPcZLDsG+axlF+8HgRAYBpkuyazVG0QU6s0ilcGo7UHBoEHZGkjyL6lfcJ0ev
         lJHuFCyQdI0SoeLyGYTwaf/xWC3LyGTvHFK5lcn2VpIm6RbnpOaQYAJrYfxVGz4y1i/5
         D1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfCe3Mmq/4WfJ6JanDJbmMfZ9bv2HspViLWfH/Y54Xs=;
        b=uY6tXKUMAXBvwQwZo8WeW2YFWud7Wzx1dKTiyW/guVp5su8O/7PL1cOuDnCjda2yoC
         OajrOchuF4vhGdj8Y5Nk1crq3nLgwIHzZlKgCU0mthdJs9m6Bnas1mJ6d7RXP2MXGuGx
         OL2nP0/s5a3TPP7Nym90R6L1TnuOQMSHN5eDj4uTbtX/zLuMdkoGPdQMHn8UrmozhZRR
         x32P3DL2CckSlJOEvbRgD2t8v+KBtYiEX52raYTdkjo5dBdNF6NzaLooHxL/kYy3DrcD
         +R0X5b30/a0j6CI1+ZRbeQKkgTQ0lofiN0viudzu9tV46stOCOWIQ0Btj81PTuj9M723
         dClg==
X-Gm-Message-State: AOAM5315yt6Qg5tRIBB4f2sskeLLZ/prz8OOccytRaQAsXylM45wxeZ/
        +QNO94F82wANXmX4smR3Fhu/iIi+Ns9GfK4KzYNKdg==
X-Google-Smtp-Source: ABdhPJwkLMwohjT56g4aif8wI04ge/Qt9cUd62JqBCc3C2k5S6oQ//ILEe95kwYJo8d9Zs35JnoCMivKLV8yo7m3WqY=
X-Received: by 2002:a05:6512:220c:: with SMTP id h12mr2986001lfu.374.1621617483757;
 Fri, 21 May 2021 10:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210520231821.12272-1-maciej.falkowski9@gmail.com> <20210520231821.12272-2-maciej.falkowski9@gmail.com>
In-Reply-To: <20210520231821.12272-2-maciej.falkowski9@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 May 2021 10:17:52 -0700
Message-ID: <CAKwvOd=32_yNvAWRjyczOoEjsWje9SfaB=S1s9kS1bRFZhuU8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile: clang-tools: Omit printing stack trace when
 KeyboardInterrupt is raised
To:     Maciej Falkowski <maciej.falkowski9@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 4:18 PM Maciej Falkowski
<maciej.falkowski9@gmail.com> wrote:
>
> When user terminates the script (also implicitly through for example
> `make clang-analyzer`) by using
> Ctrl+C (or sending SIGINT more generally) the KeyboardInterrupt
> is raised printing stack trace of the execution as shown below:
>
> $ ./scripts/clang-tools/run-clang-tools.py clang-tidy ./compile_commands.json
> ^CTraceback (most recent call last):
>   File "./scripts/clang-tools/run-clang-tools.py", line 74, in <module>
>     main()
>   File "./scripts/clang-tools/run-clang-tools.py", line 70, in main
>     pool.map(run_analysis, datastore)
>   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 364, in map
>     return self._map_async(func, iterable, mapstar, chunksize).get()
>   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 765, in get
>     self.wait(timeout)
>   File "/usr/lib64/python3.8/multiprocessing/pool.py", line 762, in wait
>     self._event.wait(timeout)
>   File "/usr/lib64/python3.8/threading.py", line 558, in wait
> Process ForkPoolWorker-6:
> Process ForkPoolWorker-1:
> Process ForkPoolWorker-5:
> Process ForkPoolWorker-7:
> Process ForkPoolWorker-2:
> Process ForkPoolWorker-3:
> Process ForkPoolWorker-4:
> Process ForkPoolWorker-8:
>     signaled = self._cond.wait(timeout)
>   File "/usr/lib64/python3.8/threading.py", line 302, in wait
>     waiter.acquire()
> KeyboardInterrupt

With this applied,
$ make LLVM=1 LLVM_IAS=1 -j72 clang-analyzer
^C
Process ForkPoolWorker-5:
make: *** [Makefile:1902: clang-analyzer] Error 130

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch!

> The patch handles the raise of the KeyboardInterrupt and exits when occurred
> with code 130 as documented in: https://tldp.org/LDP/abs/html/exitcodes.html
>
> Signed-off-by: Maciej Falkowski <maciej.falkowski9@gmail.com>
> ---
>  scripts/clang-tools/run-clang-tools.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> index 38fc311d2e03..eb0e0ecfce24 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -77,4 +77,7 @@ def main():
>
>
>  if __name__ == "__main__":
> -    main()
> +    try:
> +        main()
> +    except KeyboardInterrupt:
> +        sys.exit(130)
> --
> 2.26.3
>


-- 
Thanks,
~Nick Desaulniers
