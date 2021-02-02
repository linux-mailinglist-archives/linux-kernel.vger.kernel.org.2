Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9A30C9D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhBBSaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238501AbhBBSZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:25:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6ED064F5E;
        Tue,  2 Feb 2021 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612290268;
        bh=W1IuyyCVtN9nb9HYjJ7+xdSm5mp9t0pkfUAf4II4elY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCAib0qBVSZ78VMBIzFz/4NCH8++z5N6UdDRJkDlw37aocpi0MBKKJ+WH45WxIl8x
         XityNuus+I6AnlCsqL35HXBZjYgqGnGGIZOX9wzgnZybZwQWJqRY1dkysF2zA4KvMw
         LaXlTTwHrxlMOGQU3Hcn+MVjiSclDb7u1o4dtOQPahlEKqEwP4sN4OpUavXF810Qsi
         rv3HG+zAablMOyxAmLPWtAEC3+DelKN6XEsjcZWdl5J/B8txVfqYh3zBAULgMG5tL2
         3DaOY7PUObl8/TzMrMCykQzmmkM9Z4jNf25kTcyuJo6WYkutPqyo25m+yERPVL1Ogq
         15JGQc/HdLr8w==
Date:   Tue, 2 Feb 2021 18:24:22 +0000
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
Subject: Re: [RFC PATCH v2 14/26] KVM: arm64: Factor out vector address
 calculation
Message-ID: <20210202182422.GB17311@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-15-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-15-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:12PM +0000, Quentin Perret wrote:
> In order to re-map the guest vectors at EL2 when pKVM is enabled,
> refactor __kvm_vector_slot2idx() and kvm_init_vector_slot() to move all
> the address calculation logic in a static inline function.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 8 ++++++++
>  arch/arm64/kvm/arm.c             | 9 +--------
>  2 files changed, 9 insertions(+), 8 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
