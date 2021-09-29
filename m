Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA641BC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbhI2COS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbhI2COR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:14:17 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E2BC061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:12:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w1so1183233ilv.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ncHSqeWvmQnAH4fmEz/nsHqUsBXIb6xkEvRSYXpDRo=;
        b=cgfujflTOgMlCBvsPEW6ttFA5E2snmFqB9X3p0JX6mWK2Yrs/kIYyG59fADC8DZblc
         APjzHj1f8JQskgXuFj2epjqrQLgjI+gtvxFetIC5/a562j5WWQFwc+VTEU6RSdu8Ar+W
         czQSxYbAd2uKnaAGjmeq3CCErsNHHE2GpZ7u78V0Pf8gYUe3OBRMdvFY1kn46WuVvXSB
         R1/GRKK16Twy1oPRbr+mHY6MIFiV80vc61xA6z9Rnv9kAOgr6FN8s1dlh3fKcxUAM9Ef
         EGrZL91luO4XHm4EbCap8EUsvZXUfiVythEAL0LXDuARb2gv5uJpam+ehHBFzutr3bMA
         ZSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ncHSqeWvmQnAH4fmEz/nsHqUsBXIb6xkEvRSYXpDRo=;
        b=iXzYkLziptu8hBWQl9R+HwyEa+kri16LDHphy1yR64GaXIkpcHwq3FGeBNXt/WU/tC
         CEP+Sh8EjAQmedTDi/TFxNsHMqirmH85gfb9LKtUmHpCt4NzFaPQ9QbWnAGd8OBjt+m3
         j3C93I+24439YDZbwdPcJ2hqv4H5g/6BoNZFd2BFgxT7l4wtGaBlSWe65iom7UtVOFGV
         XW0qsNL/Ihvn048q0hnlBn7OW6yvhsE5me6icKnqYhpdxxEh07yqInhhyY7MET3w0U3S
         MzGNG7f2n26q6J/v+PobfrsI5vSWbA+bfGiKsMUh2VbIqEI0U0YrezA0tE673P2eqFl2
         4xEA==
X-Gm-Message-State: AOAM533c5BUkSMQWwz7o9+aHCoEUswSe7Lxgk1TTnds04eh7F3FNPCMx
        q1rDfkWHtDfQ2feQ7yfdAkT6uYCKJxsUOvInbn8mgQ==
X-Google-Smtp-Source: ABdhPJwzGI6eCrV5BbUaVTbIae7h3xxUmozHKTA12EjFPo/1XrzoSUCa7J8CIbyUOwYbIq9Oei3buy6Bq/rOIm70sPg=
X-Received: by 2002:a92:b301:: with SMTP id p1mr6366328ilh.10.1632881556082;
 Tue, 28 Sep 2021 19:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210928221111.1162779-1-dlatypov@google.com> <CABVgOS=0K78N+KMK3km5TKVDD9L8AMRpNCfvihCqU2h3U-oE-w@mail.gmail.com>
In-Reply-To: <CABVgOS=0K78N+KMK3km5TKVDD9L8AMRpNCfvihCqU2h3U-oE-w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 28 Sep 2021 19:12:25 -0700
Message-ID: <CAGS_qxpkak7QEfPvQhozuJt5VN=9+hcNOjrEryVj=hV8A1mcDQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: misc fixes (unused vars, imports, leaked files)
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:34 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Wed, Sep 29, 2021 at 6:11 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Drop some variables in unit tests that were unused and/or add assertions
> > based on them.
> >
> > For ExitStack, it was imported, but the `es` variable wasn't used so it
> > didn't do anything, and we were leaking the file objects.
> > Refactor it to just use nested `with` statements to properly close them.
> >
> > And drop the direct use of .close() on file objects in the kunit tool
> > unit test, as these can be leaked if test assertions fail.
>
> To clarify for a python novice: this is referring to using "with" so
> that the file isn't leaked if the assertion fails, rather than
> suggesting that leaks are okay for failing tests, right?

Correct.
Ah, I see how it can be misread now.

But on that note, it's probably fine to leak the files as CPython
should close the file object during GC.
And tests failing should make those file objects go out of scope immediately.

>
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> These all seem sensible to me. Thanks for cleaning this up!
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> -- David
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CABVgOS%3D0K78N%2BKMK3km5TKVDD9L8AMRpNCfvihCqU2h3U-oE-w%40mail.gmail.com.
