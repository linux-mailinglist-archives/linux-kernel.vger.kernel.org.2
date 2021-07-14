Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD233C830E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhGNKnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:43:02 -0400
Received: from 8bytes.org ([81.169.241.247]:37804 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhGNKnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:43:00 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5C4CB352; Wed, 14 Jul 2021 12:40:08 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:40:06 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     will@kernel.org, heiko@sntech.de, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3] iommu/rockchip: Fix physical address decoding
Message-ID: <YO6/BuhfxO3R5H0y@8bytes.org>
References: <20210712101232.318589-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712101232.318589-1-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:12:32PM +0200, Benjamin Gaignard wrote:
> Restore bits 39 to 32 at correct position.
> It reverses the operation done in rk_dma_addr_dte_v2().
> 
> Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 3:
>  - change commit header to match with IOMMU tree convention

Applied, thanks.
