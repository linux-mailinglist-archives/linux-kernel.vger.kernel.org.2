Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE54337AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCKR3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhCKR3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:29:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39BF264F8D;
        Thu, 11 Mar 2021 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615483739;
        bh=SUeqNhY4Z+cYtXpQCYJP8i17rbPK2GdEQhebAc/M+tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7QwP3mI/PxaXZL6Lzb4Uj8lOgGQvuW2ooWh1d9r7PlRtwnOnWkaL0lkxdH4Io8dM
         33c0SarypvZ0j+O+tOyGFO9XW23anKOIKjMUm0OdqHWOemnYHBfhgzeDCNLJ0YpAUu
         i9voLaJivgCho9e8soLqDIKUvVRT4O8Y4bPmk/+ITnD8F6sHo02xfh9vqMZIERS0PP
         YQmJQK+2mB+cVYY8FaaD5yvGFbtgsuHPhmiG5TZXZHiXZPtKg/WQZrnhRtxiFgju/B
         hsId/apbJy3etztRisBSXv9NedsezIP/q9J4pUoHKQdIce0ea7xWXXr3c2OACBNw3Q
         bmKHEV4MQEEiA==
Date:   Thu, 11 Mar 2021 17:28:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 17/34] KVM: arm64: Elevate hypervisor mappings
 creation at EL2
Message-ID: <20210311172852.GA31378@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-18-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-18-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:34PM +0000, Quentin Perret wrote:
> Previous commits have introduced infrastructure to enable the EL2 code
> to manage its own stage 1 mappings. However, this was preliminary work,
> and none of it is currently in use.
> 
> Put all of this together by elevating the mapping creation at EL2 when
> memory protection is enabled. In this case, the host kernel running
> at EL1 still creates _temporary_ EL2 mappings, only used while
> initializing the hypervisor, but frees them right after.
> 
> As such, all calls to create_hyp_mappings() after kvm init has finished
> turn into hypercalls, as the host now has no 'legal' way to modify the
> hypevisor page tables directly.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |  2 +-
>  arch/arm64/kvm/arm.c             | 87 +++++++++++++++++++++++++++++---
>  arch/arm64/kvm/mmu.c             | 43 ++++++++++++++--
>  3 files changed, 120 insertions(+), 12 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
