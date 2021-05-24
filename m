Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE1538E47C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhEXKry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:47:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:17601 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhEXKr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:47:26 -0400
IronPort-SDR: Y7odz+htvEmrRu4OHzO69y2ySb9FMlZL25KSDMym7++7jQdURAvvOms/SmpL4xXNo0LzTNU0DH
 4cqgL371lmHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198848349"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198848349"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:45:58 -0700
IronPort-SDR: JaGtdzHez43qZfIPsyzl2IBZn+wHzZjpRMNmQCxGH88p8V07+kJYkPWIKDWcZpcPZUG5fF8xe7
 LJ1/8TK3dB9Q==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="413542294"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:45:56 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ll85q-00EIZN-3O; Mon, 24 May 2021 13:45:54 +0300
Date:   Mon, 24 May 2021 13:45:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/dmapool: use DEVICE_ATTR_RO macro
Message-ID: <YKuD4rturdqC6oZF@smile.fi.intel.com>
References: <20210523064626.41532-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523064626.41532-1-yuehaibing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 02:46:26PM +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.

DEVICE_ATTR_RO()
DEVICE_ATTR()

After addressing above and below,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  mm/dmapool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index 16483f86360e..62083ef04878 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -62,8 +62,8 @@ struct dma_page {		/* cacheable header for 'allocation' bytes */
>  static DEFINE_MUTEX(pools_lock);
>  static DEFINE_MUTEX(pools_reg_lock);
>  
> -static ssize_t
> -show_pools(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t pools_show(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
>  {
>  	unsigned temp;
>  	unsigned size;

Unrelated change.

> @@ -103,7 +103,7 @@ show_pools(struct device *dev, struct device_attribute *attr, char *buf)
>  	return PAGE_SIZE - size;
>  }
>  
> -static DEVICE_ATTR(pools, 0444, show_pools, NULL);
> +static DEVICE_ATTR_RO(pools);
>  
>  /**
>   * dma_pool_create - Creates a pool of consistent memory blocks, for dma.
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


