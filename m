Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7373F69CB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhHXT00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhHXT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:26:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46168C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:25:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so47745975lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZJyYVORrCiAyJfqjWHoPU9PIFZ88DitsmtYgIA7rQ4=;
        b=KtXnGitBkvxfOgqJRNuwi+8709mbnBLpqTuREEhVvpbMPwWaovy2KY9NAyJLvsfAEZ
         1V1wAe8ouRjxf9LTndxeO7Z+UHxlIm0NFECFKbrxrI2kT1jgXK9GwPGvsFC73in9KpWb
         1oiPXuvWItsl7evaUnfeF/dDHy6N+uJbuNkFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZJyYVORrCiAyJfqjWHoPU9PIFZ88DitsmtYgIA7rQ4=;
        b=kXZG4tBfdctvF4Wt+mCjLEXpkFBNrl8LdB0CgIZ5ERI3506pEEZx2H14BdNne5RC+t
         aPDfV6u5p0txoldmmnW4Hsm3ooe0QYeLiKTroR/s10sJYdcuxuyTv9u9mv+NMR69qqKq
         Pv0LxANhoAIPmWAtCVsw0f19ve8ZuDeyMFAwJsnQGPuNFppgaSklf3xLFjlQYm9eArPk
         kexGAKwdkqhebU41cS6vfYsb3cNU4lMK0UddJE85lM4VwK1R6E9cl6dnF8/wQS6DhadP
         nmXIuj9+5ALFh8jUqQxEnYDoTTkk9vy8w23UGGfICgyZ0JNCFc16Ek8dG04bcudAbAsr
         y2Yg==
X-Gm-Message-State: AOAM531GpCMSyvwrYoqayh+DUcap0p16awo3hpkvEELoVA0LSBvyd+Nj
        389t3QUsN3O+H7nysWgV0J+JTl789xa+b9up
X-Google-Smtp-Source: ABdhPJy/L/uk9aoKxwDhwf58dgFpaP1VWLO8AxGY/0aWYVy/4/vBlbpkP23BsjabsybSEDy30jygQA==
X-Received: by 2002:a19:7b17:: with SMTP id w23mr26975005lfc.61.1629833132325;
        Tue, 24 Aug 2021 12:25:32 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f30sm1834101lfj.219.2021.08.24.12.25.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:25:31 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id i9so47715765lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:25:31 -0700 (PDT)
X-Received: by 2002:ac2:4da5:: with SMTP id h5mr16581349lfe.40.1629833131285;
 Tue, 24 Aug 2021 12:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com> <1966106.1629832273@warthog.procyon.org.uk>
In-Reply-To: <1966106.1629832273@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 12:25:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
Message-ID: <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:11 PM David Howells <dhowells@redhat.com> wrote:
>
> "page_group"?  I would suggest "pgroup", but that's already taken.  Maybe
> "page_set" with "pset" as a shorthand pointer name.  Or "struct pset/pgset"?

Please don't do the "shorthand" thing. Names like "pset" and "pgroup"
are pure and utter garbage, and make no sense and describe nothing at
all.

If you want a pointer name and don't need a descriptive name because
there is no ambiguity, you might as well just use 'p'. And if you want
to make it clear that it's a collection of pages, you might as well
use "pages".

Variable naming is one thing, and tere's nothing wrong with variable
names like 'i', 'p' and 'pages'. The variable name should come from
the context, and 'a' and 'b' can make perfect sense (and 'new' and
'old' can be very good names that clarify what the usage is - C++
people can go pound sand, they mis-designed the language keywords).

But the *type* name should describe the type, and it sure shouldn't be
anything like pset/pgroup.

Something like "page_group" or "pageset" sound reasonable to me as type names.

                      Linus
