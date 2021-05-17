Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA738251F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhEQHOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhEQHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:14:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DE5C061573;
        Mon, 17 May 2021 00:12:49 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r8so7168187ybb.9;
        Mon, 17 May 2021 00:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnfM4fo4oFuAPVsrltUK26/fkolufI98kOjdPlwBBSs=;
        b=sCHz9T1r7pQoPrnpmLqVHffncPimVZ34tPFdaSdpCyyRmbI4Bw3dFCYBoNaHQfs2aM
         x4LC/UHilSXaDbQyq/4lODNs6RHLkQwrQ4pnqts1hIX7m8GXq+VZCloO2acNQPvRjZC8
         nglxT+eRVpvnqJzCIEgcNaLk912N/KZAdP6X9R6yU4US8h+yBsCO6w6A4KieZrh81kyG
         WFjtQ3AXvTMaHgIfZNNkkdTD6+q/qdhDj1bfvvqnUIGHmtDNoQCMOUgv5vMgK8ZE6tYd
         5r80kL1d0ezowYexxgyQybHP/RFvWWp4MARDBG2kjL7e8XWIVJnrL592aMS7N+T8grKB
         CDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnfM4fo4oFuAPVsrltUK26/fkolufI98kOjdPlwBBSs=;
        b=ahlfZ9UIOuvAxKS0euvTxjwDL/+iZLauVYNqkGBcYkDUOW7Jq8dnn+ik0RTwSRQCVp
         6HuJ+wVMkEmE76ANPZx3LeR70L4RshfvlvcfrZ5qs2TVTn0osN+fsez6R9Hf+YrdGEcm
         JedkQ6398E/KlDgKFmkWqKEaxm+ts0aIysm5p2TXels8c8r31kd9NI4KD6apHxpEis9B
         9V5TeH5BWTpKqwJ4tYZs1kYUCZGTSoFUdFSM14al+JbWnGrImSbJye4Yce9qpW+VVCXe
         HyDH35t5Md792MSmzgVe4FZL9aVKf7v1V/NF5N7ZAg8bfJ09SipRug5d1xg3MDO6XqEE
         bW9A==
X-Gm-Message-State: AOAM532VUACrzWTZt+g82e59Y+yLmyNgWOtqj8znLWW/Jjrx4W4M1+Xa
        kiFp2ktDEPbenE9Ini1yzn9kS13aXmQ/1dYyoI9ZSj4x
X-Google-Smtp-Source: ABdhPJwhy8QlrIdBrKJb/MrNu8oi1LeLLZbLVd1iqr2w97cP4tUSJtamdpFZ04wpLC1o2Hggcr7AVCw0mnBO/qVK/RA=
X-Received: by 2002:a25:55d5:: with SMTP id j204mr79927377ybb.157.1621235568717;
 Mon, 17 May 2021 00:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <1621224036-32092-1-git-send-email-yangtiezhu@loongson.cn> <CABJPP5DRw3pNs0da4HdCLXVHSa6sE88xJOO6C3c_oBESLoWq3A@mail.gmail.com>
In-Reply-To: <CABJPP5DRw3pNs0da4HdCLXVHSa6sE88xJOO6C3c_oBESLoWq3A@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 17 May 2021 09:12:51 +0200
Message-ID: <CAKXUXMyE_q9VCXVbZLPP77anaotTjW9rk0RfK=m8Njy44XpvEA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: add description if no
 filenames are given
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 8:21 AM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> Hey,
>
> On Mon, May 17, 2021 at 9:30 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
> > if no filenames are given, it will read patch from stdin rather than exit
> > directly, it is a bit confusing whether the script hangs, I do not quite
> > know what to do next util I understand the code logic.
>
> util -> until

s/I understand/I understood/

> >
> > At the beginning, I want to print some info if no filenames are given [1],
> > but as Joe Perches said, this is unnecessary. It's like trying to make cat
> > without command line arguments emit something.
> >
> > So as Lukas Bulwahn suggested, add description for somebody that actually
> > reads the available kernel documentation on checkpatch.
> >
> > [1] https://lore.kernel.org/patchwork/patch/1429026/
> >

Generally, I think this commit message is a bit "too much the personal
experience report" rather than focussing on the technical motivation.
I prefer the same content with less "I" and more focus on the
technically valid arguments rather than people (your experience,
Joe's, Lukas' opinion etc.).

> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  Documentation/dev-tools/checkpatch.rst | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> > index 51fed1b..181b95e 100644
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -210,6 +210,8 @@ Available options:
> >
> >     Display the help text.
> >
> > +When FILE is -, or no filenames are given, read standard input.
> > +
>
> The addition is reasonable but the position of the text is a bit weird.
> Let's have it after the Usage:: text:
>
> -----------
> diff --git a/Documentation/dev-tools/checkpatch.rst
> b/Documentation/dev-tools/checkpatch.rst
> index d4bb55723a86..7bf1e48207ce 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -22,6 +22,8 @@ Usage::
>
>   ./scripts/checkpatch.pl [OPTION]... [FILE]...
>
> +When FILE is -, or absent, checkpatch reads from standard input.
> +
> Available options:
>
>  - -q,  --quiet
> @@ -210,7 +212,6 @@ Available options:
>
>    Display the help text.
>
> -When FILE is -, or no filenames are given, read standard input.
>
> Message Levels
> ==============
> -------------
>

Fully agree with Dwaipayan here. This is the better place this
sentence should be added. Please send a patch v2.

And if you want to contribute more, please add some typical example
how to invoke checkpatch with a filename and a good example how
checkpatch could be used reading from stdin (e.g., by piping in some
suitable git log or git show output).

Lukas
