Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D530545AE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhKWV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhKWV2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:28:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCB2E60E0B;
        Tue, 23 Nov 2021 21:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637702711;
        bh=qbvAP9FEgnrCIjTIXsp/tmPWIt0MQ0Xlnn794203bys=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cPd4cv7SryyQd8LTmLauUibsHQ5D8afBo8uXkhfOYPOgrgvySkD774taLKN48DNXe
         W6e3jzyS3F9HP3Vwr4fcVrY+vdkotS6q6XGdp4IFbEvFfWMi8+I+E0f5i3iTo6Et9D
         RNAyk6dVRDQxVUd/oV0muVrutlyRiPRzbbgRRdD0pnVObQCHOiI9AyfxMTW+QU+dUd
         VUBhKB5aEbpY6IZQIb8PhmUQ1tnRFhNCpiXdqc0Wm/rRPc/YMwxcFkCv3xBpOLg7L0
         8E17AtMBB1mBB+tETB8KrjOBM+wsXDbC9yE0z7P67gZsGcQXIVyELSakyuVNlln3jw
         wLDADqvF058zQ==
Date:   Tue, 23 Nov 2021 13:25:09 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr <olekstysh@gmail.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>
Subject: Re: [PATCH V2 3/4] xen/unpopulated-alloc: Add mechanism to use Xen
 resource
In-Reply-To: <76163855-c5eb-05db-2f39-3c6bfee46345@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111231312310.1412361@ubuntu-linux-20-04-desktop>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com> <1635264312-3796-4-git-send-email-olekstysh@gmail.com> <alpine.DEB.2.21.2110280920110.20134@sstabellini-ThinkPad-T480s> <1d122e60-df9c-2ac6-8148-f6a836b9e51d@gmail.com>
 <alpine.DEB.2.22.394.2111181642340.1412361@ubuntu-linux-20-04-desktop> <f1f1025b-911d-3d27-f408-9c042bc4fca4@gmail.com> <alpine.DEB.2.22.394.2111191809100.1412361@ubuntu-linux-20-04-desktop> <76163855-c5eb-05db-2f39-3c6bfee46345@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1418725751-1637702267=:1412361"
Content-ID: <alpine.DEB.2.22.394.2111231325040.1412361@ubuntu-linux-20-04-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1418725751-1637702267=:1412361
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2111231325041.1412361@ubuntu-linux-20-04-desktop>

On Tue, 23 Nov 2021, Oleksandr wrote:
> > Actually after reading your replies and explanation I changed opinion: I
> > think we do need the fallback because Linux cannot really assume that
> > it is running on "new Xen" so it definitely needs to keep working if
> > CONFIG_XEN_UNPOPULATED_ALLOC is enabled and the extended regions are not
> > advertised.
> > 
> > I think we'll have to roll back some of the changes introduced by
> > 121f2faca2c0a. That's because even if CONFIG_XEN_UNPOPULATED_ALLOC is
> > enabled we cannot know if we can use unpopulated-alloc or whether we
> > have to use alloc_xenballooned_pages until we parse the /hypervisor node
> > in device tree at runtime.
> 
> Exactly!
> 
> 
> > 
> > In short, we cannot switch between unpopulated-alloc and
> > alloc_xenballooned_pages at build time, we have to do it at runtime
> > (boot time).
> 
> +1
> 
> 
> I created a patch to partially revert 121f2faca2c0a "xen/balloon: rename
> alloc/free_xenballooned_pages".
> 
> If there is no objections I will add it to V3 (which is almost ready, except
> the fallback bits). Could you please tell me what do you think?
 
