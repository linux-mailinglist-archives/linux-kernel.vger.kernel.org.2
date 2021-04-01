Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9104C352059
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhDAUGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhDAUGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:06:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA8CC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 13:06:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b7so4659723ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5FgskCBgp4mYNMsW4JO+VcIW0/eiYLcwbqkkWuoz1o=;
        b=VR9rdV+dZtbtNdZi+t7HB7jIHlB6jGzShQeEsDb84EsEBYYfW+qnmLVXvQQIZkSWD6
         VPRTbyWKemmh/hOHgXnqqOAU+dDYdqCSxX2CkAIoDFnF2JT8XBseONmXJUC+pRx9u7kC
         Y4FbiTcJwwdpB9CRpfpmu9yhupsnCFxsZv1+jqmUF3vj176dGQp2o7gBfUUBFF5MOR8l
         Q0nKRp9ZFvYkIYzNp2Fdfovdd0ExxK6z+xmpRtrbFa7NCK4jA9V2U3QzdzFHrR7CoXQT
         bChDcJJADEh1onUweHesT6SnBjH4/TQwGpTVCANRt/D+5MualskepxrMn7vSj+cNn/pt
         NE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5FgskCBgp4mYNMsW4JO+VcIW0/eiYLcwbqkkWuoz1o=;
        b=N57kCEY0ycxen2ezdhD1aJAo8nEzm3fEbF7UtdAWS9VrusVL4Umv7imLmhNO173Ioe
         2HDFYf7HD3Ozva8udAKdaIu09+5h0/D5R6aHPAIUzieA/+e/f7yQ95exLzhTs/wpmzGB
         E/OaCDHIatbOKeMiA9E2yQSerLalOHYoYogj/TEt/cmohtmaIeCW683ZXp+FY6fQ2Qoz
         k360Cnb6sHSgZQdFCfrrnGi+dXFmOYz8hmX1lyqn9Dcie/e5g3YE8ex7XKdgYEAtkAef
         67wU2GCaum0d8p9sTN7gdeMvrxgPDEYKne1hwL1IPjvCPL7wu8Jh4DGSg5r53YzWCe/5
         35KQ==
X-Gm-Message-State: AOAM532mDIKuWAV9QXupzHjX/HTNegkblKGxEGVZO2VvuMRHE/jaxqO3
        gsIdsOsE8nTivKnKRSbxdIkTWPmSv1ZKPJjou3Y=
X-Google-Smtp-Source: ABdhPJw1cweuziLtv/UH9L+Hjp146uOcfObrlPQGwV1dUwYQeFuQvXUBmPLl90qcZqsPi0V8EDbqD/v4uSTh3H+5Jfg=
X-Received: by 2002:a17:906:4bce:: with SMTP id x14mr10681523ejv.383.1617307599465;
 Thu, 01 Apr 2021 13:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183235.BCC49E8B@viggo.jf.intel.com>
