Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482A743C449
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbhJ0HtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240621AbhJ0HtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:49:11 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50601610A4;
        Wed, 27 Oct 2021 07:46:46 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mfde0-001qv7-6d; Wed, 27 Oct 2021 08:46:44 +0100
MIME-Version: 1.0
Date:   Wed, 27 Oct 2021 08:46:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Remove unused TRNG_NO_ENTROPY
In-Reply-To: <20211026210913.57006-1-quic_qiancai@quicinc.com>
References: <20211026210913.57006-1-quic_qiancai@quicinc.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <3fac8ddb626205286f79adde96ea527b@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: quic_qiancai@quicinc.com, james.morse@arm.com, ardb@kernel.org, alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-26 22:09, Qian Cai wrote:
> TRNG_NO_ENTROPY was unused when introduced and now. This is also caught 
> by
> GCC (W=2):
> 
> arch/arm64/kvm/trng.c:17: warning: macro "TRNG_NO_ENTROPY" is not used
> [-Wunused-macros]
>    17 | #define TRNG_NO_ENTROPY   ((unsigned long)-3)
> 
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> ---
>  arch/arm64/kvm/trng.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/trng.c b/arch/arm64/kvm/trng.c
> index 99bdd7103c9c..6a46b3ac3970 100644
> --- a/arch/arm64/kvm/trng.c
> +++ b/arch/arm64/kvm/trng.c
> @@ -14,7 +14,6 @@
>  #define TRNG_SUCCESS			0UL
>  #define TRNG_NOT_SUPPORTED		((unsigned long)-1)
>  #define TRNG_INVALID_PARAMETER		((unsigned long)-2)
> -#define TRNG_NO_ENTROPY			((unsigned long)-3)
> 
>  #define TRNG_MAX_BITS64			192

That's an architectural definition that doesn't cause any problem.
If anything, that's documentation.

We have *tons* of other definitions with no user all over the
arm64 code. They save the exact same purpose.

         M.
-- 
Jazz is not dead. It just smells funny...
