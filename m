Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA638382583
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhEQHmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:42:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:39144 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235372AbhEQHmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:42:07 -0400
IronPort-SDR: xOtvbQFr+fQ7ysoF0Qyr0/UjqYfma1O+DgvEFFFgEfpKvvdliRDV7SyBoSS3TTCsLaJYegWOOJ
 87Xx0X2YxC6w==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="264325837"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="264325837"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 00:40:21 -0700
IronPort-SDR: dAdRdi1OZ5hYiaAOKuAJ+aXMdn8EvNAmqlwk8yOthuSmQObcW+7vxdJWYeB+ExP3s5BHlOQQZY
 uiPmqDz6lwUA==
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="403951583"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 00:40:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1liXrI-00CgkM-82; Mon, 17 May 2021 10:40:12 +0300
Date:   Mon, 17 May 2021 10:40:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, pizhenwei@bytedance.com,
        pbonzini@redhat.com, bobo.shaobowang@huawei.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] misc/pvpanic: Fix error handling in
 'pvpanic_mmio_probe()'
Message-ID: <YKId3AuQgQiQFY/q@smile.fi.intel.com>
References: <d6e7bf6eb6e482c387124e815edc0e0edaebafe8.1621177126.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e7bf6eb6e482c387124e815edc0e0edaebafe8.1621177126.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 05:00:27PM +0200, Christophe JAILLET wrote:
> There is no error handling path in the probe function.
> Switch to managed resource so that errors in the probe are handled easily
> and simplify the remove function accordingly.

Either folded or separated, feel free to add to the result
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: b3c0f8774668 ("misc/pvpanic: probe multiple instances")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/misc/pvpanic/pvpanic-mmio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
> index 4c0841776087..69b31f7adf4f 100644
> --- a/drivers/misc/pvpanic/pvpanic-mmio.c
> +++ b/drivers/misc/pvpanic/pvpanic-mmio.c
> @@ -93,7 +93,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
> +	pi = devm_kmalloc(dev, sizeof(*pi), GFP_ATOMIC);
>  	if (!pi)
>  		return -ENOMEM;
>  
> @@ -114,7 +114,6 @@ static int pvpanic_mmio_remove(struct platform_device *pdev)
>  	struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
>  
>  	pvpanic_remove(pi);
> -	kfree(pi);
>  
>  	return 0;
>  }
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


