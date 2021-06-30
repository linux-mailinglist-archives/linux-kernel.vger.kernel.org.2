Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952083B8466
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhF3Nzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:55:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47410 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbhF3Nvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:50 -0400
Received: from maud (unknown [IPv6:2600:8800:8c04:8c00::912b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EF5171F43548;
        Wed, 30 Jun 2021 14:49:13 +0100 (BST)
Date:   Wed, 30 Jun 2021 09:49:07 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, r.czerwinski@pengutronix.de
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
Message-ID: <YNx2U4GPoKxV3PWd@maud>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627143405.77298-4-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks really good! Just a few minor comments. With them addressed,

	Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

> +	  Say Y here if you are using an Apple SoC with a DART IOMMU.

Nit: Do we need to spell out "with a DART IOMMU"? Don't all the apple
socs need DART?

> +/*
> + * This structure is used to identify a single stream attached to a domain.
> + * It's used as a list inside that domain to be able to attach multiple
> + * streams to a single domain. Since multiple devices can use a single stream
> + * it additionally keeps track of how many devices are represented by this
> + * stream. Once that number reaches zero it is detached from the IOMMU domain
> + * and all translations from this stream are disabled.
> + *
> + * @dart: DART instance to which this stream belongs
> + * @sid: stream id within the DART instance
> + * @num_devices: count of devices attached to this stream
> + * @stream_head: list head for the next stream
> + */
> +struct apple_dart_stream {
> +	struct apple_dart *dart;
> +	u32 sid;
> +
> +	u32 num_devices;
> +
> +	struct list_head stream_head;
> +};

It wasn't obvious to me why we can get away without reference counting.
Looking ahead it looks like we assert locks in each case. Maybe add
that to the comment?

```
> +static void apple_dart_hw_set_ttbr(struct apple_dart *dart, u16 sid, u16 idx,
> +				   phys_addr_t paddr)
> +{
> +	writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
> +	       dart->regs + DART_TTBR(sid, idx));
> +}
```

Should we be checking alignment here? Something like

    BUG_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
