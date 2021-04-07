Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF95A356748
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhDGIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349691AbhDGIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:53:19 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA10C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:44:11 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7CEC12A6; Wed,  7 Apr 2021 10:44:10 +0200 (CEST)
Date:   Wed, 7 Apr 2021 10:44:08 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] iommu: sprd: Fix parameter type warning
Message-ID: <YG1w2N1UdlbzoY4v@8bytes.org>
References: <20210331031645.1001913-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331031645.1001913-1-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:16:45AM +0800, Chunyan Zhang wrote:
>  drivers/iommu/sprd-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
