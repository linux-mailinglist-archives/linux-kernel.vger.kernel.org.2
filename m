Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9ED308D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhA2TLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:11:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbhA2TKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:10:34 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611947387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZhkU5olhXDMdsTExJoQWYa6ZP+3wv/B5D9kN/lZ4eU=;
        b=Y81MIc+Os0XeR08IrFkUgpOKs38SxEH4LBJhDWBZ/3IiiTbeI3kUXvX4W3uM2CYwtNKRqp
        mSB2h0t/N1xu6uZY4Zbat7NjU8WCWHA1i2TeL1xDBFWDUfWg5eMytMm9HAGurer2L+rw5s
        rD9F7Q+vuF2y6lk7SIFImvK4fN2Fycz1oBzy0PbmxcAzaFr9VEyFZBykRX3OGAp8pziFk8
        CuLVjuI1iayHMqwJr3YfTlvQyHft3Un57vstdy2NO1hEVzwpPPu2kdo4klNGLmf74A3C1v
        xrhKJgsoDFrRHTzpFAekAmFTxBXMKoWS5iK3EsK8QnlJHf/PeIAbbQ9YnjBEtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611947387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZhkU5olhXDMdsTExJoQWYa6ZP+3wv/B5D9kN/lZ4eU=;
        b=Pfj5FRQdoyUQW7MIzXdku+QUqeXqU7wBQNHm1fOUaZUcSvgUzYJQX2Ne8cKLbVWjuQodJc
        U9ftdXnk2VenVfBQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, tdevries@suse.de, linux-kernel@vger.kernel.org,
        andrew.cooper3@citrix.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] selftests: breakpoints: Add "WINE" test for x86
In-Reply-To: <YBPQq6ccKL68aIZg@hirez.programming.kicks-ass.net>
References: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net> <20210128211627.GB4348@worktop.programming.kicks-ass.net> <87eei4d4k6.fsf@nanos.tec.linutronix.de> <YBPQq6ccKL68aIZg@hirez.programming.kicks-ass.net>
Date:   Fri, 29 Jan 2021 20:09:47 +0100
Message-ID: <875z3fd0g4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29 2021 at 10:08, Peter Zijlstra wrote:
> On Fri, Jan 29, 2021 at 12:28:41AM +0100, Thomas Gleixner wrote:
>
>> Add a test case which covers this scenario. This is modeled after the
>> WINE testcase, but changes the expect in step #2 to:
>> 
>>    - Expect DR6::BS == 1 and DR6::BR0 == 1 and IP == second instruction
>> 
>> to ensure that the GDB expectations are met as well.
>
>> +	/*
>> +	 * Expect: DR6::BS == 1 DR6::BR0 == 1  IP == instr[1]
>> +	 * Wine does not care about BR0 here but GDB does ...
>> +	 */
>> +	wine_test_step(1, addr, 1, 1, buf);
>
>
> So my v2 patch will fail this, while it will pass the actual gdb
> testcase.
>
> The thing it does is process _data_ breakpoints along with TF, but it
> will exclude instruction breakpoints and TF.
>
> Since the above test is using instruction breakpoints, it will report
> 0x4000 and 0x0001 respectively for two consequtive exceptions.

Yes, I'm a moron....
