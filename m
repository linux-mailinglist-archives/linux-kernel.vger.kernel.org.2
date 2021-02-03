Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949C30DA3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhBCMxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhBCMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:50:50 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED09C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:50:09 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w20so15181255qta.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFcUxsWT13RfOOl0Dl1xGflYYj3iUd31njtwj2FIiLU=;
        b=vzPuoTyM/I85E8YbIRlYLoFi5fGJXki/iFdZ+oEYLsFfwIb3N+prYTAZ5x5hS5PnPl
         Bz61vYPfdKfayJ7U2ICR+EVec2fOG7OW1Yzzy2N5aYJUrOp0fu37Q8d6IE7XwhfhQqZ4
         gXp4XTfAbEP1bkBEho4tsr6ywFIJ4XyOUFhqlhL5/KUM/6aIW/WVt5V1cZRIQ/mouxCR
         MVqgopw0qJwHbytAU1fLbqQOQLJYEk/+8oqnlbrnRxjkcvLEk666QRWYYK4EEvnPNDvo
         3zjBTrBHta3rtO7ndFSHoGOohX1vg3MKdr3YDpSlrMeNK/M3U4efi64d052EPSPp7HuR
         jpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFcUxsWT13RfOOl0Dl1xGflYYj3iUd31njtwj2FIiLU=;
        b=C5dV70AkpYzsLhwvbu5TX9CA4KRRqSTqWTP2e1O85WtyrwYHm2DC7DJ/dMn87XW8iE
         aPmW7wek3us3nudYzuPkqA1i7idOlLKk+bpVId3SAxt0WMdB7m6E5eNpScMQGRjuguW5
         gvIOhU/xWUq2NnWnbFx9sGNmx6ZQqTVAxEGbICGmh3WYIBeUuA9figvs1xi9ZHUgA+Kq
         B+PVmIwGSFa1FnfbisK/16dy3I0unebHn22VDKNe1uF+Pf+ZRIjZgTmwbIONZM/mG0BW
         VJL0RZaOE7PKVruau2sj7t3PEWZQvD2ZiJGqahO0kNv1YATlz19CoP46K6q4aWdNy9jL
         vyow==
X-Gm-Message-State: AOAM531bOKYIthdTQzlIQVFB/QvP/pstqc3mdyBbl/xrFpJtVJZtdClj
        HiSBI366UL1RijPu8c7RB4feeITS1NprWwQ7XoVQcw==
X-Google-Smtp-Source: ABdhPJy7Z5fMCPf4oYbV9Ib1BeKrf9W3XW/DL9H/lAjjO8vs7cBmPMQO8fC/QTia8cFZUnc67aF8U3vdwRqkstmzo48=
X-Received: by 2002:ac8:e0e:: with SMTP id a14mr2270669qti.66.1612356608469;
 Wed, 03 Feb 2021 04:50:08 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net> <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com> <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
In-Reply-To: <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 3 Feb 2021 13:49:56 +0100
Message-ID: <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
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

On Wed, Feb 3, 2021 at 1:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 01, 2021 at 09:50:20AM +0100, Dmitry Vyukov wrote:
> > Or, alternatively would it be reasonable for perf to generate SIGTRAP
> > directly on watchpoint hit (like ptrace does)? That's what I am
> > ultimately trying to do by attaching a bpf program.
>
> Perf should be able to generate signals, The perf_event_open manpage
> lists two ways of trigering signals. The second way doesn't work for
> you, due to it not working on inherited counters, but would the first
> work?
>
> That is, set attr::wakeup_events and fcntl(F_SETSIG).

The problem is that this sends a signal to the fd owner rather than
the thread that hit the breakpoint. At least that's what happened in
our tests. We would like to send a signal to the thread that hit the
breakpoint.
