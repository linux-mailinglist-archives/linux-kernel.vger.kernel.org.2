Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7809F413607
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhIUPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhIUPV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:21:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3796061165;
        Tue, 21 Sep 2021 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632237627;
        bh=K9tYO1jmVq2LUM2bQC5dB72wuyvipiHa1/0bEGbnbeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDgsRlqSJmx87Wse4Be605BDRIx/qd8rceFANqA4PyYAEOB41sP34BA+uYPin5rVI
         CqJTHOZddviC44yWDJIVEHlHFQ2QkGPOKz+P0vjs7yzXsQCkNq+sc2mP8ZiJH2DZ70
         GI9qVa0FEYpXhTgQYn6S98sMdzp1ZsQxB42Yati8=
Date:   Tue, 21 Sep 2021 17:20:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     andraprs@amazon.com, lexnv@amazon.com, alcioa@amazon.com,
        linux-kernel@vger.kernel.org, arei.gonglei@huawei.com,
        kamal@canonical.com, pbonzini@redhat.com, sgarzare@redhat.com,
        stefanha@redhat.com, vkuznets@redhat.com,
        ne-devel-upstream@amazon.com
Subject: Re: [PATCH v2 1/4] nitro_enclaves: merge contiguous physical memory
 regions
Message-ID: <YUn4N4kWe8mBUVUR@kroah.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-2-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921151039.1502-2-longpeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:10:36PM +0800, Longpeng(Mike) wrote:
> There can be cases when there are more memory regions that need to be
> set for an enclave than the maximum supported number of memory regions
> per enclave. One example can be when the memory regions are backed by 2
> MiB hugepages (the minimum supported hugepage size).
> 
> Let's merge the adjacent regions if they are physical contiguous. This
> way the final number of memory regions is less than before merging and
> could potentially avoid reaching maximum.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

I need a real (i.e. legal) name for a signed-off-by line please.

> ---
>  drivers/virt/nitro_enclaves/ne_misc_dev.c | 87 ++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
> index e21e1e8..a4776fc 100644
> --- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
> +++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
> @@ -126,6 +126,26 @@ struct ne_cpu_pool {
>  static struct ne_cpu_pool ne_cpu_pool;
>  
>  /**
> + * struct phys_mem_region - Physical memory region
> + * @paddr:	The start physical address of the region.
> + * @size:	The sizeof of the region.
> + */
> +struct phys_mem_region {
> +	u64 paddr;
> +	u64 size;
> +};
> +
> +/**
> + * struct phys_contig_mem_region - Physical contiguous memory regions
> + * @num:	The number of regions that currently has.
> + * @region:	The array of physical memory regions.
> + */
> +struct phys_contig_mem_region {
> +	unsigned long num;
> +	struct phys_mem_region region[0];
> +};

Why create your own structures and not use the in-kernel ones for stuff
like this?  What is wrong with the existing memory region or resource
handling logic?

thanks,

greg k-h
