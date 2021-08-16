Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129503EDF13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhHPVJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhHPVJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:09:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34400C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:09:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id n6so29292704ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXHESVXtW3fAQs2klw3L8m3LsM2vjy+bWhA8ZxQLeJ4=;
        b=PckaKH/D1CzdTTCYLJ91P/GUcWYKR/Q6byFdOMVw/5VWzNKfW4RZsrebRYxzy/Y72/
         zAUVSd7bfvtrMszECKKNEWQy+0LJnjFAT6aRhPpLF1UK1t18VSTI4nCFMBDgjk/T1Cki
         gBLDu4K1tSzyHhQ/wtP5YFdmZvaji5iCEHztPcwvAUh286pMnJMFLMRkQzw2DLuwTuuh
         We95oCpLEbULXkyDSJ1wHQpakMeL9WavzZG0vl4nOwtU2ZVO89uISoNYLvda3KiJJdLV
         kFNUOq2zQS67llPo5HDbPaBarGKNSKVjB4ym8h5Oj8ijDWWZJeHzjgIkS3JleguiXg5u
         EJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXHESVXtW3fAQs2klw3L8m3LsM2vjy+bWhA8ZxQLeJ4=;
        b=rhgSsqSimJmPjoush4HAKUcuoBPNNZ9Qq0o/Y7/m+hbDbrRdhNqCIxZ0+ZsXl8zCNR
         1Qw4fkjxPlvNq4j/WQm054zUBYKxNHsR7xws0U6hRcLmIU9Xt3aCeFpvBtgIyOeuoM0S
         JNY1srzwm7lwAtjtE/M6ZN+RjDgyuVwnzRt5GzjpKWUZR7GpV6jR28NT+rCu0Qdta9qL
         2ucBiywMCA2vbY0VVFu3M1WKPAf1bgLkFoFAB9qrT6+1H5yJipyl78tBtGEdrB77Regi
         i5Z0RY84FJfacYEEgIiG1UAxVyJ3V4tFxOsgUo+mcwmGJ+w6aoMXhjwH/bl3Mk7DK8g6
         RHGg==
X-Gm-Message-State: AOAM531yVuqwt0IRxDEOIpOeZY/AaPgn220i5tobiicPrdL0AXywKqE8
        zFRG8RYNWTQomnhOWAN4MPgQIW1iXlSdMh+MUWKaJQ==
X-Google-Smtp-Source: ABdhPJwwTb1fnHHmF9oB+uKc900L02CB0EGcBYEkrJkm6ZTwwahbTwe+2ey0QWu70Oyh+NkPbFv//VO0W7jBM+EZFzc=
X-Received: by 2002:a2e:9304:: with SMTP id e4mr167248ljh.244.1629148144281;
 Mon, 16 Aug 2021 14:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210816210418.59294-1-nathan@kernel.org>
In-Reply-To: <20210816210418.59294-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Aug 2021 14:08:52 -0700
Message-ID: <CAKwvOd=usiNsmpRbfBfdCyCcLRudY4aSa72FMLX-P5bKRTH9zw@mail.gmail.com>
Subject: Re: [PATCH] selftests: Use -fno-integrated-as instead of -no-integrated-as
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 2:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> -no-integrated-as is considered the legacy flag since clang 3.5 so move
> -fno-integrated-as in case clang ever decides to remove the legacy flag.
>
> Link: https://releases.llvm.org/3.5.0/tools/clang/docs/ReleaseNotes.html#new-compiler-flags
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/rseq/Makefile  | 2 +-
>  tools/testing/selftests/sched/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 2af9d39a9716..32f503c13c61 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> -CLANG_FLAGS += -no-integrated-as
> +CLANG_FLAGS += -fno-integrated-as
>  endif
>
>  CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT) -Wl,-rpath=./ \
> diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
> index 10c72f14fea9..d84a19363a62 100644
> --- a/tools/testing/selftests/sched/Makefile
> +++ b/tools/testing/selftests/sched/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> -CLANG_FLAGS += -no-integrated-as
> +CLANG_FLAGS += -fno-integrated-as
>  endif
>
>  CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/  -Wl,-rpath=./ \
>
> base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
> --
> 2.33.0.rc2
>


-- 
Thanks,
~Nick Desaulniers
