Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D43598FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhDIJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:19:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2816 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhDIJTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:19:04 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGsky56Gpz687DG;
        Fri,  9 Apr 2021 17:09:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 9 Apr 2021 11:18:50 +0200
Received: from localhost (10.47.90.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 10:18:49 +0100
Date:   Fri, 9 Apr 2021 10:17:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH 01/10] genirq: Add chip flag to denote automatic IRQ
 (un)masking
Message-ID: <20210409101725.00007271@Huawei.com>
In-Reply-To: <20210408154326.3988781-2-valentin.schneider@arm.com>
References: <20210408154326.3988781-1-valentin.schneider@arm.com>
        <20210408154326.3988781-2-valentin.schneider@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.233]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 16:43:17 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> Some IRQ chips such as the Arm GICs automagically mask / unmask an
> IRQ during the handling of said IRQ. This renders further mask / unmask
> operations within the flow handlers redundant, which we do want to leverage
> as masking by itself is not cheap (Distributor access via MMIO for GICs).
> 
> This is different from having a chip->irq_mask_ack() callback as this
> masking is:
> - inherent to the chip->irq_ack() and *cannot* be omitted
> - a *different* masking state than chip->irq_mask() (chip->irq_mask() is
>   idempotent, chip->irq_ack() really isn't)
> 
> Add a chip flag, IRQCHIP_AUTOMASKS_FLOW, to denote chips with such
> behaviour. Add a new IRQ data flag, IRQD_IRQ_FLOW_MASKED, to keep this
> flow-induced mask state separate from regular mask / unmask operations
> (IRQD_IRQ_MASKED).
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Hi Valentin,

One totally trivial thing noticed whilst reading.

> ---
>  include/linux/irq.h    | 10 ++++++++++
>  kernel/irq/chip.c      |  5 +++++
>  kernel/irq/debugfs.c   |  2 ++
>  kernel/irq/internals.h |  5 +++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index bee82809107c..580b1b6b1799 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -219,6 +219,8 @@ struct irq_data {
>   *				  irq_chip::irq_set_affinity() when deactivated.
>   * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
>   *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
> + * IRQD_IRQ_FLOW_MASKED         - Interrupt is masked by ACK. Only EOI can
> + *                                clear this.

Nitpick of the day : Seems text above is using tabs for white space blocks
whereas you have used spaces. Make it consistent.
It's not consistent in the file so I guess you could clean that up, or
just go with making it consistent in this block.

>   */
>  enum {
>  	IRQD_TRIGGER_MASK		= 0xf,
> @@ -245,6 +247,7 @@ enum {
>  	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
>  	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
>  	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
> +	IRQD_IRQ_FLOW_MASKED            = (1 << 31),
>  };
>  
>  #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
> @@ -349,6 +352,11 @@ static inline bool irqd_irq_masked(struct irq_data *d)
>  	return __irqd_to_state(d) & IRQD_IRQ_MASKED;
>  }
>  
> +static inline bool irqd_irq_flow_masked(struct irq_data *d)
> +{
> +	return __irqd_to_state(d) & IRQD_IRQ_FLOW_MASKED;
> +}
> +
>  static inline bool irqd_irq_inprogress(struct irq_data *d)
>  {
>  	return __irqd_to_state(d) & IRQD_IRQ_INPROGRESS;
> @@ -567,6 +575,7 @@ struct irq_chip {
>   * IRQCHIP_SUPPORTS_NMI:              Chip can deliver NMIs, only for root irqchips
>   * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
>   *                                    in the suspend path if they are in disabled state
> + * IRQCHIP_AUTOMASKS_FLOW:            chip->ack() masks and chip->eoi() unmasks
>   */
>  enum {
>  	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
> @@ -579,6 +588,7 @@ enum {
>  	IRQCHIP_SUPPORTS_LEVEL_MSI		= (1 <<  7),
>  	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
>  	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
> +	IRQCHIP_AUTOMASKS_FLOW                  = (1 <<  10),
>  };
>  
>  #include <linux/irqdesc.h>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 8cc8e5713287..18c3b0e1568a 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -173,6 +173,11 @@ static void irq_state_clr_masked(struct irq_desc *desc)
>  	irqd_clear(&desc->irq_data, IRQD_IRQ_MASKED);
>  }
>  
> +static void irq_state_clr_flow_masked(struct irq_desc *desc)
> +{
> +	irqd_clear(&desc->irq_data, IRQD_IRQ_FLOW_MASKED);
> +}
> +
>  static void irq_state_clr_started(struct irq_desc *desc)
>  {
>  	irqd_clear(&desc->irq_data, IRQD_IRQ_STARTED);
> diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
> index e4cff358b437..3ae83622d701 100644
> --- a/kernel/irq/debugfs.c
> +++ b/kernel/irq/debugfs.c
> @@ -58,6 +58,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
>  	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
>  	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
>  	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
> +	BIT_MASK_DESCR(IRQCHIP_AUTOMASKS_FLOW),
>  };
>  
>  static void
> @@ -103,6 +104,7 @@ static const struct irq_bit_descr irqdata_states[] = {
>  	BIT_MASK_DESCR(IRQD_IRQ_STARTED),
>  	BIT_MASK_DESCR(IRQD_IRQ_DISABLED),
>  	BIT_MASK_DESCR(IRQD_IRQ_MASKED),
> +	BIT_MASK_DESCR(IRQD_IRQ_FLOW_MASKED),
>  	BIT_MASK_DESCR(IRQD_IRQ_INPROGRESS),
>  
>  	BIT_MASK_DESCR(IRQD_PER_CPU),
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index 54363527feea..b6c1cceddec0 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -245,6 +245,11 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
>  	irqd_set(&desc->irq_data, IRQD_IRQ_MASKED);
>  }
>  
> +static inline void irq_state_set_flow_masked(struct irq_desc *desc)
> +{
> +	irqd_set(&desc->irq_data, IRQD_IRQ_FLOW_MASKED);
> +}
> +
>  #undef __irqd_to_state
>  
>  static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)

