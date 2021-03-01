Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D530332A034
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575510AbhCBD43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:52009 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241841AbhCAW7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:59:20 -0500
IronPort-SDR: IBfFtAt6njIT235hj8F62Gx16GCujXyz62MgZ/ThCFZ0BxS6raO2eTFkkGvUUaovHU/4se27DI
 4UmHfG4WqTqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="250671443"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="250671443"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 14:57:57 -0800
IronPort-SDR: tJve8x1cqIyj1Zp29MjKeC6e8QzZkBYQiEg5LY5/Q2mEq6QeMUgOU1orgYtb4aPV0pYaO/g7ns
 twgRDb4Xl6sA==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="368758360"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 14:57:57 -0800
Date:   Mon, 1 Mar 2021 15:00:11 -0800
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <zhangfei.gao@foxmail.com>,
        <linux-mm@kvack.org>, jacob.jun.pan@intel.com
Subject: Re: [PATCH v6 08/12] fork: Clear PASID for new mm
Message-ID: <20210301150011.766e70a3@jacob-builder>
In-Reply-To: <YDgh53AcQHT+T3L0@otcwcpicx3.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
        <1594684087-61184-9-git-send-email-fenghua.yu@intel.com>
        <YDYoL/zZ9YaGgwSV@myrica>
        <YDgh53AcQHT+T3L0@otcwcpicx3.sc.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On Thu, 25 Feb 2021 22:17:11 +0000, Fenghua Yu <fenghua.yu@intel.com> wrote:

> Hi, Jean,
> 
> On Wed, Feb 24, 2021 at 11:19:27AM +0100, Jean-Philippe Brucker wrote:
> > Hi Fenghua,
> > 
> > [Trimmed the Cc list]
> > 
> > On Mon, Jul 13, 2020 at 04:48:03PM -0700, Fenghua Yu wrote:  
> > > When a new mm is created, its PASID should be cleared, i.e. the PASID
> > > is initialized to its init state 0 on both ARM and X86.  
> > 
> > I just noticed this patch was dropped in v7, and am wondering whether we
> > could still upstream it. Does x86 need a child with a new address space
> > (!CLONE_VM) to inherit the PASID of the parent?  That doesn't make much
> > sense with regard to IOMMU structures - same PASID indexing multiple
> > PGDs?  
> 
> You are right: x86 should clear mm->pasid when a new mm is created.
> This patch somehow is losted:(
> 
> > 
> > Currently iommu_sva_alloc_pasid() assumes mm->pasid is always
> > initialized to 0 and fails on forked tasks. I'm trying to figure out
> > how to fix this. Could we clear the pasid on fork or does it break the
> > x86 model?  
> 
> x86 calls ioasid_alloc() instead of iommu_sva_alloc_pasid(). So
We should consolidate at some point, there is no need to store pasid in two
places.

> functionality is not a problem without this patch on x86. But I think
I feel the reason that x86 doesn't care is that mm->pasid is not used
unless bind_mm is called. For the fork children even mm->pasid is non-zero,
it has no effect since it is not loaded onto MSRs.
Perhaps you could also add a check or WARN_ON(!mm->pasid) in load_pasid()?

> we do need to have this patch in the kernel because PASID is per addr
> space and two addr spaces shouldn't have the same PASID.
> 
Agreed.

> Who will accept this patch?
> 
> Thanks.
> 
> -Fenghua


Thanks,

Jacob
