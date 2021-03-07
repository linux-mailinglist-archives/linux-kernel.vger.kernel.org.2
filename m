Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4007330123
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 14:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCGNQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 08:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbhCGNQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 08:16:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2A1165104;
        Sun,  7 Mar 2021 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615123006;
        bh=6BnRXYRyxQEIIGtVidTXEuB61ATEg1cyuiQwx/8CGKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HeBd5DDM9633U7s3qMEg5mhkJuBJeXWEcmlw/AgKze4zIweFVCCdY8jPEDuVYQTjv
         p8w1iZnwlkaJ3LVmbxazRwDhn4IteIuRyLj3ezLAYMoYcXYyNgwthEB8OuFEf334xz
         f5ZNwwMp4XjBSzOlODdcLcI32qDGUBy5oTYIYKZ/V7de7phAx0ln5e4/8XbfrQvZZF
         GLCddzXTJUUal4TJKx3wz7qLxWsMHp2k13yZt3f/ul6f4BntVOIecloFo5K3d6Ybub
         Gq4iJ+IxJNzbJ8r+gt5w7hF7cLWIE5hymOOKE8lioVsEb1F47bE+MB8U7D1Q54GQRj
         bp7VTgUufLjnw==
Date:   Sun, 7 Mar 2021 21:16:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Cc:     ping.bai@nxp.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx8mq: Correct the pcie aux sels
Message-ID: <20210307131641.GF543@dragon>
References: <1613633374-30622-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613633374-30622-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Abel

On Thu, Feb 18, 2021 at 03:29:34PM +0800, Richard Zhu wrote:
> The sys2_pll_50m should be one of the clock sels of PCIE_AUX clock,
> Change the sys2_pll_500m to sys2_pll_50m.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 4dd4ae9d022b..93480d8858be 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -118,7 +118,7 @@ static const char * const imx8mq_pcie1_ctrl_sels[] = {"osc_25m", "sys2_pll_250m"
>  static const char * const imx8mq_pcie1_phy_sels[] = {"osc_25m", "sys2_pll_100m", "sys2_pll_500m", "clk_ext1", "clk_ext2",
>  					      "clk_ext3", "clk_ext4", };
>  
> -static const char * const imx8mq_pcie1_aux_sels[] = {"osc_25m", "sys2_pll_200m", "sys2_pll_500m", "sys3_pll_out",
> +static const char * const imx8mq_pcie1_aux_sels[] = {"osc_25m", "sys2_pll_200m", "sys2_pll_50m", "sys3_pll_out",
>  					      "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_160m", "sys1_pll_200m", };
>  
>  static const char * const imx8mq_dc_pixel_sels[] = {"osc_25m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m", "sys3_pll_out", "clk_ext4", };
> -- 
> 2.17.1
> 
