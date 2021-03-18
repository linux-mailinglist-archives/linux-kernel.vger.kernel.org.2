Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765613402A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhCRKBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCRKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:01:32 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391CBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:01:32 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AFDC62D8; Thu, 18 Mar 2021 11:01:30 +0100 (CET)
Date:   Thu, 18 Mar 2021 11:01:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, john.garry@huawei.com,
        thunder.leizhen@huawei.com, vjitta@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/iova: Add rbtree entry helper
Message-ID: <YFMk+fLh7KGp4ZdR@8bytes.org>
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:35:22PM +0000, Robin Murphy wrote:
> Repeating the rb_entry() boilerplate all over the place gets old fast.
> Before adding yet more instances, add a little hepler to tidy it up.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iova.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)

Applied both, thanks Robin.
