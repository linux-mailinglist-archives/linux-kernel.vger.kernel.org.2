Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330B33B3C61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhFYFzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhFYFzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624600404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42YjOqbIy9DlhDO/iMrmfgYXOpw7YyaWJVvHtjTwroY=;
        b=iJY0flUQF+LTRn5fh9KHDToYf3l4eIuts7pXkWpOtYbVXzoxfu0Z0bcRsgUiIEqVjAIaZZ
        RaRzreDpHwf5+1sH6sF1QeybBIGMGGyG3pHZFGYFl7fd78k+PH1hur3fPwRj7ukJKGEuwy
        4M+4BxX+SJW4s/OhDi844X8krTvZFaw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-Q3FSaUNPMO6TZY4Lid6WIQ-1; Fri, 25 Jun 2021 01:53:20 -0400
X-MC-Unique: Q3FSaUNPMO6TZY4Lid6WIQ-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so3730229wmj.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=42YjOqbIy9DlhDO/iMrmfgYXOpw7YyaWJVvHtjTwroY=;
        b=Kzzjv4ZCViBPst7noQ6sueUbRAJuK+0Rt77j7DCtKf7EwySh3G/fCpO9hzzhMvacxE
         UUnmV/djt+ogujbx5uanRTI1mRKyhvX4xIIIMhe3cqCUnDXQVAeqDhdar4taFxjFoYzw
         qWrWEmCLIQjtQ8yk0PXCh7Ew0y9IF4Oilq77TjlbigcEXwkYRybVHmPG4xMy6Jo0wXiL
         eMEOP5xexGNPuJX8uIUkODcH705MI3Kl+fmSOtJ13jreG+Yi044HVDmOLEinTvXUm6gT
         qZ6D3NghwhTqRQTAjJWIjQlneI2uQ+vReI6t8Oc9BxPwJ+zb5REOQabSDxvpgvvyTlAY
         HGpQ==
X-Gm-Message-State: AOAM533rBbvtlBXhocQbKhyPlu3MbHEbVM0L6Ur7PE4d9o5rCTPkSMJc
        H6MiCyp1f44sBuN4cOMb8DM+D5fIxsXmYbh4ssPzjj3TNHzsaxAUHuQyu1pYBVZtt2n+/f0CXlF
        OF3Rh8kNt2JII8U6Pyzmrmrm1
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr8281435wmm.108.1624600398993;
        Thu, 24 Jun 2021 22:53:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcUHFPpvQ43FOWnrf0yQ88HiSNzzAPe6FNjsxlny7a3arjXm7gb+2d0KpRQeI2D2XiGqHyMg==
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr8281417wmm.108.1624600398838;
        Thu, 24 Jun 2021 22:53:18 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
        by smtp.gmail.com with ESMTPSA id x18sm5070450wrw.19.2021.06.24.22.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 22:53:18 -0700 (PDT)
Date:   Fri, 25 Jun 2021 01:53:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.duyck@gmail.com, david@redhat.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v4 2/4] mm/page_reporting: Export reporting order as
 module parameter
Message-ID: <20210625014928-mutt-send-email-mst@kernel.org>
References: <20210625014710.42954-1-gshan@redhat.com>
 <20210625014710.42954-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625014710.42954-3-gshan@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:47:08AM +0800, Gavin Shan wrote:
> The macro PAGE_REPORTING_MIN_ORDER is defined as the page reporting
> threshold. It can't be adjusted at runtime.
> 
> This introduces a variable (@page_reporting_order) to replace the
> marcro (PAGE_REPORTING_MIN_ORDER). MAX_ORDER is assigned to it initially,
> meaning the page reporting is disabled. It will be specified by driver
> if valid one is provided. Otherwise, it will fall back to @pageblock_order.
> It's also exported so that the page reporting order can be adjusted at
> runtime.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  mm/page_reporting.c                             | 9 +++++++--
>  mm/page_reporting.h                             | 5 ++---
>  3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb89dbdedc46..566c4b9af3cd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3566,6 +3566,12 @@
>  			off: turn off poisoning (default)
>  			on: turn on poisoning
>  
> +	page_reporting.page_reporting_order=
> +			[KNL] Minimal page reporting order
> +			Format: <integer>
> +			Adjust the minimal page reporting order. The page
> +			reporting is disabled when it exceeds (MAX_ORDER-1).

Which the admin knows how? Run grep in the kernel source?

> +
>  	panic=		[KNL] Kernel behaviour on panic: delay <timeout>
>  			timeout > 0: seconds before rebooting
>  			timeout = 0: wait forever
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index df9c5054e1b4..34bf4d26c2c4 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -4,12 +4,17 @@
>  #include <linux/page_reporting.h>
>  #include <linux/gfp.h>
>  #include <linux/export.h>
> +#include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/scatterlist.h>
>  
>  #include "page_reporting.h"
>  #include "internal.h"
>  
> +unsigned int page_reporting_order = MAX_ORDER;
> +module_param(page_reporting_order, uint, 0644);
> +MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
> +
>  #define PAGE_REPORTING_DELAY	(2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>  
> @@ -229,7 +234,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>  
>  	/* Generate minimum watermark to be able to guarantee progress */
>  	watermark = low_wmark_pages(zone) +
> -		    (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
> +		    (PAGE_REPORTING_CAPACITY << page_reporting_order);


Looks like this makes it easy to trigger undefined behaviour. Just use
any value > 31.

>  
>  	/*
>  	 * Cancel request if insufficient free memory or if we failed
> @@ -239,7 +244,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>  		return err;
>  
>  	/* Process each free list starting from lowest order/mt */
> -	for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
> +	for (order = page_reporting_order; order < MAX_ORDER; order++) {
>  		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
>  			/* We do not pull pages from the isolate free list */
>  			if (is_migrate_isolate(mt))
> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index 2c385dd4ddbd..c51dbc228b94 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -10,10 +10,9 @@
>  #include <linux/pgtable.h>
>  #include <linux/scatterlist.h>
>  
> -#define PAGE_REPORTING_MIN_ORDER	pageblock_order
> -
>  #ifdef CONFIG_PAGE_REPORTING
>  DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
> +extern unsigned int page_reporting_order;
>  void __page_reporting_notify(void);
>  
>  static inline bool page_reported(struct page *page)
> @@ -38,7 +37,7 @@ static inline void page_reporting_notify_free(unsigned int order)
>  		return;
>  
>  	/* Determine if we have crossed reporting threshold */
> -	if (order < PAGE_REPORTING_MIN_ORDER)
> +	if (order < page_reporting_order)
>  		return;
>  
>  	/* This will add a few cycles, but should be called infrequently */
> -- 
> 2.23.0

