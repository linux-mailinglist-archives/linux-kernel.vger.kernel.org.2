Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3639BB3F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFDO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:56:47 -0400
Received: from 8bytes.org ([81.169.241.247]:42264 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhFDO4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:56:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E92D83A9; Fri,  4 Jun 2021 16:54:58 +0200 (CEST)
Date:   Fri, 4 Jun 2021 16:54:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     will@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        xxm@rock-chips.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v7 0/4] Add IOMMU driver for rk356x
Message-ID: <YLo+wa5Z3KILTgrR@8bytes.org>
References: <20210525121551.606240-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525121551.606240-1-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 02:15:47PM +0200, Benjamin Gaignard wrote:
> Benjamin Gaignard (4):
>   dt-bindings: iommu: rockchip: Convert IOMMU to DT schema
>   dt-bindings: iommu: rockchip: Add compatible for v2
>   iommu: rockchip: Add internal ops to handle variants

Applied patches 1-3, thanks.
