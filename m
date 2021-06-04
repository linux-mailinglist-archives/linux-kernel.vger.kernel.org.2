Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498CD39BEF7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFDRlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFDRlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:41:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D314CC061767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:39:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v22so13913080lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9fPMUfjUiK0FrRER6EH6PeTXMziUWqxljccly8zx7c=;
        b=MJ0NfISVyYy/x/kclYN0s9fJRn5RliOT0U+w0BfCWBnLtWRtfPyvQRs2IIykEPgYRA
         iPmdQbb2zzRdZQzIE2X5p3HF4kbmJgxzs1DJCeD2N6RMTL7zDRAxmbT8zPfNnpdiIRZD
         KX2qRRFcTYEo6EAz4KL2o5iAZ1t2awg7AqCwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9fPMUfjUiK0FrRER6EH6PeTXMziUWqxljccly8zx7c=;
        b=PYfkuBQadeZHd/+Zx3W0VgJqXPRAHgEy1Zp/3+SkwL+YygdgNtk+nbeXdsi9i3sh7O
         pmkIcGTMoBux0BwMvGlAnYClPVPBnX0y7wHYl8j0FEE9kCkSyp1iNpQHxaag/heM8g8g
         t7geqk62lS0qe9/WQA7zmGGwbKs+0iDlszM1J+smr1xzSqP85OgXqyP/nqc5R/+LMbKU
         toTr7y0UOLweyU1e7pgb/VJvfurzmAH539hkpFCrAKXnVZvgC/l5g8JvRAPv8UOPlEr1
         lhSONPEMF+O23pgJLWmU+IdckZqZxCBH7+Dyh6s2GsNZrlzDpV+F6+RCL69Ke2p+7XGt
         MC5Q==
X-Gm-Message-State: AOAM533UBmx6/Q9LquLmZWWT3RFtNQXs6YtMh+7dVH7A9V0GVAQw2WKO
        yorMIicy3+s0CeHuQmkzWabNYIO4k8lyNxEh
X-Google-Smtp-Source: ABdhPJxc6JRH/IrIsThKaYTdPrvWlAvvoAkL5ZrzgC+rCr3bIHTBRPecIhLgiUATCVkqmfdHYxWogw==
X-Received: by 2002:a05:6512:1027:: with SMTP id r7mr3474622lfr.153.1622828340922;
        Fri, 04 Jun 2021 10:39:00 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id n5sm671760lfq.107.2021.06.04.10.38.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 10:39:00 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id i9so15200321lfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:38:59 -0700 (PDT)
X-Received: by 2002:a05:6512:baa:: with SMTP id b42mr3435945lfv.487.1622828339731;
 Fri, 04 Jun 2021 10:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
 <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net> <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
 <20210604172407.GJ18427@gate.crashing.org>
In-Reply-To: <20210604172407.GJ18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 10:38:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0Qvpn0pOOhJMGOim=psP3bhS2dEX1bAvQpmXs__vqiQ@mail.gmail.com>
Message-ID: <CAHk-=wj0Qvpn0pOOhJMGOim=psP3bhS2dEX1bAvQpmXs__vqiQ@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
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

On Fri, Jun 4, 2021 at 10:27 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> > Of course, we might want to make sure that the compiler doesn't go
> > "oh, empty asm, I can ignore it",
>
> It isn't allowed to do that.  GCC has this arguable misfeature where it
> doesn't show empty asm in the assembler output, but that has no bearing
> on anything but how human-readable the output is.

That sounds about right, but we have had people talking about the
compiler looking inside the asm string before.

So it worries me that some compiler person might at some point go all
breathy-voice on us and say "I am altering the deal. Pray I don't
alter it any further".

Side note: when grepping for what "barrier()" does on different
architectures and different compilers, I note that yes, it really is
just an empty asm volatile with a "memory" barrier. That should in all
way sbe sufficient.

BUT.

There's this really odd comment in <linux/compiler-intel.h> that talks
about some "ECC" compiler:

  /* Intel ECC compiler doesn't support gcc specific asm stmts.
   * It uses intrinsics to do the equivalent things.
   */

and it defines it as "__memory_barrier()". This seems to be an ia64 thing, but:

 - I cannot get google to find me any documentation on such an intrinsic

 - it seems to be bogus anyway, since we have "asm volatile" usage in
at least arch/ia64/mm/tlb.c

So I do note that "barrier()" has an odd definition in one odd ia64
case, and I can't find the semantics for it.

Admittedly I also cannot find it in myself to care. I don't think that
"Intel ECC" compiler case actually exists, and even if it does I don't
think itanium is relevant any more. But it was an odd detail on what
"barrier()" actually might mean to the compiler.

              Linus
