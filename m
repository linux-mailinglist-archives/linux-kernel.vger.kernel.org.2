Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6D349938
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhCYSJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhCYSJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:09:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9AA76044F;
        Thu, 25 Mar 2021 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616695772;
        bh=r8oiGX8PbZ7QTBwMmz9gonZogHqGaXWlVXCzwalFbJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvoY/FVCSoQpb89jqubMSpAK33j/6Ha7hMelMigvT0tY04aZi6TjLSpiA7DaOuuKr
         NZdrvFdfnHV0tqM3jD27YIGtNk8JL1unwIaEIMn1W6wp4++0ew+VFvlU63CSly2/SK
         PIuw0JbJ+7cwlvD7KWW3Pp6GqmwF9bfkk9RVurhpqOTjP3AUkN6bdEgtHdZ/nZUl1O
         fdOsHBGk58qI/8QHLEcYbl4BKGsMREf0W9LwelPRBbZgGnZRAPXxHbtNFaWgK3f010
         Mxmk6BCxibqswP1gPOYGfrax8o8c4qcoJc5Y70NSRCUbJIRdMY0hOFnF2Qmmy9w5l2
         2L1/OPbXpcxVg==
From:   Will Deacon <will@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Add compatible for SC7280 SoC
Date:   Thu, 25 Mar 2021 18:09:26 +0000
Message-Id: <161668482433.1639092.6431348459607978027.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615788144-29508-1-git-send-email-rnayak@codeaurora.org>
References: <1615788144-29508-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 11:32:24 +0530, Rajendra Nayak wrote:
> Add the SoC specific compatible for SC7280 implementing
> arm,mmu-500.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] dt-bindings: arm-smmu: Add compatible for SC7280 SoC
      https://git.kernel.org/will/c/a9aa2bb18ecb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
