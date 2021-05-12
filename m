Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62C37ED55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386369AbhELUUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:20:55 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52621 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1384013AbhELT4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 15:56:25 -0400
Received: from [192.168.0.3] (ip5f5aef16.dynamic.kabel-deutschland.de [95.90.239.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BAB0561E5FE33;
        Wed, 12 May 2021 21:55:14 +0200 (CEST)
Subject: Re: [RESEND PATCH v2] iommu/amd: Fix extended features logging
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20210504102220.1793-1-amonakov@ispras.ru>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <189e74f3-40a0-12ec-08fa-982dff3708f2@molgen.mpg.de>
Date:   Wed, 12 May 2021 21:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504102220.1793-1-amonakov@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 04.05.21 um 12:22 schrieb Alexander Monakov:
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
> 
> Printing the decoded features on the same line would make it quite long.
> Instead, change pci_info() to pr_info() to omit PCI bus location info,
> which is also shown in the preceding message. This results in:
> 
> pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> AMD-Vi: Extended features (0x206d73ef22254ade): PPR X2APIC NX GT IA GA PC GA_vAPIC
> AMD-Vi: Interrupt remapping enabled
> 
> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
> Link: https://lore.kernel.org/lkml/alpine.LNX.2.20.13.2104112326460.11104@monopod.intra.ispras.ru
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
>   drivers/iommu/amd/init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 429a4baa3aee..8f0eb865119a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1954,8 +1954,8 @@ static void print_iommu_info(void)
>   		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
>   
>   		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> -				 iommu->features);
> +			pr_info("Extended features (%#llx):", iommu->features);
> +
>   			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
>   				if (iommu_feature(iommu, (1ULL << i)))
>   					pr_cont(" %s", feat_str[i]);
> 
> base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
