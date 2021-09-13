Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0941409D52
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347546AbhIMTmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242839AbhIMTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:42:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFF1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:40:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r3so19318488ljc.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHADwJcnh+CpKcBf4TszmLfyeh06+LH5/t0uL2uHNes=;
        b=gafqWfBapxYEmkhl9x1+HAkYUQmokxm3yiv50LTaTCBqm27WdC3ATuau6hawnMvicP
         ZOuQVkGwvLnlI+0yX/sXDSHs0R+7zQ1ccvEMN9jq/WvgmF+A9y/6tr5FiAgi4MEglFSX
         Fno1eE+03uqck4GvLUy866IF3YqGL3tInNNC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHADwJcnh+CpKcBf4TszmLfyeh06+LH5/t0uL2uHNes=;
        b=LrGTI6Uw3CpdKZxrQrPfToS3EX98gAB007zbxcLNETdsIzlUP1P6UEQV247CcAHL9E
         ZYY3kBtrP0JVSFXgmkWJ+tJF3C6oyeHAtHYxbImQSJoUpzYGmHBoIt96s9pGFhDxfMlI
         fGbUCnTd6I/8QmwFqkjXU20VOZq5/mXADPjup9TTmpwjoAFFVpWtk4V00ZFTeCAEiEdF
         Eqs33yeSx5z7IhffOiQbAnsXsQdkyGNJvbP89cCmKnvIhnmaBnLYbQoNLJZr8mJ97YPV
         S11qXrVNYNnXKjMXCuHbsAKNT4kD6cGGUijl1m6HoERB3Fr8n7vLdGKsj7LkszpOzt1U
         QjtA==
X-Gm-Message-State: AOAM533lLyRQkvwzXsYecue9TjK7OEXD+Ho4ZKWj4LAYWQgTnW63waRt
        Uzqe9g9xFeY5yIsGJGzTdjwsABCuJ2J4RCN125c=
X-Google-Smtp-Source: ABdhPJwGuYm8Hn0YLO7G1q1aTKUc9++W1ylueLqcq1lGhXGX7YpKXVLx5/YDp1SUDo1YtHGYw9Wmvg==
X-Received: by 2002:a2e:555:: with SMTP id 82mr11928605ljf.245.1631562058027;
        Mon, 13 Sep 2021 12:40:58 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f10sm1087374ljo.11.2021.09.13.12.40.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 12:40:57 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id x27so23417417lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:40:57 -0700 (PDT)
X-Received: by 2002:a05:6512:3984:: with SMTP id j4mr371040lfu.280.1631562057201;
 Mon, 13 Sep 2021 12:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210910225207.3272766-1-keescook@chromium.org>
In-Reply-To: <20210910225207.3272766-1-keescook@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 12:40:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyq84MKRd1F4d8SGTcTgdd3ktwPr7_9s8tjgKRx_+2kA@mail.gmail.com>
Message-ID: <CAHk-=wiyq84MKRd1F4d8SGTcTgdd3ktwPr7_9s8tjgKRx_+2kA@mail.gmail.com>
Subject: Re: [PATCH] treewide: Remove unnamed static initializations to 0
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 3:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> Since "= { 0 }" and "= { }" have the same meaning ("incomplete
> initializer") they will both initialize the given variable to zero
> (modulo padding games).
>
> After this change, I can almost build the "allmodconfig" target with
> GCC 4.9 again.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> With this patch and the following three, I can build with gcc 4.9 again:
> https://lore.kernel.org/lkml/20210910223332.3224851-1-keescook@chromium.org/
> https://lore.kernel.org/lkml/20210910223409.3225001-1-keescook@chromium.org/
> https://lore.kernel.org/lkml/20210910223613.3225685-1-keescook@chromium.org/
> I look forward to raising our minimum GCC version again! :)

So this was one of the patches I left in my pending queue, and I don't
exactly hate it, but given the option to just say "don't use gcc-4.9"
and applying this big patch, I did the former.

That said, one of the reasons I didn't like the patch that much is
that it seems to be a mindless "just search-and-replace everything",
very much for initializers that didn't complain even with gcc-4.9, and
that were entirely correct.

I would _not_ mind a patch that actually fixed only the places where
it actually _is_ a question of missing braces, and we have an unnamed
union or something like that.

So some of the gcc-4.9 warnings certainly looked at least _somewhat_
reasonable for a compiler that didn't do unnamed unions or structures
very well.

And I wouldn't mind replacing those. But this patch seems to then
change entirely correct code that no reasonable compiler could
possibly warn about. I wonder if some coccinelle script or other would
find a much more reasonable subset?

With the gcc-4.9 support being dropped, that probably doesn't matter
any more, of course. But I just wanted to say that I didn't hate the
patch, but that it seemed to be too much of an automated hammer for
the problem that could be solved a lot more surgically.

The three remaining patches you point at look interesting, although I
think that third one looks decidedly odd. Why not add the 'const' in
the callers instead of removing it from the function? And why don't I
see those warnings - is this some compiler bug?

          Linus
