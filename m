Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B9B39BBCE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhFDP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhFDP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:28:12 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B915DC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 08:26:25 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 687BC3A9; Fri,  4 Jun 2021 17:26:24 +0200 (CEST)
Date:   Fri, 4 Jun 2021 17:26:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jussi Maki <joamaki@gmail.com>
Subject: Re: [PATCH] iommu/amd: Tidy up DMA ops init
Message-ID: <YLpGHx+rYnBF64Yh@8bytes.org>
References: <665db61e23ff8d54ac5eb391bef520b3a803fcb9.1622727974.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665db61e23ff8d54ac5eb391bef520b3a803fcb9.1622727974.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 02:48:21PM +0100, Robin Murphy wrote:
> As discussed on the report thread, I think it makes most sense to merge
> this as a fix for 5.13 and not worry about any backporting.
> 
>  drivers/iommu/amd/amd_iommu.h |  2 --
>  drivers/iommu/amd/init.c      |  5 -----
>  drivers/iommu/amd/iommu.c     | 31 +++++++++++++------------------
>  3 files changed, 13 insertions(+), 25 deletions(-)

Applied for v5.13, thanks Robin et al for the quick work on this
regression.

Robin, do you by chance have a Fixes tag which I can add?

Thanks,

	Joerg
