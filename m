Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F23FA47F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhH1IY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 04:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhH1IY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 04:24:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DA1C0613D9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 01:24:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f2so15895993ljn.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SyxSTDORI/8M4AERtcsdRdIUyJ2TeIzi/T8dD70iLxQ=;
        b=j2PQOEMxcHXxsJe18inN4YfzVn+rH0fKwUv/j3RPljlPoNikkKagHxgU3UPVOWHucb
         N63V3cz6yu5BShYtJFn9jcWF3nS3jPa3wJybPrUosAiBhpUi3AinmhQ9CxmfuWx5fQul
         P1Daz5iR7uUS+EGlyOoiV8Cb38+s0Kb654WnUgcUwNL55EAU1i1zlA8Qsn33Kbm6M24u
         YYgSLft5yoJmIqB7n7aHU3ErPWOaFRhGW8NjWm81dZSKxZW5C/JcFDRCpZh4UdyA6/8i
         8EZsXJPFcpsEBENRV+FUzkL/Gr8V4eUAmGse5qsKCaXHXMVQkGYMSuN24fggmu/soVpL
         qxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=SyxSTDORI/8M4AERtcsdRdIUyJ2TeIzi/T8dD70iLxQ=;
        b=U0F7n0FV25li4e0RlsrQBakdVN6GjppDIm6OxQRQBkI39kC+VjC9rP15VbdFXva9Wy
         P5XGMKxHqlVUbBB1gF1MmIXhxZUg2wYW+QM1nIIh6crnQG/LguSTOYf959404WE6AgfC
         YfbALF7Dxmfbtcn/et8KAwLU+GzlR/pKRs2Vh+UGrCXma7FrFeNoFxjS+BpUbe7UFFiH
         R8rWSi9JzMjnFZXinrKw7WVL7ymxkjwxOXSR0KQ0iJakwW8zi3n9awOy8NKBvEve5rzb
         Nw8K2DVMFB3UNEle3bLDwsPnZR94dIowOJcdQ/CyjnwR+Rp565zqbeFYm7WX0iosIefI
         1GlQ==
X-Gm-Message-State: AOAM530DrTg6he3V5ljN6Tysa98D6cPkZdDRJszreciOpRI4TD492nN3
        6KO7mbZzXgfz8wn7Ub7h/PFAo0OoJzKP99/oaNvIbXVe8ECDRg==
X-Google-Smtp-Source: ABdhPJwP5pqeyE9fqLgEYftIPzjKFT5lxE8nI5lGLql1VwhmDF92Z8MwFpmUUyBT9oajVZqOA0yWLnf+DaKUn507RVw=
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr11337086ljp.257.1630139044155;
 Sat, 28 Aug 2021 01:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAAo+4rWyNEyoZJ1uAcg7K1ZSHrWiQQO2o_K++uPNMzp-Sy_J7Q@mail.gmail.com>
 <20210801090830.GB18001@1wt.eu> <091e487a-d458-45d4-613d-b25ca7bfc98c@fb.com>
In-Reply-To: <091e487a-d458-45d4-613d-b25ca7bfc98c@fb.com>
From:   =?UTF-8?B?5Y+25r6E6ZSL?= <dg573847474@gmail.com>
Date:   Sat, 28 Aug 2021 16:23:53 +0800
Message-ID: <CAAo+4rX-19UWda_C77goEjq1h10i4-vA=kn-9qy_GgDJVJGq4A@mail.gmail.com>
Subject: Re: Protential deadlock in linux/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yonghong Song <yhs@fb.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=882=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:56=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 8/1/21 2:08 AM, Willy Tarreau wrote:
> > Hello,
> >
> > On Sun, Aug 01, 2021 at 04:56:37PM +0800, ??? wrote:
> >> Dear Maintainers,
> >>
> >>
> >> [image: image.png]
> >> This code snippet seems to be problematic since it may cause a deadloc=
k
> >> problem.
> >>
> >> Description:
> >> When *pthread_create* in line 197 fails, *server_started_mtx* will not=
 be
> >> released. If this function is invoked again then, the executing thread=
 will
> >> stuck in line 196 for requiring an already locked mutex, which causes =
a
> >> deadlock problem.
> >>
> >> Fix suggestions:
> >> Unlock *server_started_mtx *before goto close_server_fd at line 199.
> >>
> >> CWE ID:
> >> CWE-667: Improper Locking
> >>
> >> Source code address:
> >> https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d363=
9d4772966/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c#L199
> >
> > Sorry, but how is this in any way related to security, given that it's =
in
> > self-tests programs running in userland ? In the worst case, a develope=
r
> > will experience a failure during tests where there should not be. Bette=
r
> > report this directly to the code's authors, without involving the secur=
ity
> > team. Even better, please provide a patch to fix this.
>
> Yes, this is bpf selftest bug. The fix should be straightforward as
> described in the above.
>
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
> @@ -195,8 +195,10 @@ static void run_test(int cgroup_fd)
>
>          pthread_mutex_lock(&server_started_mtx);
>          if (CHECK_FAIL(pthread_create(&tid, NULL, server_thread,
> -                                     (void *)&server_fd)))
> +                                     (void *)&server_fd))) {
> +               pthread_mutex_unlock(&server_started_mtx);
>                  goto close_server_fd;
> +       }
>          pthread_cond_wait(&server_started, &server_started_mtx);
>          pthread_mutex_unlock(&server_started_mtx);
>
> Agree with Willy, maybe you or somebody can provide a patch to fix the bu=
g?
>
> >
> > Regards,
> > Willy
> >
