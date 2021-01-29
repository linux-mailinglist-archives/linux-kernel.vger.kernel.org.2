Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CCB308EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 22:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhA2VAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 16:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhA2U77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:59:59 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596DDC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:59:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c2so12106031edr.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVH1s5GcGoG1te9FUAOq8LIQwayu4tr9vgJLQMZUFNw=;
        b=vhN3SKTCzL8NW2JQMe9nLy+1sPx5AbQAjOUYFkDWFQMHQt4dVczXcmkflCPQ3Fe/Uk
         E1ODptOnLTYdUAb3zO5oi9zZ4Eepg3T51IvnK8a6IHT/diPceLPNmY6tRSw/bipFxQ51
         AnAU9796oRyQss3ja5xnyRdLlLehm/RyH53OwCfAB+gaK6zLb+42oFehlGzfqOIht5FD
         X6olexQEL9dmmrRckTn63qEOM0vtA3VmV6J4zPqskQUTcYJXcSCaBKWjlpTuYIelKGOt
         KY6C/DgXOPFcfEOu9CvR5XHXrdAyxpRW+TfiBr7I6aBkTZMhMGUhSnzgePzkM9ml9BA4
         hBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVH1s5GcGoG1te9FUAOq8LIQwayu4tr9vgJLQMZUFNw=;
        b=tFJBEfP3VSY1x2gFhOeU7exuMhPyD7QAbjP4O8rRjmzHFSICc4zeVzwYneNuuef7F/
         86fIcEHMOoW86Xo4GltidOjB9dEHiT2ONB1RbnFFpn7MUgCsgyWTXLYcqkoDhCTuIjXl
         wyPMRxHAdzOrDA/QvK1eTwt7JXZygqium+ie36A0MMNEY7x83BLmcSekpB37cKZHEkWa
         78T7ftcIIXL9ZXXjYPrLH8qGJaimDKsLxQxx/SA/xJCr9WQjjzGbPddvg3rpdQxYNg8Z
         wGn4U8XIWAEvExijiGxsjz2F9i4/wQwea3zRY1p/N/e/BRX7ZVoV0DjDSzG0e5sMv02f
         d5ZQ==
X-Gm-Message-State: AOAM533xmTLyq1F54f/kv+zXeGpvnF3qREVzUIPRKMqeeRED2fiw4d5p
        B1XT7qDCxWlAo1l/D9DZUqXSQBd8zgggleAqsU0=
X-Google-Smtp-Source: ABdhPJyeGpRYWhq035RfJWm8foKTw1NlidoXIYQGGlquPqG59tIsr4ZikU0kIameCXnAq1HomxQ1bB+lMO/XyOB9bMg=
X-Received: by 2002:a50:fc04:: with SMTP id i4mr7371767edr.137.1611953958176;
 Fri, 29 Jan 2021 12:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003423.8D2B5637@viggo.jf.intel.com>
In-Reply-To: <20210126003423.8D2B5637@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Jan 2021 12:59:06 -0800
Message-ID: <CAHbLzkpC-woEakmThVzM3_QaXJ0xFYiN+xjyfwBvpYh4LeX_Bw@mail.gmail.com>
Subject: Re: [RFC][PATCH 06/13] mm/migrate: update migration order during on
 hotplug events
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

