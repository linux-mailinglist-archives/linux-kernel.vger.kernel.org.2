Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11EB420A93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhJDMHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232591AbhJDMHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:07:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25B3F61215;
        Mon,  4 Oct 2021 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633349144;
        bh=c6LEDjMveuaB/U/2rmlfIhlH+c99dwL8fKFv9i/sGXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJarSqwsXSdTSsyPNMFF+Lkir8x+NXdxnVPOMwMAX7+ZypzSijOh/Z5VA0q+T/z/+
         6ZyjHbIvPVyG+Nx+hsmBcaNG5A7+wCdxvICcS7wsah+PmnCG+t+S5wUPPOJayNDjn+
         9Sd/GYX1v8J8zHqulRJpa5QfR88ewty6iAn/8xkpjDli+x0C85Sy5qYXosHvtkw0X1
         DbDjHpG/FqpgGkVLyE+UEwd8JcJ0UjqEjPST4RrEce2ygGpLaL/7HVU6C0IHCSnSuG
         oARAWdNXqHIoSH/bVoWc1PAn7XioaXxE7zs2L9j73PIBr6oSvKMEPMYYpBkSVr5q7D
         FfkHjpB59e3QA==
From:   Will Deacon <will@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        martin.botka@somainline.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@somainline.org,
        iommu@lists.linux-foundation.org, jamipkettunen@somainline.org,
        Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for SM6350 SoC
Date:   Mon,  4 Oct 2021 13:05:33 +0100
Message-Id: <163334664315.1581907.12696776880512874722.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210820202906.229292-1-konrad.dybcio@somainline.org>
References: <20210820202906.229292-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 22:29:04 +0200, Konrad Dybcio wrote:
> Add the SoC specific compatible for SM6350 implementing
> arm,mmu-500.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu: Add compatible for SM6350 SoC
      https://git.kernel.org/will/c/e4a40f15b031
[2/2] iommu/arm-smmu-qcom: Add SM6350 SMMU compatible
      https://git.kernel.org/will/c/bc53c8b8b087

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
