Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715C530F3F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhBDNgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbhBDNga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:36:30 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A8EC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:35:48 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id e15so2307825qte.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKZ8jOVXaGHt37s8mgAlb0QZlKKHVkfqK1l6zjxD0zE=;
        b=Tp7+xVOkN7692sIbinqdK5pKIdTxjFRvN5TBKktfYa/OcV8vZXujRgWJpUprEotTvk
         Ywh0AWOTjD4pyPJ+9ioiH1ghUScrk9zY3P8/XLs0m3mxDcsm8ke9jnfR/4FBPGv55mB0
         lVnq5uOmwKA3KK0SHnu8sJ8Fgyda0ZF51Q24uo2sVgvVu85hjJUgTS2RzscFC9UPjFcU
         NlPq+b70HxshgqfyALReSbkIuf6mUSFjMjzrxDPnmNo6vhyoEUvOxTz71tfud4eKGHRz
         dPkA2tmAlG9geJOMKPMyoVO+2bXMfu9Vt+9zIQ+irREt+FOlcIwCAoInuO35O1NrKsrr
         B6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKZ8jOVXaGHt37s8mgAlb0QZlKKHVkfqK1l6zjxD0zE=;
        b=bnRwDN4Lggm+ru6M3VvWt9J0kjTIwfTCzmyUG/QZqLMY0XWmOjwcoVW2pWH4rzd+Ap
         Jl2MiTJo84raawRokgzA0y+DrvWiY9tBk8yDkZq/5CQL7Lzli71i1Hy/qT/LOMqWHpdN
         56Jvk4rJ4u4CC7aKRkF1TYJIUpDRb6u5XA8zjP1nni7M5D3r80ypF+oeT/5r46h9p+1I
         sHhoHqGyhYB6B7YvkyVwRyB2UWFQHsKBSUlwcU0XAFDa58fiXSDAP80x/16nRFQD3vMl
         xMzi0qb6G6PuXK0tIC/fM3IPnhEuJXTyueMgcSa6fTIWHqMf0Vj52gqOFj/WubIzyary
         pq0w==
X-Gm-Message-State: AOAM530QG/kg2zKno89HMT1XI11BjXeFtbjxnnn4dv3+fEudvhHcAerU
        GffcStE6xriOJL2NnPUpDwfX2JCqHjtupIeyDuy89Q==
X-Google-Smtp-Source: ABdhPJysl3WfoClrkXYBxHK86kJI0Gz9JlpcZhPPm94ZZQlyp5AYwslMA04261A+csN+WG70clZW6b5+0JY9DKlbhTg=
X-Received: by 2002:a05:622a:c9:: with SMTP id p9mr6885875qtw.337.1612445747619;
 Thu, 04 Feb 2021 05:35:47 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net> <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net> <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net> <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
 <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net> <CACT4Y+a17L2pUY1kkRB_v_y3P_sbMpSLb6rVfXmGM7LkbAvj5Q@mail.gmail.com>
 <YBvyTDR+q0M62vKR@hirez.programming.kicks-ass.net>
In-Reply-To: <YBvyTDR+q0M62vKR@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Feb 2021 14:35:36 +0100
Message-ID: <CACT4Y+ZbWMa7zsa84dOBZ0C0Qgik2uDST+bzX=TrSU6vFXkkCQ@mail.gmail.com>
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

On Thu, Feb 4, 2021 at 2:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 04, 2021 at 01:53:59PM +0100, Dmitry Vyukov wrote:
> > Humm... I was thinking of perf_event_open(pid == 0).
> > It does not make sense to send SIGTRAP in a remote process, because it
> > does not necessarily cooperate with us.
> >
> > But is there any problem with clone w/o CLONE_THREAD? Assuming the
> > current process has setup the signal handler, the child will have the
> > same handler and the same code/address space. So delivery of SIGTRAP
> > should work the same way in the child.
>
> Nothing should be doing CLONE_VM without CLONE_THREAD. Yes, it's
> possible, but if you do so, you get to keep the pieces IMO.
>
> Current libc either does a full clone (fork) or pthread_create,
> pthread_create does CLONE_THREAD.

I meant a different thing.
I meant that we could restrict synchronous SIGTRAP for (1)
perf_event_open(pid != 0) and (2) disable it after exec.
What is the issue here for clone without CLONE_THREAD?
