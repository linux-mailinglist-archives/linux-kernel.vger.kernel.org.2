Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810303E5B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbhHJNWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241248AbhHJNVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:21:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57CE260F38;
        Tue, 10 Aug 2021 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628601690;
        bh=jqyHZ175J/Gvvs023uqRUmo52RsbbfMGvn++lpbF66s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+a4GHR4h1dHtT1sJaTfvsu8J2/xAVbb8xQvxOWtAZkgpn26IlUZ/GFV/gaQYEbGV
         lPxKHhT2GkVeHO6Xwvno6jh1lBza6SRE8pvMIqH/Rh3wl/+LCzNUK1nQLQxcfO7Bba
         OId6prpx1+pskLJVHqM3W0VaZjMdN8WDujnwOd3kKK1QTuEpqYAuV6pbX9s1+MQicX
         6re4qQcHFaRDpWO4wq6WRcP7bMmn/hi7L5k3sc+yZ107nm1nFUWIC4C12AEM3i4um6
         q3JD/05M7BgrMyMwt5l72dUcXFqH1rrruzEzn0A08IFety7rDlp8ODT2jTXG7z6MLr
         PoAnqpxa3E6pw==
Date:   Tue, 10 Aug 2021 14:21:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] KVM: arm64: Drop init_common_resources()
Message-ID: <20210810132123.GB2946@willie-the-truck>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628578961-29097-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 12:32:38PM +0530, Anshuman Khandual wrote:
> Could do without this additional indirection via init_common_resources() by
> just calling kvm_set_ipa_limit() directly instead. This change saves memory
> and cycles.

Does it? Really?

Will

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e9a2b8f27792..19560e457c11 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1696,11 +1696,6 @@ static bool init_psci_relay(void)
>  	return true;
>  }
>  
> -static int init_common_resources(void)
> -{
> -	return kvm_set_ipa_limit();
> -}
> -
>  static int init_subsystems(void)
>  {
>  	int err = 0;
> @@ -2102,7 +2097,7 @@ int kvm_arch_init(void *opaque)
>  		}
>  	}
>  
> -	err = init_common_resources();
> +	err = kvm_set_ipa_limit();
>  	if (err)
>  		return err;
>  
> -- 
> 2.20.1
> 
