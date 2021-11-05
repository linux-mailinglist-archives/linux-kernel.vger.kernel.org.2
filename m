Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D634469C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhKEUie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhKEUic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:38:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D2C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:35:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v15so9792236ljc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9qbelhhsw3oFrUlIgF9/qeZ03Ntzp3KJEfhun8kseA=;
        b=AusmWqPzUH3kaoEHyvmF0MYkCUsUGWRicOXc055M3GVFviwOU4QPIwlu9uVIDJaOQP
         qvwAGqnVFgJ2mYDBj3nDfHUl1Rmq11m/Vq/NFprESDAKrSoJFtr8ftNZtpOzoHMnUR2p
         cVVLYytSUHqmPQ8vkYLjbYEvMWjh0Ft/9lvYfyMsauOEdYy/Vy/xrnHS+7U8BHdrXnpr
         1CyD14Qiw48hreUk94QwKKW5V3OkJjPuwAmobKm1QFRNYFWa69bo0Q3PLwRT3bqo9YIV
         MUEHh9L9Dg/s0vb04siBjet2Xvjw9vOhdtK9tyrN4wr8JdlHG6Zsrbgq8lipIqKGzYeE
         yTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9qbelhhsw3oFrUlIgF9/qeZ03Ntzp3KJEfhun8kseA=;
        b=mNo8AVjMpBs2C5aig1/Nzrq6SxIjzti2TvX7CS5y7i5JtVPKNWe5yClXGxTXoWHQOr
         35Z2yhcoBFzqVtif9C99rp74TZhO1tN4FzjKCbiSajvWL8gWAlSh+xPHUoME+qcpsSSc
         J1oIf9FiIDUkTh2a12QqiF6BgUFRony69Y9iKAK/k/xh2fsB+qwNsr9x5XDVRwBTD6ZW
         M5b72/NvKV+5GUKlwh8q2HjhY9cvar3TWkzC9Z9inyngmZzt5UTZovugCbbDfVirYv8D
         Mw2MD6VXKzDWzcANgcN5OnFOfkTtLU0c8po9+z7m+z7/M10kaDj85Q00UbiKKVk+EBT6
         sfWw==
X-Gm-Message-State: AOAM533KEayHyQB7INkay8mJ7mhIm+gwU7l6W7Lln/9SBsN/URTP6EAT
        jrmtx1WjW9hLhMRy+ycJudXmoGfBONmmsiEU1OO92A==
X-Google-Smtp-Source: ABdhPJySLtWybIH3YPm9dxDIImgkKHXCgX75l5eN7Z7plkjpTrw1p3bbL/SBU4FYmCJSNfLg2rH5/OiyjSAnEzLhgyo=
X-Received: by 2002:a2e:87d5:: with SMTP id v21mr1807937ljj.128.1636144550723;
 Fri, 05 Nov 2021 13:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211105163137.3324344-1-anders.roxell@linaro.org> <20211105163137.3324344-2-anders.roxell@linaro.org>
In-Reply-To: <20211105163137.3324344-2-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:35:39 -0700
Message-ID: <CAKwvOd=rRntVgYdqEeb=JAYo2iC-wVB3dkQWNvwdZdrYgt2s7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: timens: exec: use 'labs()' over 'abs()'
To:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>
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
> exec.c:33:8: error: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
>                         if (abs(tst.tv_sec - now.tv_sec) > 5)
>                             ^
> exec.c:33:8: note: use function 'labs' instead
>                         if (abs(tst.tv_sec - now.tv_sec) > 5)
>                             ^~~
>                             labs

Careful.

Isn't the tv_sec member of `struct timespec` a `time_t` which is 32b
on 32b hosts and 64b on 64b hosts? If I'm recalling that correctly,
then this patch results in a harmless (though unnecessary) sign
extension for 32b targets. That should be fine, but someone like Arnd
should triple check if my concern is valid or not.

So I'm in favor of this patch (dispatching to abs or labs based on 64b
host) would hurt readability.

>
> The note indicates what to do, Rework to use the function 'labs()'.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/timens/exec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
> index e40dc5be2f66..d12ff955de0d 100644
> --- a/tools/testing/selftests/timens/exec.c
> +++ b/tools/testing/selftests/timens/exec.c
> @@ -30,7 +30,7 @@ int main(int argc, char *argv[])
>
>                 for (i = 0; i < 2; i++) {
>                         _gettime(CLOCK_MONOTONIC, &tst, i);
> -                       if (abs(tst.tv_sec - now.tv_sec) > 5)
> +                       if (labs(tst.tv_sec - now.tv_sec) > 5)
>                                 return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
>                 }
>                 return 0;
> @@ -50,7 +50,7 @@ int main(int argc, char *argv[])
>
>         for (i = 0; i < 2; i++) {
>                 _gettime(CLOCK_MONOTONIC, &tst, i);
> -               if (abs(tst.tv_sec - now.tv_sec) > 5)
> +               if (labs(tst.tv_sec - now.tv_sec) > 5)
>                         return pr_fail("%ld %ld\n",
>                                         now.tv_sec, tst.tv_sec);
>         }
> @@ -70,7 +70,7 @@ int main(int argc, char *argv[])
>                 /* Check that a child process is in the new timens. */
>                 for (i = 0; i < 2; i++) {
>                         _gettime(CLOCK_MONOTONIC, &tst, i);
> -                       if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
> +                       if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
>                                 return pr_fail("%ld %ld\n",
>                                                 now.tv_sec + OFFSET, tst.tv_sec);
>                 }
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
