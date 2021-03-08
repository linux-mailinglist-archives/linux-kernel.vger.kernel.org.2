Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3883317AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhCHTsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:48:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:50671 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231243AbhCHTrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:47:48 -0500
IronPort-SDR: Awl+Pyo/H8dVm2wjNxSoqH2dhqlgsaU2wCNRIRp7Gn+J5KvfWdWgxFNuNNKvo7sgEVTNgTdPfr
 4t2bKmhK1wrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273122731"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="273122731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:47:48 -0800
IronPort-SDR: WOrCr/EqVp4x85cVw8oQ1HycY/InT6iNHA86LctH221jXzosfr12XCVnXT7H06dpcJKIKTCRZi
 9DhoNBcArcgQ==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="509034146"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:47:48 -0800
Date:   Mon, 8 Mar 2021 11:47:46 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
Message-ID: <20210308194746.GA15436@otc-nc-03>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
 <20210304122623.GD26414@8bytes.org>
 <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg

On Mon, Mar 08, 2021 at 09:58:26AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> On 3/4/21 8:26 PM, Joerg Roedel wrote:
> >On Thu, Feb 25, 2021 at 02:26:51PM +0800, Lu Baolu wrote:
> >>When the first level page table is used for IOVA translation, it only
> >>supports Read-Only and Read-Write permissions. The Write-Only permission
> >>is not supported as the PRESENT bit (implying Read permission) should
> >>always set. When using second level, we still give separate permissions
> >>that allows WriteOnly which seems inconsistent and awkward. There is no
> >>use case we can think off, hence remove that configuration to make it
> >>consistent.
> >
> >No use-case for WriteOnly mappings? How about DMA_FROM_DEVICE mappings?
> >
> 
> The statement of no use case is not correct. Sorry about it.
> 
> As we have moved to use first level for IOVA translation, the first
> level page table entry only provides RO and RW permissions. So if any
> device driver specifies DMA_FROM_DEVICE attribution, it will get RW
> permission in the page table. This patch aims to make the permissions
> of second level and first level consistent. No impact on the use of
> DMA_FROM_DEVICE attribution.
> 

That is the primary motivation, given that we have moved to 1st level for
general IOVA, first level doesn't have a WO mapping. I didn't know enough
about the history to determine if a WO without a READ is very useful. I
guess the ZLR was invented to support those cases without a READ in PCIe. I

Early Intel IOMMU's didn't handle ZLR properly, until we fixed it in the
next generation. It just seemed opposite to the CPU page-tables, and we
wanted to have consistent behavior. After moving to 1st level, we don't
want things to work sometimes, and break if we use 2nd level for the same
mappings.

Hope this helps

Cheers,
Ashok
