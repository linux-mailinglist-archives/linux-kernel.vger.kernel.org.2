Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D2E35D21D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 22:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhDLUhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 16:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbhDLUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 16:37:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD508C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 13:37:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618259830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oh48Rss2+itxZmRETAokmr334utlKN/vxMR52g/3xqU=;
        b=FOok4NcdvWPuwMkC7QNjW7gCkdGJrxH/eERSy3WMlxPl2RVfATdXpivveJ2nD4jbVQ/0+W
        XlcbspjB4iZhYHCQ5IKqxYySqWYsiMcEWJcIBq8WrL/NMCraJdy6sjQasjUNOI8RIr/zHj
        qRJFEfQcNYkNFlztoGJLnHqbkzOQ5NuExNTNaEKVM5TetVfjzPLVsi7pSNrjAwKcf4mQzP
        UcizBF+nd9f2AOzaeK0v8jLIlKlyd/LABLjN4RDWzxYdR/qxhG8z5Q8iq6ImUZrxkfsFCV
        zOkMGI3/aEL+ILd2FnUd2i5/XNWjss9gHVRzcZTWBLRltGVqI48gnkS8o7X0OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618259830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oh48Rss2+itxZmRETAokmr334utlKN/vxMR52g/3xqU=;
        b=PJBnop+Js3BbdyHLqTiQXr7bP0c4LuYRQGYE6Y+FNZeWS422FxpVkwHcK75iexI0PGJiW3
        6t1Ygezpp2FxVOCg==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock synchronization when marked unstable
In-Reply-To: <20210412195722.GG4510@paulmck-ThinkPad-P17-Gen-1>
References: <20210402224828.GA3683@paulmck-ThinkPad-P72> <20210402224906.3912-3-paulmck@kernel.org> <87blam4iqe.ffs@nanos.tec.linutronix.de> <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1> <878s5p2jqv.ffs@nanos.tec.linutronix.de> <20210411164612.GZ4510@paulmck-ThinkPad-P17-Gen-1> <20210412042157.GA1889369@paulmck-ThinkPad-P17-Gen-1> <87k0p71whr.ffs@nanos.tec.linutronix.de> <20210412182049.GE4510@paulmck-ThinkPad-P17-Gen-1> <87y2dnz644.ffs@nanos.tec.linutronix.de> <20210412195722.GG4510@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 12 Apr 2021 22:37:10 +0200
Message-ID: <87o8ejz1c9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12 2021 at 12:57, Paul E. McKenney wrote:
> On Mon, Apr 12, 2021 at 08:54:03PM +0200, Thomas Gleixner wrote:
>> > I will send a new series out later today, Pacific Time.
>> 
>> Can you do me a favour and send it standalone and not as yet another
>> reply to this existing thread maze. A trivial lore link to the previous
>> version gives enough context.
>
> Will do!
>
> Of course, it turns out that lockdep also doesn't like waited-on
> smp_call_function_single() invocations from timer handlers,
> so I am currently looking at other options for dealing with that
> potential use-after-free.  I am starting to like the looks of "only set
> CLOCK_SOURCE_VERIFY_PERCPU on statically allocated clocksource structures
> and let KASAN enforce this restriction", but I have not quite given up
> on making it more general.

The simplest point is in the thread under the clocksource_mutex which
prevents anything from vanishing under your feet.

Thanks,

        tglx
