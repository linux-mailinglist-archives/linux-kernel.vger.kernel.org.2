Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533EE3075D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhA1MSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:18:38 -0500
Received: from 8bytes.org ([81.169.241.247]:53324 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhA1MSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:18:35 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9A61D51D; Thu, 28 Jan 2021 13:17:49 +0100 (CET)
Date:   Thu, 28 Jan 2021 13:17:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Correctly check addr alignment in
 qi_flush_dev_iotlb_pasid()
Message-ID: <20210128121747.GK32671@8bytes.org>
References: <20210119043500.1539596-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119043500.1539596-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:35:00PM +0800, Lu Baolu wrote:
> An incorrect address mask is being used in the qi_flush_dev_iotlb_pasid()
> to check the address alignment. This leads to a lot of spurious kernel
> warnings:
> 
> [  485.837093] DMAR: Invalidate non-aligned address 7f76f47f9000, order 0
> [  485.837098] DMAR: Invalidate non-aligned address 7f76f47f9000, order 0
> [  492.494145] qi_flush_dev_iotlb_pasid: 5734 callbacks suppressed
> [  492.494147] DMAR: Invalidate non-aligned address 7f7728800000, order 11
> [  492.508965] DMAR: Invalidate non-aligned address 7f7728800000, order 11
> 
> Fix it by checking the alignment in right way.
> 
> Fixes: 288d08e780088 ("iommu/vt-d: Handle non-page aligned address")
> Reported-and-tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for 5.11, thanks.

