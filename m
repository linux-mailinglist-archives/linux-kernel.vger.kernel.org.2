Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02A141C446
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbhI2MI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244801AbhI2MIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:08:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:06:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso1597126wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZUrTE1lS5oIQTax5a5GDZNIHxuc33ruzP5rR4Lxz3a4=;
        b=L9L8l3oRRCUvc5C06ylk3QB5ulMPbJNFwY0fYsVM90Vgcer/pyRPhVMfJGhSnAFat+
         60xoKm60FPIUdbXcRxL35Ku7ILoMum7BJOQARbKZJ3gkIPW7TAUN5MR70IvhQHBf8glw
         Bc7NaJeOGqTHuveTKQCTz1s0SIk1nFAIBd7gc0deghB+XhA4s6P3pHP5sAJnXqfeYuB4
         Hm/ykR70aMyFN+t5KNGJ1XceRvh6/Fqeti+qIeG387oMOUp4O1zj27whEbO/H1nqpraL
         KVxqTfMIlvk+ZTkzfB+l+EyI+JO78WloJ5mS/eXpuhePh21OCZgrStV1BGdNemHWtW3i
         f/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUrTE1lS5oIQTax5a5GDZNIHxuc33ruzP5rR4Lxz3a4=;
        b=3hhh7EGW22yue/uolIST+5iJcQ1Y2K13NNtsZg+eZQMSivl4ggTpAGa1g+dy8VREf1
         7Db8yr7R3VsFIXg5vD6t4AuGtih/1ZmXPs6MmuBXiSrCThjdCzgtAadT5zYUJRqei0W3
         TrHoZD+2Ac1U0X7m91YHcogXuvUBp7HSyQDjuYY7OVpJplP5Wkz7XZf0832vFdfUJawE
         XVVBEZUydsFbICxwDw7ye5j/qwz7Xod0K5ahtP21rYr63qHERTgPvzJvWh6zjOcwF22S
         vWHzKv9ElzX8nqtFOsRZN/VGVUiBWJMa3Cm5bk7+jQMKt+FoYMeMz+WSVjyT3vfSrt1W
         Wfgw==
X-Gm-Message-State: AOAM530+oAvNBycF+tMtWn1i0SljTLgi9FqMgDbiUK4o4omVRjOgyztI
        E+TlOWQUb4L/BQgxbLqikY709Q==
X-Google-Smtp-Source: ABdhPJyKpv3fF+OhFeUpeh+ujdRxW+mTeSxbgwm1QX7Dkuh0JV9ldlAvn1O8sVNnBBDCiszeUzyf0A==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr9981711wmb.139.1632917201096;
        Wed, 29 Sep 2021 05:06:41 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:c9be:b970:304:6a4d])
        by smtp.gmail.com with ESMTPSA id b15sm2601582wru.9.2021.09.29.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 05:06:40 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:06:34 +0200
From:   Marco Elver <elver@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     will@kernel.org, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Message-ID: <YVRWyq+rDeAFLx+X@elver.google.com>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 05:15PM -0400, Mathieu Desnoyers wrote:
> The control dependency ordering currently documented in
> Documentation/memory-barriers.txt is fragile and can be broken by
> various compiler optimizations.
> 
> The goal here is to prevent the compiler from being able to optimize a
> conditional branch into something which lacks the control dependency,
> while letting the compiler choose the best conditional branch in each
> case.
> 
> Prevent the compiler from considering the two legs of a conditional
> branch as identical by adding a distinct volatile asm in each leg of the
> branch. Those asm do not emit any instruction nor data into the
> resulting executable, and do not have any clobbers.
> 
> GNU describes asm volatile statements as having side-effects. [1]
> 
> C99 describes that accessing volatile objects are side-effects, and that
> "at certain specified points in the execution sequence called sequence
> points, all side effects of previous evaluations shall be complete
> and no side effects of subsequent evaluations shall have taken
> place". [2]
> 
> This ensures that the program order of READ_ONCE(), asm volatile in both
> legs of the branch, and following WRITE_ONCE() and after_ctrl_dep()
> barriers are preserved.
> 
> With this approach, the following code now keeps the control dependency:
> 
>         z = READ_ONCE(var1);
>         if (ctrl_dep(z))
>                 WRITE_ONCE(var2, 5);
>         else
>                 WRITE_ONCE(var2, 5);
> 
> And the ctrl_dep_eval() checking the constant triggers a build error
> for:
> 
>         y = READ_ONCE(var1);
>         if (ctrl_dep(y % 1))
>                 WRITE_ONCE(var2, 5);
>         else
>                 WRITE_ONCE(var2, 6);
> 
> Which is good to have to ensure the compiler don't end up removing the
> conditional branch because the it evaluates a constant.
> 
> Introduce the ctrl_dep macro in the generic headers, and use it
> everywhere it appears relevant.  The approach taken is simply to
> look for smp_acquire__after_ctrl_dep and "control dependency" across the
> kernel sources, so a few other uses may have been missed.

It would be nice to know where and on which arch things are currently
broken of course, which might then also help raise confidence that this
implementation of ctrl_dep() works.

Because it's still hard to prove that the compiler will always do the
right thing with that implementation. The only concrete option I see
here is creating tests with known or potential breakage.

In an ideal world we could add such tests to the compiler's test-suites
themselves, assuming the behaviour your ctrl_dep() implementation relies
on is supposed to be guaranteed (and the compiler folks agree..).

Beyond the above trivial test case with 2 identical branches, here's
another one that breaks on arm64 with clang 12 (taken from
https://reviews.llvm.org/D103958):

 | int x, y;
 | void noinline test_ctrl_dep_broken1(void)
 | {
 | 	/* ARM: do NOT expect: cinc | expect: cbz */
 | 	if (ctrl_dep(READ_ONCE(x))) {
 | 		y = 1;
 | 	} else {
 | 		y = 2;
 | 	}
 | }

Without ctrl_dep():

 | <test_ctrl_dep_broken1>:
 |        d00042a8        adrp    x8, ffffffc010868000 <initcall_debug>
 |        b9400508        ldr     w8, [x8, #4]
 |        52800029        mov     w9, #0x1                        // #1
 |        7100011f        cmp     w8, #0x0
 |        1a891528        cinc    w8, w9, eq  // eq = none
 |        d00042a9        adrp    x9, ffffffc010868000 <initcall_debug>
 |        b9000928        str     w8, [x9, #8]
 |        d65f03c0        ret

			^^ no branch, compiler replaced branch with cinc!

with ctrl_dep():

 | <test_ctrl_dep_broken1>:
 |        d00042a8        adrp    x8, ffffffc010868000 <initcall_debug>
 |        b9400508        ldr     w8, [x8, #4]
 |        34000068        cbz     w8, ffffffc0100124b4 <test_ctrl_dep_broken1+0x14>
 |        52800028        mov     w8, #0x1                        // #1
 |        14000002        b       ffffffc0100124b8 <test_ctrl_dep_broken1+0x18>
 |        52800048        mov     w8, #0x2                        // #2
 |        d00042a9        adrp    x9, ffffffc010868000 <initcall_debug>
 |        b9000928        str     w8, [x9, #8]
 |        d65f03c0        ret

			^^ has cbz (and no cinc)

Which is good -- empirically, this seems to work for this case at least.
