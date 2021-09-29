Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF241CF28
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346519AbhI2WVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhI2WVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:21:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBFCC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:19:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z24so16777163lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gblz1s4/t5kM/Sz4vMBI9n/3xu6XJFKh+IQyPNqJVx0=;
        b=SE2FoWPC1cgZ7I0c47+ZUKwshBeV9+l8hWP91guv0aWjELOTrsUJ4GJ8oRfVDwmB0w
         f1MXRi/7V7R60OwcBgRBbLwO2pvNyxx4+m3AMZXtcITI95m7T+LB7PvJZKZGagyobqhR
         sz/KJyQd1t5hCoxOw+kggHMLLr+KkZhJ6yOVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gblz1s4/t5kM/Sz4vMBI9n/3xu6XJFKh+IQyPNqJVx0=;
        b=B0EqKY1RRoZ7maG2BY5Ij2/1q1l9B0wURHENnATq95uiwpHkc9f1QXx5mUbXTL6oDD
         wQKQjZ3tZavGo1yrqXNFDYld10aWX+VTXI2mEUhJThZD4aUPZTyS8A8KQtQYSjEqes+G
         KHiB39pFGchVb4HR+Fd7bOT8G/3YsdPknO39q44M7UaUoBYRY2Cfov/KI8sIOqWHCVBw
         shaI2tTsssaD84rtsxW4phPQDyJsslEzIM0ni7ahMZ+lpEc6lX/LQjHWZczffF+CP2ID
         B2M/P5C0rBhunyzffgAUOZnOudxTJcgIyT8IvkkvBKTepsPz5RpIJja6mNUmkOMGAi8N
         v16g==
X-Gm-Message-State: AOAM531a8KYzlzgrd/0n6X2XR7MpCh9pWBYSwDqmR/QHcCbmtH13NXyS
        aIEAZVBtmrteFeyT2A8w/safLdJhndkhSyQF
X-Google-Smtp-Source: ABdhPJyDRKRrDrhUa1lh6M0R3K5ScsyaxjRO42sve6mJKwLpCJCKxFHCXZicD3pI440gBGbdmnBlRg==
X-Received: by 2002:a05:651c:1549:: with SMTP id y9mr2433781ljp.105.1632953997402;
        Wed, 29 Sep 2021 15:19:57 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id h23sm123655lja.131.2021.09.29.15.19.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 15:19:57 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id e15so16878047lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:19:57 -0700 (PDT)
X-Received: by 2002:a05:6512:984:: with SMTP id w4mr2143060lft.141.1632953673075;
 Wed, 29 Sep 2021 15:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com> <1882826966.44389.1632943626923.JavaMail.zimbra@efficios.com>
In-Reply-To: <1882826966.44389.1632943626923.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Sep 2021 15:14:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0oguMasoc_E83MVpC61zepZGGiALVyu91BsfrYt_RiQ@mail.gmail.com>
Message-ID: <CAHk-=wg0oguMasoc_E83MVpC61zepZGGiALVyu91BsfrYt_RiQ@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:27 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> If we go for only using ctrl_dep() for scenarios which require it for
> documented reasons, then we would need to leave in place all the
> caveats details in Documentation/memory-barriers.txt, and document
> that in those scenarios ctrl_dep() should be used. This would be a
> starting point I guess.

So to me, it's really that starting point  that I feel needs to truly
explain the whole concept.

I'm ok with people adding more cases later (but would still want to
see a comment about exactly why that ctrl_dep() is needed), but the
initial commit is the one that I want to hold up to much higher
standards.

Those higher standards being: "there's an actual bug here" along with
documenting what exactly is going on in that particular case.

Because I do *not* want to introduce this as "ctrl_dep() documents the
control dependency".

If it's _only_ documentation, then a pure comment will do.

So to me, the only reason to actually have a ctrl_dep() macro is that
we have an actual and existing real true bug.

If the only reason for ctrl_dep() is made-up code that doesn't
actually exist, ie

        if (READ_ONCE(x))
                WRITE_ONCE(y,1);
        else
                WRITE_ONCE(y,1);

and the "READ_ONCE()" and "WRITE_ONCE()" being ordered in the face of
made-up examples like this, then ctrl_dep() shouldn't exist.

(The alternative being some "if the compiler can statically know the
direction of the 'if()'" which is I think _equally_ made up, since the
whole point of a control dependency is that it's dynamic, and no
compiler can ever statiaclly determine the direction).

See?

This is why I want to have a real actual live example for that first commit.

If we then in *other* cases add a "ctrl_dep()" for documentation
reasons, and because somebody is unsure about what the "if/else" sides
can contain and wants to make sure they cannot be merged, that's a
separate thing.

But if we can't find a single case where this truly matters and the
particular actual present bug can be shown, then it really makes me go
"is this just all theoretical for purely made up examples that aren't
realistic"?

I mean - just look at the above example of "could be done without the
'if()', and then re-ordered by the hardware". It really isn't very
realistic.

              Linus
