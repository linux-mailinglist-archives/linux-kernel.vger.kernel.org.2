Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBF140BC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhINXbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhINXbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:31:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7455EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:29:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g1so1906138lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PDbAl7XBZ5+izFdXy34C90+UtfxGn4oelrSaT4hvZo=;
        b=hlSJFVl2f17plnlKffHP/5QoB3uHmrBbD+1tiGUIZLKiDMBgtJ3uBmdOSRBxP5+jsD
         aaKltm8spMSCmqJAcuexFIwMAQnUUPYC0fbxtQ9uTnNTtEb0pDhDsTsD8r8bhE5H+b5P
         9C4lDvKr/M/ipfhZIzHDgdS25QNz/6UuPzLkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PDbAl7XBZ5+izFdXy34C90+UtfxGn4oelrSaT4hvZo=;
        b=VW9lt6KRHZIQdGGidDDxqcPhnVP5PpBVhsScPJTG+saoaRQpMPattIK/PAfYRjhT/j
         fb7bbShlZBa4njonDO0NbpogXpf3ZClgich5MXVixJzYlMPy5j7Hu3zmdPpB9B9DloG6
         Q5o/s6UfT2vtRcB10h6Jx10KoLyar6rmNfTeMy+uAnrE8MhyPSIGPv9bclI11AriGLpw
         msri4Mhe3o/nlnd7hK4+qpCYPaevziLdz49A8/sg/K1H42VXcN9owYuydZBGpau11fBn
         1ZD/Vkj74LT/fQdKrfDuKEuUDut2H12cTSMoXXG52QTy1Pfb4BUFwsUxgwxhj6skkd5f
         lw4A==
X-Gm-Message-State: AOAM531WY3FrP8qyri97KSnYPMKM9w1vULFkrkTNQj+gEKZknrF/s6a5
        y/4D+d+d8j9/QqpKuu1fjzUGE4jEJQ0TD1M/ZFg=
X-Google-Smtp-Source: ABdhPJwaR/n8I006wf/fBu7kr6uxydvqQGNG/x8CAvQJeqwYu+RLRfhy2Xct3nHypjO6uo43zALOHQ==
X-Received: by 2002:a05:6512:318a:: with SMTP id i10mr15647780lfe.444.1631662184404;
        Tue, 14 Sep 2021 16:29:44 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w25sm1231861lfu.123.2021.09.14.16.29.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 16:29:43 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id j12so1667195ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:29:43 -0700 (PDT)
X-Received: by 2002:a2e:96c7:: with SMTP id d7mr17832442ljj.191.1631662183146;
 Tue, 14 Sep 2021 16:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210914105620.677b90e5@oasis.local.home> <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
 <20210914145953.189f15dc@oasis.local.home> <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
 <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com>
 <CAHk-=whBd5Sgg4if7HB4o0Zrj3eNprKv9U02uEUB1QhQvrsQZw@mail.gmail.com>
 <CAHk-=wipBkq-OeUBsgv-_hvTfg=nveTpiZonWeY1dBMofkjEuw@mail.gmail.com>
 <20210914170553.7c1e1faa@oasis.local.home> <4392e867-0cce-d04a-e3d1-cba152daaa1f@suse.cz>
In-Reply-To: <4392e867-0cce-d04a-e3d1-cba152daaa1f@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 16:29:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimTmUcYC_BPvwv-48OFwpzJhzrX-_9afk--ND6en81Xg@mail.gmail.com>
Message-ID: <CAHk-=wimTmUcYC_BPvwv-48OFwpzJhzrX-_9afk--ND6en81Xg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 3:48 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Well, looks like I can't. Commit 77e02cf57b6cf does boot fine for me,
> multiple times. But so now does the parent commit 6a4746ba06191. Looks like
> the magic is gone. I'm now surprised how deterministic it was during the
> bisect (most bad cases manifested on first boot, only few at second).

Well, your report was clearly memory corruption by the invalid
memblock_free() just ending up causing random problems later on.

So it could easily be 100% deterministic with a certain memory layout
at a particular commit. And then enough other changes later, and it's
all gone, because the memory corruption now hits something else that
didn't even care.

The code for your oops was

   0: 48 8b 17              mov    (%rdi),%rdx
   3: 48 39 d7              cmp    %rdx,%rdi
   6: 74 43                je     0x4b
   8: 48 8b 47 08          mov    0x8(%rdi),%rax
   c: 48 85 c0              test   %rax,%rax
   f: 74 23                je     0x34
  11: 49 89 c0              mov    %rax,%r8
  14:* 48 8b 40 10          mov    0x10(%rax),%rax <-- trapping instruction

and that's the start of rb_next(), so what's going on is that
"rb->rb_right" (the second word of 'struct rb_node') ends up having
that value in %rax:

  RAX: 343479726f6d656d

which is ASCII "44yromem" rather than a valid pointer if I looked that up right.

And just _slightly_ different allocation patterns, and your 'struct
rb_node' gets allocated somewhere else, and you don't see the oops at
all, or you get it later in some different place.

Most memory corruption doesn't cause oopses, because most memory isn't
used as pointers etc.

What you _could_ try if you care enough is

 - go back to the thing you bisectted to where you can still hopefully
recreate the problem

 - apply that patch at that point with no other changes

and then the test would hopefully be closer to the state you could
re-create the problem.

And hopefully it would still not reproduce, just because the bug is
fixed, of course ;)

The very unlikely alternative is that your bisect was just pure random
bad luck and hit the wrong commit entirely, and the oops was due to
some other problem.

But it does seem unlikely to be something else. Usually when bisects
go off into the weeds due to not being reproducible, they go very
obviously off into the weeds rather than point to something that ends
up having a very similar bug.

           Linus
