Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F8741F4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355774AbhJASUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354947AbhJASUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:20:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2CBC06177F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 11:18:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y23so7062149lfj.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuvJOD3DzRGmVW6xcad8F/v9YB5VsSRjw/nzs5q47b4=;
        b=MgDHcdJSmX13uyCrfEHU0FYoJQ1hXzA5UW2GY94/ufFm/9Qq3zH15vPjnENcyoArkK
         FU67Ww/nLrIPvwuOcYozEGxrgnmYrE/xtwICCE/8r8Fq7gG7HGJlLyPDKnPGIQOpwv4h
         TG9h2lpDce0CjWYasQzV5YqhInUJMedEFM9PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuvJOD3DzRGmVW6xcad8F/v9YB5VsSRjw/nzs5q47b4=;
        b=dpBoOJHfaQS82iUMv84RTc2ch6L0We+yJwHdyFwLsBCdKgEB3Jd8epteqy6Katx2uh
         PaO7MtcezQaQWPgGz4KzIWwtuK7PKzZnbFksjCwoKu28AYR/w/3qYGczYtTcUnpxX/Qv
         ZFql7TipSKVPRepMJSZYyrb8RDNK4FMu/tuEKss3jKWizMrf2OblWF4m8X9PJj/firYo
         HU5f7BHJvLvXpB+PI+adrSBeoI5fCLZl5f9nvCF868iaPADQvxPybClZ46qipqof8ywv
         Np6JEkf/ekW9ShrVkTJH3WlRchP/ZPmAqnRgt8U7n3e2WwIHclBmjKuf2D9ygiyoe/ER
         MvBw==
X-Gm-Message-State: AOAM532/IuGQS1XslkRNJ6qnH9FrPyoO/lpmRFkdsJu8uAmzlE7MX6yp
        d59+eqllV7zJA66IQaRkAFRvn4iFGOAoUuW/VDc=
X-Google-Smtp-Source: ABdhPJxxVuB3jOoqlT/n+2/XjIRp6+e1MzvosSv57Pged6yj7ZiPtxcgu96qsGCMpqhRKTqkRxuIHA==
X-Received: by 2002:a19:645c:: with SMTP id b28mr7036376lfj.60.1633112335646;
        Fri, 01 Oct 2021 11:18:55 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z12sm808101lfd.283.2021.10.01.11.18.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 11:18:54 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id x27so42096081lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:18:53 -0700 (PDT)
X-Received: by 2002:ac2:51a6:: with SMTP id f6mr147804lfk.150.1633112333146;
 Fri, 01 Oct 2021 11:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <YVRWyq+rDeAFLx+X@elver.google.com> <1340204910.47919.1633103136293.JavaMail.zimbra@efficios.com>
 <CAHk-=whcN4ACLFvst0THwwpUFK4DDSM4O_frSoUQJ1m+0ENWjw@mail.gmail.com> <1097444747.48074.1633109281556.JavaMail.zimbra@efficios.com>
In-Reply-To: <1097444747.48074.1633109281556.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Oct 2021 11:18:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whi_B36yw9Haw3sfSQhF7+Y1=bn_y2S=DwZ533yuF=izw@mail.gmail.com>
Message-ID: <CAHk-=whi_B36yw9Haw3sfSQhF7+Y1=bn_y2S=DwZ533yuF=izw@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        paulmck <paulmck@kernel.org>,
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

On Fri, Oct 1, 2021 at 10:28 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I've spent some quality time staring at generated assembler diff in the past
> days, and looking for code patterns of refcount_dec_and_test users, without
> much success. There are some cases which end up working by chance, e.g. in
> cases where the if leg has a smp_acquire__after_ctrl_dep and the else leg has
> code that emits a barrier(), but I did not find any buggy generated
> code per se. In order to observe those issues in real life, we would
> really need to have identical then/else legs to the branch.

Yeah, that's been very much my feeling too during this whole
discussion (including, very much, earlier threads).

All the examples about this being a problem are those kinds of
"identical or near-identical if/else statements" and they just don't
seem to be all that realistic.

Because immediately when the if-statement actually does something
_meaningful_, it just turns into a branch. And when people use atomics
- even the weak READ/WRITE_ONCE() kinds of things, never mind anything
stronger - it really doesn't give the compiler the option to move
things around all that much.

There's a reason the source code uses an if-statement, after all: that
is literally the logical code flow, and people write a very particular
dependency chain that is just very fundamental.

Having essentially the same thing on both sides just isn't a realistic
thing to do, and if it were - and you cared about performance in that
case, which is what this is all about, after all - you'd write it very
differently.

                Linus
