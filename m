Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24145305D00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhA0NXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238241AbhA0NUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:20:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52CDF207A2;
        Wed, 27 Jan 2021 13:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611753600;
        bh=inUC5PP/mCtOcJb9zEFFxMqaSkScQIwSvgVH1JRqWvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNuRicZmVe/PskXlJzjLEJ722ZnXFAQLGeRAKTwdR9iqt8/1zUf0zHi0a93TqOGkP
         rd8J65szwWJe+FtycVSdjA/Pp/AKW60v17pMS7LryT8DkN5iWh0XRN509189hWu1NC
         jOXWisvo/4jyP2t9Bd+lGFriZvCvIB8ss7aB45OJw7wtGKw+k4zm3ftZh65z5ODLxm
         1Ol1KFwT6HKrPc7oGrdIdPgYUU49minUmwqG3Q3rdt0Y+1iKUtoXMA7U/bgxniSlHS
         bzV8KHX8UUQSGKM4SAl1HSQgAXL1RXse2L7wLfmgvCLY9frBzkvDeDYcOMrLBPNXuZ
         qP3grMuikAOow==
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, anan.sun@mediatek.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        David Laight <David.Laight@ACULAB.COM>,
        srv_heupstream@mediatek.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>, chao.hao@mediatek.com,
        youlin.pei@mediatek.com, linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 0/7] MediaTek IOMMU improve tlb flush performance in map/unmap
Date:   Wed, 27 Jan 2021 13:19:53 +0000
Message-Id: <161175074760.1106263.14591124622667700357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107122909.16317-1-yong.wu@mediatek.com>
References: <20210107122909.16317-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 20:29:02 +0800, Yong Wu wrote:
> This patchset is to improve tlb flushing performance in iommu_map/unmap
> for MediaTek IOMMU.
> 
> For iommu_map, currently MediaTek IOMMU use IO_PGTABLE_QUIRK_TLBI_ON_MAP
> to do tlb_flush for each a memory chunk. this is so unnecessary. we could
> improve it by tlb flushing one time at the end of iommu_map.
> 
> [...]

After discussion with Joerg, I'll queue this (and hopefully the next posting
of your IOMMU driver) along with the Arm SMMU patches, and then send that
all together.

Applied to will (for-joerg/mtk), thanks!

[1/7] iommu: Move iotlb_sync_map out from __iommu_map
      https://git.kernel.org/arm64/c/d8c1df02ac7f
[2/7] iommu: Add iova and size as parameters in iotlb_sync_map
      https://git.kernel.org/arm64/c/2ebbd25873ce
[3/7] iommu/mediatek: Add iotlb_sync_map to sync whole the iova range
      https://git.kernel.org/arm64/c/20143451eff0
[4/7] iommu: Switch gather->end to the inclusive end
      https://git.kernel.org/arm64/c/862c3715de8f
[5/7] iommu/io-pgtable: Allow io_pgtable_tlb ops optional
      https://git.kernel.org/arm64/c/77e0992aee4e
[6/7] iommu/mediatek: Gather iova in iommu_unmap to achieve tlb sync once
      https://git.kernel.org/arm64/c/f21ae3b10084
[7/7] iommu/mediatek: Remove the tlb-ops for v7s
      https://git.kernel.org/arm64/c/0954d61a59e3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
