Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05D035C28A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbhDLJpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:45:31 -0400
Received: from 3.mo51.mail-out.ovh.net ([188.165.32.156]:48084 "EHLO
        3.mo51.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbhDLJZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:25:39 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 05:25:39 EDT
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.192])
        by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 1BABE27E4A1;
        Mon, 12 Apr 2021 11:06:19 +0200 (CEST)
Received: from kaod.org (37.59.142.102) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 11:06:18 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-102R004cd848d06-19e0-4ba3-a856-63be1968541e,
                    30B7ACC6D8DC628EDB1EBF85A4A81F2E60AF40AB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.89.73.13
Subject: Re: [PATCH] genirq: reduce irqdebug bouncing cachelines
To:     Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20210402132037.574661-1-npiggin@gmail.com>
 <87im4u2vxx.ffs@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2dae4501-6f01-1b32-4b69-1dfc94c93425@kaod.org>
Date:   Mon, 12 Apr 2021 11:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87im4u2vxx.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: bdc4617e-ccd1-4b6c-a780-716d4e202d20
X-Ovh-Tracer-Id: 975592273213688797
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgedvieejfedvhfduhfffueevheeludffhfdvkeehleegtddttdfhieegveeghfffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 4/10/21 1:58 PM, Thomas Gleixner wrote:
> Nicholas,
> 
> On Fri, Apr 02 2021 at 23:20, Nicholas Piggin wrote:
>> note_interrupt increments desc->irq_count for each interrupt even for
>> percpu interrupt handlers, even when they are handled successfully. This
>> causes cacheline bouncing and limits scalability.
>>
>> Instead of incrementing irq_count every time, only start incrementing it
>> after seeing an unhandled irq, which should avoid the cache line
>> bouncing in the common path.
>>
>> This actually should give better consistency in handling misbehaving
>> irqs too, because instead of the first unhandled irq arriving at an
>> arbitrary point in the irq_count cycle, its arrival will begin the
>> irq_count cycle.
> 
> I've applied that because it makes sense in general, but I think the whole
> call to note_interrupt() can be avoided or return early when interrupts
> would be marked accordingly. For IPI handlers which always return
> HANDLED the whole procedure is pretty pointless to begin with.
> 
> Something like the completely untested below.
> 
> Thanks,
> 
>         tglx
> ---
>  include/linux/interrupt.h |    3 +++
>  include/linux/irq.h       |    2 ++
>  kernel/irq/manage.c       |    2 ++
>  kernel/irq/settings.h     |   12 ++++++++++++
>  kernel/irq/spurious.c     |    2 +-
>  5 files changed, 20 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -64,6 +64,8 @@
>   * IRQF_NO_AUTOEN - Don't enable IRQ or NMI automatically when users request it.
>   *                Users will enable it explicitly by enable_irq() or enable_nmi()
>   *                later.
> + * IRQF_NO_DEBUG - Exclude from runnaway detection for IPI and similar handlers,
> + *		   depends on IRQF_PERCPU.
>   */
>  #define IRQF_SHARED		0x00000080
>  #define IRQF_PROBE_SHARED	0x00000100
> @@ -78,6 +80,7 @@
>  #define IRQF_EARLY_RESUME	0x00020000
>  #define IRQF_COND_SUSPEND	0x00040000
>  #define IRQF_NO_AUTOEN		0x00080000
> +#define IRQF_NO_DEBUG		0x00100000
>  
>  #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
>  
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -72,6 +72,7 @@ enum irqchip_irq_state;
>   *				  mechanism and from core side polling.
>   * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
>   * IRQ_HIDDEN			- Don't show up in /proc/interrupts
> + * IRQ_NO_DEBUG			- Exclude from note_interrupt() debugging
>   */
>  enum {
>  	IRQ_TYPE_NONE		= 0x00000000,
> @@ -99,6 +100,7 @@ enum {
>  	IRQ_IS_POLLED		= (1 << 18),
>  	IRQ_DISABLE_UNLAZY	= (1 << 19),
>  	IRQ_HIDDEN		= (1 << 20),
> +	IRQ_NO_DEBUG		= (1 << 21),
>  };
>  
>  #define IRQF_MODIFY_MASK	\
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1682,6 +1682,8 @@ static int
>  		if (new->flags & IRQF_PERCPU) {
>  			irqd_set(&desc->irq_data, IRQD_PER_CPU);
>  			irq_settings_set_per_cpu(desc);
> +			if (new->flags & IRQF_NO_DEBUG)
> +				irq_settings_set_no_debug(desc);
>  		}
>  
>  		if (new->flags & IRQF_ONESHOT)
> --- a/kernel/irq/settings.h
> +++ b/kernel/irq/settings.h
> @@ -18,6 +18,7 @@ enum {
>  	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
>  	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
>  	_IRQ_HIDDEN		= IRQ_HIDDEN,
> +	_IRQ_NO_DEBUG		= IRQ_NO_DEBUG,
>  	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
>  };
>  
> @@ -33,6 +34,7 @@ enum {
>  #define IRQ_IS_POLLED		GOT_YOU_MORON
>  #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
>  #define IRQ_HIDDEN		GOT_YOU_MORON
> +#define IRQ_NO_DEBUG		GOT_YOU_MORON
>  #undef IRQF_MODIFY_MASK
>  #define IRQF_MODIFY_MASK	GOT_YOU_MORON
>  
> @@ -174,3 +176,13 @@ static inline bool irq_settings_is_hidde
>  {
>  	return desc->status_use_accessors & _IRQ_HIDDEN;
>  }
> +
> +static inline void irq_settings_set_no_debug(struct irq_desc *desc)
> +{
> +	desc->status_use_accessors |= _IRQ_NO_DEBUG;
> +}
> +
> +static inline bool irq_settings_no_debug(struct irq_desc *desc)
> +{
> +	return desc->status_use_accessors & _IRQ_NO_DEBUG;
> +}
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
> @@ -274,7 +274,7 @@ void note_interrupt(struct irq_desc *des
>  	unsigned int irq;
>  
>  	if (desc->istate & IRQS_POLL_INPROGRESS ||
> -	    irq_settings_is_polled(desc))
> +	    irq_settings_is_polled(desc) | irq_settings_no_debug(desc))

Shouldn't it be '||' instead  ? 

>  		return;
>  
>  	if (bad_action_ret(action_ret)) {
> 

We could test irq_settings_no_debug() directly under handle_nested_irq() 
and handle_irq_event_percpu() to avoid calling note_interrupt(), just 
like we do for noirqdebug.

Thanks,

C.
