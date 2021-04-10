Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6535AA73
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 05:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhDJDHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 23:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJDHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 23:07:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065BFC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 20:07:20 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b10so7912649iot.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 20:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVNC0d59MT6xpFEDMgjLN8K/lOHIofFkyNv+jPDCMzY=;
        b=V9jKrooI8Haf1uI3I2fEntbb+NYU3UsCPjwssnKN96Xu8dLwsGjfZ2WNbH+AMKa3Fk
         y0RdsN7Y9Mp5ddgZiWLriuMUFvlEoJBt00+qw7eAeWHeepZsfLDhgcAFC7FxIQhPgFjt
         wI8wZXfd0pIa3sfNlmOK32loMbbA8zpWu/TZIA1cwpkAUiqMma/F04XSnp1R8mhen8GV
         jUe1BTc/HywJQIBifiapO0Cb91d5IwO3yIhaf6IxIF/pffhXYS/BU9cVvImdYY/OTgmh
         focPNd35E+/ELmZQ8pQJdwzDnwKss2AER02PBwOZTPKILLLrMafQsHXrvssCgmjS5Acl
         emRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVNC0d59MT6xpFEDMgjLN8K/lOHIofFkyNv+jPDCMzY=;
        b=puMzpWJKoZiAj0HanQ3qSIz0ldI/ee2Y2mu/1bEAU1tK+3ckjiVr5CCE/DkZPcuSE4
         h0Fwg64Owkn80R3jisOUOjzx67lV2sJJbUGGSdkvlW/+5rKQAAdGX4xB4b6vdjbbq6Sy
         iFa6vAsDOypBayQf72S5KTWCotN+FRUnX1D4nfkBvrEdwVr+i9DT0epfyU+iAfs7O9Ms
         3A9ciI4rXAS9337Yo43HXZQeZp/bk6whpRCwXAW9tU3FRtCc1Z5K+zXbFZB0gCUOQ/AR
         l6Ncd9Igg8WfK8wmMNDaqqOG7dS4/s21qXlmtHIKLgYeAgJVUfaVBhfAmwsopej1xdEL
         lUiQ==
X-Gm-Message-State: AOAM532hoheIciaMEJmxLWAYRUcV2ppYwhzNUzZp8aJJO1a83J4K7rfF
        v858LlPL/OnjDoCY/7QjamWR6tKdbcmxmImmGJ4e4Q==
X-Google-Smtp-Source: ABdhPJy1JsEpa0RjSGy/7SGGuduw2fX6ZNYpbqt4u0QfFvAtjUX0rEOfdWgfHjjynFGUZEkr2BTVdUrIYql0OyJhtKc=
X-Received: by 2002:a5e:8c16:: with SMTP id n22mr13978920ioj.156.1618024039488;
 Fri, 09 Apr 2021 20:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183219.DC1928FA@viggo.jf.intel.com>
In-Reply-To: <20210401183219.DC1928FA@viggo.jf.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 9 Apr 2021 20:07:08 -0700
Message-ID: <CAAPL-u8Jk-i-9-iSnU7_nb-k2ZMqdRk5c88d-M6Bi1rfv4kSLQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration order
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 11:35 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> +/*
> + * node_demotion[] example:
> + *
> + * Consider a system with two sockets.  Each socket has
> + * three classes of memory attached: fast, medium and slow.
> + * Each memory class is placed in its own NUMA node.  The
> + * CPUs are placed in the node with the "fast" memory.  The
> + * 6 NUMA nodes (0-5) might be split among the sockets like
> + * this:
> + *
> + *     Socket A: 0, 1, 2
> + *     Socket B: 3, 4, 5
> + *
> + * When Node 0 fills up, its memory should be migrated to
> + * Node 1.  When Node 1 fills up, it should be migrated to
> + * Node 2.  The migration path start on the nodes with the
> + * processors (since allocations default to this node) and
> + * fast memory, progress through medium and end with the
> + * slow memory:
> + *
> + *     0 -> 1 -> 2 -> stop
> + *     3 -> 4 -> 5 -> stop
> + *
> + * This is represented in the node_demotion[] like this:
> + *
> + *     {  1, // Node 0 migrates to 1
> + *        2, // Node 1 migrates to 2
> + *       -1, // Node 2 does not migrate
> + *        4, // Node 3 migrates to 4
> + *        5, // Node 4 migrates to 5
> + *       -1} // Node 5 does not migrate
> + */

In this example, if we want to support multiple nodes as the demotion
target of a source node, we can group these nodes into three tiers
(classes):

fast class:
0 -> {1, 4}  // 1 is the preferred
3 -> {4, 1}  // 4 is the preferred

medium class:
1 -> {2, 5}  // 2 is the preferred
4 -> {5, 2}  // 5 is the preferred

slow class:
2 -> stop
5 -> stop

This can guarantee there are no cycles, either.  Does it sound sensible?

> +again:
> +       this_pass = next_pass;
> +       next_pass = NODE_MASK_NONE;
> +       /*
> +        * To avoid cycles in the migration "graph", ensure
> +        * that migration sources are not future targets by
> +        * setting them in 'used_targets'.  Do this only
> +        * once per pass so that multiple source nodes can
> +        * share a target node.
> +        *
> +        * 'used_targets' will become unavailable in future
> +        * passes.  This limits some opportunities for
> +        * multiple source nodes to share a destination.
> +        */
> +       nodes_or(used_targets, used_targets, this_pass);
> +       for_each_node_mask(node, this_pass) {
> +               int target_node = establish_migrate_target(node, &used_targets);
> +
> +               if (target_node == NUMA_NO_NODE)
> +                       continue;
> +
> +               /* Visit targets from this pass in the next pass: */
> +               node_set(target_node, next_pass);
> +       }
> +       /* Is another pass necessary? */
> +       if (!nodes_empty(next_pass))
> +               goto again;

This goto seems like exactly a "do {} while" loop.  Any particular reason not to
use "do {} while" here?
