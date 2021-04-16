Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9AF3623DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbhDPPZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbhDPPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:25:20 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE036C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:24:54 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D3E01223; Fri, 16 Apr 2021 17:24:51 +0200 (CEST)
Date:   Fri, 16 Apr 2021 17:24:50 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/8] iommu: fix a couple of spelling mistakes detected by
 codespell tool
Message-ID: <YHmsQtm4o5f7fAru@8bytes.org>
References: <20210326062412.1262-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326062412.1262-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 02:24:04PM +0800, Zhen Lei wrote:
> This detection and correction covers the entire driver/iommu directory.
> 
> Zhen Lei (8):
>   iommu/pamu: fix a couple of spelling mistakes
>   iommu/omap: Fix spelling mistake "alignement" -> "alignment"
>   iommu/mediatek: Fix spelling mistake "phyiscal" -> "physical"
>   iommu/sun50i: Fix spelling mistake "consits" -> "consists"
>   iommu: fix a couple of spelling mistakes
>   iommu/amd: fix a couple of spelling mistakes
>   iommu/arm-smmu: Fix spelling mistake "initally" -> "initially"
>   iommu/vt-d: fix a couple of spelling mistakes

This patch-set doesn't apply. Please re-send it as a single patch when
v5.13-rc1 is released.

Thanks,

	Joerg
