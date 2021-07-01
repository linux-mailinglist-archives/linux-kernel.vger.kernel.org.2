Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733043B8B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhGAAUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbhGAAUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:20:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F3C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:18:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t17so8527827lfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmjVxgCuZa7W1IB2rE7Ahs8xwAc6kD7PBq+4uE9+JOg=;
        b=MwGuYq470DmmxyRW4pUzKJAiI4H+QXWtWt+NTxQliXHh0rcaeFKoVfPZgD6OBSkoeG
         YFK7kzI7NdXqOnjvIk9UbPglOGKun5fmzyA7G09R69iUwxLwGFkfLbQu2SHKAC88o91m
         g0aY9S4Y8QJy8Sy6GgZAZtSNU5JQmRivsHihX1qNcdnmjhYbEOGPjgliq8iesXVK3S3P
         w59/vFnMZbpLHyfmLBy0+tgwGLmD3CoPbifnp6OsA+FgqfJTdBgWQbRbKz38k7JdCjZ1
         J4UlP0kiYjFkxQAye44s4FCOOvw+H/ydsXoCp7JfjR0eVeW2R72lPix4v4E91Wjnj41K
         1AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmjVxgCuZa7W1IB2rE7Ahs8xwAc6kD7PBq+4uE9+JOg=;
        b=eRNdgZDUyZa3CspztsZC5GIbKT3LuV4Atjm4hKjFEJ+tAdzitKZ2eTL5q1Po5b8bha
         ItsJFSFONBXaod83LFATqmvplEyej1b5pvcRRqhXQg6pBm+2++Fg4CMKje0Rrr3kLJXJ
         ZjPybg5lSQRB7R4+ks8DRVf53lmDiatgpUIJvJ6TLW3HYtS4+vkgFGcjj+2pXj2c5O3C
         Yk+51LPeTtLYd3zy2WVKzp91KMMtovy7cW850LpP4bkh5DEHsAaWvWshU3P4xIUzMJK/
         WrKqNOADjVOP1s/1gbDa+YSAoZcRogBUxXHK0AMOmGYljiq4NXXSxnjQsu3PyyEgB9AH
         h0QA==
X-Gm-Message-State: AOAM533tgId4xfdPUYS8YfmyNTrNn0SowqO5r0M800r3z8BkVg3p9PCv
        bc8IAf/dzefypMVVO/vPJZ6yAclpacdckqig2TvJRg==
X-Google-Smtp-Source: ABdhPJxhdsug23dO9aKrK0MJcADXuwga3FJN8Rqu74M+5beXZR3CMYGYDeoM6AE7Daeb6YUcq+j6pJ9NWKihh6AqwT8=
X-Received: by 2002:a19:5016:: with SMTP id e22mr16601403lfb.299.1625098698637;
 Wed, 30 Jun 2021 17:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210621083108.17589-1-sj38.park@gmail.com> <20210621083108.17589-6-sj38.park@gmail.com>
In-Reply-To: <20210621083108.17589-6-sj38.park@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Jun 2021 17:18:07 -0700
Message-ID: <CALvZod4zE812VjubFKfbTG_jF7-uX5kT48=XQ+2cYxnzsY9-fQ@mail.gmail.com>
Subject: Re: [PATCH v31 05/13] mm/damon: Implement primitives for the virtual
 memory address spaces
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
> This commit introduces a reference implementation of the address space
> specific low level primitives for the virtual address space, so that
> users of DAMON can easily monitor the data accesses on virtual address
> spaces of specific processes by simply configuring the implementation to
> be used by DAMON.
>
> The low level primitives for the fundamental access monitoring are
> defined in two parts:
>
> 1. Identification of the monitoring target address range for the address
>    space.
> 2. Access check of specific address range in the target space.
>
> The reference implementation for the virtual address space does the
> works as below.
>
> PTE Accessed-bit Based Access Check
> -----------------------------------
>
> The implementation uses PTE Accessed-bit for basic access checks.  That
> is, it clears the bit for the next sampling target page and checks
> whether it is set again after one sampling period.  This could disturb
> the reclaim logic.  DAMON uses ``PG_idle`` and ``PG_young`` page flags
> to solve the conflict, as Idle page tracking does.
>
> VMA-based Target Address Range Construction
> -------------------------------------------
>
> Only small parts in the super-huge virtual address space of the
> processes are mapped to physical memory and accessed.  Thus, tracking
> the unmapped address regions is just wasteful.  However, because DAMON
> can deal with some level of noise using the adaptive regions adjustment
> mechanism, tracking every mapping is not strictly required but could
> even incur a high overhead in some cases.  That said, too huge unmapped
> areas inside the monitoring target should be removed to not take the
> time for the adaptive mechanism.
>
> For the reason, this implementation converts the complex mappings to
> three distinct regions that cover every mapped area of the address
> space.  Also, the two gaps between the three regions are the two biggest
> unmapped areas in the given address space.  The two biggest unmapped
> areas would be the gap between the heap and the uppermost mmap()-ed
> region, and the gap between the lowermost mmap()-ed region and the stack
> in most of the cases.  Because these gaps are exceptionally huge in
> usual address spaces, excluding these will be sufficient to make a
> reasonable trade-off.  Below shows this in detail::
>
>     <heap>
>     <BIG UNMAPPED REGION 1>
>     <uppermost mmap()-ed region>
>     (small mmap()-ed regions and munmap()-ed regions)
>     <lowermost mmap()-ed region>
>     <BIG UNMAPPED REGION 2>
>     <stack>
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> Reviewed-by: Fernand Sieber <sieberf@amazon.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
