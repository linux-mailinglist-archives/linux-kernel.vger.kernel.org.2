Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3759130DF63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhBCQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234927AbhBCQIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:08:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 101D264F9B;
        Wed,  3 Feb 2021 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612368365;
        bh=GNyZIbhSMsMA+IdaAyNXFV3wbRVRMl0Dn1D0Eg9euXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FO9H6iajc6NVqYVl4y5je/YxxoDHEFiT2NosmwBHrOBdYZi5oFgx0buRz+Bq1V8UA
         czLa4+xX/opvBFh8yb4fHjTdDyB6M5onZzQ20opl3i4yaX/bOlKYcycLb0rKOWI/NG
         mFjcYWp1jS7FxsSzlU8zLmEL8lQMA7tm+YMyNF2zl9jXsS0TsjcLAWALn3TncBqA3q
         XPYRLOAPkkKjTnSQl2XGVs8tIspIlbLQ8gigJvAEEnLyVBufLTa0X5rASMYZ+Ec1zx
         rUCFiK3OLYBAXt0rCyHniYKy0rm0+SQlUPMGdohf8CfYe4Vu2EX/ip48sGX1DEQoRO
         BgdqTVMBtro+w==
Date:   Wed, 3 Feb 2021 16:05:58 +0000
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
Subject: Re: [RFC PATCH v2 20/26] KVM: arm64: Set host stage 2 using
 kvm_nvhe_init_params
Message-ID: <20210203160558.GI18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-21-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-21-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:18PM +0000, Quentin Perret wrote:
> Move the registers relevant to host stage 2 enablement to
> kvm_nvhe_init_params to prepare the ground for enabling it in later
> patches.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h   | 3 +++
>  arch/arm64/kernel/asm-offsets.c    | 3 +++
>  arch/arm64/kvm/arm.c               | 5 +++++
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S | 9 +++++++++
>  arch/arm64/kvm/hyp/nvhe/switch.c   | 5 +----
>  5 files changed, 21 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
