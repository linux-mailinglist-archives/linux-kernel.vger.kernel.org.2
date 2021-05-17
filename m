Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CCB38262A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhEQIDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:03:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:31206 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233996AbhEQIDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:03:14 -0400
IronPort-SDR: /dqYSnAAENTefNx/d7qpcvv/ydKWxWyTHS2GwRj9Cr6QE8ocPJscoB+JuzEX5eDmsZjFSG12sL
 pmFtByZw0H8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="221441607"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="221441607"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 01:01:33 -0700
IronPort-SDR: FgOX0IWDmyxGYjz2Ou+WxyBrPYO6+TWl+uC8XpXkWwZTAeJS6J2roLjeMZ9pJ8x6ViFAdKv0KV
 2wHLlYByVnew==
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="403962831"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 01:01:29 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1liYBq-00Cgwp-Ao; Mon, 17 May 2021 11:01:26 +0300
Date:   Mon, 17 May 2021 11:01:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, pizhenwei@bytedance.com,
        pbonzini@redhat.com, linqiheng@huawei.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] misc/pvpanic: Fix error handling in
 'pvpanic_pci_probe()'
Message-ID: <YKIi1hljnjvqMCVA@smile.fi.intel.com>
References: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 04:36:55PM +0200, Christophe JAILLET wrote:
> There is no error handling path in the probe function.
> Switch to managed resource so that errors in the probe are handled easily
> and simplify the remove function accordingly.

Yes, that's what I suggested earlier to another contributor.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

P.S. You may consider the following things as well:
 1) converting to use pci_set_drvdata() / pci_get_drvdata()
 2) providing devm_pvpanic_probe() [via devm_add_action() /
    devm_add_action_or_reset()]

> Fixes: db3a4f0abefd ("misc/pvpanic: add PCI driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/misc/pvpanic/pvpanic-pci.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> index 9ecc4e8559d5..046ce4ecc195 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -78,15 +78,15 @@ static int pvpanic_pci_probe(struct pci_dev *pdev,
>  	void __iomem *base;
>  	int ret;
>  
> -	ret = pci_enable_device(pdev);
> +	ret = pcim_enable_device(pdev);
>  	if (ret < 0)
>  		return ret;
>  
> -	base = pci_iomap(pdev, 0, 0);
> +	base = pcim_iomap(pdev, 0, 0);
>  	if (!base)
>  		return -ENOMEM;
>  
> -	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
> +	pi = devm_kmalloc(&pdev->dev, sizeof(*pi), GFP_ATOMIC);
>  	if (!pi)
>  		return -ENOMEM;
>  
> @@ -107,9 +107,6 @@ static void pvpanic_pci_remove(struct pci_dev *pdev)
>  	struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
>  
>  	pvpanic_remove(pi);
> -	iounmap(pi->base);
> -	kfree(pi);
> -	pci_disable_device(pdev);
>  }
>  
>  static struct pci_driver pvpanic_pci_driver = {
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


