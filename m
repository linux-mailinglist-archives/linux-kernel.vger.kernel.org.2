Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B93494BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhCYO5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231225AbhCYO51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98E2261A01;
        Thu, 25 Mar 2021 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616684247;
        bh=+MGOAS/02TPE6GFrT+w8Tf+8MdBv5X5AeEce0i//TeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTnuiXXLkEsn4crF73TAZrj0cXe7YMEDsHkZMFAFnZJMb1Jzxyu9+62FuSNT/G9TU
         XZzFp4gdAeWsRtEsWiHLERdVq3Z/5yPkMCq45tIWj0YzZXWIbU/3ZfMindIVANJDyQ
         jd2AkjbpLp4Vty+7gkGtOEZJnG5hVkhypEQzQjB348anIbXIZPHjnjvKoGmIsbLNYY
         XEppwNk+b63CdQYy90SzqZlk1sbmLNuYX0Voe0ar9NUKr9H/hk9a9Oqrmv+24VJozD
         14gxdzWLvPV4WPh/t/5PQMn7vIC/JfPSSevrQgQ8MkWHbruaAil+rCjCgHP0s2bFok
         l9O2J3KWYyZUA==
Date:   Thu, 25 Mar 2021 14:57:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Don't use lazy flush for untrusted device
Message-ID: <20210325145723.GB15172@willie-the-truck>
References: <20210225061454.2864009-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225061454.2864009-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:14:54PM +0800, Lu Baolu wrote:
> The lazy IOTLB flushing setup leaves a time window, in which the device
> can still access some system memory, which has already been unmapped by
> the device driver. It's not suitable for untrusted devices. A malicious
> device might use this to attack the system by obtaining data that it
> shouldn't obtain.
> 
> Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/dma-iommu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
