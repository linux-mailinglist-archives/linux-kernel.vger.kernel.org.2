Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4EB357224
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354311AbhDGQ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhDGQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:29:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1520C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:29:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e10so5245624pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=30vaYO8QvcWp/TkVqpqtB3ob8eJXnmjqog5CouESalk=;
        b=hs7bKSs1jZB7tVMk24eqMdDhXi/Zi78JsD8ccMJHgSikkyBi9yOwjKQYOw7Qpa+91C
         zj3yKvPCbnyb5xrHxkYPdawFWI+zjII/gCnB3bat7B3fUY7b0UbDQ6otxH8nWAxlf/i8
         DVRFFuQUbSzXDHNzi+E7uCv4Pr5a4DuOBgOP8cl+YkyjitiTFsKSkNEKKmiY63amBIvB
         lAPAVSA5vcJd4ludsDfTHGGedt+fdfQqvUA9M/V8wMWMUV40Lf8uiyFXG/bY7TJqsfL7
         z1s2Y65AkNZhj6EE3p8g/gek5keY3i+9u3obqr7J/zA/WsbiGe75qDFEY7e3rLJ0iYPh
         kNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=30vaYO8QvcWp/TkVqpqtB3ob8eJXnmjqog5CouESalk=;
        b=mUcxcWSQhlXbpVYB4kvTTN2/59HbenDGJLM4fttnTZqddx7rkIDtGxgAYzU3M7bGsT
         9pEbIg1jYDqaMgHPs1fWNq87Z9+iX5cZnN221XZHT8+GIDlr69TSFOAZloY2kXTn4F4A
         2HZOpE9JYU36l3+NKYSm27hlhn9ZN8h4Nh6htImXGU5yCDh102PxiOoS2jLN530clkGw
         Fvo4H+ZOTae+jQMqxayA8NF8FeJJmAq28BcNnCmhOclNE0opWQ83PXVSOvI81S9bSZjV
         oxA3A/wp/IUpmK4CvKviv9jMVvGQkc3utQdfxUDOb2h4zA47mis3c+31vS9pbi59TbYb
         n4OA==
X-Gm-Message-State: AOAM530hFD1sYSugfk9JGROSHa7QcOOlrPtiZc+DwPZDCc5kq6ADYQm0
        4pGptHcjjzEEKSZMHRHhOfabTg==
X-Google-Smtp-Source: ABdhPJxp1BMcOO2FCXs6zLTKMNXvSMVT4MFuXpVxFI+xBc98lIgK6yT8/QQT0HBAnGcZnxOd2LsOgg==
X-Received: by 2002:a17:90a:6e47:: with SMTP id s7mr4143181pjm.229.1617812968299;
        Wed, 07 Apr 2021 09:29:28 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x18sm2456918pfu.32.2021.04.07.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:29:27 -0700 (PDT)
Date:   Wed, 7 Apr 2021 10:29:26 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 1/4] remoteproc: imx: add missing of_node_put
Message-ID: <20210407162926.GC418374@xps15>
References: <1617082235-15923-1-git-send-email-peng.fan@oss.nxp.com>
 <1617082235-15923-2-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617082235-15923-2-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 01:30:32PM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> After of_parse_phandle, we need of_node_put to decrease the refcount
> of the device_node.
> 
> Reported-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 6d3207ccbaef..077413319f58 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -459,6 +459,8 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  			return err;
>  		}
>  
> +		of_node_put(node);
> +

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  		if (b >= IMX7D_RPROC_MEM_MAX)
>  			break;
>  
> -- 
> 2.30.0
> 
