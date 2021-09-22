Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B02414222
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhIVGtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232710AbhIVGti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D270461184;
        Wed, 22 Sep 2021 06:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632293288;
        bh=GZjQIFKbFZFtRAx+smMS36ixmN7bbJnbuI8ZYsHz0dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2vV6JU70a/IdoWSCjrPZk3oRkbIF7FDelLjdsqocfzyajW/n4iQ0oPJ/EVCg+ZbD
         coF9NN7IeFHfZtvhwHwpi+BRBkvb8vTAoJ8G9rBpJwkkzMGPB932o7y7x5V+bAc8Za
         ByLjUIhcWiGKkFV4o9lzpen+QjHgVGzjXAMRT26ZFz6j5ITyDNwPIW7AVrs21W54GK
         DfeXHjmy5KcdRtx38Dh55e2qMDpuHd8mq7ppEPA0dtRX13Q0R5fn7KySr9Yk/l2Nou
         ZJk/XBZSQ4SuATgBxTlu5JIBIgVqLtgSsOU6SyKxGAyN+ATjmd9wKdYwiE2sa8axd9
         kPZRTdZFE602w==
Date:   Wed, 22 Sep 2021 14:48:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mq: fix the schema check errors
Message-ID: <20210922064802.GE13480@dragon>
References: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
 <1630046580-19282-4-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630046580-19282-4-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 02:43:00PM +0800, Richard Zhu wrote:
> No functional changes, but the ranges should be grouped by region.
> Otherwise, schema dtbs_check would report the following errors.
> 
> "/linux-imx/arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: pcie@33800000: ranges: 'oneOf' conditional failed, one must be fixed:
>         /linux-imx/arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: pcie@33800000: ranges: 'oneOf' conditional failed, one must be fixed:
>                 [[2164260864, 0, 0, 536346624, 0, 65536, 2181038080, 0, 402653184, 402653184, 0, 133169152]] is not of type 'boolean'
>                 True was expected
>                 [[2164260864, 0, 0, 536346624, 0, 65536, 2181038080, 0, 402653184, 402653184, 0, 133169152]] is not of type 'null'
>         [2164260864, 0, 0, 536346624, 0, 65536, 2181038080, 0, 402653184, 402653184, 0, 133169152] is too long
>         From schema: //linux-imx/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml"
> 
> Refer to commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows").
> The num-viewport is not required anymore, remove them totally.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks!
