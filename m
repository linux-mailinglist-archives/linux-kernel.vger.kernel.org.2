Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3D45CBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbhKXSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbhKXSRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:17:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA01C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:14:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e3so14390123edu.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fo4mOTqhHKegk3FsdIGggEWxMKGlpqzxJlRZUDZ6lK8=;
        b=h4EQIdhoGpX4ZXTjiWQ2vyhcmJAF+1+VP7MYLwAWfABXN6usB8j2QQhvHqi1Gz0+ch
         qKxs9RoH+Y1E+sPzy/OGZ9+tsKgU//Fa5sH7sDYr2O7hWeentE7GVDW9ax22plVKt/oD
         FBqRidgp+L9gO6zuRYyHPGzi2bD4LoneunKHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fo4mOTqhHKegk3FsdIGggEWxMKGlpqzxJlRZUDZ6lK8=;
        b=IP0Vy/VdJGmL8XHGiuVVIWAtIWnA3xyBaZQyH0BE+y+20CNuEI7bAY8HR7U+/H0r4I
         9SdXjUXEVghEiyRA1rxaCCe/zA+j7io14tF+Ne+W4rncFUHiBB0sZAdv6GfhgrMSW2HY
         pVm2ELrsAnMeEMIVB8dqqSU1gz9rWsI+F3Pp0TV2w5eHfpHqjHGgPLFyrgzp9uBcFd6c
         ap8HMIxyQ+2Wv4x143oH5Uvh+6cV0GPqBvdclWr4ssPVaNIkPuUUfYO0lHcAUVVDjqJs
         vd+4/JsVqwmy5CZUyLtXqVZ3A/SG5eRkOQVtnAa5WPrqaUdBgtY3K2AnCid3oGBF9ngP
         G0CA==
X-Gm-Message-State: AOAM5338o4amFsWyFB+GzlecM3as9QfFYk2I8oea2h/ghqxFWR0ALBqi
        0i7bCPkmbsIH5Im28VSap0AEX/RNr0pRw2wW
X-Google-Smtp-Source: ABdhPJwOZLXLRTidsIb0aSajfOKfkhQC4kPGB12X0shdqi8aER8Txj5H6U81/kt66pU+66CmrWViGQ==
X-Received: by 2002:a17:907:6291:: with SMTP id nd17mr23316583ejc.194.1637777652040;
        Wed, 24 Nov 2021 10:14:12 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id hw8sm310820ejc.58.2021.11.24.10.14.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:14:11 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id a9so5807099wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:14:11 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr20906517wrn.318.1637777651144;
 Wed, 24 Nov 2021 10:14:11 -0800 (PST)
MIME-Version: 1.0
References: <163774583541.221636.5062449110647587402@leemhuis.info>
In-Reply-To: <163774583541.221636.5062449110647587402@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Nov 2021 10:13:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wimd-G9+etiTb=_yqxy8H45su-=WXdLBrhi2TJK+gB+Mw@mail.gmail.com>
Message-ID: <CAHk-=wimd-G9+etiTb=_yqxy8H45su-=WXdLBrhi2TJK+gB+Mw@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2021-11-24]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, nice to see the new regression tracking bot start to show life.

Greg had one suggestion, I have another - namely about grouping of these things.

I like how you group them by "identified" and "unknown", because
that's certainly very meaningful.

But at the same time it does mean that if I look for "what are current
issues with the development kernel", it ends up being very spread out:

On Wed, Nov 24, 2021 at 1:25 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> ========================================================
> current cycle (v5.15.. aka v5.16-rc), culprit identified
> ========================================================
...
> =========================================================================================
> previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
> =========================================================================================
...
> ==================================================================================
> older cycles (..v5.14), culprit identified, with activity in the past three months
> ==================================================================================
...
> ====================================================
> current cycle (v5.15.. aka v5.16-rc), unkown culprit
> ====================================================
...

note how there was a lot of other stuff in between those "culprit
idenfified" and "unknown culprit" for the current kernel.

One of the things I really liked about the regression tracking you did
before was that it helped me get a sense for the state of the release,
and so I'd like to see that "current cycle" in one go.

I suspect that Greg may have a slightly similar issue - as a driver
maintainer, he cares about current cycle things (but mainly only when
they affect his subsystems), but with his stable maintainer hat on he
then cares more about the older cycles.

Greg suggested splitting out the issues one by one - to try to have
the right people on the Cc for any _particular_ issue, and while I
think that's not the solution in this case (I very much want to see
the "summary" email), it would be good to perhaps at least organize
that summary email slightly differently.

I suspect this is something we'd need to iterate on as we use this in
our workflow, but that was my initial reaction to this first report.

               Linus
