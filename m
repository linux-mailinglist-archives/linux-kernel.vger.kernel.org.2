Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A9A3100ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhBDXo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhBDXoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:44:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D9C06178B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 15:43:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j11so4562979wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 15:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdxivZtYPm/w27qYlDAWfOEEAK/f2pjTA4/stH/yMGY=;
        b=JVcDR5FaBcM/8aHWqzBqRX9vTW+ZRxzi1CD3sesrMKWoJInMMvK5ATZXuu1H1O7jgi
         Xt4HFN4ew7WWWGgd85IxBQCSgFeXmetfJiiWWsyxlHFxINjmmw8elzZu54u//MEjcH/z
         QMSlcsi1GfzSjKTOOOifAtWzF2MAeYxxjGMZVAvVV3TPPumO9/YXl8F3//UbVp6dmvoz
         XMfsGfvmTgUOTzn0DLa5BCjWdHpG76fQmQRoUZIavXMuwC+UnKl96rgRcVbpSieaFobz
         W7HzqeBjEDInkEaC//hRLUH2jOgubIV9oetGMZM0Va29gTt9QdQQjVPUJ9QwWr1XtesS
         KHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdxivZtYPm/w27qYlDAWfOEEAK/f2pjTA4/stH/yMGY=;
        b=TYo6d805Gz4nmx78cSGYtpCNN2nRoSjILLQ0xihvcoe+JqX4vnfkNwcwzVIukXMlx7
         ze+96Dci9W2XvKwtiKUzFAmjCNw7jEWSwPFbj/KvqzgoLNOf7QRwjMMV5LTaEFfIidcT
         GuhDkaMbhFNhOVOxcuYX0n8Va2pM0rHgFz4D/HabqeMz6oEU1NLXpn7gLEyiSNLxdg7+
         HTsV6xsyhPwYLF3yMLemusLaDIoMqtWgHWVuXmIuNKPZkJed0LKnAK81gKTJKpboDOtq
         lOeLkltC8sQL2wh8k0zfN2hpOt0+T5U8W39sDtNaudz6cCC/RA5Icrj2SInmier+7nlb
         8AMg==
X-Gm-Message-State: AOAM532MyKBGGWx6KGGLzA+OTX8EbRtONF1ydMIPBjqRN4wVNR66w4eW
        PwRK/sJ/s6X20a3wI+wds/KbxxrGMHnk+5t4xQqMvg==
X-Google-Smtp-Source: ABdhPJz77YxEMYKHKw2Qi9IrrX7lozG/fKhB+ku/8XHvs/GGECMC+fn8lsyvVgFVpog/PuxO22WGLJQoJ3kPG7FL8p0=
X-Received: by 2002:a05:600c:4f93:: with SMTP id n19mr1169835wmq.163.1612482201973;
 Thu, 04 Feb 2021 15:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20210203155001.4121868-1-minchan@kernel.org> <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com> <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
In-Reply-To: <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 4 Feb 2021 15:43:10 -0800
Message-ID: <CAJuCfpG_J_XkaK=1z2oHkTpq7Pw1qvZLKuYrs7aG5b9yVwvEag@mail.gmail.com>
Subject: Re: [PATCH] mm: cma: support sysfs
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 3:14 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/4/21 12:07 PM, Minchan Kim wrote:
> > On Thu, Feb 04, 2021 at 12:50:58AM -0800, John Hubbard wrote:
> >> On 2/3/21 7:50 AM, Minchan Kim wrote:
> >>> Since CMA is getting used more widely, it's more important to
> >>> keep monitoring CMA statistics for system health since it's
> >>> directly related to user experience.
> >>>
> >>> This patch introduces sysfs for the CMA and exposes stats below
> >>> to keep monitor for telemetric in the system.
> >>>
> >>>    * the number of CMA allocation attempts
> >>>    * the number of CMA allocation failures
> >>>    * the number of CMA page allocation attempts
> >>>    * the number of CMA page allocation failures
> >>
> >> The desire to report CMA data is understandable, but there are a few
> >> odd things here:
> >>
> >> 1) First of all, this has significant overlap with /sys/kernel/debug/cma
> >> items. I suspect that all of these items could instead go into
> >
> > At this moment, I don't see any overlap with item from cma_debugfs.
> > Could you specify what item you are mentioning?
>
> Just the fact that there would be two systems under /sys, both of which are
> doing very very similar things: providing information that is intended to
> help diagnose CMA.
>
> >
> >> /sys/kernel/debug/cma, right?
> >
> > Anyway, thing is I need an stable interface for that and need to use
> > it in Android production build, too(Unfortunately, Android deprecated
> > the debugfs
> > https://source.android.com/setup/start/android-11-release#debugfs
> > )
>
> That's the closest hint to a "why this is needed" that we've seen yet.
> But it's only a hint.
>
> >
> > What should be in debugfs and in sysfs? What's the criteria?
>
> Well, it's a gray area. "Debugging support" goes into debugfs, and
> "production-level monitoring and control" goes into sysfs, roughly
> speaking. And here you have items that could be classified as either.
>
> >
> > Some statistic could be considered about debugging aid or telemetric
> > depening on view point and usecase. And here, I want to use it for
> > telemetric, get an stable interface and use it in production build
> > of Android. In this chance, I'd like to get concrete guideline
> > what should be in sysfs and debugfs so that pointing out this thread
> > whenever folks dump their stat into sysfs to avoid waste of time
> > for others in future. :)
> >
> >>
> >> 2) The overall CMA allocation attempts/failures (first two items above) seem
> >> an odd pair of things to track. Maybe that is what was easy to track, but I'd
> >> vote for just omitting them.
> >
> > Then, how to know how often CMA API failed?
>
> Why would you even need to know that, *in addition* to knowing specific
> page allocation numbers that failed? Again, there is no real-world motivation
> cited yet, just "this is good data". Need more stories and support here.

