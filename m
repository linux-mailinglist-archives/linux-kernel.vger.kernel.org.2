Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE083C82FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhGNKga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhGNKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:36:29 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2C9C06175F;
        Wed, 14 Jul 2021 03:33:38 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8D7E3352; Wed, 14 Jul 2021 12:33:36 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:33:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Global devTLB flush when present context
 entry changed
Message-ID: <YO69cul3Ifnp6qn7@8bytes.org>
References: <20210712071315.3416543-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712071315.3416543-1-baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 03:13:15PM +0800, Lu Baolu wrote:
> ---
>  drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)

Applied, thanks.
