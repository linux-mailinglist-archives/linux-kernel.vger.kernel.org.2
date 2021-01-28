Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA13073D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhA1Kdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:33:36 -0500
Received: from 8bytes.org ([81.169.241.247]:53286 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhA1Kdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:33:33 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 637ED51D; Thu, 28 Jan 2021 11:32:50 +0100 (CET)
Date:   Thu, 28 Jan 2021 11:32:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Add qi_submit trace event
Message-ID: <20210128103248.GH32671@8bytes.org>
References: <20210114090400.736104-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114090400.736104-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 05:04:00PM +0800, Lu Baolu wrote:
> This adds a new trace event to track the submissions of requests to the
> invalidation queue. This event will provide the information like:
> - IOMMU name
> - Invalidation type
> - Descriptor raw data
> 
> A sample output like:
> | qi_submit: iotlb_inv dmar1: 0x100e2 0x0 0x0 0x0
> | qi_submit: dev_tlb_inv dmar1: 0x1000000003 0x7ffffffffffff001 0x0 0x0
> | qi_submit: iotlb_inv dmar2: 0x800f2 0xf9a00005 0x0 0x0
> 
> This will be helpful for queued invalidation related debugging.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c         |  3 +++
>  include/trace/events/intel_iommu.h | 37 ++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)

Applied, thanks.
