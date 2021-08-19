Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F053F21B7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhHSUiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbhHSUiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:38:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814C3C061757
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:37:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w20so15579096lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgXymfqgLxB55cygt9ZhuDY1NRwbRIl68JfwaLHFxU8=;
        b=MceR7MtQuMc4MmHD20XUcnrhWaX0y7Pv84DU/6PNFNUkZl6vYjYv+XP2za7cYFWX+Y
         4XR3BlXpVnb4zj1YPJq4lKKIOOQqXZ9vr//f/7JgmeaUJ3yBBLGCORXwGnhFBJvZP1s3
         oAXhWUma+gSbrJUF5XAndd1SKKPWftW/RUHuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgXymfqgLxB55cygt9ZhuDY1NRwbRIl68JfwaLHFxU8=;
        b=LI5HDP8l2Rre60N0pFR7Xnbrhn0JtO+oPnwLN2z7WydoDfjxJQOAuz0bmX6s34/nKp
         Bs/AoViCcwhq5WUUXx9gis8tv+KU+/IxaZQnspCTNgyUrnqaYd4WyCqll8/umH0YgY64
         lMAsAqdmrp2QPJ2yRtT3Z1d5z758uZDPSGkwpQrKtD8PDRhatGuhjNURCv9SKVLOIAVD
         Al0vQ+waS7ZK+AU3WyGaa4ubQuULZXyeWk+yqJf0PrpmGsBI81uco6Gu2NYTlBYLlifr
         QOCx3YZgNh5nQEC0+V0QV/FjC8w0uXqMRxPonWsREn9/vOC2xtWtrho3kF6Kzn3tthJm
         7YJQ==
X-Gm-Message-State: AOAM533X434P53i/AsyRY6xQPXBOOOzBkfAXGWvz7f3PbeGywkLcc0N3
        quTiLJVKRzfi6OBTnN+/dvEJFNDhmjHuB+w8KLI=
X-Google-Smtp-Source: ABdhPJwBcVZ4SjXMADqJRHMzW8FVBQvDu8A7S1GwTUpGLgwOt8cALFgljPm30x808urLwwTHaXziIg==
X-Received: by 2002:a05:6512:b9e:: with SMTP id b30mr11937970lfv.428.1629405457797;
        Thu, 19 Aug 2021 13:37:37 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a1sm355830ljj.97.2021.08.19.13.37.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 13:37:37 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id o10so15563774lfr.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:37:36 -0700 (PDT)
X-Received: by 2002:a19:4f1a:: with SMTP id d26mr11522879lfb.377.1629405456647;
 Thu, 19 Aug 2021 13:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210819040517.GA329693@embeddedor> <CAHk-=whXUJbqhjkRSjOQ2Tm5OmyKv3_JUTh8pxxvykGaC+fM0Q@mail.gmail.com>
 <9ef3265b-a5e7-d21b-68a8-ad137ac6ebfd@kernel.org>
In-Reply-To: <9ef3265b-a5e7-d21b-68a8-ad137ac6ebfd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Aug 2021 13:37:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPU-SA2L=wiDGHGQBL_K-qtpu5EzQLwmV0qk7LSZKQrA@mail.gmail.com>
Message-ID: <CAHk-=whPU-SA2L=wiDGHGQBL_K-qtpu5EzQLwmV0qk7LSZKQrA@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.14-rc7
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 1:17 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> For what it's worth, clang's version of -Wimplicit-fallthrough would
> have caught the bug in commit 652b44453ea9 [..]

The thing is, any warning can catch a bug. The "signed pointer"
warnings could catch things too if people really care about "unsigned
char *" vs just plain "char *".

But warnings that have too many false positives are more likely to
hide bugs than expose them. So it's very much a balancing act.

I personally think that false positives are deadly: I'd much rather
have a c completely clean build where are the warnings are big red
flags, than a build that has warnings that _may_ be signs of bugs, but
where you have known false positives that have no sane workaround.

Because with even a _single_ false positive, people will immediately
just stop caring about any other warnings at all. We've seen that over
and over again.

This is why a compiler warning - to be useful - has to be completely
unambiguously about bad code, or at least have a alternate "good code
pattern" that is no worse than the code that the warning about.

> However, if you are truly opposed to a version check, can we at least
> just check for the presence of -Wunreachable-code-fallthrough as I
> suggested before?

I'm ok with that, since at that point there are no false warnings.

But even then, it's much too late for 5.14 by now, considering that
this has had issues, and that we already enable the warnings on the
common gcc builds.

                Linus
