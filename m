Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818D4387502
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347847AbhERJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344886AbhERJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:25:57 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABAAC061573;
        Tue, 18 May 2021 02:24:40 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C4AEF2FA; Tue, 18 May 2021 11:24:38 +0200 (CEST)
Date:   Tue, 18 May 2021 11:24:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] iommu/virtio: Add missing MODULE_DEVICE_TABLE
Message-ID: <YKOH1SvN0CrfRgZ9@8bytes.org>
References: <20210508031451.53493-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508031451.53493-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 11:14:51AM +0800, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  drivers/iommu/virtio-iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Applied for v5.13, thanks.
