Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53615397165
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhFAK1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:27:20 -0400
Received: from foss.arm.com ([217.140.110.172]:46460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhFAK1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:27:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1164311FB;
        Tue,  1 Jun 2021 03:25:37 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 269123F73D;
        Tue,  1 Jun 2021 03:25:36 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH v2 08/10] irqchip/gic-v3-its: Use irq_chip_ack_parent()
In-Reply-To: <87y2c0s748.wl-maz@kernel.org>
References: <20210525173255.620606-1-valentin.schneider@arm.com> <20210525173255.620606-9-valentin.schneider@arm.com> <87y2c0s748.wl-maz@kernel.org>
Date:   Tue, 01 Jun 2021 11:25:33 +0100
Message-ID: <87r1hlg9uq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/21 13:17, Marc Zyngier wrote:
> On Tue, 25 May 2021 18:32:53 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> o make irq_chip_ack_parent() the default chip->irq_ack() via
>>   MSI_FLAG_USE_DEF_CHIP_OPS.
>
> Seem like a reasonable approach: how about a custom irq_ack() callback
> that iterates over the hierarchy until it finds an a non-NULL entry?
> Flows that don't use ack won't be impacted, users that need ack will
> provide one if they want, and the default will do something slightly
> slower, but at least unsurprising.
>

Sounds about right!

>> XXX: what about pMSI and fMSI ?
>
> Same thing. They are just bus-specific domains on top of the ITS
> domain, and must follow the same convention.
>
> However, this patch is perfectly acceptable to me (as long as you take
> care of platform and fsl -MSI).
>

Noted.

> Thanks,
>
>       M.
>
> --
> Without deviation from the norm, progress is not possible.
