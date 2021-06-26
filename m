Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30423B4D4A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 09:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFZHFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 03:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZHFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 03:05:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A2BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 00:03:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624691004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rzu8FRL+CWUI4jBrCwo+n7segzdf3IKWI66QDPYtHEo=;
        b=qAjQW440QHEIYD95OkySuCRRWN+cKtd9NMVn51Jkq5Zujex4z+2PytQP5dd7WDWsA3chtY
        sllHEpZ5Tw1a6zcwZMY5nTzZBERi1XN+kMcqbuEuXs3UIuiFptDGUXxIUYt/NSIZWNPCbU
        9xYm4bn/5a3y0izyaKHTjUE97xIITm587qjEcpMPHTFdIcdPWhiGDQEgxb8MCDU1Jts7l6
        /kkffDxLZBD9c/ViNtBBsmq+G6h7tPEdoX0l/FO/Iss7vGKiCAMU0uARVTlmwhUDGj9UeF
        QzwewIkrtcnVLA+hCCJrpMXVtsUQBLlhQA9rFb9DTjGVXd/2lBH0w8PzZaH5YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624691004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rzu8FRL+CWUI4jBrCwo+n7segzdf3IKWI66QDPYtHEo=;
        b=uQjnC3n2sTGmCa8t4Uo81Kt3eiesXGrvAjgNOVtzg9IdGc+cJk1pqIEGiUVdaN5T8lXxcA
        /OiuPxvzg59/fYCA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [RFC PATCH 1/4] x86/entry/nmi: Switch to the entry stack before switching to the thread stack
In-Reply-To: <YNW3O1YxZx9XkZqU@hirez.programming.kicks-ass.net>
References: <20210601065217.23540-1-jiangshanlai@gmail.com> <20210601065217.23540-2-jiangshanlai@gmail.com> <87bl81h3ih.ffs@nanos.tec.linutronix.de> <444d7139-e47a-4831-93d0-8eb5b9680fdc@www.fastmail.com> <YNWytd64PzMwZKQX@hirez.programming.kicks-ass.net> <YNW3O1YxZx9XkZqU@hirez.programming.kicks-ass.net>
Date:   Sat, 26 Jun 2021 09:03:23 +0200
Message-ID: <87a6ndumys.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25 2021 at 13:00, Peter Zijlstra wrote:
> On Fri, Jun 25, 2021 at 12:40:53PM +0200, Peter Zijlstra wrote:
>> On Sat, Jun 19, 2021 at 08:13:15PM -0700, Andy Lutomirski wrote:
>> >=20
>> >=20
>> > On Sat, Jun 19, 2021, at 3:51 PM, Thomas Gleixner wrote:
>> > > On Tue, Jun 01 2021 at 14:52, Lai Jiangshan wrote:
>> > > > From: Lai Jiangshan <laijs@linux.alibaba.com>
>> > > >
>> > > > Current kernel has no code to enforce data breakpoint not on the t=
hread
>> > > > stack.  If there is any data breakpoint on the top area of the thr=
ead
>> > > > stack, there might be problem.
>> > >=20
>> > > And because the kernel does not prevent data breakpoints on the thre=
ad
>> > > stack we need to do more complicated things in the already horrible
>> > > entry code instead of just doing the obvious and preventing data
>> > > breakpoints on the thread stack?
>> >=20
>> > Preventing breakpoints on the thread stack is a bit messy: it=E2=80=99s
>> > possible for a breakpoint to be set before the address in question is
>> > allocated for the thread stack.
>>=20
>> How about we call into C from the entry stack and have the from-user
>> stack swizzle there. The from-kernel entries land on the ISTs and those
>> are already excluded.
>>=20
>> > None of this is NMI-specific. #DB itself has the same problem.  We
>> > could plausibly solve it differently by disarming breakpoints in the
>> > entry asm before switching stacks. I=E2=80=99m not sure how much I lik=
e that
>> > approach.
>>=20
>> I'm not sure I see how, from-user #DB already doesn't clear DR7, and if
>> we recurse, we'll get a from-kernel trap, which will land on the IST,
>> whcih is excluded, and then we clear DR7 there.
>>=20
>> IST and entry stack are excluded, the only problem we have is thread
>> stack, and that can be solved by calling into C from the entry stack.
>>=20
>> I should put teaching objtool about .data references from .noinstr.text
>> and .entry.text higher on the todo list I suppose ...
>
> Also, I think we can run the from-user exceptions on the entry stack,
> without ever switching to the kernel stack, except for #PF, which is
> magical and schedules.

No. Pretty much any exception coming from user space can schedule and
even if it does not voluntary it can be preempted.

Thanks,

        tglx

