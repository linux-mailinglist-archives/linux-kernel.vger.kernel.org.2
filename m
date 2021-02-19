Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17C31F70F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhBSKHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:07:03 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:35187 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhBSKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:06:53 -0500
Received: by mail-lj1-f182.google.com with SMTP id a17so17211482ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyoGtdTBvH11avsFOatFOJh6Wg3bijN6V4/enGjdXko=;
        b=jRspiRyq3k+xi25rHrdsPhlQacsAWht6UKuXdT2N8Lc3QAWkXMvIRat7yWzKcnaLS9
         qvi6TM2jhUHXhg0hZITaU6A8DD2/ZgWcWpB6IyluNiyb8GHrPU5s7sQQkBz3D/ZnuwIT
         a+Ia7VyA42GV0urgsjxjhqNghplDaBgmhRLGJ1S3AbK+IwwRuZvBrxFyruXxFNCPVESy
         hj4Nxn6u8avWl07AAIDsLaOjycp6e1YbJC5oCfnyJHyoLuvBE2kb86Se5lLFL7lQZBki
         wDkcycmjEGoXGLTR7HJ7eCapPW2Dy6bl6YnoyIk2QVVY+LsrAbZ2VscfEWpP7LPXwkvm
         qEBA==
X-Gm-Message-State: AOAM5330p2P5RbCVzoo/kV/gBZDRU7dPYe5H2DlN7mZG2uuzoAMaCkjM
        1LlnGMVAZx/DyLwq+3KdIGTQbgpNloLLhovrMJP9ZObw
X-Google-Smtp-Source: ABdhPJwmX/GVwXkqZTsbr/9SfVjxW4LtmoV9EqYB4Jjz3ezSGr6OM+y+ZKwlL+DpO6b0gn8RXxpUAOnat3MwZ6M0AQI=
X-Received: by 2002:a2e:87c2:: with SMTP id v2mr5092155ljj.23.1613729170744;
 Fri, 19 Feb 2021 02:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20201216090556.813996-1-namhyung@kernel.org> <20201216090556.813996-3-namhyung@kernel.org>
 <20201229115158.GH521329@kernel.org> <CAM9d7cidFuM5gmjq8=uy+mJjHHEVE=q6qESkc_OeTeGEQkGbnA@mail.gmail.com>
 <CAM9d7chBmkG6S1QzF+gDU8=5ce8zQo2xM5Jr1t_iptsh_+t7NQ@mail.gmail.com> <YC0S858hMZG6o/tt@kernel.org>
In-Reply-To: <YC0S858hMZG6o/tt@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 19 Feb 2021 19:05:59 +0900
Message-ID: <CAM9d7cj=XrpTDQuJ1vhax0drpO8rcbjQgUi3Gj8Q2476U7SmgQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/lib/fs: Cache cgroupfs mount point
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Feb 17, 2021 at 9:58 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jan 08, 2021 at 02:51:44PM +0900, Namhyung Kim escreveu:
> > On Wed, Jan 6, 2021 at 10:33 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Arnaldo,
> > >
> > > On Tue, Dec 29, 2020 at 8:51 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Wed, Dec 16, 2020 at 06:05:56PM +0900, Namhyung Kim escreveu:
> > > > > Currently it parses the /proc file everytime it opens a file in the
> > > > > cgroupfs.  Save the last result to avoid it (assuming it won't be
> > > > > changed between the accesses).
> > > >
> > > > Which is the most likely case, but can't we use something like inotify
> > > > to detect that and bail out or warn the user?
> > >
> > > Hmm.. looks doable.  Will check.
> >
> > So I've played with inotify a little bit, and it seems it needs to monitor
> > changes on the file or the directory.  I didn't get any notification from
> > the /proc/mounts file even if I did some mount/umount.
> >
> > Instead, I could get IN_UNMOUNT when the cgroup filesystem was
> > unmounted.  But for the monitoring, we need to do one of a) select-like
> > syscall to wait for the events, b) signal-driven IO notification or c) read
> > the inotify file with non-block mode everytime.
> >
> > In a library code, I don't think we can do a) or b) since it can affect
> > user program behaviors.  Then we should go with c) but I think
> > it's opposite to the purpose of this patch. :)
> >
> > As you said, I think mostly we don't care as the accesses will happen
> > in a short period of time.  But if you really care, maybe for the upcoming
> > perf daemon changes, I think we can add an API to invalidate the cache
> > or internal time-based invalidation logic (like remove it after 10 sec.).
>
> Ok, we can have something in 'perf daemon' to periodically invalidate
> this, maybe do a poor man inotify and when asking for the cgroup
> mountpoint, check some characteristic of that file that changes when it
> is modified, or plain use a timestamp and have some threshold.

I thought about this again.

We don't directly access the cgroups in the perf daemon.
It just creates new record processes so they'll see a new
mountpoint whenever they started since this cache is
shared within the process only.

That means we don't need to care about the invalidate in the
daemon but each perf record and perf stat should do it when
they are required to do the work repeatedly.

But looking at the code, the cgroup is set during event parsing
(-G option) or early in the command (--for-each-cgroup option).
So cgroup info would not be changed even if the command
runs repeatedly.

So I think you can take the patch as is.

Thanks,
Namhyung
