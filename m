Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A43ABF0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhFQWlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232180AbhFQWkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:40:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C33C4613E9;
        Thu, 17 Jun 2021 22:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623969522;
        bh=a4dBuG/a3oG0tKglZCN4sWMO5PsJEFISDC1+iX1wPnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVUkazckL1w0mnpYELOxRgUkzfRnsu3k+0QV6mcbAUT7r4eObwunpcwF864fEc2DU
         khUBWFrN+hmmjAiqxAyduFimmGxJCa45lUREO4Q2pi6I23OUCXA9JD9lWVucAhdkDX
         xJ+qhfWKqJDMHsPmOm6dQBiCYx4JqQbuvIjygf7qtHS0d1R1Obia+3d6hSSpXM8d7N
         ca88AbCkcofYBUF/HRv+j658aT/BcDCKu8vtY5rzyjGSG0PHaPf4mTe/3y0fVuxWZ4
         yO76btAc/t6MWeOzIBSlfiF9xQ50DyH/ZxiX/KB+NBYMC6Wjuauaw8R1uYbF+zwmRP
         xQIOhJYfJ+kOQ==
From:   Will Deacon <will@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: KVM: Bump debugging information print down to KERN_DEBUG
Date:   Thu, 17 Jun 2021 23:38:34 +0100
Message-Id: <162396615830.1467937.16143448603491809431.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617073059.315542-1-lee.jones@linaro.org>
References: <20210617073059.315542-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 08:30:59 +0100, Lee Jones wrote:
> This sort of information is only generally useful when debugging.
> 
> No need to have these sprinkled through the kernel log otherwise.

Not sure why this has "KVM" in the subject, so I replaced it with "smp".

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: smp: Bump debugging information print down to KERN_DEBUG
      https://git.kernel.org/arm64/c/cf814bcfa1e6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
