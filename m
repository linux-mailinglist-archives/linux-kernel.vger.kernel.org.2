Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F943874FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346909AbhERJZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbhERJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:24:58 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4303C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:23:40 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C6AE02FA; Tue, 18 May 2021 11:23:38 +0200 (CEST)
Date:   Tue, 18 May 2021 11:23:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iommu/amd: Fix wrong parentheses on page-specific
 invalidations
Message-ID: <YKOHmQcqW0bX59nV@8bytes.org>
References: <20210502070001.1559127-1-namit@vmware.com>
 <20210502070001.1559127-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210502070001.1559127-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 11:59:56PM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> The logic to determine the mask of page-specific invalidations was
> tested in userspace. As the code was copied into the kernel, the
> parentheses were mistakenly set in the wrong place, resulting in the
> wrong mask.
> 
> Fix it.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 268aa4548277 ("iommu/amd: Page-specific invalidations for more than one page")
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied this one for v5.13, thanks Nadav.

Somehow the rest of the patch-set got screwed up during sending or so,
at least I see some patches twice in my inbox and with different
subjects.

Can you please re-send patches 2-4 when -rc3 it out?

Thanks,

	Joerg
