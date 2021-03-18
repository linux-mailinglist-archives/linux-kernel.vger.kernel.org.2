Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D539C34034B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCRK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:29:55 -0400
Received: from 8bytes.org ([81.169.241.247]:59674 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhCRK3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:29:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 646CB2D8; Thu, 18 Mar 2021 11:29:49 +0100 (CET)
Date:   Thu, 18 Mar 2021 11:29:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Report more information about
 invalidation errors
Message-ID: <YFMrnJC0DEmGgukE@8bytes.org>
References: <20210318005340.187311-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318005340.187311-1-baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 08:53:40AM +0800, Lu Baolu wrote:
> When the invalidation queue errors are encountered, dump the information
> logged by the VT-d hardware together with the pending queue invalidation
> descriptors.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c  | 68 ++++++++++++++++++++++++++++++++++---
>  include/linux/intel-iommu.h |  6 ++++
>  2 files changed, 70 insertions(+), 4 deletions(-)

Applied, thanks.
