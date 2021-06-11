Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A03A4646
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFKQR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhFKQR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:17:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94582613D9;
        Fri, 11 Jun 2021 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623428160;
        bh=X8fq5Ssa8KruLdrdCiVfEs1JgSpE6Roo0bK+wmejB+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toHI7dqFyFs3RVKe8lF5VXSfnke6XT3P1GGiJdTo3FqWDIkpD/UMJwpTTHHUR++k8
         TW6DmDB2XMJ4JqU9PbTHevr/DPIp/EoUPcmedvAkTGvZbw4FnQVOdzrs2NEYcocnYy
         lKsNALRdXg2ITl7mJcJK3fHjp4ywSZORfvfwmJFPyomJ3R7tCU9tdHsD5gQGkJ6d+6
         J82qegUsU7v8pMbKZvDrhe2ADs9S795kAKWQbQ5eYOPo8I1xNN1j5OAM9sOxPdPzBI
         kRj5HSOqzcd1kfXsJGXUS7jwCLDaTgP9K23UVsfvdJwuPtUK2xSTE1/IYxgMVFGgKV
         V+ghr6emt7k9A==
From:   Will Deacon <will@kernel.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Rob Clark <robdclark@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Xin Tan <tanxin.ctf@gmail.com>,
        yuanxzhang@fudan.edu.cn
Subject: Re: [PATCH v2] iommu/arm-smmu: Fix arm_smmu_device refcount leak in address translation
Date:   Fri, 11 Jun 2021 17:15:43 +0100
Message-Id: <162340795809.3699041.237536515051087882.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623293391-17261-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1623293391-17261-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 10:49:20 +0800, Xiyu Yang wrote:
> The reference counting issue happens in several exception handling paths
> of arm_smmu_iova_to_phys_hard(). When those error scenarios occur, the
> function forgets to decrease the refcount of "smmu" increased by
> arm_smmu_rpm_get(), causing a refcount leak.
> 
> Fix this issue by jumping to "out" label when those error scenarios
> occur.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Fix arm_smmu_device refcount leak in address translation
      https://git.kernel.org/will/c/7c8f176d6a3f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
