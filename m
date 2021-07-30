Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA83DB75B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbhG3Kri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:47:38 -0400
Received: from foss.arm.com ([217.140.110.172]:40302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238487AbhG3Kri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:47:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D1F31FB;
        Fri, 30 Jul 2021 03:47:33 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93933F73D;
        Fri, 30 Jul 2021 03:47:32 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/2] irqchip/gic-v3: Fix selection of partition domain for EPPIs
In-Reply-To: <20210729172748.28841-3-james.morse@arm.com>
References: <20210729172748.28841-1-james.morse@arm.com> <20210729172748.28841-3-james.morse@arm.com>
Date:   Fri, 30 Jul 2021 11:47:30 +0100
Message-ID: <87eebgkri5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/21 17:27, James Morse wrote:
> commit 5f51f803826e ("irqchip/gic-v3: Add EPPI range support") added
> GIC_IRQ_TYPE_PARTITION support for EPPI to gic_irq_domain_translate(),
> and commit 52085d3f2028 ("irqchip/gic-v3: Dynamically allocate PPI
> partition descriptors") made the gic_data.ppi_descs array big enough for
> EPPI, but neither gic_irq_domain_select() nor partition_domain_translate()
> were updated.
>
> This means partitions are created by partition_create_desc() for the
> EPPI range, but can't be registered as they will always match the root
> domain and map to the summary interrupt.
>
> Update gic_irq_domain_select() to match PPI and EPPI. The fwspec for
> PPI and EPPI both start from 0. Use gic_irq_domain_translate() to find
> the hwirq from the fwspec, then convert this to a ppi index.
>
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Tiny nit below, regardless:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> @@ -1518,7 +1547,12 @@ static int partition_domain_translate(struct irq_domain *d,
>       if (WARN_ON(!np))
>               return -EINVAL;
>
> -	ret = partition_translate_id(gic_data.ppi_descs[fwspec->param[1]],
> +	ret = gic_irq_domain_translate(d, fwspec, &ppi_intid, type);

This assigns @type for us, so the @type assignment at the tail of
partition_domain_translate() becomes redundant.

> +	if (WARN_ON_ONCE(ret))
> +		return 0;
> +
> +	ppi_idx = __gic_get_ppi_index(ppi_intid);
> +	ret = partition_translate_id(gic_data.ppi_descs[ppi_idx],
>                                    of_node_to_fwnode(np));
>       if (ret < 0)
>               return ret;
> --
> 2.30.2
