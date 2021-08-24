Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998EB3F6968
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhHXTBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhHXTA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:00:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE722C061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:00:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g13so47553019lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8GMAuZs3SF8G+2KitM/POFRgnyCkDTcN34+zOcLvgc=;
        b=aH6CPYiXxnGWOs0D+02Zg2N/IGvBu9mHmNR0D/J0PG92yW1XDHpw2xOFhxWZSK3zTn
         uydZvilXdZqJMGTtIQeufhHszHnba5FqFkcLSZ2sO8WPBh7xw3FVtx/KxdJbQbMuwp3Y
         DPkzbmfpvKe+X0kNdcEXYpRqTcu4VNMDQhRFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8GMAuZs3SF8G+2KitM/POFRgnyCkDTcN34+zOcLvgc=;
        b=ZKy/uJwbnZNO8EMrkmAtCoxMdf8OABazOfyPWU94NilcdcL6NtTVW1jHJpUAUQxR7O
         9JuGyAdRgSj3pkXVeLtosyXDCa2aeToaujuLAuddpL64N7oZUnK6Z+SaAgi/KQkhYBcI
         H1eUqFh8AuHF6YqqffcPqthYDLC2VJNNTKN9+3UgbbX3uIuo1LX9PgDwUhUlRSok7S9u
         YRLQwnyImfJmnvbuqSuhMCH4szoZlVwRlMO1ivCvRWjWfrCvJdUiAdE+/Sr10c7UUz2H
         pp194U7NTrJJ4tSvYsx4nBAFEM63kOWHa9I163/fNNqlS2bQ1fx2CdJFvs0SdTDJYYih
         WqRA==
X-Gm-Message-State: AOAM532PP7Dj+I3zGv22u0hV1lboMm8I6UgOO0J5Fv5loDROF1ZXqCaA
        N7ShPccMvjAcdVR0BObD9Rzfd1geRrQoRw0c
X-Google-Smtp-Source: ABdhPJyg+VHmeccgmF3is8ld2rF0s7Lf9JiixWEiK8G9b9XJQuR+4wJMaXvSLoU9X/TPNZUzqF0rjA==
X-Received: by 2002:a05:6512:b09:: with SMTP id w9mr13425328lfu.394.1629831609933;
        Tue, 24 Aug 2021 12:00:09 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a3sm1867603ljj.122.2021.08.24.12.00.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:00:09 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m28so1304372lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:00:08 -0700 (PDT)
X-Received: by 2002:a05:6512:104b:: with SMTP id c11mr26021753lfb.201.1629831608481;
 Tue, 24 Aug 2021 12:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org> <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
In-Reply-To: <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 11:59:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkA=RKJ-vke0EoOUK19Hv1f=47Da6pWAWQZPhjKD6WOg@mail.gmail.com>
Message-ID: <CAHk-=wgkA=RKJ-vke0EoOUK19Hv1f=47Da6pWAWQZPhjKD6WOg@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Unlike the filesystem side, this seems like a lot of churn for very
> little tangible value. And leaves us with an end result that nobody
> appears to be terribly excited about.

Well, there is actually some fairly well documented tangible value:
our page accessor helper functions spend an absolutely insane amount
of effort and time on just checking "is this a head page", and
following the "compound_head" pointer etc.

Functions that *used* to be trivial - and are still used as if they
were - generate nasty complex code.

I'm thinking things like "get_page()" - it increments the reference
count to the page. It's just a single atomic increment, right.

Wrong..

It's still inlined, but it generates these incredible gyrations with
testing the low bit of a field, doing two very different things based
on whether it is set, and now we have that "is it close to overflow"
test too (ok, that one is dependent on VM_DEBUG), so it actually
generates two conditional branches, odd bit tests, lots of extra calls
etc etc,

So "get_page()" should probably not be an inline function any more.
And that's just the first thing I happened to look at. I think we have
those "head = compound_head(page)" all over the VM code,

And no, that "look up the compound page header" is not necessarily the
biggest part of it, but it's definitely one part of it. And if we had
a "we know this page is a head page" that all just goes away.

And in a lot of cases, we *do* know that. Which is exactly the kind of
static knowledge that the folio patches expose.

But it is a lot of churn. And it basically duplicates all our page
functions, just to have those simplified versions. And It's very core
code, and while I appreciate the cleverness of the "folio" name, I do
think it makes the end result perhaps subtler than it needs to be.

The one thing I do like about it is how it uses the type system to be
incremental.

So I don't hate the patches. I think they are clever, I think they are
likely worthwhile, but I also certainly don't love them.

               Linus
