Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B74730CB93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbhBBT3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhBBN7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:59:08 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7DEC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 05:58:27 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3FB893E6; Tue,  2 Feb 2021 14:58:26 +0100 (CET)
Date:   Tue, 2 Feb 2021 14:58:24 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Properly pass gfp_t in _iommu_map() to avoid
 atomic sleeping
Message-ID: <20210202135824.GZ32671@8bytes.org>
References: <20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:06:23PM -0800, Douglas Anderson wrote:
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
