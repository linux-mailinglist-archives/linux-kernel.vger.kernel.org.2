Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7A34027B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCRJvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhCRJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:51:23 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A1C06174A;
        Thu, 18 Mar 2021 02:51:22 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F330A2D8; Thu, 18 Mar 2021 10:51:19 +0100 (CET)
Date:   Thu, 18 Mar 2021 10:51:18 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v5 0/2] Add Unisoc IOMMU basic driver
Message-ID: <YFMilmgApRdWYDad@8bytes.org>
References: <20210305093216.201897-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305093216.201897-1-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 05:32:14PM +0800, Chunyan Zhang wrote:
>  .../devicetree/bindings/iommu/sprd,iommu.yaml |  57 ++
>  drivers/iommu/Kconfig                         |  12 +
>  drivers/iommu/Makefile                        |   1 +
>  drivers/iommu/sprd-iommu.c                    | 577 ++++++++++++++++++
>  4 files changed, 647 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
>  create mode 100644 drivers/iommu/sprd-iommu.c

Applied, thanks.
