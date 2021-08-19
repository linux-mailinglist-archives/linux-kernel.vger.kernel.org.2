Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08843F1D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhHSPsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:48:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:17390 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235645AbhHSPsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:48:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203784125"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="203784125"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 08:47:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="679511206"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 08:47:28 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mGkGI-00BVRB-F2; Thu, 19 Aug 2021 18:47:22 +0300
Date:   Thu, 19 Aug 2021 18:47:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc/pvpanic: fix set driver data
Message-ID: <YR59CnAXhzECKF3s@smile.fi.intel.com>
References: <1629380481-4363-1-git-send-email-mihai.carabas@oracle.com>
 <1629380481-4363-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629380481-4363-2-git-send-email-mihai.carabas@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 04:41:21PM +0300, Mihai Carabas wrote:
> Add again dev_set_drvdata(), but this time in devm_pvpanic_probe(), in order
> for dev_get_drvdata() to not return NULL.

Thanks, almost good, after addressing below feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 394febc9d0a6 ("misc/pvpanic: Make 'pvpanic_probe()' resource managed")
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/misc/pvpanic/pvpanic.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 02b807c..6ce48ce 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -81,6 +81,8 @@ int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi)
>  	if (!pi || !pi->base)
>  		return -EINVAL;

> +	dev_set_drvdata(dev, pi);

I believe this should be last (or close enough) operation in the function for
the sake of logical flow.

>  	spin_lock(&pvpanic_lock);
>  	list_add(&pi->list, &pvpanic_list);
>  	spin_unlock(&pvpanic_lock);

-- 
With Best Regards,
Andy Shevchenko


