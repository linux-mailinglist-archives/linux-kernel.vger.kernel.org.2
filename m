Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9997334E428
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhC3JRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:17:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45874 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbhC3JRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:17:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C8F801A311F;
        Tue, 30 Mar 2021 11:17:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BC1DE1A133F;
        Tue, 30 Mar 2021 11:17:18 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A7FBA203DF;
        Tue, 30 Mar 2021 11:17:18 +0200 (CEST)
Date:   Tue, 30 Mar 2021 12:17:18 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Jian Dong <dj0227@163.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>
Subject: Re: [PATCH]  clk: imx: reference preceded by free
Message-ID: <20210330091718.xd6phttmlyoegsnq@fsr-ub1664-175>
References: <1616469034-9691-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616469034-9691-1-git-send-email-dj0227@163.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-23 11:10:34, Jian Dong wrote:
> From: Jian Dong <dongjian@yulong.com>
> 
>  when register failed, clk will be freed, it will generate dangling pointer
>  problem in later reference. it should return directly.
> 
> Signed-off-by: Jian Dong <dongjian@yulong.com>

Applied, thanks.

> ---
>  drivers/clk/imx/clk-lpcg-scu.c | 1 +
>  drivers/clk/imx/clk-scu.c      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
> index 77be763..dd5abd0 100644
> --- a/drivers/clk/imx/clk-lpcg-scu.c
> +++ b/drivers/clk/imx/clk-lpcg-scu.c
> @@ -114,6 +114,7 @@ struct clk_hw *__imx_clk_lpcg_scu(struct device *dev, const char *name,
>  	if (ret) {
>  		kfree(clk);
>  		hw = ERR_PTR(ret);
> +		return hw;
>  	}
>  
>  	if (dev)
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 1f5518b7..f89b4da 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -426,6 +426,7 @@ struct clk_hw *__imx_clk_scu(struct device *dev, const char *name,
>  	if (ret) {
>  		kfree(clk);
>  		hw = ERR_PTR(ret);
> +		return hw;
>  	}
>  
>  	if (dev)
> -- 
> 1.9.1
> 
> 
