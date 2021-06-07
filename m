Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7318D39D848
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFGJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:09:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:37687 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGJJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:09:06 -0400
IronPort-SDR: Im1ncTXOQEb+4zT+eS4t40wvA3fjo/n5ppbvwT5nXlrmc3yTAnkDe9z8mfj0kOibrd539VerOT
 0ojzufQZ/wOg==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="290214597"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="290214597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:07:14 -0700
IronPort-SDR: fWtBuoMT2YmpRsiDp/3t1jD9RY33zkoIdNpPXtYnedhKZ+PSkv8UFgK6TrLqDQNNISH2mH1RWj
 XdJwPvFNpDtQ==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="401623618"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:07:11 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqBDw-000DL0-SU; Mon, 07 Jun 2021 12:07:08 +0300
Date:   Mon, 7 Jun 2021 12:07:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, akpm@linux-foundation.org,
        yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] misc/pvpanic: Remove some dead-code
Message-ID: <YL3hvMW3d2cd8IT1@smile.fi.intel.com>
References: <8e425618f4042a8ab8366be4d34026972e77bd40.1622911768.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e425618f4042a8ab8366be4d34026972e77bd40.1622911768.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 06:53:47PM +0200, Christophe JAILLET wrote:
> 'pvpanic_remove()' is referenced only by a 'devm_add_action_or_reset()'
> call in 'devm_pvpanic_probe()'. So, we know that its parameter is non-NULL.
> 
> Axe the unneeded check to save a few lines of code.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/misc/pvpanic/pvpanic.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 82770a088d62..02b807c788c9 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -66,9 +66,6 @@ static void pvpanic_remove(void *param)
>  	struct pvpanic_instance *pi_cur, *pi_next;
>  	struct pvpanic_instance *pi = param;
>  
> -	if (!pi)
> -		return;
> -
>  	spin_lock(&pvpanic_lock);
>  	list_for_each_entry_safe(pi_cur, pi_next, &pvpanic_list, list) {
>  		if (pi_cur == pi) {
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


