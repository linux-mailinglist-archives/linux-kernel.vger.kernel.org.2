Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E492360A90
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhDONe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhDONe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:34:57 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:34:32 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 30B46387; Thu, 15 Apr 2021 15:34:30 +0200 (CEST)
Date:   Thu, 15 Apr 2021 15:34:26 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, will@kernel.org, yong.wu@mediatek.com,
        kernel@collabora.com, dafna3@gmail.com,
        enric.balletbo@collabora.com
Subject: Re: [PATCH] iommu/mediatek: always enable the clk on resume
Message-ID: <YHhA4u7zat3vtJfD@8bytes.org>
References: <20210408122842.29009-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408122842.29009-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 02:28:42PM +0200, Dafna Hirschfeld wrote:
>  drivers/iommu/mtk_iommu.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Applied, thanks.
