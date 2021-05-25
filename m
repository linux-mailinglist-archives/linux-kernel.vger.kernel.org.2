Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF21538FE46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhEYJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:57:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5551 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhEYJ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:57:22 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fq8XD2SKlzwTbK;
        Tue, 25 May 2021 17:53:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 17:55:50 +0800
Received: from localhost (10.52.120.147) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 10:55:48 +0100
Date:   Tue, 25 May 2021 10:54:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] cxl/mem: Reserve all device regions at once
Message-ID: <20210525105400.000001fd@Huawei.com>
In-Reply-To: <20210522001154.2680157-3-ira.weiny@intel.com>
References: <20210522001154.2680157-1-ira.weiny@intel.com>
        <20210522001154.2680157-3-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.147]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 17:11:51 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> In order to remap individual register sets each bar region must be
> reserved prior to mapping.  Because the details of individual register
> sets are contained within the BARs themselves, the bar must be mapped 2
> times, once to extract this information and a second time for each
> register set.
> 
> Rather than attempt to reserve each BAR individually and track if that
> bar has been reserved.  Open code pcim_iomap_regions() by first
> reserving all memory regions on the device and then mapping the bars
> individually as needed.
> 
> NOTE pci_request_mem_regions() does not need a corresponding
> pci_release_mem_regions() because the pci device is managed via
> pcim_enable_device().
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes for V2:
> 	Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=pending
> 	Clarify why pci_release_mem_regions() does not need to be
> 	called.

Gah - I'm never keen on hidden automated cleanup.  Oh well.

> 	Adjust for the different return code between pcim_iomap_regions() and
> 	pcim_iomap()
> 	Change print specifier.
> ---
>  drivers/cxl/pci.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b2f978954daa..33fc6e1634e3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -927,7 +927,7 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
>  {
>  	struct pci_dev *pdev = cxlm->pdev;
>  	struct device *dev = &pdev->dev;
> -	int rc;
> +	void __iomem *addr;
>  
>  	/* Basic sanity check that BAR is big enough */
>  	if (pci_resource_len(pdev, bar) < offset) {
> @@ -936,13 +936,14 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
>  		return IOMEM_ERR_PTR(-ENXIO);
>  	}
>  
> -	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> -	if (rc) {
> +	addr = pcim_iomap(pdev, bar, 0);
> +	if (!addr) {
>  		dev_err(dev, "failed to map registers\n");
> -		return IOMEM_ERR_PTR(rc);
> +		return addr;
>  	}
>  
> -	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> +	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
> +		bar, offset);
>  
>  	return pcim_iomap_table(pdev)[bar] + offset;
>  }
> @@ -1003,6 +1004,9 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		return -ENXIO;
>  	}
>  
> +	if (pci_request_mem_regions(pdev, pci_name(pdev)))
> +		return -ENODEV;
> +
>  	/* Get the size of the Register Locator DVSEC */
>  	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>  	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> @@ -1028,8 +1032,8 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  
>  		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
>  			base = cxl_mem_map_regblock(cxlm, bar, offset);
> -			if (IS_ERR(base))
> -				return PTR_ERR(base);
> +			if (!base)
> +				return -ENOMEM;
>  			break;
>  		}
>  	}

