Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4E420A96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhJDMHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233134AbhJDMHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7556061215;
        Mon,  4 Oct 2021 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633349149;
        bh=97kgmJBa0qL8A5UxMz3vj6lMPTHTmg9/W7lY7JruH7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y41TowH1y/OerqL/AS1oT8JSyc7icR5rmPPeJdoW/ig3m/RuxwbbqhgTIETFKb8q8
         xgKniB7v2ZJuP0cGEeS+J/U5nDjRGxNxMd1SVlUAIHp3ZsZxkU8b04q8H1+TYZHwoJ
         TZntYoAQI+rXokEK/EnZwXUSgCdPq6WQeUf+0XqbA1lw685O1t6cj+Cut4sUb2c5AB
         iHZuv7Aibl3H7ZEX4JvisO7eKGtCAS0dJvE+kgxv5tnHS5GOaHrigP8CViLu3HILdv
         WSDvgBL2UyHw0DqeE0g/Oo3oC2zCd8bP6fm4Ulmd0AoPj8w4wBOAIT0cmnWVVA3rfK
         Dc6emV/Fmeteg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        iommu <iommu@lists.linux-foundation.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop pre-zeroing batch commands in arm_smmu_atc_inv_master()
Date:   Mon,  4 Oct 2021 13:05:35 +0100
Message-Id: <163334645081.1581475.7922976720083700299.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210817113411.1962-1-thunder.leizhen@huawei.com>
References: <20210817113411.1962-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 19:34:11 +0800, Zhen Lei wrote:
> Pre-zeroing the batched commands structure is inefficient, as individual
> commands are zeroed later in arm_smmu_cmdq_build_cmd(). Therefore, only
> the member 'num' needs to be initialized to 0.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Stop pre-zeroing batch commands in arm_smmu_atc_inv_master()
      https://git.kernel.org/will/c/93f9f7958f12

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
