Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C165D3B7682
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhF2QhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhF2QhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:37:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90A9C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:34:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u25so16252191ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVxx6zpWtcdsULUPWErKqjtTjlhlStVWEPIt+o6rJzA=;
        b=RQmFW2wmVw+pZcJx5ASMwMtBuR0uIqf1DvohGEj877skEvY7BIALzVK0wZSn85cSgP
         rnVIxAAF4mwSTGnM1fMzlUiP+2hUUukWyxLqSV23B3rr/sbS6B+N/vViuc4nFw87wBca
         Vf7iQHLbxiMR7VnG+qHjquEHs5t0TJ04xAdEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVxx6zpWtcdsULUPWErKqjtTjlhlStVWEPIt+o6rJzA=;
        b=PT3QtkdMtDrNNaz/gFR/Wi1RJZqNjPqUB8FMShKsaAkRCYan5auHOKOv4RwTCDVzA7
         0J3ckT3NxUEweRLxvjTfbBrxdCYKYu1sQrP4vhzFpLrLSj+3Pf65kxMddwFqqMkC5bdP
         Km3bnknnCX0xaY3b2W9kjNbIiblfuhnFt9yCXGo/YmipbAdYIpX2MSTLehrX+rB+RrVi
         Wgiivh7a7+/UC3cWbuJMiKa9CRI/f2hSLccVC63TkE/cvHNQxNBl03sgjiJsjxWB2uKz
         Qnz9jC1pfN5NghFhb39/MLdkZGYHdvUka7EjgvKQvYWf3WM38l4jn1qYTwF7SiATaQhp
         uIAA==
X-Gm-Message-State: AOAM5332mwtoM/uV39TBWEWuW2ftJHJT3D6W6uCV0aU1NYWm/JgD8ywX
        yzz5wtEkMK9/l7BHFWIAu5oWJgmP8DSVNST6znQ=
X-Google-Smtp-Source: ABdhPJz7mpAIPBf/bqNuK/YPfZTAH6ZNk9FM8pzCgd+yPyiN6rGSP1EU5IjaDj/9mqxLg5iX+o44ww==
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr4670391ljj.325.1624984473973;
        Tue, 29 Jun 2021 09:34:33 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c20sm1364759lja.30.2021.06.29.09.34.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 09:34:33 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id q18so6198838lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:34:33 -0700 (PDT)
X-Received: by 2002:ac2:4950:: with SMTP id o16mr16652927lfi.487.1624984473279;
 Tue, 29 Jun 2021 09:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <87fsx1vcr9.fsf@disp2133> <CAHk-=wj1z-NKxedgZvSS37iH=EKE47PkL=+BYccAUtsuB1sySQ@mail.gmail.com>
 <87czs4u0rm.fsf@disp2133>
In-Reply-To: <87czs4u0rm.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Jun 2021 09:34:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs5+3MLjG_hsQcKdamOcTsJLsk47tV12FfD_0f2h47Rg@mail.gmail.com>
Message-ID: <CAHk-=wgs5+3MLjG_hsQcKdamOcTsJLsk47tV12FfD_0f2h47Rg@mail.gmail.com>
Subject: Re: [GIT PULL] ucounts: Count rlimits in each user namespace
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 8:52 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > Why the "sigpending < LONG_MAX" test in that
> >
> >         if (override_rlimit || (sigpending < LONG_MAX && sigpending <=
> > task_rlimit(t, RLIMIT_SIGPENDING))) {
> > thing?
>
> On second look that sigpending < LONG_MAX check is necessary.  When
> inc_rlimit_ucounts detects a problem it returns LONG_MAX.

I saw that, but _without_ that test you'd be left with just that

    sigpending <= task_rlimit(t, RLIMIT_SIGPENDING)

and if task_rlimit() is LONG_MAX, then that means "no limits", so it is all ok.

IOW, afaik even _if_ sigpending ends up being LONG_MAX, the
conditional does the right thing without that "sigpending < LONG_MAX"
test.

                Linus
