Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD5459FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhKWKMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhKWKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:12:51 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730DBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:09:43 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v22so19308449qtx.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mtuMlpt4ohIkpQN6Xh6FxPj3xbgP5bBSF7XYuviEPZU=;
        b=NaqNVJ7EUYxGBODwkbcim8Vay/2aeIY4axpoj0OCHvdwSwqW5L6gIeGzqreaAo43Th
         9Y+JjCsRzPpIlZmv1boK4px4vGL5n43XE0SZHipQheuHaApqBKOaZuHZNyKvEUb6JG9z
         D3jsiMfeYMJ/Ue7qvxfqWrv7Jmxh+OR9mr8Wl4GRK/VVLl6O3fl8QoEbsbTa4vGXgsa6
         ixD2AVnSTZh/cwXPouflUcOP1+OhJTb1YRxaSqGHeDnCrUAEa7NcEb9608yLY6afIXTq
         HqR1xYdI94qUGjFCtdPHCm2AYnK0rUnnzczkNIBItBB9GLyF5ylw0z817s8ebVKZUxWD
         JCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mtuMlpt4ohIkpQN6Xh6FxPj3xbgP5bBSF7XYuviEPZU=;
        b=STbpFlj1HuBey4qnvZ5TAJ52H3ha80NOalFO5yTjWYDkl3HBUdOk7udb5/CYRib9QX
         +ejGLxC4AkXH4F/SyvTW/UylzD1HuIzORypG+6KobyV7WfCUvKpq7O+jyjGSwsC9Z3CI
         q5fiUvST5An7RQXEf1ledlf73B3Gx+5SEG+itRH2obsj+tm0QIUNYX2Ov3M57UcPFayQ
         kFA3/WhcNVPsDyD2PFDH7uAioDyIXIXs+yXsIXVgnba+Kc53E6iyan0MTAMW96nvI8V+
         MGBeAR05cv0hV9RR4kTJUoFkYR6IIG21ZbJv+Ndu+dNgD+aBCZ8XCJrPQoKSgr9qTHlH
         J65Q==
X-Gm-Message-State: AOAM531BEUAY0KLpnf7vdmob1Nwe+pRCTxQJvC7AkhTOlmd2TAD3JNkS
        EVBgYKnmODHiKxWNjXxcS+r5O5RRp5jowxqKU81dSg==
X-Google-Smtp-Source: ABdhPJy4u9mYrnz15jGtUEipitPlUwY+pFzG0QNGRX/8h5EjhiEzk5eLgZmdQJnadpSo/pkY8hbQQbzoV0x8JUcOAOs=
X-Received: by 2002:a05:622a:1045:: with SMTP id f5mr4753990qte.319.1637662182323;
 Tue, 23 Nov 2021 02:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20211123051658.3195589-1-pcc@google.com> <20211123051658.3195589-2-pcc@google.com>
 <CACT4Y+bNA7NocP_wG+FKVPKEygWWbq4E0Zrw5bn47KvCwgQXAg@mail.gmail.com>
In-Reply-To: <CACT4Y+bNA7NocP_wG+FKVPKEygWWbq4E0Zrw5bn47KvCwgQXAg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 23 Nov 2021 11:09:05 +0100
Message-ID: <CAG_fn=XnLANd=FBYuW_MvhCqZBGczfNqk0cBmQdXgra81LT+nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] fs: use raw_copy_from_user() to copy mount() data
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 8:51 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, 23 Nov 2021 at 06:17, Peter Collingbourne <pcc@google.com> wrote:
> >
> > With uaccess logging the contract is that the kernel must not report
> > accessing more data than necessary, as this can lead to false positive
> > reports in downstream consumers. This generally works out of the box
> > when instrumenting copy_{from,to}_user(), but with the data argument
> > to mount() we use copy_from_user() to copy PAGE_SIZE bytes (or as
> > much as we can, if the PAGE_SIZE sized access failed) and figure out
> > later how much we actually need.
> >
> > To prevent this from leading to a false positive report, use
> > raw_copy_from_user(), which will prevent the access from being logged.
> > Recall that it is valid for the kernel to report accessing less
> > data than it actually accessed, as uaccess logging is a best-effort
> > mechanism for reporting uaccesses.
> >
> > Link: https://linux-review.googlesource.com/id/I5629b92a725c817acd9a861=
288338dd605cafee6
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> >  fs/namespace.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 659a8f39c61a..695b30e391f0 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -3197,7 +3197,12 @@ static void *copy_mount_options(const void __use=
r * data)
> >         if (!copy)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       left =3D copy_from_user(copy, data, PAGE_SIZE);
> > +       /*
> > +        * Use raw_copy_from_user to avoid reporting overly large acces=
ses in
> > +        * the uaccess buffer, as this can lead to false positive repor=
ts in
> > +        * downstream consumers.
> > +        */
> > +       left =3D raw_copy_from_user(copy, data, PAGE_SIZE);

I don't really like the idea of using raw_copy_from_user() anywhere.
Right now users of instrumented.h can more or less assume they see all
usercopy events, and removing the copy_from_user() call from here
looks like a regression.

Cannot the usercopy logger decide whether it wants to log the access
based on the size (e.g. skip accesses >=3D PAGE_SIZE)?
Will it help if we can instrument both sides of copy_from_user() (see
the code here: https://linux-review.googlesource.com/c/linux/kernel/git/tor=
valds/linux/+/14103/4)?

If not, maybe we can disable/enable uaccess logging for the current
task around these accesses?

> This will skip KASAN/etc checks as well, right? I guess it is fine b/c
> this affects just this place and the code looks safe (famous last
> words :)) and we can refine it in future.
> But I wonder about false positives under KMSAN. However, we probably
> can add an explicit KMSAN annotation to mark it as initialised.
> Alex?
>
> >         /*
> >          * Not all architectures have an exact copy_from_user(). Resort=
 to
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
> >



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
