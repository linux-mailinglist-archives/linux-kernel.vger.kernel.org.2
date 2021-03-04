Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61E732D57E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhCDOjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhCDOjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:39:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E75764F53;
        Thu,  4 Mar 2021 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614868712;
        bh=8HCRgaAXUQKJEYk45KGjzpayiZSJL7Z75jrU+D65Qeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5yEwJIaq0J3G+LX6gOVqkHLOFA7A1fzuRqCO9TA3yz2kYuwqLKdBrGz76rPD96U2
         cKxMcAvYWFIn0mO4mwEXY8GDmT7CujlI2LMHCeYDKCxCFT+MS7YUtSLUZgseGev/xB
         nGDRIQhE3SgnpSPCaLFPVNGxI9ZIEar6b0EurD8f6+x6FTn+2mosIODf05n8Fhps7T
         6QAmQ2r7uAqH2YL1JnUMvggdafAHFhTeRJA6Ahi2Z9kxafeSU3qpbvvwMD8QMRRMdf
         M7fZC0WyDhSD4F/RBO4PNluP+ce8uxYNzwoR2gYlXfFBH1z7UPaIWt7zo1b4j71CLe
         LtYItYCXzSl+w==
Date:   Thu, 4 Mar 2021 14:38:25 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 10/32] KVM: arm64: Introduce an early Hyp page
 allocator
Message-ID: <20210304143825.GA21410@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-11-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-11-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:40PM +0000, Quentin Perret wrote:
> With nVHE, the host currently creates all stage 1 hypervisor mappings at
> EL1 during boot, installs them at EL2, and extends them as required
> (e.g. when creating a new VM). But in a world where the host is no
> longer trusted, it cannot have full control over the code mapped in the
> hypervisor.
> 
> In preparation for enabling the hypervisor to create its own stage 1
> mappings during boot, introduce an early page allocator, with minimal
> functionality. This allocator is designed to be used only during early
> bootstrap of the hyp code when memory protection is enabled, which will
> then switch to using a full-fledged page allocator after init.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/early_alloc.h | 14 +++++
>  arch/arm64/kvm/hyp/include/nvhe/memory.h      | 24 +++++++++
>  arch/arm64/kvm/hyp/nvhe/Makefile              |  2 +-
>  arch/arm64/kvm/hyp/nvhe/early_alloc.c         | 54 +++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c          |  4 +-
>  5 files changed, 94 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/memory.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/early_alloc.c

Acked-by: Will Deacon <will@kernel.org>

Will
