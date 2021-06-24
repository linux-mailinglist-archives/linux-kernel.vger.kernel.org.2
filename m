Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92B53B33FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhFXQfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhFXQfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:35:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7BFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 09:33:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h15so11245102lfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 09:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+6AW48CYbAMx4zT8RExeRCMx/Kaeq/I74QmDikRucc=;
        b=im0cOOnq6LVaPRTNRxRDOz1ygnhIbbUlF9c6CS20ddaGvqg9ISHVWTIxkTD8uFm1Tv
         u3ZGXCe4umDiHot1yi+v8XBgPbyMjDEB3nlFhdzW8hV9C6xuX5aTEia4k9QR9Ntfkq23
         Cey67c4Ud3K0ry/gMPGLqUz6Dpa1Y5UevnKBtNNp4cprAeEALRGtI9v6CdDjBX12uvoF
         ukJeU+Ve594cwv6THXfMcCwGT6f4MgBD8zTM9iF6RZS3Yle9z6aiJtEfJ1qzXOipYmve
         Q+3f1F8HrcIzc4ZDU7rdAJVeH9eW0QJ8ZJGhB9xCjdGFTwNMQUFDfzfg5KbDooMbpxkY
         moQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+6AW48CYbAMx4zT8RExeRCMx/Kaeq/I74QmDikRucc=;
        b=tMX7e8G+fofH9HKDl+cOJIFZGWw8tyBOZjsPNvJGftaNMmM7dSaWcuPf4DnM0xNAP9
         ryAURGdHe5FmwnG2NaBI2tHJzgbdqJwv3t7+zm9/KSPfnDkpYSlbVves7PatBdQ/y/Lw
         ZzR+68efzOnpEsyAHUZZvvvVI+cN5ZOqBDEJaDN57QPWUjEF79ked4Dzw+BlXNfGTTgL
         YVb+dc4zpZ/GlTRG/ALIKOVzeSKJ1V+jbaTwdVWKqVv48B5OWbp3EBJIOlHYCbTLwE0m
         DIe+HX5LOSAGeST0wKPSsZDZ7GvsT89acKgax2UwtGsekEmYOFIU0PwL9a94n+MxMSbn
         eEMA==
X-Gm-Message-State: AOAM530Achj41Xb6qdk7M9OjEirHFRAZhKoR0p0E0Ms/J6hMpZodHrGc
        8DbpF63AakAXpyMnAnK1O6T79H047ALRxZVIrMboLw==
X-Google-Smtp-Source: ABdhPJxg2cOMazwQ5ow6tu7EIY18EF62S42Zhobl9KJz3KU0CvggjO2x/+0UHbS4cqwqWf67KQKpZPHiTiFIOWM++JA=
X-Received: by 2002:a05:6512:1191:: with SMTP id g17mr4488372lfr.347.1624552398592;
 Thu, 24 Jun 2021 09:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod5dFVxJVFUP4zBCC97C7rr5pGjRZQoixzs=GcNRAosKgw@mail.gmail.com>
 <20210624152130.877-1-sjpark@amazon.de>
In-Reply-To: <20210624152130.877-1-sjpark@amazon.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 24 Jun 2021 09:33:07 -0700
Message-ID: <CALvZod682cg_fTf+vQxN=q_5A+GanJ3m7kVn_0gFut21_Xmu0A@mail.gmail.com>
Subject: Re: [PATCH v31 05/13] mm/damon: Implement primitives for the virtual
 memory address spaces
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Jonathan.Cameron@huawei.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, greg@kroah.com,
        Greg Thelen <gthelen@google.com>, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, Mel Gorman <mgorman@suse.de>, mheyne@amazon.de,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        sieberf@amazon.com, snu@zelle79.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        zgf574564920@gmail.com, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 8:21 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> On Thu, 24 Jun 2021 07:42:44 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > On Thu, Jun 24, 2021 at 3:26 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > [...]
> > > > > +/*
> > > > > + * Get the three regions in the given target (task)
> > > > > + *
> > > > > + * Returns 0 on success, negative error code otherwise.
> > > > > + */
> > > > > +static int damon_va_three_regions(struct damon_target *t,
> > > > > +                               struct damon_addr_range regions[3])
> > > > > +{
> > > > > +       struct mm_struct *mm;
> > > > > +       int rc;
> > > > > +
> > > > > +       mm = damon_get_mm(t);
> > > > > +       if (!mm)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       mmap_read_lock(mm);
> > > > > +       rc = __damon_va_three_regions(mm->mmap, regions);
> > > > > +       mmap_read_unlock(mm);
> > > >
> > > > This is being called for each target every second by default. Seems
> > > > too aggressive. Applications don't change their address space every
> > > > second. I would recommend to default ctx->primitive_update_interval to
> > > > a higher default value.
> > >
> > > Good point.  If there are many targets and each target has a huge number of
> > > VMAs, the overhead could be high.  Nevertheless, I couldn't find the overhead
> > > in my test setup.  Also, it seems someone are already started exploring DAMON
> > > patchset with the default value. and usages from others.  Silently changing the
> > > default value could distract such people.  So, if you think it's ok, I'd like
> > > to change the default value only after someone finds the overhead from their
> > > usages and asks a change.
> > >
> > > If you disagree or you found the overhead from your usage, please feel free to
> > > let me know.
> > >
> >
> > mmap lock is a source contention in the real world workloads. We do
> > observe in our fleet and many others (like Facebook) do complain on
> > this issue. This is the whole motivation behind SFP, maple tree and
> > many other mmap lock scalability work. I would be really careful to
> > add another source of contention on mmap lock. Yes, the user can
> > change this interval themselves but we should not burden them with
> > this internal knowledge like "oh if you observe high mmap contention
> > you may want to increase this specific interval". We should set a good
> > default value to avoid such situations (most of the time).
>
> Thank you for this nice clarification.  I can understand your concern because I
> also worked for an HTM-based solution of the scalability issue before.
>
> However, I have neither strong preference nor confidence for the new default
> value at the moment.  Could you please recommend one if you have?
>

I would say go with a conservative value like 60 seconds. Though there
is no scientific reason behind this specific number, I think it would
be a good compromise. Applications usually don't change their address
space layout that often.
