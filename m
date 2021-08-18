Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2EA3F02F4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhHRLnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:43:52 -0400
Received: from marcansoft.com ([212.63.210.85]:60726 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbhHRLnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:43:51 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 07:43:50 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5FEF341F72;
        Wed, 18 Aug 2021 11:35:07 +0000 (UTC)
Subject: Re: [PATCH] irqchip/apple-aic: fix irq_disable from within irq
 handlers
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210812100942.17206-1-sven@svenpeter.dev>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <9b2805ec-e5b4-bb1b-abee-0bff7e3dbf24@marcan.st>
Date:   Wed, 18 Aug 2021 20:35:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812100942.17206-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*Puts on kernel maintainer hat again*

Sorry for the delay. I've been spending too much time on hardware RE 
recently...

On 12/08/2021 19.09, Sven Peter wrote:
> When disable_irq_nosync for an interrupt is called from within its
> interrupt handler, this interrupt is only marked as disabled with the
> intention to mask it when it triggers again.
> The AIC hardware however automatically masks the interrupt when it is read.
> aic_irq_eoi then unmasks it again if it's not disabled *and* not masked.
> This results in a state mismatch between the hardware state and the
> state kept in irq_data: The hardware interrupt is masked but
> IRQD_IRQ_MASKED is not set. Any further calls to unmask_irq will directly
> return and the interrupt can never be enabled again.
> 
> Fix this by keeping the hardware and irq_data state in sync by unmasking in
> aic_irq_eoi if and only if the irq_data state also assumes the interrupt to
> be unmasked.
> 
> Fixes: 76cde2639411 ("irqchip/apple-aic: Add support for the Apple Interrupt Controller")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   drivers/irqchip/irq-apple-aic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index b8c06bd8659e..6fc145aacaf0 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -226,7 +226,7 @@ static void aic_irq_eoi(struct irq_data *d)
>   	 * Reading the interrupt reason automatically acknowledges and masks
>   	 * the IRQ, so we just unmask it here if needed.
>   	 */
> -	if (!irqd_irq_disabled(d) && !irqd_irq_masked(d))
> +	if (!irqd_irq_masked(d))
>   		aic_irq_unmask(d);
>   }
>   
> 

Looks good to me. I can't remember exactly where this code came from, 
but looking again at the irqchip code it's clear that the mask state and 
hardware mask always have to be in sync.

Acked-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
