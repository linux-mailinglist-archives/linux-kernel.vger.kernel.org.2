Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8F344C67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhCVQzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhCVQzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:55:16 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852A3C061574;
        Mon, 22 Mar 2021 09:55:14 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id t14so5645616ilu.3;
        Mon, 22 Mar 2021 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngARvZf0Hr9eoT5wywWQfkd9nJk4dz1wJXXtIU4BmYk=;
        b=htInPnZg4vA+r7OCPDFJS5+IlPc32tImgeocBgZqDXhlQuU7p+XXJBReMc1MYJti4O
         Ut1bxDZCaEWVUImDpMrOHozfrOuDFW0XbytfEtkVQ6sHUNkdHsm+HRfsTghbR10Hy2zR
         gux3CXoHNFlrQ/woLzePzXIXyTbVKcN9Rd/JaLQtAPScMbH9cTjrF2vLFIrkV2/m0nUM
         a4Jb0G30nFUQ4hqO1RF1lctYzuVEhS9Cwrh/u/D7i1+vxXJSoO29Slngf/5QM3Tso+Sr
         GfqASeS7M6XS3DnKDDN4yDiK4eKyIAadNYth7mLi7gMkyfnVtSThMeDYjzOIb8XWqoZn
         owVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngARvZf0Hr9eoT5wywWQfkd9nJk4dz1wJXXtIU4BmYk=;
        b=e/uxh4lsJ0sQxAzIBHo+qt6KWoBAbyvIcIYcR6xEkSCaVP51MTX96rUcNVoUkPsPij
         1DHKmKQMQ1AijtBeFV4CyZseIaUCZkjNIThcuzHHNoPIV3wzsDwH42MCahwBhkfoK7zk
         8VfltK4Pz3zz4wTdGKUdV/amFArvEKU3eM6KLLYvHC9spRpZdevtcn9NWKS6j/zE10HU
         9+LJ0WW8OWYS+TjABI5GxZBe2jPU7gzsV1viFNys97I4xxHZ0W25OGgbR8eR8b2Vm3oL
         n1j+8McdMVaqBQd/0eJ4RpKfSDoqeZwJPk92VgDossNbSlmvl8FXEieqGGzYakJCsxYu
         RtOw==
X-Gm-Message-State: AOAM530+BPU6s2vqGYLv31aflw68Y67vYIVPa9gwvPamOtCTvMe6EAbS
        lpTIf9gZG7nZpTKpRcMzd+QRA368J9DEdF72gyo=
X-Google-Smtp-Source: ABdhPJyuJC5hVCu0FCRaN9RV2YxF9x8kaHOn+ZjQHGxHWHv3o0Td39BXmxSaDgG62GosSCT8X7bL+vwO2jxcpkFsiSA=
X-Received: by 2002:a05:6e02:1049:: with SMTP id p9mr790208ilj.125.1616432113856;
 Mon, 22 Mar 2021 09:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
In-Reply-To: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 22 Mar 2021 17:55:05 +0100
Message-ID: <CAKXUXMw7kHBPov23kF1HUBrW9DL+huqAG8ZRLJwGgU67nCOPeg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 4:38 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
>
> Lo! I want to provide users with an easier way to search our multitude
> of mailing lists for reports about issues (aka bugs), as reporting the
> same kernel problem multiple times has known downsides for everyone
> involved. That's why I propose to create this new mailing list:
>
> linux-issues@lists.linux.dev
>
> Developers and users reporting or handling issues then can CC it or
> search it via lore. But this will only fly if the idea has buy-in from
> at least the core kernel maintainers, to make sure they and the
> developers actually use it. That's why I'm looking for feedback with
> this mail and also CCed ksummit-discuss, as that's the easiest way to
> make sure maintainers get aware of this idea and can raise their voice.
>
>
> Note, there is a second reason why ksummit-discuss is CCed: another
> reason why I want to create this new list is making it easier to find
> and track regressions reported to our various mailing lists (often
> without LKML in CC, as for some subsystems it's seems to be custom to
> not CC it). Back on the maintainers summit in 2017 it was agreed to
> create a dedicated list for this purpose
> (https://lwn.net/Articles/738216/). I even requested a
> "linux-regressions@vger.kernel.org" a while later, but didn't hear
> anything back; and, sadly, about the same time I started having trouble
> finding spare time for working on regression tracking. :-/
>
> But I soon will get back into that area:
> https://linux-regtracking.leemhuis.info/post/hello-world/ Hence it's a
> good time to prepare some groundwork for that. But these days I think
> having something like linux-regressions@lists.linux.dev might be over
> engineered, at least for now: a linux-issues@lists.linux.dev with a
> simple "[regressions]" in the subject will suffice, as that tag is
> something a lot of people are used to already. And if we think we need
> that list we can still create it in the future. Or what do you folks
> think about it?
>

Thorsten, I generally support this initiative. I am just wondering:

What is the definition of an issue for you?

Just four examples that come to my mind:

- all the warnings that Stephen Rothwell reports on linux-next, such
as https://lore.kernel.org/linux-next/20210322170452.726525e8@canb.auug.org.au/
or https://lore.kernel.org/linux-next/20210322075108.3967d5d1@canb.auug.org.au/?
- all the issues that the kernel test robot reports?
- all the errors and warnings that kernel ci reports? Basically, each
"issue" that is already aggregated in this email,
https://lore.kernel.org/linux-next/6058787c.1c69fb81.d3f10.8c6d@mx.google.com/?
- all the syzbot reports?

Are you including all those automatic testing and checking efforts as
reporting valid "issues"? Or would you like to keep this list only for
reports from single individual human users that need to detect the
"issue" without using one of the tools above?

Lukas
