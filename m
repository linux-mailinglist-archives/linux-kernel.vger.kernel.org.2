Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F323157B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 21:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhBIU32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 15:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhBIS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:27:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1407BC061223
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 10:15:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612894445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaU6hgPCKTfYtvujtzWo6YPy+BMiRpxfX8q5cY2xfZE=;
        b=FmSXK1w0nKRP/hdlx9uxHl6IjoEwME4nK41CcufJh1P+I34q8PgomZVyd8RMpDC19uCaZ7
        73jO6Mbj6yaTVdNkYbiSLGCvuRDbZ8OO8CsVPaW7ptsWnGgu/aJnyiaEWp2bAlp84TBF+N
        BDQHAvSLfVG3hap4wQp8ZSXk3oBN0kUJVaH9Sd03Wwq77Ps30vcCjUPsF3mlEnlaxj81Q6
        Pa2K5rg/r1S6F/teZ4RbnKnDgymd/u4Twb6bNGx+sPnAegQZsGWemWv4wmJzrovupHi3j7
        Iu3G6FuYt7q4r6+v1iH2ootuLjRRZ3ztjm7ondPcYHqRdmLBX6lyJ0f/TuQYnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612894445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaU6hgPCKTfYtvujtzWo6YPy+BMiRpxfX8q5cY2xfZE=;
        b=deMmx/JDGvM0wD/8NioXYymsnQsumTrJo1WEWvCSIU0IS2ol0c2xa1yOkR3V4k/5rhP17a
        U02KFRtneJtFOZAg==
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 05/12] x86/irq: Provide macro for inlining irq stack switching
In-Reply-To: <20210209162214.twr35rrb2qwvlx3f@treble>
References: <20210204204903.350275743@linutronix.de> <20210204211154.618389756@linutronix.de> <20210208204209.yccd76j7sp2zbv37@treble> <87zh0db7ha.fsf@nanos.tec.linutronix.de> <20210209162214.twr35rrb2qwvlx3f@treble>
Date:   Tue, 09 Feb 2021 19:14:05 +0100
Message-ID: <87wnvhaz2q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09 2021 at 10:22, Josh Poimboeuf wrote:
> On Tue, Feb 09, 2021 at 04:12:33PM +0100, Thomas Gleixner wrote:
>> On Mon, Feb 08 2021 at 14:42, Josh Poimboeuf wrote:
>> > On Thu, Feb 04, 2021 at 09:49:08PM +0100, Thomas Gleixner wrote:
>> >>  #ifdef CONFIG_X86_64
>> >> +
>> >> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
>> >> +# define IRQSTACK_CALL_CONSTRAINT	, ASM_CALL_CONSTRAINT
>> >> +#else
>> >> +# define IRQSTACK_CALL_CONSTRAINT
>> >> +#endif
>> >
>> > Is this really needed?  i.e. does ASM_CALL_CONSTRAINT actually affect
>> > code generation with !FRAME_POINTER?
>> 
>> The problem is that if the asm inline is the first operation in a
>> function some compilers insert the asm inline before setting up the
>> frame pointer.
>> 
>> That's actualy irrelevant here as the compiler cannot reorder against
>> the C code leading to the asm inline. So we can probably replace it with
>> a big fat comment.
>
> Actually, I think keeping ASM_CALL_CONSTRAINT is a good idea.
>
> What I meant was, is the #ifdef needed?  My previous understanding was
> that ASM_CALL_CONSTRAINT has no effect for !FRAME_POINTER (i.e., ORC).
>
> So is there any reason to *not* have ASM_CALL_CONSTRAINT with ORC?

You're right. No idea how I ended up with that ifdef.

Thanks,

        tglx
