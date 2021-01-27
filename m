Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23200305A17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhA0LmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbhA0LbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:31:22 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13CBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:30:23 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 247E5303; Wed, 27 Jan 2021 12:29:29 +0100 (CET)
Date:   Wed, 27 Jan 2021 12:29:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/6] IOMMU: Some more IOVA and core code tidy-up
Message-ID: <20210127112925.GA32671@8bytes.org>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 09:35:05PM +0800, John Garry wrote:
> Just some tidy-up to IOVA and core code.
> 
> Based on v5.11-rc2
> 
> Differences to v1:
> - Add core IOMMU patches
> 
> John Garry (6):
>   iova: Make has_iova_flush_queue() private
>   iova: Delete copy_reserved_iova()
>   iova: Stop exporting some more functions
>   iommu: Stop exporting iommu_map_sg_atomic()
>   iommu: Delete iommu_domain_window_disable()
>   iommu: Delete iommu_dev_has_feature()

Applied, thanks.
