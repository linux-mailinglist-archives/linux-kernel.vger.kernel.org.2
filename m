Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18B93F6A19
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhHXTtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhHXTtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:49:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1AAC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:48:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d16so39601893ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+VIucdxRscrrUQHUBcwMBpfJ0EErD494EMkYvulJNE=;
        b=NLRLSyitIlgW1rcZ+5AvMAiC/lml/QOnCl2JQnqY5/JIVU0v3BMoHEinpZmCpPhVP0
         slt8rwQ1x3+0xrhnoLCm8XFfng0r4Ceililxq+JJmh6ULOzAEFE7RRqMR7BWoAyW5tv0
         Ptu8+m/iU43d7FwMcO5GAhPrD+dg0nrsS2z2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+VIucdxRscrrUQHUBcwMBpfJ0EErD494EMkYvulJNE=;
        b=LGoxm8TIS62Cv6aqw61CJGJm753x2cy9EbAVsm++6B2Ob/uYTyDQk0NSX5iQIkoZ5s
         LFxDpEvSdQZGOUVU+9DJYFDnsxE2pfRdg92tRVhqpHo7/VCDkD9EpXKlPGVLqWqNpDD3
         ZNCwaMP09GqiFR1kbjY4Y0PcvKVVikvEUYdDNPnwByS68YrUu7jiUwGHzO4/lTzHMySy
         QGH1qNuENduzTzR6gmgWbCQDOeSfnA26Brn42Y3qiwr0MGzlS/kuQQsa7JSnosC3GFLr
         K/60H/YYDYivroW8qmWPON4QrpR5pZoFeZQQv8W5oFMTLUuC78rLUFNPqnQyr1tVUsQu
         h+0g==
X-Gm-Message-State: AOAM532uApUSUP4hY5PRiit3O+li20nJisEifp5s2CDyGGVlUsnzobPg
        HfGIjIvmvEtdkHh6TPSWCMhrmqM4Z+Nm3WBt
X-Google-Smtp-Source: ABdhPJxtN4NXAtxtytmFeC1ut8kQEJMb6XD/mHH0Yxp+AFmEq01xTomjFyqn9hHQdusZ2BAPZ0hPPw==
X-Received: by 2002:a2e:9444:: with SMTP id o4mr33209975ljh.210.1629834510233;
        Tue, 24 Aug 2021 12:48:30 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id u3sm1827287lju.107.2021.08.24.12.48.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:48:29 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id w4so38087312ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:48:29 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr33004192ljc.251.1629834509146;
 Tue, 24 Aug 2021 12:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
 <1966106.1629832273@warthog.procyon.org.uk> <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
 <CAHk-=whd8ugrzMS-3bupkPQz9VS+dWHPpsVssrDfuFgfff+n5A@mail.gmail.com>
In-Reply-To: <CAHk-=whd8ugrzMS-3bupkPQz9VS+dWHPpsVssrDfuFgfff+n5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 12:48:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwRW1_o6iBOxtSE+vm7uiSr98wkTLbCze9-7wW0ZhOLQ@mail.gmail.com>
Message-ID: <CAHk-=wgwRW1_o6iBOxtSE+vm7uiSr98wkTLbCze9-7wW0ZhOLQ@mail.gmail.com>
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

On Tue, Aug 24, 2021 at 12:38 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> "pageset" is such a great name that we already use it, so I guess that
> doesn't work.

Actually, maybe I can backtrack on that a bit.

Maybe 'pageset' would work as a name. It's not used as a type right
now, but the usage where we do have those comments around 'struct
per_cpu_pages' are actually not that different from the folio kind of
thing. It has a list of "pages" that have a fixed order.

So that existing 'pageset' user might actually fit in conceptually.
The 'pageset' is only really used in comments and as part of a field
name, and the use does seem to be kind of consistent with the Willy's
use of a "aligned allocation-group of pages".

                 Linus
