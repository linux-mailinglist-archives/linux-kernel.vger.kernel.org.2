Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5939F446980
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhKEUSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhKEUSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:18:10 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A008C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:15:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r10so15664938ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqHVphJRsOg0vKmfYa1jZpyPe0YWBaEezxPZReK1I2E=;
        b=q3+yzE4Ow/m3lzoIN5PdiNgUFMQTre/b366H7VJROVrX586YFvc+IpOpRL+A1pvhyC
         7hT0LiAUOMJwChlqcl/K6n31dpkV9ts/wlePBoiCsRsaV1LqAlXVOR/1/WPoo51Rvhcg
         25YUDAfVHtUI0aGA9g0d89LOb62SYS2YcBB1kQi7M61dwdUD+TbLCtvbhgLh0x2e1XyM
         UtWDhCigDX7keyPmOeCyzCrQM1v9girHXVB8oLtgV7YhVsNBRGjpi/ZXiEyU8NNkWyqO
         nuWtoSWyypnCpWS3ZCepa1wAk6daF1uj1hm/+E8zU9Sot8GUO0ELieZQ+rsibt7Ssski
         mkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqHVphJRsOg0vKmfYa1jZpyPe0YWBaEezxPZReK1I2E=;
        b=uvPC4ZCeIokM7xOxuyYGoB7MBke5Otbn9Z9HfWaNXtAjr2gmGToDrantWHLejRwJjO
         eK/+v4gqocMs6Arfq7NuqTSN77eGwd3bMACOKeCv3GXtz0QOFBc9TKBUBI+CijmmR4/R
         uEdq3ewGTkHA5w+85W+EDxyKvk2rJyu8cnq87eP6mc9zwa9Gi+H3Zna7NgXOvpPoUiCk
         REn9RO6NV5edSSvBVrmbdJrTW6SeCwT7OSsqfEOd6ws85q3PqwrLaH/vUkH9z5FNDeVZ
         fOrq7fTg3R23T9syGSEeBiTMZKpkbO6pIT+33eZiH+hj8Qh4kjm2XltTMvsvmt+/+B3M
         Ql9Q==
X-Gm-Message-State: AOAM532HX2PFkCLh3Y139PYhwHnuL8lBqwIhbNMo96fKO7HfZVK7ljtG
        t1tCJlP2vUnQN+6/1s+3AOrD2AzNXqzzjJEMnAptUw==
X-Google-Smtp-Source: ABdhPJwZ2tz6jaVRxkOgVp+jl8s6Gk3iTKD+Q0XS0ogAGfwSz3i/LFHq01irNF29i/MrlLZz7O3KVOKoMYGqjyS7zVw=
X-Received: by 2002:a05:651c:889:: with SMTP id d9mr63754997ljq.198.1636143328368;
 Fri, 05 Nov 2021 13:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211105162530.3307666-1-anders.roxell@linaro.org> <20211105162530.3307666-2-anders.roxell@linaro.org>
In-Reply-To: <20211105162530.3307666-2-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:15:17 -0700
Message-ID: <CAKwvOd=Qdt7Wd1fL-vhheZjcNonqBaxbJwVamG3Q-eMy+A=2KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: cgroup: use function 'labs()' over 'abs()'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, christian@brauner.io, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 9:25 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/cgroup with clang, the compiler warn about the
> function abs() see below:
>
> In file included from test_memcontrol.c:21:
> ./cgroup_util.h:16:9: warning: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Wabsolute-value]
>         return abs(a - b) <= (a + b) / 100 * err;
>                ^
> ./cgroup_util.h:16:9: note: use function 'labs' instead
>         return abs(a - b) <= (a + b) / 100 * err;
>                ^~~
>                labs
>
> The note indicates what to do, Rework to use the function 'labs()'.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/cgroup/cgroup_util.h | 2 +-
>  tools/testing/selftests/cgroup/test_kmem.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
> index 82e59cdf16e7..76b35d9dffb5 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/cgroup_util.h
> @@ -13,7 +13,7 @@
>   */
>  static inline int values_close(long a, long b, int err)
>  {
> -       return abs(a - b) <= (a + b) / 100 * err;
> +       return labs(a - b) <= (a + b) / 100 * err;
>  }
>
>  extern int cg_find_unified_root(char *root, size_t len);
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> index 22b31ebb3513..d65bb8fe876a 100644
> --- a/tools/testing/selftests/cgroup/test_kmem.c
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -192,7 +192,7 @@ static int test_kmem_memcg_deletion(const char *root)
>                 goto cleanup;
>
>         sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
> -       if (abs(sum - current) < MAX_VMSTAT_ERROR) {
> +       if (labs(sum - current) < MAX_VMSTAT_ERROR) {
>                 ret = KSFT_PASS;
>         } else {
>                 printf("memory.current = %ld\n", current);
> @@ -383,7 +383,7 @@ static int test_percpu_basic(const char *root)
>         current = cg_read_long(parent, "memory.current");
>         percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
>
> -       if (current > 0 && percpu > 0 && abs(current - percpu) <
> +       if (current > 0 && percpu > 0 && labs(current - percpu) <
>             MAX_VMSTAT_ERROR)
>                 ret = KSFT_PASS;
>         else
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
