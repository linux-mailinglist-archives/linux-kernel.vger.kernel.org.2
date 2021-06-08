Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF9439F55A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhFHLou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFHLot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:44:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 791EB61364;
        Tue,  8 Jun 2021 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623152577;
        bh=bY8DNkX7vzFlmdAwO/oaPooA1JibNQ9/EzESl4Fuy0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vN/iDmxohvpkrpHSTgh8MhUcmx63RQRG/Nxlp6sMwZBn6On1oPgFBq1R5Tn4JApNp
         PjLM7/EJuwy85uF12XCr98DVywFSG+eSY0o4eJwSi8TMe+sYIwkgF5PhvLPlJiFk+d
         emy1LEfat7Lfu/dnAnqJ9TyC0znwHU00uyQJddcmG3wQ2LGDTehXRkVYTyWDZSk6C+
         4wiKMVUGS5Bagsd4W61/DnGWjKLb+FNZr9fJpRMifqDfbuudS5WguzPDnWilL0fsRw
         2sZgEBrCJwxjgNqDyb4+wFHFURNizHxkbwGeg3ZvEJ78MkVsOqgtPblA1DQuH+ca/2
         uLfh+6lSKKMNA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: Decrease the queue size of evtq and priq
Date:   Tue,  8 Jun 2021 12:42:37 +0100
Message-Id: <162314747848.3711241.13281936770478633279.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210531123553.9602-1-thunder.leizhen@huawei.com>
References: <20210531123553.9602-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 20:35:53 +0800, Zhen Lei wrote:
> Commit d25f6ead162e ("iommu/arm-smmu-v3: Increase maximum size of queues")
> expands the cmdq queue size to improve the success rate of concurrent
> command queue space allocation by multiple cores. However, this extension
> does not apply to evtq and priq, because for both of them, the SMMU driver
> is the consumer. Instead, memory resources are wasted. Therefore, the
> queue size of evtq and priq is restored to the original setting, one page.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Decrease the queue size of evtq and priq
      https://git.kernel.org/will/c/f115f3c0d5d8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
