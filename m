Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE35D3BAEA6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGDUEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhGDUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:04:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FEFC061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 13:01:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id k8so21614996lja.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Md0gkKPz/DPxslMHek692MiRmAvxsrMN/TT/CR51lc=;
        b=YsYWx0zFx/g3ttKgXjHiGoLpm2aBbbHr+R+8iUTfyFXnH0c0hJf1cBHsoN6Ifv2KF3
         qPNIDIzqg491I56rIOmTyAzf1eY4dqISXJ839lUtLcvqhR9QC+2sgh2QPG0aujHGn3yJ
         zDCM2xPC7E1KN4oMI7+TKw0c5wk9e1PA0ZWT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Md0gkKPz/DPxslMHek692MiRmAvxsrMN/TT/CR51lc=;
        b=kXXJ674owYOULNjsg6FEbxCwpbxFk2M8vqMFcEbOye3hcJJlo7b/7/mcGHNl5zjPFA
         KoKvFyenPT0enTm5rPKzfaIEWDEJXpyQcscQJLTsj900qvW7WvREamOu/tXkix4aXuoD
         ou6NNLooEJ7cWwBF1immgl3tuc3udtb5QD+1bDaj45pZuK/0ThRJYzzjuT/fcLXM9B/N
         e4PCm1EcrbchAHEOANOsnzNRX96rQJ1JKzPHw7VtBSY4ovRhWwmlV9TxWIBkWQZ9L+8P
         zdcMVsGK6zZSw5/Koa/T4q+Xj3MqlRLHG0HppPYBV+UFk4GhwzIeHyzpzKKTKYIiynlA
         LsdA==
X-Gm-Message-State: AOAM531w5Sy6A3djvV3lNe/70J2u+n7fFuGAtX8wkYOs6tN9ZVqXfK07
        H+emP1hdOJFgFy4JOJz417Pe72fA/CeuvbPG
X-Google-Smtp-Source: ABdhPJxKMvc/TIBFkqB+Pe0BoWoNy3gCkcftlS3c5qT5e+KoKkiFQZ0uaKmCVYEqd0JbN5oXPPgdeg==
X-Received: by 2002:a2e:585c:: with SMTP id x28mr888140ljd.385.1625428910348;
        Sun, 04 Jul 2021 13:01:50 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k12sm316029lfv.14.2021.07.04.13.01.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 13:01:49 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id f30so28560120lfj.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 13:01:49 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr7617377lfc.201.1625428909235;
 Sun, 04 Jul 2021 13:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172440.GA2966393@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210704172440.GA2966393@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 13:01:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSGHOiuv1yARox+P3k2uTLtJ=F51aKoJYVi5UPgjitCQ@mail.gmail.com>
Message-ID: <CAHk-=whSGHOiuv1yARox+P3k2uTLtJ=F51aKoJYVi5UPgjitCQ@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v5.14
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 4, 2021 at 10:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> An example merge resolution may be found here:
>
>         4e2b64e124c7 ("Merge remote-tracking branch 'linus/master' into HEAD")

There sommit ID's are completely useless, because I have no idea where
they come from. They aren't in the linux-next tree as far as I can
tell, for example.

So they are just random noise.

Now, none of the conflicts looked in the least complicated, so it's
not like I _need_ the examples, but this "send random shortened SHA1s
to Linus" is simply not useful.

At a guess, it's actually from your merge-example branch in your own tree.

The point being, that a SHA1 may be globally unique, but without
telling me where that SHA1 can be _found_, it is entirely useless.

If you have example merges - which I do like seeing, and I will
compare against just to double-check even when I have no reason to
doubt my own merge - you need to point to it the same way you point to
the actual real branch.

IOW, say something like

  "I've done an example merge, and you can find it in

     git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
rcu-example-merge"

or similar.

Because actual SHA1 names are only useful WHEN THEY ARE IN MY TREE. So
you can point to history that I have (or that was in your actual pull
request), and I can see _those_ just fine.

So when you say

  "The second is a trivial whitespace conflict between these two commits:

        76c8eaafe4f0 ("rcu: Create an unrcu_pointer() to remove __rcu
from a pointer")
        b9964ce74544 ("rcu: Create an unrcu_pointer() to remove __rcu
from a pointer")"

then that makes sense, because those are two commits that I actually
have as part of the merge conflict).

But that example merge? I don't have it, unless you actually tell me
where it is.

Then I can just do

      git fetch <paul-told-me-where-to-fetch>

and can do

    git show FETCH_HEAD

or (more commonly) just compare my merge result with yours:

    git diff FETCH_HEAD kernel/rcu/tree_stall.h

and it's all golden. But if you send me a random SHA1 of somethign
that only exists in your trees, I just go "oh, ok, not useful".

           Linus
