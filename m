Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB90B4469A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhKEU3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhKEU3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:29:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E2CC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:27:02 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id t11so16886550ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wyUo/ZQtCQyVodL9pugyYugqUauw4Uj0CoamGRaoTo=;
        b=jDVwGOof8/gm/IIUo7XhzEjXEtnollc06Ebj3pcM+qgJ3GUFaKtvAHx5MtjHxwLSh7
         RqVxjAMaKz7jc3OnM33zlboH5YsD3D0dlSufzoc9KmJ4MCY0X7fu4xuo5UMJmmkWgA5X
         jM+TNwOVDhcOmez5CXM0vck43rEdQQ5YLqx21u342gnRHhpvwiWbsBO8Vj82mBgrvl2m
         Lq90Gxff2LKTw9L/BmpkKg21+Bp2ADNb9LhC1V2B7PWkp405StxP7Ax3XYodwwa9+O4s
         iIq307MIXAeGJX2svn0y+u8SO4VVcF/SbR4oryd52a4pitv21E4htnP31gP9R25jU00A
         rZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wyUo/ZQtCQyVodL9pugyYugqUauw4Uj0CoamGRaoTo=;
        b=RsCZ3Q5qNDQSQQQ2RC+oAT5qvTj4rVsTBtlAkspKj91QAn+Cwox9wHj1yqnSzdVv4B
         WxPWmErZVV/ttp2OGttg7EDwMW15fD7Ps+sm1xvQoIkDrzNYNierpaQOct2m8zp2Mzy+
         QjXqob0sABaPjo3JkKlhUcit0bMEFqBRrsnJxv76k2AlxheTXd/HXrTwlC/6p0Tiyl6z
         V7eC0MuDazJbylW3VVcAa4A/taHNC8+PCkbwZaT79BmaAavI8Hy1c2M518zzDA2Cl2kO
         dr8sP7rBqGTyJtUePvk3Z/tbzMpL6ssalX9tpDs9iS2BoaD0otIhuYjOmaEobpeRm6zd
         sfJA==
X-Gm-Message-State: AOAM5313PVc0MhKoPfUv1jxr/JcxNmWlyZPm8ySQ3yQGyhtCYHdu4NMf
        1teqSiZA6rU7ryoteMhENi3AdJwIhJGMg8lLaaewIQ==
X-Google-Smtp-Source: ABdhPJyeR/MQfc6Wj3DYsKJsPEiSVQY5rZ/UIDydLAnjBCIuEikkBi11cb68jlY8MjNhmB8Vdb1+AQZeA2azlXDwqv8=
X-Received: by 2002:a2e:750e:: with SMTP id q14mr64381888ljc.338.1636144020678;
 Fri, 05 Nov 2021 13:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211105163137.3324344-1-anders.roxell@linaro.org>
In-Reply-To: <20211105163137.3324344-1-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:26:49 -0700
Message-ID: <CAKwvOdnge-hBmoFH-CHZmbh7DTq8bQiyhbfEOWkBt447=e6QGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: timens: use 'llabs()' over 'abs()'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 9:31 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/timens with clang, the compiler warn about the
> function abs() see below:
>
> timerfd.c:64:7: error: absolute value function 'abs' given an argument of type 'long long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
>                 if (abs(elapsed - 3600) > 60) {
>                     ^
> timerfd.c:64:7: note: use function 'llabs' instead
>                 if (abs(elapsed - 3600) > 60) {
>                     ^~~
>                     llabs
>
> The note indicates what to do, Rework to use the function 'llabs()'.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/timens/timer.c   | 2 +-
>  tools/testing/selftests/timens/timerfd.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
> index 5e7f0051bd7b..5b939f59dfa4 100644
> --- a/tools/testing/selftests/timens/timer.c
> +++ b/tools/testing/selftests/timens/timer.c
> @@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
>                         return pr_perror("timerfd_gettime");
>
>                 elapsed = new_value.it_value.tv_sec;
> -               if (abs(elapsed - 3600) > 60) {
> +               if (llabs(elapsed - 3600) > 60) {
>                         ksft_test_result_fail("clockid: %d elapsed: %lld\n",
>                                               clockid, elapsed);
>                         return 1;
> diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
> index 9edd43d6b2c1..a4196bbd6e33 100644
> --- a/tools/testing/selftests/timens/timerfd.c
> +++ b/tools/testing/selftests/timens/timerfd.c
> @@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
>                         return pr_perror("timerfd_gettime(%d)", clockid);
>
>                 elapsed = new_value.it_value.tv_sec;
> -               if (abs(elapsed - 3600) > 60) {
> +               if (llabs(elapsed - 3600) > 60) {
>                         ksft_test_result_fail("clockid: %d elapsed: %lld\n",
>                                               clockid, elapsed);
>                         return 1;
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
