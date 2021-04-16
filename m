Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE336270E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbhDPRmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbhDPRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:42:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC99C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:41:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d124so18780930pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Kx3UcFdv/eRIfY3Uc8K/OykQp2bLhtDqFTwHRlJGkc=;
        b=k2MNufu1970ZVAMczqrdsGovu9JaJc1xX1Hp071LsHaxBvxl8xOhtkkxILO8FEllV/
         y5iVTa5QXGlBjFuZDsFxDbRzSb4oGG1QcTl0Yb9hE8CoPDEitRXg6Wz/ZU+SjSahYk00
         FVFeMkV3wzZl9SyGcH9OX6mzppEOaqtZpskncCTlIGxV4xR/CryjYUzTLnZwAUiOxIpf
         +ZWk4b32gkwAAFUimvGCg1wtJ+Lae5+jLSxWnMmoFcjWPlmfheYTkIYie5DHW5MC75KD
         7wEl5IuqBpCFj+g6oPIwmjb0V/vVeOOCUyah4XbzszmCeRTDpw2fjmU5h30R/MqCfDfN
         pzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Kx3UcFdv/eRIfY3Uc8K/OykQp2bLhtDqFTwHRlJGkc=;
        b=ZsVe+KDxR1AYjKRxWDsmg2m24D1q9mPPm0jGLzlkbMuWcX84K2UOQOGluQr8NH8YFb
         qrYFSWgUd6Ll8t2AEIFHuI6HhDtqM+ZeLq24dZ1VhwPyUrA7UJ8BRwJVnfY9eEuDtYTm
         F3KfIgSBTDJjH7sMPm0MPRW3DysjMvoTHO2J6iUSUAeIJJmacz1KHmAtgUei9aPdpkun
         B4F3l+rrks4aAdgjdcRQ5GaT8lehZzyBxtfeEPxQ9r81zBkc/3bFmCAxNiGkJnkPutKC
         aBhJlRb5gW71XCEzQrRCIt6S+VThwvd/z2yDntl06oeSIxXUEoMxk5p46OeE0w8Tsbrh
         X12A==
X-Gm-Message-State: AOAM530as49oeHlSc/T3uiH45UZwCGffKbKhuX3l3sRiBMpCoiyylxTh
        Ak0jhcRyDRC+3aNdtq92BVZ+xw==
X-Google-Smtp-Source: ABdhPJyEK6zn9gkTmeVXKDB7SUNWFl5FHVT928E8q/dwEi9HIjsdYuDs2H7QLKrXtoIGJaRkvO2LUg==
X-Received: by 2002:aa7:864d:0:b029:24b:dd03:edec with SMTP id a13-20020aa7864d0000b029024bdd03edecmr9062588pfo.18.1618594912941;
        Fri, 16 Apr 2021 10:41:52 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a9sm5265558pfo.186.2021.04.16.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:41:52 -0700 (PDT)
Date:   Fri, 16 Apr 2021 11:41:50 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 4/8] remoteproc: imx_rproc: parse fsl,auto-boot
Message-ID: <20210416174150.GA1050209@xps15>
References: <1618493261-32606-1-git-send-email-peng.fan@oss.nxp.com>
 <1618493261-32606-5-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618493261-32606-5-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 09:27:37PM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Parse fsl,auto-boot to indicate whether need remoteproc framework
> auto boot or not.
> 
> When remote processor is booted before Linux Kernel up, do not parse
> fsl,auto-boot, so only need to parse the property when rproc state is
> RPROC_DETACHED.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index d633887..06dac92 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -654,6 +654,9 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  
>  	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
>  
> +	if (rproc->state != RPROC_DETACHED)
> +		rproc->auto_boot = of_property_read_bool(np, "fsl,auto-boot");
> +

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	ret = rproc_add(rproc);
>  	if (ret) {
>  		dev_err(dev, "rproc_add failed\n");
> -- 
> 2.7.4
> 
