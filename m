Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB243417FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCSJIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:08:51 -0400
Received: from 8bytes.org ([81.169.241.247]:59864 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhCSJIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:08:47 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6BE362DA; Fri, 19 Mar 2021 10:08:46 +0100 (CET)
Date:   Fri, 19 Mar 2021 10:08:43 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix lockdep splat in
 intel_pasid_get_entry()
Message-ID: <YFRqG3DW8k0Zrk0w@8bytes.org>
References: <20210317005834.173503-1-baolu.lu@linux.intel.com>
 <YFMpmLNd73IVcgWq@8bytes.org>
 <89f87115-32dc-205e-61e0-71de0d626303@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f87115-32dc-205e-61e0-71de0d626303@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Fri, Mar 19, 2021 at 09:02:34AM +0800, Lu Baolu wrote:
> This code modifies the pasid directory entry. The pasid directory
> entries are allocated on demand and will never be freed.
> 
> > What you need to do here is to retry the whole path by adding a goto
> > to before  the first get_pasid_table_from_pde() call.
> 
> Yes. Retrying by adding a goto makes the code clearer.
> 
> > 
> > Btw, what makes sure that the pasid_entry does not go away when it is
> > returned here?
> 
> As explained above, it handles the pasid directory table entry which
> won't go away.

Okay, I think the goto is a good idea anyway, in case this changes
someday. Please also add a comment to this code stating that the entries
are never freed.

Regards,

	Joerg