In-Reply-To: <20210401183235.BCC49E8B@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Apr 2021 13:06:27 -0700
Message-ID: <CAHbLzkpbua9BM+sMng3d3Fxo+61HVNEegviTLqtVVtxtjjbsCQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] mm/migrate: new zone_reclaim_mode to enable reclaim migration
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        weixugc@google.com, Yang Shi <yang.shi@linux.alibaba.com>,
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
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Some method is obviously needed to enable reclaim-based migration.
>
> Just like traditional autonuma, there will be some workloads that
> will benefit like workloads with more "static" configurations where
> hot pages stay hot and cold pages stay cold.  If pages come and go
> from the hot and cold sets, the benefits of this approach will be
> more limited.
>
> The benefits are truly workload-based and *not* hardware-based.
> We do not believe that there is a viable threshold where certain
> hardware configurations should have this mechanism enabled while
> others do not.
>
> To be conservative, earlier work defaulted to disable reclaim-
> based migration and did not include a mechanism to enable it.
> This proposes extending the existing "zone_reclaim_mode" (now
> now really node_reclaim_mode) as a method to enable it.
>
> We are open to any alternative that allows end users to enable
> this mechanism or disable it it workload harm is detected (just
> like traditional autonuma).
>
> Once this is enabled page demotion may move data to a NUMA node
> that does not fall into the cpuset of the allocating process.
> This could be construed to violate the guarantees of cpusets.
> However, since this is an opt-in mechanism, the assumption is
> that anyone enabling it is content to relax the guarantees.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
>
> Changes since 20200122:
>  * Changelog material about relaxing cpuset constraints
>
> Changes since 20210304:
>  * Add Documentation/ material about relaxing cpuset constraints

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>
>  b/Documentation/admin-guide/sysctl/vm.rst |   12 ++++++++++++
>  b/include/linux/swap.h                    |    3 ++-
>  b/include/uapi/linux/mempolicy.h          |    1 +
>  b/mm/vmscan.c                             |    6 ++++--
>  4 files changed, 19 insertions(+), 3 deletions(-)
>
> diff -puN Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE Documentation/admin-guide/sysctl/vm.rst
> --- a/Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE   2021-03-31 15:17:40.324000190 -0700
> +++ b/Documentation/admin-guide/sysctl/vm.rst   2021-03-31 15:17:40.349000190 -0700
> @@ -976,6 +976,7 @@ This is value OR'ed together of
>  1      Zone reclaim on
>  2      Zone reclaim writes dirty pages out
>  4      Zone reclaim swaps pages
> +8      Zone reclaim migrates pages
>  =      ===================================
>
>  zone_reclaim_mode is disabled by default.  For file servers or workloads
> @@ -1000,3 +1001,14 @@ of other processes running on other node
>  Allowing regular swap effectively restricts allocations to the local
>  node unless explicitly overridden by memory policies or cpuset
>  configurations.
> +
> +Page migration during reclaim is intended for systems with tiered memory
> +configurations.  These systems have multiple types of memory with varied
> +performance characteristics instead of plain NUMA systems where the same
> +kind of memory is found at varied distances.  Allowing page migration
> +during reclaim enables these systems to migrate pages from fast tiers to
> +slow tiers when the fast tier is under pressure.  This migration is
> +performed before swap.  It may move data to a NUMA node that does not
> +fall into the cpuset of the allocating process which might be construed
> +to violate the guarantees of cpusets.  This should not be enabled on
> +systems which need strict cpuset location guarantees.
> diff -puN include/linux/swap.h~RECLAIM_MIGRATE include/linux/swap.h
> --- a/include/linux/swap.h~RECLAIM_MIGRATE      2021-03-31 15:17:40.331000190 -0700
> +++ b/include/linux/swap.h      2021-03-31 15:17:40.351000190 -0700
> @@ -382,7 +382,8 @@ extern int sysctl_min_slab_ratio;
>  static inline bool node_reclaim_enabled(void)
>  {
>         /* Is any node_reclaim_mode bit set? */
> -       return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
> +       return node_reclaim_mode & (RECLAIM_ZONE |RECLAIM_WRITE|
> +                                   RECLAIM_UNMAP|RECLAIM_MIGRATE);
>  }
>
>  extern void check_move_unevictable_pages(struct pagevec *pvec);
> diff -puN include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE include/uapi/linux/mempolicy.h
> --- a/include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE    2021-03-31 15:17:40.337000190 -0700
> +++ b/include/uapi/linux/mempolicy.h    2021-03-31 15:17:40.352000190 -0700
> @@ -71,5 +71,6 @@ enum {
>  #define RECLAIM_ZONE   (1<<0)  /* Run shrink_inactive_list on the zone */
>  #define RECLAIM_WRITE  (1<<1)  /* Writeout pages during reclaim */
>  #define RECLAIM_UNMAP  (1<<2)  /* Unmap pages during reclaim */
> +#define RECLAIM_MIGRATE        (1<<3)  /* Migrate to other nodes during reclaim */
>
>  #endif /* _UAPI_LINUX_MEMPOLICY_H */
> diff -puN mm/vmscan.c~RECLAIM_MIGRATE mm/vmscan.c
> --- a/mm/vmscan.c~RECLAIM_MIGRATE       2021-03-31 15:17:40.339000190 -0700
> +++ b/mm/vmscan.c       2021-03-31 15:17:40.357000190 -0700
> @@ -1074,6 +1074,9 @@ static bool migrate_demote_page_ok(struc
>         VM_BUG_ON_PAGE(PageHuge(page), page);
>         VM_BUG_ON_PAGE(PageLRU(page), page);
>
> +       if (!(node_reclaim_mode & RECLAIM_MIGRATE))
> +               return false;
> +
>         /* It is pointless to do demotion in memcg reclaim */
>         if (cgroup_reclaim(sc))
>                 return false;
> @@ -1083,8 +1086,7 @@ static bool migrate_demote_page_ok(struc
>         if (PageTransHuge(page) && !thp_migration_supported())
>                 return false;
>
> -       // FIXME: actually enable this later in the series
> -       return false;
> +       return true;
>  }
>
>  /* Check if a page is dirty or under writeback */
> _
>
