Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7851F41AC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbhI1Jkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:40:37 -0400
Received: from 8bytes.org ([81.169.241.247]:39780 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235071AbhI1Jkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:40:36 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F33BA2FF; Tue, 28 Sep 2021 11:38:55 +0200 (CEST)
Date:   Tue, 28 Sep 2021 11:38:54 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dart: Remove iommu_flush_ops
Message-ID: <YVLirjjXIJFqEm3m@8bytes.org>
References: <20210921153934.35647-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921153934.35647-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:39:34PM +0200, Sven Peter wrote:
 
> Fixes: 46d1fb072e76b161 ("iommu/dart: Add DART iommu driver")
> Reported-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 18 ------------------
>  1 file changed, 18 deletions(-)

Applied for v5.15, thanks Sven.
