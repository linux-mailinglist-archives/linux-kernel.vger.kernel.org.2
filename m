Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965D3356722
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349733AbhDGIrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349639AbhDGImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:42:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D037DC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:42:01 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D4FAE2A6; Wed,  7 Apr 2021 10:41:59 +0200 (CEST)
Date:   Wed, 7 Apr 2021 10:41:58 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, ashok.raj@intel.com,
        kevin.tian@intel.com, rajesh.sankaran@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Report right snoop capability when using
 FL for IOVA
Message-ID: <YG1wVgCrYVPm+sJK@8bytes.org>
References: <20210330021145.13824-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330021145.13824-1-baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:11:45AM +0800, Lu Baolu wrote:
>  drivers/iommu/intel/pasid.h |  1 +
>  drivers/iommu/intel/iommu.c | 11 ++++++++++-
>  drivers/iommu/intel/pasid.c | 16 ++++++++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)

Applied, thanks.
