Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930983ADE27
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhFTLZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhFTLZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:25:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F5AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 04:23:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624188189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5bNhJoM3/FLw4Sw6281mYeD7esoBy928BpQg2VpBIY=;
        b=BU+N+QWnB/4dZ5yiG7ScsxJDGXXx+1aD3RaMxGM8cmmiVV4VMK4melGWva7N1V1UbjKhZP
        smkJG0RkRHYWg2iKWGjFCfF3nj/uqAxewGN4gWNo5z26ptzWrUmmyv27FChG0+UuIvizC4
        I+13/3sAiut01kwjIbod6XuxgbWh6o/5+05XJqmICNXwdfE8r1Tp05lqSNnUnyYegs/G1p
        iDdaCfpp2mqKNYnsqHm9YU6QEv8v+Q0++5qTjw8zSe+kdlqD039yc8pAcwBngzhhXH3fmk
        AcQJK7V6oYIoDgTU5XcrDGSDZdpsvJ6ONGCNFIxkCUn6C5V2sqB+6FmYefkCow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624188189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5bNhJoM3/FLw4Sw6281mYeD7esoBy928BpQg2VpBIY=;
        b=wtgM6bxF41VoEmg0ep1ScW4g4ce986W/us+H9vFBuMrHFC6Z4EwnhgY4XkMu5C0+Sb0lMN
        841kTnoDdQ5MHjAg==
To:     Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [RFC PATCH 1/4] x86/entry/nmi: Switch to the entry stack before switching to the thread stack
In-Reply-To: <444d7139-e47a-4831-93d0-8eb5b9680fdc@www.fastmail.com>
References: <20210601065217.23540-1-jiangshanlai@gmail.com> <20210601065217.23540-2-jiangshanlai@gmail.com> <87bl81h3ih.ffs@nanos.tec.linutronix.de> <444d7139-e47a-4831-93d0-8eb5b9680fdc@www.fastmail.com>
Date:   Sun, 20 Jun 2021 13:23:08 +0200
Message-ID: <87wnqog4pv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19 2021 at 20:13, Andy Lutomirski wrote:
> On Sat, Jun 19, 2021, at 3:51 PM, Thomas Gleixner wrote:
>> On Tue, Jun 01 2021 at 14:52, Lai Jiangshan wrote:
>> > From: Lai Jiangshan <laijs@linux.alibaba.com>
>> >
>> > Current kernel has no code to enforce data breakpoint not on the thread
>> > stack.  If there is any data breakpoint on the top area of the thread
>> > stack, there might be problem.
>>=20
>> And because the kernel does not prevent data breakpoints on the thread
>> stack we need to do more complicated things in the already horrible
>> entry code instead of just doing the obvious and preventing data
>> breakpoints on the thread stack?
>
> Preventing breakpoints on the thread stack is a bit messy: it=E2=80=99s
> possible for a breakpoint to be set before the address in question is
> allocated for the thread stack.

Bah.

> None of this is NMI-specific. #DB itself has the same problem.

Oh well.

> We could plausibly solve it differently by disarming breakpoints in
> the entry asm before switching stacks. I=E2=80=99m not sure how much I li=
ke
> that approach.

That's ugly and TBH in some sense is a breakpoint on the thread stack a
violation of noinstr. I rather see them prevented completely, but yes
that would have to be expanded to pretty much any variable which is
touched in noinstr sections. What a mess.

Thanks,

        tglx


