Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B2432D325
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbhCDMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:33:23 -0500
Received: from 8bytes.org ([81.169.241.247]:57642 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240602AbhCDMdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:33:14 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 603EB321; Thu,  4 Mar 2021 13:32:33 +0100 (CET)
Date:   Thu, 4 Mar 2021 13:32:31 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, will@kernel.org,
        jacob.jun.pan@linux.intel.com, eric.auger@redhat.com,
        yi.l.liu@intel.com, kevin.tian@intel.com,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] iommu/vt-d: Fix status code for Allocate/Free PASID
 command
Message-ID: <20210304123231.GE26414@8bytes.org>
References: <20210227073909.432-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210227073909.432-1-yuzenghui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 03:39:09PM +0800, Zenghui Yu wrote:
> As per Intel vt-d spec, Rev 3.0 (section 10.4.45 "Virtual Command Response
> Register"), the status code of "No PASID available" error in response to
> the Allocate PASID command is 2, not 1. The same for "Invalid PASID" error
> in response to the Free PASID command.
> 
> We will otherwise see confusing kernel log under the command failure from
> guest side. Fix it.
> 
> Fixes: 24f27d32ab6b ("iommu/vt-d: Enlightened PASID allocation")
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

Applied for v5.12, thanks.
