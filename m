Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221393A7DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFOMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230302AbhFOMJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:09:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2B1961462;
        Tue, 15 Jun 2021 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623758821;
        bh=rEL7+PHdIxvgE3FMT8IM5yXjwKgJoUfgtbzsHUr2xZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKOp/Vk8M27VAvvOEHfKa4pml24mPGYErsbIHq9QFQNzu8inX0onoBvgP8I0apXE0
         HL4sCpPw+BicNE01zDaT1dmRBLPQVoB4PjmxtCwpSHPc065i+vJyIUiCyzpNWlqXOd
         /ZyeJ/8C9/MdjqZM5xVAmknIojpgoxBjSm8kp8pYOq+YeH4pJaRU7R1PsTgBNF+5Iy
         nexiKvFuzRRBEy9rVvM1yAxZ+f5yDgGMZWfdU4dzicMlhRDpq7vdLoelc34dcb76UM
         FnmZLLmOr4Nk/I9RpiBpsS2Su7Z9xzKbHDsitBWILfiSUtHinqvWbGu3Ybrrs/t/wI
         flW2V/1NwQlxQ==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/mm: Drop SWAPPER_INIT_MAP_SIZE
Date:   Tue, 15 Jun 2021 13:06:51 +0100
Message-Id: <162375529175.2680379.14396302085668277562.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623665411-20055-1-git-send-email-anshuman.khandual@arm.com>
References: <1623665411-20055-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 15:40:11 +0530, Anshuman Khandual wrote:
> The commit cdef5f6e9e0e ("arm64: mm: allocate pagetables anywhere") had
> dropped the last reference to SWAPPER_INIT_MAP_SIZE. Hence just clean up.

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Drop SWAPPER_INIT_MAP_SIZE
      https://git.kernel.org/arm64/c/0f473ac746a9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
