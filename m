Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8913408F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhCRPeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCRPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:33:59 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD943C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:33:59 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3EC7C2DA; Thu, 18 Mar 2021 16:33:56 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:33:36 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, Wei.Huang2@amd.com
Subject: Re: [RFC PATCH 6/7] iommu/amd: Introduce amd_iommu_pgtable
 command-line option
Message-ID: <YFNy0LbQAreu64lt@8bytes.org>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
 <20210312090411.6030-7-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312090411.6030-7-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:04:10AM -0600, Suravee Suthikulpanit wrote:
> To allow specification whether to use v1 or v2 IOMMU pagetable for
> DMA remapping when calling kernel DMA-API.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  drivers/iommu/amd/init.c                        | 15 +++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..466e807369ea 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -319,6 +319,12 @@
>  			             This mode requires kvm-amd.avic=1.
>  			             (Default when IOMMU HW support is present.)
>  
> +	amd_iommu_pgtable= [HW,X86-64]
> +			Specifies one of the following AMD IOMMU page table to
> +			be used for DMA remapping for DMA-API:
> +			v1         - Use v1 page table (Default)
> +			v2         - Use v2 page table

Any reason v2 can not be the default when it is supported by the IOMMU?

