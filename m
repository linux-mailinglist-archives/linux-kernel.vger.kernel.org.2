Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33C638D891
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 05:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhEWDju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 23:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231528AbhEWDjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 23:39:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 356C16115C;
        Sun, 23 May 2021 03:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621741104;
        bh=b6jp1x2ZGWuy2CC16vguZJqSjntrUqQvRjIQyUE4VKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJmo/mnZVvALMDSi6xGXjKTggphRJK+lxaWvwtC7hi4g9pVfGXoeLVPcJTuSWr40G
         fWjnKJOVypkmcB3DVddORIl5y/MtqgUO7iBgq1/U/bnMi+mjkL2uhWot097FPBbWDS
         AoNw3mVSOXDGnScpDUINhYQLXb/VZygvkwd5doyEOiNLLQBTTmd7sO/wvNMEMJUenV
         ZRLSl70mXtxckBZ2SWxiDBq7ynDQ/eWNe2P9JB7KmyLvL39LZ7hFooqLJOoAxEMQ52
         VAMdaLui76JawpXTdCsg7xDm+jI6rqjWfreTdiRMkwQc2pl8Nf9Wb5k8C3//b/IZ2L
         jUUwIGuLICrgQ==
Date:   Sun, 23 May 2021 11:38:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, iuliana.prodan@nxp.com, Anson.Huang@nxp.com,
        peng.fan@nxp.com, alice.guo@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soc: imx8m: add missing MODULE_DEVICE_TABLE
Message-ID: <20210523033818.GT8194@dragon>
References: <1620790885-15892-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620790885-15892-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:41:25AM +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

I do not see it supports module build right now.

Shawn

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 071e144..8debf62 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -186,6 +186,7 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
>  	{ .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, imx8_soc_match);
>  
>  #define imx8_revision(soc_rev) \
>  	soc_rev ? \
> -- 
> 2.6.2
> 
