Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9810030FDD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhBDUPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbhBDUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:08:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA008C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:07:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gx20so2464329pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3g2YdFFOBsK1UzWuh7itdWF6Pzv+CzXoJ4Ui6H/0fgA=;
        b=VAyZpB7r+7xqgOIbs8+IuAKKdVcFH9OlkFXuOky917ADs2skp24/LthVyjdQZX2ayq
         xXR/3YMo7ZsDaoagNtapW/b1Ibuhk/bpLmuj+s3QR4+qJqbao7Imd9GYxFwaAVUF9CXc
         lMEL9coVZDJT3Vy5by7LrUvo8HfxZfbXl6qAnajX+5yUxYybs8ecBIG6943/oS1vwUsc
         /niQoSJNsSDpqd5OVQ0Oc40arCqiXz8wAZo2g1V0Na+aLqHqvVlFFFTZZQSsp4tiAWBO
         P46vVrZsnSjxghjOG6/XbxEBtioD4OnjB6drxUqwvkqE4KnN7HxitIrxIjYV8GaIe5Vx
         E0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3g2YdFFOBsK1UzWuh7itdWF6Pzv+CzXoJ4Ui6H/0fgA=;
        b=CBOCwW/hjqlElkklSftDEeLEdpnDqw/lohN+dS6GQb9Jf70W8xoz8sh9r+U0WZz1rR
         tBwA2PRhfN1Ye3T49JfuMNdXuCoFHzfcCoZ1rRdAaPv58Ol060UqKTpO9d1vafzjAc+v
         h5TRjLI9po912bnUdnfXFSqAemiKu3uCdeOrJ8c/tPYfVCIpT2Lo9LdL087JVh69p8ed
         BsBx/VMGrAgAriy4wQ6leysLxWCsTH6M20BiJr+wrd0igA+gPZEEGtSi/14hI+/jBNSu
         kOSB7yIidZzOA0VxvfwDiUPolDn87ZoUp4U+wECHhuRdXIO0Ey/o7g1TOPZ76KaoMZmA
         YxJg==
X-Gm-Message-State: AOAM531ItVLeTeZmmG9g708dTV8qTaaziCRkJF5roxjo5qL5Q1arCktY
        Yd1i1AAIIdfg8a4O+un1k6A=
X-Google-Smtp-Source: ABdhPJx2pDxpy0ANrcj8xHkDPFXK9KldlEknHOtngWb1VJiCkVj1RQmCjG6+zyfoIdwVvObNdk6pAQ==
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr636974pjb.166.1612469240330;
        Thu, 04 Feb 2021 12:07:20 -0800 (PST)
Received: from google.com ([2620:15c:211:201:598:57c0:5d30:3614])
        by smtp.gmail.com with ESMTPSA id f3sm6278088pfe.25.2021.02.04.12.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:07:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Feb 2021 12:07:17 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YBxT9XFE6QAQ4T9N@google.com>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 12:50:58AM -0800, John Hubbard wrote:
> On 2/3/21 7:50 AM, Minchan Kim wrote:
> > Since CMA is getting used more widely, it's more important to
> > keep monitoring CMA statistics for system health since it's
> > directly related to user experience.
> > 
> > This patch introduces sysfs for the CMA and exposes stats below
> > to keep monitor for telemetric in the system.
> > 
> >   * the number of CMA allocation attempts
> >   * the number of CMA allocation failures
> >   * the number of CMA page allocation attempts
> >   * the number of CMA page allocation failures
> 
> The desire to report CMA data is understandable, but there are a few
> odd things here:
> 
> 1) First of all, this has significant overlap with /sys/kernel/debug/cma
> items. I suspect that all of these items could instead go into

At this moment, I don't see any overlap with item from cma_debugfs.
Could you specify what item you are mentioning?

> /sys/kernel/debug/cma, right?

Anyway, thing is I need an stable interface for that and need to use
it in Android production build, too(Unfortunately, Android deprecated
the debugfs
https://source.android.com/setup/start/android-11-release#debugfs
)

What should be in debugfs and in sysfs? What's the criteria?

Some statistic could be considered about debugging aid or telemetric
depening on view point and usecase. And here, I want to use it for
telemetric, get an stable interface and use it in production build
of Android. In this chance, I'd like to get concrete guideline
what should be in sysfs and debugfs so that pointing out this thread
whenever folks dump their stat into sysfs to avoid waste of time
for others in future. :)

> 
> 2) The overall CMA allocation attempts/failures (first two items above) seem
> an odd pair of things to track. Maybe that is what was easy to track, but I'd
> vote for just omitting them.

Then, how to know how often CMA API failed?
There are various size allocation request for a CMA so only page
allocation stat are not enough to know it.

> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >   Documentation/ABI/testing/sysfs-kernel-mm-cma |  39 +++++
> >   include/linux/cma.h                           |   1 +
> >   mm/Makefile                                   |   1 +
> >   mm/cma.c                                      |   6 +-
> >   mm/cma.h                                      |  20 +++
> >   mm/cma_sysfs.c                                | 143 ++++++++++++++++++
> >   6 files changed, 209 insertions(+), 1 deletion(-)
> >   create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-cma
> >   create mode 100644 mm/cma_sysfs.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> > new file mode 100644
> > index 000000000000..2a43c0aacc39
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> > @@ -0,0 +1,39 @@
> > +What:		/sys/kernel/mm/cma/
> > +Date:		Feb 2021
> > +Contact:	Minchan Kim <minchan@kernel.org>
> > +Description:
> > +		/sys/kernel/mm/cma/ contains a number of subdirectories by
> > +		cma-heap name. The subdirectory contains a number of files
> > +		to represent cma allocation statistics.
> 
> Somewhere, maybe here, there should be a mention of the closely related
> /sys/kernel/debug/cma files.
> 
> > +
> > +		There are number of files under
> > +				/sys/kernel/mm/cma/<cma-heap-name> directory
> > +
> > +			- cma_alloc_attempt
> > +			- cma_alloc_fail
> 
> Are these really useful? They a summary of the alloc_pages items, really.
> 
> > +			- alloc_pages_attempt
> > +			- alloc_pages_fail
> 
> This should also have "cma" in the name, really: cma_alloc_pages_*.

No problem.

> 
> > +
> > +What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_attempt
> > +Date:		Feb 2021
> > +Contact:	Minchan Kim <minchan@kernel.org>
> > +Description:
> > +		the number of cma_alloc API attempted
> > +
> > +What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_fail
> > +Date:		Feb 2021
> > +Contact:	Minchan Kim <minchan@kernel.org>
> > +Description:
> > +		the number of CMA_alloc API failed
> > +
> > +What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_attempt
> > +Date:		Feb 2021
> > +Contact:	Minchan Kim <minchan@kernel.org>
> > +Description:
> > +		the number of pages CMA API tried to allocate
> > +
> > +What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_fail
> > +Date:		Feb 2021
> > +Contact:	Minchan Kim <minchan@kernel.org>
> > +Description:
> > +		the number of pages CMA API failed to allocate
> > diff --git a/include/linux/cma.h b/include/linux/cma.h
> > index 217999c8a762..71a28a5bb54e 100644
> > --- a/include/linux/cma.h
> > +++ b/include/linux/cma.h
> > @@ -49,4 +49,5 @@ extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> >   extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
> >   extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
> > +
> 
> A single additional blank line seems to be the only change to this file. :)

Oops.
