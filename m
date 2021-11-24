Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2074645CA28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349065AbhKXQh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:37:57 -0500
Received: from 8bytes.org ([81.169.241.247]:59474 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349029AbhKXQh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:37:56 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6B7A9341; Wed, 24 Nov 2021 17:34:44 +0100 (CET)
Date:   Wed, 24 Nov 2021 17:34:35 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568
Message-ID: <YZ5pm2kFM41OOu+Y@8bytes.org>
References: <20211124021325.858139-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124021325.858139-1-knaerzche@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 03:13:25AM +0100, Alex Bee wrote:
> With the submission of iommu driver for RK3568 a subtle bug was
> introduced: PAGE_DESC_HI_MASK1 and PAGE_DESC_HI_MASK2 have to be
> the other way arround - that leads to random errors, especially when
> addresses beyond 32 bit are used.
> 
> Fix it.
> 
> Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Applied for v5.16, thanks.
