Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6473A315FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhBJHN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhBJHN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:13:27 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25C8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 23:12:45 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id z18so927215ile.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q3AI3PxYvElwnsak10yIQDMqaAMIiPeIHqC/YROvbiU=;
        b=sOYXbBDOj0cvSmQ6bcRtVtTgrod13gbBEFBUxEqPIoYbY2nbXakEVTXJrmf9/NGP67
         0jWEdxIDJyFDXQ38ZEWwM3Gpf+szpYPjDVhXybB4di0jJep/H/LH2DP/82rxc5gt4IiY
         nvVsRVtHqOw0hJzgoGxBTng053Y/30K3WmE5SBLGiqyC7Qi34ZiuqrRgZl1MnV7M+TzT
         00vlFnGlWF8jQN4yIUZWrQMUk3uDT8CPKRwkO+U/CisWWF1mqa6K1jA46/MhLFBT3ZPy
         xSyKZA0gIdDmDtkN69QQnu7kqd/pexfXiK+GDy2hTX6+PyjViFfRhPkTamA9zKXmmAJ8
         U4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q3AI3PxYvElwnsak10yIQDMqaAMIiPeIHqC/YROvbiU=;
        b=ASQjMH9D253+RLHRodsyziucUyrrmPEbb1fe1DHfHIiYGYZyoID2WCp1FJPCMXyYlc
         1Nuei2mR/GXhYJQW+uQLv6vzt1tPx82Dxzj+lXl1xXe33oGSg19FwKSPv1STcqQ+qpqv
         eU3up1BwkVW7U8xyyky5niqXbRnnh98Zswbl9RPv+6ergzX45GmteulnUDXP8Aq34iOq
         BWc8q0gcvaRdc7Lk+akbvJM0hAgGChjVp6IOihOs39HeVKZ0RZAxfX0D1zmIAUZfYxGm
         fmI+7k9qMtX14K3URTAnqH4v861k0NWQRUpkDzmCvxtmVuJYAHveymG+08s8s5kEbKda
         AbIw==
X-Gm-Message-State: AOAM532EgWRpuPz/QdZwCTgnAzzrVtOincKbbmBmlPv6Z/rBUQwxaFmQ
        vpL8aEYvIJw+UxGqpLxUbTgf6g==
X-Google-Smtp-Source: ABdhPJzyYJ7qhaqf0tnYOjDHZBz2QGuva1Dj6ve1vhEpdlIBVskFuFjkso6YpHw/gTg5vcQDc0nR2A==
X-Received: by 2002:a05:6e02:1a4d:: with SMTP id u13mr1770493ilv.176.1612941163487;
        Tue, 09 Feb 2021 23:12:43 -0800 (PST)
Received: from google.com ([2620:15c:183:200:985b:af79:841f:dd9e])
        by smtp.gmail.com with ESMTPSA id a14sm572533ilj.39.2021.02.09.23.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 23:12:42 -0800 (PST)
Date:   Wed, 10 Feb 2021 00:12:38 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Sonny Rao <sonnyrao@google.com>, Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        page-reclaim@google.com
Subject: Re: [page-reclaim] Augmented Page Reclaim
Message-ID: <YCOHZhJKr6DzFQGi@google.com>
References: <YBkT6175GmMWBvw3@google.com>
 <CAJmaN=miDwb4CvVDmLS4aBKsNOVp9XiDKB1Dp3s6cfrq4yXiQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmaN=miDwb4CvVDmLS4aBKsNOVp9XiDKB1Dp3s6cfrq4yXiQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:32:58PM -0800, Jesse Barnes wrote:
> > ======================
> > Augmented Page Reclaim
> > ======================
> > We would like to share a work with you and see if there is enough
> > interest to warrant a run for the mainline. This work is a part of
> > result from a decade of research and experimentation in memory
> > overcommit at Google: an augmented page reclaim that, in our
> > experience, is performant, versatile and, more importantly, simple.
> 
> Per discussion on IRC, maybe some additional background would help.

And I'll add more details to the doc included in the tree once I've
finished collecting feedback.

> In looking at browser workloads on Chrome OS, we found that reclaim was:
> 1) too expensive in terms of CPU usage

We have two general metrics for this item: CPU time spent on page
reclaim and (direct) page reclaim latency. CPU usage is important to
everybody but latency is also quite important for phones, laptops,
etc.

> 2) often making poor decisions about what to reclaim

We have another two metrics here: the number of refaults and the
number of false inactive pages. For example, it's bad if pages refault
within a hundred of milliseconds after they have been reclaimed. Also
it's bad if reclaim thinks many pages are inactive but later finds
they are actually active.

> This work was mainly targeted toward improving those things, with an
> eye toward interactive performance for browser workloads.
> 
> We have a few key tests we use for that, that measure tab switch times
> and number of tab discards when under memory pressure, and this
> approach significantly improves these (see Yu's data).

We monitor workload-specific metrics as well. For example, we found
page reclaim also affects battery life, tab switch latency and the
number of janks (pauses when scrolling web pages) on Chrome OS. I
don't want to dump everything here because they seem irrelevant to
most people.

> We do expect this approach will also be beneficial to cloud workloads,
> and so are looking for people to try it out in their environments with
> their favorite key tests or workloads.

And if you are interested in our workload-specific metrics, Android,
Cloud, etc., please feel free to contact us. Any other questions,
concerns and suggestions are also welcome.
