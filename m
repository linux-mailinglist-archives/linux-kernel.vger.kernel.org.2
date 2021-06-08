Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF339F556
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhFHLoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFHLop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:44:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C325A61360;
        Tue,  8 Jun 2021 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623152572;
        bh=fGah1+p/pv2388oRBq6wxQPYcwlfBCFXSQHmKKgtJbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2h0RGsquAxhM5p1pqkyitd0GSbNPqdcCFY2sdVRH0rsrJ1U2bzL9bPEwwHXWfKe4
         x6wNauyM8MLjB4+kz9RKO2hZVgDUv5+J3HMuVyOUIZHE/gD7e6pdxZWA+Idm6cnUAk
         Nm+Aui2H3fvK1TK2frluOqPNPXdcAo1PxkTRSrG7eOPV82O2iQXm9vT2T3xBaohqfN
         yiwjlMtlx3a6q7OvjSmbF3oizJb1Urdiwx4bmqu4mR0fqKrW1/OTgrO7wlN/Ed1nld
         F3tYOmZdFFAzHRX1i/b9Wp5KnQw8rK0IDLEu4X9T2MNZ31dRQBRJdREWE8tsXx5+dr
         n7Kmb1hb8U9Ag==
From:   Will Deacon <will@kernel.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        ~postmarketos/upstreaming@lists.sr.ht,
        marijn.suijten@somainline.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, konrad.dybcio@somainline.org,
        Rob Clark <robdclark@chromium.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        angelogioacchino.delregno@somainline.org
Subject: Re: [PATCH V2] iommu: arm-smmu-qcom: Add sm6125 compatible
Date:   Tue,  8 Jun 2021 12:42:35 +0100
Message-Id: <162314671954.3707273.3414160134891891543.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210523212535.740979-1-martin.botka@somainline.org>
References: <20210523212535.740979-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021 23:25:33 +0200, Martin Botka wrote:
> Add compatible for SM6125 SoC

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu: arm-smmu-qcom: Add sm6125 compatible
      https://git.kernel.org/will/c/6321484d1c24

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
