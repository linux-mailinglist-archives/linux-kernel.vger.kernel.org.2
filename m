Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAD359493
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhDIFct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhDIFcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:32:48 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C69CC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 22:32:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z136so4678632iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxWZg8GIxRLBho/ausojU/sJO0xe78oHCVyalpIaIOk=;
        b=QOL4OZ1urFgNXve/8IvwqfMO5TWDKsDZuKsv0cLeHRxQyvM5/H4eSPB7H9TSVuZy6G
         E5sXuqnmOKmTV+VYoFJgdQXPIp5RQuO8h8skw+Y1c2PelpZzGSwT71Uh+rp+v0MQcUbx
         WwsdJ8csxIXJiCqm2kpIE+xTk/qQDgtrNVW4cWa5Yygf5dXW12/srme+G9amHoPUz8bL
         czFasIpo//7/39H//fsS0emmjm1VRSD7684CUr5WdEjn/VEAvO1BA1OhAUxdZY69eldC
         wbZFI19VWRNox6ayVJSN8RgRyO7NOCwctosx2swPNngNcQXwVQF1AeSKbPPea8hqvm97
         mStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxWZg8GIxRLBho/ausojU/sJO0xe78oHCVyalpIaIOk=;
        b=T3kKcSTbDUlvxk0lYKq0iiL/usxTD2dqFP9eK6dxIJ3nKffJXeTZr/AB4rZQqP3Tdd
         hOHf0Y8VFQCrn3WRyGxBiFTb23W6sYDo3trlY/86r9SirO0pSS8r9uf5iU53VTaNmWZ0
         UvJIsqsIbmYhey6+YRxFGiHYf6qKQitfNw1U/U1QJEdDYLH+swkh8rYlQkcSEIw5B6QC
         5GXFF8F2f10Bk0u3dnyB1jPBvPJPBKu65zkT2kAZ7eahFR+ZK4IO08uv8zqFa+NgyaTM
         TP6FKFNQbeVUIgFadbbGj0QenF+AV+s/XefjNJ8bZC0Q3MNsrLsWZujiGcKyzBEPsNHQ
         NYuA==
X-Gm-Message-State: AOAM533NJsqekO07PISnJYNpy/iCY1emvYcDholjR86BKgEqv25W7Lyd
        vECzZqa71rGZg10wKpyh47UKjj8Xa+k2W6tePG/tRA==
X-Google-Smtp-Source: ABdhPJweUM9c8DnJ7OuLnPeNxaLs4UVsS28KDeOhqoFpLF8v3R5OvLaSNa6cMuV1cBMLcryj+VtdUOzku111YltYcTI=
X-Received: by 2002:a6b:661a:: with SMTP id a26mr9823930ioc.124.1617946355681;
 Thu, 08 Apr 2021 22:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183218.E7C9CE24@viggo.jf.intel.com>
In-Reply-To: <20210401183218.E7C9CE24@viggo.jf.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 8 Apr 2021 22:32:24 -0700
Message-ID: <CAAPL-u-xGhqsr8WvX2TE+qA4t2Q6S93XaDTK82fUsOkhq7iUDg@mail.gmail.com>
Subject: Re: [PATCH 01/10] mm/numa: node demotion data structure and lookup
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shy828301@gmail.com, David Rientjes <rientjes@google.com>,
        ying.huang@intel.com, Dan Williams <dan.j.williams@intel.com>,
        david@redhat.com, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to start with a simple node tiering model like this
change, which looks good to me.

I do want to mention a likely usage scenario that motivates the need
for a list of nodes as the demotion target of a source node.

Access to a cross-socket DRAM node is still fast enough.  So to minimize
memory stranding, job processes can be allowed to fall back to
allocate pages from a remote DRAM node.

But cross-socket access to PMEM nodes (the slower tier) can be slow,
especially for random writes.  It is then desirable not to demote the
pages of a process to a remote PMEM node, even when the pages are on
a remote DRAM node, which has the remote PMEM node as its demotion
target.  At the same time, it is also desirable to still be able to
demote such pages when they become cold so that the more precious
DRAM occupied by these pages can be used for more active data.

To support such use cases, we need to be able to specify a list of
demotion target nodes for the remote DRAM node, which should include
the PMEM node closer to the process.  Certainly, we will also need an
ability to limit the demotion target nodes of a process (or a cgroup)
to ensure that only local PMEM nodes are eligible as the actual
demotion target.

Note that demoting a page to a remote PMEM node is more acceptable
than a process accesses the same remote PMEM node because demotion
is one-time, sequential access, and can also use non-temporal stores
to reduce the access overheads and bypass caches.

Reviewed-by: Wei Xu <weixugc@google.com>

On Thu, Apr 1, 2021 at 11:35 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Prepare for the kernel to auto-migrate pages to other memory nodes
> with a user defined node migration table. This allows creating single
> migration target for each NUMA node to enable the kernel to do NUMA
> page migrations instead of simply reclaiming colder pages. A node
> with no target is a "terminal node", so reclaim acts normally there.
> The migration target does not fundamentally _need_ to be a single node,
> but this implementation starts there to limit complexity.
>
> If you consider the migration path as a graph, cycles (loops) in the
> graph are disallowed.  This avoids wasting resources by constantly
> migrating (A->B, B->A, A->B ...).  The expectation is that cycles will
> never be allowed.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
>
> --
>
> changes since 20200122:
>  * Make node_demotion[] __read_mostly
>
> changes in July 2020:
>  - Remove loop from next_demotion_node() and get_online_mems().
>    This means that the node returned by next_demotion_node()
>    might now be offline, but the worst case is that the
>    allocation fails.  That's fine since it is transient.
> ---
>
>  b/mm/migrate.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff -puN mm/migrate.c~0006-node-Define-and-export-memory-migration-path mm/migrate.c
> --- a/mm/migrate.c~0006-node-Define-and-export-memory-migration-path    2021-03-31 15:17:10.734000264 -0700
> +++ b/mm/migrate.c      2021-03-31 15:17:10.742000264 -0700
> @@ -1163,6 +1163,23 @@ out:
>         return rc;
>  }
>
> +static int node_demotion[MAX_NUMNODES] __read_mostly =
> +       {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
> +
> +/**
> + * next_demotion_node() - Get the next node in the demotion path
> + * @node: The starting node to lookup the next node
> + *
> + * @returns: node id for next memory node in the demotion path hierarchy
> + * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
> + * @node online or guarantee that it *continues* to be the next demotion
> + * target.
> + */
> +int next_demotion_node(int node)
> +{
> +       return node_demotion[node];
> +}
> +
>  /*
>   * Obtain the lock on page, remove all ptes and migrate the page
>   * to the newly allocated page in newpage.
> _
