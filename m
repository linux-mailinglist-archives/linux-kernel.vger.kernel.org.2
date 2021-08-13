Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874C93EB6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbhHMOeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhHMOeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:34:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07B9E6103A;
        Fri, 13 Aug 2021 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628865234;
        bh=d0BeRz2Oi17JZJ39SH5fmnNP/U0hTjWRV5pfhm+LWBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkwS8opmptLBwTpvdVUX6Ijyab8gX6A0LxK/5hNHqEGkP0pi1uxRXtVzDS2JwVmzm
         A3tr0cMkJJW8BEr6GPEydxX+z52qoJyYxahcF4lel1vBUfJUrfKvBe4S/fd6INAIX3
         YreruVZt8SqimHw2UMUkXqO8tq3wlCqtZtDosybi0rmU8RZb4D2dzd6aeF9+xP7bix
         U0q0y7NV9A+GrirhXoMlAPhqksYjzPjELzZS/rNtmi4W2I+ohx30EisbFgGQr4l3dE
         0QHliUBIzMNTX/saBqeYAKNBtEaNi28oInJNOke32t7D7sUs5CW4SuC0rbB1HFfMLc
         mZ5bjW/5xpXiA==
From:   Will Deacon <will@kernel.org>
To:     robin.murphy@arm.com, John Garry <john.garry@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, thunder.leizhen@huawei.com,
        joro@8bytes.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop pre-zeroing batch commands
Date:   Fri, 13 Aug 2021 15:33:47 +0100
Message-Id: <162886116698.2824022.16783624022186581694.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1628696966-88386-1-git-send-email-john.garry@huawei.com>
References: <1628696966-88386-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 23:49:26 +0800, John Garry wrote:
> Pre-zeroing the batched commands structure is inefficient, as individual
> commands are zeroed later in arm_smmu_cmdq_build_cmd(). The size is quite
> large and commonly most commands won't even be used:
> 
> 	struct arm_smmu_cmdq_batch cmds = {};
> 345c:	52800001 	mov	w1, #0x0                   	// #0
> 3460:	d2808102 	mov	x2, #0x408                 	// #1032
> 3464:	910143a0 	add	x0, x29, #0x50
> 3468:	94000000 	bl	0 <memset>
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Stop pre-zeroing batch commands
      https://git.kernel.org/will/c/fac956710ab0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
