Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37703810DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhENTat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhENTao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:30:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71BFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:29:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621020567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BUCRh6+JO6hwPoznRg0DikeObEjzSgPqiFp6VBNC0BA=;
        b=upcs4dh8Cfn0LxB0CTZjFaafR09fumaQIKcDs80pPzNcvy9sRYs+QeqSJjYbaIP1VclrR5
        ao17N6mth3Saiua0gww57C/243IWyhYoH4/NYRI5vWIc86WFwSemNuQjSbZmuRWI47g5a2
        DSLyAWHQwdl7C+vNAVRGABr4Nuf/W82ZqlxroJqxI/afArziPy++nUtR+8sulJRrkjEHUp
        0vI8xGBE0RmLGDxjx0f3xd4xinATbA2ktpweKOSqrjsDi5hO4XEiMOumk8OxGnZqsJ8JI9
        piDaNku04g7njiGaDAkjX0H8sI5Zh5Rit/nem/UXW1MPeiq7X/QJQnSRKIsZxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621020567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BUCRh6+JO6hwPoznRg0DikeObEjzSgPqiFp6VBNC0BA=;
        b=hrOKMEb1Sx2wT7jVWxmi4G8D8GWa3B/SNyLUYI++NCjn36kmbiAwWI2E1jYa3B0646MvkE
        KtgYa6Iv/F/itEDQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Avoid double reprogramming in __hrtimer_start_range_ns()
In-Reply-To: <YIaxL5zcpjbfR1gp@hirez.programming.kicks-ass.net>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com> <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com> <87r1jbv6jc.ffs@nanos.tec.linutronix.de> <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com> <87eef5qbrx.ffs@nanos.tec.linutronix.de> <87v989topu.ffs@nanos.tec.linutronix.de> <YIaKnuZDfffmmAdM@hirez.programming.kicks-ass.net> <YIaxL5zcpjbfR1gp@hirez.programming.kicks-ass.net>
Date:   Fri, 14 May 2021 21:29:27 +0200
Message-ID: <875yzl3yi0.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26 2021 at 14:25, Peter Zijlstra wrote:
> On Mon, Apr 26, 2021 at 11:40:46AM +0200, Peter Zijlstra wrote:
>> There is an unfortunate amount of duplication between
>> hrtimer_force_reprogram() and hrtimer_reprogram(). The obvious cleanups
>> don't work however :/ Still, does that in_hrtirq optimization make sense
>> to have in force_reprogram ?

No. It need's to be in hrtimer_programm().

