Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C9349939
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCYSJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhCYSJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:09:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C74661A26;
        Thu, 25 Mar 2021 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616695775;
        bh=IK7RaZ38tGD05wufzzYh3po/BlI1i3qxmYoN/2G5xlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d03GQxWjOKR/Hapbm4ncwQi/8OHaSBsGSa2lDmC6zPtc7zBDSWTYYAuAvroWSAIs3
         5okV+oLX+ErRAH6wTFdm4IHNsP3U4cHcfhApRTn4WZZO24+FVP0Hl85lGkDHhRcHkg
         p5AgpDJ3Ad0I78pmH15edRLP+zbYLcxcd8YrbeZ+iPk8zEOC71tQSFqszraM7lFi/e
         TWanVSyFnDVj4tGYLJuM+F80nEhtxeDjFKSBwVF8T8nI+FtIr4jV6lR2QFDcjdDpV6
         QDR6uzOn1PmMXcwRzWfdj7LpDrK9hGAN5OCvHKUB17Eb3IB2YNoVX4MYgDc202ULm9
         lcQlLEJC3jgNg==
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Rui Zhu <zhurui3@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add bit field SFM into GERROR_ERR_MASK
Date:   Thu, 25 Mar 2021 18:09:27 +0000
Message-Id: <161669343969.1653955.1039033291680251791.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324081603.1074-1-thunder.leizhen@huawei.com>
References: <20210324081603.1074-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 16:16:03 +0800, Zhen Lei wrote:
> In arm_smmu_gerror_handler(), the value of the SMMU_GERROR register is
> filtered by GERROR_ERR_MASK. However, the GERROR_ERR_MASK does not contain
> the SFM bit. As a result, the subsequent error processing is not performed
> when only the SFM error occurs.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: add bit field SFM into GERROR_ERR_MASK
      https://git.kernel.org/will/c/655c447c97d7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
