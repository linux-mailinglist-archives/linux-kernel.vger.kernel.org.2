Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732CD3EB6C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhHMOe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240667AbhHMOe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:34:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E439610A5;
        Fri, 13 Aug 2021 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628865239;
        bh=92m9HeuR9H4yXPt2DolbcPV0xTYOZD/RrYfz77RdcA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZ9oERHYXdZf/5bfYcWV9pOyAr6+/jpV1J0o6wOqNp3pgwmKdwwwNvNEkv1CicAdG
         lNNNx7QqE7VhKak9TUIYl7r4DWgkgGDXDqsCnIvZNeIO7/UkgoVVraGBdqbRf3O3xp
         KViVVgqupJbOmmJyjPnwS4wnU85PM4jWurRTIwsASST4R4T7HD06069pOhEJ2n96qc
         aiZgR47TftZV39IFMEy9hoEwX9Lhhn2dwgMgDIXpKzgaZeGYB1CFc0wjJNq0GwN9mt
         b62Y5yMV/mg/UvLyRSJCY8L2cqbNvvc1bKoqxLVX87OG1fTy2sm+xZWWVPyDaPbWmW
         GXvH4AYr1BBTg==
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/4] Prepare for ECMDQ support
Date:   Fri, 13 Aug 2021 15:33:49 +0100
Message-Id: <162886058252.2822076.1201372357126525246.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811114852.2429-1-thunder.leizhen@huawei.com>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 19:48:48 +0800, Zhen Lei wrote:
> RFC --> v1
> 1. Resend the patches for ECMDQ preparation and remove the patches for ECMDQ implementation.
> 2. Patch 2 is modified. Other patches remain unchanged.
>    1) Add static helper __arm_smmu_cmdq_issue_cmd(), and make arm_smmu_cmdq_issue_cmd()
>       and arm_smmu_cmdq_issue_cmd_with_sync() implement based on it.
>    2) Remove unused arm_smmu_cmdq_issue_sync().
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/4] iommu/arm-smmu-v3: Use command queue batching helpers to improve performance
      https://git.kernel.org/arm64/c/eff19474b1bd
[2/4] iommu/arm-smmu-v3: Add and use static helper function arm_smmu_cmdq_issue_cmd_with_sync()
      https://git.kernel.org/arm64/c/4537f6f1e2d8
[3/4] iommu/arm-smmu-v3: Add and use static helper function arm_smmu_get_cmdq()
      https://git.kernel.org/arm64/c/8639cc83aac5
[4/4] iommu/arm-smmu-v3: Extract reusable function __arm_smmu_cmdq_skip_err()
      https://git.kernel.org/arm64/c/2cbeaf3f36eb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
