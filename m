Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726FB389ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhETBSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhETBSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:18:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1A8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:16:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z13so21911275lft.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHiclWwNmbkDjIZibew+dxVBlYyOj4Q9+62BbO0BElM=;
        b=y2AsBtabAqYS/8F7ubzaQsaboehJCfXK/Jma6HlQrHkC1dyhIJyKlr9Gtu1SBGcb4r
         gcjlgjcSrUJ8zDw9Duc3ENMnZeycri/xdm57gNVd/KGS1s1uQqRKfrqqWWJFz17dNdoe
         XKwnajO+joO4CoEy6wHBVmyNNkO6uSR3VdevohvlofIIRe6JZ52TPSZzV4ZcDpI5WhxG
         sur9BA6SUflvVRxc4j0QtzLHpSTkBEttoRlCC4FfY6XrGNuNqqrh2nrz9wbeWfcSWB6P
         0bar0CWnCbqvf6lfUbJf31A8i6hpSWNc6hsw8H9t5y9+mPCGS9XidRxeCJyK3OTTsl5U
         kU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHiclWwNmbkDjIZibew+dxVBlYyOj4Q9+62BbO0BElM=;
        b=HYMXDGGwP3HAy/xUg9xYkUgA6KR2cY6POxXTkF/2pKA8jxLEH3UmaB8oJIjy79+kEz
         X57dVG6/nXz/5eH7NKwqbea+a3PBbWMZNQZAGQuPt/yyxUBwGOQn46A7W6Mib9Aw3Tqm
         UL/zQCVXKD8GEbUu8LMtQ0Qs7XuWDFrwzLrBsiSLGVTEcVxsEn6UCgeiyGF/HCU/pWBX
         6qVD7lSfz15jqYRYrhvddd83VoBQ0DfKXxr0D0xfTnzksPl46zWFLk410sNe0pabpZSS
         J5m8/K7WP1MiKwMIE+HqZYtOqywMUrvmE8a/XFe2ISRJovq0s0fP+dzKgb/XRoy5gTz/
         fgPg==
X-Gm-Message-State: AOAM5331BFqKZ927evVZhqP5jNz7opW7zWQkab9Fwe3qlUjS/soSk61k
        8PsN2TuOnOqdBO7bDiEl+q6yiUlHrSGlqCVTTAySSg==
X-Google-Smtp-Source: ABdhPJwH+YPeaS6Ncl5QgzBWKO9hsVhZaSR5v8hWY6PP3fzTwtXY+pXJeF0WKCzuX5EIzu0Pyjw2p35Uj0VvjiLsrOE=
X-Received: by 2002:a19:6a06:: with SMTP id u6mr1505228lfu.626.1621473417983;
 Wed, 19 May 2021 18:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <CANcMJZDOMZVj6WVEe+7b--Rwkdg1-WVFfHkVm4KR-ykS4LxQFQ@mail.gmail.com>
 <20210518084900.GA7412@willie-the-truck>
In-Reply-To: <20210518084900.GA7412@willie-the-truck>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 May 2021 18:16:46 -0700
Message-ID: <CALAqxLXNq__ycVa1GJMYd-gx2cEXzkY-ipd1qe5S=4i+xP8c3A@mail.gmail.com>
Subject: Re: REGRESSION: kernel BUG at arch/arm64/kernel/alternative.c:157!
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:49 AM Will Deacon <will@kernel.org> wrote:
>
> Hi John,
>
> On Mon, May 17, 2021 at 02:52:59PM -0700, John Stultz wrote:
> > With v5.13-rc2, I've been seeing an odd boot regression with the
> > DragonBoard 845c:
> >
> > Unfortunately, trying to bisect it down (v5.13-rc1 works ok) is giving
> > me inconsistent results so far. It feels a bit like maybe some config
> > option gets enabled moving forward, and then sticks around when we go
> > back.  I'll take another swing at bisecting it later today, but I have
> > to move on to some other work right now, so I figured I'd share (with
> > folks who better know the recent __apply_alternatives changes) in case
> > folks have a better idea:
>
> Please can you try reverting af44068c581c and 0c6c2d3615ef?

Hey Will,
  I realized I didn't get back to you on this.  As MarkR already noted
it does seem to be coming from 0c6c2d3615ef. Jumping to 5.13-rc1,
doing a make clean, building/booting then jumping to 5.13-rc2 + the
two reverts above, building/booting, and the issue won't appear. If we
just jump to 5.13-rc2 or 5.13-rc2 with af44068c581c reverted, after
building and booting I'll be able to see the issue.

 Given it disappears after a make clean, I'm guessing this isn't a
major issue, mostly just a concern for folks to accidently hit it
bisecting things, so I'm not sure if there's anything else to do.

Let me know if you'd like me to try anything else.

thanks
-john
