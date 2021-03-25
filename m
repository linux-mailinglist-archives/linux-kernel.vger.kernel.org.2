Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C553497A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCYRJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhCYRI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:08:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D909619E4;
        Thu, 25 Mar 2021 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616692138;
        bh=56A0l6+2zQ5O9rkIHutwsEMDBdqlpzUskFaOTpTah6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDkVZOYAKaFCu9XhG9L6xlZbZpW0FDhNpktbHw7nxXpTlKGvTOW17UDX7lFkpPVJV
         vXCCZaLsNUjtc6IoKIr8pnqm+gVceFCpouLM0mKP/nlO9IHre6h+/zjhDpXzhg2x9e
         TDTNluUinlB5azg/97/5Dd5a7MKmcwIcbbMlPOEqm4NJJntlWYKoShXcrb/o7iQWIk
         4Lm8Ve4UdIyZObOtCUeGKNfRbZI7Ifdlxh3euALR6Mp/XKOWEy2l4UPi6htlmNlwmD
         03K7HvBQPH4SJ/ttC5uIrmmGUBTKhRa9LMaD2V7m4wDitiOzCG3qx8QbjcLA3yP7IM
         ofYPAgelluGBg==
Date:   Thu, 25 Mar 2021 17:08:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: Statically set module owner
Message-ID: <20210325170853.GA15337@willie-the-truck>
References: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 12:52:01PM +0000, Robin Murphy wrote:
> It happens that the 3 drivers which first supported being modular are
> also ones which play games with their pgsize_bitmap, so have non-const
> iommu_ops where dynamically setting the owner manages to work out OK.
> However, it's less than ideal to force that upon all drivers which want
> to be modular - like the new sprd-iommu driver which now has a potential
> bug in that regard - so let's just statically set the module owner and
> let ops remain const wherever possible.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This is something I hadn't got round to sending earlier, so now rebased
> onto iommu/next to accommodate the new driver :)
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 +
>  drivers/iommu/sprd-iommu.c                  | 1 +
>  drivers/iommu/virtio-iommu.c                | 1 +
>  include/linux/iommu.h                       | 9 +--------
>  5 files changed, 5 insertions(+), 8 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
