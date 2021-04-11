Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECD35B1E5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhDKGRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:17:24 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48001 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229792AbhDKGRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:17:21 -0400
Received: from [192.168.178.35] (unknown [94.134.88.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id ED738206473C5;
        Sun, 11 Apr 2021 08:17:02 +0200 (CEST)
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20210410211152.1938-1-amonakov@ispras.ru>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
Date:   Sun, 11 Apr 2021 08:17:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210410211152.1938-1-amonakov@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alexander,


Am 10.04.21 um 23:11 schrieb Alexander Monakov:
> print_iommu_info prints the EFR register and then the decoded list of
> features on a separate line:
> 
> pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
>   PPR X2APIC NX GT IA GA PC GA_vAPIC
> 
> The second line is emitted via 'pr_cont', which causes it to have a
> different ('warn') loglevel compared to the previous line ('info').
> 
> Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
> from the pci_info format string, but this doesn't work, as pci_info
> calls implicitly append a newline anyway.

Hmm, did I really screw that up during my testing? I am sorry about that.

I tried to wrap my head around, where the newline is implicitly 
appended, and only found the definitions below.

     include/linux/pci.h:#define pci_info(pdev, fmt, arg...) 
dev_info(&(pdev)->dev, fmt, ##arg)

     include/linux/dev_printk.h:#define dev_info(dev, fmt, ...) 
                                      \
     include/linux/dev_printk.h:     _dev_info(dev, dev_fmt(fmt), 
##__VA_ARGS__)

     include/linux/dev_printk.h:__printf(2, 3) __cold
     include/linux/dev_printk.h:void _dev_info(const struct device *dev, 
const char *fmt, ...);

     include/linux/compiler_attributes.h:#define __printf(a, b) 
          __attribute__((__format__(printf, a, b)))


> Restore the newline, and call pr_info with empty format string to set
> the loglevel for subsequent pr_cont calls. The same solution is used in
> EFI and uvesafb drivers.

Thank you for fixing this.

> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
>   drivers/iommu/amd/init.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 596d0c413473..a25e241eff1c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1929,8 +1929,11 @@ static void print_iommu_info(void)
>   		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
>   
>   		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> +			pci_info(pdev, "Extended features (%#llx):\n",
>   				 iommu->features);
> +
> +			pr_info("");
> +
>   			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
>   				if (iommu_feature(iommu, (1ULL << i)))
>   					pr_cont(" %s", feat_str[i]);
> 

In the discussion *smpboot: CPU numbers printed as warning* [1] John wrote:

> It is supported to provide loglevels for CONT messages. The loglevel is
> then only used if the append fails:
> 
>     pr_cont(KERN_INFO "message part");
> 
> I don't know if we want to go down that path. But it is supported.


Kind regards,

Paul


[1]: https://lkml.org/lkml/2021/2/16/191
