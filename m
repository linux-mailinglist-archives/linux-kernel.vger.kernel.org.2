Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FF37FBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhEMQqN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 May 2021 12:46:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:6529 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232279AbhEMQpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:45:39 -0400
IronPort-SDR: 9cnCEjKqC0Pv0uVCBfb8g4jmvOL1JmcLuVbOpptGI2DKlYuo0vQggWVRq4uCm1aFRLbP1vX6Ac
 N090UbY6UGjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="196896531"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="196896531"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 09:44:17 -0700
IronPort-SDR: IzZGvtmnOazCD/bdR7ddiOefUMtd/AXraOiK6SBYoyzo+X5ZP/cBfdwwYrFpbll8uQyCUSKjPz
 m0Sm8Wk2hywA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="626299114"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 09:44:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 09:44:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 09:44:14 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 13 May 2021 09:44:14 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Christoph Hellwig <hch@infradead.org>,
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
Subject: RE: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Thread-Topic: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Thread-Index: AQHXR/foStIq1WXEVUyqodFI447jQarh3/IAgAAZyAD//6FJIA==
Date:   Thu, 13 May 2021 16:44:14 +0000
Message-ID: <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
References: <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210510233749.GG1002214@nvidia.com>   <20210510203145.086835cc@jacob-builder>
        <20210511114848.GK1002214@nvidia.com>   <20210511091452.721e9a03@jacob-builder>
        <20210511163521.GN1002214@nvidia.com>   <20210511110550.477a434f@jacob-builder>
        <20210511194726.GP1002214@nvidia.com>   <YJt3tGlzFK3b4E82@infradead.org>
        <20210513060012.0fcc7653@jacob-builder> <20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
In-Reply-To: <20210513081050.5cf6a6ed@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For shared workqueue, it can only generate DMA request with PASID. The
> submission is done by ENQCMDS (S for supervisor) instruction.
>
> If we were not to share page tables with init_mm, we need a system PASID
> that doing the same direct mapping in IOMMU page tables.

Note that for the currently envisioned kernel use cases for accelerators it
would be OK for this system PASID to just provide either:

1) A 1:1 mapping for physical addresses.  Kernel users of the accelerators
  would provide physical addresses in descriptors.
2) The same mapping that the kernel uses for its "1:1" map of all physical
    memory. Users would use kernel virtual addresses in that "1:1" range
    (e.g. those obtained from page_to_virt(struct page *p);)

If people want to use an accelerator on memory allocated by vmalloc()
things will get more complicated. But maybe we can delay solving that
problem until someone comes up with a real use case that needs to
do this?

-Tony


