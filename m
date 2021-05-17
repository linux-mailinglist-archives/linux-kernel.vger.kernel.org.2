Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16901382E02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhEQNym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:54:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:31016 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232924AbhEQNyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:54:41 -0400
IronPort-SDR: qXPqx7Sv/l3I36W/eoRvdblrMHIbMXHbpfZNupcXGsoQMXUJNdY2oJoZAjPlFt8j6U29ZF5GkY
 RgWaDEFf8lOg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="264384046"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="264384046"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 06:53:24 -0700
IronPort-SDR: 5pnxCDbTih3gaHsg+ybzP3BT9YNLO6FSdqANCvbXQmQRVEqwwH6O38npkHsitHGnHfRExqItZ5
 gd//qcIihv/Q==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="438929130"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 06:53:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lidgP-00CkPc-8Z; Mon, 17 May 2021 16:53:21 +0300
Date:   Mon, 17 May 2021 16:53:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ferry Toth <ftoth@exalondelft.nl>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 1/1] extcon-intel-mrfld: initialize mrfld_extcon status
Message-ID: <YKJ1UUDpRSCDq/bV@smile.fi.intel.com>
References: <20210424174138.175889-1-ftoth@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424174138.175889-1-ftoth@exalondelft.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 07:41:38PM +0200, Ferry Toth wrote:
> extcon driver for Basin Cove PMIC shadows the switch status used for dwc3
> DRD to detect a change in the switch position. This change initializes the
> status at probe time.

Chanwoo, can we get this fix in?

> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 492929c54791 ("extcon: mrfld: Introduce extcon driver for Basin Cove PMIC")
> ---
>  drivers/extcon/extcon-intel-mrfld.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
> index f47016fb28a8..cd1a5f230077 100644
> --- a/drivers/extcon/extcon-intel-mrfld.c
> +++ b/drivers/extcon/extcon-intel-mrfld.c
> @@ -197,6 +197,7 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
>  	struct regmap *regmap = pmic->regmap;
>  	struct mrfld_extcon_data *data;
> +	unsigned int status;
>  	unsigned int id;
>  	int irq, ret;
>  
> @@ -244,6 +245,14 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
>  	/* Get initial state */
>  	mrfld_extcon_role_detect(data);
>  
> +	/*
> +	 * Cached status value is used for cable detection, see comments
> +	 * in mrfld_extcon_cable_detect(), we need to sync cached value
> +	 * with a real state of the hardware.
> +	 */
> +	regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
> +	data->status = status;
> +
>  	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
>  	mrfld_extcon_clear(data, BCOVE_MCHGRIRQ1, BCOVE_CHGRIRQ_ALL);
>  
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko


