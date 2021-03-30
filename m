Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285DB34E374
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhC3Iod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231608AbhC3IoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:44:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E63660249;
        Tue, 30 Mar 2021 08:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617093861;
        bh=oFFDK2BLu4MoJQwEi0hkeaCQvHCq16fu8EbC6R/hx2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTK2HmzfRGgWYLx1e9G2StgfMaoh4DtbvaOApdgOK+guipLCNn7rLV1H3/GGFI0yc
         G8FDcqt+MZfuQ0Hk1Np3ukzWrHn/VlAZtWHDQ7ucd9EwfsPTg3jOpsqFb900S2nuIP
         m3FzEic5krxhzGoy7ltJxEGlzlN2VDA8UXd1SOw4jtVuak4AoGFQ5NY7GUE6xkmieL
         F61hiBCFOYEYPmmdtRL36h+JeJp+YF/6ZhU3pVQO2B0TX3bIXltKECE5cNOUPdxwdV
         jNQd43QxYmz5TFgIJkdg9gK6Irmj21R/dRrAFvlZLlBmcaZGGPaeVWPJtLKA3NxM1l
         13INKpE6pwIqQ==
Date:   Tue, 30 Mar 2021 11:44:17 +0300
From:   Abel Vesa <abelvesa@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     abel.vesa@nxp.com, shawnguo@kernel.org, ping.bai@nxp.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: imx8mq: Correct the pcie1 sels
Message-ID: <YGLk4cfJuPLbCJ2g@ryzen.lan>
References: <1615796268-9011-1-git-send-email-hongxing.zhu@nxp.com>
 <1615796268-9011-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615796268-9011-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-15 16:17:48, Richard Zhu wrote:
> - The sys2_pll_50m should be one of the clock sels of PCIE_AUX clock.
> Change the sys2_pll_500m to sys2_pll_50m.
> - Correct one mis-spell of the imx8mq_pcie1_ctrl_sels definition, from
> "sys2_pll_250m" to "sys2_pll_333m".
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Applied, thanks.

> ---
>  drivers/clk/imx/clk-imx8mq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 4dd4ae9d022b..c66c196f396c 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -113,12 +113,12 @@ static const char * const imx8mq_disp_dtrc_sels[] = {"osc_25m", "vpu_pll_out", "
>  static const char * const imx8mq_disp_dc8000_sels[] = {"osc_25m", "vpu_pll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys3_pll_out", "audio_pll2_out", };
>  
>  static const char * const imx8mq_pcie1_ctrl_sels[] = {"osc_25m", "sys2_pll_250m", "sys2_pll_200m", "sys1_pll_266m",
> -					       "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_250m", "sys3_pll_out", };
> +					       "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_333m", "sys3_pll_out", };
>  
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