It makes sense to me. You can add my Reviewed-by.

 
> From dc79bcd425358596d95e715a8bd8b81deaaeb703 Mon Sep 17 00:00:00 2001
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Date: Tue, 23 Nov 2021 18:14:41 +0200
> Subject: [PATCH] xen/balloon: Bring alloc(free)_xenballooned_pages helpers
>  back
> 
> This patch rolls back some of the changes introduced by commit
> 121f2faca2c0a "xen/balloon: rename alloc/free_xenballooned_pages"
> in order to make possible to still allocate xenballooned pages
> if CONFIG_XEN_UNPOPULATED_ALLOC is enabled.
> 
> On Arm the unpopulated pages will be allocated on top of extended
> regions provided by Xen via device-tree (the subsequent patches
> will add required bits to support unpopulated-alloc feature on Arm).
> The problem is that extended regions feature has been introduced
> into Xen quite recently (during 4.16 release cycle). So this
> effectively means that Linux must only use unpopulated-alloc on Arm
> if it is running on "new Xen" which advertises these regions.
> But, it will only be known after parsing the "hypervisor" node
> at boot time, so before doing that we cannot assume anything.
> 
> In order to keep working if CONFIG_XEN_UNPOPULATED_ALLOC is enabled
> and the extended regions are not advertised (Linux is running on
> "old Xen", etc) we need the fallback to alloc_xenballooned_pages().
> 
> This way we wouldn't reduce the amount of memory usable (wasting
> RAM pages) for any of the external mappings anymore (and eliminate
> XSA-300) with "new Xen", but would be still functional ballooning
> out RAM pages with "old Xen".
> 
> Also rename alloc(free)_xenballooned_pages to xen_alloc(free)_ballooned_pages.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
>  drivers/xen/balloon.c | 20 +++++++++-----------
>  include/xen/balloon.h |  3 +++
>  include/xen/xen.h     |  6 ++++++
>  3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index ba2ea11..a2c4fc49 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -581,7 +581,6 @@ void balloon_set_new_target(unsigned long target)
>  }
>  EXPORT_SYMBOL_GPL(balloon_set_new_target);
> 
> -#ifndef CONFIG_XEN_UNPOPULATED_ALLOC
>  static int add_ballooned_pages(unsigned int nr_pages)
>  {
>      enum bp_state st;
> @@ -610,12 +609,12 @@ static int add_ballooned_pages(unsigned int nr_pages)
>  }
> 
>  /**
> - * xen_alloc_unpopulated_pages - get pages that have been ballooned out
> + * xen_alloc_ballooned_pages - get pages that have been ballooned out
>   * @nr_pages: Number of pages to get
>   * @pages: pages returned
>   * @return 0 on success, error otherwise
>   */
> -int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
> +int xen_alloc_ballooned_pages(unsigned int nr_pages, struct page **pages)
>  {
>      unsigned int pgno = 0;
>      struct page *page;
> @@ -652,23 +651,23 @@ int xen_alloc_unpopulated_pages(unsigned int nr_pages,
> struct page **pages)
>      return 0;
>   out_undo:
>      mutex_unlock(&balloon_mutex);
> -    xen_free_unpopulated_pages(pgno, pages);
> +    xen_free_ballooned_pages(pgno, pages);
>      /*
> -     * NB: free_xenballooned_pages will only subtract pgno pages, but since
> +     * NB: xen_free_ballooned_pages will only subtract pgno pages, but since
>       * target_unpopulated is incremented with nr_pages at the start we need
>       * to remove the remaining ones also, or accounting will be screwed.
>       */
>      balloon_stats.target_unpopulated -= nr_pages - pgno;
>      return ret;
>  }
> -EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
> +EXPORT_SYMBOL(xen_alloc_ballooned_pages);
> 
>  /**
> - * xen_free_unpopulated_pages - return pages retrieved with
> get_ballooned_pages
> + * xen_free_ballooned_pages - return pages retrieved with get_ballooned_pages
>   * @nr_pages: Number of pages
>   * @pages: pages to return
>   */
> -void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
> +void xen_free_ballooned_pages(unsigned int nr_pages, struct page **pages)
>  {
>      unsigned int i;
> 
> @@ -687,9 +686,9 @@ void xen_free_unpopulated_pages(unsigned int nr_pages,
> struct page **pages)
> 
>      mutex_unlock(&balloon_mutex);
>  }
> -EXPORT_SYMBOL(xen_free_unpopulated_pages);
> +EXPORT_SYMBOL(xen_free_ballooned_pages);
> 
> -#if defined(CONFIG_XEN_PV)
> +#if defined(CONFIG_XEN_PV) && !defined(CONFIG_XEN_UNPOPULATED_ALLOC)
>  static void __init balloon_add_region(unsigned long start_pfn,
>                        unsigned long pages)
>  {
> @@ -712,7 +711,6 @@ static void __init balloon_add_region(unsigned long
> start_pfn,
>      balloon_stats.total_pages += extra_pfn_end - start_pfn;
>  }
>  #endif
> -#endif
> 
>  static int __init balloon_init(void)
>  {
> diff --git a/include/xen/balloon.h b/include/xen/balloon.h
> index e93d4f0..f78a6cc 100644
> --- a/include/xen/balloon.h
> +++ b/include/xen/balloon.h
> @@ -26,6 +26,9 @@ extern struct balloon_stats balloon_stats;
> 
>  void balloon_set_new_target(unsigned long target);
> 
> +int xen_alloc_ballooned_pages(unsigned int nr_pages, struct page **pages);
> +void xen_free_ballooned_pages(unsigned int nr_pages, struct page **pages);
> +
>  #ifdef CONFIG_XEN_BALLOON
>  void xen_balloon_init(void);
>  #else
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 9f031b5..410e3e4 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -52,7 +52,13 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>  extern u64 xen_saved_max_mem_size;
>  #endif
> 
> +#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>  int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>  void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
> +#else
> +#define xen_alloc_unpopulated_pages xen_alloc_ballooned_pages
> +#define xen_free_unpopulated_pages xen_free_ballooned_pages
> +#include <xen/balloon.h>
> +#endif
> 
>  #endif    /* _XEN_XEN_H */
--8323329-1418725751-1637702267=:1412361--
