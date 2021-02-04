Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31E30EFD8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhBDJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbhBDJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:39:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B9C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3o2saBcPyUQ6g/10+Rj6Ku6UfMXIXVT/67I546Blx18=; b=vIlYxDHoSkG7xyetvOcrUXHxn7
        vlruNrOw3mqhF7OHZ9PhbqZWv4Ov6FPJGGT3kXeWxnkJ2lzi6SM/2sQr3qFAEEjeJ43iJc6jNQrvL
        8sdRfvrgFXOVHJwBhI5vPjHWfrg9SMEfAzodtPEwIbPCLMV3JRwbTdNRu/2haO/n4uoW/PkixcQ8Y
        e1pCOgJ8n3i0uYz5W17A+HMqa5wpxUK5cEWu4Xb2cUzM69n7BdymyT+O/N3L3cIT4DBmvIyMvxoJX
        4Mi0Vut1Emfb+IpRMEhg8NsegIRXwBZ3OaUn7oqFjFIJzfn4vcdzZQJfc7Uk315Pk40QlMKglWbb7
        yfeerTLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7b6J-000feA-Ae; Thu, 04 Feb 2021 09:38:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC034301A32;
        Thu,  4 Feb 2021 10:38:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACC542138F7C5; Thu,  4 Feb 2021 10:38:58 +0100 (CET)
Date:   Thu, 4 Feb 2021 10:38:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Subject: Re: Process-wide watchpoints
Message-ID: <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net>
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net>
 <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
 <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
 <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:10:11AM +0100, Dmitry Vyukov wrote:
> On Wed, Feb 3, 2021 at 2:37 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Letting perf send a signal to the monitored task is intrusive.. let me
> > think on that.
> 
> I was thinking of something very similar to that bpf_send_signal that
> delays sending to exit from irq:
> https://elixir.bootlin.com/linux/latest/source/kernel/trace/bpf_trace.c#L1091

Oh, making code to do it isn't the problem. The problem stems from the
fact that perf is supposed to be observant only. The exception is when
you monitor yourself, in that case you can send signals to yourself,
because you know what you're doing (supposedly ;-).

But if you go send signals to the task you're monitoring, you're
actually changing their code-flow, you're an active participant instead
of an observer.

Also, they might not be able to handle the signal, in which case you're
not changing the program but terminating it entirely.

That's a big conceptual shift.

OTOH, we're using ptrace permission checks, and ptrace() can inject
signals just fine. But it's a fairly big departure from what perf set
out to be.
