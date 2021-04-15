Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662EB3600CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 06:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhDOEHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 00:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDOEHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 00:07:37 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F70C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 21:07:13 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a11so20801193ioo.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 21:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6AY733fGeYnXuyutjzCDjkciisfbvulWzaOHZ289MSo=;
        b=g+uB2jOSsHNLUINlbn5GDoqTqrYOf6elH+fG2NZo4sFIYzRUzYkbZR2L7b9BWjiyGR
         qCSqED8miQHqrxXw9fUSZnouWyO6e9lreI7BiUFj6rPbzmHc2JjPD/pnJTYXtfZsgnAB
         7EeE+WE2jOtacH1whI5r56Ovj5UaoI2oSp59ZpxD4tlH5muut9EzH4Hl3IIKjhP42rVB
         Fw4wstzeYnQbhk6DaGVvgCs6KD6on+lx5ofNdYIPAvFYzerEY2g0kKbPw6zeextA14lq
         UgVKEJF4q4XYIyEknElyxQcde/2oI2uOP25T6xnMO8VBlLHEBscQW/1kyqsC07Db1ZRT
         HYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AY733fGeYnXuyutjzCDjkciisfbvulWzaOHZ289MSo=;
        b=F9hl7kFVbKsCuAzP8qnjXy1W7q6nlvunjgxU1FPwQL/7UUGgcN/YtbbhqdM7YXf3IF
         2xMMA+hMca18KZx8kR2eD/UJwdbrm8yCuHwAZsTzg8DJE+Vv9G8QWtb8HyYM31CzDvM3
         CxsfRSYjhfZIEO26MtjWstwpr6VqCbq6R2qb/DnupV5yjsGw3sfwPhwofk4qoKmQFNdH
         udLStQ6eUAsxetW/GCqjhfhW7tD/mJzFIvfJXdMp2Tc1tObz6ThyzmRx1wOlzHvh/0ZT
         u/XRtWFpTURLma10w9FEO6Ij9j6dmOtR15tAx31BDl69e26sCXPuwRuoxDkPl9KUvQbY
         31mQ==
X-Gm-Message-State: AOAM533ZqqXyfuZ95U1odMAyIjuuD91D75jX8a76ZaSncwGhKlObSiDh
        GZz+OwDErqNpJ4OnzGaOrHJR4YA/Cik4nQPqR398Qg==
X-Google-Smtp-Source: ABdhPJwcQgwBEVmrdjdVbeLZ/5I5D9yyyGLw9MkszxLxsK5BIx7H5Snojbzb4cyLRN70qv1qZIM8drfIumagG6aiACg=
X-Received: by 2002:a5e:8c16:: with SMTP id n22mr1089398ioj.156.1618459633060;
 Wed, 14 Apr 2021 21:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183219.DC1928FA@viggo.jf.intel.com>
 <CAAPL-u8Jk-i-9-iSnU7_nb-k2ZMqdRk5c88d-M6Bi1rfv4kSLQ@mail.gmail.com> <20210414080849.GA20886@linux>
In-Reply-To: <20210414080849.GA20886@linux>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 14 Apr 2021 21:07:01 -0700
Message-ID: <CAAPL-u-w_WShb0RyXhs8koihTOPvFK_dCwB22RhzA=f9kRyqqQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration order
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 1:08 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> Hi Wei Xu,
>
> I have some questions about it
>
> Fast class/memory are pictured as those nodes with CPUs, while Slow class/memory
> are PMEM, right?
> Then, what stands for medium class/memory?

That is Dave's example.  I think David's guess makes sense (HBM - fast, DRAM -
medium, PMEM - slow).  It may also be possible that we have DDR5 as fast,
CXL-DDR4 as medium, and CXL-PMEM as slow.  But the most likely use cases for
now should be just two tiers: DRAM vs PMEM or other types of slower
memory devices.

> In Dave's example, list is created in a way that stays local to the socket,
> and we go from the fast one to the slow one.
> In yours, lists are created taking the fastest nodes from all sockets and
> we work our way down, which means have cross-socket nodes in the list.
> How much of a penalty is that?

Cross-socket demotion is certainly more expensive.  But because it is
sequential access
and can also be optimized with non-temporal stores, it may not be much
slower than
demotion to a local node in the next tier.  The actual penalty will
depend on the devices.

> And while I get your point, I am not sure if that is what we pretend here.
> This patchset aims to place cold pages that are about to be reclaim in slower
> nodes to give them a second chance, while your design seems more to have kind
> of different memory clases and be able to place applications in one of those tiers
> depending on its demands or sysadmin-demand.
>
> Could you expand some more?

Sure.  What I have described has the same goal as Dave's patchset,
i,e, to demote
cold pages to the slower nodes when they are about to be reclaimed.  The only
difference is that in my suggestion the demotion target of a fast tier
node is expanded
from a single node to a set of nodes from the slow tier and one node
in such a set
can be marked as the preferred/local demotion target.   This can help
enable more
flexible demotion policies to be configured, such as to allow a cgroup
to allocate from
all fast tier nodes, but only demote to a local slow tier node.  Such
a policy can reduce
memory stranding at the fast tier (compared to if memory hardwall is
used) and still
allow demotion from all fast tier nodes without incurring the expensive random
accesses to the demoted pages if they were demoted to remote slow tier nodes.

I understand that Dave started this patchset with a simplified
demotion path definition,
which I agree.  Meanwhile, I think this more generalized definition of
demotion path
is useful and can also be important for some use cases.
