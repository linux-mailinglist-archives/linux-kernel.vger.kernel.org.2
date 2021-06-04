Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD739BBF0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFDPf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:35:27 -0400
Received: from 8bytes.org ([81.169.241.247]:42340 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFDPf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:35:27 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 035A23A9; Fri,  4 Jun 2021 17:33:39 +0200 (CEST)
Date:   Fri, 4 Jun 2021 17:33:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org,
        bcm-kernel-feedback-list@broadcom.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/dma: Fix IOVA reserve dma ranges
Message-ID: <YLpH0jpLzg5R1K5o@8bytes.org>
References: <20200914072319.6091-1-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914072319.6091-1-srinath.mannam@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:53:19PM +0530, Srinath Mannam wrote:
> Fix IOVA reserve failure in the case when address of first memory region
> listed in dma-ranges is equal to 0x0.
> 
> Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
> Changes from v2:
>    Modify error message with useful information based on Bjorn's comments.
> 
> Changes from v1:
>    Removed unnecessary changes based on Robin's review comments.
> 
>  drivers/iommu/dma-iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.
