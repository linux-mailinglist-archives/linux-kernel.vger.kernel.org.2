Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95BE356B33
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbhDGL3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233309AbhDGL3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:29:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3237161369;
        Wed,  7 Apr 2021 11:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617794953;
        bh=9NYyU7bUjOR+lLmEGMoWH42DJ2TAlct90gArzd8w4y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mb72Mgv2mJJ7Y9FIzjDq+4botbLgPx1PAR73hGL5gqbsWLGb1/VlO3QqmfClRIw9m
         NzcejtnuMc43m8jlHvyMZOa/ReMYUWEG7DELK6RNeJ0YpshjcqWnYm/PGnhWpR4vNP
         gYIphl3n3PoBEmVmH33Tc4maj5Ej8ZmbX/56ek5EfAImlkCuPcwf9grp/RVYwbGFxg
         Vqsmmgb3lP34tTN5X6zTAu4+UblR6ekvQYr9dOoOUn2r7FkchKU0MaKjmUgIcjO/Yl
         WkekR3IcccJUG8dv82uLkTxUNVxEVmcrdEBMtqgnSNBi9ZpZ/meDr/aaRzQMeleahJ
         SypmiCrufDKeQ==
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove the unused fields for PREFETCH_CONFIG command
Date:   Wed,  7 Apr 2021 12:29:07 +0100
Message-Id: <161779144071.3351666.16894933104302748109.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407084448.1838-1-yuzenghui@huawei.com>
References: <20210407084448.1838-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 16:44:48 +0800, Zenghui Yu wrote:
> Per SMMUv3 spec, there is no Size and Addr field in the PREFETCH_CONFIG
> command and they're not used by the driver. Remove them.
> 
> We can add them back if we're going to use PREFETCH_ADDR in the future.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Remove the unused fields for PREFETCH_CONFIG command
      https://git.kernel.org/will/c/e0bb4b735404

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
