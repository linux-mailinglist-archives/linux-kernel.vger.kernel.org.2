Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69BC41CB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345334AbhI2RuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345272AbhI2RuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:50:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05E2561361;
        Wed, 29 Sep 2021 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632937716;
        bh=flVinZZluinTpML7hGLvjHlO/g3I8NE+6pnRDd1Kdzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PtfZ37Se+g5ZAq9dkNrMNAGmj1FeyLA3JtJAsr/t0KP6WNBwrjne5Tfek2VvZpTtM
         6HpRJbPeYU3fjvco7C8/SjOFao4OcZzQWX3zVQv6oJXvNyryG5g80rnKWXb/tF0AcS
         L58U5xWBiUf3z1CyD8U6Q1UQnFt8eD7VtMtY3bpkQ4farsNobQVj3Sj/uOWwCND1Nu
         tvufM1HWYvjUvgKSgULciTQ/ngzoBnlO8C1HML148f6KInQVFR5AE7bdY7akh6bfMz
         HNrwWTDUcHh9W85IWciFbb4r7OgKkFbbvh4WXQyvWjfhYOmOqdActxqdhHaBmeAaw1
         W+JhiCXEC0iag==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH V2] arm64/mm: Add pud_sect_supported()
Date:   Wed, 29 Sep 2021 18:48:23 +0100
Message-Id: <163293087332.927113.5526863542809374103.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1632130171-472-1-git-send-email-anshuman.khandual@arm.com>
References: <1632130171-472-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 14:59:31 +0530, Anshuman Khandual wrote:
> Section mapping at PUD level is supported only on 4K pages and currently it
> gets verified with explicit #ifdef or IS_ENABLED() constructs. This adds a
> new helper pud_sect_supported() for this purpose, which particularly cleans
> up the HugeTLB code path. It updates relevant switch statements with checks
> for __PAGETABLE_PMD_FOLDED in order to avoid build failures caused with two
> identical switch case values in those code blocks.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Add pud_sect_supported()
      https://git.kernel.org/arm64/c/f8b46c4b51ab

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
