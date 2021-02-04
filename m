Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE530F004
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhBDJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhBDJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:55:35 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A703C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 01:54:55 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l23so1880491qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 01:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwoKI5+cSpuGhL3r0lZuUOMuyL0kTKIQYXZfMVQnS+M=;
        b=P0o3DTNR5MxLgcX+yBoJeXbi7TkHK1HSACE3WhFC9oWxj5vxPztE3eaIA9gzEg7rYl
         uYzty3SIlYh7iLcfRlmyMHYHkc/b/vy9S6tlrBPkSECcbjOWD23RSSAVRzd2R2q9nKwf
         rmENZ9WqrF//kh59VmuJNIVDPZLdhkBdnWsH1qnDu+sI2Xd8cGGjh6/kfvDYIi+fG90t
         ME06HIR1p2mMUEmEuJJrg9E2dyywL9OyyBVRu+4GDItZ3cC/Gyx0ovtKinwh3jsOiqwQ
         TOaN5ITLveAVCF2JDjxvpvt21DUKDHy00a0huJvX23SW7NkRE1Jzc7/WnDxtlvgv+KkK
         OZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwoKI5+cSpuGhL3r0lZuUOMuyL0kTKIQYXZfMVQnS+M=;
        b=rdXhJzO88wK8lE11+pIWkexbeGK0/QOWSl162N4lJEMjwlDbuCsnGEPGQIoql/2jeO
         tDpWYuqSPn/DPhQZqzMyeUw6U7yuD2/biJzGNfHjysK8Ummto90j/0GWYrBm9SYRtOGe
         2wMxYqdxWGi9B7FGB4VxtxJM+4CVQ0zjCjLP8g2e6CpGeg0XrnXGkBlRgZF+UqOBzk4f
         aMiOXOE+R4qGiDskHvhdRxQSXSnkmWOxcGOkI9sT1wjUeJ39kODNb7P1nzD4M8q67Oho
         Ve6lT29HW8AZSvTrU8sEp5xEoXSAgXXAZbfJhmUEkn7EMMbi54xGjl0+fV9tGUrL3Mxx
         jT9g==
X-Gm-Message-State: AOAM5333uxFKdNhzjxWlhMO8qaS1I62jDIcDyFlCT8Gv8KsGlzaMP0ym
        OVcR5zTLRtfipLOrPs9vGhKKO6ZkOxp7HGlBnx59Yg==
X-Google-Smtp-Source: ABdhPJw7PWEQC+qR5wMdiG9WcptTFMJ1qqKqaxz0nQRjO1k6gcgozg+LmjXlH/dOOPDTWryvsuhvwXYPJPz8xRb/53E=
X-Received: by 2002:ac8:e0e:: with SMTP id a14mr6304181qti.66.1612432494120;
 Thu, 04 Feb 2021 01:54:54 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net> <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net> <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net> <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net>
In-Reply-To: <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Feb 2021 10:54:42 +0100
Message-ID: <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
Subject: Re: Process-wide watchpoints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 10:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 04, 2021 at 09:10:11AM +0100, Dmitry Vyukov wrote:
> > On Wed, Feb 3, 2021 at 2:37 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Letting perf send a signal to the monitored task is intrusive.. let me
> > > think on that.
> >
> > I was thinking of something very similar to that bpf_send_signal that
> > delays sending to exit from irq:
> > https://elixir.bootlin.com/linux/latest/source/kernel/trace/bpf_trace.c#L1091
>
> Oh, making code to do it isn't the problem. The problem stems from the
> fact that perf is supposed to be observant only. The exception is when
> you monitor yourself, in that case you can send signals to yourself,
> because you know what you're doing (supposedly ;-).
>
> But if you go send signals to the task you're monitoring, you're
> actually changing their code-flow, you're an active participant instead
> of an observer.
>
> Also, they might not be able to handle the signal, in which case you're
> not changing the program but terminating it entirely.
>
> That's a big conceptual shift.
>
> OTOH, we're using ptrace permission checks, and ptrace() can inject
> signals just fine. But it's a fairly big departure from what perf set
> out to be.

Oh, I see, I did not think about this.

FWIW it's doable today by attaching a BPF program.

Will it help if this mode is restricted to monitoring the current
process? Sending signals indeed usually requires cooperation, so doing
it for the current process looks like a reasonable restriction.
This may be not a fundamental restriction, but rather "we don't have
any use cases and are not sure about implications, so this is a
precaution measure, may be relaxed in future".
