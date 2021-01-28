Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44B3073D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhA1KfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:35:16 -0500
Received: from 8bytes.org ([81.169.241.247]:53294 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhA1KfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:35:14 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7492351D; Thu, 28 Jan 2021 11:34:32 +0100 (CET)
Date:   Thu, 28 Jan 2021 11:34:31 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Preset Access/Dirty bits for IOVA over FL
Message-ID: <20210128103430.GI32671@8bytes.org>
References: <20210115004202.953965-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115004202.953965-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 08:42:02AM +0800, Lu Baolu wrote:
> The Access/Dirty bits in the first level page table entry will be set
> whenever a page table entry was used for address translation or write
> permission was successfully translated. This is always true when using
> the first-level page table for kernel IOVA. Instead of wasting hardware
> cycles to update the certain bits, it's better to set them up at the
> beginning.
> 
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 14 ++++++++++++--
>  include/linux/intel-iommu.h |  2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)

Applied, thanks.
