Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6149C400C3A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhIDRNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhIDRNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:13:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18EBC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 10:12:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so4768793lfu.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqrO14T0pKbUG+FmsgnUcUfGbeFob3eqLQ85Va5kmqk=;
        b=XY3nqgBYHLsJv0nJJNOzNYFr6o39fLeHQUlIyaxdGcj+ytYTEywwCgGFGUgWA8dqgi
         f/RE770n2NQr3TuVxMTfnMl1wfJTREqHXbAnvL6LMmw/Jeb6+6EtPi40+SPjL3M+Lbh4
         58pSSUN+hfX5ihok2Aq10yyW56VMKHDHtD8ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqrO14T0pKbUG+FmsgnUcUfGbeFob3eqLQ85Va5kmqk=;
        b=NRV6US2w2CvR7154sbTBhRRSw5p82tTkqFHrnpy7akR9XUXhfikYoTZjckPc2bLVV8
         KGGiVjiIdP5k3oNH6gS2A50YUDHA+q+SwArObLVHqMIUB4Rk5TFWQIGP2b0oxeUeDQ1L
         cqWqKnyCFbttCGNXiSNcSjXh4ixmaot5FYUf+cYf32UEFb4loJkcpLTs9qBtYYMaNmkh
         +7ZzSV8JyiGmUPtSxbNNfI0tYp2tYedDt2Rb0pDcJ5w8jWHlmZ+N1nBfy4mGWqvEKXEG
         SWM2IFGxf9y4e0iky89dYxpLu0iupdkigDupnJSY+A4xXqyjyLNZtAnyZsnFuhauHI1i
         wt3Q==
X-Gm-Message-State: AOAM530Ez2QC4tf0825QCjy2YK/YaKvDULyqeuGSL8FlxBstupnE+saL
        0Z0mGg/2iPFhp0GS6LcP8By7GZ5JySY9JSNf
X-Google-Smtp-Source: ABdhPJwpFMusnHTPcwSpvScqb9lSu3C1hZOVwiGTZ4E5HLcxeWDDSFh7BrqgcQOerA9Lf9/ryAlqeQ==
X-Received: by 2002:a05:6512:964:: with SMTP id v4mr3509245lft.91.1630775546997;
        Sat, 04 Sep 2021 10:12:26 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id e19sm300912ljl.47.2021.09.04.10.12.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 10:12:26 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id f2so3834217ljn.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:12:25 -0700 (PDT)
X-Received: by 2002:a2e:96c7:: with SMTP id d7mr3561133ljj.191.1630775545660;
 Sat, 04 Sep 2021 10:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <YTOF8VYTYNFYpB7O@zeniv-ca.linux.org.uk> <CAHk-=whho2pj4Au+rVpTGkoj7nJCEJwSfikLQVHDZ8kbKG7U1w@mail.gmail.com>
In-Reply-To: <CAHk-=whho2pj4Au+rVpTGkoj7nJCEJwSfikLQVHDZ8kbKG7U1w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Sep 2021 10:12:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whx9iKutjLY6iRBHg2TTzSDXgrZ0-Uj5sUqhyQZZQ_yRQ@mail.gmail.com>
Message-ID: <CAHk-=whx9iKutjLY6iRBHg2TTzSDXgrZ0-Uj5sUqhyQZZQ_yRQ@mail.gmail.com>
Subject: Re: [possible bug] missed wakeup in do_sigtimedwait()?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 9:59 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I agree, that seems like a bug, and your fix seems the trivially correct thing.

Oh, never mind.  Signals are special.

Why?

Because TASK_INTERRUPTIBLE is special, and schedule() will check for
"am I trying to sleep while a signal is pending" and will never
actually sleep.

So you can't have missed wakeups from signals, because this sequence
is perfectly ok, by design:

 - signal comes in and is pending

 - we set TASK_INTERRUPTIBLE

 - we are thinking about something *entirely* different, like looking
at a pipe being emty

 - we schedule()

and the pending signal will just mean that we never go to sleep.

It's designed that way exactly so that people who have interruptible
sleeps don't need to think about signals at all - they can concentrate
on doing their own thing, and then do the "signal_pending()" check at
any point without caring.

This has always been true, I had just swapped out that logic from memory.

             Linus
