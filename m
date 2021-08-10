Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5ED3E8448
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhHJU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhHJU0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:26:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 910E960F13;
        Tue, 10 Aug 2021 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628627163;
        bh=M/gnx8A37cYi/RDawoflYj+z3IDmvAjd8upAEDz9esk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVyzkRR7dz1I8A71AVZ9lXDMwcNEDyYltsZvLNHAn5xLieb1pReRv8tfvyyQUtnlF
         4QRuZgxcF0uh6tHCwZVzksts4/YIbTqwgVZk3bFw1EwldWBCSUUucfTVxXxQz/4VQR
         7xCbkYhHydV4j0hP5zgKze1qJb8QS0CWXkXuTQZpLFwbwNvhVThq/NQAmFdci+Gh3h
         CIqjEcgam7ufabC88dgvI2UU55vTU/rp/jTI/mbM2Kw+5pINWfuX2crRXk+MAOHUg4
         diT3vHlTWh7zbsacTTJJsj/WUpclce2rfFgKa4hyMFe08BkXYr1CLf/PdBfI4Riq9T
         +vSnHZGuZJAHw==
From:   Will Deacon <will@kernel.org>
To:     robin.murphy@arm.com, vdumpa@nvidia.com,
        Ashish Mhetre <amhetre@nvidia.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch V3 0/2] iommu/arm-smmu: Fix races in iommu domain/group creation
Date:   Tue, 10 Aug 2021 21:25:54 +0100
Message-Id: <162861955924.3590382.10228157894867875931.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
References: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 10:13:59 +0530, Ashish Mhetre wrote:
> When two devices with same SID are getting probed concurrently through
> iommu_probe_device(), the iommu_group and iommu_domain are allocated more
> than once because they are not protected for concurrency. This is leading
> to context faults when one device is accessing IOVA from other device.
> Fix this by protecting iommu_domain and iommu_group creation with mutexes.
> 
> Changes in v3:
> * Updated commit messages.
> * Added Signed-off-by in patch 2.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu: Fix race condition during default domain allocation
      https://git.kernel.org/will/c/211ff31b3d33
[2/2] iommu/arm-smmu: Fix race condition during iommu_group creation
      https://git.kernel.org/will/c/b1a1347912a7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
