Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A836430EE12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhBDILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhBDILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:11:04 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BB6C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 00:10:24 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id n14so1326889qvg.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dMlwZbTRtvs33wBsCxd9atqEMDdw1B0hqvbpblPMA0=;
        b=Rho3iN2Lf5K6QM0EKVgayPCb+QWxlhDBcr9TbW2D8Cn+g8egpJcG7rVI8XB0lk9wZ3
         zhEqGFc1QJ5bU/G5xByE1+pzYfDylZpnYH69QW6hhnI06894rL+5lvM9soJ17C2SBihT
         K9OmlDhdfsQ/8uDqUtR+0ynamPF9VGDxjy+CmBra5i0sLVD6fhNYeD5DPKygSjuJj5lP
         jZ29Q4Rj84D5JKaObWNcC6DstX7VW2+w2OL3g+AqXGT+Za+lADJ7vYzeWUKSD6lMImtO
         ZzYypiTg5rP/BsbXVxk1+2+/d84mNpDr+cwQFgscaDWZU320tbob8F74qywwYdWaxjrC
         Iegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dMlwZbTRtvs33wBsCxd9atqEMDdw1B0hqvbpblPMA0=;
        b=BJKIyX2/DmxtnOHjTv6qgDnzRCCUZULcdU8x8Qo6nRI0Gzb3FlYqaFCva7ai7GxTuV
         /VVfdO8JIiB3bpA21StbQOme/+d82SJd5MtG54UNaABqY+Eqi6rEcD3S9cziOJLvADqN
         W51CX27FXcxXZXV/pvAJi5R8NtRwPCeIgRMdfUVhhHqPrvoHoX1awvPqe9lg8WCWJbxy
         ACIhvMWpicNPBCh58aYYjXKfAteAz9MQTyEUT/ARh22P2EBDzpmHlQlHoMVgRuCa6+MP
         dcskBU18paovDiCzGND0ly2GQ4HqTHznHU1dJ2dnKUKnpvVJOpyCMipBD1o2B8PkN7rb
         EL7w==
X-Gm-Message-State: AOAM532BUFZrurm7owNGCsBGhAPW8GtIB6w+IH8mxmmiDEp6VfTWGRSR
        jQQQ2pAO7vqJP7Xyvx3caL/AXs1Lif3QD9RlW8nKSw==
X-Google-Smtp-Source: ABdhPJxpjAoV3EN1RaCoDx+SNGiSORXQC+WU9AZ2gYM3rqOqBgpti8yW02cjA6xTZcXcPij4ZTi5Y0CaRXIbSf41fDI=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr6646419qva.18.1612426223627;
 Thu, 04 Feb 2021 00:10:23 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net> <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net> <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
In-Reply-To: <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Feb 2021 09:10:11 +0100
Message-ID: <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
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

On Wed, Feb 3, 2021 at 2:37 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 03, 2021 at 01:49:56PM +0100, Dmitry Vyukov wrote:
> > On Wed, Feb 3, 2021 at 1:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Feb 01, 2021 at 09:50:20AM +0100, Dmitry Vyukov wrote:
> > > > Or, alternatively would it be reasonable for perf to generate SIGTRAP
> > > > directly on watchpoint hit (like ptrace does)? That's what I am
> > > > ultimately trying to do by attaching a bpf program.
> > >
> > > Perf should be able to generate signals, The perf_event_open manpage
> > > lists two ways of trigering signals. The second way doesn't work for
> > > you, due to it not working on inherited counters, but would the first
> > > work?
> > >
> > > That is, set attr::wakeup_events and fcntl(F_SETSIG).
> >
> > The problem is that this sends a signal to the fd owner rather than
> > the thread that hit the breakpoint. At least that's what happened in
> > our tests. We would like to send a signal to the thread that hit the
> > breakpoint.
>
> Ah indeed.. all of this was aimed at self-monitoring.
>
> Letting perf send a signal to the monitored task is intrusive.. let me
> think on that.

I was thinking of something very similar to that bpf_send_signal that
delays sending to exit from irq:
https://elixir.bootlin.com/linux/latest/source/kernel/trace/bpf_trace.c#L1091
