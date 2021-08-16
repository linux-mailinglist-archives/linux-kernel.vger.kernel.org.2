Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6733ED026
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhHPIWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231716AbhHPIWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:22:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B61661B2A;
        Mon, 16 Aug 2021 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629102096;
        bh=v18Ob//oOAIeQmu3aXKKRsWdxAHyy/T7LeoQ46bi2G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ubhjgvz4NQPP+8fF72SovDtWK7ukpc33jGB0RILwp86eu70aViqAfg1Ko8sY1NBlF
         8TLkQhYsCZ6OoaVMoRh2V/s1Cw3iCN0J6Fmjef45KOHC2/EmEaJXX4lPXJ84McPyRT
         q1kCMMxkdJNHAgXVtxwMn23Y5TUQ99cgnkVkZHwmgpZDU2iK/hnXqtNq49KNme+x1Y
         6OITEA0cw89WzV8X6XfHDNRoDcL1Uox6HsBhHismMEBLAYozj/LgDL0/t0b5b/xyFM
         IncMnbZYFKY4R6PvScxotv4gCAc5FiCyAUb/kP/EtsTCxgN8Fq0nurgmfT/8togwVS
         BegHYWgJa2g3A==
Date:   Mon, 16 Aug 2021 09:21:27 +0100
From:   Will Deacon <will@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching
 helpers to improve performance
Message-ID: <20210816082126.GA11011@willie-the-truck>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
 <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
 <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
 <5482d2e5-24db-6139-a8a8-74be1282e2ec@huawei.com>
 <52204403-f69a-d2b9-9365-7553e87d1298@huawei.com>
 <a3cdd5df-c028-5484-ce99-928a689d341a@huawei.com>
 <e8b71423-e827-f141-1203-00aca2e70834@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b71423-e827-f141-1203-00aca2e70834@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:47:58PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/8/16 15:24, John Garry wrote:
> >> In addition, I find that function arm_smmu_cmdq_build_cmd() can also be optimized
> >> slightly, three useless instructions can be reduced.
> > 
> > I think that you could optimise further by pre-building commonly used commands.
> > 
> > For example, CMD_SYNC without MSI polling is always the same. And then only different in 1 field for MSI polling.
> > 
> > But you need to check if the performance gain is worth the change.
> 
> Good advice. I can give it a try.

Please send it as a new patch on top. I've queued the old one and sent
it to Joerg. Since this is just further cleanup, it can be done separately.

Will
