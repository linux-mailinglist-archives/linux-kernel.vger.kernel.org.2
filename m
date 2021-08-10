Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAAE3E5AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbhHJNUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241185AbhHJNUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:20:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE91E60F38;
        Tue, 10 Aug 2021 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628601622;
        bh=i8aV5+sUyxbK8b8J3GdV5Q1yGwzOp1R2o33rDjK+wH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqSO0i7ySLnw7yIc8Eok1mNOrrXvrLrw/T559Lgl4LtbGnapFY3pDfSn3sWrxWoc0
         MFs6WyE3ASeGm7FdHxYFUdsaF6wxBgNMNNTs3cwI09DeRnPD70u5I13jEKoTyrRrKw
         2tOZbqULGJeDQua64XNnYlfSdBdaCY3q9QctVcWC+Sn/pYyAnE6HlP6/66L5H7D1GP
         Oop4mI7/SHPceddDvkb5f4tgb1O83AZ/z5EZvJYbkreZJHcsBBERTgwUEdLDK/tL22
         n/xzkteQewS12TQIff0Lqb7ypLAhv0RqAS1bZap3SR/LeKQP9aT8FOHFhYmo/ROfXl
         nRwvjdhREOenw==
Date:   Tue, 10 Aug 2021 14:20:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] KVM: arm64: Drop direct PAGE_[SHIFT|SIZE] usage as
 page size
Message-ID: <20210810132015.GA2946@willie-the-truck>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628578961-29097-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 12:32:37PM +0530, Anshuman Khandual wrote:
> All instances here could just directly test against CONFIG_ARM64_XXK_PAGES
> instead of evaluating via PAGE_SHIFT or PAGE_SIZE. With this change, there
> will be no such usage left.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 6 +++---
>  arch/arm64/mm/mmu.c          | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Why is this better?

WIll
