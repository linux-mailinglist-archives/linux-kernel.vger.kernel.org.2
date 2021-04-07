Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C3E35723C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354333AbhDGQhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhDGQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:36:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96AC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:36:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso1618624pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pEEhjTO9JV5okKF7T4MRSprI70KvuiQd/IpVgcL8zGg=;
        b=o/VII+Jx+ad6iMKK+qAdAYnwhh9a6MQvFh9liFeXv1i74yoOg4/4KHJHadvYQJ8gj6
         ZAB+0xL/BQT/MwzCoeW1Nkdjo2BzA4JtDQeDZSsvN2/tkIrmMUclyB8bsf9LNz44wlYu
         mnErsaqChcz4N/LsCo6sHFauznR2iFqheiSCAYaeuWfAX7MLDITO2T9jCNjmXrTDS9hp
         qqB6ujoz1NMlwZgKys38LYk8XNvqBNIfIiYBExIkPkPzKfa5nzPFkY0Y0oQYCTsHEacI
         U2ClAZTUJ/pnzHKumNoDWdjWghmRW6ltleYu4/bnBazDTR94cgPRq2fhXdA5nqAoEyDC
         lGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pEEhjTO9JV5okKF7T4MRSprI70KvuiQd/IpVgcL8zGg=;
        b=AqWx5Tb4eOvZM/uf9vWuI8LtRTnVEOu+yKvzps0nwjcxtq8cARUiybHQ+uwSVUZBKM
         xeNozbexYMKwlihuUn5fThz6l3Mt5+rC/av9zR5lsVB966hIzbjZ3QhNOmakTyQUfY5b
         1IB69TXt7Byt7E8sUPC6UxH2PMc+WWQ2Nn1inCHDJ+Q+XXT5PN8eygvJtzPyv7NxZtOP
         mAyVE1jkzYmV98h1bTXCSi5SN2GhsdYOtnS96yYm+kxqDejWcpcZsB7dVwP308ZRUREg
         gGX69SlXeKK1FWDBNm0PoYaFabFjXUIuHEXyAs1rHryaHX4hcpwFO+FLh3IUNwgMn/IU
         rvMA==
X-Gm-Message-State: AOAM533d90UppSPmTXZREUZp5JkgSEoRGkMIiPHSKEhMi8EYLTODbr+3
        JGaQtodtTjWSl3NzljN4VXDP1A==
X-Google-Smtp-Source: ABdhPJwwpcXbX3SPUZyeqzlXInVrruizddprEMheMKqVbORqTtMo4h/iT/KC4/GRIcmDyX6msyrC2Q==
X-Received: by 2002:a17:902:bb8e:b029:e6:3b2:5834 with SMTP id m14-20020a170902bb8eb02900e603b25834mr3815144pls.38.1617813404691;
        Wed, 07 Apr 2021 09:36:44 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n16sm21971850pff.119.2021.04.07.09.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:36:44 -0700 (PDT)
Date:   Wed, 7 Apr 2021 10:36:42 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 3/4] remoteproc: imx: move memory parsing to rproc_ops
Message-ID: <20210407163642.GD418374@xps15>
References: <1617082235-15923-1-git-send-email-peng.fan@oss.nxp.com>
 <1617082235-15923-4-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617082235-15923-4-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 01:30:34PM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use the rproc_ops::prepare() hook for doing memory resources
> reallocation when reattach an remote procesor.
> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index b05aae0ad7a2..7cd09971d1a4 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -317,7 +317,7 @@ static int imx_rproc_mem_release(struct rproc *rproc,
>  	return 0;
>  }
>  
> -static int imx_rproc_parse_memory_regions(struct rproc *rproc)
> +static int imx_rproc_prepare(struct rproc *rproc)
>  {
>  	struct imx_rproc *priv = rproc->priv;
>  	struct device_node *np = priv->dev->of_node;
> @@ -363,10 +363,7 @@ static int imx_rproc_parse_memory_regions(struct rproc *rproc)
>  
>  static int imx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  {
> -	int ret = imx_rproc_parse_memory_regions(rproc);
> -
> -	if (ret)
> -		return ret;
> +	int ret;
>  
>  	ret = rproc_elf_load_rsc_table(rproc, fw);
>  	if (ret)
> @@ -399,6 +396,7 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
>  }
>  
>  static const struct rproc_ops imx_rproc_ops = {
> +	.prepare	= imx_rproc_prepare,
>  	.start		= imx_rproc_start,
>  	.stop		= imx_rproc_stop,
>  	.kick		= imx_rproc_kick,
> -- 
> 2.30.0
> 
