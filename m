Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396A231B2FD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 23:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBNWNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 17:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhBNWNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 17:13:17 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433FBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 14:12:37 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f6so4981613ioz.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 14:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=YwaYOR6smcnC1fdwtfgVkGEp6bB82XTtb8+PRtT3+Lk=;
        b=BlITmRbvzOb88BrfBUp8KwYYWl/t33jgHRJQS2SXBbjKtLAE+4sPTe+nF5Q8cFkKP+
         Uf2l2SMvl1e6ANKqWySxYtckt0V25OcXaWFI/q0bq9I/W1bBBqJhBOxTxDDM6nV6SNxd
         1h7jHrxecGbCBKBCprpVAWOaIMEpeMtMa0sLN0kmtfCFonmDV40oJSlSC/JeKDLZ38hw
         3tBVE51MS9mqAu2MIYcCE38kCUSaVZGyGYBjdcctWVuUMKlmtTdABTzuWJkHJADdcLYb
         we/aUA58PEMPZDX74seVlXn7cqWtKCrFTwtW3NPTBhHqiuI3SVfhdWBUjXYqV2RWKkif
         eEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=YwaYOR6smcnC1fdwtfgVkGEp6bB82XTtb8+PRtT3+Lk=;
        b=d/9psK3R5QrB3CJ6MUrcaMdSCyueXp1RJzpjqWUTtHp1HJNTmN9E7rEa31ZghoE/ml
         4oJXlUqCSdXzh4MYV568eCwHRS1du/ZpljDxXUmbwjduMEnxj3EPRbJNp2L9UZo0IMyP
         +uvTrxDBRW71IaznINGb0QveoYDQQ4lx9+VegP6+6Cvx6F9H0J7D1n21A65VsifrasM5
         2xvpzBM6BsAeExDYQGPTTR4adWB+fOFvkI4ogLyAUieAXxDhH2uNwbwrEBHCDDbRcjIE
         P4cq57x8RAbj3wnNlXs4xsSiUFhhhpcBCQMwGSIQYBZvObU/vBFZYkNe3etZVjtbnaIz
         4NUw==
X-Gm-Message-State: AOAM531X1tVma5oSzcM1ONb8KhwmT0AFsiZwNzfuBgMJo9rjx+EcpVKO
        9itk4uAXABpCHQLMv6GKczZV/lI2+ZBJEFThURWessoi0s8=
X-Google-Smtp-Source: ABdhPJx0PKd815rdvR01iY+xbgJ5R4BYbX3ETgdTmw18/UcD1fEr+MReNjaYCSK6kuF1UUoT8rNZiPBcU3uFs2PAnIE=
X-Received: by 2002:a05:6602:22d7:: with SMTP id e23mr10646282ioe.156.1613340756761;
 Sun, 14 Feb 2021 14:12:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUGO0__SEZ7YvuQzfSdaWfTnCHW=73-3W4X=Vz51wHd+w@mail.gmail.com>
 <CAHk-=wiR+uHUyp3=Nf1aiNjmg0ZekaQJupLRguFNZ=MreuGhfg@mail.gmail.com>
 <CA+icZUXRjrX+1NAZy4As_ficD4aHRAZWHRj5hrE+D6E5zEKXHw@mail.gmail.com> <CAMuHMdU-XugrkfM-9tQLrOJ_E1Of1Zf-DJZeSXJwkhw0Q9YoPA@mail.gmail.com>
In-Reply-To: <CAMuHMdU-XugrkfM-9tQLrOJ_E1Of1Zf-DJZeSXJwkhw0Q9YoPA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 14 Feb 2021 23:12:26 +0100
Message-ID: <CA+icZUXh7TNQU2EUch0XyBxhY8LWRD==98+jNNKtOpij+0bwCg@mail.gmail.com>
Subject: Re: Linux 5.8-rc6
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 5:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Sedat,
>
> On Tue, Jul 21, 2020 at 10:19 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > You happen to know if I can configure in my ~/.gitconfig to pull
> > linux-git stuff from two repositories - check first git.kernel.org
> > then GitHub.
> >
> > Some days ago GitHub had some maintenance issues and I was not able to pull.
> > Means I trust more the security and integrity concept of git.kernel.org.
> >
> > To pull from GitHub - saved 15-16mins of my life-time - meant
> > 15-16mins go earlier to sleep - as said I started my build 01:02a.m.
> > (German local-time).
>
> Assumed your cloned from kernel.org:
>
>     git remote add github https://github.com/torvalds/linux
>
> After that:
>   1. "git remote update" will fetch data from both origin and github,
>   2. "git merge $(git tag | grep -v rc | sort -n | tail -1)" will
>      merge in the latest release, if you don't have it merged already.
>

Last week or so I really used your recommendation.
Thanks Geert.

- Sedat -

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
