Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F237397164
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFAK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:27:12 -0400
Received: from foss.arm.com ([217.140.110.172]:46448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhFAK1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:27:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D42C11FB;
        Tue,  1 Jun 2021 03:25:28 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85E023F73D;
        Tue,  1 Jun 2021 03:25:27 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH v2 02/10] genirq: Define irq_ack() and irq_eoi() helpers
In-Reply-To: <871r9stpd5.wl-maz@kernel.org>
References: <20210525173255.620606-1-valentin.schneider@arm.com> <20210525173255.620606-3-valentin.schneider@arm.com> <8735u8tphl.wl-maz@kernel.org> <871r9stpd5.wl-maz@kernel.org>
Date:   Tue, 01 Jun 2021 11:25:25 +0100
Message-ID: <87sg21g9uy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/21 11:58, Marc Zyngier wrote:
> On Thu, 27 May 2021 11:55:50 +0100,
> Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Tue, 25 May 2021 18:32:47 +0100,
>> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> > diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
>> > index b6c1cceddec0..090bd7868845 100644
>> > --- a/kernel/irq/internals.h
>> > +++ b/kernel/irq/internals.h
>> > @@ -87,6 +87,8 @@ extern void irq_enable(struct irq_desc *desc);
>> >  extern void irq_disable(struct irq_desc *desc);
>> >  extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
>> >  extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
>> > +extern void irq_ack(struct irq_desc *desc);
>> > +extern void irq_eoi(struct irq_desc *desc);
>>
>> Nit: we have {un,}mask_irq, but you add irq_{ack,eoi}. It'd be good to
>> have some naming consistency (yes, this may/will clash with existing
>> code, but we can fix that as well).
>
> Actually, the helpers do have the right naming, but the internal
> declarations are the ones that are wrong...
>

Doh!

>       M.
>
> --
> Without deviation from the norm, progress is not possible.
