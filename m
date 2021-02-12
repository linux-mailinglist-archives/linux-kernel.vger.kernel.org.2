Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0545131A3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhBLRqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:46:16 -0500
Received: from foss.arm.com ([217.140.110.172]:40580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBLRqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:46:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A89F41063;
        Fri, 12 Feb 2021 09:45:26 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C4233F73B;
        Fri, 12 Feb 2021 09:45:25 -0800 (PST)
Date:   Fri, 12 Feb 2021 17:45:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] NTB: Drop kfree for memory allocated with
 devm_kzalloc
Message-ID: <20210212174520.GA22934@e121166-lin.cambridge.arm.com>
References: <20210210075345.1096001-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210075345.1096001-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 07:53:45AM +0000, Wei Yongjun wrote:
> It's not necessary to free memory allocated with devm_kzalloc
> and using kfree leads to a double free.
> 
> Fixes: 363baf7d6051 ("NTB: Add support for EPF PCI-Express Non-Transparent Bridge")

Squashed it in the commit it is fixing and repushed pci/ntb out.

Thanks,
Lorenzo

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 2cccb7dff5dd..b019755e4e21 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -723,7 +723,6 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
>  	ntb_unregister_device(&ndev->ntb);
>  	ntb_epf_cleanup_isr(ndev);
>  	ntb_epf_deinit_pci(ndev);
> -	kfree(ndev);
>  }
>  
>  static const struct ntb_epf_data j721e_data = {
> 
