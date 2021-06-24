Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B573B34EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhFXRlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFXRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:41:07 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1139C061574;
        Thu, 24 Jun 2021 10:38:46 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 19so5869836qky.13;
        Thu, 24 Jun 2021 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=USIvcW2GRTbxr6DQIhIcD3oRQUCmqXrjMxJlSlcyZyY=;
        b=kbR6mQPR3V5N+3juXGRBcBiazil8iZpsxfWzxd9BvUFR3SpS9O350b+QwJv7cVfd6W
         qmn9n8UtxJAx8JoVnoN7znSebG/jRlB7ZGrQNXz8XtSTx7r4iM/eekYQC1EQLNPcBtkk
         tA1JBxd4jXacZTtvOSKqLEpkl7Dzjpd8db6iH+n/jL5mrKjORyvQB0dFbRB+M38TtY4S
         3L0NcRdwJuMeZ3/gPAwdYCyUt4b+Q6E7JybJHYoWhqxaZ3DKY+BdaxmATNjy8eJ05Xm4
         9Ba/QGQ+cmFAcmMN3URpDChlQGHE8gz1WgUGX+I7X1TD9Ba1nTqqJFZSeK43L17Fu8t8
         uwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=USIvcW2GRTbxr6DQIhIcD3oRQUCmqXrjMxJlSlcyZyY=;
        b=I0HuYQVMkWHwP89hSCBcxzGk2ZyfhrP82Gib6gajFxvV1gG0tRIbZZScDOEZGd1TUv
         mssO5+aVwgx7oGOl47pAOYrFNwDANymmH8RwuHkMuSXQj106eEosqpGPjSVaNaIr3hw7
         YvXQLT+gInpBsM7Wi5Piw1wispqACvRBzTHRLlI3tQqqLGPWZPp+NpKie7sYze4JS/SC
         J4sNey2rA/N304DIoY7YCZ/6DrQ+0qTBfFIwcA6vuPNXTqp9wRyrdqF5F24v8ACcFTuw
         AFrwTUOml/W69OebsijLTyoyRlJD1K1BWTVX8gVdA8OOBWZPfI02NGxEsBDBO78HJA4D
         DSwQ==
X-Gm-Message-State: AOAM533VZTzxvOrQEG7RwgxkFuTXS81y/R9ChH4j8FgRharItMG+AHMf
        idNHRF5zSjIOHKDTMGScMtI=
X-Google-Smtp-Source: ABdhPJxsAxEekOJRnWG7tLXyRAMmuBFyqd4fVq5FToPvGsrdsQqeT0S7KrBF8UWNZT4FhKuSR1CeKQ==
X-Received: by 2002:a37:9d90:: with SMTP id g138mr3040398qke.212.1624556326108;
        Thu, 24 Jun 2021 10:38:46 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 61sm1110156qtf.37.2021.06.24.10.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:38:45 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, acme@kernel.org,
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
Subject: Re: [PATCH v31 05/13] mm/damon: Implement primitives for the virtual memory address spaces
Date:   Thu, 24 Jun 2021 17:38:39 +0000
Message-Id: <20210624173839.1766-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod682cg_fTf+vQxN=q_5A+GanJ3m7kVn_0gFut21_Xmu0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu, 24 Jun 2021 09:33:07 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Thu, Jun 24, 2021 at 8:21 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > On Thu, 24 Jun 2021 07:42:44 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > On Thu, Jun 24, 2021 at 3:26 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > > >
> > > [...]
> > > > > > +/*
> > > > > > + * Get the three regions in the given target (task)
> > > > > > + *
> > > > > > + * Returns 0 on success, negative error code otherwise.
> > > > > > + */
> > > > > > +static int damon_va_three_regions(struct damon_target *t,
> > > > > > +                               struct damon_addr_range regions[3])
> > > > > > +{
> > > > > > +       struct mm_struct *mm;
> > > > > > +       int rc;
> > > > > > +
> > > > > > +       mm = damon_get_mm(t);
> > > > > > +       if (!mm)
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > > +       mmap_read_lock(mm);
> > > > > > +       rc = __damon_va_three_regions(mm->mmap, regions);
> > > > > > +       mmap_read_unlock(mm);
> > > > >
> > > > > This is being called for each target every second by default. Seems
> > > > > too aggressive. Applications don't change their address space every
> > > > > second. I would recommend to default ctx->primitive_update_interval to
> > > > > a higher default value.
> > > >
> > > > Good point.  If there are many targets and each target has a huge number of
> > > > VMAs, the overhead could be high.  Nevertheless, I couldn't find the overhead
> > > > in my test setup.  Also, it seems someone are already started exploring DAMON
> > > > patchset with the default value. and usages from others.  Silently changing the
> > > > default value could distract such people.  So, if you think it's ok, I'd like
> > > > to change the default value only after someone finds the overhead from their
> > > > usages and asks a change.
> > > >
> > > > If you disagree or you found the overhead from your usage, please feel free to
> > > > let me know.
> > > >
> > >
> > > mmap lock is a source contention in the real world workloads. We do
> > > observe in our fleet and many others (like Facebook) do complain on
> > > this issue. This is the whole motivation behind SFP, maple tree and
> > > many other mmap lock scalability work. I would be really careful to
> > > add another source of contention on mmap lock. Yes, the user can
> > > change this interval themselves but we should not burden them with
> > > this internal knowledge like "oh if you observe high mmap contention
> > > you may want to increase this specific interval". We should set a good
> > > default value to avoid such situations (most of the time).
> >
> > Thank you for this nice clarification.  I can understand your concern because I
> > also worked for an HTM-based solution of the scalability issue before.
> >
> > However, I have neither strong preference nor confidence for the new default
> > value at the moment.  Could you please recommend one if you have?
> >
> 
> I would say go with a conservative value like 60 seconds. Though there
> is no scientific reason behind this specific number, I think it would
> be a good compromise. Applications usually don't change their address
> space layout that often.

Ok, I will use that from the next spin.  Thank you for this nice suggestion.


Thanks,
SeongJae Park