IMHO it would be very useful to see whether there are multiple
small-order allocation failures or a few large-order ones, especially
for CMA where large allocations are not unusual. For that I believe
both alloc_pages_attempt and alloc_pages_fail would be required.

>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> > There are various size allocation request for a CMA so only page
> > allocation stat are not enough to know it.
> >
> >>>
> >>> Signed-off-by: Minchan Kim <minchan@kernel.org>
> >>> ---
> >>>    Documentation/ABI/testing/sysfs-kernel-mm-cma |  39 +++++
> >>>    include/linux/cma.h                           |   1 +
> >>>    mm/Makefile                                   |   1 +
> >>>    mm/cma.c                                      |   6 +-
> >>>    mm/cma.h                                      |  20 +++
> >>>    mm/cma_sysfs.c                                | 143 ++++++++++++++++++
> >>>    6 files changed, 209 insertions(+), 1 deletion(-)
> >>>    create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-cma
> >>>    create mode 100644 mm/cma_sysfs.c
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> >>> new file mode 100644
> >>> index 000000000000..2a43c0aacc39
> >>> --- /dev/null
> >>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> >>> @@ -0,0 +1,39 @@
> >>> +What:              /sys/kernel/mm/cma/
> >>> +Date:              Feb 2021
> >>> +Contact:   Minchan Kim <minchan@kernel.org>
> >>> +Description:
> >>> +           /sys/kernel/mm/cma/ contains a number of subdirectories by
> >>> +           cma-heap name. The subdirectory contains a number of files
> >>> +           to represent cma allocation statistics.
> >>
> >> Somewhere, maybe here, there should be a mention of the closely related
> >> /sys/kernel/debug/cma files.
> >>
> >>> +
> >>> +           There are number of files under
> >>> +                           /sys/kernel/mm/cma/<cma-heap-name> directory
> >>> +
> >>> +                   - cma_alloc_attempt
> >>> +                   - cma_alloc_fail
> >>
> >> Are these really useful? They a summary of the alloc_pages items, really.
> >>
> >>> +                   - alloc_pages_attempt
> >>> +                   - alloc_pages_fail
> >>
> >> This should also have "cma" in the name, really: cma_alloc_pages_*.
> >
> > No problem.
> >
> >>
> >>> +
> >>> +What:              /sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_attempt
> >>> +Date:              Feb 2021
> >>> +Contact:   Minchan Kim <minchan@kernel.org>
> >>> +Description:
> >>> +           the number of cma_alloc API attempted
> >>> +
> >>> +What:              /sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_fail
> >>> +Date:              Feb 2021
> >>> +Contact:   Minchan Kim <minchan@kernel.org>
> >>> +Description:
> >>> +           the number of CMA_alloc API failed
> >>> +
> >>> +What:              /sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_attempt
> >>> +Date:              Feb 2021
> >>> +Contact:   Minchan Kim <minchan@kernel.org>
> >>> +Description:
> >>> +           the number of pages CMA API tried to allocate
> >>> +
> >>> +What:              /sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_fail
> >>> +Date:              Feb 2021
> >>> +Contact:   Minchan Kim <minchan@kernel.org>
> >>> +Description:
> >>> +           the number of pages CMA API failed to allocate
> >>> diff --git a/include/linux/cma.h b/include/linux/cma.h
> >>> index 217999c8a762..71a28a5bb54e 100644
> >>> --- a/include/linux/cma.h
> >>> +++ b/include/linux/cma.h
> >>> @@ -49,4 +49,5 @@ extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> >>>    extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
> >>>    extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
> >>> +
> >>
> >> A single additional blank line seems to be the only change to this file. :)
> >
> > Oops.
> >
>
