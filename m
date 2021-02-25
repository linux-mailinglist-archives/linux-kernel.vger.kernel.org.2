Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F39C325999
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhBYWXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:23:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:3567 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233455AbhBYWSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:18:04 -0500
IronPort-SDR: edwX2uxP8Nqr+3PbHjpS/LjIi/TUOZ5uMxRuNhDF/OAb0wQvPXL+fIsqWvlraCzmw20gIIgHy7
 fL1IMyMWQe6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="185749632"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="185749632"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 14:17:18 -0800
IronPort-SDR: HBKSHiLe0MtfvnRN4zT3jI0f0Rqf5KuNeB1ORFZDVA8T397xDurDMDhDQchjk4a8veYMxlqzmu
 CNop4lCWAW1w==
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="404589780"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 14:17:18 -0800
Date:   Thu, 25 Feb 2021 22:17:11 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, zhangfei.gao@foxmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH v6 08/12] fork: Clear PASID for new mm
Message-ID: <YDgh53AcQHT+T3L0@otcwcpicx3.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-9-git-send-email-fenghua.yu@intel.com>
 <YDYoL/zZ9YaGgwSV@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDYoL/zZ9YaGgwSV@myrica>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean,

On Wed, Feb 24, 2021 at 11:19:27AM +0100, Jean-Philippe Brucker wrote:
> Hi Fenghua,
> 
> [Trimmed the Cc list]
> 
> On Mon, Jul 13, 2020 at 04:48:03PM -0700, Fenghua Yu wrote:
> > When a new mm is created, its PASID should be cleared, i.e. the PASID is
> > initialized to its init state 0 on both ARM and X86.
> 
> I just noticed this patch was dropped in v7, and am wondering whether we
> could still upstream it. Does x86 need a child with a new address space
> (!CLONE_VM) to inherit the PASID of the parent?  That doesn't make much
> sense with regard to IOMMU structures - same PASID indexing multiple PGDs?

You are right: x86 should clear mm->pasid when a new mm is created.
This patch somehow is losted:(

> 
> Currently iommu_sva_alloc_pasid() assumes mm->pasid is always initialized
> to 0 and fails on forked tasks. I'm trying to figure out how to fix this.
> Could we clear the pasid on fork or does it break the x86 model?

x86 calls ioasid_alloc() instead of iommu_sva_alloc_pasid(). So
functionality is not a problem without this patch on x86. But I think
we do need to have this patch in the kernel because PASID is per addr
space and two addr spaces shouldn't have the same PASID.

Who will accept this patch?

Thanks.

-Fenghua
