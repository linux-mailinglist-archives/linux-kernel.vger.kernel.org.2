Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671323403B3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCRKnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:43:12 -0400
Received: from 8bytes.org ([81.169.241.247]:59700 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230180AbhCRKnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:43:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9A82B2D8; Thu, 18 Mar 2021 11:43:03 +0100 (CET)
Date:   Thu, 18 Mar 2021 11:43:02 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: Re: [PATCH v2 0/4] Misc vSVA fixes for VT-d
Message-ID: <YFMutnvP1mKhumx0@8bytes.org>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:13:56AM -0800, Jacob Pan wrote:
> Hi Baolu et al,
> 
> This is a collection of SVA-related fixes.
> 
> ChangeLog:
> 
> v2:
> 	- For guest SVA, call pasid_set_wpe directly w/o checking host CR0.wp
> 	  (Review comments by Kevin T.)
> 	- Added fixes tag
> 
> Thanks,
> 
> Jacob
> 
> Jacob Pan (4):
>   iommu/vt-d: Enable write protect for supervisor SVM
>   iommu/vt-d: Enable write protect propagation from guest
>   iommu/vt-d: Reject unsupported page request modes
>   iommu/vt-d: Calculate and set flags for handle_mm_fault
> 
>  drivers/iommu/intel/pasid.c | 29 +++++++++++++++++++++++++++++
>  drivers/iommu/intel/svm.c   | 21 +++++++++++++++++----
>  include/uapi/linux/iommu.h  |  3 ++-
>  3 files changed, 48 insertions(+), 5 deletions(-)

Applied, thanks.
