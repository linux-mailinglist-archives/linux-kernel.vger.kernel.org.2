Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EC741421F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhIVGq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232770AbhIVGq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:46:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E3F761184;
        Wed, 22 Sep 2021 06:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632293128;
        bh=b4P0Qy8Nb5H0Hi0ul/osrvT68IMpJoDX5vWluNtevdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhc1DZpXAI/DxTCL+qWTeUDk26xXoyPWJLcMzdNOTgay9V5aeAi/the9GczrQUWWB
         7B1YFJmmVARvRYllm7eQV1OhePNXuK96y1JlB7EIUTjmXvONykPoNRFA5Q2cbv+5X7
         iPRfbbsS9QXbGre92FhMAI6NMGGlj4zeaKgEVBmsS4+qbP/RMVhyGXqIyzm6uJ0R5k
         jzsjkrIgV9jNQPQD6S6a9Da+rW+b+ku+GTRuGuPoYe3cu3wz+E7Z9fOJz9kZXiZAEm
         5O6ta86BfhmnTloYhLVOwD3rbRa0XMNHdt6VqMHzhvgocTOEafzaiPJM2phpbsLALq
         CZ/TslAy2DFRw==
Date:   Wed, 22 Sep 2021 14:45:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 2/3] arm: dts: imx: fix the schema check errors
Message-ID: <20210922064520.GD13480@dragon>
References: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
 <1630046580-19282-3-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630046580-19282-3-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 02:42:59PM +0800, Richard Zhu wrote:
> - ranges property should be grouped by region, with no functional
>   changes. Otherwise, schema dtbs_check would report the following errors.
> "linux-imx/arch/arm/boot/dts/imx6qp-vicutp.dt.yaml: pcie@1ffc000: ranges: 'oneOf' conditional failed, one must be fixed:
>         linux-imx/arch/arm/boot/dts/imx6qp-vicutp.dt.yaml: pcie@1ffc000: ranges: 'oneOf' conditional failed, one must be fixed:
>                 [[2164260864, 0, 0, 33030144, 0, 65536, 2181038080, 0, 16777216, 16777216, 0, 15728640]] is not of type 'boolean'
>                 True was expected
>                 [[2164260864, 0, 0, 33030144, 0, 65536, 2181038080, 0, 16777216, 16777216, 0, 15728640]] is not of type 'null'
>         [2164260864, 0, 0, 33030144, 0, 65536, 2181038080, 0, 16777216, 16777216, 0, 15728640] is too long
>         From schema: linux-imx/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml"
> - refer to commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows").
>   The num-viewport is not required anymore, remove them totally.
> - dt_binding_check complains "compatible: ['fsl,imx6qp-pcie', 'snps,dw-pcie']
>   is too long", remove "snps,dw-pcie" from the compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks!
