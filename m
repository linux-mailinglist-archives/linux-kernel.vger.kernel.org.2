Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C73B8B13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhGAAKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbhGAAKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:10:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11967C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:08:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a11so8350810lfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vibCQHRcBzovbP098YQJ8mdWoX2J5W8wiaM7M9niEQ=;
        b=e+BOa5lVh8fknuCBWWZJqvx/9unwfYZPGN/BgA6mFJfxXAR3MsYl2UaPqSISg1aemm
         CckSbHg9T6n+da7WWFpBAZ19uz/mPHl35kTBjAfx3HZ5AJVbYw6XF5KDLJKf5+8dyYf0
         eC0MVxMARYtz4R3YUWDRwpdZXUTpJcXAbenKfunsIzgQm82ewVZHwtcsg66USaN7rrs7
         Gef0I9NiO3dD+8MHYvBRjrZV8WGIaZ4pu3o85U2v/VMGVXzlsGf91B0I4berjf8tusiK
         5SC0NWeI+yuxx9nZHdRM4gFyh/an4RKZOi7AhehE7juhNmVlPDCFBUO3rbEyg87sW8lS
         jtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vibCQHRcBzovbP098YQJ8mdWoX2J5W8wiaM7M9niEQ=;
        b=Bo2mnCqN0hvsfMsIINN81HXZrSFzOkXHrO9y6A7jQ//DPE1yorOZAWBlwhgtiNVXqz
         7sqk7/kESik40ixl8758pGltDRXUQRtryYZ1eTeZPFMt1rjVseaS5U87J1gQ9+W5bdD5
         aso1/xh/mJzkX3GbNT59GPVkdrzH02Fh7iYvEZ/Nvz4YJ8c/RRGF0LEci+0D1vkWJYzP
         q8z7MLRnlgVbSZNkAOQV1a2nvw1qGmtBet3K+cSy2OYxh+yIvWhU6JCyOT3DRKIVzdE+
         qxZiBeAGsp1lc16EZ2cmVhcZpNxYxtkvcpNtLkrf23sxEKVzkk7yOllUX+wHPicafjPw
         yZVA==
X-Gm-Message-State: AOAM532D7O8TJvqM/lffMR+3gzV1e7sqz4COLtxyWGOe7VplNcnlnkiK
        +inOsupK7j5CMg6AzAoL9Vt45Y8rg02Zh5ZBbwyTpw==
X-Google-Smtp-Source: ABdhPJxmyDJBfSyvbdI9dLWs8zeazyEu5My7Y4TtfaD2ngwyDX1ng6dTOgkazyM8zq5NQfwyTeaMmDjfcRV2sJdGoAs=
X-Received: by 2002:a19:5016:: with SMTP id e22mr16576212lfb.299.1625098083067;
 Wed, 30 Jun 2021 17:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210628133355.18576-1-sj38.park@gmail.com> <20210628133355.18576-4-sj38.park@gmail.com>
In-Reply-To: <20210628133355.18576-4-sj38.park@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Jun 2021 17:07:51 -0700
Message-ID: <CALvZod6jTB=L34gh2awfOH=+3jZ0DCxXPtmj7NO95DzfqJ_MGA@mail.gmail.com>
Subject: Re: [PATCH v32 03/13] mm/damon: Adaptively adjust regions
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

On Mon, Jun 28, 2021 at 6:34 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> Even somehow the initial monitoring target regions are well constructed
> to fulfill the assumption (pages in same region have similar access
> frequencies), the data access pattern can be dynamically changed.  This
> will result in low monitoring quality.  To keep the assumption as much
> as possible, DAMON adaptively merges and splits each region based on
> their access frequency.
>
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.
> Then, after it reports and clears the aggregated access frequency of
> each region, it splits each region into two or three regions if the
> total number of regions will not exceed the user-specified maximum
> number of regions after the split.
>
> In this way, DAMON provides its best-effort quality and minimal overhead
> while keeping the upper-bound overhead that users set.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> Reviewed-by: Fernand Sieber <sieberf@amazon.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
