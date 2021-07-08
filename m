Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD503BF7AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGHJlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:41:14 -0400
Received: from 8bytes.org ([81.169.241.247]:33300 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhGHJlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:41:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 28043312; Thu,  8 Jul 2021 11:38:31 +0200 (CEST)
Date:   Thu, 8 Jul 2021 11:38:29 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v14 0/6] iommu: Enhance IOMMU default DMA mode build
 options
Message-ID: <YObHla5Vyr+YaCI7@8bytes.org>
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1b75de8f-a2e3-6297-0f56-b2f1548495b0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b75de8f-a2e3-6297-0f56-b2f1548495b0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Jun 25, 2021 at 05:41:09PM +0100, John Garry wrote:
> We think that this series is ready to go.
> 
> There would be a build conflict with the following:
> https://lore.kernel.org/linux-iommu/20210616100500.174507-1-namit@vmware.com/
> 
> So please let us know where you stand on it, so that could be resolved.
> 
> Robin and Baolu have kindly reviewed all the patches, apart from the AMD
> one.

The AMD one also looks good to me, please re-send after the merge window
closes and I will take care of it then. Note that I usually start
merging new stuff after -rc3 is out.

Regards,

	Joerg
