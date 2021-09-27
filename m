Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6B41A003
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhI0UTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236897AbhI0UTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:19:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D72E61041
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632773886;
        bh=IHsvUyvzsKP7lWOY4wr3zpA6gSFdzHNOrAmHGV/uNv0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=biT1ueVmFhaYAmS6xk951LigOoHAZwceTHazGzH1RUDITt1Ofg8fYXAzXIvNA0HLx
         ESi/KT+3i/UCkN4j9O2uv+CVR87GGQtgeMI5JBR2rjkZV+GDnptNuhE+EKHzXM0ZEZ
         QrnVbY5R+esVTxIEzqrptGnVjzKGhPwAGVEWQ5kJ5ZKlRAqiuyexszSpw/2zOdM9Oy
         VQJHvZSpxIghowA0GQka343IuRS0GDu59rSlK3Elw/fmsKeVtuN7Ze7nBRH3O2qthU
         6eSep5oKojfAgw9jrDllV7wnTksrp+/1Mo7S5kbLTZJzwOX0Lj6i480iC7bUmaaOGf
         RPdanXpiw4lJA==
Received: by mail-lf1-f45.google.com with SMTP id t10so82531783lfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:18:05 -0700 (PDT)
X-Gm-Message-State: AOAM531elmX6l+ogcx/NjSStvG02Rx4j23s8sW9X+pyu3LZuBoT+vQdU
        oVbXgXJ20VzseKE2/GbTKn2E43Lwkz4dkw+mAF8=
X-Google-Smtp-Source: ABdhPJxVWT+r5zUMOL7sfAvIIewnSZ9Yfy72XldH6iZRlXsSzs31t2vw7rOv9KFwMaaclEv8II2vDy6exbnoMffLr/s=
X-Received: by 2002:a2e:5442:: with SMTP id y2mr1877130ljd.436.1632773884184;
 Mon, 27 Sep 2021 13:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com> <YTnL814pES+YWWnm@hirez.programming.kicks-ass.net>
 <CABPqkBROKmSLLCwFjiqObDpQz4iBUeO-0OaziNy05kxs3-4JHQ@mail.gmail.com>
In-Reply-To: <CABPqkBROKmSLLCwFjiqObDpQz4iBUeO-0OaziNy05kxs3-4JHQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Sep 2021 13:17:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7qnu4aaTNKigQdbfGO83Ku22DQm+_xzOXnMW=r6=oTww@mail.gmail.com>
Message-ID: <CAPhsuW7qnu4aaTNKigQdbfGO83Ku22DQm+_xzOXnMW=r6=oTww@mail.gmail.com>
Subject: Re: [PATCH v1 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, kim.phillips@amd.com,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

On Tue, Sep 14, 2021 at 10:57 PM Stephane Eranian <eranian@google.com> wrote:
>
> On Thu, Sep 9, 2021 at 1:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Sep 09, 2021 at 12:56:47AM -0700, Stephane Eranian wrote:
> > > This patch series adds support for the AMD Fam19h 16-deep branch sampling
> > > feature as described in the AMD PPR Fam19h Model 01h Revision B1 section 2.1.13.
> >
> > Yay..
> >
> > > BRS interacts with the NMI interrupt as well. Because enabling BRS is expensive,
> > > it is only activated after P event occurrences, where P is the desired sampling period.
> > > At P occurrences of the event, the counter overflows, the CPU catches the NMI interrupt,
> > > activates BRS for 16 branches until it saturates, and then delivers the NMI to the kernel.
> >
> > WTF... ?!? Srsly? You're joking right?
> >
>
> As I said, this is because of the cost of running BRS usually for
> millions of branches to keep only the last 16.
> Running branch sampling in general on any arch is  never totally free.

Could you please share some data on how expensive the BRS is? We are
hoping to use
BRS/LBR without PMI (bpf_get_branch_snapshot). If it is too expensive,
we may need
some heuristic to turn it on/off.

Thanks,
Song
