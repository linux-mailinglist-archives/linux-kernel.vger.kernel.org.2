Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D58331B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhCHX7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhCHX7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:59:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983BFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 15:59:08 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mj10so23923120ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 15:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0sgCVzuEWKtYhGm2lK4XelzYXOqzpILEQnckI9FXEY=;
        b=Aseowwh2JcLWPQNWZOAXoWU0QMjWmb0VwfNqQlqr4N5u/ycJsRUTo9Z+R6wO5mxUJZ
         2e1mPPdqAYjy5Cva32D8Rj5TmRWFs2+wwSX6N4WgdWNfwc6yidbnzv9+QmfbYxvL3eXA
         Hwcl8U+So2nBtK0xaGmGDyPrGmpQeuuAw2+g3Q/UAkmtMokQqRGoVRmrbXM3k5vPV119
         0lzcB66ObWAzp54b6K9dLJ5y6ERIy496/BfljJFFgdjZKCWCOkOdhW5Iqr8CeaL4iy7c
         W+mc77qnThxN0+usIEXrLVY4EMv0p/RjSs2YnEmGO53QBFCottWEGA1aQtNik84ABfWZ
         lohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0sgCVzuEWKtYhGm2lK4XelzYXOqzpILEQnckI9FXEY=;
        b=G0AbDhW23/srs86rX3RXnkeUIzZcZuFwxfVv37q8EG+erQ5hUPJ20f9oNpv9KPdMow
         x+0JIUHyQo0uZzbL4qLmzY3DYBEfTgpPAnf71xhJrb0rmc3jvqlDBQUPiz2dffl825Xt
         sB9jNdjk7Y+RQ90Ovb0LluzaLc+BzmRDf9fXJ3IF12w7unSLfVaJ5HyPl1GmT/QzO+Wm
         1FvmpDQ3w0BtVpEQj0bQYCfIQXClymnJQq6qrgLdSj1kWm4PMuysoSOQ9p58jCjcsvJe
         5JFvQ9r5dmii3Az+2q4NFUi354gRepJXGWLcU/Uz1Qo7VfRGX/i9dO6LIuYI4wdvg/kl
         e0MA==
X-Gm-Message-State: AOAM532HVrXAR/e3KMLj0kH8iiKRIqe9B/oNpqKaCKDD1OQedUgIwkpE
        J6u25ttkJ+hqqK57oXNlAh9bDiiTv+m8B5hW6U4=
X-Google-Smtp-Source: ABdhPJxjayvrTchiFV4M3OVjoplMke131OsV8QZAQ3K+FOsdbnZ4wotvDxsdIudVABZKs3qQy62KJhS5k94x51eZeMo=
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr17528122ejf.25.1615247947402;
 Mon, 08 Mar 2021 15:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210304235951.271553C2@viggo.jf.intel.com>
In-Reply-To: <20210304235951.271553C2@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 15:58:56 -0800
Message-ID: <CAHbLzkqee9w6m4NQ4+=Dmp+E10=DVYGYP4FzA8hMJNvBAMMQ0w@mail.gmail.com>
Subject: Re: [PATCH 01/10] mm/numa: node demotion data structure and lookup
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 4:00 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
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

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
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
> --- a/mm/migrate.c~0006-node-Define-and-export-memory-migration-path    2021-03-04 15:35:51.353806441 -0800
> +++ b/mm/migrate.c      2021-03-04 15:35:51.359806441 -0800
> @@ -1157,6 +1157,23 @@ out:
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
>
