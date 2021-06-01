Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF9397162
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhFAK07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:26:59 -0400
Received: from foss.arm.com ([217.140.110.172]:46430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233641AbhFAK0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:26:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5677711FB;
        Tue,  1 Jun 2021 03:25:07 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A81A3F73D;
        Tue,  1 Jun 2021 03:25:06 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH v2 00/10] irqchip/irq-gic: Optimize masking by leveraging EOImode=1
In-Reply-To: <87zgwgs9x0.wl-maz@kernel.org>
References: <20210525173255.620606-1-valentin.schneider@arm.com> <87zgwgs9x0.wl-maz@kernel.org>
Date:   Tue, 01 Jun 2021 11:25:01 +0100
Message-ID: <87tumhg9vm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/21 12:17, Marc Zyngier wrote:
> On Tue, 25 May 2021 18:32:45 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> I've tested this on my Ampere eMAG, which uncovered "fun" interactions with
>> the MSI domains. Did the same trick as the Juno with the pl011.
>>
>> pNMIs cause said eMAG to freeze, but that's true even without my patches. I
>> did try them out under QEMU+KVM and that looked fine, although that means I
>> only got to test EOImode=0. I'll try to dig into this when I get some more
>> cycles.
>
> That's interesting/worrying. As far as I remember, this machine uses
> GIC500, which is a well known quantity. If pNMIs are causing issues,
> that'd probably be a CPU interface problem. Can you elaborate on how
> you tried to test that part? Just using the below benchmark?
>

Not even that, it would hang somewhere at boot. Julien suggested offline
that it might be a problem with the secondaries' PMR initial value, but I
really never got to do dig into it.

>>
>> Performance impact
>> ==================
>>
>> Benchmark
>> +++++++++
>>
>> Finding a benchmark that leverages a force-threaded IRQ has proved to be
>> somewhat of a pain, so I crafted my own. It's a bit daft, but so are most
>> benchmarks (though this one might win a prize).
>
> I love it (and wrote similar hacks in my time)! :D

Yay!

> Can you put that up
> somewhere so that I can run the same test on my own zoo and find out
> how it fares?
>

The setup part is really fugly and I was too ashamed of it to link it in
the cover letter; for ACPI I could simply use acpi_register_gsi() since
that uses the right domain by default, but for DT I ended up adding a DT
entry and a match table.

I'll see about unifying this and I'll send it out your way.
