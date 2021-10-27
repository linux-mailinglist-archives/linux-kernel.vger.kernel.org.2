Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1DB43C3FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbhJ0HhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234080AbhJ0Hg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:36:58 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880B060C4A;
        Wed, 27 Oct 2021 07:34:33 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mfdSB-001qke-G2; Wed, 27 Oct 2021 08:34:31 +0100
MIME-Version: 1.0
Date:   Wed, 27 Oct 2021 08:34:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Avoid shadowing a previous local
In-Reply-To: <20211027024212.64842-1-quic_qiancai@quicinc.com>
References: <20211027024212.64842-1-quic_qiancai@quicinc.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <da6be00d39c37ad26bfad9e75e814cb1@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: quic_qiancai@quicinc.com, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-27 03:42, Qian Cai wrote:
> It is less-prone to have a different variable name from the one in a 
> wider
> scope. This is also flagged by GCC (W=2):
> 
> In file included from ./include/linux/kvm_host.h:39,
>                  from arch/arm64/kvm/arm.c:12:
> arch/arm64/kvm/arm.c: In function 'kvm_arch_vcpu_ioctl_run':
> ./arch/arm64/include/asm/kvm_host.h:638:26: warning: declaration of
> 'ret' shadows a previous local [-Wshadow]
>   638 |   typeof(f(__VA_ARGS__)) ret;    \
>       |                          ^~~
> arch/arm64/kvm/arm.c:852:9: note: in expansion of macro 
> 'kvm_call_hyp_ret'
>   852 |   ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
>       |         ^~~~~~~~~~~~~~~~
> arch/arm64/kvm/arm.c:773:6: note: shadowed declaration is here
>   773 |  int ret;
>       |      ^~~
> 
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h
> b/arch/arm64/include/asm/kvm_host.h
> index 4be8486042a7..4693d84ccd95 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -635,16 +635,16 @@ void kvm_arm_resume_guest(struct kvm *kvm);
> 
>  #define kvm_call_hyp_ret(f, ...)					\
>  	({								\
> -		typeof(f(__VA_ARGS__)) ret;				\
> +		typeof(f(__VA_ARGS__)) __ret;				\
>  									\
>  		if (has_vhe()) {					\
> -			ret = f(__VA_ARGS__);				\
> +			__ret = f(__VA_ARGS__);				\
>  			isb();						\
>  		} else {						\
> -			ret = kvm_call_hyp_nvhe(f, ##__VA_ARGS__);	\
> +			__ret = kvm_call_hyp_nvhe(f, ##__VA_ARGS__);	\
>  		}							\
>  									\
> -		ret;							\
> +		__ret;							\
>  	})
>  #else /* __KVM_NVHE_HYPERVISOR__ */
>  #define kvm_call_hyp(f, ...) f(__VA_ARGS__)

I don't think this makes much sense. This is bound to eventually clash
with another variable, and you're back to square one.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
