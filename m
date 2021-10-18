Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071F943179C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhJRLmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhJRLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:42:15 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043DDC06161C;
        Mon, 18 Oct 2021 04:40:03 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BC604694; Mon, 18 Oct 2021 13:40:00 +0200 (CEST)
Date:   Mon, 18 Oct 2021 13:39:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     thierry.reding@gmail.com, vdumpa@nvidia.com, will@kernel.org,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra-smmu: Use devm_bitmap_zalloc when applicable
Message-ID: <YW1dDaV8fRrQ1heP@8bytes.org>
References: <2c0f4da80c3b5ef83299c651f69a563034c1c6cb.1632661557.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0f4da80c3b5ef83299c651f69a563034c1c6cb.1632661557.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 03:07:18PM +0200, Christophe JAILLET wrote:
> 'smmu->asids' is a bitmap. So use 'devm_kzalloc()' to simplify code,
> improve the semantic of the code and avoid some open-coded arithmetic in
> allocator arguments.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/iommu/tegra-smmu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied, thanks.
