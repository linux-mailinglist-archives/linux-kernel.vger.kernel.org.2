Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26071400587
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbhICTJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350440AbhICTJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:09:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A045C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:08:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s3so320483ljp.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXv355oswFlihE8Wkmp+jzxg7i8K3CPb1oZ1YHa8zTE=;
        b=bruE3ijbbS/LB9tFEk5ZgJ2iV1ZsvkruGV2DXjs2fpOT2jbUP2tE3yK4S1kjLy3sAb
         0tbaZnPM2scyeuozZeMQld8/u2rtq4R6ABfL1sKY9snT9NG9/I8/C1oGLEFFS3Ygfpbp
         kpbTF9ozbCW4bFLsYRjfDxFzRK3zLKJrDFeEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXv355oswFlihE8Wkmp+jzxg7i8K3CPb1oZ1YHa8zTE=;
        b=af5yuzXQcECRTAwRP/oq/HKWyP6gCYFPRnGbgQhWrOTyHVlrqqkBJwAj1aJVhldhHj
         ULlduHg4DkLC7aZFzCLmEWGOlXdCf4JQJ7vkfc/QUNvCuxF6L10NJr0FPZr5lqOTGDa8
         D7ivbD2ZF8S73dhthium/ceDaFzUhsIRFkgDXZjMM9CuoVgzgWyzticgIVJCeLbm9uW0
         Iwth7+1Tn7djkH3piL37ElTsUWmK1wLmuKj7udgZD4lk4h7HHJ/OwLi87doCwmWdfC4C
         pljYi8nPMxdAJhXWYzmk4kURSAQQ2mXnA4cjffzRRL7vFZEzn6lCsjtg20WZb88rxPIF
         fbFQ==
X-Gm-Message-State: AOAM531hOdiJfYjYXukBy5U6HFU94QKTvQjkflCy9gTgpIFh6A3X6SWm
        4Ne3pGfQB3wjqeneMNkR7Ri8WDPG5+KZ2elrm8o=
X-Google-Smtp-Source: ABdhPJyQPDoLI7f9nGhMel2QONaKJIUHg0QAC16CqCEnzCGBjXvmUy2gpGKvqmLvefo+in7dgyqjLw==
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr357439ljp.344.1630696101765;
        Fri, 03 Sep 2021 12:08:21 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id d20sm28016lfv.117.2021.09.03.12.08.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 12:08:20 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y34so224583lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:08:19 -0700 (PDT)
X-Received: by 2002:a05:6512:3d28:: with SMTP id d40mr299531lfv.474.1630696099356;
 Fri, 03 Sep 2021 12:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org> <1630552995.2mupnzoqzs.astroid@bobo.none>
 <YTCktV3KF9PzIACU@casper.infradead.org> <1630652670.aplcvu6g23.astroid@bobo.none>
 <YTJxFgD0kKPs51dz@casper.infradead.org>
In-Reply-To: <YTJxFgD0kKPs51dz@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 12:08:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCf1PAs7D0oGwVLfuJYxCcKeb3ApTF8E+PHGNJE7UW+w@mail.gmail.com>
Message-ID: <CAHk-=whCf1PAs7D0oGwVLfuJYxCcKeb3ApTF8E+PHGNJE7UW+w@mail.gmail.com>
Subject: Re: Is it possible to implement the per-node page cache for programs/libraries?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Frank Wang <zwang@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 12:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Was there a reason you chose to do it that way instead of having per-node
> i_mapping pointers?

You can't have per-node i_mapping pointers without huge coherence issues.

If you don't care about coherence, that's fine - but that has to be a
user-space decision (ie "I will just replicate this file").

You can't just have the kernel decide "I'll map this set of pages on
this node, and that other ser of pages on that other node", in case
there's MAP_SHARED things going on.

Anyway, I think very fundamentally this is one of those things where
99.9% of all people don't care, and DO NOT WANT the complexity.

And the 0.1% that _does_ care really could and should do this in user
space, because they know they care.

Asking the kernel to do complex things in critical core functions for
something that is very very rare and irrelevant to most people, and
that can and should just be done in user space for the people who care
is the wrong approach.

Because the question here really should be "is this truly important,
and does this need kernel help because user space simply cannot do it
itself".

And the answer is a fairly simple "no".

            Linus
