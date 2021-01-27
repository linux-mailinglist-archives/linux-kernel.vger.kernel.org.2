Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD94D306781
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhA0XFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233556AbhA0XBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:01:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E95F164DCE;
        Wed, 27 Jan 2021 22:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611786167;
        bh=XlDDbXd58PRQLQnVBVMxsMBxLbjIOdstTUlWPOs1plY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkuVkySLPNkaRm8Qzv68SuVxwtHoJVIUTGuN7vBFH6O788iez+gbUX74iv6iaQV2Z
         DUH/rqf/I4cYO6BTBoThYav/tey+78ZfnB2Daw0heFFnmKmDPb68LtQYjMOf9O0Z9l
         McbmPCoO/m4Vk5287UPDWGjwXuuDiyNYiXtjUlQ3OdTz4JFQ0rtL/q1PKA4Dgr60/2
         PfH6jWxW4KT/6WbtwyhruADXCJmmbciW9sZGh/qWHnH3IxqwDskoTjNcx+WJoCE1QZ
         kszf8ogtK5X5Gx9xssXhB2UbTTwGAzj8uiHNRQN1nB3aVc1AfvZYIN0xGtJVGDtnIm
         JM7QEHX48cAKw==
Date:   Wed, 27 Jan 2021 22:22:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: mcs_spinlock: Drop smp_wmb in
 arch_mcs_spin_lock_contended()
Message-ID: <20210127222241.GC848@willie-the-truck>
References: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
 <20210127200109.16412-2-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127200109.16412-2-alexander.sverdlin@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:01:09PM +0100, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Drop smp_wmb in arch_mcs_spin_lock_contended() after adding in into
> ARCH-independent code.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  arch/arm/include/asm/mcs_spinlock.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
> index 529d2cf..d8fa921 100644
> --- a/arch/arm/include/asm/mcs_spinlock.h
> +++ b/arch/arm/include/asm/mcs_spinlock.h
> @@ -8,8 +8,6 @@
>  /* MCS spin-locking. */
>  #define arch_mcs_spin_lock_contended(lock)				\
>  do {									\
> -	/* Ensure prior stores are observed before we enter wfe. */	\
> -	smp_mb();							\

I think this is the right place for the barrier, not in the core code.

Will
