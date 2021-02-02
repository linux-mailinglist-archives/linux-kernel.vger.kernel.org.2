Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6EC30C86E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhBBRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbhBBRrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:47:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EF4C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:46:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a9so12917898ejr.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGI/zcEe0Yt+bxNAd+ZCrR6roUoFCN6DKRYdKgfHGTo=;
        b=dn0kQpEE8uzdEC3sYSZKK96Y1R4SyTF8SQ++wUCnfT8U7YdqxyodVjFScTsZDUlz2n
         KXg1Dw+ctFq/Dk2HuQqOumasQ3G3q02khzesSRbG5uN4Ex1jxRPwfgQq7SyPS8eexJcj
         0/GfCZpmy+aF81ygQgdOI5YT/qoJNbogDX68XaZy+mqpSgoH8aeK6qAc82a4vH+GPZdR
         lZ7l6G74LFud0yjEfSEjbtn6W5GDktU+8rXMXfsGDWXCRBcjbriVGr79SHijhun74lqQ
         LArbTXnvlK5ey46TqSx5UZmskyWGW67xW0k4frniCllwf2pIqDldTzka/QONLnkOz3bp
         1F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGI/zcEe0Yt+bxNAd+ZCrR6roUoFCN6DKRYdKgfHGTo=;
        b=cYk3hUWkwqqIlkJ73mo76ElGchHXKM4nOHDdqjT03JIQd8l7tURyfip72Tz6nujh7p
         GLumFZyou5sJ1b1l23cdjSDj5ROkPN9DhpkZaKSOz39jbT4ooeReNBdm6rHwCtiG7n4H
         boC+MYtbWPTVi+b+okJbRKLlOzcgXeBEF8ebhV0M6txysTs3PqQ8n5ujeT9vsStisdBe
         UG1lzE5Pn1aTf8Zga3KE1rfKUypId058j+8sac10eSNPxQ5QSEf5iqwLh1wZ/dg1tpVL
         YxTxR9vsQyfObNTh4773nVkfMgFc2ydxFcrWvBiyavRmSDLpmmZcwaGDh2hdGQif5aOk
         /Vmw==
X-Gm-Message-State: AOAM530onnyiz87j5mGYYk39SyWvYogIyAYU+9YL+QZDHwZzWydN0cRm
        bJEmyxuz01C6yBuaZmS/8FfLnpJ1xmyD1L2cDHdywlKW
X-Google-Smtp-Source: ABdhPJwswex2voGStCOUsnNL01gx3JAAwJ4/V3+iqItDVUhsO/oc14DWZpKkTcMicL+pke/SiErAG604f5qaxUrOYUw=
X-Received: by 2002:a17:906:eddd:: with SMTP id sb29mr14357090ejb.383.1612288011231;
 Tue, 02 Feb 2021 09:46:51 -0800 (PST)
MIME-Version: 1.0
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003421.45897BF4@viggo.jf.intel.com>
 <CAHbLzkoB98YY0amBWTGcDPStcy1c35CC8D5MPMbVxzRKqVA0Cg@mail.gmail.com> <317d4c23-76a7-b653-87a4-bab642fa1717@intel.com>
