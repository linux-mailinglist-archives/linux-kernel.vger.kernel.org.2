Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B426139BD24
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhFDQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFDQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:32:07 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFEDC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 09:30:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t7so7835100lff.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+KCY22dx//O8yKBxj7GElgNdKz9QEJ9C/z48QZLkP0=;
        b=Q0SDTPiRYq2yIU2qzA4zQezJqPCyIpRgdDRy5hzw0WsIyYEkLWCl62youFoH0X2uC0
         eVaISP8lDacL3mGgoXK3K6Ag2+p4ihUDx2/neQu9mt91HNI1IG6z88lysj5wO8G/RtxP
         Lslm9wLgxNXrM2ODEsKLK+rKm2h7dfub/WPgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+KCY22dx//O8yKBxj7GElgNdKz9QEJ9C/z48QZLkP0=;
        b=Qz0dRd0xqp7ID+3/uqK71H2WcD+taVYiAawGAEQNiN8EHv9nIlj13KM0zo7NTeuoVr
         LwWVanBWlNpPVm/OHkOdslMigb9fFZPDKz9rVao/h55KdrZv8V1hjDFn8pQ4eonxq7rM
         MelLyiR06FNCPJiOXbKgwn1uNdOGWYJ0EEZPxkjyq1PUBjUrDos3kZhRvlvrO0JILhim
         mPE+eLhDk/bS+KKv8nkYuTSK+H8Oy1VCp54AvlGr1N5+AOi8V4tcIxTR5DqNvtgLLQgU
         N0huPDHAhy5jlpXIyt0mjCCDmNaK7iImqDERa9pHq84CsbutA7Gy2SHUCYYcjDBx8XYz
         eaog==
X-Gm-Message-State: AOAM531KA6/FBA6XOkq6UAvhnSKg+s1L4STio4tMFXm45HKyVAZ0zogm
        BQP1RvHl16jVCJJ/i+pR3ymXxSeUN9GEFV2c
X-Google-Smtp-Source: ABdhPJxurJfCjDWC4c58zuyzocd6LguWqtPX9HjEY9g2xjGIM2epjvmpKhsf7rNznjj0RGWcoVbliA==
X-Received: by 2002:a05:6512:3327:: with SMTP id l7mr881909lfe.113.1622824218859;
        Fri, 04 Jun 2021 09:30:18 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o17sm656309lfi.91.2021.06.04.09.30.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 09:30:18 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t7so7834969lff.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:30:17 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr3311306lfl.253.1622824217183;
 Fri, 04 Jun 2021 09:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
In-Reply-To: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 09:30:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
Message-ID: <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 3:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I've converted most architectures we care about, and the rest will get
> an extra smp_mb() by means of the 'generic' fallback implementation (for
> now).

Why is "volatile_if()" not just

       #define barier_true() ({ barrier(); 1; })

       #define volatile_if(x) if ((x) && barrier_true())

because that should essentially cause the same thing - the compiler
should be *forced* to create one conditional branch (because "barrier"
is an asm that can't be done on the false side, so it can't do it with
arithmetic or other games), and after that we're done.

No need for per-architecture "asm goto" games. No new memory barriers.
No actual new code generation (except for the empty asm volatile that
is a barrier).

              Linus
