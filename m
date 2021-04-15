Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C17360AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhDONtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:49:16 -0400
Received: from 8bytes.org ([81.169.241.247]:35046 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDONtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:49:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6A328387; Thu, 15 Apr 2021 15:48:40 +0200 (CEST)
Date:   Thu, 15 Apr 2021 15:48:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Krzysztof Kozlowski <krzk@kernel.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Subject: Re: [PATCH 1/2] iommu/mediatek-v1: Avoid build fail when build as
 module
Message-ID: <YHhENs5Jh5h0Pz+r@8bytes.org>
References: <20210412064843.11614-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412064843.11614-1-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 02:48:42PM +0800, Yong Wu wrote:
> When this driver build as module, It build fail like:
> 
> ERROR: modpost: "of_phandle_iterator_args"
> [drivers/iommu/mtk_iommu_v1.ko] undefined!
> 
> This patch remove this interface to avoid this build fail.
> 
> Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Currently below patch is only in linux-next-20210409. This fixes tag may be
> not needed. we can add this if it is need.
> Fixes: 8de000cf0265 ("iommu/mediatek-v1: Allow building as module")
> ---
>  drivers/iommu/mtk_iommu_v1.c | 62 ++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 34 deletions(-)

Applied both, thanks.
