Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFECE3812B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhENVQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhENVQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:16:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21877613DE
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 21:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621026924;
        bh=6NUH5BPgrJlnf2o44v4VmSKl7CL9Z5+001eR+AxepkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=exTX+yplfNo3jtt109pCTfgvfT/Vk6257m7XoLq8LgIQcizSbn7ZUUeoA+F3JnxRz
         e9GjxkyRIHToOOL/pTAQwBjkzmH/NCgbph0d+X8Z0MHpKPnDUfn6XxHTlEr+zDtNGQ
         DN9j28pCa3LqxGIs3d/cyXcOIKu/TysCYyRRpqOxdQhALqMmrNAihClbJnTHVhpz/B
         62hsHvIsZxhhABu7RmgWZwYydOOYOgt+f/F5VWMxjAzNGB21Xbl7Tt1emF3PHOddoT
         V3Dj4xLSY0uTEz9tjYxkSoys0zfP5qUYk4WhLu7TtozKzT5tz7LGD1ZCkaboa+SXPE
         Jt/aYqje+9uUw==
Received: by mail-wr1-f47.google.com with SMTP id z17so492509wrq.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 14:15:24 -0700 (PDT)
X-Gm-Message-State: AOAM530gErTV8lKOY7ujqGmW2Ub6aZefDJ0CPt8LBOnwbO8uGgUmLEP/
        iW1qZ9+evaO5ij03/XqFVqP468PE9M1H4hrBABQ=
X-Google-Smtp-Source: ABdhPJyMmsUWv7wugOdVS7iE7e99XXMJsDTEzihineKEAR1zkiEnYA288KSuAxVA7VtzVoHdGeZh+8lmpzwxsKuCHrM=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr62499904wrz.105.1621026922815;
 Fri, 14 May 2021 14:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210514140429.3334181-1-arnd@kernel.org> <20210514101610.4392adbc@gandalf.local.home>
 <CAKwvOdmJfm+PKxjR-N=YfFcjrXi4N4xUiRCLbSNMNJ+5g_wX+g@mail.gmail.com>
In-Reply-To: <CAKwvOdmJfm+PKxjR-N=YfFcjrXi4N4xUiRCLbSNMNJ+5g_wX+g@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 14 May 2021 23:14:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1KkFb-pk5XkEa+MnFBPfzMTdUCKMWH+ANQLdfHbp2FWg@mail.gmail.com>
Message-ID: <CAK8P3a1KkFb-pk5XkEa+MnFBPfzMTdUCKMWH+ANQLdfHbp2FWg@mail.gmail.com>
Subject: Re: [PATCH] tracing: events_hist: avoid using excessive stack space
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@godmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>, Tom Rix <trix@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:19 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Fri, May 14, 2021 at 7:16 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 14 May 2021 16:04:25 +0200
> > Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > In some configurations, clang produces a warning about an overly large
> > > amount of stack space used in hist_trigger_print_key():
> > >
> > > kernel/trace/trace_events_hist.c:4594:13: error: stack frame size of 1248 bytes in function 'hist_trigger_print_key' [-Werror,-Wframe-larger-than=]
> > > static void hist_trigger_print_key(struct seq_file *m,
> > >
> > > Moving the 'str' variable into a more local scope in the two places
> > > where it gets used actually reduces the the used stack space here
> > > and gets it below the warning limit, because the compiler can now
> > > assume that it is safe to use the same stack slot that it has for
> > > the stack of any inline function.
> >
> > Thanks Arnd for the nice explanation of the rationale for this change.
> >
> > But I still find it too subtle to my liking that we need to move the
> > declaration like this (and duplicate it twice) for internal behavior of the
> > compiler (where it can't figure out itself by the use cases if it can
> > optimize the stack).
>
> Under which configurations this warning was observed wasn't specified,
> but I'd bet it's one of the sanitizers splitting this in two in order
> to tell which branch may have overflowed the buffer.

Right, I did not manage to find the exact conditions that trigger it.
I did *not* see it with KASAN enabled and I saw it with UBSAN both
on or off.

       Arnd
