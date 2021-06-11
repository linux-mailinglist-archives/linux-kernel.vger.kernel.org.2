Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8923A4648
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFKQSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhFKQSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:18:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1683613FA;
        Fri, 11 Jun 2021 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623428163;
        bh=auQ7lw/e0XSmoS6xpReg018/FKMQ8EwKCFSeQiuUWoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTVLvfC5wHyuL8MhVMl+UVXyQrMMGTJzwnIWwk0kzi5gWS0ixsrrH78uNyUY6VmMy
         spu7nNvbGYuS41I3OZgArRUr6y/JOs3qh4XZJvuKC70/hhN71Nt/EzT74N3rlMrNRs
         UNVHT0t+TVPwT/YSmb5hYf6qf0/fg6W3D2WsqkRSITO268pLD/J93FWXE/woaDS4j2
         q5DAvA3dVkkUotTUAkOMFOFubiBUMnEZ0/4F0gQIWi3x+uZsFQBw47vJgqFhEZw9ib
         W1Q1ouwLLeWeZmHERHNH778q5RPHr9+FWucFdm0Fwr+Hs8pVEtOFldNcYOZD9mOKHG
         DZWIOJB+kkpoQ==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        linux-kernel@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Xin Tan <tanxin.ctf@gmail.com>,
        yuanxzhang@fudan.edu.cn
Subject: Re: [PATCH v2] iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
Date:   Fri, 11 Jun 2021 17:15:44 +0100
Message-Id: <162340794186.3698890.4788653563160979192.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623293672-17954-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1623293672-17954-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 10:54:29 +0800, Xiyu Yang wrote:
> arm_smmu_rpm_get() invokes pm_runtime_get_sync(), which increases the
> refcount of the "smmu" even though the return value is less than 0.
> 
> The reference counting issue happens in some error handling paths of
> arm_smmu_rpm_get() in its caller functions. When arm_smmu_rpm_get()
> fails, the caller functions forget to decrease the refcount of "smmu"
> increased by arm_smmu_rpm_get(), causing a refcount leak.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
      https://git.kernel.org/will/c/1adf30f198c2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
