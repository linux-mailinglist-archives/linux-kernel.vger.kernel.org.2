Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519193722AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhECVyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:54:35 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:33622 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:54:33 -0400
Received: by mail-lj1-f181.google.com with SMTP id s25so8730593lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 14:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdtl/MAZu2OsCSIK0KpZJSUXJx1Iq+7Xqx4DLLui68o=;
        b=U2JjzFZ/MKITLTJF1gViXNG/rpIykk0irBgl6WMtwRXSJ3u0j1bJhvIdrU1kH/0mD2
         MWG/cM64XFQBaGrZJXJK1qbIy/Zx08erXbM9QQ8ADg6NCQNmfKqepYR3pIt9kXduvA0j
         Hdj4JMIMfj/4mKze5/dpqE3Z3KKq6Oh6tN0Hekbu4Di/9fKH9ljwyNVHWPJz196Xwt/z
         b2K/lIDSBA8/B3RcKs6wI6J/NC3FMBgh5w01hZqOFnoqVGAkYv82nI0xgfzRiMJ/wEXF
         ABIF1MaGX6FXu89rWLRB5SZ6KBaYqIH+km0ibgY0HNoXT/9DqK1QkORaaCPzlYk2zCx3
         MwNw==
X-Gm-Message-State: AOAM530DxS8g92bi5hd1gKHPbUpJ8ZnPOq5AgA5WK9akdgSiT27A29pM
        C8RPiv/nPj+MZiVU9k4quPb3r2RLbTfPtt0MdKU=
X-Google-Smtp-Source: ABdhPJy7EoLk5CbjrSzUwJlvgGJU378pPmW9vCXF5X32E9IRyL1ghC4gmwmYHlqMsnSF9Luzth2nF/OUCEklGtLsCYs=
X-Received: by 2002:a05:651c:307:: with SMTP id a7mr15103342ljp.166.1620078819231;
 Mon, 03 May 2021 14:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net> <CABPqkBTncWfeFWY=kYXTAr3gRjpyFVL-YJN4K1YOPpHO35PHBw@mail.gmail.com>
 <YH664QumxBAIyYpt@hirez.programming.kicks-ass.net> <CAM9d7cjXtGLuEkVaCOgJifwJUJmSABcZ5LRAdUsRM8TRYsVGsQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjXtGLuEkVaCOgJifwJUJmSABcZ5LRAdUsRM8TRYsVGsQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 3 May 2021 14:53:27 -0700
Message-ID: <CAM9d7cidMxn5UmR2sG+Tvapco8g4UbU1f5pxKt++Z+egpJVrAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Apr 21, 2021 at 12:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Apr 20, 2021 at 8:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Apr 20, 2021 at 01:34:40AM -0700, Stephane Eranian wrote:
> > > This does not scale for us:
> > >    - run against the fd limit, but also memory consumption in the
> > >    kernel per struct file, struct inode, struct perf_event ....
> > >    - number of events per-cpu is still also large
> > >    - require event scheduling on cgroup switches, even with RB-tree
> > >    improvements, still heavy
> > >    - require event scheduling even if measuring the same events across
> > >    all cgroups
> > >
> > > One factor in that equation above needs to disappear. The one counter
> > > per file descriptor is respected with Nahmyung's patch because he is
> > > operating a plain per-cpu mode. What changes is just how and where the
> > > count is accumulated in perf_events. The resulting programming on the
> > > hardware is the same as before.
> >
> > Yes, you're aggregating differently. And that's exactly the problem. The
> > aggregation is a variable one with fairly poor semantics. Suppose you
> > create a new cgroup, then you have to tear down and recreate the whole
> > thing, which is pretty crap.
>
> Yep, but I think cgroup aggregation is an important use case and
> we'd better support it efficiently.
>
> Tracking all cgroups (including new one) can be difficult, that's why
> I suggested passing a list of interested cgroups and counting them
> only.  I can change it to allow adding new cgroups without tearing
> down the existing list.  Is that ok to you?

Trying to move it forward..  I'll post v4 if you don't object to adding
new cgroup nodes while keeping the existing ones.

Thanks,
Namhyung


>
> >
> > Ftrace had a similar issue; where people wanted aggregation, and that
> > resulted in the event histogram, which, quite frankla,y is a scary
> > monster that I've no intention of duplicating. That's half a programming
> > language implemented.
>
> The ftrace event histogram supports generic aggregation.  IOW users
> can specify which key and data field to aggregate.  That surely would
> complicate the things.
>
> >
> > > As you point out, the difficulty is how to express the cgroups of
> > > interest and how to read the counts back.  I agree that the ioctl() is
> > > not ideal for the latter. For the former, if you do not want ioctl()
> > > then you would have to overload perf_event_open() with a vector of
> > > cgroup fd, for instance. As for the read, you could, as you suggest,
> > > use the read syscall if you want to read all the cgroups at once using
> > > a new read_format. I don't have a problem with that.  As for cgroup-id
> > > vs. cgroup-fd, I think you make a fair point about consistency with
> > > the existing approach. I don't have a problem with that either
> >
> > So that is a problem of aggregation; which is basically a
> > programmability problem. You're asking for a variadic-fixed-function
> > now, but tomorrow someone else will come and want another one.
>
> Well.. maybe we can add more stuff later if it's really needed.
> But BPF also can handle many aggregations these days. :)
>
> Thanks,
> Namhyung
