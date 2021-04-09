Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD91359C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhDIKej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:34:39 -0400
Received: from foss.arm.com ([217.140.110.172]:47800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233745AbhDIKe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:34:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B1AD1FB;
        Fri,  9 Apr 2021 03:34:15 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74EAF3F73D;
        Fri,  9 Apr 2021 03:34:14 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH 01/10] genirq: Add chip flag to denote automatic IRQ (un)masking
In-Reply-To: <20210409101725.00007271@Huawei.com>
References: <20210408154326.3988781-1-valentin.schneider@arm.com> <20210408154326.3988781-2-valentin.schneider@arm.com> <20210409101725.00007271@Huawei.com>
Date:   Fri, 09 Apr 2021 11:34:07 +0100
Message-ID: <875z0voig0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for taking a peek :)

On 09/04/21 10:17, Jonathan Cameron wrote:
> On Thu, 8 Apr 2021 16:43:17 +0100
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>> index bee82809107c..580b1b6b1799 100644
>> --- a/include/linux/irq.h
>> +++ b/include/linux/irq.h
>> @@ -219,6 +219,8 @@ struct irq_data {
>>   *				  irq_chip::irq_set_affinity() when deactivated.
>>   * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
>>   *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
>> + * IRQD_IRQ_FLOW_MASKED         - Interrupt is masked by ACK. Only EOI can
>> + *                                clear this.
>
> Nitpick of the day : Seems text above is using tabs for white space blocks
> whereas you have used spaces. Make it consistent.
> It's not consistent in the file so I guess you could clean that up, or
> just go with making it consistent in this block.
>

I usually let my editor take the wheel when it comes to whitespace vs tabs,
but it does look like it's not aligned with the rest here.
