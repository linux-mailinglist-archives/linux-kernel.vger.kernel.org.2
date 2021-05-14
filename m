Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709BF380406
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhENHJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232897AbhENHJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 899E761354;
        Fri, 14 May 2021 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620976090;
        bh=e5/9R5jIX60oWrB142AU3f1OLRTtCpmN7NsFzFxnRts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGSq0YJBbgpsJfs97LaEt5pCjMUd7LLmEzCYM0y9CGssS3JqeoAPkFYHKFkLs7tew
         0zh27mH+R15ZK4CAK/izDwRkrL8AqEuVXsj2b6irdssxzdciUTCRnAUTWTfW/cGqqc
         FHE9SNHiq5YLDYw2pCjGtVbd2A6cBKxxJzzQxySM=
Date:   Fri, 14 May 2021 09:08:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        zhenwei pi <pizhenwei@bytedance.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] misc/pvpanic: add missing MODULE_DEVICE_TABLE
Message-ID: <YJ4h16jjImjvqAKx@kroah.com>
References: <20210514070103.540-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514070103.540-1-linqiheng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 03:01:03PM +0800, Qiheng Lin wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
> ---
>  drivers/misc/pvpanic/pvpanic-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> index 9ecc4e8559d5..ccd7e32d3f55 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -26,6 +26,7 @@ static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC)},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
>  
>  static ssize_t capability_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
> 

As I have said before, unless you have a user that reports a real
problem with these types of modules not automatically loading, I am not
going to take these patches, and you should probably stop generating
them.

thanks,

greg k-h
