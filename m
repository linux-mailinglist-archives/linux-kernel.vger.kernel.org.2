Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7643F37F5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 12:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhEMKzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 06:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhEMKzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 06:55:07 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA54C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 03:53:56 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so2095519otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYLCvpNZX5w1upIsGWaUJr6yD2kIWAzqUdyxsIrTylA=;
        b=Nwnt9aKW/ZDmmJAWvHm9lqFcd84egGiJ5gep5np5gp6OICHieEtC/YSJJBVuIo83mb
         gV4MEa+HpYYbXCKww67aX6II7W1neOVtp6NkMu9uA2aZfcxWdNXe7nmv94a7uD8STsMg
         9GBz3+CpwiSyWnUAkXkLN16bnJLoa6xrf+rtrGLmOwmnkKv8SSeG0TpQneX7lZMk69LS
         TCZlPlox62IZFF4ZS/gwc+T5INPiEVYlSuI3GF2lfDs7jVbRhqhKHJPVYYYR04uDH+j9
         4FKYULYfhIjziwS/y8ygv1G5KQI6J8ZCPOFmTJ9syVQmBc4MZKLkxY2G8B1yUBwohvc5
         fVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYLCvpNZX5w1upIsGWaUJr6yD2kIWAzqUdyxsIrTylA=;
        b=lR94+0b0KVmUcRTbQDIZpeRQI+6naM+G5zpzzQhcVTIT9uquW3FL8XPqxbR8mmiZ2/
         rWv2sBHXSrCEQkMx7cjJ5aoQ0jRCi7OYCdHH6GqlaP8ilyH/XARNajfeRxmE3VKxiUqw
         2MNPz4FB7Qa/aUopwbCuaplCqjtKJc75xmzV65q9FAuGDgNp0+JmK2GfhoM8rN5L3sWb
         PAw3cuO54vdSowxxD82gDvHZDWlc0/hD/ClNzFBzw4mLkgeeRjWEcARmR+z+YSo6sX5V
         /tcjDDclR1Jiv5rsbH7dJQ/kSx7Ad5lbl9tMj7dOeylrN4Mh08qLd0mVgABvbvIbpa6n
         5hdQ==
X-Gm-Message-State: AOAM531zSNVDqcDNEJ5E0HALbymccrZagXm200jVSxFsNztb/yb7hlHN
        +ekWiAdSkjnQWUA24FqpTMD1V6ss5+gxz1nP2z1fAA==
X-Google-Smtp-Source: ABdhPJwXoqW0UBLxBDPjVB9PBC6koZw3VeNM7TIhqywuz1GXeStqDyDw2mCs0ypAVVATh5/nVlcmAR80l3U9gMB2VWk=
X-Received: by 2002:a05:6830:349b:: with SMTP id c27mr17419866otu.251.1620903236141;
 Thu, 13 May 2021 03:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
 <20210511232401.2896217-1-paulmck@kernel.org> <a1675b9f-5727-e767-f835-6ab9ff711ef3@gmail.com>
In-Reply-To: <a1675b9f-5727-e767-f835-6ab9ff711ef3@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 13 May 2021 12:53:44 +0200
Message-ID: <CANpmjNM48id0b+H=PqFkCBDSyK76RFTB3Uk0mNeE2htu3v8qfw@mail.gmail.com>
Subject: Re: [PATCH tip/core/rcu 01/10] kcsan: Add pointer to
 access-marking.txt to data_race() bullet
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 at 12:47, Akira Yokosawa <akiyks@gmail.com> wrote:
>
> Hi Paul,
>
> On Tue, 11 May 2021 16:23:52 -0700, Paul E. McKenney wrote:
> > This commit references tools/memory-model/Documentation/access-marking.txt
> > in the bullet introducing data_race().  The access-marking.txt file
> > gives advice on when data_race() should and should not be used.
> >
> > Suggested-by: Akira Yokosawa <akiyks@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  Documentation/dev-tools/kcsan.rst | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> > index d85ce238ace7..80894664a44c 100644
> > --- a/Documentation/dev-tools/kcsan.rst
> > +++ b/Documentation/dev-tools/kcsan.rst
> > @@ -106,7 +106,9 @@ the below options are available:
> >
> >  * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
> >    any data races due to accesses in ``expr`` should be ignored and resulting
> > -  behaviour when encountering a data race is deemed safe.
> > +  behaviour when encountering a data race is deemed safe.  Please see
> > +  ``tools/memory-model/Documentation/access-marking.txt`` in the kernel source
> > +  tree for more information.
> >
> >  * Disabling data race detection for entire functions can be accomplished by
> >    using the function attribute ``__no_kcsan``::
> >
>
> I think this needs some adjustment for overall consistency.
> A possible follow-up patch (relative to the change above) would look
> like the following.
>
> Thoughts?
>
>         Thanks, Akira
>
> -------8<--------
> From: Akira Yokosawa <akiyks@gmail.com>
> Subject: [PATCH] kcsan: Use URL link for pointing access-marking.txt
>
> For consistency within kcsan.rst, use a URL link as the same as in
> section "Data Races".
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>

Good catch. I'd be in favour of this change, as it makes it simpler to
just follow the link. Because in most cases I usually just point folks
at the rendered version of this:
https://www.kernel.org/doc/html/latest/dev-tools/kcsan.html

Acked-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kcsan.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index 80894664a44c..151f96b7fef0 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -107,8 +107,7 @@ the below options are available:
>  * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
>    any data races due to accesses in ``expr`` should be ignored and resulting
>    behaviour when encountering a data race is deemed safe.  Please see
> -  ``tools/memory-model/Documentation/access-marking.txt`` in the kernel source
> -  tree for more information.
> +  `"Marking Shared-Memory Accesses" in the LKMM`_ for more information.
>
>  * Disabling data race detection for entire functions can be accomplished by
>    using the function attribute ``__no_kcsan``::
> @@ -130,6 +129,8 @@ the below options are available:
>
>      KCSAN_SANITIZE := n
>
> +.. _"Marking Shared-Memory Accesses" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> +
>  Furthermore, it is possible to tell KCSAN to show or hide entire classes of
>  data races, depending on preferences. These can be changed via the following
>  Kconfig options:
> --
> 2.17.1
