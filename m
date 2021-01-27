Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E639A305A30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhA0Lpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbhA0Lmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:42:52 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C7DC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:42:12 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C358F303; Wed, 27 Jan 2021 12:42:10 +0100 (CET)
Date:   Wed, 27 Jan 2021 12:42:09 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: amd: Use DEFINE_SPINLOCK() for spinlock
Message-ID: <20210127114209.GD32671@8bytes.org>
References: <20201228135112.28621-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228135112.28621-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 09:51:12PM +0800, Zheng Yongjun wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/iommu/amd/iommu_v2.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.
