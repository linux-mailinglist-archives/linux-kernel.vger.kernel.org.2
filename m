Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2365342142E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbhJDQgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:36:12 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42776 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbhJDQgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:36:11 -0400
Received: by mail-oi1-f173.google.com with SMTP id x124so22286928oix.9;
        Mon, 04 Oct 2021 09:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0dpw/V8bg0MxBudexnCNVse/yhrpLd1wrwigqMt/Mf4=;
        b=0uLehH8cQydmMA/XcmmSH4EZonhIIs6d5++YMPzkju1tQY/FEy4mQnGI98gjjHgRhY
         Ubg5zsBlws/1R8pTT4HHGf4+zmkCO+yckOGUEhhoQw/bGY3fgklG3NIRWzTRl+JIR4/9
         IvFUva5IisRWMa+7EmNVFLEMvE7OHztNm9xL5fQGWhcLaV+hbD+tFt3PCu87qdWbiz9n
         gJmXqujN/nNGkH9l5i8rujzmbvEgYtDt2q7G9DZk/64HjEQ3PJMGf9D587p1Pg1XWO1+
         MJb3xUPXwgL3447iQUaJiZDpxnZ6XGuRPrKJvpBCsN3dkFUiIUzTrwk0dxGHPcrCE7R0
         2+UQ==
X-Gm-Message-State: AOAM533OhW4ki4H/6CXubXwdfmyJV+S/tx4LouksFf4DX0PuL0BYZTwg
        n+mnbTWMHaE5ffCPYu632VNFD5G81A==
X-Google-Smtp-Source: ABdhPJyWs8jPtI7Az6impbOs6RYLWqtQA6g7t7PUwbGnr6ooHx6OyIrt5yr6QR8S2RGXjkrcVH6Pcw==
X-Received: by 2002:aca:30c9:: with SMTP id w192mr13601001oiw.93.1633364836818;
        Mon, 04 Oct 2021 09:27:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d21sm2868961ooh.43.2021.10.04.09.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:27:15 -0700 (PDT)
Received: (nullmailer pid 1418805 invoked by uid 1000);
        Mon, 04 Oct 2021 16:27:14 -0000
Date:   Mon, 4 Oct 2021 11:27:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] memory: fsl_ifc: populate child devices without
 relying on simple-bus
Message-ID: <YVsrYp3kZNmB1CIu@robh.at.kernel.org>
References: <20211001000924.15421-1-leoyang.li@nxp.com>
 <20211001000924.15421-3-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001000924.15421-3-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 07:09:21PM -0500, Li Yang wrote:
> After we update the binding to not use simple-bus compatible for the
> controller, we need the driver to populate the child devices explicitly.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/memory/fsl_ifc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> index d062c2f8250f..251d713cd50b 100644
> --- a/drivers/memory/fsl_ifc.c
> +++ b/drivers/memory/fsl_ifc.c
> @@ -88,6 +88,7 @@ static int fsl_ifc_ctrl_remove(struct platform_device *dev)
>  {
>  	struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(&dev->dev);
>  
> +	of_platform_depopulate(&dev->dev);
>  	free_irq(ctrl->nand_irq, ctrl);
>  	free_irq(ctrl->irq, ctrl);
>  
> @@ -285,6 +286,14 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
>  		}
>  	}
>  
> +	/* legacy dts may still use "simple-bus" compatible */
> +	if (!of_device_is_compatible(dev->dev.of_node, "simple-bus")) {
> +	        ret = of_platform_populate(dev->dev.of_node, NULL, NULL,
> +						&dev->dev);

There's no need to make this conditional. of_platform_populate() is safe 
to call multiple times. If that doesn't work, it's a bug.

Rob
