Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9782F3DDAEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhHBOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbhHBOY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:24:59 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E9C061384
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:23:16 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 417CA3C3; Mon,  2 Aug 2021 16:23:14 +0200 (CEST)
Date:   Mon, 2 Aug 2021 16:23:08 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     iommu@lists.linux-foundation.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
Subject: Re: [PATCH v2] iommu: Check if group is NULL before remove device
Message-ID: <YQf/zKTtlV/BPTi/@8bytes.org>
References: <20210731074737.4573-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731074737.4573-1-linux@fw-web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 09:47:37AM +0200, Frank Wunderlich wrote:
> Fixes: d72e31c93746 ("iommu: IOMMU Groups")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - commit-message with captial letters on beginning of sentenence
> - added more information, many thanks to Yong Wu

Applied, thanks.
