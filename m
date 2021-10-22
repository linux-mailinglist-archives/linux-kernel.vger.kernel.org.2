Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC074379BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhJVPUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:20:41 -0400
Received: from foss.arm.com ([217.140.110.172]:55776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232384AbhJVPUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:20:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B48BB1FB;
        Fri, 22 Oct 2021 08:18:22 -0700 (PDT)
Received: from [10.57.20.104] (unknown [10.57.20.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6C5E3F694;
        Fri, 22 Oct 2021 08:18:18 -0700 (PDT)
Subject: Re: [PATCH 09/15] irq: arm: perform irqentry in entry code
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-10-mark.rutland@arm.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <0efc4465-12b5-a568-0228-c744ec0509a3@arm.com>
Date:   Fri, 22 Oct 2021 16:18:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211021180236.37428-10-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 10/21/21 7:02 PM, Mark Rutland wrote:
> +/*
> + * TODO: restructure the ARMv7M entry logic so that this entry logic can live
> + * in arch code.
> + */
> +asmlinkage void __exception_irq_entry
> +static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)

I'm seeing build time failure...

drivers/irqchip/irq-nvic.c:50:8: error: two or more data types in declaration specifiers
 static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
        ^~~~
drivers/irqchip/irq-nvic.c:50:13: warning: 'nvic_handle_irq' defined but not used [-Wunused-function]
 static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)

I've fixed that locally and planing to give it a go...

Cheers
Vladimir
