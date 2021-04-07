Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80FA35675E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349723AbhDGI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhDGI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:58:19 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88938C0613D7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:48:02 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 414EB2A6; Wed,  7 Apr 2021 10:48:01 +0200 (CEST)
Date:   Wed, 7 Apr 2021 10:47:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     will@kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] iommu: Remove duplicate check of pasids
Message-ID: <YG1xvyeBZZN+WjM4@8bytes.org>
References: <1617275956-4467-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617275956-4467-1-git-send-email-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 07:19:16PM +0800, Qi Liu wrote:
> Remove duplicate check of pasids in amd_iommu_domain_enable_v2(), as it
> has been guaranteed in amd_iommu_init_device().
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/iommu/amd/iommu.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.
