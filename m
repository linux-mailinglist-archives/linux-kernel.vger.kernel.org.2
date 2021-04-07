Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2F356641
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346936AbhDGIQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:16:39 -0400
Received: from 8bytes.org ([81.169.241.247]:33672 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237172AbhDGIQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:16:33 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9E4A92A6; Wed,  7 Apr 2021 10:16:23 +0200 (CEST)
Date:   Wed, 7 Apr 2021 10:16:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, ashok.raj@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iommu/vt-d: Several misc cleanups
Message-ID: <YG1qVs/koSdaQj1F@8bytes.org>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:05:55AM +0800, Lu Baolu wrote:
> Lu Baolu (5):
>   iommu/vt-d: Remove unused dma map/unmap trace events
>   iommu/vt-d: Remove svm_dev_ops
>   iommu/vt-d: Remove SVM_FLAG_PRIVATE_PASID
>   iommu/vt-d: Remove unused function declarations
>   iommu/vt-d: Make unnecessarily global functions static

Applied all, thanks.