On Mon, Jan 25, 2021 at 4:41 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Reclaim-based migration is attempting to optimize data placement in
> memory based on the system topology.  If the system changes, so must
> the migration ordering.
>
> The implementation here is pretty simple and entirely unoptimized.  On
> any memory or CPU hotplug events, assume that a node was added or
> removed and recalculate all migration targets.  This ensures that the
> node_demotion[] array is always ready to be used in case the new
> reclaim mode is enabled.
>
> This recalculation is far from optimal, most glaringly that it does
> not even attempt to figure out if nodes are actually coming or going.
> But, given the expected paucity of hotplug events, this should be
> fine.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> ---
>
>  b/mm/migrate.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 95 insertions(+), 2 deletions(-)
>
> diff -puN mm/migrate.c~enable-numa-demotion mm/migrate.c
> --- a/mm/migrate.c~enable-numa-demotion 2021-01-25 16:23:11.850866703 -0800
> +++ b/mm/migrate.c      2021-01-25 16:23:11.855866703 -0800
> @@ -49,6 +49,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/ptrace.h>
>  #include <linux/oom.h>
> +#include <linux/memory.h>
>
>  #include <asm/tlbflush.h>
>
> @@ -3135,6 +3136,7 @@ void migrate_vma_finalize(struct migrate
>  EXPORT_SYMBOL(migrate_vma_finalize);
>  #endif /* CONFIG_DEVICE_PRIVATE */
>
> +#if defined(CONFIG_MEMORY_HOTPLUG)
>  /* Disable reclaim-based migration. */
>  static void disable_all_migrate_targets(void)
>  {
> @@ -3191,7 +3193,7 @@ static int establish_migrate_target(int
>   * with itself.  Exclusion is provided by memory hotplug events
>   * being single-threaded.
>   */
> -void __set_migration_target_nodes(void)
> +static void __set_migration_target_nodes(void)
>  {
>         nodemask_t next_pass    = NODE_MASK_NONE;
>         nodemask_t this_pass    = NODE_MASK_NONE;
> @@ -3253,9 +3255,100 @@ again:
>                 goto again;
>  }
>
> -void set_migration_target_nodes(void)
> +/*
> + * For callers that do not hold get_online_mems() already.
> + */
> +static void set_migration_target_nodes(void)

Aha, it is changed to static here. I think this hunk should be folded
into the previous patch.

>  {
>         get_online_mems();
>         __set_migration_target_nodes();
>         put_online_mems();
>  }
> +
> +/*
> + * React to hotplug events that might affect the migration targes

s/targes/targets

> + * like events that online or offline NUMA nodes.
> + *
> + * The ordering is also currently dependent on which nodes have
> + * CPUs.  That means we need CPU on/offline notification too.
> + */
> +static int migration_online_cpu(unsigned int cpu)
> +{
> +       set_migration_target_nodes();
> +       return 0;
> +}
> +
> +static int migration_offline_cpu(unsigned int cpu)
> +{
> +       set_migration_target_nodes();
> +       return 0;
> +}
> +
> +/*
> + * This leaves migrate-on-reclaim transiently disabled
> + * between the MEM_GOING_OFFLINE and MEM_OFFLINE events.
> + * This runs reclaim-based micgration is enabled or not.

s/micgration/migration

> + * This ensures that the user can turn reclaim-based
> + * migration at any time without needing to recalcuate

s/reclcuate/recalculate

> + * migration targets.
> + *
> + * These callbacks already hold get_online_mems().  That
> + * is why __set_migration_target_nodes() can be used as
> + * opposed to set_migration_target_nodes().
> + */
> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> +                                                unsigned long action, void *arg)
> +{
> +       switch (action) {
> +       case MEM_GOING_OFFLINE:
> +               /*
> +                * Make sure there are not transient states where
> +                * an offline node is a migration target.  This
> +                * will leave migration disabled until the offline
> +                * completes and the MEM_OFFLINE case below runs.
> +                */
> +               disable_all_migrate_targets();

Don't we need smp_wmb() here? In the previous patch the comment says
write memory barrier is needed to guarantee readers see the consistent
values. The the smp_wmb() is called by __set_migration_target_nodes().
So, it seems it'd better to move smp_wmb() into
disable_all_migrate_targets().

> +               break;
> +       case MEM_OFFLINE:
> +       case MEM_ONLINE:
> +               /*
> +                * Recalculate the target nodes once the node
> +                * reaches its final state (online or offline).
> +                */
> +               __set_migration_target_nodes();
> +               break;
> +       case MEM_CANCEL_OFFLINE:
> +               /*
> +                * MEM_GOING_OFFLINE disabled all the migration
> +                * targets.  Reenable them.
> +                */
> +               __set_migration_target_nodes();
> +               break;
> +       case MEM_GOING_ONLINE:
> +       case MEM_CANCEL_ONLINE:
> +               break;
> +       }
> +
> +       return notifier_from_errno(0);
> +}
> +
> +static int __init migrate_on_reclaim_init(void)
> +{
> +       int ret;
> +
> +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "migrate on reclaim",
> +                               migration_online_cpu,
> +                               migration_offline_cpu);
> +       /*
> +        * In the unlikely case that this fails, the automatic
> +        * migration targets may become suboptimal for nodes
> +        * where N_CPU changes.  With such a small impact in a
> +        * rare case, do not bother trying to do anything special.
> +        */
> +       WARN_ON(ret < 0);
> +
> +       hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> +       return 0;
> +}
> +late_initcall(migrate_on_reclaim_init);
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> _
>