In-Reply-To: <317d4c23-76a7-b653-87a4-bab642fa1717@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 2 Feb 2021 09:46:39 -0800
Message-ID: <CAHbLzkqrPvY4Zb17AGJi1Zi7OV9WDUTEpj5DpfWY9c2WHzPBYw@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/13] mm/numa: automatically generate node migration order
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Feb 1, 2021 at 11:13 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/29/21 12:46 PM, Yang Shi wrote:
> ...
> >>  int next_demotion_node(int node)
> >>  {
> >> -       return node_demotion[node];
> >> +       /*
> >> +        * node_demotion[] is updated without excluding
> >> +        * this function from running.  READ_ONCE() avoids
> >> +        * reading multiple, inconsistent 'node' values
> >> +        * during an update.
> >> +        */
> >
> > Don't we need a smp_rmb() here? The single write barrier might be not
> > enough in migration target set. Typically a write barrier should be
> > used in pairs with a read barrier.
>
> I don't think we need one, practically.
>
> Since there is no locking against node_demotion[] updates, although a
> smp_rmb() would ensure that this read is up-to-date, it could change
> freely after the smp_rmb().

Yes, but this should be able to guarantee we see "disable + after"
state. Isn't it more preferred?

>
> In other words, smp_rmb() would shrink the window where a "stale" read
> could occur but would not eliminate it.
>
> >> +       return READ_ONCE(node_demotion[node]);
> >
> > Why not consolidate the patch #4 in this patch? The patch #4 just add
> > the definition of node_demotion and the function, then the function is
> > changed in this patch, and the function is not used by anyone between
> > the adding and changing.
>
> I really wanted to highlight that the locking scheme and the READ_ONCE()
> (or lack thereof) was specifically due to how node_demotion[] was being
> updated.
>
> The READ_ONCE() is not, for instance, inherent to the data structure.
>
> ...
> >> +/*
> >> + * When memory fills up on a node, memory contents can be
> >> + * automatically migrated to another node instead of
> >> + * discarded at reclaim.
> >> + *
> >> + * Establish a "migration path" which will start at nodes
> >> + * with CPUs and will follow the priorities used to build the
> >> + * page allocator zonelists.
> >> + *
> >> + * The difference here is that cycles must be avoided.  If
> >> + * node0 migrates to node1, then neither node1, nor anything
> >> + * node1 migrates to can migrate to node0.
> >> + *
> >> + * This function can run simultaneously with readers of
> >> + * node_demotion[].  However, it can not run simultaneously
> >> + * with itself.  Exclusion is provided by memory hotplug events
> >> + * being single-threaded.
> >
> > Maybe an example diagram for the physical topology and how the
> > migration target is generated in the comment seems helpful to
> > understand the code.
>
> Sure.  Were you thinking of a code comment, or enhanced changelog?

I'd prefer a code comment.

>
> Let's say there's a system with two sockets each with the same three
> classes of memory: fast, medium and slow.  Each memory class is placed
> in its own NUMA node and the CPUs are attached to the fast memory.  That
> leaves 6 NUMA nodes (0-5):
>
>         Socket A: 0, 1, 2
>         Socket B: 3, 4, 5
>
> The migration path for this configuration path would start on the nodes
> with the processors and fast memory, progress through medium and end
> with the slow memory:
>
>         0 -> 1 -> 2 -> stop
>         3 -> 4 -> 5 -> stop
>
> This is represented in the node_demotion[] like this:
>
>         {  1, // Node 0 migrates to 1
>            2, // Node 1 migrates to 2
>           -1, // Node 2 does not migrate
>            4, // Node 3 migrates to 1
>            5, // Node 4 migrates to 2
>           -1} // Node 5 does not migrate
>
> Is that what you were thinking of?

Perfect.

>
> ...
> >> +again:
> >> +       this_pass = next_pass;
> >> +       next_pass = NODE_MASK_NONE;
> >> +       /*
> >> +        * To avoid cycles in the migration "graph", ensure
> >> +        * that migration sources are not future targets by
> >> +        * setting them in 'used_targets'.  Do this only
> >> +        * once per pass so that multiple source nodes can
> >> +        * share a target node.
> >> +        *
> >> +        * 'used_targets' will become unavailable in future
> >> +        * passes.  This limits some opportunities for
> >> +        * multiple source nodes to share a desintation.
> >
> > s/desination/destination
>
> Fixed, thanks.
>
> >> +        */
> >> +       nodes_or(used_targets, used_targets, this_pass);
> >> +       for_each_node_mask(node, this_pass) {
> >> +               int target_node = establish_migrate_target(node, &used_targets);
> >> +
> >> +               if (target_node == NUMA_NO_NODE)
> >> +                       continue;
> >> +
> >> +               /* Visit targets from this pass in the next pass: */
> >> +               node_set(target_node, next_pass);
> >> +       }
> >> +       /* Is another pass necessary? */
> >> +       if (!nodes_empty(next_pass))
> >> +               goto again;
> >> +}
> >> +
> >> +void set_migration_target_nodes(void)
> >
> > It seems this function is not called outside migrate.c, so it should be static.
>
> Fixed, thanks.
