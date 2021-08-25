Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B993F73E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbhHYK7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbhHYK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:59:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901DC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:58:19 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x5so19381793qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=814QjR6zkCfIOSzonK+alcyMN9fiwOlsyyZrKehQu1g=;
        b=K6fcAHHWrAgkmEvAF4Uj+VXADPTnvvoOnrQsAaxiUpZx4hwJVG58U6qms9C6C8jSar
         jIK6i7ABOusI7HQR/1V4EdwSDx3AsTjojs4by6/6P4Sgt6SCevsOGab4ba0U3c/wAJ+M
         8kIMceHhMRdGYOk2x2e2W2o2CuPJ3jdJx70MBKtG0WjHwXh/y4/RgzRxuimYNdYUUtfP
         pow+lKGn2eRt5l3bO9WALlTeW1wDQXdjLGH2eMLxc1P4Y0ab0W/kST0aFf9vL2Qi+OLP
         Jy9fGnACyIq9PiRdUF7oEYCB2i8URA8Q12klTkR2FW32CxIIXTYtWIGIl6NJW2RZ6iL1
         M1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=814QjR6zkCfIOSzonK+alcyMN9fiwOlsyyZrKehQu1g=;
        b=B0m/+sgRdmRATkKJ+wxYKAFHYpWltYMOB2bcV33Kwz61D1Bw5vW9aCnEYYjowb8PVR
         oJP86flZxI7jLncc3u/m3D+kkNAh6x5GRD3/8018xXrVFfx4pKGRFOTvTtIGlvh1ruvF
         PpSg4hYC2zaDwv6PLlN5i+CNdT8C9B5qt6/d1AmBrtMVyuJEnT+YIkDT/y4ASl2RaHLX
         wb2dTHT42Cp4AFwuj4bpSgSnzuy6mmNIVmJIdYXk2ySYznoo+nW7aB/m6WMyG5uH/Ch1
         mxnvtR76QX9WwyusBTSKyyFVvnUpCZbeFo/WlP3w2iqZQRvBdg6ArvoWnYVzONLqRAEd
         Gfag==
X-Gm-Message-State: AOAM531j9orp260TVpyB8nYboj9g+yqrzGe55fdTv/B/TJxYY79t6nKB
        bEJreZwc48n9CDzod4Dkpl1hS+33xh8Fa+cWyalPEg==
X-Google-Smtp-Source: ABdhPJzHp8DWDytoQbbdL51Uh4LBATWm/OEylGryBMp5ckAmpks/IrQOnyJ/0aufv06FDV/McCTEPVmBeB6W0EnZcEw=
X-Received: by 2002:ac8:46cd:: with SMTP id h13mr39096818qto.369.1629889098034;
 Wed, 25 Aug 2021 03:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210825105533.1247922-1-elver@google.com>
In-Reply-To: <20210825105533.1247922-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 25 Aug 2021 12:57:41 +0200
Message-ID: <CAG_fn=VMqbOwDkpae02EsE4QoEk_vbW3sM0KzsXWLDceOYGSzA@mail.gmail.com>
Subject: Re: [PATCH] kfence: test: fail fast if disabled at boot
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:55 PM Marco Elver <elver@google.com> wrote:
>
> Fail kfence_test fast if KFENCE was disabled at boot, instead of each
> test case trying several seconds to allocate from KFENCE and failing.
> KUnit will fail all test cases if kunit_suite::init returns an error.
>
> Even if KFENCE was disabled, we still want the test to fail, so that CI
> systems that parse KUnit output will alert on KFENCE being disabled
> (accidentally or otherwise).
>
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>


> ---
>  mm/kfence/kfence_test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index eb6307c199ea..f1690cf54199 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -800,6 +800,9 @@ static int test_init(struct kunit *test)
>         unsigned long flags;
>         int i;
>
> +       if (!__kfence_pool)
> +               return -EINVAL;
> +
>         spin_lock_irqsave(&observed.lock, flags);
>         for (i =3D 0; i < ARRAY_SIZE(observed.lines); i++)
>                 observed.lines[i][0] =3D '\0';
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
