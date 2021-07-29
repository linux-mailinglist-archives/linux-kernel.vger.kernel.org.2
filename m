Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D83DA6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhG2Ox1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbhG2Ox0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:53:26 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C68C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:53:23 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x15so8743183oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rz/FWXWJIdJs5D3kcgNlgtx454VDwz/C1hhNbH4bMzk=;
        b=Ze6QRgWWb+lHbCY6+Wyvvr0cQrSGAnwY9AXf9xUDEpUQUO1Ks0zjzXgSbTKHZg9hvO
         euLDod7XoiygnT0oSQy0EKMXpk1ON9ykY3Lrb/fUkGn17DmUp6w8OHwcTrO/8cYPLIRD
         GQkxPchndEqXYyWvf2TIX62aEKymSqs2u2LyLMOHRaeYSEN6Ho2XicNfyTG6WcciJQ3f
         zcZBq0hf7UMaBk/qk+6us732yAvw5ypvzIDZMMjg7gLPdYAkjmASk+S1tzhO819ignh1
         4iANoJp2IOmW0nie5yGsr1MrmDXZtbJklSdQ9y7hA3ZPYkOZMPRLWAjFtAKiJw3qsC62
         Ltaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rz/FWXWJIdJs5D3kcgNlgtx454VDwz/C1hhNbH4bMzk=;
        b=H5Wz33wILnp2eb8ZVtL2+KMTU+XyDZqSglFGaXZNJdccPbKVadIZk9aNbNj8/tBZUX
         msYjIjcNScBUcB7pnhhrz1USvVqoFSokyvOXYVA5ve45Ur0A+X/lZ7ION1HtMUzsg7r4
         P+qpcJB5ZmdGLTxAvpUnAM8NLTPJt/SdF4LrYLPxs/JjziANOg6T0PJmXiBgC9rYQffz
         Mm3p/cIwk/EK89XAhpFkW5FDut+e5B2IpQuL3EjD4Z3eU9eTmgAYnmORG89KMJEvtOth
         8tYrU/GE866RSeMJq3dWz7y2opLqGnqRfomy/8pFcmKkCC7+VNDjYf0m2WRXS3UhLTHM
         Q5Uw==
X-Gm-Message-State: AOAM532ahXVkNCwhVA7NA35nn3o1XWQmbHyOrR7oiUEao5h/lyTIGD1U
        9Ovs8QvZv/nwdOmRE4/Vt3KwCK5VkrkNSiRiEUTwTQ==
X-Google-Smtp-Source: ABdhPJx4KJ3VVPzhGKpY3n3A8ZLZOnyaUppNX9EeEqvRHtpVVtWmK+nQ9CHP4axrhg6dc+asDlMOcSvW/EBjUzylFro=
X-Received: by 2002:aca:c402:: with SMTP id u2mr3281466oif.121.1627570402255;
 Thu, 29 Jul 2021 07:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210729142811.1309391-1-hca@linux.ibm.com>
In-Reply-To: <20210729142811.1309391-1-hca@linux.ibm.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 29 Jul 2021 16:53:10 +0200
Message-ID: <CANpmjNM=rSFwmJCEq6gxHZBdYKVZas4rbnd2gk8GCAEjiJ_5UQ@mail.gmail.com>
Subject: Re: [PATCH] kcsan: use u64 instead of cycles_t
To:     Heiko Carstens <hca@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Paul

On Thu, 29 Jul 2021 at 16:28, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> cycles_t has a different type across architectures: unsigned int,
> unsinged long, or unsigned long long. Depending on architecture this
> will generate this warning:
>
> kernel/kcsan/debugfs.c: In function =E2=80=98microbenchmark=E2=80=99:
> ./include/linux/kern_levels.h:5:25: warning: format =E2=80=98%llu=E2=80=
=99 expects argument of type =E2=80=98long long unsigned int=E2=80=99, but =
argument 3 has type =E2=80=98cycles_t=E2=80=99 {aka =E2=80=98long unsigned =
int=E2=80=99} [-Wformat=3D]
>
> To avoid this simple change the type of cycle to u64 in
> microbenchmark(), since u64 is of type unsigned long long for all
> architectures.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Marco Elver <elver@google.com>

Do you have a series adding KCSAN support for s390, i.e. would you
like to keep it together with those changes?

Otherwise this would go the usual route through Paul's -rcu tree.

Thanks,
-- Marco

> ---
>  kernel/kcsan/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index e65de172ccf7..1d1d1b0e4248 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -64,7 +64,7 @@ static noinline void microbenchmark(unsigned long iters=
)
>  {
>         const struct kcsan_ctx ctx_save =3D current->kcsan_ctx;
>         const bool was_enabled =3D READ_ONCE(kcsan_enabled);
> -       cycles_t cycles;
> +       u64 cycles;
>
>         /* We may have been called from an atomic region; reset context. =
*/
>         memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20210729142811.1309391-1-hca%40linux.ibm.com.
