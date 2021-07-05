Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EDC3BC369
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 22:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhGEUjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 16:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhGEUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 16:39:17 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E46AC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 13:36:39 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w74so150741oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VmnvvXduvAAn8SsgnPZw+usamuncWhUu9MriQvE4FCM=;
        b=s7wldRipXdKhncmqyRNjmmayeib+oXFYjFTVC2P0BTfcEo1tRp+ZUjJMKv2SC5TzRa
         kPqKJevFD+5Pqp2iwKfqnil8ukDVexWa5mQ1M1TJGR16OcNYdEJhHA753wb5tKtWrElZ
         uW0h9Cf5E79NHrTe6k3FYegIKfZ2syEiuKREH57u2CFHu30LSc1qxg+cfQKpv3Fu23q9
         H3oM3KflXVgH6bgaqnPUCHqfCD6N48sgDtSQ3AXiEO0D9Fzn+Y90YqGHptr8PKBTrp2B
         KygVhiD7M1bXqrhwEKVXQIiqLMsdZ5MWkjnIuwyMxwc4QDuW1s322808ED28XP80pgHp
         Vtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VmnvvXduvAAn8SsgnPZw+usamuncWhUu9MriQvE4FCM=;
        b=j04rhqz4jewWvrjVnENX3SIf7lGupd3gyok2DdRx5Zjh56R6a8oaR71fYfgVHaeN5o
         aqKaXbjvK1tsgAS02wmSc0B34ZclsDGyUeeJUDLDJC1QzDeVJub47U6yH/sbp2ZEbo62
         YQ0jYt3Ul5VhIwdQ0P4ZLdyu3xP1Dg2zGXYRltfUShM75mZ6+zB7EwvrDsB8LgGKKhlm
         7pA4d+bOFbgEk/EZoS3kXgNIliadl4qQjc/xgmrDreaJWuzMOIojUM+WdcTziXYuwJn1
         I/Wwhxc+zgqEuGGEic9PWfr55JV26HGGsBouHcCpNv92RbNbiaubAn8lvg5WM3VnIknS
         1u3A==
X-Gm-Message-State: AOAM5301kFxzzGjkdv1n7ZhOTK9w5RoufzSLhwDUKRCtVAMoTaqRmP48
        YYQD3ERsIrdrlQlaX8oMVgY=
X-Google-Smtp-Source: ABdhPJwGS7lyYvaUXC5f91CIR3Ox/xwCMm/MQDIDnWbt34SnY11Mh/UAXULqvVbph76tqzGXhaKxDQ==
X-Received: by 2002:a54:4617:: with SMTP id p23mr9475776oip.104.1625517398647;
        Mon, 05 Jul 2021 13:36:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l10sm2807405oti.9.2021.07.05.13.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 13:36:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [irqchip: irq/irqchip-next] irqdomain: Protect the linear revmap
 with RCU
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <162341967699.19906.3242958007782554792.tip-bot2@tip-bot2>
 <20210705172352.GA56304@roeck-us.net> <87h7h88wsd.wl-maz@kernel.org>
 <79ec0069-553b-cac1-5ec7-d68c757619a5@roeck-us.net>
 <87fsws8uty.wl-maz@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fb3b9223-a811-af48-ead5-b2c6f7305de4@roeck-us.net>
