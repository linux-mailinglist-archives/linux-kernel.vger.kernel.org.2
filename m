Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4816D30D320
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhBCFjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:39:31 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:39602 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBCFj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:39:28 -0500
Received: by mail-lj1-f173.google.com with SMTP id u4so25383924ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 21:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gR6tvIdl2AVii1tWTxnGTmzq32La5odgjeYLRyiNXrE=;
        b=BPJo7eirZxTJVD6PcVcI7k/tllU85DIeu/A5x9NU4JNhtlnXCHQx17NEfVo2zZLzla
         FnfHuxSeL+ZJB8g5UsAK69+01TNRkQ1G0VmCVI3TXTsTNorJlEZ+93rSFkLgqoOkA/O3
         eWAGvfqv6VwUaLUaZJfX7UggoTlto5bqm5uFekH3WHI9ytElDMEwAUUpogihIbA3RsYx
         mD9jQv4osZxQvVFStDsNmI/g7e6a3qIQ2lyN1gAhAnO3SGJ9M9/AF9YoGmu0/HGEL9L2
         OhoHHKeyKSOoVdA+enyPgf3faBqD4/UyzKEiJO8EoDR/lQisYSxocsMgYHngTuZ9xqZy
         W90Q==
X-Gm-Message-State: AOAM533UKS5nMhZMWzTlEMvf0wSVx8GvvJ5ZoKPgx9ONr6ifNC2OyGMA
        aL4jUjmg0rdLq/3dxkPpkm1IMAvqpMR9/Y8y3UVM77Bj
X-Google-Smtp-Source: ABdhPJwBoRzkYxPwmTNokyvrnZeEey+kEbRvHZI0PdPDqJwRkOaqlr7ejDWb82TXmqWutC6pSD7LPu0ToW1QOzK18C4=
X-Received: by 2002:a2e:b0f3:: with SMTP id h19mr731227ljl.233.1612330726316;
 Tue, 02 Feb 2021 21:38:46 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net> <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com> <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
In-Reply-To: <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 3 Feb 2021 14:38:34 +0900
Message-ID: <CAM9d7ci4GqApJoG5B2ise2R20Eu7yz1zFxkA+wM-LoCDRCdnbw@mail.gmail.com>
Subject: Re: Process-wide watchpoints
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Jan 31, 2021 at 7:28 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> Not directly related to the above question, but related to my use case.
> Could we extend bpf_perf_event_data with some more data re breakpoint events?
>
> struct bpf_perf_event_data {
>     bpf_user_pt_regs_t regs;
>     __u64 sample_period;
>     __u64 addr;
> };
>
> Ideally, I would like to have an actual access address, size and
> read/write type (may not match bp addr/size). Is that info easily
> available at the point of bpf hook call?
> Or, if that's not available at least breakpoint bp_type/bp_size.
>
> Is it correct that we can materialize in bpf_perf_event_data anything
> that's available in bpf_perf_event_data_kern (if it makes sense in the
> public interface of course)?
>
> struct bpf_perf_event_data_kern {
>     bpf_user_pt_regs_t *regs;
>     struct perf_sample_data *data;
>     struct perf_event *event;
> };
>
> Unfortunately I don't see perf_event_attr.bp_type/bp_size
> stored/accessible anywhere in bpf_perf_event_data_kern. What would be
> the right way to expose them in bpf_perf_event_data?

I think you can access it via event->attr.bp_type/size in the struct
bpf_perf_event_data_kern.

Thanks,
Namhyung
