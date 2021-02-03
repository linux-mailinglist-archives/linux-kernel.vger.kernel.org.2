Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC330DE69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhBCPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234531AbhBCPis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:38:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88CCD64F8C;
        Wed,  3 Feb 2021 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612366687;
        bh=Qak6mhwDNjguVOOBu6kwlKWIJ1viPAqdFwNyzm7XLsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WE08rcuIZPrjb3tZ2Brfsaz61cnJTNscqfNeBsiftXJXvl0RFgDQMRQGsL9y4bvdz
         hRIEC9eV1iTFkGbVHirIkUTAbNC1fNlLxM3S6Ldc+fjAksC1NLVwUMWZKm6KlkRNbZ
         oxlaa7Y1p8USkggIuj3MNcsY6nu0QM8R6BUBq2hny0vI1g2a8ZiehGC7e7hI6OQCeD
         FnNkbnkIpmUgzCJs85nPzlOTQtPEiz0XhLSxv+5egwoARq3K8t2NEMo1GargXbJQgv
         h3MDcVD8FlPpYXhzKd9A8jHHWQaFTXJDy8gC3cs4x+2yDybuQSO1tZ5hQGV3sB84qo
         aRTYgR+mHu8Qw==
Date:   Wed, 3 Feb 2021 15:38:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 19/26] KVM: arm64: Use kvm_arch in kvm_s2_mmu
Message-ID: <20210203153801.GD18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-20-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-20-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:17PM +0000, Quentin Perret wrote:
> In order to make use of the stage 2 pgtable code for the host stage 2,
> change kvm_s2_mmu to use a kvm_arch pointer in lieu of the kvm pointer,
> as the host will have the former but not the latter.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 2 +-
>  arch/arm64/include/asm/kvm_mmu.h  | 7 ++++++-
>  arch/arm64/kvm/mmu.c              | 8 ++++----
>  3 files changed, 11 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
