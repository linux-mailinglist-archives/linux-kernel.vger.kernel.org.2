Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B37D425A52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbhJGSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:07:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:37160 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243116AbhJGSHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:07:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226225878"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="226225878"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 11:05:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="590237485"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 11:05:13 -0700
Date:   Thu, 7 Oct 2021 11:08:58 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Barry Song <21cnbao@gmail.com>, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211007110858.03cfea88@jacob-builder>
In-Reply-To: <20211007174822.GK2744544@nvidia.com>
References: <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
        <20211001123623.GM964074@nvidia.com>
        <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
        <20211004094003.527222e5@jacob-builder>
        <20211004182142.GM964074@nvidia.com>
        <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
        <20211007113221.GF2744544@nvidia.com>
        <CAGsJ_4x2UEmNXCVhJAVRyB8568VMrTkOLeVCNp8CyP6xZJwCig@mail.gmail.com>
        <20211007115918.GH2744544@nvidia.com>
        <20211007105010.33d706cf@jacob-builder>
        <20211007174822.GK2744544@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, 7 Oct 2021 14:48:22 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Oct 07, 2021 at 10:50:10AM -0700, Jacob Pan wrote:
> 
> > On platforms that are DMA snooped, this barrier is not needed. But I
> > think your point is that once we convert to DMA API, the sync/barrier
> > is covered by DMA APIs if !dev_is_dma_coherent(dev). Then all archs are
> > good.  
> 
> No.. my point is that a CPU store release is not necessary a DMA
> visiable event on all platforms and things like dma_wmb/rmb() may
> still be necessary. This all needs to be architected before anyone
> starts writing drivers that assume a coherent DMA model without using
> a coherent DMA allocation.
> 
Why is that specific to SVA? Or you are talking about things in general?

Can we ensure coherency at the API level where SVA bind device is
happening? i.e. fail the bind if not passing coherency check.

Thanks,

Jacob