Date:   Mon, 5 Jul 2021 13:36:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87fsws8uty.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/21 11:43 AM, Marc Zyngier wrote:
> On Mon, 05 Jul 2021 19:23:27 +0100,
> Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi Marc,
>>
>> On 7/5/21 11:01 AM, Marc Zyngier wrote:
>>> Hi Guenter,
>>>
>>> On Mon, 05 Jul 2021 18:23:52 +0100,
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Fri, Jun 11, 2021 at 01:54:36PM -0000, irqchip-bot for Marc Zyngier wrote:
>>>>> The following commit has been merged into the irq/irqchip-next branch of irqchip:
>>>>>
>>>>> Commit-ID:     d4a45c68dc81f9117ceaff9f058d5fae674181b9
>>>>> Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d4a45c68dc81f9117ceaff9f058d5fae674181b9
>>>>> Author:        Marc Zyngier <maz@kernel.org>
>>>>> AuthorDate:    Mon, 05 Apr 2021 12:57:27 +01:00
>>>>> Committer:     Marc Zyngier <maz@kernel.org>
>>>>> CommitterDate: Thu, 10 Jun 2021 13:09:18 +01:00
>>>>>
>>>>> irqdomain: Protect the linear revmap with RCU
>>>>>
>>>>> It is pretty odd that the radix tree uses RCU while the linear
>>>>> portion doesn't, leading to potential surprises for the users,
>>>>> depending on how the irqdomain has been created.
>>>>>
>>>>> Fix this by moving the update of the linear revmap under
>>>>> the mutex, and the lookup under the RCU read-side lock.
>>>>>
>>>>> The mutex name is updated to reflect that it doesn't only
>>>>> cover the radix-tree anymore.
>>>>>
>>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>>
>>>> This patch results in various RCU warnings when booting mipsel images
>>>> in qemu. I can not revert the patch due to subsequent changes, so I
>>>> don't know if a simple revert fixes the problem. Log messages and
>>>> bisect log see below.
>>>
>>> Thanks for the heads up. Do you have a config file I can use to
>>> reproduce this? The QEMU invocation runes would certainly help too.
>>>
>>> It strikes me that in drivers/irqchip/irq-mips-cpu.c,
>>> plat_irq_dispatch() now uses the irqdomain resolution before
>>> irq_enter() took place. That's certainly a latent bug. I'll fix that
>>> regardless, but I'd like to make sure this is what you are seeing too.
>>>
>>
>> See http://server.roeck-us.net/qemu/mipsel/
>>
>> config		Complete configuration file
>> defconfig	Shortened configuration file
>> rootfs.cpio	root file system (initrd)
>> run.sh		qemu run script (tested with qemu 4.2.1 and 6.0.0)
>> vmlinux		Kernel image experiencing the problem (v5.13-9883-gaf9efb8b661)
>>
>> Hope this helps,
> 
> It definitely helps, and confirms my hunch. With the patch below, I'm
> not getting the warnings anymore. I'm pretty sure a number of other
> MIPS systems suffer from similar issues, which I'll address similarly.
> 
> Please let me know if that addresses the issue on your end.
> 

Yes, it does. Feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

to the real patch.

Now the big question: Why does this only affect 32-bit little endian
mips images, but not the matching big endian images, nor 64-bit images ?

Thanks,
Guenter

> Thanks,
> 
> 	M.
> 
> diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
> index d1477ecb1af9..57561e0e6e8d 100644
> --- a/arch/mips/include/asm/irq.h
> +++ b/arch/mips/include/asm/irq.h
> @@ -57,6 +57,9 @@ asmlinkage void plat_irq_dispatch(void);
>   
>   extern void do_IRQ(unsigned int irq);
>   
> +struct irq_domain;
> +extern void do_domain_IRQ(struct irq_domain *domain, unsigned int irq);
> +
>   extern void arch_init_irq(void);
>   extern void spurious_interrupt(void);
>   
> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index 85b6c60f285d..c76005cd3b79 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -21,6 +21,7 @@
>   #include <linux/kallsyms.h>
>   #include <linux/kgdb.h>
>   #include <linux/ftrace.h>
> +#include <linux/irqdomain.h>
>   
>   #include <linux/atomic.h>
>   #include <linux/uaccess.h>
> @@ -107,3 +108,16 @@ void __irq_entry do_IRQ(unsigned int irq)
>   	irq_exit();
>   }
>   
> +void __irq_entry do_domain_IRQ(struct irq_domain *domain, unsigned int hwirq)
> +{
> +	struct irq_desc *desc;
> +
> +	irq_enter();
> +	check_stack_overflow();
> +
> +	desc = irq_resolve_mapping(domain, hwirq);
> +	if (likely(desc))
> +		handle_irq_desc(desc);
> +
> +	irq_exit();
> +}
> diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
> index 0bbb0b2d0dd5..0c7ae71a0af0 100644
> --- a/drivers/irqchip/irq-mips-cpu.c
> +++ b/drivers/irqchip/irq-mips-cpu.c
> @@ -127,7 +127,6 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
>   asmlinkage void __weak plat_irq_dispatch(void)
>   {
>   	unsigned long pending = read_c0_cause() & read_c0_status() & ST0_IM;
> -	unsigned int virq;
>   	int irq;
>   
>   	if (!pending) {
> @@ -137,12 +136,15 @@ asmlinkage void __weak plat_irq_dispatch(void)
>   
>   	pending >>= CAUSEB_IP;
>   	while (pending) {
> +		struct irq_domain *d;
> +
>   		irq = fls(pending) - 1;
>   		if (IS_ENABLED(CONFIG_GENERIC_IRQ_IPI) && irq < 2)
> -			virq = irq_linear_revmap(ipi_domain, irq);
> +			d = ipi_domain;
>   		else
> -			virq = irq_linear_revmap(irq_domain, irq);
> -		do_IRQ(virq);
> +			d = irq_domain;
> +
> +		do_domain_IRQ(d, irq);
>   		pending &= ~BIT(irq);
>   	}
>   }
> 

