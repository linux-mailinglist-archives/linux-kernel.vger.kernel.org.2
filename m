Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5ED39DD0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFGM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhFGM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:57:42 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B41C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 05:55:51 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 66702391; Mon,  7 Jun 2021 14:55:48 +0200 (CEST)
Date:   Mon, 7 Jun 2021 14:55:47 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jussi Maki <joamaki@gmail.com>
Subject: Re: [PATCH] iommu/amd: Tidy up DMA ops init
Message-ID: <YL4XU/9GKXBQBiN8@8bytes.org>
References: <665db61e23ff8d54ac5eb391bef520b3a803fcb9.1622727974.git.robin.murphy@arm.com>
 <YLpGHx+rYnBF64Yh@8bytes.org>
 <781da5b3-4856-9a76-d803-51800dec6033@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781da5b3-4856-9a76-d803-51800dec6033@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 06:35:17PM +0100, Robin Murphy wrote:
> For the sake of justifying this as "fix" rather than "cleanup", you may as
> well use the flush queue commit cited in the patch log - I maintain there's
> nothing technically wrong with that commit itself, but it is the point at
> which the underlying issue becomes worth fixing due to how they interact ;)

Okay :) I added:

Fixes: a250c23f15c2 ("iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE")

Regards,

	Joerg
