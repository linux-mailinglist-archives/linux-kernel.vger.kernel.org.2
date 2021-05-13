Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4703C37FE79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhEMT7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:59:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:17069 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhEMT7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:59:03 -0400
IronPort-SDR: xSSXmWVY3duG9FrBXq32+0B1MwqBK2BUa+DwhY7Qi/M1Sa2ZZp5qNRwiQ/xq4atv4x2p+LVKAP
 ONYX3HRz8xuA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="221039457"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="221039457"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:57:51 -0700
IronPort-SDR: E2rhr2ojxOhoRpAjEdPNGL93ipKiiRZK+7lnx6dfQRww+hfoGQuxMN/qGtSvwx8ijnGaqBaWhp
 Z7EHKyCqoMPQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="431411776"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:57:51 -0700
Date:   Thu, 13 May 2021 12:57:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210513195749.GA801830@agluck-desk2.amr.corp.intel.com>
References: <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
 <e9dd39aa8a144c23beffa5ca58936385@intel.com>
 <20210513192014.GU1002214@nvidia.com>
 <20210513124621.01421173@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513124621.01421173@jacob-builder>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:46:21PM -0700, Jacob Pan wrote:
> It seems there are two options:
> 1. Add a new IOMMU API to set up a system PASID with a *separate* IOMMU page
> table/domain, mark the device is PASID only with a flag. Use DMA APIs
> to explicit map/unmap. Based on this PASID-only flag, Vendor IOMMU driver
> will decide whether to use system PASID domain during map/unmap. Not clear
> if we also need to make IOVA==kernel VA.
> 
> 2. Add a new IOMMU API to setup a system PASID which points to init_mm.pgd.
> This API only allows trusted device to bind with the system PASID at its
> own risk. There is no need for DMA API. This is the same as the current
> code except with an explicit API.
> 
> Which option?

Option #1 looks cleaner to me. Option #2 gives access to bits
of memory that the users of system PASID shouldn't ever need
to touch ... just map regions of memory that the kernel has
a "struct page" for.

What does "use DMA APIs to explicitly map/unmap" mean? Is that
for the whole region?

I'm expecting that once this system PASID has been initialized,
then any accelerator device with a kernel use case would use the
same PASID. I.e. DSA for page clearing, IAX for ZSwap compression
& decompression, etc.

-Tony
