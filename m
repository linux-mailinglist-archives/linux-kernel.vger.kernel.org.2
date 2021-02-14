Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC631B291
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 21:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBNU4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 15:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhBNU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:56:49 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7BDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 12:56:08 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j19so7229022lfr.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 12:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvIet1hUFo7wVMBNV+UfDaANQC7eRKzYGZc7SbqGVq4=;
        b=Nt+NXAJDYBOjuawoWGi0jtiZwyIh4tcmTBzegkgRWbglQUyhrP5YHUuLrgATNkTcMn
         DhoMxYA3jQAzq3Bhu0BMnXWoQOXXylzFXV0wgy5jV3L5CC40hJlZAdAmBsXpSvKB6j7d
         y1H8Ou2bR0UoK/6DZbzdnUmikDco97EiAQx1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvIet1hUFo7wVMBNV+UfDaANQC7eRKzYGZc7SbqGVq4=;
        b=TB9adewGtv6fkkkk1AnIloXzeNENB66s0Sn2pufQTjeZU8q8e/1Reae8XDdYQAuRGa
         wzszwwU3r+4WPonqeOqHmBl8sjpbJYEJ0EalU7Y69Zkd2ksofaupH9nLHbb0RqVC2TXw
         1kDEBGR4UlgvziT4h/S8evzsGmOIa9qF4reRaDEBASEIgP/A1FNFyM5MZyCJBuNDrQOi
         ASSSZXTvNGUbJfwY689maMBIWfkQH5AhES1f36dzZL1Gd4wvjOMqnhgqzzTYvzIUdufO
         +KuLU49/GqjtiHzFc2ZBvyWZ2wpp81VpMT+y/fAl3CGq0vQzOLxUDQJBrS6UUnENXYQC
         3GjQ==
X-Gm-Message-State: AOAM532Mx3UHha6nnzUvZhbHoHrOq8mFbDLYrBmEFvJFoIS/QgEmuzmJ
        KqreZaLWa/WUhMAqpaiQon5qfYlZFVXhKA==
X-Google-Smtp-Source: ABdhPJy1Nc9+0ehunQkBz6FFOynA9vcKDaeR8nMQ9D7Wnm0nzXAxpb6Q/m9sNpcad7BWOkcAQiHTww==
X-Received: by 2002:a19:ca14:: with SMTP id a20mr6786749lfg.567.1613336167069;
        Sun, 14 Feb 2021 12:56:07 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id e25sm2552357ljl.44.2021.02.14.12.56.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 12:56:06 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id a17so5516341ljq.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 12:56:06 -0800 (PST)
X-Received: by 2002:a2e:8590:: with SMTP id b16mr7775464lji.507.1613336165860;
 Sun, 14 Feb 2021 12:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20210214171328.GA5314@duo.ucw.cz> <CAHk-=wgCp5n3sB_hDmOLSPiJcwJm9RErBHN_6ABhRWyVEkY4Xw@mail.gmail.com>
 <20210214203138.GA22191@amd>
In-Reply-To: <20210214203138.GA22191@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 12:55:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmB6qH7Ho433B066S0=B-CtDNFtaZWOM3PMGWB0ERKSw@mail.gmail.com>
Message-ID: <CAHk-=wgmB6qH7Ho433B066S0=B-CtDNFtaZWOM3PMGWB0ERKSw@mail.gmail.com>
Subject: Re: [GIT PULL 5.11-rc8] LED fix
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 12:31 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> 92bf22614b21 is my rc7, and it is parent of the commit I want you to
> apply.

Oh, right you are. I looked at your leds-cleanup-for-pavel branch for
some reason, which was much older.

Anyway, it does the remote lookup with git ls-remote, and doesn't find
any matching ref for that 92bf22614 commit you gave it as a base, so
that's why it complains. You _could_ fix that by just pushing all the
tags you have locally to your remote too.

Have you changed your behavior wrt git request-pull lately? Because
that whole model you use is broken.

The "end" commit shouldn't be my tag (and it shouldn't be a SHA1). It
should be *your* branch name.

So what you *should* have used is something like

    git request-pull master
git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/
for-rc8-5.11

(assuming "master" is the upstream branch - which would be my
v5.11-rc7) without any odd SHA games or anything like that.

              Linus
