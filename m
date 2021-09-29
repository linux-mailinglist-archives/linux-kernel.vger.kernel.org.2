Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EB241C8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbhI2PzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245740AbhI2PzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:55:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F63160FA0;
        Wed, 29 Sep 2021 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632930814;
        bh=uEB7waoBI1fsFWcFkbUd52mOvV43dk+iz1OQQ6eGAs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhfK1xg/+azJIJECGx2MEBGxaCxIQlJVIfzX6+ALentONlFVSuD/mDBT3jQCRjPzM
         zXAazTZ+QTASPy3yqTnF8Ign8olbao4VgwsShjtc3VxzZV78KkFUru8tSgGhThuZ7H
         p2NNnjDuXhE+ElpLLdZNsY/FT9Wn1UcUt+Zig9M1ltgzRuvK+SBC8mVyU0F5RwLmRW
         inV8EdFSu1fXT12TRtLow8BRMQRw9NilDRDlWuNlVhKp5puuyWDfJ9JmZd4tcMphEZ
         hKKkiB6Lw6maRopT+mcDqx0YUsEZ9kxnWM1jfrDPzk64UNNwN8Twcgaxd8IOZVAd4Q
         YWHgJmaTEh2bg==
Date:   Wed, 29 Sep 2021 16:53:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: arm64: Depend on HAVE_KVM => OF instead of
 directly on OF
Message-ID: <20210929155328.GD22029@willie-the-truck>
References: <20210921222231.518092-1-seanjc@google.com>
 <20210921222231.518092-3-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921222231.518092-3-seanjc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 03:22:31PM -0700, Sean Christopherson wrote:
> Select HAVE_KVM if the KVM dependency is met (OF / Open Firmware), and
> make KVM depend on HAVE_KVM instead of directly on OF.  This fixes the
> oddity where arm64 configs can end up with KVM=y and HAVE_KVM=n, and will
> hopefully prevent breakage if there are future users of HAVE_KVM.
> 
> Note, arm64 unconditionally selects OF, and has always done so (see
> commit 8c2c3df31e3b ("arm64: Build infrastructure").  Keep the somewhat
> pointless HAVE_KVM dependency on OF to document that KVM requires Open
> Firmware support.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/arm64/Kconfig     | 1 +
>  arch/arm64/kvm/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5b13a932561..38c0f36a5ed4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -187,6 +187,7 @@ config ARM64
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>  	select HAVE_IRQ_TIME_ACCOUNTING
> +	select HAVE_KVM if OF

Honestly, I'd just drop the 'if OF' here. We select it unconditionally a
few lines below and so I think it's more confusing to have the check.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
