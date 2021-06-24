Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495953B3270
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhFXPX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:23:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05C2C061574;
        Thu, 24 Jun 2021 08:21:36 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g3so769956qth.11;
        Thu, 24 Jun 2021 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=XTZcBFmJD64rk0L0Ti7cLCSZOK6HZ1i75AWgRbmnkT0=;
        b=DTWibfbFd03qYiZGv8C80cChp1eOSQiI21lvhjpC4tj8lC6nSetbmAiFCyXo/JicEh
         4ObQ/MekbB9/HJ7I02SIaLcRG4zjb8XHfRZrGU9yglcYCZqR7aLVGINU3CAJR+QIcBRo
         1+P8j5KD/T7x37XHZBfSlFJnn7fj19cACdYFSRfeYdWX9PfVXaZ7iJ4o8hnKUUQoBVFS
         whvHg8Pnq+tjsTgU4wi+QTL8yHMvRugPSrEw3oIMlwRNrKGByzIgxOjkGKTQwIJpKbu7
         /HCWvj92kEF3aHp0D6gzJi5ACJRbGVajYxGvEEE/haNiMe7urLOSNTyH0B9FUZUXTC68
         LRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=XTZcBFmJD64rk0L0Ti7cLCSZOK6HZ1i75AWgRbmnkT0=;
        b=WN/nMbHgy0iLZOf5MkWcVaMFId3XDy6jSS5iNDPbb3f+DYkhcSaK1w1rGfHeQ3o1rx
         ZkJC+6EnAqwJ3rkhZFlFC66jTMms0EBe5cECqa5q2jyks9a4CUFdf9BvDEy1qoZNmKye
         wD536wuTpLtJf4jzHgxArxAV32jV73+hXueeDahRXZo+BrByWUfArwRRXahCnOmNIF48
         9ckXLMN044Swrza6nw619ukOxd/uYbpwHHM2GJuj4ZZsYg7OsqJLvr6OTvy6QRL46wd1
         EvGaqm5ASQ3TPa2y3bDJmnOKuHa59deQU5eHHS737jJV5Fhek9gMlDGSkuG3vqg6Sy2B
         B7/w==
X-Gm-Message-State: AOAM531lrWqjeIcCMz1ILfHLhgyYZ5NzCe9EcVSh3DRcgkI/zUNSjDr/
        HnVwXSn/5x3GtJACjREEndA=
X-Google-Smtp-Source: ABdhPJwuYrd3WsqGm7dLq9ddX8OCu6a+36K8C3d4Ru9zdbUjafqg7nYbhAE1pOb+IQPgZNSujUy5jQ==
X-Received: by 2002:ac8:5ec3:: with SMTP id s3mr5372912qtx.312.1624548095857;
        Thu, 24 Jun 2021 08:21:35 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 6sm2849236qks.0.2021.06.24.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 08:21:35 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
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
Subject: Re: [PATCH v31 05/13] mm/damon: Implement primitives for the virtual memory address spaces
Date:   Thu, 24 Jun 2021 15:21:30 +0000
Message-Id: <20210624152130.877-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod5dFVxJVFUP4zBCC97C7rr5pGjRZQoixzs=GcNRAosKgw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu, 24 Jun 2021 07:42:44 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Thu, Jun 24, 2021 at 3:26 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> [...]
> > > > +/*
> > > > + * Get the three regions in the given target (task)
> > > > + *
> > > > + * Returns 0 on success, negative error code otherwise.
> > > > + */
> > > > +static int damon_va_three_regions(struct damon_target *t,
> > > > +                               struct damon_addr_range regions[3])
> > > > +{
> > > > +       struct mm_struct *mm;
> > > > +       int rc;
> > > > +
> > > > +       mm = damon_get_mm(t);
> > > > +       if (!mm)
> > > > +               return -EINVAL;
> > > > +
> > > > +       mmap_read_lock(mm);
> > > > +       rc = __damon_va_three_regions(mm->mmap, regions);
> > > > +       mmap_read_unlock(mm);
> > >
> > > This is being called for each target every second by default. Seems
> > > too aggressive. Applications don't change their address space every
> > > second. I would recommend to default ctx->primitive_update_interval to
> > > a higher default value.
> >
> > Good point.  If there are many targets and each target has a huge number of
> > VMAs, the overhead could be high.  Nevertheless, I couldn't find the overhead
> > in my test setup.  Also, it seems someone are already started exploring DAMON
> > patchset with the default value. and usages from others.  Silently changing the
> > default value could distract such people.  So, if you think it's ok, I'd like
> > to change the default value only after someone finds the overhead from their
> > usages and asks a change.
> >
> > If you disagree or you found the overhead from your usage, please feel free to
> > let me know.
> >
> 
> mmap lock is a source contention in the real world workloads. We do
> observe in our fleet and many others (like Facebook) do complain on
> this issue. This is the whole motivation behind SFP, maple tree and
> many other mmap lock scalability work. I would be really careful to
> add another source of contention on mmap lock. Yes, the user can
> change this interval themselves but we should not burden them with
> this internal knowledge like "oh if you observe high mmap contention
> you may want to increase this specific interval". We should set a good
> default value to avoid such situations (most of the time).

Thank you for this nice clarification.  I can understand your concern because I
also worked for an HTM-based solution of the scalability issue before.

However, I have neither strong preference nor confidence for the new default
value at the moment.  Could you please recommend one if you have?


Thanks,
SeongJae Park
