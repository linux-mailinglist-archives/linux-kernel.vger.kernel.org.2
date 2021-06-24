Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE193B31AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhFXOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhFXOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:45:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DBAC061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:42:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u13so10751989lfk.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPDOtaL+XLEb4/llfBA4wK0O+KTaocWklfCim100ic0=;
        b=AwNSCHRt5qjpDmU6yijGBadrKOXnnr9hVNiLlx/FbaOFqI7Oxqf65VBlsJ84NPRVUf
         Uk6MvF+XRWYMyea/gmTHmIUsLYO7xcwg9uhua6HSTwUNSWCMFDs8TG7TzLmj03SLlMLu
         nm+U/p9FibYIcXKi7fSqx93PopR7gtjTiBZHR3bsaYo0FD2sFQhJS5DGD3A8rJJh5InC
         +SOGjQ6qrQ/au6Oy7sPYBw1TPZPaqdfRUaAmVvuVuXWe2YEZ5fRR/HxaJPTbhGqJHLGE
         N1zbWFHepM00ofYSoqSVnrlyxnmfStngqHMx949hyPQtNpJz+7vR6NuPH/uXYf1W6sge
         jWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPDOtaL+XLEb4/llfBA4wK0O+KTaocWklfCim100ic0=;
        b=TJx9dHprRYOxM1jV0XcA9x3cgQzPvk1aJoaidYu07UKH59HlCSicufI7bGUNjFVp+A
         pa1okx0JdK3YDr8BfdC8z+cBJQN8qPta5IYBjBZGPEoLSclv1m/PSgNk0CKk4S/SX2Y+
         plVxOcAqRmLjBQzg4M/frBDH50JadX6V7X/zna9KIgRv3gAkV7bqwEnDnwXhivVbIIrY
         dnpo4VKoDRJmglwrdVbi2XBX3qRn1rceBvmuItuhXphJSCZig3zmvue1u/GqqI0+hgoD
         G7kXACzjBHD7UcD3pskdcydnXOc8gAzTxoGBu7MNmLFYowA86BSurDyN+E0cSwApKQRd
         TyiA==
X-Gm-Message-State: AOAM531x8SAxkjeI2b90VfVIp3iYGBMwLUFKKBIaSnaNZ6x/Ppy17flh
        T1ASRqOniI61EfkD7TBcGN8xjcdHuhUAwYmB6zBt7w==
X-Google-Smtp-Source: ABdhPJz9FhxmntnQWK4wpCGRR5Ld+FnwOhzVQjZ+p6hzlK1H8jz79mEJvtqeIDnDWjY+USditIlEcEmoOoq3XuphUdY=
X-Received: by 2002:a05:6512:3155:: with SMTP id s21mr4064815lfi.358.1624545776093;
 Thu, 24 Jun 2021 07:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210624102623.24563-1-sjpark@amazon.de> <20210624102623.24563-3-sjpark@amazon.de>
In-Reply-To: <20210624102623.24563-3-sjpark@amazon.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 24 Jun 2021 07:42:44 -0700
Message-ID: <CALvZod5dFVxJVFUP4zBCC97C7rr5pGjRZQoixzs=GcNRAosKgw@mail.gmail.com>
Subject: Re: [PATCH v31 05/13] mm/damon: Implement primitives for the virtual
 memory address spaces
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 3:26 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
[...]
> > > +/*
> > > + * Get the three regions in the given target (task)
> > > + *
> > > + * Returns 0 on success, negative error code otherwise.
> > > + */
> > > +static int damon_va_three_regions(struct damon_target *t,
> > > +                               struct damon_addr_range regions[3])
> > > +{
> > > +       struct mm_struct *mm;
> > > +       int rc;
> > > +
> > > +       mm = damon_get_mm(t);
> > > +       if (!mm)
> > > +               return -EINVAL;
> > > +
> > > +       mmap_read_lock(mm);
> > > +       rc = __damon_va_three_regions(mm->mmap, regions);
> > > +       mmap_read_unlock(mm);
> >
> > This is being called for each target every second by default. Seems
> > too aggressive. Applications don't change their address space every
> > second. I would recommend to default ctx->primitive_update_interval to
> > a higher default value.
>
> Good point.  If there are many targets and each target has a huge number of
> VMAs, the overhead could be high.  Nevertheless, I couldn't find the overhead
> in my test setup.  Also, it seems someone are already started exploring DAMON
> patchset with the default value. and usages from others.  Silently changing the
> default value could distract such people.  So, if you think it's ok, I'd like
> to change the default value only after someone finds the overhead from their
> usages and asks a change.
>
> If you disagree or you found the overhead from your usage, please feel free to
> let me know.
>

mmap lock is a source contention in the real world workloads. We do
observe in our fleet and many others (like Facebook) do complain on
this issue. This is the whole motivation behind SFP, maple tree and
many other mmap lock scalability work. I would be really careful to
add another source of contention on mmap lock. Yes, the user can
change this interval themselves but we should not burden them with
this internal knowledge like "oh if you observe high mmap contention
you may want to increase this specific interval". We should set a good
default value to avoid such situations (most of the time).
