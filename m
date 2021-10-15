Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0896042E728
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 05:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhJODTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 23:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhJODTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 23:19:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 855EE61073;
        Fri, 15 Oct 2021 03:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634267862;
        bh=Ux69hECYzDx+dh+M+NFT22iOJ55SGHWsAhrVpj/fST8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtB0MjUh+wbQK7vUBPnDiSt+M8peK3mw3z8Jfgp5kSr/g3B31S5GdvPbSYRa8Ihf7
         HbAf86pwGkhL/W16aeZTuprRE01bZs02lWVTq8OgOzmPSXGXWl63J6c/rTTYXRW52r
         fVk+q+xDE/O2k3rJmSvHkBCBO+RppU76xrn0aYsUfGsm0pimMIF5wze4W2kM5N7+oZ
         qo84lnpDy1QQGhrbagy+YiZSP6DdieweDrrGvhuOIE8tnh3F1jhPtSsabLIwUGjhJk
         ofGK7CyNFE+TFvWObJijuCLNJvgWMZt7z0f40yZljHEj/a3Nn//o+ImHF7bSGv/tBP
         /2sLOcQyogCXw==
Date:   Fri, 15 Oct 2021 11:17:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/17] Cleanup of LS1021a device trees
Message-ID: <20211015031735.GD22881@dragon>
References: <20211012235824.31096-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012235824.31096-1-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 06:58:06PM -0500, Li Yang wrote:
> This is a series of patches trying to cleanup the LS1021a based device
> trees including:
> - Add missing nodes
> - Update to use SPDX tags
> - Fix existing schema check issues in dts
> - Update related bindings to deal with some check issues
> 
> Changes in V2
> - Spin-off the IFC binding related patches into a separate series due to
>   its dependency on driver changes
> - Added two more fixes about thermal-zones node and flash compatible
> - Remove copyright updates
> - Updated description in i2c binding patch to clarify the intension
> - Added Acked-by tag
> 
> Changes in V3
> - Remove the flash label and num-cs
> - Drop the i2c-imx binding change, instead update the DTS to remove
>   clock-names and re-order DMA channels
> 
> Li Yang (17):
>   dt-bindings: arm: fsl: add ls1021a-tsn board
>   ARM: dts: ls1021a: remove clock-names property for i2c nodes
>   ARM: dts: ls1021a: change dma channels order to match schema
>   ARM: dts: ls1021a: change to use SPDX identifiers
>   ARM: dts: ls1021a-qds: Add node for QSPI flash
>   ARM: dts: ls1021a: update pcie nodes for dt-schema check
>   ARM: dts: ls1021a: fix board compatible to follow binding schema
>   ARM: dts: ls1021a: breakup long values in thermal node
>   ARM: dts: ls1021a: disable ifc node by default
>   ARM: dts: ls1021a: remove regulators simple-bus
>   ARM: dts: ls1021a: fix memory node for schema check
>   ARM: dts: ls1021a: add #dma-cells to qdma node
>   ARM: dts: ls1021a: add #power-domain-cells for power-controller node
>   ARM: dts: ls1021a-qds: change fpga to simple-mfd device
>   ARM: dts: ls1021a-tsn: remove undocumented property "position" from
>     mma8452 node
>   ARM: dts: ls1021a: move thermal-zones node out of soc/
>   ARM: dts: ls1021a-tsn: use generic "jedec,spi-nor" compatible for
>     flash

Applied all, thanks!
