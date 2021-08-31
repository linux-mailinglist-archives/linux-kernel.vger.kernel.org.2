Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9825A3FCFCA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 01:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhHaXGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 19:06:09 -0400
Received: from rosenzweig.io ([138.197.143.207]:44874 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241192AbhHaXGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:06:06 -0400
Date:   Tue, 31 Aug 2021 17:40:32 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] iommu/dart: Remove force_bypass logic
Message-ID: <YS6h0E1lM5owyLWp@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-9-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828153642.19396-9-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Now that the dma-iommu API supports IOMMU granules which are larger than
> the CPU page size and that the kernel no longer runs into a BUG_ON when
> devices are attached to a domain with such a granule there's no need to
> force bypass mode anymore.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

This was such an ugly hack, glad to see it go. This patch is

	Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
