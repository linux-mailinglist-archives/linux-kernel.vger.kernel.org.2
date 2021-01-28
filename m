Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC453073D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhA1KcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:32:14 -0500
Received: from 8bytes.org ([81.169.241.247]:53274 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232361AbhA1Kbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:31:41 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7EA4151D; Thu, 28 Jan 2021 11:30:58 +0100 (CET)
Date:   Thu, 28 Jan 2021 11:30:56 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Consolidate duplicate cache invaliation
 code
Message-ID: <20210128103056.GG32671@8bytes.org>
References: <20210114085021.717041-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114085021.717041-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 04:50:21PM +0800, Lu Baolu wrote:
> The pasid based IOTLB and devTLB invalidation code is duplicate in
> several places. Consolidate them by using the common helpers.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 18 ++----------
>  drivers/iommu/intel/svm.c   | 55 ++++++-------------------------------
>  2 files changed, 11 insertions(+), 62 deletions(-)

Applied, thanks.
