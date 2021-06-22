Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600703B0817
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhFVPBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhFVPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:01:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F28C061767
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:59:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c11so30572621ljd.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RA8ZD9ClukMzIKl1MArz2ae3thSxvhEA0gqsTc1XYss=;
        b=Pb4LQYmNj3prWXaEvsu8+rvfYImNKOOFVO+YElWuhVGmGRuzjKH3ziJIRpyoScfWkq
         CtFTKrqB7bLWr3dbBYb/lObqKFZtynQCNjOKG4XgFCSzPIuj8Cq3KKhd3TmrtlHlqgED
         SafREWJtEpmXpAzkZuiZx9uJG1MHLKvv0RhzehuvcKx1aEcAfMsYsULjKYqMLOkFXgQ+
         SXieBM52oa/d16NaRVwpOaypC3AyhGlXY8ya/3N0yFfVohmHUFpNW/6GvNFYew3hCdVj
         esSl1xYrpRwRjF6yq543gA9qCZrqpYjO7GGiGfzFegaccFxdLq9RKHxf51AdT9+N4tP+
         ffYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RA8ZD9ClukMzIKl1MArz2ae3thSxvhEA0gqsTc1XYss=;
        b=Lzp1pxyR8srO9ep3YW35r7/G9KdCLkow39ymNYcTmdPkZ7MRKpSaEzuSHzoybQbp4q
         7B7eJk2zhUMZjnULFlOqFXuC+S6AtxlMm1DMg74ZW6bQ8Jbadpm6ZPyFMBe5y/d2ewS6
         dUbZu9ycwVpGe87OucMFXYOm9ZDQ3fn34egSkXS4zjP7xR2KDngxdmxXt9ZPPZefi9IG
         cnvD0EpV4KkerrXTFgXN1Wd+zrp5ou9W3/MpbCLke34UZfcpdmvtEpJ6wN8ejklqi/iY
         dYBLzbMNnO5362XQS9VGjqHYr8CD/apll8h5x0iC6r0UruXJwsiemjIkwEsPFuCwETd1
         gxCw==
X-Gm-Message-State: AOAM5311E9cTWUUBURWya6oTC4t0am7FNICEQY1Vf0XzK+Taxf7SJapv
        HDjkFELiFobwFJfKc3f4VGd4X/Su9iZQS+PgUTwl0A==
X-Google-Smtp-Source: ABdhPJxulhjPL3w9xH/DtXwDuOpTPs0GBBZVsrKKsHxqzu/ANLShEMXKYExXbngsiCwr7f1lxiXoFteJooEKw+KviKg=
X-Received: by 2002:a05:651c:49d:: with SMTP id s29mr3703265ljc.279.1624373970420;
 Tue, 22 Jun 2021 07:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210621083108.17589-1-sj38.park@gmail.com> <20210621083108.17589-3-sj38.park@gmail.com>
In-Reply-To: <20210621083108.17589-3-sj38.park@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Jun 2021 07:59:19 -0700
Message-ID: <CALvZod7mJivKs+u8cTKrYuUg=X+XFjXZ3zBnureFzTqK+BLrYQ@mail.gmail.com>
Subject: Re: [PATCH v31 02/13] mm/damon/core: Implement region-based sampling
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
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

On Mon, Jun 21, 2021 at 1:31 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> To avoid the unbounded increase of the overhead, DAMON groups adjacent
> pages that are assumed to have the same access frequencies into a
> region.  As long as the assumption (pages in a region have the same
> access frequencies) is kept, only one page in the region is required to
> be checked.  Thus, for each ``sampling interval``,
>
>  1. the 'prepare_access_checks' primitive picks one page in each region,
>  2. waits for one ``sampling interval``,
>  3. checks whether the page is accessed meanwhile, and
>  4. increases the access count of the region if so.
>
> Therefore, the monitoring overhead is controllable by adjusting the
> number of regions.  DAMON allows both the underlying primitives and user
> callbacks to adjust regions for the trade-off.  In other words, this
> commit makes DAMON to use not only time-based sampling but also
> space-based sampling.
>
> This scheme, however, cannot preserve the quality of the output if the
> assumption is not guaranteed.  Next commit will address this problem.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> Reviewed-by: Fernand Sieber <sieberf@amazon.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
