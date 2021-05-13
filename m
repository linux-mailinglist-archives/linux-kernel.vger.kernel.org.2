Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622E337FDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhEMTQK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 May 2021 15:16:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:59001 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhEMTQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:16:07 -0400
IronPort-SDR: KHly6+fCOkPbbg5ahhEZxygiwK/6IS0qWWIqyg/eR2r/ZuAaPMF/nxazFDLgBrbePMwxmE8cys
 hZltrnjORE8w==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="200082105"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="200082105"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:14:57 -0700
IronPort-SDR: 7WEggcpESFwbovgw4qCaZtkJ0dnpYOGOo+UvuJZn9NCMESFuAGSr/nAaGZZYjsp3VWNrGfznTf
 SBUHkmiZmNHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="401132951"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 13 May 2021 12:14:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 13 May 2021 12:14:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 12:14:54 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 13 May 2021 12:14:54 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Joerg Roedel" <joro@8bytes.org>,
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
Thread-Index: AQHXR/foStIq1WXEVUyqodFI447jQarh3/IAgAAZyAD//6FJIIAAhnOA//+hPACAAHc/AP//jORg
Date:   Thu, 13 May 2021 19:14:54 +0000
Message-ID: <e9dd39aa8a144c23beffa5ca58936385@intel.com>
References: <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder> <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org> <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com> <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
In-Reply-To: <20210513190040.GR1002214@nvidia.com>
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

> If you want this then be explicit about what it is you are making when
> building the API. Don't try to hide it under some generic idea of
> "kernel PCI DMA SVA"

So, a special API call (that Dave can call from IDXD) to set up this
kernel PASID. With suitable documentation to explain the scope.
Maybe with a separate CONFIG option so it can be completely
stubbed out (IDXD does *NOT* "select" this option ... users have
to explicitly pick it).

> I could easily see an admin option to "turn this off" entirely as
> being too dangerous, especially if the users have no interest in IDXD.

And a kernel command line option to block IDXD from using that
special API ... for users on generic kernels who want to block
this use model (but still use IDXD in non-kernel cases). Users
who don't want IDXD at all can block loading of the driver.

Would that work?

-Tony
