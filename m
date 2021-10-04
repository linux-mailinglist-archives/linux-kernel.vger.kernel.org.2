Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31256420A98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhJDMHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233106AbhJDMHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98F9261452;
        Mon,  4 Oct 2021 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633349151;
        bh=DczapP2V5LAVbduqo9lFtPbbyPM9o8Og7N2F7J1rbPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1bhSjAGiVnD8Sr1dLFAeEW60oKwO02PjL0305VrZCXwBWUhmC/eo6SH/HNxrivu+
         pUxsq8TeBu1IYVi4keUKzx6ZC6VJDOza/fEfw5t1v7dvEcyE1cAI1camLiqwWD7YfR
         UV+aT7n1DGXLP3+Pyu/d3PS+p86UTJ25/SglDtVi1lSR+umo6Iv9nBHQMo5wbBpuPv
         0ZXS2n2M4Rlo5Sf0juaUOn+WSFER4kHEdCfvq6v1c5JW8BRDkQ62J+DDPDeeraEg0D
         C95SlKbZxKt0Lapa5Z7X92ldcjQMpKgzehn3tUHzQWkbTzbhFD4O+g4OM068GdnbD5
         SZfehzTy+d0PQ==
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu <iommu@lists.linux-foundation.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Perform some simple optimizations for arm_smmu_cmdq_build_cmd()
Date:   Mon,  4 Oct 2021 13:05:36 +0100
Message-Id: <163334647414.1581641.3396518420865935764.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818080452.2079-1-thunder.leizhen@huawei.com>
References: <20210818080452.2079-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 16:04:50 +0800, Zhen Lei wrote:
> v1 --> v2:
> 1. Add patch 1, Properly handle the return value of arm_smmu_cmdq_build_cmd()
> 2. Remove arm_smmu_cmdq_copy_cmd(). In addition, when build command fails, out_cmd is not filled.
> 
> 
> Zhen Lei (2):
>   iommu/arm-smmu-v3: Properly handle the return value of
>     arm_smmu_cmdq_build_cmd()
>   iommu/arm-smmu-v3: Simplify useless instructions in
>     arm_smmu_cmdq_build_cmd()
> 
> [...]

Applied first patch only to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Properly handle the return value of arm_smmu_cmdq_build_cmd()
      https://git.kernel.org/will/c/59d9bd727495

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
