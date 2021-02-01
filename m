Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1880630AE3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBARnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232359AbhBARm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:42:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F5E564E9C;
        Mon,  1 Feb 2021 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612201309;
        bh=Coy8GnAXaLr1Ite2Qp1Zmud9F/Xbq++8nLGERyWz1zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pya8jRrCvkpzbzb7LfN8NfCpsjbcALtAvceTk+7uAToBACDZndGBfLqO0TvnRs4QD
         vJt3n3sYn90rFk6cR3ObT0dGnrXLHiHnbGUWRrnA4+sssDkD83ArGPBV8XlQ8+N95j
         sBDnYQKZQx63cDdgE3rBsE6ck17Mgtp3krhlE6j7VO+NZcoFY1537qQZ1ZpO6OeGif
         HtFGRpj6wB5J0oYBEf6AGjSOoOhtkpeYK0TEJNYx9zOn4eNiMWXpD1a920S2bMogcL
         2MjQN0N5j5kJ+fm20uyeCk7W8G9Sa0NgxmKTm7oc445f0HL/SgjiAKCk3gK3mo7LRe
         zwKfv6/SlM7XQ==
Date:   Mon, 1 Feb 2021 17:41:43 +0000
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
Subject: Re: [RFC PATCH v2 04/26] KVM: arm64: Initialize kvm_nvhe_init_params
 early
Message-ID: <20210201174143.GB15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-5-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-5-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:02PM +0000, Quentin Perret wrote:
> Move the initialization of kvm_nvhe_init_params in a dedicated function
> that is run early, and only once during KVM init, rather than every time
> the KVM vectors are set and reset.
> 
> This also opens the opportunity for the hypervisor to change the init
> structs during boot, hence simplifying the replacement of host-provided
> page-tables and stacks by the ones the hypervisor will create for
> itself.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/arm.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 04c44853b103..3ac0f3425833 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c

[...]

> @@ -1807,6 +1813,12 @@ static int init_hyp_mode(void)
>  			goto out_err;
>  	}
>  
> +	/*
> +	 * Prepare the CPU initialization parameters
> +	 */
> +	for_each_possible_cpu(cpu)
> +		cpu_prepare_hyp_mode(cpu);
> +

This is the fifth for_each_possible_cpu() loop in this function; can any of
them be merged together?

Will
