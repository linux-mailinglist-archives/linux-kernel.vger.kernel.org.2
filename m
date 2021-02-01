Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FAD30A847
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhBANGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:06:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBANGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:06:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8693C64EA2;
        Mon,  1 Feb 2021 13:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612184738;
        bh=MM8WH0IvCN8GfFKYW8sdTTYdArhCxEvBpBqATMu+6UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je8UoaT41GN2v+qvPQaftc4km4+KO4QvUkH+0YL1qsKJWH+e+xDl/04UYBazvz2yw
         gMl4DkdN+bwcSVpH45DuT0jt44HmieyGOONDy3Kcb48PigezF5kjbthaPhCqygofWe
         iFoJKHEFLFVfsnlVr9wXfygIvonW49qYk9wCBP2z0YxaHV4DNJN0f/TS/prWyslKTv
         oQcU63vXCInVw+1vmZ/3YiXrrkPQy6hksvOzZmunLh+8PqHUQjqaSAP+Qve5ZWGhTi
         trrNTMn0f40t0s9Wfd/62+9xv+S+rndYtzeDxpNYjI8DO1J7uEkRBM/TrEiN9bAR6p
         J8v70H2zz7I6w==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, John Garry <john.garry@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, thunder.leizhen@huawei.com,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] driver/perf: Remove ARM_SMMU_V3_PMU dependency on ARM_SMMU_V3
Date:   Mon,  1 Feb 2021 13:05:32 +0000
Message-Id: <161218318071.2645311.5418215713079588987.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1612175042-56866-1-git-send-email-john.garry@huawei.com>
References: <1612175042-56866-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 18:24:02 +0800, John Garry wrote:
> The ARM_SMMU_V3_PMU dependency on ARM_SMMU_V3_PMU was added with the idea
> that a SMMUv3 PMCG would only exist on a system with an associated SMMUv3.
> 
> However it is not the job of Kconfig to make these sorts of decisions (even
> if it were true), so remove the dependency.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] driver/perf: Remove ARM_SMMU_V3_PMU dependency on ARM_SMMU_V3
      https://git.kernel.org/will/c/34eb9359c111

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
