Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417B6410192
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245528AbhIQXGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhIQXGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:06:30 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40186C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:05:08 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y197so490020iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ab6BsRkm5PbVHkwLBj6zbgugbszRDdG1wC8fenvlUdM=;
        b=TdAwvwXuPRV9vs/6cEhmAdY6hgi+EOW/CUFergN9OqbvMJTm5iO/R841l0L4HwT38/
         umB2VOSP/AvhuxZSowAAXqYfcv4IEjFYCN0QzBiv4WSwW+yQC5/1jJQkhsrrWv8hXt/E
         ThqEdO+zpaCmT41PyDATQwzn9hNMyJHy5yKcWMuTwssdPaukNUGjyQSjDr4z/w3LoRq4
         9k92cueUXjsiSBFU0UcEJ3WTa8ul8lniS19OPnNpQeYp3wa2fzBSwpLj+7kOLFHC4R5K
         15lK9JI5h351o+OLI3vq5oKMd/4VzE9AYTziX2rnk3AOcfrtabEGAMzirb6OFpjMigUs
         Wfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ab6BsRkm5PbVHkwLBj6zbgugbszRDdG1wC8fenvlUdM=;
        b=1JL/mHNC4ZaHPTnKDb2CFXqne9QyTzABDPbOyAdGLKdnVTokEYSr+nxYIKmyh3be+u
         /FcWtr+TDBzGB+rftn8m4rb1lAAe+bonaZz8NGn6wo6Vrzu4g28JSFrQqEjvpHxvyKkU
         RaxVHW8gPiBRwCc+HvzS8TSuc6U068mVtixttjVg267WdpeP948p+JCQ9IDvCWnkxUca
         SkrGUW3MxusSaoz2GOzdzs86WF8RZPDHame8CumWY4gYI3k8bABkoWQwMMU+FOFB7qD5
         I4YjRMEwSGlTetZpCioD9gIdcgJUIBIoEkIuGmezZclc+1wxjnZ+MgT3fquvjX6kxZ8i
         k0Ig==
X-Gm-Message-State: AOAM531lcPnIH7L4kFhLbE1ppg48Y1Elxi5HPtKMxcyQtgBHR+WPaSQ3
        6/x3Kz1tm35s0kgn1+DGyy9yljYddErzZJPf2jaCYQ==
X-Google-Smtp-Source: ABdhPJzSGn/QtM23htOl5mp0w8bBCcRwMrNTMzYgC//Zwsxw+5RZfnpYKggTQbF6t5ofBA+cYocsYEXzjF+DBZsaVqo=
X-Received: by 2002:a6b:fe05:: with SMTP id x5mr4884928ioh.26.1631919907444;
 Fri, 17 Sep 2021 16:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210917223504.C140445A@davehans-spike.ostc.intel.com> <20210917223507.913387AB@davehans-spike.ostc.intel.com>
In-Reply-To: <20210917223507.913387AB@davehans-spike.ostc.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 17 Sep 2021 16:04:56 -0700
Message-ID: <CAAPL-u_Tig1jK=mv_r=j-A-hR3Kpu7txiSFbPR3a8O1qhM1s-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/migrate: add CPU hotplug to demotion #ifdef
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization of node_demotion doesn't have to depend on
CONFIG_MEMORY_HOTPLUG and CONFIG_HOTPLUG_CPU.  While you are at this,
can you replace cpuhp_setup_state() with cpuhp_setup_state_nocalls()
and also call set_migration_target_nodes() directly in
migrate_on_reclaim_init() outside
CONFIG_MEMORY_HOTPLUG/CONFIG_HOTPLUG_CPU?  Thanks.

Wei

On Fri, Sep 17, 2021 at 3:35 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Once upon a time, the node demotion updates were driven solely by
> memory hotplug events.  But now, there are  handlers for both CPU
> and memory hotplug.
>
> However, the #ifdef around the code checks only memory hotplug.
> A system that has HOTPLUG_CPU=y but MEMORY_HOTPLUG=n would miss
> CPU hotplug events.
>
> Update the #ifdef around the common code.  Add memory and
> CPU-specific #ifdefs for their handlers.  These memory/CPU
> #ifdefs avoid unused function warnings when their Kconfig option
> is off.
>
> Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  b/mm/migrate.c |   46 +++++++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff -puN mm/migrate.c~add-cpu-hotplug-config mm/migrate.c
> --- a/mm/migrate.c~add-cpu-hotplug-config       2021-09-16 16:14:01.770140593 -0700
> +++ b/mm/migrate.c      2021-09-17 11:30:19.197027668 -0700
> @@ -3066,7 +3066,7 @@ void migrate_vma_finalize(struct migrate
>  EXPORT_SYMBOL(migrate_vma_finalize);
>  #endif /* CONFIG_DEVICE_PRIVATE */
>
> -#if defined(CONFIG_MEMORY_HOTPLUG)
> +#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_HOTPLUG_CPU)
>  /* Disable reclaim-based migration. */
>  static void __disable_all_migrate_targets(void)
>  {
> @@ -3248,25 +3248,7 @@ static void set_migration_target_nodes(v
>         put_online_mems();
>  }
>
> -/*
> - * React to hotplug events that might affect the migration targets
> - * like events that online or offline NUMA nodes.
> - *
> - * The ordering is also currently dependent on which nodes have
> - * CPUs.  That means we need CPU on/offline notification too.
> - */
> -static int migration_online_cpu(unsigned int cpu)
> -{
> -       set_migration_target_nodes();
> -       return 0;
> -}
> -
> -static int migration_offline_cpu(unsigned int cpu)
> -{
> -       set_migration_target_nodes();
> -       return 0;
> -}
> -
> +#if defined(CONFIG_MEMORY_HOTPLUG)
>  /*
>   * This leaves migrate-on-reclaim transiently disabled between
>   * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
> @@ -3313,6 +3295,27 @@ static int __meminit migrate_on_reclaim_
>
>         return notifier_from_errno(0);
>  }
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +/*
> + * React to hotplug events that might affect the migration targets
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
>
>  static int __init migrate_on_reclaim_init(void)
>  {
> @@ -3333,4 +3336,5 @@ static int __init migrate_on_reclaim_ini
>         return 0;
>  }
>  late_initcall(migrate_on_reclaim_init);
> -#endif /* CONFIG_MEMORY_HOTPLUG */
> +#endif /* CONFIG_HOTPLUG_CPU */
> +#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_HOTPLUG_CPU */
> _
