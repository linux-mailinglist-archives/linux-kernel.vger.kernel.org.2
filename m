Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C4B307629
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhA1M2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhA1M2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:28:49 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30B4C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:28:08 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1103E51D; Thu, 28 Jan 2021 13:28:06 +0100 (CET)
Date:   Thu, 28 Jan 2021 13:28:04 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        iommu@lists.linux-foundation.org, jsnitsel@redhat.com,
        thomas.lendacky@amd.com, robin.murphy@arm.com, bhe@redhat.com,
        hch@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v3 0/2] iommu: fix the failure of deferred attach for
 iommu attach device
Message-ID: <20210128122804.GM32671@8bytes.org>
References: <20210126115337.20068-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126115337.20068-1-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:53:35PM +0800, Lianbo Jiang wrote:
> Lianbo Jiang (2):
>   dma-iommu: use static-key to minimize the impact in the fast-path
>   iommu: use the __iommu_attach_device() directly for deferred attach
> 
>  drivers/iommu/dma-iommu.c | 29 +++++++++++------------------
>  drivers/iommu/iommu.c     | 10 ++++++++++
>  include/linux/iommu.h     |  1 +
>  3 files changed, 22 insertions(+), 18 deletions(-)

Sorry, missed that there was a newer version. Applied this instead of
v2.
