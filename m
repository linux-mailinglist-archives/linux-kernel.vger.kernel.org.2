Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC6A356A16
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhDGKm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234576AbhDGKmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:42:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D7956105A;
        Wed,  7 Apr 2021 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617792136;
        bh=MHbf/bQAeLgtOsJGl6XD9m82rnO4b7mz7XxYX2+FXdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ee/zkmzr/GCO+FG8YMGgI0NnboYerBcr82gKJwWcDLJ1kKr1vO1MZzVAsGwFME/QG
         d01O+kPty36J29VHF+zo/1gWMBdMEFP3G4CvuwQ4ibUuFsOJc+2BEpLQ+XnRygLcIK
         7dL8E2fRvBphDlAB0xsks5jF1M+vb689F9jx5hTlo6bI+ixD7tYpCqYyaUKFHV8TmF
         vACTcg1DDf6MOu1de0mKSybd94Slp9c7FuXXih/3RC6kkQJ4FAW5lCE0mnXLPRjHf6
         FlzeVEEarEIrCxxVUh5XlwM+UJoq7VPttmL4wLA+O2iSBoYVhtZ+Xm1qXXV+LlY43z
         tKWHUi/i+/9iw==
Date:   Wed, 7 Apr 2021 11:42:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/3] iommu: dart: Add DART iommu driver
Message-ID: <20210407104209.GA15173@willie-the-truck>
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-4-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328074009.95932-4-sven@svenpeter.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 09:40:09AM +0200, Sven Peter wrote:
> Apple's new SoCs use iommus for almost all peripherals. These Device
> Address Resolution Tables must be setup before these peripherals can
> act as DMA masters.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  MAINTAINERS                      |   1 +
>  drivers/iommu/Kconfig            |  14 +
>  drivers/iommu/Makefile           |   1 +
>  drivers/iommu/apple-dart-iommu.c | 858 +++++++++++++++++++++++++++++++
>  4 files changed, 874 insertions(+)
>  create mode 100644 drivers/iommu/apple-dart-iommu.c

[...]

> +/* must be called with held domain->lock */
> +static int apple_dart_attach_stream(struct apple_dart_domain *domain,
> +				    struct apple_dart *dart, u32 sid)
> +{
> +	unsigned long flags;
> +	struct apple_dart_stream *stream;
> +	struct io_pgtable_cfg *pgtbl_cfg;
> +	int ret;
> +
> +	list_for_each_entry(stream, &domain->streams, stream_head) {
> +		if (stream->dart == dart && stream->sid == sid) {
> +			stream->num_devices++;
> +			return 0;
> +		}
> +	}
> +
> +	spin_lock_irqsave(&dart->lock, flags);
> +
> +	if (WARN_ON(dart->used_sids & BIT(sid))) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> +	if (!stream) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}

Just in case you missed it, a cocci bot noticed that you're using GFP_KERNEL
to allocate while holding a spinlock here:

https://lore.kernel.org/r/alpine.DEB.2.22.394.2104041724340.2958@hadrien

Will
